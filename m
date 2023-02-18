Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B3569BA80
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBROyS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Feb 2023 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBROyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:54:17 -0500
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA015CA7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:54:15 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id A0BF6C01DD;
        Sat, 18 Feb 2023 14:54:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 76A146000A;
        Sat, 18 Feb 2023 14:54:12 +0000 (UTC)
Message-ID: <45807c0e9fc818dd433746fbb55988c73b016477.camel@perches.com>
Subject: Re: [PATCH v2 09/10] powerpc: Use ppc_md_progress()
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat, 18 Feb 2023 06:54:11 -0800
In-Reply-To: <c4416002503fa19e930bc78177bb85641367c40f.1676711562.git.christophe.leroy@csgroup.eu>
References: <6cb9865d916231c38401ba34ad1a98c249fae135.1676711562.git.christophe.leroy@csgroup.eu>
         <c4416002503fa19e930bc78177bb85641367c40f.1676711562.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 76A146000A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: ko8ekdn8kgjoy13z5nmwfcoyx7qqiza7
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19KzBUQ62SvQ99BfK/AxzAcNZNwaOmCbag=
X-HE-Tag: 1676732052-331222
X-HE-Meta: U2FsdGVkX1/DZbqqps+9kd6q64cfiK8UA5TaayzVMfWlIQ4jprjRTx98Jt36YWCNM9F6tpM7eyvK3vrd0PmYCg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-18 at 10:15 +0100, Christophe Leroy wrote:
> Many places have:
> 
> 	if (ppc.md_progress)
> 		ppc.md_progress();
> 
> Use ppc_md_progress() instead.
> 
> Note that checkpatch complains about using function names,
> but this is not a function taking format strings, so we
> leave the function names for now.

If you are changing almost all of these uses, why not
drop the unused 2nd argument 'hex' at the same time?

void ppc_printk_progress(char *s, unsigned short hex)
{
	pr_info("%s\n", s);
}

> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
[]
> @@ -127,8 +127,7 @@ __setup("l3cr=", ppc_setup_l3cr);
>  static int __init ppc_init(void)
>  {
>  	/* clear the progress line */
> -	if (ppc_md.progress)
> -		ppc_md.progress("             ", 0xffff);
> +	ppc_md_progress("             ", 0xffff);

	ppc_md_progress("             ");

Although this example seems especially useless.

> diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
[]
> @@ -347,7 +347,7 @@ void __init MMU_init_hw(void)
>  	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
>  		return;
>  
> -	if ( ppc_md.progress ) ppc_md.progress("hash:enter", 0x105);
> +	ppc_md_progress("hash:enter", 0x105);

	ppc_md_progress("hash:enter");

[]

> diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
[]
> @@ -189,8 +189,7 @@ static void __init efika_setup_arch(void)
>  	mpc52xx_pm_init();
>  #endif
>  
> -	if (ppc_md.progress)
> -		ppc_md.progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);
> +	ppc_md_progress("Linux/PPC " UTS_RELEASE " running on Efika ;-)\n", 0x0);

And perhaps remove the extra newlines here and other places as
it doesn't seem useful to have unnecessary blank lines in the log.

