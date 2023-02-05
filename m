Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5C68AE05
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 03:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBECOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 21:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBECOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 21:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879291DB8D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 18:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675563200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ti8X/no/PUHL0AZuLXOo07rzpY67vV1fRdGL+Apgc10=;
        b=hZopKaUSCLL1eXgi0Gc/wbZjXiCGgLUpgtrWbPXjzYR5lkrEBSxCdzSgaQ2tpgwUGN5U46
        H09QxAvUgSxpPCYfRY8V9HN83dMfmzar8VMPdJr9aqcU1DuTJxZrQivta8RTJ2wuD8CPkr
        +HqM0d9Z+eA+Bepsle/NNsHHiKsYjdM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-q0djaynDMtSO7fDeGWLWyA-1; Sat, 04 Feb 2023 21:13:19 -0500
X-MC-Unique: q0djaynDMtSO7fDeGWLWyA-1
Received: by mail-qk1-f198.google.com with SMTP id g6-20020ae9e106000000b00720f9e6e3e2so5869534qkm.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 18:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti8X/no/PUHL0AZuLXOo07rzpY67vV1fRdGL+Apgc10=;
        b=lezg5yvfZcfFYnIGg3Kb3J2FB6eOP3q+lPiJ9SrMp/quFqRb2sV5LBMduzB6w6Do0w
         7PN89mcG/aXBa5yDMym9p9HFylIr5z18LNghm0zGeSdBqI4XFVjDJDx86MhnhxmFN+Dl
         i5vmqvbxT23UYEuDnTBEKbPWrNKEeqAE/0HJKo0Fg3f8hWc2C/qTJk5EcI6YlT/HKNTa
         leT65eoMTHsTyepR6PVa8V9/5PgjVZSb5eGz2TbwHvuESa8kAiTsdLqJekWC2iVhWLhY
         f9WgK1SWmnvJiHFScASXBibpYuTiZ4McwbeefPzU+Vjuum8gXKfe8LES2G49Dz8w+5bc
         HMRA==
X-Gm-Message-State: AO0yUKU9MngIJrFWcpq8wPIV+FWjhXjXVjiEf2xVfTAeTdGtE0EVazuL
        GCMQ8Gx3FogNFy+AqRn6McyqfUe9odJ9zHQ4+tqMsVjQWuzvzoSSODRklmYzuzPNSgsMZ1umTp2
        G280w7dsNHI1UUyOkaZn0yGSM
X-Received: by 2002:a05:622a:34e:b0:3b9:bda7:bfa7 with SMTP id r14-20020a05622a034e00b003b9bda7bfa7mr28226295qtw.40.1675563199075;
        Sat, 04 Feb 2023 18:13:19 -0800 (PST)
X-Google-Smtp-Source: AK7set9OkA10FCcupiaY4iiAdKXtqwaxPP+EiUcMzFKXACPqRgx3hajFPOHWvBbGXnWXABs0p0KGrw==
X-Received: by 2002:a05:622a:34e:b0:3b9:bda7:bfa7 with SMTP id r14-20020a05622a034e00b003b9bda7bfa7mr28226286qtw.40.1675563198864;
        Sat, 04 Feb 2023 18:13:18 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id y21-20020a05622a005500b003b9bb59543fsm4590130qtw.61.2023.02.04.18.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 18:13:18 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, liweilei@awinic.com, colin.i.king@gmail.com,
        wangweidong.a@awinic.com, zhaolei@awinic.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: codecs: aw88395: initialize cur_scene_id to 0
Date:   Sat,  4 Feb 2023 17:57:33 -0800
Message-Id: <20230205015733.1721009-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck reports
sound/soc/codecs/aw88395/aw88395_lib.c:789:6: error: Uninitialized variable: cur_scene_id [uninitvar]
 if (cur_scene_id == 0) {
     ^

Passing a garbage value to aw_dev_parse_data_by_sec_type_v1() will cause a crash
when the value is used as an array index.  This check assumes cur_scene_id is
initialized to 0, so initialize it to 0.

Fixes: 4345865b003b ("ASoC: codecs: ACF bin parsing and check library file for aw88395")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/codecs/aw88395/aw88395_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88395/aw88395_lib.c b/sound/soc/codecs/aw88395/aw88395_lib.c
index 64dde972f3f0..d7c31a202adc 100644
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@ -769,7 +769,7 @@ static int aw_dev_parse_dev_type_v1(struct aw_device *aw_dev,
 {
 	struct aw_cfg_dde_v1 *cfg_dde =
 		(struct aw_cfg_dde_v1 *)((char *)prof_hdr + prof_hdr->hdr_offset);
-	int cur_scene_id;
+	int cur_scene_id = 0;
 	unsigned int i;
 	int ret;
 
-- 
2.26.3

