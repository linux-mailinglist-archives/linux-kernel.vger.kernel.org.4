Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8B74F826
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGKSwH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:52:06 -0400
X-Greylist: delayed 4691 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 11:52:04 PDT
Received: from 9.mo584.mail-out.ovh.net (9.mo584.mail-out.ovh.net [46.105.40.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C5BC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:52:04 -0700 (PDT)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.156.38])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id D2D652703D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:33:51 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-l5klt (unknown [10.110.171.34])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 602A01FD37;
        Tue, 11 Jul 2023 17:33:51 +0000 (UTC)
Received: from courmont.net ([37.59.142.107])
        by ghost-submission-6684bf9d7b-l5klt with ESMTPSA
        id WdOxEn+SrWTPKC4Auh2lqg
        (envelope-from <remi@remlab.net>); Tue, 11 Jul 2023 17:33:51 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S001ecf9f6e3-4f29-4dc6-a688-e1e232be3982,
                    BD5993DD31A8D185A8BDB9FDB50A3FED214DC06B) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/12] riscv: Add vector extension XOR implementation
Date:   Tue, 11 Jul 2023 20:33:50 +0300
Message-ID: <2289969.yH7iMFiWxO@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230711153743.1970625-3-heiko@sntech.de>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 10556156052126767579
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkohgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeftrohmihcuffgvnhhishdqvehouhhrmhhonhhtuceorhgvmhhisehrvghmlhgrsgdrnhgvtheqnecuggftrfgrthhtvghrnheptdetleevudfgtdevleeuhfffgeehvdevieetvdektdegtdekvedvhfegkeehhfdunecuffhomhgrihhnpeigohhrrdhssgdprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekgedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le tiistaina 11. heinäkuuta 2023, 18.37.33 EEST Heiko Stuebner a écrit :
> diff --git a/arch/riscv/lib/xor.S b/arch/riscv/lib/xor.S
> new file mode 100644
> index 000000000000..3bc059e18171
> --- /dev/null
> +++ b/arch/riscv/lib/xor.S
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2021 SiFive
> + */
> +#include <linux/linkage.h>
> +#include <asm-generic/export.h>
> +#include <asm/asm.h>
> +
> +ENTRY(xor_regs_2_)
> +	vsetvli a3, a0, e8, m8, ta, ma

AFAICT, so far, Linux only uses `vsetvli` to save/restore/flush vectors, and 
that's, of course, with LMUL=8, so that's not really telling much anything. 
This function could be the first actual vector optimisation in kernel if/when 
it gets merged.

Should the same group multiplier be used for "actual" vector loops throughout 
the kernel? I've seen conflicting advises or opinions here. Should kernel code 
always use the maximum possible LMUL, depending on register pressure of the 
loop? Or will that just increase latency with no bandwidth gains compared to, 
say, LMUL=1 or LMUL=2?

> +	vle8.v v0, (a1)
> +	vle8.v v8, (a2)
> +	sub a0, a0, a3
> +	vxor.vv v16, v0, v8
> +	add a2, a2, a3
> +	vse8.v v16, (a1)
> +	add a1, a1, a3
> +	bnez a0, xor_regs_2_
> +	ret
> +END(xor_regs_2_)
> +EXPORT_SYMBOL(xor_regs_2_)
> +
> +ENTRY(xor_regs_3_)
> +	vsetvli a4, a0, e8, m8, ta, ma
> +	vle8.v v0, (a1)
> +	vle8.v v8, (a2)
> +	sub a0, a0, a4
> +	vxor.vv v0, v0, v8
> +	vle8.v v16, (a3)
> +	add a2, a2, a4
> +	vxor.vv v16, v0, v16
> +	add a3, a3, a4
> +	vse8.v v16, (a1)
> +	add a1, a1, a4
> +	bnez a0, xor_regs_3_
> +	ret
> +END(xor_regs_3_)
> +EXPORT_SYMBOL(xor_regs_3_)
> +
> +ENTRY(xor_regs_4_)
> +	vsetvli a5, a0, e8, m8, ta, ma
> +	vle8.v v0, (a1)
> +	vle8.v v8, (a2)
> +	sub a0, a0, a5
> +	vxor.vv v0, v0, v8
> +	vle8.v v16, (a3)
> +	add a2, a2, a5
> +	vxor.vv v0, v0, v16
> +	vle8.v v24, (a4)
> +	add a3, a3, a5
> +	vxor.vv v16, v0, v24
> +	add a4, a4, a5
> +	vse8.v v16, (a1)
> +	add a1, a1, a5
> +	bnez a0, xor_regs_4_
> +	ret
> +END(xor_regs_4_)
> +EXPORT_SYMBOL(xor_regs_4_)
> +
> +ENTRY(xor_regs_5_)
> +	vsetvli a6, a0, e8, m8, ta, ma
> +	vle8.v v0, (a1)
> +	vle8.v v8, (a2)
> +	sub a0, a0, a6
> +	vxor.vv v0, v0, v8
> +	vle8.v v16, (a3)
> +	add a2, a2, a6
> +	vxor.vv v0, v0, v16
> +	vle8.v v24, (a4)
> +	add a3, a3, a6
> +	vxor.vv v0, v0, v24
> +	vle8.v v8, (a5)
> +	add a4, a4, a6
> +	vxor.vv v16, v0, v8
> +	add a5, a5, a6
> +	vse8.v v16, (a1)
> +	add a1, a1, a6
> +	bnez a0, xor_regs_5_
> +	ret
> +END(xor_regs_5_)
> +EXPORT_SYMBOL(xor_regs_5_)


-- 
レミ・デニ-クールモン
http://www.remlab.net/



