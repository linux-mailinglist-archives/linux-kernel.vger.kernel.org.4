Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9A5EB08A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiIZSwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIZSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:52:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09D8A1EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:52:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so11620671wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=riX8yuJ7T/1aIgc2gZuwKDnDJ1vHtlPT4yB5deweeiM=;
        b=UHqgCA9TAYirnUkGkKzOw3CgCxhoJzb1PLInmzM4kmFKCzfEUHG9r51rYRoqtEQX9K
         tg8Xn3JezJ/S8lJE+K0Suz1kmQAspO7T/STgU4GUj58QZ5qrw6oO3vCMMZj5KjLrndpp
         b6d5QQpQHyGpuoTFYP52cfAuMsZAdrg7VMTHDQbsuR47SYeUxscRJ1jfHpsex0ZIhnGK
         h5EBqUpKH0cTxRFn1Hmu+tHzj/me6usWLBM0f2pY9Tn6yujUALkFmHONPP5IHA7lEVWF
         gmsxzd/KVyogbUfxfqcT21kiYEw1nFD+n5CeY86u/1My7MiwLeg+3bwhhWcStwn4ycMR
         U6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=riX8yuJ7T/1aIgc2gZuwKDnDJ1vHtlPT4yB5deweeiM=;
        b=MRGUqWgHI33axOwg1XvJYoJPq4DOS+dVdPS4OHL4ALpmhTS4+S0OABMhGgkQ23FwH/
         Y6mrZgieq1uGZa006EQnkJjth0gUiMO0pklm7AvQYBXqZfZ4wUzBG1qrYRIkDFXj3gi5
         noZ3FE+rDz/tfDgPiwUaTlHlcCne9Rul9vNvrT95/ZlBC9q00EOyoeFOJ/J4LPDsB1gN
         GqMPgPsKk7OUYdmS4oESLDdPtCWDEgQa7BQf1dWHOm/sBbDT0ZrOHfKh5pXnqVv1InQO
         xbUQVke6zgHD59it0pnJI6THc/a1ffld0jxfR5y9+rPyggYCI4MiY+uaU3FiPdh6IYTo
         sd/w==
X-Gm-Message-State: ACrzQf1IEcXjWXDQg318wEvAtXjYQREt/N86XHUqq/5DmJv+fm407B5A
        lKgScndEReVaE5vJGQHrfIjwNG4l2wQj
X-Google-Smtp-Source: AMsMyM7Ycbl2s0l0BI1pvE1IBL2sYqvT42ZAtuFcMyNQphhC5bQq8O77L6KTAHqpW/B2VXNhJsY4jw==
X-Received: by 2002:a05:6000:18a1:b0:22a:f4c2:c9d3 with SMTP id b1-20020a05600018a100b0022af4c2c9d3mr14065268wri.92.1664218329260;
        Mon, 26 Sep 2022 11:52:09 -0700 (PDT)
Received: from fedora (88-106-97-87.dynamic.dsl.as9105.com. [88.106.97.87])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003b4fe03c881sm12391851wmo.48.2022.09.26.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:52:08 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:52:07 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     tglx@linutronix.de
Cc:     steven.price@arm.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        ak@linux.intel.com, Jason@zx2c4.com
Subject: [PATCH 5/7] kernel/cpu: Convert snprintf() to scnprintf()
Message-ID: <YzH01+6fErqu2Roo@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf
Adding to that, there has been a slow migration from snprintf to scnprintf.
This LWN article explains the rationale for this change
https: //lwn.net/Articles/69419/
Ie. snprintf() returns what *would* be the resulting length,
while scnprintf() returns the actual length.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..f358d89c9580 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2512,7 +2512,7 @@ static ssize_t control_show(struct device *dev,
 {
 	const char *state = smt_states[cpu_smt_control];
 
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return scnprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
 static ssize_t control_store(struct device *dev, struct device_attribute *attr,
@@ -2525,7 +2525,7 @@ static DEVICE_ATTR_RW(control);
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return scnprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR_RO(active);
 
-- 
2.37.3

