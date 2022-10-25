Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F7B60C915
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiJYJ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiJYJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B217A955
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666691585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EtrW71D5/2sPWM7kdpNEu7omKbDnLBRaRCZse75RN24=;
        b=QQ7GqgiROqwNihh5xpWeymUpLIh0ZBEcTt7mqRP16dDDKdZGe3+iGWGMORSc0P6zF+eXvj
        2gd5wqRl5eLL1dDe/hInjx97l8Ado2xyoC0OrHCb+pkCb9ld2GnTjIKmJx5YVd+0RE86Pp
        Hv5/9vHdDALa8+MXPk4HfukKgYC28Gk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-OZZ3BLGDNeClv3Pbq6V9DQ-1; Tue, 25 Oct 2022 05:53:03 -0400
X-MC-Unique: OZZ3BLGDNeClv3Pbq6V9DQ-1
Received: by mail-ed1-f71.google.com with SMTP id dz9-20020a0564021d4900b0045d9a3aded4so11650707edb.22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EtrW71D5/2sPWM7kdpNEu7omKbDnLBRaRCZse75RN24=;
        b=7cOHdX2B2pUgRSH7mr/qutqOqrOOcQdApRjRnwjf4ZRxmf/CVLYSTAYOMfiPRnDYJ+
         YKDH74NZraDcsLwcgfLsDtkVVTR03co3/TyWVQAHX6xPCg/ag6LaNJ/Xboz11PuNr4v+
         mE5yd/APiEg9hKf+O635c8gz14yVKZSVmOd7Y9eS0ptJ3yw0aAzr1NEJ/N2GaZ208gO8
         CcGg77ABXGZ13krOH8Mt/TU4vyTK814iKyQG5aoBc59C9Qb8b3h4ER52MMmbww2HICE1
         M1si8hm9zm7aIYXXaJR+jCAxjXznTD1CO466MmTMf114v5x8RguqWyu6fvTSRLA/7KBw
         tnqg==
X-Gm-Message-State: ACrzQf0vw+Vwffj6JA9140TLKgkMhqUuzVI7dPUVxTFbUAcIo2ETz+Pi
        gt0P18nmbA2aAEKDpwJYVwrxhEAbJy5gHjz6uR9iM+oHhysGvp0a/rqArwsbeReXWRTl4Ou0WrB
        iayYlrYOUHiORMRN0mUiHRADA
X-Received: by 2002:a17:907:da7:b0:791:8f57:6860 with SMTP id go39-20020a1709070da700b007918f576860mr32509234ejc.509.1666691581773;
        Tue, 25 Oct 2022 02:53:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5UdWVp2QHWe3GuycJ8wnLjKKaJcsY9oYSs676/vqh3nm58pjFII9O6z3LyFVUZl1FBqX3rgg==
X-Received: by 2002:aa7:c14f:0:b0:460:e1cc:2c29 with SMTP id r15-20020aa7c14f000000b00460e1cc2c29mr24718596edp.423.1666691571384;
        Tue, 25 Oct 2022 02:52:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b007919ba4295esm1072639eja.216.2022.10.25.02.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:52:50 -0700 (PDT)
Message-ID: <9256cedf-151d-724b-1e39-fe016fce8a44@redhat.com>
Date:   Tue, 25 Oct 2022 11:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.1-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the first round of fixes for platform-drivers-x86 for 6.1.

The only thing which stands out is a fix for a backlight regression
on Chromebooks (under drivers/acpi, with ack from Rafael).

Other then that nothing special to report just various small fixes
and hardware-id additions.

Regards,

Hans


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.1-2

for you to fetch changes up to e9cf4d9b9a6fdb1df6401a59f5ac5d24006bfeae:

  ACPI: video: Fix missing native backlight on Chromebooks (2022-10-24 17:02:13 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.1-2

A small set of assorted fixes and hardware-id additions for 6.1.

The following is an automated git shortlog grouped by driver:

ACPI:
 -  video: Fix missing native backlight on Chromebooks

asus-wmi:
 -  Add support for ROG X16 tablet mode

leds:
 -  simatic-ipc-leds-gpio: fix incorrect LED to GPIO mapping

platform/x86/amd:
 -  pmc: Read SMU version during suspend on Cezanne systems

platform/x86/intel:
 -  pmc/core: Add Raptor Lake support to pmc core driver

thinkpad_acpi:
 -  Fix reporting a non present second fan on some models

----------------------------------------------------------------
Dmitry Osipenko (1):
      ACPI: video: Fix missing native backlight on Chromebooks

Gayatri Kammela (1):
      platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver

Henning Schild (1):
      leds: simatic-ipc-leds-gpio: fix incorrect LED to GPIO mapping

Jelle van der Waa (1):
      platform/x86: thinkpad_acpi: Fix reporting a non present second fan on some models

Luke D. Jones (1):
      platform/x86: asus-wmi: Add support for ROG X16 tablet mode

Mario Limonciello (1):
      platform/x86/amd: pmc: Read SMU version during suspend on Cezanne systems

 drivers/acpi/video_detect.c                 | 12 ++++++++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 12 ++++++------
 drivers/platform/x86/amd/pmc.c              |  7 +++++++
 drivers/platform/x86/asus-nb-wmi.c          |  9 +++++++++
 drivers/platform/x86/intel/pmc/core.c       |  2 ++
 drivers/platform/x86/thinkpad_acpi.c        |  4 +++-
 6 files changed, 39 insertions(+), 7 deletions(-)

