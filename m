Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141AB688050
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjBBOpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:45:31 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9E8626E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:45:30 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id t24-20020a4a8258000000b005170b789faaso195240oog.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 06:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGufOIJ0TiCnGVFcLZ+Cxm7XNsb1pLcp45dbpeI8y5g=;
        b=W6HeCVMQ6ftSO2rX+RY8QMgrI6vlKcGmEi6BNxrIBs0WgKeUq9OcVTp1etZJkuk7n3
         eT7/kSP0eQ81JETUpJRl5p1cXrFEmnSQCwfBzTn2arkrAsssNSQyJdRVR3IgRZowx2Gu
         Sm0cStZLDRFZbCDEcGs1bC6jE49rR0lvBrSTHHK/I9nGUK12BqLZkn1+SFkzBQu6ri2E
         b91E3sF1a9aJpGPLuAvXHMAbjNPw+YFI3Da6ULlG+/0kyJeTvHTlSId9blb8LtyL0D0D
         acUbJ2Py2o5raDWCif9amuCJnN3l7ysVLscV3U/TPlZvvkkAwTsIZcTlglPH0T54+i5d
         ljPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGufOIJ0TiCnGVFcLZ+Cxm7XNsb1pLcp45dbpeI8y5g=;
        b=lm17vi8bGkYJPaO7ZkirEyWOcBGggCUJn7RKBciIEdga6cP4/qUyJIizAbryAdukbw
         Nis8y0Q/MmNW0fJ/BBippiNq4wyFW8N6+HVxMulbpjAKXc+/Q9tylBVpqYVZpPOxjOOE
         y7/eMArEPbG368R1Fz3CFcpdtTcuDC+U5/20xuNHphKW/j+6IFs3KfONQnN6mbXNhDwN
         io3hXntKOMdWzbEHwV2osm1QE15KrcPvvaq+6SvqVbQaFpU9yR2VfO10hQcPG/5ZtHiS
         znqETA+Sza/TThV/p9m6FHwTpwp2Qn5kp1GwdnD7iPxAILd5+hh4NSapz+W1OgoU17yq
         RDqQ==
X-Gm-Message-State: AO0yUKV1BrANVTqKryzNvkZ6TRhNkAyOYHYqNYm9gBoqV8+irvU2+XyR
        61ceDL5eeRv47cqSTLf7Af0=
X-Google-Smtp-Source: AK7set8xdRBKC/rgen1Gt+ngaNQ2mxHcQ6U/gzQqpMUyq+2HoA8P01vlGp51GATHsO0GeCcsH+6iyA==
X-Received: by 2002:a4a:1744:0:b0:51a:cab:cbef with SMTP id 65-20020a4a1744000000b0051a0cabcbefmr2657590ooe.4.1675349129733;
        Thu, 02 Feb 2023 06:45:29 -0800 (PST)
Received: from ?IPv6:::1? ([2804:14d:128a:85a9:38a9:1bdb:a338:39fa])
        by smtp.gmail.com with ESMTPSA id z7-20020a4ab607000000b004a8eb1d8f1bsm8497497oon.39.2023.02.02.06.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 06:45:29 -0800 (PST)
Date:   Thu, 02 Feb 2023 11:45:24 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V2 7/9] perf/x86/msr: Add Meteor Lake support
User-Agent: K-9 Mail for Android
In-Reply-To: <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com> <20230104201349.1451191-7-kan.liang@linux.intel.com> <Y9sWImm4v5I/MZId@kernel.org> <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
Message-ID: <1828CB97-35C8-4420-92F2-4795A89FA793@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 2, 2023 11:34:02 AM GMT-03:00, "Liang, Kan" <kan=2Eliang@linux=
=2Eintel=2Ecom> wrote:
>Hi Arnaldo,
>
>On 2023-02-01 8:47 p=2Em=2E, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Jan 04, 2023 at 12:13:47PM -0800, kan=2Eliang@linux=2Eintel=2Ec=
om escreveu:
>>> From: Kan Liang <kan=2Eliang@linux=2Eintel=2Ecom>
>>>
>>> Meteor Lake is Intel's successor to Raptor lake=2E PPERF and SMI_COUNT=
 MSRs
>>> are also supported=2E
>>>
>>> Reviewed-by: Andi Kleen <ak@linux=2Eintel=2Ecom>
>>> Signed-off-by: Kan Liang <kan=2Eliang@linux=2Eintel=2Ecom>
>>> ---
>>=20
>> Did the kernel bits land upstream?
>Yes, the kernel part has been merged into the tip=2Egit perf/core branch=
=2E
>
>Thanks for checking the status=2E There are two perf tool patches in this
>series, which hasn't been merged=2E Should I resend them?

Please, try rebasing it on the tmp=2Eperf/core in my tree=2E

- Arnaldo

>
>
>> =20
>>> No change since V1
>>>
>>>  arch/x86/events/msr=2Ec | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/x86/events/msr=2Ec b/arch/x86/events/msr=2Ec
>>> index ecced3a52668=2E=2E074150d28fa8 100644
>>> --- a/arch/x86/events/msr=2Ec
>>> +++ b/arch/x86/events/msr=2Ec
>>> @@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
>>>  	case INTEL_FAM6_RAPTORLAKE:
>>>  	case INTEL_FAM6_RAPTORLAKE_P:
>>>  	case INTEL_FAM6_RAPTORLAKE_S:
>>> +	case INTEL_FAM6_METEORLAKE:
>>> +	case INTEL_FAM6_METEORLAKE_L:
>>>  		if (idx =3D=3D PERF_MSR_SMI || idx =3D=3D PERF_MSR_PPERF)
>>>  			return true;
>>>  		break;
>>> --=20
>>> 2=2E35=2E1
>>=20
