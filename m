Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70B7626020
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiKKRJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiKKRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:08:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B4410C5;
        Fri, 11 Nov 2022 09:08:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t4so3275247wmj.5;
        Fri, 11 Nov 2022 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IWLrD4C46aKmQaLw0mo+60fQZJP9UtxE6QzQixWpf0=;
        b=Rg7o/CAwJNOUBY+WgCJx82bsbnycLUEJXepv4OfsHgtFrGyVLodrTz5vwPK6SuAdgI
         KuUyvVDND9kjb2Ri87mvmCkF0RxUiYj9RTDxJR/p09+Qq2CQVZswlyjVZC4Qlx5MTTIy
         EXptI8ZfrzP2uj/N6IsLkJBllo7BdpvekfN3ufwaOYCNEBn7E40DdHAHBf1/yIMvcl8Z
         3N/dEQ9QomhQRIvfinUkPGMwUTa4jKPS/HgjE3xl/4PcTeUBIWCwqqUte01lYhk60djL
         DWHyWSqKW1HjhgtDcvjGccp3KReIzrAAzq6rGUuRnnAfrFi36x6oXzExcuksltFgiRmo
         7wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IWLrD4C46aKmQaLw0mo+60fQZJP9UtxE6QzQixWpf0=;
        b=j6NxtPRW2svn0bV4O6d1DbfRXGN5RVR7An2c4zBnlnhUMU8/jE1Hd0qnCzWETewh4d
         hFQh/BP6d0c5bmGh7tu0h6J+9Ax61UcXvdmN/h8jKhE3lDKAfYI9rniw55K0t/l4liUC
         ymXYGBDBvmeoZ3pVyHdkLCd5uiCZNl3O5FCue9utd2KW4fcKGxHMmGVsjGMGfChr9fTe
         EMjnZiUizlejWhxYGbwr69qdoN5frzA7qTIxCckZfTKp8JE9M/ZQiENSuqHumuinb3mX
         +H8QKIo0lyD2NsOgTNecGo1Z11Q6FXI/WIU3DSbXsINoqNlyrNEsjt2RC4S7S6fZU4U9
         r2AA==
X-Gm-Message-State: ANoB5pl7mr1Wc+m4Jm7LKy8TkdCRaAcJ6jyOBC4obU32g2+DRu0w1ofE
        dYAPvwNNu47WhejPNNZEU8o=
X-Google-Smtp-Source: AA0mqf4LJMTdCQTNJbQup7NUSrFUhZdGqyD1CMJTEdnoMr2UPl9V0WxOXCDwQkEkDM3yBCkDpIOkAw==
X-Received: by 2002:a05:600c:3489:b0:3cf:8731:8110 with SMTP id a9-20020a05600c348900b003cf87318110mr1998435wmq.32.1668186505245;
        Fri, 11 Nov 2022 09:08:25 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f7-20020adfe907000000b0023677081f3asm2322425wrm.42.2022.11.11.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:08:24 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libfc: remove redundant variable ev_qual
Date:   Fri, 11 Nov 2022 17:08:24 +0000
Message-Id: <20221111170824.558250-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Variable ev_qual is being assigned and modified but the end result
is never used. The variable is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/libfc/fc_disc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 942fc60f7c21..0f32ded246d0 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -75,7 +75,6 @@ static void fc_disc_recv_rscn_req(struct fc_disc *disc, struct fc_frame *fp)
 	struct fc_seq_els_data rjt_data;
 	unsigned int len;
 	int redisc = 0;
-	enum fc_els_rscn_ev_qual ev_qual;
 	enum fc_els_rscn_addr_fmt fmt;
 	LIST_HEAD(disc_ports);
 	struct fc_disc_port *dp, *next;
@@ -107,8 +106,6 @@ static void fc_disc_recv_rscn_req(struct fc_disc *disc, struct fc_frame *fp)
 		goto reject;
 
 	for (pp = (void *)(rp + 1); len > 0; len -= sizeof(*pp), pp++) {
-		ev_qual = pp->rscn_page_flags >> ELS_RSCN_EV_QUAL_BIT;
-		ev_qual &= ELS_RSCN_EV_QUAL_MASK;
 		fmt = pp->rscn_page_flags >> ELS_RSCN_ADDR_FMT_BIT;
 		fmt &= ELS_RSCN_ADDR_FMT_MASK;
 		/*
-- 
2.38.1

