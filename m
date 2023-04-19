Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3986E7B37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjDSNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjDSNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E88313C3B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681911878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8JKAFfWzA+HrvLNdRkbuEhcM/1yqc32dGHnjCBEcPk=;
        b=ZGxnOxY6YzrRdxoHJuGYtIweSWY+TNLav36evo1OuIuv8g2xFVwxtoezWrnL2cMONLwkKW
        9tybT5Up9tqCQkzgBhXlLkKjmul7bWcuQklDn3G1bobyyTVJHNLLkDUk5VkRHiBcm9li0f
        W1VC8ji8Wg4hUn3tyV0HAkFUTPPuIlQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-O6zNc8deM8Ox7-_uQy7PdQ-1; Wed, 19 Apr 2023 09:44:37 -0400
X-MC-Unique: O6zNc8deM8Ox7-_uQy7PdQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6a5f1bc4b26so1583906a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681911876; x=1684503876;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8JKAFfWzA+HrvLNdRkbuEhcM/1yqc32dGHnjCBEcPk=;
        b=FcWvU7WHWRNo1tzrPKKPeYsfG4D7yRa4tAEE9WfQrYZZwbSUOMQY9g0mSOFMy9fxgd
         S27seglOujlF1sNc+T49hIYsDsD5uuVQu18+hP/WBAQz20WOuNRYDEqj5osjLuib3oGs
         aQXfaxo9SeKGdjyequ+oG1RpYXbqJo2RXsHjz5W11OlEQHjrNffS4o7WEbBENh1WSDtG
         uRT9mHXo6Fxqpxj2qLoBWwyrTuCNHSrvv4b3uSFCVIzekY0Zp3JI1LWhwGGTEQGsJXlS
         WEQ9jPPSIOM14JV0go5pJS7/Hkx4ZmMVCo3zsfiSqrS0JgJwuWYCMibgW+1AcABJ7W4U
         3Edw==
X-Gm-Message-State: AAQBX9duEmUUQnTVqksg729gw+AkEsXVG2YBlBwcSfq6hAEZTtd2qKkf
        vyb4BnhZZ6+td1/cUjtkRaYgMwiKJJ1RsIthnVjeMoUowGRY6lIpwFdRyD44mhcIsMP8eT9wQuv
        qBYSVWdb2Jk5UYc0ZVJy1U2/Y
X-Received: by 2002:a05:6830:129a:b0:6a5:f503:aeab with SMTP id z26-20020a056830129a00b006a5f503aeabmr2947241otp.6.1681911876236;
        Wed, 19 Apr 2023 06:44:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZM1GVqQYv0BdCOoAH4vTMkZ0Fnnoaokpull2fJw9MugBZhRm7c2vOI1arU/DUOzItjTKyEQQ==
X-Received: by 2002:a05:6830:129a:b0:6a5:f503:aeab with SMTP id z26-20020a056830129a00b006a5f503aeabmr2947231otp.6.1681911875902;
        Wed, 19 Apr 2023 06:44:35 -0700 (PDT)
Received: from smtpclient.apple (cpe-24-28-76-31.austin.res.rr.com. [24.28.76.31])
        by smtp.gmail.com with ESMTPSA id z10-20020a9d7a4a000000b006a4244d2a7asm6611275otm.9.2023.04.19.06.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:44:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.4\))
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
From:   Andrew Theurer <atheurer@redhat.com>
In-Reply-To: <ZD/NbAU8gHILW/6w@tpad>
Date:   Wed, 19 Apr 2023 08:44:23 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98E08059-6607-43FF-84E3-BFF3FF193D09@redhat.com>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad> <ZD/NbAU8gHILW/6w@tpad>
To:     Marcelo Tosatti <mtosatti@redhat.com>
X-Mailer: Apple Mail (2.3731.600.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 19, 2023, at 6:15 AM, Marcelo Tosatti <mtosatti@redhat.com> =
wrote:
>=20
> On Wed, Apr 19, 2023 at 08:14:09AM -0300, Marcelo Tosatti wrote:
>> On Tue, Apr 18, 2023 at 03:02:00PM -0700, Andrew Morton wrote:
>>> On Mon, 20 Mar 2023 15:03:32 -0300 Marcelo Tosatti =
<mtosatti@redhat.com> wrote:
>>>=20
>>>> This patch series addresses the following two problems:
>>>>=20
>>>> 1. A customer provided evidence indicating that a process
>>>>   was stalled in direct reclaim:
>>>>=20
>>>> ...
>>>>=20
>>>> 2. With a task that busy loops on a given CPU,
>>>>    the kworker interruption to execute vmstat_update
>>>>    is undesired and may exceed latency thresholds
>>>>    for certain applications.
>>>>=20
>>>=20
>>> I don't think I'll be sending this upstream in the next merge =
window.=20
>>> Because it isn't clear that the added complexity in vmstat handling =
is
>>> justified.
>>=20
>> =46rom my POV this is an incorrect statement (that the complexity in
>> vmstat handling is not justified).
>>=20
>> Andrew, this is the 3rd attempt to fix this problem:
>>=20
>> First try:  =
https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/
>>=20
>> Second try: =
https://patchew.org/linux/20230105125218.031928326@redhat.com/
>>=20
>> Third try: syncing vmstats remotely from vmstat_shepherd (this
>> patchset).
>>=20
>> And also, can you please explain: what is so complicated about the
>> vmstat handling? cmpxchg has been around and is used all over the
>> kernel, and nobody considers "excessively complicated".
>>=20
>>> - Michal's request for more clarity on the end-user requirements
>>>  seems reasonable.
>>=20
>> And i explained to Michal in great detail where the end-user=20
>> requirements come from. For virtualized workloads, there are two
>> types of use-cases:
>>=20
>> 1) For example, for the MAC scheduler processing must occur every =
1ms,
>> and a certain amount of computation takes place (and must finish =
before
>> the next 1ms timeframe). A > 50us latency spike as observed by =
cyclictest
>> is considered a "failure".
>>=20
>> I showed him a 7us trace caused by, and explained that will extend to =
>
>> 50us in the case of virtualized vCPU.
>>=20
>> 2) PLCs. These workloads will also suffer > 50us latency spikes
>> which is undesirable.
>>=20
>> Can you please explain what additional clarity is required?
>>=20
>> RH's performance team, for example, has been performing packet
>> latency tests and waiting for this issue to be fixed for about 2
>> years now.
>>=20
>> Andrew Theurer, can you please explain what problem is the =
vmstat_work
>> interruption causing in your testing?
>=20
> +CC Andrew.

Nearly every telco we work with for 5G RAN is demanding <20 usec CPU =
latency as measured by cyclictest & oslat.  We cannot achieve under 20 =
usec with the vmstats interruption.

-Andrew=

