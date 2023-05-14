Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59071701D85
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbjENNCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbjENNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:02:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75D30CF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:02:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so7115351b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684069329; x=1686661329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRndM6dwLyg+CH40gLpw0L0oNCaMTsXiybvOzf1CBdM=;
        b=UOpBDf/UdqFprkz/RaGVHjIHh4ZVukFEER1c03onGY1QQrIksKTtlCedPjz3MGeWBW
         KE5nPnSo8fF/vUXXgNYlD9as/unN4tXAnt51PyM3TTV//0RNYGFeHFPdKuRhPD88bQOW
         Vw2HDSO4KPeSTXai3fv7kCPcEtZfiMyDpBnvFs/R2CZOZ9tccpwjBPndOBNkSF/A+TNr
         vjCFQV7OVn27eGIet6A0y1tk3TNxOXf+hnv6V2bUJt16hxQEVnL2dNCq1ev5kbL+wcqp
         5uWM6ucTKa1Zxh9+/JjOrPUojRHYtMp+QTptJEXCZjeAYVBRBZaNAJsHCRfD6/8+896R
         iYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684069329; x=1686661329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRndM6dwLyg+CH40gLpw0L0oNCaMTsXiybvOzf1CBdM=;
        b=cmZS31ywL5++xD+Mdx61/ryzcTdh7ayFHW3sI9itbYTVnfaNw0QB77faHobSk84bMa
         3H4MJ6WMW626wh/SHt79i5k9BNM8OKMMHB7DXxZH0hcHZzB9pBRty/N+yKIXNOQD67Ny
         NNFeTb546Wlp0VYckdBwQAFRQgrvsQelbkMGLmnjOjWZelKeX3XUcvejJYRh8UU8FVGj
         PlJomE5Jt768mWY5O0FEKxF6HnOhe1MTd9LxfuUpsxqxas7pSpDw1iFzN7bpLyZ6i5p0
         xUR5nm7sS73BsSUTUD8oXAevYVEmm3d183SMBt2YXlW6KIAn/iPrDyPJhc/Ws6Y89xEz
         LSIQ==
X-Gm-Message-State: AC+VfDyanTMMJqgzvCOGs2NrIzsP1kZ9rqHIXexprO495C0nYI5/c12y
        G62FdPwrcl9ZoMntY5lSeDKp0nIRkTPyGg==
X-Google-Smtp-Source: ACHHUZ5QJJrM45x8eaWbsW8g7uaVPN75hlKQ2lWbhMYHrZaQFam4iHhjYo8H5t0i31YWv9Nwg+KkyQ==
X-Received: by 2002:a05:6a20:c701:b0:ef:e589:28a3 with SMTP id hi1-20020a056a20c70100b000efe58928a3mr32710915pzb.16.1684069328625;
        Sun, 14 May 2023 06:02:08 -0700 (PDT)
Received: from redkillpc.. ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id e35-20020a635463000000b0051b70c8d446sm9766146pgm.73.2023.05.14.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 06:02:08 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        prathubaronia2011@gmail.com
Subject: [PATCH v2 2/2] axis-fifo: cleanup space issues with fops struct
Date:   Sun, 14 May 2023 18:31:48 +0530
Message-Id: <20230514130148.138624-3-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230514130148.138624-1-prathubaronia2011@gmail.com>
References: <2023051411-happier-mural-a8ef@gregkh>
 <20230514130148.138624-1-prathubaronia2011@gmail.com>
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

Add required spaces for proper formatting of fops members for better
readability.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7b3080202b31..2692fda89583 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -716,11 +716,11 @@ static int axis_fifo_close(struct inode *inod, struct file *f)
 }
 
 static const struct file_operations fops = {
-	.owner = THIS_MODULE,
-	.open = axis_fifo_open,
+	.owner   = THIS_MODULE,
+	.open    = axis_fifo_open,
 	.release = axis_fifo_close,
-	.read = axis_fifo_read,
-	.write = axis_fifo_write
+	.read    = axis_fifo_read,
+	.write   = axis_fifo_write
 };
 
 /* read named property from the device tree */
-- 
2.34.1

