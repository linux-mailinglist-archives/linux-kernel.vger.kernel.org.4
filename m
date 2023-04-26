Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ED26EF49C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbjDZMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbjDZMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436766591
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682512928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5DM8uFRDHl/3yHn+2axRN4cpB2/Yn2dxraiQxNEcRs=;
        b=BU4LWJeUjjt3eBUfsW0S7A1PwyIyabp97lhESaZXWMfETl77YGkqzZorVHthoJaWoIpxJd
        rSldnzbyqGa80JgDLuo1knQSj10I7Z5imLVW2Gk2hH0F4geFlyJpgOdSj3mKZK1gnonLUC
        9LkBexeBgf4VPAaazfRn4CjjmCJOfaE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-PoeCxOWvOgq8hmDR21Tkqg-1; Wed, 26 Apr 2023 08:42:04 -0400
X-MC-Unique: PoeCxOWvOgq8hmDR21Tkqg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94f59fc787fso665293366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 05:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682512924; x=1685104924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5DM8uFRDHl/3yHn+2axRN4cpB2/Yn2dxraiQxNEcRs=;
        b=BehFLR54axJnq8i7lNwrj6BVAvm0zsUnHPCoBRkV70ZVRq7rf+dFzARS2HtGgVBWSU
         AtC5wsw+dmVzg7zMUTcK9dwiY7FdB1s6pPQ14gtNfvkXu8MWoHz8MT9Jiacqu5xOtnuJ
         kocZfVqkmeApSezzshyqARIt0278QNPQKoWBQBUFc7yP91SOofC4O+8E5k+ml1JmoLn4
         aNJW0ZiQrvTukoMKPjAs/PNzdBQtdyy7UDE0KPUF7SJCISpYl58PB7YAoZ2N9eB2HXyt
         fXaIWhZ9Zf4dBfYsin8924m1Py01SiZWd9/MCaf+x08oelm3dkRDBgZDWpnCoExGrDI4
         xs3w==
X-Gm-Message-State: AAQBX9eDML6w2HEyowusdR8ByqxmbNSHDm2CDapoNR9YgEktVub15pe+
        xSAXTDLBrc+QVu0IBGVal8dYW3lb/3hYZBzBpbkF9+FmVB8g3wra77St471O4KjxBN4Qlk5ARrl
        khtmWAsDOxojIdLrxp24nGDCe
X-Received: by 2002:a17:907:d092:b0:959:6fb2:1c35 with SMTP id vc18-20020a170907d09200b009596fb21c35mr9999719ejc.60.1682512923893;
        Wed, 26 Apr 2023 05:42:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvXKOYJy6okWIZQECAi2PCDtQ0dPgUVzmT7RubNUWIJbMHxurZWDEmVVfiERP74ogwTR7r/g==
X-Received: by 2002:a17:907:d092:b0:959:6fb2:1c35 with SMTP id vc18-20020a170907d09200b009596fb21c35mr9999703ejc.60.1682512923548;
        Wed, 26 Apr 2023 05:42:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f15-20020a056402150f00b00506adf55ae2sm6742648edw.6.2023.04.26.05.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 05:42:02 -0700 (PDT)
Message-ID: <d632fa2f-e94f-2958-c899-480afa9354c3@redhat.com>
Date:   Wed, 26 Apr 2023 14:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/4] platform/x86: wmi: Add subsystem documentation
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424222939.208137-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230424222939.208137-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 4/25/23 00:29, Armin Wolf wrote:
> Currently, there is no recent documentation available for writing WMI
> drivers using the modern bus-based interface. This leads to developers
> using the deprecated GUID-based interface when developing new drivers,
> causing issues with notification handling when multiple WMI devices sharing
> the same notification ID are present. There is also no way for WMI
> drivers to add device specific documentation at the moment.
> Add documentation for the WMI subsystem to solve those issues. The
> device specific documentation currently onyl include documentation for
> the wmi-bmof driver, but more is expected to follow.

Thank you for your patch series, I've applied this series
to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Patches which are added to review-hans now are intended for
the next rc1. This branch will get rebased to the next rc1 when
it is out and after the rebasing the contents of review-hans
will be pushed to the platform-drivers-x86/for-next branch.

Regards,

Hans


> ---
> Changes in v2:
> - spelling fixes
> - tell readers that MOF means Managed Object Format
> - 80-cloumn limit
> 
> Armin Wolf (4):
>   platform/x86: wmi: Add kernel doc comments
>   platform/x86: wmi: Mark GUID-based WMI interface as deprecated
>   platform/x86: wmi: Add documentation
>   platform/x86: wmi: Add device specific documentation
> 
>  .../ABI/stable/sysfs-platform-wmi-bmof        |  7 ++
>  Documentation/driver-api/index.rst            |  1 +
>  Documentation/driver-api/wmi.rst              | 21 ++++
>  Documentation/subsystem-apis.rst              |  1 +
>  Documentation/wmi/acpi-interface.rst          | 96 +++++++++++++++++++
>  Documentation/wmi/devices/index.rst           | 22 +++++
>  Documentation/wmi/devices/wmi-bmof.rst        | 25 +++++
>  Documentation/wmi/index.rst                   | 19 ++++
>  MAINTAINERS                                   |  9 ++
>  drivers/platform/x86/Kconfig                  |  4 +-
>  drivers/platform/x86/wmi.c                    | 63 +++++++++---
>  include/linux/wmi.h                           | 41 +++++++-
>  12 files changed, 289 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-platform-wmi-bmof
>  create mode 100644 Documentation/driver-api/wmi.rst
>  create mode 100644 Documentation/wmi/acpi-interface.rst
>  create mode 100644 Documentation/wmi/devices/index.rst
>  create mode 100644 Documentation/wmi/devices/wmi-bmof.rst
>  create mode 100644 Documentation/wmi/index.rst
> 
> --
> 2.30.2
> 

