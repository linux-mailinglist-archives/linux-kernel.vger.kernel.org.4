Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31BD5FDAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJMN3K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Oct 2022 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJMN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:29:07 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275E2F669
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:29:05 -0700 (PDT)
Received: from p508fd99e.dip0.t-ipconnect.de ([80.143.217.158] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oiyGf-0007JB-RH; Thu, 13 Oct 2022 15:28:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 4/8] riscv: cpufeature: extend riscv_cpufeature_patch_func to all ISA extensions
Date:   Thu, 13 Oct 2022 15:28:57 +0200
Message-ID: <1991071.yIU609i1g2@phil>
In-Reply-To: <3185764.oiGErgHkdL@diego>
References: <20221006070818.3616-1-jszhang@kernel.org> <20221006070818.3616-5-jszhang@kernel.org> <3185764.oiGErgHkdL@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 7. Oktober 2022, 13:54:31 CEST schrieb Heiko Stübner:
> Am Donnerstag, 6. Oktober 2022, 09:08:14 CEST schrieb Jisheng Zhang:
> > make the riscv_cpufeature_patch_func() scan all ISA extensions rather
> > than limited feature macros.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

[...]

> > @@ -127,7 +124,7 @@ asm volatile(ALTERNATIVE_2(						\
> >  	"add a0, a0, %0\n\t"						\
> >  	"2:\n\t"							\
> >  	"bltu a0, %2, 3b\n\t"						\
> > -	"nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,		\
> > +	"nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\
> 
> hmm, would it make sense to also at the same time extend the errata_id
> in the alternatives struct to unsigned long?
> 
> Right now it's a unsigned int, and we're already at bit30 with the current extensions.
> 
> Otherwise the idea is pretty neat of allowing easy handling for all extensions
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I think I might need to take that back ... with this change each
cpufeature is tightly coupled to real extension ids, but what about
cpufeatures that do not match directly to an extension?

I.e. ZICBOM + fast-unaligned-access [0] (coming from a dt-property)
or only viable with extension 1+2+3?


Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=riscv-hwprobe&id=9be297f7ed349945cccc85f8df9d90e5ab68c1d9


