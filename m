Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057BC62BAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiKPLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiKPLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CB450B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668595698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=actXV8V/4HNDVBL7ZEvrJbHCudo+/TOoQCTQnP3PDcQ=;
        b=SFM53fQHBcb3XASC2GdbpW3vWIHFL6NP/szeFhyavLG+0w1QMRyuLBVLvUbVM05GOvgoCI
        o7qynrsJsC/ECY03Ohlf8j6VbIZbky86qBP5bSHlDkjbsFJn9GzWxYjokXg3QeoVc5NH8v
        cOwBLialCT106NuS87rU5ozHrh05kH4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449-clpFUp2AMxSlrMYUe6BqUA-1; Wed, 16 Nov 2022 05:48:15 -0500
X-MC-Unique: clpFUp2AMxSlrMYUe6BqUA-1
Received: by mail-ej1-f69.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso9531317ejb.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=actXV8V/4HNDVBL7ZEvrJbHCudo+/TOoQCTQnP3PDcQ=;
        b=cMKUo3jtdypPRm29iqNqBpb0T30Y+bM7aFg5Izh4whoOJz/nyltVQqKEeTJMy+0eaR
         EuSUkNL8IOjXffb1i//xCEHx8VX8kTUDOYqeKWTQgup75mpXyw1c71fgi5gerZeTUpEH
         TycF4xroGK1FolxbMCAxnzV1qDgCFvjhZZvaKdCvd2g5aPFe+EXpkEK4inFPEMpQQRoI
         xPEk6o97OdGohkqXIga2ExpA9+/NZtnOb3zqm89G12z23Q/vsgIOdrht50uoGyyQs5vX
         UNHSy3dO/a1jREg1mMUIrRjb31nJLCa2m0LztSynk2GQc+69Lo2dNW5BKvrAySSYfCB8
         +lcg==
X-Gm-Message-State: ANoB5pl+xbUYZebzjCv3dRLpbREoBrdWYi9E3koQ3QXerO7na9OM4T+C
        GhVWHkxFxPt9URFPdSEQxSmOSEOG6ikfVINflvfsY1xvLfZIzIEgubzhrrR616KUvfVLxGZAicp
        y8oZkExqCc9VAACnCUjWTXwhP
X-Received: by 2002:a17:906:b046:b0:7ae:50c6:453a with SMTP id bj6-20020a170906b04600b007ae50c6453amr17306079ejb.596.1668595693653;
        Wed, 16 Nov 2022 02:48:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Qqw6Edkg9M9z4WOBmEeBBINk3jGmghVcVxARQQw1FpxITl3iaW+gro9yRTHhbZ3vlSsggIw==
X-Received: by 2002:a17:906:b046:b0:7ae:50c6:453a with SMTP id bj6-20020a170906b04600b007ae50c6453amr17306068ejb.596.1668595693457;
        Wed, 16 Nov 2022 02:48:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a2-20020aa7d742000000b004623028c594sm7333413eds.49.2022.11.16.02.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:48:12 -0800 (PST)
Message-ID: <5e425476-5f04-23e2-03e0-1f8ea57c1a55@redhat.com>
Date:   Wed, 16 Nov 2022 11:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.1-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the third round of fixes for platform-drivers-x86 for 6.1:

 -  Surface Pro 9 and Surface Laptop 5 kbd, battery, etc. support
    (this is just a few hw-id additions)
 -  A couple of other hw-id / DMI-quirk additions
 -  A few small bug fixes + 1 build fix

Regards,

Hans


The following changes since commit 53eb64c88f17b14b324fbdfd417f56c5d3fa6fee:

  platform/x86: p2sb: Don't fail if unknown CPU is found (2022-11-07 12:33:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-4

for you to fetch changes up to b44fd994e45112b58b6c1dec4451d9a925784589:

  platform/x86: ideapad-laptop: Add module parameters to match DMI quirk tables (2022-11-16 08:47:08 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.1-4

Highlights:
 -  Surface Pro 9 and Surface Laptop 5 kbd, battery, etc. support
    (this is just a few hw-id additions)
 -  A couple of other hw-id / DMI-quirk additions
 -  A few small bug fixes + 1 build fix

The following is an automated git shortlog grouped by driver:

acer-wmi:
 -  Enable SW_TABLET_MODE on Switch V 10 (SW5-017)

asus-wmi:
 -  add missing pci_dev_put() in asus_wmi_set_xusb2pr()

hp-wmi:
 -  Ignore Smart Experience App event

ideapad-laptop:
 -  Add module parameters to match DMI quirk tables
 -  Fix interrupt storm on fn-lock toggle on some Yoga laptops

platform/surface:
 -  aggregator_registry: Add support for Surface Laptop 5
 -  aggregator_registry: Add support for Surface Pro 9
 -  aggregator: Do not check for repeated unsequenced packets

platform/x86/amd:
 -  pmc: Add new ACPI ID AMDI0009
 -  pmc: Remove more CONFIG_DEBUG_FS checks

platform/x86/intel:
 -  pmc: Don't unconditionally attach Intel PMC when virtualized

thinkpad_acpi:
 -  Enable s2idle quirk for 21A1 machine type

----------------------------------------------------------------
Arnav Rawat (1):
      platform/x86: ideapad-laptop: Fix interrupt storm on fn-lock toggle on some Yoga laptops

Hans de Goede (2):
      platform/x86: acer-wmi: Enable SW_TABLET_MODE on Switch V 10 (SW5-017)
      platform/x86: ideapad-laptop: Add module parameters to match DMI quirk tables

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Smart Experience App event

Lennard Gäher (1):
      platform/x86: thinkpad_acpi: Enable s2idle quirk for 21A1 machine type

Mario Limonciello (1):
      platform/x86/amd: pmc: Remove more CONFIG_DEBUG_FS checks

Maximilian Luz (3):
      platform/surface: aggregator: Do not check for repeated unsequenced packets
      platform/surface: aggregator_registry: Add support for Surface Pro 9
      platform/surface: aggregator_registry: Add support for Surface Laptop 5

Roger Pau Monné (1):
      platform/x86/intel: pmc: Don't unconditionally attach Intel PMC when virtualized

Shyam Sundar S K (1):
      platform/x86/amd: pmc: Add new ACPI ID AMDI0009

Xiongfeng Wang (1):
      platform/x86: asus-wmi: add missing pci_dev_put() in asus_wmi_set_xusb2pr()

 .../platform/surface/aggregator/ssh_packet_layer.c | 24 +++++++++++---
 .../platform/surface/surface_aggregator_registry.c | 37 ++++++++++++++++++++++
 drivers/platform/x86/acer-wmi.c                    |  9 ++++++
 drivers/platform/x86/amd/pmc.c                     |  3 +-
 drivers/platform/x86/asus-wmi.c                    |  2 ++
 drivers/platform/x86/hp-wmi.c                      |  3 ++
 drivers/platform/x86/ideapad-laptop.c              | 37 ++++++++++++++++++++--
 drivers/platform/x86/intel/pmc/pltdrv.c            |  9 ++++++
 drivers/platform/x86/thinkpad_acpi.c               |  8 +++++
 9 files changed, 124 insertions(+), 8 deletions(-)

