Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D555B8770
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiINLpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiINLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:45:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4007A534;
        Wed, 14 Sep 2022 04:45:28 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id go34so34078610ejc.2;
        Wed, 14 Sep 2022 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tqexaluLS/Hq5ZzwKd1WjDvLB5oW63lsXWxKitTfWEY=;
        b=e4xd2M66zszVNq8YmhKpHY8ZIdggWgLbfc5+RKNcLpBcqRne9wONjDgqGeAXIV4tvi
         UcYIdX+gXb9er5DNXEOJ4cNwHjclfky5UUeY6t0b4JTaCZe30RN5/kDpi+57vi+IaxJF
         wF+4V8rA0UTeIiAKWDAz9/y2ZijXZMj2JmHgI6MB2Hn7aEFJPS3Jf6lsFtY5CnR7rGAy
         iKQ6FmtO6uluYaf1GyjRHwl+iS848EdYUkd341FMJZ6npE8esUsZ2hrQcvjfkL1zP6kr
         +icr5zLRrJkTl/RPKod+s60uj0LyXuYKP+K5YOa1u3EKnN8tGBZ9bkJdfgKeWB5YiLdQ
         ajJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tqexaluLS/Hq5ZzwKd1WjDvLB5oW63lsXWxKitTfWEY=;
        b=m81ZsXwANB8ebdA1UEZB1nqyE182biKH68WqvQhs1CR0Y4jXTeU3eZDix6YaMJzp+9
         +D6N+QJgDf5THV6wTCvN618G3We9QcfxjoLKyUZnfmMyPthJYpw1RlkeQCIpIAKZ9STt
         YHSO4TXwMFG23XoAnRZkXpGtjczjXw3BonD8uZHHfPM7WXR/EcOZAJyEyt2DeqfYhAgG
         TQdhwyhVCACE9a1RffE/oP6x2OsKJ+8VAFZD5pntO6Comr+OAZmuqonD0+ms7zJ4YZce
         YgLAXYX+yBsduYxnnYUMz6/2vAm8wiMW59TwTIYW340szuNihc8A9dVm/X67S1ojZ/Va
         XY+Q==
X-Gm-Message-State: ACgBeo00JZd7GqYNoVrEfadGn6QPzRvgJC7EW79kNzre2BXDGDL3K8KG
        gRa9CehTVQqnH2jXlzX/hLEde4o7Ntk=
X-Google-Smtp-Source: AA6agR5bobO1qpWSI/lhhlat3aOU3UPrDzSqMRRKib3ZWhPiGHcXh0AhJnqqCmKgV0G+xc/xY7GlmA==
X-Received: by 2002:a17:906:fe09:b0:77a:52b3:da5d with SMTP id wy9-20020a170906fe0900b0077a52b3da5dmr16260621ejb.57.1663155926452;
        Wed, 14 Sep 2022 04:45:26 -0700 (PDT)
Received: from fedora.localdomain ([87.116.166.59])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7d5cc000000b0044e937ddcabsm9593026eds.77.2022.09.14.04.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:45:26 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Fix Quadro fan speed offsets
Date:   Wed, 14 Sep 2022 13:43:27 +0200
Message-Id: <20220914114327.6941-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offsets for setting speeds of fans connected to Quadro are off by one.
Set them to their correct values.

The offsets as shown point to registers for setting the fan control mode,
which will be explored in future patches, but slipped in here. When
setting fan speeds, the resulting values were overlapping, which made the
fans still run in my initial testing.

Fixes: cdbe34da01e3 ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Quadro fan controller")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 3ea25edfc7a5..c51a2678f0eb 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -120,7 +120,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
 static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
 /* Fan speed registers in Quadro control report (from 0-100%) */
-static u16 quadro_ctrl_fan_offsets[] = { 0x36, 0x8b, 0xe0, 0x135 };
+static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 };
 
 /* Register offsets for the High Flow Next */
 #define HIGHFLOWNEXT_NUM_SENSORS	2
-- 
2.30.2

