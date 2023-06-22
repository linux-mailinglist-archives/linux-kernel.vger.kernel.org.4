Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B273A98E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjFVUgI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFVUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:36:06 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC07BDC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:36:01 -0700 (PDT)
Received: from i53875bdf.versanet.de ([83.135.91.223] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qCR1z-00020C-4S; Thu, 22 Jun 2023 22:35:51 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Stefan O'Rear <sorear@fastmail.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
Date:   Thu, 22 Jun 2023 22:35:50 +0200
Message-ID: <9132027.CDJkKcVGEf@diego>
In-Reply-To: <23381fc8-c297-46ed-9e11-a2643e18e4c9@app.fastmail.com>
References: <20230228215435.3366914-1-heiko@sntech.de> <1941316.PYKUYFuaPT@diego>
 <23381fc8-c297-46ed-9e11-a2643e18e4c9@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Am Donnerstag, 22. Juni 2023, 20:58:37 CEST schrieb Stefan O'Rear:
> On Thu, Jun 22, 2023, at 1:39 PM, Heiko Stübner wrote:
> > Am Dienstag, 13. Juni 2023, 08:35:53 CEST schrieb Stefan O'Rear:
> >> vxrm and vxsat are part of fcsr in 0.7.1, so they should already have been
> >> handled by __fstate_save and __fstate_restore, and this code is likely to
> >> misbehave (saving the new process's vxrm/vxsat in the old process's save area
> >> because float state is swapped before vector state in __switch_to).
> >
> > I'm not sure I follow your description but may be overlooking or have
> > misunderstood something.
> >
> > Somehow I way to often have trouble resolving CSR addresses, but according
> > to openSBI, FCSR has the location of 0x3
> > (#define CSR_FCSR 0x003 in include/sbi/riscv_encoding.h)
> >
> > where CSR_VXSAT and CSR_VXRM are at 0x9 and 0xa respectively.
> > (#define CSR_VXSAT 0x9 and  #define CSR_VXRM 0xa)
> >
> >
> > And looking at __fstate_save + __fstate_restore the only CSRs accessed seem
> > to be CSR_STATUS and FCSR itself.
> >
> > I definitly won't claim to be right, but don't see the issue yet.
> >
> >
> > Thanks for a hint
> > Heiko
> 
> Are you aware of "3.7. Vector Fixed-Point Fields in fcsr" in
> riscv-v-spec-0.7.1.pdf?

oh wow, thanks a lot for that pointer, now I understand your concern.

So in vector-0.7.1 fcsr[10:9] mirrors vxrm and fcsr[8] mirrors vxsat.


On a positive note, the T-Head cores seem to not implement the full
vector 0.7.1 specification after all, in the documentation I have [0]
fcsr[31:8] are declared as "0" and uppermost bits are [7:5] for the "frm"
field.

So I guess a code comment should suffice to explain :-)


Regards
Heiko


[0] https://github.com/T-head-Semi/openc906/blob/main/doc/%E7%8E%84%E9%93%81C906%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.pdf
16.3.1.3 浮点控制状态寄存器（FCSR） on page 334


