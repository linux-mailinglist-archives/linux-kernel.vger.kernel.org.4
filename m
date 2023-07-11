Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1074F819
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGKSm5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:42:56 -0400
Received: from 14.mo582.mail-out.ovh.net (14.mo582.mail-out.ovh.net [46.105.56.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13B31704
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:42:54 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.4.200])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 2D27723A93
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:06:34 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-42n7r (unknown [10.110.115.59])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id CBA2B1FE33;
        Tue, 11 Jul 2023 18:06:33 +0000 (UTC)
Received: from courmont.net ([37.59.142.102])
        by ghost-submission-6684bf9d7b-42n7r with ESMTPSA
        id 5e55LSmarWQWAwAApIyesg
        (envelope-from <remi@remlab.net>); Tue, 11 Jul 2023 18:06:33 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R004a521992a-6c1f-49e2-b636-6ed0849ec6b9,
                    BD5993DD31A8D185A8BDB9FDB50A3FED214DC06B) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/12] RISC-V: add helper function to read the vector VLEN
Date:   Tue, 11 Jul 2023 21:06:32 +0300
Message-ID: <5073588.8QdJVB83L8@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230711153743.1970625-4-heiko@sntech.de>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 11108691431442553307
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le tiistaina 11. heinäkuuta 2023, 18.37.34 EEST Heiko Stuebner a écrit :
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> VLEN describes the length of each vector register and some instructions
> need specific minimal VLENs to work correctly.
> 
> The vector code already includes a variable riscv_vsize that contains the
> value of "32 vector registers with vlenb length" that gets filled during
> boot. vlenb is the value contained in the CSR_VLENB register and
> the value represents "VLEN / 8".
> 
> So add riscv_vector_vlen() to return the actual VLEN value for in-kernel
> users when they need to check the available VLEN.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/vector.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/vector.h
> b/arch/riscv/include/asm/vector.h index ac2c23045eec..88cf76a2316d 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -232,4 +232,15 @@ static inline bool
> riscv_v_vstate_ctrl_user_allowed(void) { return false; }
> 
>  #endif /* CONFIG_RISCV_ISA_V */
> 
> +/*
> + * Return the implementation's vlen value.
> + *
> + * riscv_vsize contains the value of "32 vector registers with vlenb
> length" + * so rebuild the vlen value in bits from it.
> + */
> +static inline int riscv_vector_vlen(void)
> +{
> +	return riscv_v_vsize / 32 * 8;
> +}

KVM already has a bespoke conversion to bytes (rather than bits). Factor code?

> +
>  #endif /* ! __ASM_RISCV_VECTOR_H */


-- 
レミ・デニ-クールモン
http://www.remlab.net/



