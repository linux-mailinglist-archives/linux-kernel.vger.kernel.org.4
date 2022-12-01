Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100A663F759
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLASQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiLASPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:15:48 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A2555C98
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:15:45 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id u10so1894626qvp.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=5PgqwlpfigOiJb+R6DBfN2Y+9M3plGn2cvcFk1q1idotxQqKkOrHK0SkEt2LX5Shny
         dg2FU1+jL3L44XsAU66mjo5stS3NmB9Iwpkkuk79rEdcNYkTIHAz++0JNbHh2CpdJTln
         mC2cKv7jG0a+94XWljJkftKcT5bYlaISFmWePF1nPtobCPxD2qpIvWx+sQYrBgk8nHFH
         pYPgp4IUNehXtKWkTOFTu9HpVjFWj4Gx6m3WWGcaEdBrnMRmysCSJZkbGlKUgyV/V4Ct
         LOHU63gedLyv18jT7qn/ArIda/DjU96SEZfNMkgnd3KY5PCVrH4i5PWQK2tNNnUY/GCv
         0LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFCBGy/PHSqulvVt1jN7WYpo1L/uAw3+z6frKWBhRoc=;
        b=yf84UaXOeAgZXiDOqBGCHr4hVWGqtd5Yo6fx44EEv0fXkrTILca7yXyOw6Doez5cxt
         6oFYZpC6hj21HgWDCbC1lpnNUMTR3TcakO4R48Dtalfql+P/sWkcFhKHHDXKvUw/8cg8
         SRpWzkPvqBzAUni0FMTc6fgTlqUnCNJYAIdUrPcjbsyeTcjVRUujSCITdu6m4ZHNI1F9
         V6hHK+DrCcSVBWA1CHbskKlTJNm21AC/NF9AHf4sSjPKMtS9S7QcvGSUWyuypCweZ9pV
         ntEx1ODV2WI8XkgQN5c2hF5f3vV646CNmgTTU9TQg9dX3qONlwuAbQtEBwjS0PXy6CvW
         f6Lw==
X-Gm-Message-State: ANoB5pnhSdsatHW4vl4zSPT55McwFa1NjalZkXdyYgXZJMYyxJgdDqxZ
        zdJ1q0eWCwYxgWSZz0whmaui7g==
X-Google-Smtp-Source: AA0mqf4RRVlUXmmFLCa0Fz6p7Ui5DTW9XDLrG2IJ35rybH3l1vfNXfWV+0JDCVGQqW36DNkNulQwxA==
X-Received: by 2002:a05:6214:3113:b0:4bb:7436:49de with SMTP id ks19-20020a056214311300b004bb743649demr42952713qvb.27.1669918544609;
        Thu, 01 Dec 2022 10:15:44 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8464c000000b003a55fe9f352sm2908912qto.64.2022.12.01.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:15:44 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with new octal modes as per JEDEC JESD216F
Date:   Thu,  1 Dec 2022 13:15:30 -0500
Message-Id: <20221201181532.255449-2-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201181532.255449-1-nathan.morrison@timesys.com>
References: <20221201181532.255449-1-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the new bit fields for
reading: 1S-1S-8S, 1S-8S-8S, 1D-8D-8D
programming: 1S-1S-8S, 1S-8S-8S

Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---
 drivers/mtd/spi-nor/sfdp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 2257f1b4c2e2..e4e87815ba94 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -953,11 +953,16 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ SNOR_HWCAPS_READ_1_1_1_DTR,	BIT(13) },
 		{ SNOR_HWCAPS_READ_1_2_2_DTR,	BIT(14) },
 		{ SNOR_HWCAPS_READ_1_4_4_DTR,	BIT(15) },
+		{ SNOR_HWCAPS_READ_1_1_8,       BIT(20) },
+		{ SNOR_HWCAPS_READ_1_8_8,       BIT(21) },
+		{ SNOR_HWCAPS_READ_1_8_8_DTR,   BIT(22) },
 	};
 	static const struct sfdp_4bait programs[] = {
 		{ SNOR_HWCAPS_PP,		BIT(6) },
 		{ SNOR_HWCAPS_PP_1_1_4,		BIT(7) },
 		{ SNOR_HWCAPS_PP_1_4_4,		BIT(8) },
+		{ SNOR_HWCAPS_PP_1_1_8,         BIT(23) },
+		{ SNOR_HWCAPS_PP_1_8_8,         BIT(24) },
 	};
 	static const struct sfdp_4bait erases[SNOR_ERASE_TYPE_MAX] = {
 		{ 0u /* not used */,		BIT(9) },
-- 
2.30.2

