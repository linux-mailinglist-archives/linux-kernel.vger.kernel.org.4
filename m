Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB526ADD03
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCGLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCGLLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68494E051
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678187340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDXpVQCtQOIlmzO6ioTe8cdUScPgYtXM44balfNsDNo=;
        b=Gz/PY5GU7kSX1Xf3AVOWEcqm60XUIG3vEDwsBa7b1Jt8yjZ0oXI1ls7Go++itobvECeWar
        7Fb8AaSj8/JVs4/PC4ak91w4pPTEjgcLbvcg+Q3U5hqf9JzzL+mLwDWZcRgYSY65s8pXhn
        E6UuQ35Z0ufEnBqIhn1sb+TCeD03L40=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-KQv483jQM-aok-OWnZD_OA-1; Tue, 07 Mar 2023 06:02:15 -0500
X-MC-Unique: KQv483jQM-aok-OWnZD_OA-1
Received: by mail-ed1-f71.google.com with SMTP id p36-20020a056402502400b004bb926a3d54so18267640eda.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 03:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678186934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDXpVQCtQOIlmzO6ioTe8cdUScPgYtXM44balfNsDNo=;
        b=SeSzRyU/bb6MZdgCWDIuk6s8wgtnXVyXLTGFI+OUTBc0ReseLL+K4R8n4Rg/hHxO97
         ct2S8Djsp+n15wBUjxqYDQpfgtyhVPU9BgMYw+IE7vgQoSUH/LX77iygnT2k/U4U7vMn
         FEftHudq9gze1N7ce3KyQBr9cdi67VhjVXCqHKo7xbRN9dNAdtHZpTo+JeAEAu7CLcnD
         ZPmiHOjYHQLhNuOCgJeDyuUS9pk1YZjt8jSP/WZitp17/bJff26hKrcenB1AH+mXQrO3
         SOLaEtiO9b+8LGfgM8RKRsCxnpIAQiAW4jFrATOPPFBFxaCei7nqn1aIvAg3hs53QuhH
         sd9Q==
X-Gm-Message-State: AO0yUKWl3eoFJntn/u1F0L9d+ssJk9RnqoX4gmwq5/4Ja7uJeg2c9OKW
        jymyCMaNbU3FG3eQyWy2nlhpCmIwGszjRWtxRpqfSLzNhh2F8aB31ZI3bfuWHJqPJeOo37dt7kS
        gyJV+njfrDnZO5KzqgQ0FGlEB
X-Received: by 2002:a17:907:3e91:b0:8b2:b711:5e62 with SMTP id hs17-20020a1709073e9100b008b2b7115e62mr16191510ejc.52.1678186934713;
        Tue, 07 Mar 2023 03:02:14 -0800 (PST)
X-Google-Smtp-Source: AK7set9nJRFyyMSUSPpxbJwDWUspJLFE9XgiKxOVJCQqMy9LeMgxwcewIoOUdbCS7ZKCPD2GqektIg==
X-Received: by 2002:a17:907:3e91:b0:8b2:b711:5e62 with SMTP id hs17-20020a1709073e9100b008b2b7115e62mr16191477ejc.52.1678186934456;
        Tue, 07 Mar 2023 03:02:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o13-20020a1709062e8d00b008e22978b98bsm5956978eji.61.2023.03.07.03.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:02:13 -0800 (PST)
Message-ID: <d3761f4a-6945-9a7e-03e9-bf0279c6f0f2@redhat.com>
Date:   Tue, 7 Mar 2023 12:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/8] Add Array BIST test support to IFS
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230301015942.462799-1-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jithu,

On 3/1/23 02:59, Jithu Joseph wrote:
> Changes in v3
>  - GregKH 
>     -  Separating read-only fields from rw fields in
>        struct ifs_device (patch 1/8)
>     -  Remove the subdirectory intel_ifs/<n> for devicenode (patch 2/8)
>     -  Replaced an enum with #define (patch 4/8)
>  - Dave Hansen
>     - Remove tracing patch
>     - ifs_array_test_core() (patch 6/8)
>         - fix an initialization bug
>         - other suggested changes
>     - Use basic types in ifs_array for first two fields. (kept
>       the union to avoid type castings)

Thank you for the new version. Given all the feedback on
the previous 2 versions I'm going to wait a bit to see if more
feedback comes in before reviewing this myself.

Regards,

Hans




> v2 submission:
> Link: https://lore.kernel.org/lkml/20230214234426.344960-1-jithu.joseph@intel.com/
> 
> Changes in v2
>  - remove duplicate initializations from ifs_array_test_core()
>    (Dave Hansen, patch 4/7)
>  - remove bit parsing from tracing fast path to tracing 
>    output (Steven Rostedt, patch 5/7)
>  - move "ATTRIBUTE_GROUPS(plat_ifs_array)" to core.c and remove
>    exporting function ifs_get_array_groups() (Greg KH, patch 3/7)
>  - Generalized doc and ABI doc (Greg KH, patches 6/7 and 7/7)
> 
> v1 submission:
> Link: https://lore.kernel.org/lkml/20230131234302.3997223-1-jithu.joseph@intel.com/
> 
> Array BIST is a new type of core test introduced under the Intel Infield
> Scan (IFS) suite of tests.
> 
> Emerald Rapids (EMR) is the first CPU to support Array BIST.
> Array BIST performs tests on some portions of the core logic such as
> caches and register files. These are different portions of the silicon
> compared to the parts tested by Scan at Field (SAF).
> 
> Unlike SAF, Array BIST doesn't require any test content to be loaded.
> 
> Jithu Joseph (8):
>   platform/x86/intel/ifs: Reorganize driver data
>   platform/x86/intel/ifs: IFS cleanup
>   x86/include/asm/msr-index.h: Add IFS Array test bits
>   platform/x86/intel/ifs: Introduce Array Scan test to IFS
>   platform/x86/intel/ifs: Sysfs interface for Array BIST
>   platform/x86/intel/ifs: Implement Array BIST test
>   platform/x86/intel/ifs: Update IFS doc
>   Documentation/ABI: Update IFS ABI doc
> 
>  arch/x86/include/asm/msr-index.h              |  2 +
>  drivers/platform/x86/intel/ifs/ifs.h          | 62 +++++++++----
>  drivers/platform/x86/intel/ifs/core.c         | 92 ++++++++++++++-----
>  drivers/platform/x86/intel/ifs/load.c         |  8 +-
>  drivers/platform/x86/intel/ifs/runtest.c      | 91 +++++++++++++++++-
>  drivers/platform/x86/intel/ifs/sysfs.c        | 17 ++--
>  .../ABI/testing/sysfs-platform-intel-ifs      |  8 +-
>  7 files changed, 221 insertions(+), 59 deletions(-)
> 

