Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D296A6C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCAMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358CD303DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677675281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7rxUejgMdEgbK2ryOu+LPqYE2umbodPKouLs7Mb/Xo=;
        b=NOo232KfUeJ3n8EhGoK8OJ4KKujOK0J3TdfmtYxaxU9fM0KGs0tWZxb870ERCp/DlLaOdV
        0nmcTGsBhl2zoPNVfNT3tbBS5STwyJsRpnjb1Rowe2XriDX3iTwcl4nfsl5U11HUirihiz
        HcSj5OSVYZd48LvJXLTIwM++fDg6oY4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-3qXMTNlaPYONKGajkNjfAQ-1; Wed, 01 Mar 2023 07:54:40 -0500
X-MC-Unique: 3qXMTNlaPYONKGajkNjfAQ-1
Received: by mail-ed1-f69.google.com with SMTP id eh16-20020a0564020f9000b004acc4f8aa3fso18916784edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7rxUejgMdEgbK2ryOu+LPqYE2umbodPKouLs7Mb/Xo=;
        b=OTJUMmqAhiSRrTn6EBIvZte6cNqLGU9RKDVaQgzk22RmglgSmVdhrjQitZLI3t9L0j
         XtiSsLOztMw+wqRaDRDC7KCqA4ArJbT6llzyGwhouxL8xd2M7rxKK+L0N6pOy/O8iNp0
         k2hTzQxRoTgwP+buKoOmhA3WGsdDbESDYhLycEO/aOGsdKaCJrpB9t3ANEZEuKwqOFEG
         trOcUDT8r9qtyv4ZugPv1wRU7rLo0zxKToxMXDN4tEc3FFDDenimTGi2XRof+9fzQ0as
         9fYjnkADpGz/KxDa4QRdcpncN55Cr4HJpVQvuU6wu8dx/fAYz2cSDF8EVtTNq+cmJ/qe
         4XMg==
X-Gm-Message-State: AO0yUKV4meyJSj/1C9rlNI0fDj1EjK7Atv99uMnuPecNqEJIAirEM2I/
        ahr/BshidEvFGkhwGKpeJc3gbaXX50PG7etk4xRAEREI8cJLcJwOgGFl2e1HZHopzf2A9HlupZp
        mBOulznSsI6VxjGFqPWaBVrYG
X-Received: by 2002:a17:907:6ea5:b0:906:3799:cc7f with SMTP id sh37-20020a1709076ea500b009063799cc7fmr2499866ejc.39.1677675279309;
        Wed, 01 Mar 2023 04:54:39 -0800 (PST)
X-Google-Smtp-Source: AK7set81lCv1nlaF8uVgwEzJ3dXt9sQnmYTFJPQS2vA/4IgLiYvEc8PtxcfEkdqcRM+zsD7LeNfPvA==
X-Received: by 2002:a17:907:6ea5:b0:906:3799:cc7f with SMTP id sh37-20020a1709076ea500b009063799cc7fmr2499844ejc.39.1677675278954;
        Wed, 01 Mar 2023 04:54:38 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z71-20020a509e4d000000b004acb42134c4sm5607607ede.70.2023.03.01.04.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 04:54:38 -0800 (PST)
Message-ID: <4ccb9139-1e70-e669-646a-1975460962cd@redhat.com>
Date:   Wed, 1 Mar 2023 13:54:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/5] apple-gmux: support MMIO gmux type on T2 Macs
Content-Language: en-US, nl
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230218132007.3350-1-orlandoch.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/18/23 14:20, Orlando Chamberlain wrote:
> Hi All,
> 
> This patch series adds support for the MMIO based gmux present on these
> Dual GPU Apple T2 Macs: MacBookPro15,1, MacBookPro15,3, MacBookPro16,1,
> MacBookPro16,4 (although amdgpu isn't working on MacBookPro16,4 [1]).
> 
> Changes from v2[2]:
> 
> - Add "," to last item in apple_gmux_type enum
> - Don't not clear interrupts when status is 0
> - Don't check if we failed to make debugfs folder
> - Check for fake mmio gmux

Thanks, this looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the entire series.

Can you prepare a v4 addressing Lukas's remarks:

1. Switch to acpi_execute_simple_method()
2. Add extra info about the gmux provided by Lukas 
   to either the docs or as comments

With those changes added I believe v4 will be ready
for merging.

Regards,

Hans


> 
> # 1:
> 
> has a slight change in how the switch state is read: instead of checking
> for x == 2, check !(x & 1)
> 
> # 2:
> 
> implements a system to support more than 2 gmux types
> 
> # 3:
> 
> start using the gmux's GMSP acpi method when handling interrupts on MMIO
> gmux's. This is needed for the MMIO gmux's to clear interrupts.
> 
> # 4:
> 
> Adds support for the MMIO based gmux on T2 macs.
> 
> # 5:
> 
> Add a debugfs interface to apple-gmux so data from ports can be read
> and written to from userspace.
> 
> This can be used for more easily researching what unknown ports do,
> and switching gpus when vga_switcheroo isn't ready (e.g. when one gpu
> is bound to vfio-pci and in use by a Windows VM, I can use this to
> switch my internal display between Linux and Windows easily).
> 
> # Issues:
> 
> 1. Switching gpus at runtime has the same issue as indexed gmux's: the
> inactive gpu can't probe the DDC lines for eDP [3]
> 
> 2. iMacPro1,1, iMac20,1 and iMac20,2 all seem to have a gmux in their
> acpi tables, but they shouldn't. A check that hopefully will detect this
> is used, but it's untested as I don't have any of those computers.
> 
> 3. Powering on the amdgpu with vga_switcheroo doesn't work well. I'm
> told on the MacBookPro15,1 it works sometimes, and adding delays helps,
> but on my MacBookPro16,1 I haven't been able to get it to work at all:
> 
> amdgpu: switched off
> amdgpu: switched on
> amdgpu 0000:03:00.0:
>     Unable to change power state from D3hot to D0, device inaccessible
> amdgpu 0000:03:00.0:
>     Unable to change power state from D3cold to D0, device inaccessible
> [drm] PCIE GART of 512M enabled (table at 0x00000080FEE00000).
> [drm] PSP is resuming...
> [drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
> [drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
> [drm:amdgpu_device_fw_loading [amdgpu]]
>     *ERROR* resume of IP block <psp> failed -62
> amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
> snd_hda_intel 0000:03:00.1: Enabling via vga_switcheroo
> snd_hda_intel 0000:03:00.1:
>     Unable to change power state from D3cold to D0, device inaccessible
> snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535
> snd_hda_codec_hdmi hdaudioC0D0: Unable to sync register 0x2f0d00. -5
> 
> There are some acpi methods (PWRD, PWG1 [4, 5]) that macOS calls when
> changing the amdgpu's power state, but we don't use them and that could be
> a cause. Additionally unlike previous generation Macbooks which work
> better, on MacBookPro16,1 the gpu is located behind 2 pci bridges:
> 
> 01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
>     Navi 10 XL Upstream Port of PCI Express Switch (rev 43)
> 02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
>     Navi 10 XL Downstream Port of PCI Express Switch
> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>     Navi 14 [Radeon RX 5500/5500M / Pro 5500M] (rev 43)
> 03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
>     Navi 10 HDMI Audio
> 
> Upon attempting to power on the gpu with vga_switcheroo, all these
> devices except 01:00.0 have their config space filled with 1s.
> Rescanning pci makes the config space of all the devices go back to
> normal, however amdgpu still fails to resume with the same logs as
> above.
> 
> [1]: https://lore.kernel.org/all/3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com/
> [2]: https://lore.kernel.org/platform-driver-x86/20230216122342.5918-1-orlandoch.dev@gmail.com/
> [3]: https://lore.kernel.org/all/9eed8ede6f15a254ad578e783b050e1c585d5a15.1439288957.git.lukas@wunner.de/
> [4]: https://gist.github.com/Redecorating/6c7136b7a4ac7ce3b77d8e41740dd87b
> [5]: https://lore.kernel.org/all/20120710160555.GA31562@srcf.ucam.org/
> 
> Orlando Chamberlain (5):
>   apple-gmux: use first bit to check switch state
>   apple-gmux: refactor gmux types
>   apple-gmux: Use GMSP acpi method for interrupt clear
>   apple-gmux: support MMIO gmux on T2 Macs
>   apple-gmux: add debugfs interface
> 
>  drivers/platform/x86/apple-gmux.c | 349 ++++++++++++++++++++++++++----
>  include/linux/apple-gmux.h        |  70 ++++--
>  2 files changed, 357 insertions(+), 62 deletions(-)
> 

