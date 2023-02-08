Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD97E68FB0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBHXUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBHXUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:20:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78244A5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:20:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-527af7b329aso2444537b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 15:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+6M1s6jVzcZP7H16vCeUwIRH/hJEUzDrlIpdlKRJhik=;
        b=mBb39kHZdGoftt6jokvxEpIxgXyE4g6cQI9YaKv/PO27i8fxX5pxrgNtuSU0GYHGFA
         cyHDBjQvthf3Xqw3OAGereXg+BotnoemG2a/dE5BTEleBFRgWKQNEh6jreR/WPI48/GM
         Dj9tsoy79KreWNfUsTCXK3RjIqtqZlZswVAIP9vw8aNZcpc2sPui2Mkb0B+xocImQ46D
         KmSFO2GEEvWNAxrPT715rdP2wtkq8kMwIz8CMxOThFa1t79/5WUj6tHqxDCEG75EIhiP
         F3W91ygmCRpKyGWxKsAqsOwF3+6dI3J2f26Y08qbJASOUuC5yLyJGRe8/uafGcjrXoTh
         5L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6M1s6jVzcZP7H16vCeUwIRH/hJEUzDrlIpdlKRJhik=;
        b=YUzQrOOQ6y2Us+gxQozCI/XplvrS+JbD6e1KQtVUW/bjOfrvarkb1Jnxn29v3kqfoY
         B19AXrCXOXU7lXpbquLKtPeqaAZG1AeJZJ2V6lS57ChzULbmRl8la8k/G42Oh6PiV+Ii
         Ucrhu/Kxb3mnBdAylIUUbfx6pY08S3TIk5QwnzsCrgCcLJZu7Qvfuu+yfVOUUw5fEOZ1
         wuVxdZ4mbRT22xPQMuzQiPJseH15HH8XU218f4qi2jXpFq+Lw23e8CtTqAb/q+tSKrn4
         VH0ckG4MWWstf8rz3FP1UYtSq8bT2GqGAn8dZJ8Ns5Z5nCwFOkoTtuz4diqRJ+DTle1y
         n89g==
X-Gm-Message-State: AO0yUKU496zmiVzxvt7DEQ8EBa1BKFfh+2vcW+/LHxUayGjIcGFa0H04
        HFbAewZuVakwCiumCPZSezUG/4LrSB+7ssZbKAUdrQ==
X-Google-Smtp-Source: AK7set/kS9P6unQBcb+71E7vO8XBeo8f3HWqwTvhJ1RMmwL44a8INIhB2P197E46QbsxqxFdPinayks2Z3H4MVENs7mucQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:32e8:a89:521e:3f2e])
 (user=isaacmanjarres job=sendgmr) by 2002:a0d:d543:0:b0:52b:ecfa:575a with
 SMTP id x64-20020a0dd543000000b0052becfa575amr2ywd.0.1675898405151; Wed, 08
 Feb 2023 15:20:05 -0800 (PST)
Date:   Wed,  8 Feb 2023 15:19:59 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230208232001.2052777-1-isaacmanjarres@google.com>
Subject: [PATCH v2 0/1] Fix kmemleak crashes when scanning CMA regions
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Saravana Kannan <saravanak@google.com>, linux-mm@kvack.org,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to boot a device with an ARM64 kernel with the following
config options enabled:

CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_DEBUG_KMEMLEAK=y

a crash is encountered when kmemleak starts to scan the list of gray
or allocated objects that it maintains. Upon closer inspection, it was
observed that these page-faults always occurred when kmemleak attempted
to scan a CMA region.

At the moment, kmemleak is made aware of CMA regions that are specified
through the devicetree to be dynamically allocated within a range of
addresses. However, kmemleak should not need to scan CMA regions or any
reserved memory region, as those regions can be used for DMA transfers
between drivers and peripherals, and thus wouldn't contain anything
useful for kmemleak.

Additionally, since CMA regions are unmapped from the kernel's address
space when they are freed to the buddy allocator at boot when
CONFIG_DEBUG_PAGEALLOC is enabled, kmemleak shouldn't attempt to access
those memory regions, as that will trigger a crash. Thus, kmemleak
should ignore all dynamically allocated reserved memory regions.

v1 ==> v2:
- Simplified the original approach of informing kmemleak about all CMA
  regions in the system to just having kmemleak ignore CMA regions it is
  currently aware of.

Isaac J. Manjarres (1):
  of: reserved_mem: Have kmemleak ignore dynamically allocated reserved
    mem

 drivers/of/of_reserved_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.39.1.581.gbfd45094c4-goog

