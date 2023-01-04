Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDAB65CED1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjADIxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjADIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA51AA03
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6A48B815B8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C50C433EF;
        Wed,  4 Jan 2023 08:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822384;
        bh=c+W/ETy2yHoE82hOmg9G4o49+KrhbGh7VQyzmOuvRYM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QGm9BblgEHoUQmt0vLv+vmpdz1Hip7XG2GPXYNH/ozjESyrRkzZeehUPgEDnfF8wx
         VcmZuplhQma31DKo16UTFvnXdSuB+vOE2mOdmys5I6lDOVoRgAJGlufIyeGENYSF7J
         SGr7bnhwMFbdCN7NTf0FqEomCH2DTnBIhG7++KbWhLjcQZqqZjp2EYoVWKhF/KxRD/
         25NZbEZIXp/9tp39011WFZvoAIJMZgWZwNk2y4Z9zYPSW0zakLYT5ZrdNId20YyOmI
         gMPXJgqxXRCloyM8FZrngD68+sLhXwKPEqmHWPfKJoJyA7sSjG3v/UVR7/lKvophSs
         40rnYPJoSFVug==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Add OPTPROBES feature on RISCV
In-Reply-To: <f2e121f3-2bb7-5389-79e3-91edbebe60b8@huawei.com>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <87y1qkvmpf.fsf@all.your.base.are.belong.to.us>
 <f2e121f3-2bb7-5389-79e3-91edbebe60b8@huawei.com>
Date:   Wed, 04 Jan 2023 09:53:01 +0100
Message-ID: <878riismtu.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"liaochang (A)" <liaochang1@huawei.com> writes:

> Hi=EF=BC=8CBj=C3=B6rn=EF=BC=8Cappreciate for your review and testing abou=
t this feature.

Thank you for the hard work!

> =E5=9C=A8 2023/1/3 2:02, Bj=C3=B6rn T=C3=B6pel =E5=86=99=E9=81=93:
>> Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:
>>=20
>>> Add jump optimization support for RISC-V.
>>=20
>> Thank you for continuing to work on the series! I took the series for a
>> spin, and ran into a number of issues that makes me wonder how you test
>> the series, and how the testing is different from my runs.
>
> I have pick some kernel functions to test this series, which means all op=
tprobe
> are install at entry of function, i guess the instruction pattern is not =
versatile
> enough for my testcases leads to some bugs are not discovered.
>
> Do you think it is good idea to test this feature via binary ftracetest a=
nd the
> kprobe related tc scripts in tools/testing/ftrace directory?

Definitely! Both running all tests in tools/testing/selftests/ftrace and
with the CONFIG_KPROBES_SANITY_TEST module.

[...]

>> 4. Lockdep splat

[...]

> Need to study this backtrace further, but at first glance, i guess CONFIG=
_DYNAMIC_FTRACE is enabled on your kernel, right?
> If so, all krpobe is installed via ftrace stub, then kprobe optimiztion o=
ccur in the ftrace trampoline code, and it also
> a corner case to current optprobe implementation.

Yes, CONFIG_DYNAMIC_FTRACE is on. My kernel config was simply:
  make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- defconfig
  make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- kselftest-merge


Thanks,
Bj=C3=B6rn
