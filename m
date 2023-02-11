Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA716931FA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBKP3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A866234D1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676129345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vnewwx5BEEx6q0ZK/xXbQu7RnpiAewRN9TE3zelH0io=;
        b=iL7c7usIa++zXfpukecc8MN9yI59LoHQ4DvXFoJz0NkTLBduR6NA25eVHJ2Myz1gMQiWCt
        Rs6qNXuABJdJoueS/VO4HuG0xcyCgY6FYLt6eSZGRLJto6Tjr266gejzTaO4mHwkM1HX5H
        VKAnehzWJOB0Mu2RIyU4PYxbmeb1c74=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-349-DBGvvWs6M36Ob6QDPtgnDA-1; Sat, 11 Feb 2023 10:29:03 -0500
X-MC-Unique: DBGvvWs6M36Ob6QDPtgnDA-1
Received: by mail-qk1-f199.google.com with SMTP id q21-20020a05620a0d9500b0070572ccdbf9so5139920qkl.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnewwx5BEEx6q0ZK/xXbQu7RnpiAewRN9TE3zelH0io=;
        b=XgwU/d9pGJlJlqmqlJD7VwaA6Nzko7w39MieBqMFqd/BgN8Yjrn8Uzpt6gUYtyVWw+
         6yL/BIzVP9upJTIISuQfBXvzaUVBt+1u3sDFnJHiaOJOojLHv79TNmSbodKr5GWwoy8T
         nwm9Hf5EY5A6NLYcrKDo/2lHcifS4uevAUhXl2TEVttUha9IxxKdGur67X1YpjjkWjYL
         ewUMJ5j2ar3v3lBIzAF0Cn7VPHlgAX8AVrnFAt95Pv+Q4G57KzwNGc0+ZknwsSYpCR1L
         +z4woNE9jcpEj+w8PEqptLKr2yY9CBs6KdhhHB5shgWjzeIygnvq9sPCIHrHKF6mfcXX
         2u5Q==
X-Gm-Message-State: AO0yUKWPZU899gP45cy8XAWlkVSsshtF/KO45M6JxGCxCpu8j5G/X+TZ
        4KVRVB8E07AxRLSeFPK/fRWSwbchN6KNDzwcyqw8lfspvhL5JvnA8Z/tUjq5pGDfUsTt5tF4l8n
        61/k1VKeEthY90sK+CuS2Vo5S
X-Received: by 2002:a05:6214:19ec:b0:56e:9cf7:770e with SMTP id q12-20020a05621419ec00b0056e9cf7770emr4878170qvc.38.1676129343066;
        Sat, 11 Feb 2023 07:29:03 -0800 (PST)
X-Google-Smtp-Source: AK7set+laBPz4EUeiyMJzQAIrxTFZNbvmVxan4PQhSxa+Fh3lCfCJDceEIUr3+ynEqcHI9SLUJTjmA==
X-Received: by 2002:a05:6214:19ec:b0:56e:9cf7:770e with SMTP id q12-20020a05621419ec00b0056e9cf7770emr4878147qvc.38.1676129342855;
        Sat, 11 Feb 2023 07:29:02 -0800 (PST)
Received: from borg.redhat.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 9-20020a05620a048900b006fec1c0754csm5830350qkr.87.2023.02.11.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 07:29:02 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        dragan.m.cvetic@gmail.com, wjsota@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] staging: rtl8192e: set dm_rx_path_sel_table storage-class-specifier to static
Date:   Sat, 11 Feb 2023 07:28:56 -0800
Message-Id: <20230211152856.2129062-1-trix@redhat.com>
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

smatch reports
drivers/staging/rtl8192e/rtl8192e/rtl_dm.c:147:21:
  warning: symbol 'dm_rx_path_sel_table' was not declared. Should it be static?

dm_rx_path_sel_table is only used in rtl_dm.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index d8455b23e555..3bc5dabf2e2c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 /*------------------------Define global variable-----------------------------*/
 struct dig_t dm_digtable;
 
-struct drx_path_sel dm_rx_path_sel_table;
+static struct drx_path_sel dm_rx_path_sel_table;
 /*------------------------Define global variable-----------------------------*/
 
 
-- 
2.26.3

