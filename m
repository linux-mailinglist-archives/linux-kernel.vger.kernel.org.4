Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D2C706105
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEQHWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjEQHVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:21:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C74F1727;
        Wed, 17 May 2023 00:21:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so355041a12.3;
        Wed, 17 May 2023 00:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684308107; x=1686900107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS1Na/akbxcwCBviSJ46uyRelYEV2u7/1Oj5iI8pDZU=;
        b=DHkEdXATNviXY3mYKfPgC2QKdgu3cRWMZnopSMkj0ila7020sxn+b2cnNRskmpAbZo
         3OBqnhqMWEccG4TcmCA0wwS/h/T5C8k+Tzcl1N55uGuSAjZsScJUIeJZUktT9PdiUuI6
         U7v/XeLVWzyU2pmH150DqEQw/kSLW2jiMSHB6ZchU3r1tVd8tFyPap7funYDjIcLS18K
         MUZ2MQcOLOrYFPN0sHTvmCQk5CUuzxfQkxWEDROo7cEOmDhsKjJ9BE5nOJf33OVIUmfC
         JDCEBaEFOOpBrh+aiZ0THMaqPWH8kTOhVbHTGuK+sCxbzKUPJjDzZTI+eZuoDIvjIWgQ
         Yimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684308107; x=1686900107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS1Na/akbxcwCBviSJ46uyRelYEV2u7/1Oj5iI8pDZU=;
        b=PdQ3qd5/MuI7uSjvZE9ldbAoSwDsxRUCWV9M42app+SflENfwWVAw6beMPSNtHNEra
         qO2Thdo6gSGnJDMdTXBb1NiVDoKuDIqkRGCmJW2D4lUSXcQiYWh0umUcb1z/E3tN8H4P
         JDCWQrGr9UoanPqRwCx9FASZJbg3NWj67Hi9Unr2lbbwzTPpnMZZ3VOz8aDR0IkvX5YX
         w40LOiDTXe3w05hwqg8OqUiqA0D8z5vs86z/VVGFlgICf35V+KMUCZt6t4H6uQ7B0zKo
         hSknUiOmsXg+jG9puKPwcSNG3hRc45GgCHcqMR1o4zeksonroQEDUZOGYvQixlokehL4
         xqZQ==
X-Gm-Message-State: AC+VfDyHfEtjZqlYTcIs71piSMQHzv4t9kYwf7j9CrLcN2hnWAzT6Ycr
        PU8FN3kEhvIxD/wSqIEup2I=
X-Google-Smtp-Source: ACHHUZ5i+90PE5P+soAQjoR6R62SXEFnC71GiDKChwBtnvPTH12pwILXHueF3vQtLbKwuoEBFexfVw==
X-Received: by 2002:a17:903:1c2:b0:1ac:94b3:3aaa with SMTP id e2-20020a17090301c200b001ac94b33aaamr36314210plh.6.1684308106760;
        Wed, 17 May 2023 00:21:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b0019309be03e7sm16712947plg.66.2023.05.17.00.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:21:46 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 26ABA1061C6; Wed, 17 May 2023 14:21:43 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Watchdog Drivers <linux-watchdog@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrey Panin <pazke@donpac.ru>
Subject: [PATCH 2/2] watchdog: ibmasr: Replace GPL license notice with SPDX identifier
Date:   Wed, 17 May 2023 14:21:40 +0700
Message-Id: <20230517072140.1086660-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517072140.1086660-1-bagasdotme@gmail.com>
References: <20230517072140.1086660-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=bagasdotme@gmail.com; h=from:subject; bh=Y1QNbQK3xjZdpu9JwvlhnKA2/0o+9myq3T+4p7KyICk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpDS2yOZKsmrY1a36VFv7V38oamtUi88HoheWe9da2N 5ilXxzuKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwESC3Bl+sySnPMppygxd/fOc 0DGHEAu+F9d9c+zq0ifqfP9+Qk4qkJFh/i2JhiT1VQoL9E2f74xRXbvn2FnN/enRc5zXcxyVych mAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unversioned GPL license notice with appropriate SPDX license
identifier, which is GPL 1.0+.

Cc: Andrey Panin <pazke@donpac.ru>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/watchdog/ibmasr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index 4a22fe15208630..6955c693b5fd00 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-1.0+
 /*
  * IBM Automatic Server Restart driver.
  *
@@ -6,8 +7,6 @@
  * Based on driver written by Pete Reynolds.
  * Copyright (c) IBM Corporation, 1998-2004.
  *
- * This software may be used and distributed according to the terms
- * of the GNU Public License, incorporated herein by reference.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
An old man doll... just what I always wanted! - Clara

