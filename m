Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65A6AD730
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCGGNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjCGGNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:13:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27F301B1;
        Mon,  6 Mar 2023 22:13:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0981961215;
        Tue,  7 Mar 2023 06:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF63C433D2;
        Tue,  7 Mar 2023 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678169610;
        bh=xf0x6cqpQmmfZLNlygDl/x3UlC8DENzrRv3kNRhpTTc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=bgFYdTVrcrjW7ir3dhuVSDPLPmyjfBGF1o1lFWTz4SeyRWK7ZU3emLUBvv8kFE+kD
         WhvYY0xXn/KizUTQJJ/i5PQ9ZW11Pa2P6W4U69CtAIZtFgMSO70hJa078RAj9o6tQr
         KM9FDEJHmIys5arjV6eHobRMaNiKaf75TrW3vmMki47wrM/om+6WXFsl6FbIU3wfRP
         MVJ7yEDPLT5mz+j5krb2R47f4B/Ovu+3oJfcd+E1wb69yh7WNKNVZRQkEkYbgCvpmr
         IIeLptbdOSKsFGzsaxUIpUmdLaTwXTljxw98zGvqe8SbG1NejE6ETv5HfMxROaMW9T
         H0H30Rs+hEuZQ==
Date:   Tue, 07 Mar 2023 06:13:22 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
CC:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
User-Agent: K-9 Mail for Android
In-Reply-To: <ZAbGSA6F0kfv9YYw@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com> <16007014-c5f2-4b07-baec-e19952236aa5@spud> <ZAbGSA6F0kfv9YYw@sunil-laptop>
Message-ID: <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org>
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



On 7 March 2023 05:06:16 GMT, Sunil V L <sunilvl@ventanamicro=2Ecom> wrote=
:
>On Mon, Mar 06, 2023 at 09:51:09PM +0000, Conor Dooley wrote:
>> Hey Sunil,
>>=20
>> On Fri, Mar 03, 2023 at 07:06:27PM +0530, Sunil V L wrote:
>> > This patch series enables the basic ACPI infrastructure for RISC-V=2E
>> > Supporting external interrupt controllers is in progress and hence it=
 is
>> > tested using poll based HVC SBI console and RAM disk=2E
>> >=20
>> > The first patch in this series is one of the patch from Jisheng's
>> > series [1] which is not merged yet=2E This patch is required to suppo=
rt
>> > ACPI since efi_init() which gets called before sbi_init() can enable
>> > static branches and hits a panic=2E
>> >=20
>> > Patch 2 and 3 are ACPICA patches which are not merged into acpica yet
>> > but a PR is raised already=2E
>> >=20
>> > Below are two ECRs approved by ASWG=2E
>> > RINTC - https://drive=2Egoogle=2Ecom/file/d/1R6k4MshhN3WTT-hwqAquu5nX=
6xSEqK2l/view
>> > RHCT - https://drive=2Egoogle=2Ecom/file/d/1nP3nFiH4jkPMp6COOxP6123DC=
ZKR-tia/view
>> >=20
>> > The series depends on Anup's IPI improvement series [2]=2E
>> >=20
>> > [1] https://lore=2Ekernel=2Eorg/all/20220821140918=2E3613-1-jszhang@k=
ernel=2Eorg/
>> > [2] https://lore=2Ekernel=2Eorg/lkml/20230103141221=2E772261-7-apatel=
@ventanamicro=2Ecom/T/
>>=20
>> Building a clang-15 allmodconfig (I didn't try gcc) with this series, a=
nd
>> Anup's IPI bits, results in a broken build, due to failings in cmpxchg:
>>=20
>> /stuff/linux/drivers/platform/surface/aggregator/controller=2Ec:61:25: =
error: call to __compiletime_assert_335 declared with 'error' attribute: BU=
ILD_BUG failed
>>         while (unlikely((ret =3D cmpxchg(&c->value, old, new)) !=3D old=
)) {
>>                                ^
>Hi Conor,
>
>I am able to build without any of these issues using clang-15=2E I am
>wondering whether the base is proper=2E I had rebased on top of the maste=
r
>and couple of patches from IPI series were already merged in the master=
=2E
>
>Do you mind verifying with my branch
>https://github=2Ecom/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V3?

I can check that later I suppose=2E

>
>Or if you could provide me your branch details, I can look further=2E

6=2E3-rc1, with both series applied, sans Anups applied patches=2E
