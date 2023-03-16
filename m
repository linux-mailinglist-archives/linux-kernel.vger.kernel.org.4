Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974166BDD15
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCPXlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCPXlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:41:02 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7E0B5B7D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:40:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o14so1569301ioa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremypeper-com.20210112.gappssmtp.com; s=20210112; t=1679010024;
        h=content-transfer-encoding:signed-off-by:mime-version:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oh1TRZbPC7Q3T5uoGQy7dy839+/pV/CuFAlUjNAFOKk=;
        b=L0JHsT8B+8MwvL6ehQF9gZ06tMxT2oTcj2vk8am24w86mZISFIqh6hRrP5TyXOHB6a
         iQ6SWJOx672gbxkmkcmQAOFbF9ul17V+o4ZxQ1MNbfSS3htq0KiBCVNbZwt4wgMdV7cn
         lT0v+XtoSqqwcCSYNt9S5Lrab/vL6klqrBgtlGvwjlxcaXDbtOsSJT5FEDS3XahDb/N1
         tqh6iWGCIaaK9H58YVai4DxA9St6VPQ2BTrLJc0Dh7Nef//yMqeBJ5XDsxaXryAgm2FG
         zbd/oiIOsjOLEtoqJtbGptajev8sgXv2Y15JAGPZo20/kZSD4iYovqkcd7N6etWEu4FN
         8gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010024;
        h=content-transfer-encoding:signed-off-by:mime-version:message-id
         :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh1TRZbPC7Q3T5uoGQy7dy839+/pV/CuFAlUjNAFOKk=;
        b=b7/svwVnfIG8/MmfP4+aqyblHiZJg7CUZqLis/5xsXZ7W+kXTplVo/mkV2fMxXx6p3
         ELc0yxGS74U0k7/JvzY2/ykl43v7/NmfSeb8klK4JkOkGBF8lJW1vNSwhj+jxUQRGKDJ
         d0Cm8ZFG+iTRY+Z38w911DVABzOFeijqZiEPxsccidNkYiUak2ft9fjp2HPL/FiODdKR
         h3+pNrdnAU3oP5PfPVRBq2ptsjJuG70q6mNSs2uTYbL2J/6WfwNbvI1vsvHUQ6Y30kJU
         KHF8C/kTU0kINm5u8oHBUQUPjWXhU9KYPHQwc7KJs7KnFcrVwuU6jyfXgZW2cwQQaHLO
         kdJw==
X-Gm-Message-State: AO0yUKVdQT3m/u/j9ImNGt2qjy1z6rw4TtuA2T8aBSx4fqNp7fzkvbp/
        OFkokY7fqld1tTFbUY6Wrh4ZFJdW/kZTFxh17eY=
X-Google-Smtp-Source: AK7set+l79aV0RT51F4N5whoaabgqgUJ26Ea50eGaFi5PLYuci8JUSqIIIO36BA17MJRqqvxWUIqeg==
X-Received: by 2002:a5e:9812:0:b0:74c:a9a5:2c41 with SMTP id s18-20020a5e9812000000b0074ca9a52c41mr614339ioj.2.1679010024517;
        Thu, 16 Mar 2023 16:40:24 -0700 (PDT)
Received: from earth (70-59-64-215.mpls.qwest.net. [70.59.64.215])
        by smtp.gmail.com with ESMTPSA id b5-20020a5ea705000000b00753507c82bfsm129028iod.55.2023.03.16.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:40:23 -0700 (PDT)
From:   1000001101000 <systemalerts@jeremypeper.com>
X-Google-Original-From: 1000001101000 <1000001101000@earth>
Received: by earth (Postfix, from userid 1000)
        id CFC4010601D2; Thu, 16 Mar 2023 18:40:22 -0500 (CDT)
To:     linux-kernel@vger.kernel.org, arnd@kernel.org
Cc:     "Jeremy J . Peper" <jeremy@jeremypeper.com>
Subject: [PATCH 1/3] set the correct driver for the i2c RTC
Date:   Thu, 16 Mar 2023 18:40:07 -0500
Message-Id: <20230316234009.2115005-1-user@earth>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Signed-off-by: Jeremy J. Peper <jeremy@jeremypeper.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy J. Peper <jeremy@jeremypeper.com>

---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 383dc6eab..c3f6dc351 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -39,7 +39,7 @@ static struct mv_sata_platform_data db78x00_sata_data = {
 };
 
 static struct i2c_board_info __initdata db78x00_i2c_rtc = {
-	I2C_BOARD_INFO("ds1338", 0x68),
+	I2C_BOARD_INFO("rs5c372a", 0x32),
 };
 
 
-- 
2.30.2

