Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB76687A74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjBBKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjBBKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:42:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828195C0C5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675334502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QlEx6p+sP0F72zEFo4Djc1uKGyMHxjFvBe5AJ7Wvue0=;
        b=PLgxSHb1EBTerzaJ2HYl9fWtPK2jErqzap2uSH2yYzgmPmKYWI8LdIpS76qocYQ79SIsag
        veAljU+VVcwGdSAzZoKJ/8NSRr2l/6XbpzYC1I/W9iFF8tk9uMvpSOejaYva+z08GsHaUW
        IGwoSUtq5vSZltvBJZPudMjVM+ycrr4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365-D6Q1mcctNyS6LHepCMjjtg-1; Thu, 02 Feb 2023 05:41:41 -0500
X-MC-Unique: D6Q1mcctNyS6LHepCMjjtg-1
Received: by mail-ed1-f70.google.com with SMTP id w16-20020a056402129000b004a1f1a2e79dso1137813edv.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlEx6p+sP0F72zEFo4Djc1uKGyMHxjFvBe5AJ7Wvue0=;
        b=tDSxrkbe1Ih5ZLpz0KfP9Tqhblt6IYGTMTU4V9jmrWjjytPG6eGW/BqsOZUovNsQr8
         gYcGrzbFgjafvYoa5gUpwbv/ZpaWXk/roo5gBsyNKeJytu4KU3/opaYl8ZNp3aAQ+JKQ
         UAaeQF7HJE4DmMnAYv0Z750QPI/lQbup8F4ouTXjdm0e7LgeF5OEnEz6SI3GVXkiRtM4
         Y/yeIfo2aOFju/HwFn1idf5aHRED8ItBrz68XIQJhFaKmuPAj0cdMQYRNdjQ0GywgsTP
         UMPGqTTgSTCx+Seg12x+9mfowJJro4f1sei2bkyn3frkulP1hJFzKNiINy2lkza5ZVNj
         xXgw==
X-Gm-Message-State: AO0yUKWLK5F2nOW72T6wC1HzhYZpm51u4PcGTS0zz5R8PSUBx5YZttmj
        DHDRDoP1ZamrPHwiK3oZfXVuHN51SGmp0O/+iDMYGtIXAuh8KaHOFYjh6/FM0+iFJROtnZCr0s8
        uBr8lTyUFGyvHylUF9pb5i0XB
X-Received: by 2002:a05:6402:2206:b0:492:bf3d:1a16 with SMTP id cq6-20020a056402220600b00492bf3d1a16mr5195435edb.4.1675334499764;
        Thu, 02 Feb 2023 02:41:39 -0800 (PST)
X-Google-Smtp-Source: AK7set+ZybQHsTFn1hv7cKYKZkfqRELTowe/2i5vppcjDAa4cdyqVT3cV70lTyNzSy/RfX3OW7SuAw==
X-Received: by 2002:a05:6402:2206:b0:492:bf3d:1a16 with SMTP id cq6-20020a056402220600b00492bf3d1a16mr5195428edb.4.1675334499569;
        Thu, 02 Feb 2023 02:41:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906010b00b0088272bac7c5sm8447323eje.121.2023.02.02.02.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 02:41:39 -0800 (PST)
Message-ID: <21c96b2f-92bb-5ba8-c08f-e6df1db4a4df@redhat.com>
Date:   Thu, 2 Feb 2023 11:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.2-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Here is the third round of fixes for platform-drivers-x86 for 6.2.

This pull-req contains a set of AMD PMF fixes + a few other small fixes.

Regards,

Hans


The following changes since commit 1bc5d819f0b9784043ea08570e1b21107aa35739:

  platform/x86: thinkpad_acpi: Fix profile modes on Intel platforms (2023-01-25 12:45:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.2-4

for you to fetch changes up to eecf2acd4a580e9364e5087daf0effca60a240b7:

  platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI match (2023-02-02 11:34:38 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v6.2-4

A set of AMD PMF fixes + a few other small fixes.

The following is an automated git shortlog grouped by driver:

platform/x86/amd:
 -  pmc: add CONFIG_SERIO dependency

platform/x86/amd/pmf:
 -  Ensure mutexes are initialized before use
 -  Fix to update SPS thermals when power supply change
 -  Fix to update SPS default pprof thermals
 -  update to auto-mode limits only after AMT event
 -  Add helper routine to check pprof is balanced
 -  Add helper routine to update SPS thermals

thinkpad_acpi:
 -  Fix thinklight LED brightness returning 255

touchscreen_dmi:
 -  Add Chuwi Vi8 (CWI501) DMI match

----------------------------------------------------------------
Arnd Bergmann (1):
      platform/x86/amd: pmc: add CONFIG_SERIO dependency

Hans de Goede (3):
      platform/x86/amd/pmf: Ensure mutexes are initialized before use
      platform/x86: thinkpad_acpi: Fix thinklight LED brightness returning 255
      platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI match

Shyam Sundar S K (5):
      platform/x86/amd/pmf: Add helper routine to update SPS thermals
      platform/x86/amd/pmf: Add helper routine to check pprof is balanced
      platform/x86/amd/pmf: update to auto-mode limits only after AMT event
      platform/x86/amd/pmf: Fix to update SPS default pprof thermals
      platform/x86/amd/pmf: Fix to update SPS thermals when power supply change

 drivers/platform/x86/amd/Kconfig         |  1 +
 drivers/platform/x86/amd/pmf/auto-mode.c |  9 +--------
 drivers/platform/x86/amd/pmf/cnqf.c      | 14 +++++---------
 drivers/platform/x86/amd/pmf/core.c      | 32 ++++++++++++++++++++++++++++----
 drivers/platform/x86/amd/pmf/pmf.h       |  3 +++
 drivers/platform/x86/amd/pmf/sps.c       | 28 ++++++++++++++++++++++------
 drivers/platform/x86/thinkpad_acpi.c     |  2 +-
 drivers/platform/x86/touchscreen_dmi.c   |  9 +++++++++
 8 files changed, 70 insertions(+), 28 deletions(-)


