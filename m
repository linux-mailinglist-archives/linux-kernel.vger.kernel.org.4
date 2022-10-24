Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21A360AF31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJXPjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiJXPis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:38:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131136422;
        Mon, 24 Oct 2022 07:27:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z14so3013246wrn.7;
        Mon, 24 Oct 2022 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PhUxSjTWxhyhzoVN8CjeIVwED4ZtcdgKG/cY+s+iZJY=;
        b=mt6091jjQZfb8b+bV3hD5cmriQUm0Fvq6TbPxfxdXdDN8lUmwjUxMjxpjyMqoFJSuj
         01oDJyceoEPr1mT3oiB2iD+ThpDN2CrFakO1Dd9MYcCg0Ue7VaV0WiF+dFJJyNCNan1t
         v1EYN1CyS0Hbv6SR+622XhyBaXOLao5CX36W4t6F0NPAJ5FNtj/aW6YoX+sfr67yLhWq
         BithXtPwSslxzzdZXdP7PmRThuR9bhhfp2F+mlPtnFhBeTJiYv8ouUbqUmxFp+C/N2RB
         mSFHSFHsASQxwkumtlJfWFF23lLc8v5cvHufju3nBavN9AswLGvxBxF3eVswzmMW9Oxu
         eu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhUxSjTWxhyhzoVN8CjeIVwED4ZtcdgKG/cY+s+iZJY=;
        b=p9nhVQzdOEtLiP6aZNoIBsvYgqnNm3moQP5tmqT4MwtLk6adUVZG+ihkswOjah9aKs
         DwibsOsW9FA+OfiSNnq1jRFFDjMbzdNQcTTyvFOoiaSt2Idd12hr4UNmVoPHmVnbXeyb
         LEnZTdI44HJFbMrpmHInKO3acaiEXpZDbT8BHNfemsT4c2tTILEfo9HX7/hVKQ5Ojv+1
         I3WMXiJ7QNvbbHw2himaloaJ0SPX3h0slqAgqSFS3VAHYX8KVf60RfNYjLwBxtsXtX3i
         J/D1AaasqvhuUGQACKodQZ0N0UCYHExPtY2T9RXWyASegGBo4CCGTkJqKtId7gy8wUsc
         Prlw==
X-Gm-Message-State: ACrzQf09D8vOv8UODnA6yEgPz8LfjXLqzEU5U0ZbNCzSLNkWqUjZW5Y/
        WZVp2I7EzFdt9p29hZY1uwXS1RI+deWdH3P/
X-Google-Smtp-Source: AMsMyM44vMoE3Dmn/VvKNqaYOPK26ElVURH8dDmfTZHmdTukOfAed3ywyx3xGCAIAlNTgJJYqYbb8A==
X-Received: by 2002:a5d:6d89:0:b0:236:6e52:4fa with SMTP id l9-20020a5d6d89000000b002366e5204famr4820402wrs.395.1666620662901;
        Mon, 24 Oct 2022 07:11:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f8-20020a0560001b0800b0023677fd2657sm1551414wrz.52.2022.10.24.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 07:11:02 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: nsp_cs: remove variable i
Date:   Mon, 24 Oct 2022 15:11:01 +0100
Message-Id: <20221024141101.2161167-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable i is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/pcmcia/nsp_cs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 48acab03a8a0..a5a1406a2bde 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -450,8 +450,6 @@ static int nsp_analyze_sdtr(struct scsi_cmnd *SCpnt)
 	sync_data	      *sync   = &(data->Sync[target]);
 	struct nsp_sync_table *sync_table;
 	unsigned int	       period, offset;
-	int		       i;
-
 
 	nsp_dbg(NSP_DEBUG_SYNC, "in");
 
@@ -466,7 +464,7 @@ static int nsp_analyze_sdtr(struct scsi_cmnd *SCpnt)
 		sync_table = nsp_sync_table_40M;
 	}
 
-	for ( i = 0; sync_table->max_period != 0; i++, sync_table++) {
+	for (; sync_table->max_period != 0; sync_table++) {
 		if ( period >= sync_table->min_period &&
 		     period <= sync_table->max_period	 ) {
 			break;
-- 
2.37.3

