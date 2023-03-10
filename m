Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F4E6B4BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCJP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCJP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:57:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F644C02
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:51:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e13so5455721wro.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678463496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpuN32VQrGcv/3Pj2zsLc3BfvbthJh4eelemNP67L9M=;
        b=EjgPufN/cGkNJlNHqYKe7Dvb0DPZVDoUQfE7cCDnzHUy5HZaHZxrDsNAUzRwAQrUL1
         i/DNPGm/Z4VM2zl0DJ936UNJEm4qO2uunUmPxw1Nyw7k1nH3csue+QAqkTJEpKNjVkz9
         bvXQtggu+bIZZ7pQ8mJ0rhogOJBh0VB+3gWsZCxs6Q+SRxwk1t7O7yKKBso8Z2urhAKY
         l4dPXw9Hs8vlhZDQjL80h/uJmxsngN3bvRzX6UckLTmjoKUpiQSS0H0rCrrLZXHEHkGK
         JbKgtiuN6nx7pkcIsCSJYuZAlqSlBiDbrffsaUcMfe/uN00BL+S8+pRHWLGR8Aw4UuuQ
         AQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678463496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpuN32VQrGcv/3Pj2zsLc3BfvbthJh4eelemNP67L9M=;
        b=XNIGkaTNDZHuHmuY2SHDiyMcyxR/yfzwk8m/eUAKf8OZXzL5s8jGlvZeMN708tnGDV
         X2J990U+4VOHa44vzFqcSroQkcp+culeX12sCKTaahgJEUWkGWpUmn8Cf5v2t+WYbkMP
         OFLgFUoRaElGV/AH/ZsU0vmOQcDuUvnQgcIQ0+3gYOtQKJBAnTtVamjiN4iWt9AbbE5x
         dsGYCBQcv0j8H75P+RoGASJZoc7YC5O2DtxojoGPhYFa/ZT9wnKwUkTeGOAeeVowRTxh
         GZxLCPXV8umgis9kVOVwSiNiPFAH0rfH5ZHXDWmlLXNLz0wCovsmfilE2jKaQMDaubPZ
         Ubsw==
X-Gm-Message-State: AO0yUKV5R6LWztDm3eHfDljsY8/ShoWjEzTGGQOXdG1rnfABZemE2M+3
        BbhuyIipjPoTSbYtdVdHSHA=
X-Google-Smtp-Source: AK7set+aFnP5rMPRo/m99shb4IMy/aI/Wc8HeEJBX8YkAaBNdpjimiY4SO5S8m3LRlXa0ZEhtAJyTQ==
X-Received: by 2002:adf:ee8c:0:b0:2c7:9931:4f7d with SMTP id b12-20020adfee8c000000b002c799314f7dmr16660450wro.18.1678463496288;
        Fri, 10 Mar 2023 07:51:36 -0800 (PST)
Received: from alaa-emad.. ([41.42.191.171])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600001c800b002c7e1a39adcsm140139wrx.23.2023.03.10.07.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 07:51:35 -0800 (PST)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH 2/2] staging: greybus: Fix Alignment with parenthesis
Date:   Fri, 10 Mar 2023 17:51:25 +0200
Message-Id: <ccd27442c1ad9a33b0b7564176fa68f7b153fa20.1678462486.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
References: <b6521b9a75a4088d621246b436c7ec5d35365690.1678462486.git.eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix " CHECK: Alignment should match open parenthesis "
Reported by checkpath

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/fw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/fw-core.c b/drivers/staging/greybus/fw-core.c
index f562cb12d5ad..0fb15a60412f 100644
--- a/drivers/staging/greybus/fw-core.c
+++ b/drivers/staging/greybus/fw-core.c
@@ -110,7 +110,7 @@ static int gb_fw_core_probe(struct gb_bundle *bundle,
 			}
 
 			connection = gb_connection_create(bundle, cport_id,
-						gb_fw_download_request_handler);
+							  gb_fw_download_request_handler);
 			if (IS_ERR(connection)) {
 				dev_err(&bundle->dev, "failed to create download connection (%ld)\n",
 					PTR_ERR(connection));
-- 
2.34.1

