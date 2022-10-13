Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73C25FD444
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJMFhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMFho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:37:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5302C10CF82
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:37:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E190A616E3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1CEC433C1;
        Thu, 13 Oct 2022 05:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665639463;
        bh=8aVZC45tzS5Xypj4wP6sxsCkOsmuarZG9AGJpu3SPco=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=F/D4d5YEo4S11Gj+F+xVctT+5me3AkVUXb2whtUfIS8fJ2mFuvUr8PySwMHqJDeAZ
         b2NkTQDtu5CaRGkklBGxSm8sI7e0sfzKQs9O+ynrHay1wfBk3l89nFUEsU66zrPrFg
         18ShVKVDCefbYGjeJYkNcpW4kNI2s4E8l2acQZ1t5DZGJBcjMK8ZdfNnaQhjsqmGye
         An86ifLgD2CmtT+nU0bZV7B1MAhbFI87RXTyhsZDhv5+LYXvn3vc+f90B8uxlGYaDi
         hGgxNoDjGA+p6gZQV4JMvoE0xUHL8zhimDiaqzRXHXzsslA+O0BwlTr/ZXlRqeYZIk
         CBwcIQMlg90Ng==
Date:   Thu, 13 Oct 2022 06:37:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/8=5D_riscv=3A_move_riscv=5Fnonc?= =?US-ASCII?Q?oherent=5Fsupported=28=29_out_of_ZICBOM_probe?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y0GCST9IQcKws9Yh@xhacker>
References: <20221006070818.3616-1-jszhang@kernel.org> <20221006070818.3616-2-jszhang@kernel.org> <Y0F1uH71Ll7YGygB@spud> <Y0GCST9IQcKws9Yh@xhacker>
Message-ID: <BBEFA528-0F84-41CB-A62F-ED4673947928@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 October 2022 14:59:37 IST, Jisheng Zhang <jszhang@kernel=2Eorg> wrote=
:
>On Sat, Oct 08, 2022 at 02:06:00PM +0100, Conor Dooley wrote:
>> On Thu, Oct 06, 2022 at 03:08:11PM +0800, Jisheng Zhang wrote:
>> > It's a bit wired to call riscv_noncoherent_supported() once when
>> > insmod a module=2E Move the calling out of feature patch func=2E
>> >=20
>> > Signed-off-by: Jisheng Zhang <jszhang@kernel=2Eorg>
>> > ---
>> >  arch/riscv/kernel/cpufeature=2Ec | 7 +------
>> >  arch/riscv/kernel/setup=2Ec      | 4 ++++
>> >  2 files changed, 5 insertions(+), 6 deletions(-)
>> >=20
>> > diff --git a/arch/riscv/kernel/cpufeature=2Ec b/arch/riscv/kernel/cpu=
feature=2Ec
>> > index 3b5583db9d80=2E=2E03611b3ef45e 100644
>> > --- a/arch/riscv/kernel/cpufeature=2Ec
>> > +++ b/arch/riscv/kernel/cpufeature=2Ec
>> > @@ -272,12 +272,7 @@ static bool __init_or_module cpufeature_probe_zi=
cbom(unsigned int stage)
>> >  	case RISCV_ALTERNATIVES_EARLY_BOOT:
>> >  		return false;
>> >  	default:
>> > -		if (riscv_isa_extension_available(NULL, ZICBOM)) {
>> > -			riscv_noncoherent_supported();
>> > -			return true;
>> > -		} else {
>> > -			return false;
>> > -		}
>> > +		return riscv_isa_extension_available(NULL, ZICBOM);
>> >  	}
>> >  #endif
>> > =20
>> > diff --git a/arch/riscv/kernel/setup=2Ec b/arch/riscv/kernel/setup=2E=
c
>> > index 2dfc463b86bb=2E=2E1a055c3f5d9d 100644
>> > --- a/arch/riscv/kernel/setup=2Ec
>> > +++ b/arch/riscv/kernel/setup=2Ec
>> > @@ -299,6 +299,10 @@ void __init setup_arch(char **cmdline_p)
>> >  	riscv_init_cbom_blocksize();
>> >  	riscv_fill_hwcap();
>> >  	apply_boot_alternatives();
>> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
>> > +	if (riscv_isa_extension_available(NULL, ZICBOM))
>> > +		riscv_noncoherent_supported();
>> > +#endif
>>=20
>> I have a personal bias against ifdefs where possible, maybe @Heiko
>> remembers why riscv_noncoherent_supported() was not defined as somethin=
g
>> like `void riscv_noncoherent_support(void){}` for when that CONFIG is
>> not enabled? If it was this could become a an IS_ENABLED & we wouldn't
>> have to be so careful about wrapping it's usage in ifdefs=2E
>
>Good idea=2E Will do in newer version=2E

Given this comment and the LKP report I've marked the series as changes re=
quested in patchwork FYI=2E

Thanks,
Conor=2E

>
>>=20
>> Your change in isolation makes sense to me though, so:
>> Reviewed-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>>=20
>> Thanks,
>> Conor=2E
>>=20
>> >  }
>> > =20
>> >  static int __init topology_init(void)
>> > --=20
>> > 2=2E37=2E2
>> >=20
