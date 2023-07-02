Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E94745273
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGBVO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 17:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 17:14:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D22E54;
        Sun,  2 Jul 2023 14:14:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b89bc52cd1so104695ad.1;
        Sun, 02 Jul 2023 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688332494; x=1690924494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4cN3JSQg0LROpUkwJ5OAt46ArJ76XLCWxuJ783Zv6aE=;
        b=qNRV+7gEAgLRd0BVi+m3pRcVO+/d+b5oGaeVl1fFnDRuUoRPGVqqftO11e96GC+Qc5
         uXYQxHRpPnTqhcG+RxWF4goVgc4BxE6jWfNxqc0UPD9Cj3+foqNIQkkkcufr/nKV1Lz1
         ZlYd6sl2l/nVsXt7o729HPLWIkePUH/FYSLt11xQnwtEpHEHB+loOzSRTqmdt9ccfyfy
         ie9J+S3IXtb7hZCCA/3mqRMOMCZ+SPSZEDUvgIUmRuvNaj6aXfhg1qGaeznNhJ4s8FFR
         mwfXohBLWijFhh9g8lFsUUHmfjU1TKf+mLPnm933y2DGz43E1h77WS2aZCWiERxyM15r
         NHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688332494; x=1690924494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cN3JSQg0LROpUkwJ5OAt46ArJ76XLCWxuJ783Zv6aE=;
        b=GqJmIyhGMZ8z8u1Zehn43fvyn+C3Fe+Z1XvUlxpUrOiuEUl5xz0xZnpJEc7bOWveQr
         2eaZJWxKLsXf6QRc2yZj8wf8Kl9uboOAdn9V4eymKq9vM4CcZli6plo7Lgo7C9OsYOki
         cUNPs6m9C0Ha1FxqPO31v7Ic4/W+mVr+6xIINx9VdThaudr8p5SxhsI9fDUgW0MSR5FE
         mufHt9a0dyFw1fTgEZ3aORyZcyzdIBAQMhs24ahOG3kSVS2PfTBoA0fcVwQhwbLPEvT6
         pOkbG2CP4JenFzBWMhJ/AUu7e8HKgImVWT/EqVu1RU9KEo/9uHdKiqJtLuf0q4YN8/jc
         4GAQ==
X-Gm-Message-State: ABy/qLZfUT8AwPDJprChSZM7EWYMlGlOsNQpYeOhb8JxdCipxRTT7SfP
        KLq9Sgs+Ev2VSAz+QyvEJE4=
X-Google-Smtp-Source: APBJJlEO623g2YL+Etf09gJJ8RoSXjsIxGh2Un45Tya8tBOsXcBssWyK7ePBW1oLinExeAWuul/jQg==
X-Received: by 2002:a17:90b:350e:b0:260:ea8f:613d with SMTP id ls14-20020a17090b350e00b00260ea8f613dmr7140457pjb.20.1688332493730;
        Sun, 02 Jul 2023 14:14:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090a658700b00262eccfa29fsm11721292pjj.33.2023.07.02.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 14:14:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] checkpatch: Add old hwmon APIs to deprecated list
Date:   Sun,  2 Jul 2023 14:14:50 -0700
Message-Id: <20230702211450.3789779-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwmon_device_register() and [devm_]hwmon_device_register_with_groups()
have been deprecated. All hardware monitoring drivers should use
[devm_]hwmon_device_register_with_info() instead.

The problem with the old API functions is that they require sysfs attribute
handling in driver code. The new API handles sysfs attributes in the
hwmon core. Using the new API typically reduces driver code size by 20-40%.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7bfa4d39d17f..6d97f1a6028e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -842,6 +842,9 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
+	"hwmon_device_register"			=> "hwmon_device_register_with_info",
+	"hwmon_device_register_with_groups"	=> "hwmon_device_register_with_info",
+	"devm_hwmon_device_register_with_groups"=> "devm_hwmon_device_register_with_info",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.39.2

