Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36736DA086
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjDFTBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbjDFTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:06 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E893D2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:01:01 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso20692805ile.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIaNzDoEfkQUCUs5a1+ah5UqZ1hq5cACYGIKF90PLWA=;
        b=G+FTw3D1oOQIjnAKB1cpn9CiPMPKCCFM4zdri/XtQJGkhM8ftL306NfOcRuhgBJwAT
         +mqD0LOE5YJzkUY6ePsFoGVjZiuuVZ9E2USexjk/EUU97k0/6RzsAAanDkVOThd1NSb/
         UHy8zFuNtffS3eWlDckeeAT9oCY7xDJSH2ttDYfw5Ys4YqfON7UCSPfniEHkJXIicK5X
         pym1+Tk0FtNI+3SFj6R7I0VHLqY1yU3s7SCpVrnruhY/CbD+oW8s5P5fV208J/K1wmOr
         VQqc6oZ6PtBD6O5hhHqZblnYB84HAIivUECRQzO7E8yY+rSsgFhBq+ttRv64b/8RpqGV
         7E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIaNzDoEfkQUCUs5a1+ah5UqZ1hq5cACYGIKF90PLWA=;
        b=ldmf2bixK4+UUaXaCC0/MwE8VAX1JwuImwpySQxxoMuxzRpq8ECZg1CSNBaok7+4Xl
         4lnPL+fcdlJ878d1GYJLTYQiBVIA0PG+ZVKpBKPX3P3/J67oAwbgLYSZ3wavXdlO6BWb
         JGyyzBX2jt/VAeQsgcC+f/MawebawFZsQU6j4r80PshOzrdUD2fa4YUfb05/GqIXTkTl
         0XDqcFFTjXKqxjyi2KwQ2AXNMPa+nKsq8mCvrN0V881crCeW8Y4KdxacEak9SQiEzAIn
         OhneT8xkG5tW0lUBwaDOl0goQHSd1pCizt0OfGSwl8tiRqLLrcMRrlONjnpADIKiSXLd
         M5nw==
X-Gm-Message-State: AAQBX9fz6BqXi8a3kmBAc0Lqv7zrDghxMi//koj6PkQi2a2tatT1qxG9
        zphz9dflw3csqJzxGUb/DLh1K+YnkXgvA4g=
X-Google-Smtp-Source: AKy350Z+5g/pbGkfqFeQV7zALWCzNXPo9m7bN766vJbNtaAOGFM9jzMpqoRBx0ByEqTie31Zw2uJvsgSxEzqmLQ=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:a10c:0:b0:405:8be:eaaa with SMTP id
 f12-20020a02a10c000000b0040508beeaaamr6056313jag.5.1680807660861; Thu, 06 Apr
 2023 12:01:00 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:22 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-4-allenwebb@google.com>
Subject: [PATCH v10 03/11] stmpe-spi: Fix MODULE_DEVICE_TABLE entries
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A one character difference in the name supplied to MODULE_DEVICE_TABLE
breaks compilation for STMPE_SPI after built-in modules can generate
match-id based module aliases. Since this wasn't being used before and
builtin aliases aren't needed in this case, remove it.

This was not caught earlier because STMPE_SPI can not be built as a
module and MODULE_DEVICE_TABLE is a no-op for built-in modules.

Fixes: e789995d5c61 ("mfd: Add support for STMPE SPI interface")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202212171140.NB93eVvI-lkp@intel.com/
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/mfd/stmpe-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index e9cbf33502b3..e9cb6a635472 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -129,7 +129,6 @@ static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, stmpe_id);
 
 static struct spi_driver stmpe_spi_driver = {
 	.driver = {
-- 
2.39.2

