Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87761F2C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiKGMSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiKGMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:18:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFCE140E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667823431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZTWKAuVDT83fFNqwk1O5ig1lK6i4L5TSFkF7nc/9Uwc=;
        b=UNLifTcTSxPhL+V0B5qVVgi+/39icwIlsQsfi7FTGT3NTNGZVA+j6Fu8wtPUXNxGzB1rYv
        JLbt7FkziLNrhCGQU8WjfQGqoxltNba2krtkThpYqxOU02NYnSVJQ3U6yZzKnXx+7vuj/m
        7B7UBprPwvJyBFZbf3H52IB6RloAgCA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-ZPD5yBT5Oim9z8t5gVaxyw-1; Mon, 07 Nov 2022 07:17:10 -0500
X-MC-Unique: ZPD5yBT5Oim9z8t5gVaxyw-1
Received: by mail-ed1-f71.google.com with SMTP id b14-20020a056402278e00b004621a2642d7so8153587ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZTWKAuVDT83fFNqwk1O5ig1lK6i4L5TSFkF7nc/9Uwc=;
        b=7PA9cAnH+dyV9Cw/xgOxP3REyMqWbZZuigmZn5skGDJWvzTGawZPrLboPYE8Xomm1e
         V48AvXzy5fM3gMlvPbT/LdRCPG/WXRpIbMjre6qzA/iGOYFSRuPZp31X57yj0bo3I2UW
         RitMi4Y5+hvQMpFMImQo6mkge2G0psovho9RcGF5ymC7qROnlZK2uqgoUQcWn8iikuCd
         Q4zv/B01MfitCWCKl4TKdiX74o3zs5IG0w/brXSRhJ7vVmaf2uVJvKEI436Hz8h9jNqq
         D56xqPAo3r6LyWM7nh3jnk5rg5cfnUNM1gB8ETLX6yfxQuV26v7zcPQKuflkLKKd0a39
         uexQ==
X-Gm-Message-State: ANoB5pmyh2bPu8IZaV15fqf6Fqsf3IYGtxKGa9/2MasKgsaAoKDUtzed
        rZ1rjPPuw0wub7HGD5EroU5usR2AIsW2Y+QZm8y3+hleA0gylPOsVmRKBT39CuxnUr7yU1ppvrp
        QM4qOjqD7/Fc5A4V6ZLiDbPcK
X-Received: by 2002:a17:906:4ecc:b0:7ae:4f8e:1d7 with SMTP id i12-20020a1709064ecc00b007ae4f8e01d7mr10050769ejv.339.1667823429503;
        Mon, 07 Nov 2022 04:17:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf57HiGsXfdZdGvP8OHlSyBlkc1l75EKYj1DzSKjHrWdu2vtsPjQLjOzLsvrMyaqctPFhUF06Q==
X-Received: by 2002:a17:906:4ecc:b0:7ae:4f8e:1d7 with SMTP id i12-20020a1709064ecc00b007ae4f8e01d7mr10050750ejv.339.1667823429238;
        Mon, 07 Nov 2022 04:17:09 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id v6-20020a50a446000000b00463597d2c25sm4195864edb.74.2022.11.07.04.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 04:17:08 -0800 (PST)
Message-ID: <bab3412a-6328-953e-81c2-cea423908c21@redhat.com>
Date:   Mon, 7 Nov 2022 13:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.1-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 6.1.

The most important fixes here are a set of fixes for the ACPI backlight
detection refactor which landed in 6.1. These fix regressions reported
on some laptop models by making acpi_video_backlight_use_native() always
return true for now, which in essence undoes some of the changes.

Note I plan to take another shot at having only 1 /sys/class/backlight
class device per panel with 6.2, with modified detection heuristics
to avoid the (known) regressions.

I just realized I forgot to add Rafael's Acked-by to the 3 "ACPI: video: ..."
patches, since I already have pushed out the signed tag I cannot
(easily/cleanly) fix this now, sorry. Rafael's Ack for these is here:
https://lore.kernel.org/linux-acpi/CAJZ5v0h8FvqLwTixFALfOT2xbgiSqbT3XCMCbubwad4fHpK0hQ@mail.gmail.com/

Other then that nothing special to report just various small fixes
and hardware-id additions.

Regards,

Hans


The following changes since commit e9cf4d9b9a6fdb1df6401a59f5ac5d24006bfeae:

  ACPI: video: Fix missing native backlight on Chromebooks (2022-10-24 17:02:13 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-3

for you to fetch changes up to 53eb64c88f17b14b324fbdfd417f56c5d3fa6fee:

  platform/x86: p2sb: Don't fail if unknown CPU is found (2022-11-07 12:33:49 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.1-3

Highlights:
 -  ACPI: video: Fix regressions from 6.1 backlight refactor by making
    acpi_video_backlight_use_native() always return true for now
 -  Misc. other bugfixes and HW id additions

The following is an automated git shortlog grouped by driver:

ACPI:
 -  video: Add backlight=native DMI quirk for Dell G15 5515
 -  video: Make acpi_video_backlight_use_native() always return true
 -  video: Improve Chromebook checks

hp_wmi:
 -  Fix rfkill causing soft blocked wifi

ideapad-laptop:
 -  Disable touchpad_switch

p2sb:
 -  Don't fail if unknown CPU is found

platform/x86/intel/hid:
 -  Add some ACPI device IDs

platform/x86/intel/pmt:
 -  Sapphire Rapids PMT errata fix

touchscreen_dmi:
 -  Add info for the RCA Cambio W101 v2 2-in-1

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86: p2sb: Don't fail if unknown CPU is found

David E. Box (1):
      platform/x86/intel/pmt: Sapphire Rapids PMT errata fix

Hans de Goede (4):
      ACPI: video: Improve Chromebook checks
      ACPI: video: Make acpi_video_backlight_use_native() always return true
      ACPI: video: Add backlight=native DMI quirk for Dell G15 5515
      platform/x86: touchscreen_dmi: Add info for the RCA Cambio W101 v2 2-in-1

Ivan Hu (1):
      platform/x86/intel/hid: Add some ACPI device IDs

Jorge Lopez (1):
      platform/x86: hp_wmi: Fix rfkill causing soft blocked wifi

Manyi Li (1):
      platform/x86: ideapad-laptop: Disable touchpad_switch

 drivers/acpi/video_detect.c            | 41 ++++++++++++++++++++++++++--------
 drivers/platform/x86/hp-wmi.c          | 12 ++++++++--
 drivers/platform/x86/ideapad-laptop.c  | 25 ++++++++++++++++++++-
 drivers/platform/x86/intel/hid.c       |  3 +++
 drivers/platform/x86/intel/pmt/class.c | 31 ++++++++++++++++++++++++-
 drivers/platform/x86/p2sb.c            | 15 +++++--------
 drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++
 7 files changed, 130 insertions(+), 22 deletions(-)

