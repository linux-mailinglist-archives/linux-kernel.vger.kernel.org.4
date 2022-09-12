Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A46C5B5ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiILRG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiILRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:06:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CA91A06C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:06:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u6so13726412eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qMeY1yK9xt3qfvVZVOO64vUAYBCOBsU2kKO+rqbtJOM=;
        b=op4pGo+GmxHAhLZiMhqd9rgPslgIzpjcCHV1nFu4/+3k8W/gZhfqc98AGy2UDlVw02
         HuMeuLpRwPUhl7IO2wvPJplgjCWlHfgA3mZwqUCPBoZm9sqlrpZ9HSNoQSPNjZavs9mg
         ycd9OUqyPaeRvFHtK5J35c5w0LnvaVc4qu3kNYgA+ogtPNiij9We5aI5pdFj6zyaXWy3
         9Ucl2hVQTUtlRwJqdgjix0C7lyc66bOvQ1oOykt26wFYu3k1EX8KyP8/a6lf/a1XOz2M
         Wcdzsh0HmLmnhC0wOy1PFTTCpPNVCYkGvgpIYQr/tOxdf19mQdm2YtM++1ohesiV922W
         RoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qMeY1yK9xt3qfvVZVOO64vUAYBCOBsU2kKO+rqbtJOM=;
        b=eUO9go2gIR6VTdqUTRiacFP9DQJTc2gTuHaRJCbGMQOC7QRHiFIIs9C0038jmxRcfi
         nCqTOgYf+cvmtdmuoFXNK6VpsZuYLlL/5+O5DBZ6KNxBWmnfGmFa3lmmc9BEVZXkJiDK
         3wJ0hY6b5qufBQgfPwXQD5ij1ZBKHyJuibHSZNL8WjUSiF/xWCPWbYCNdJm/HYzq57xR
         8FZhqlIntkXcJIMdKoCinU684EJUMDI78OJ1b1OF//oamGakSMjJXY7392MFvuvAu/qZ
         +2pDVJuO7Ky3bi0aGXrobcvSTvOtfOG5edWZK8ZNBiij8efNQDx42PeOsH7quUpOCXhg
         jALQ==
X-Gm-Message-State: ACgBeo2fpVecRlmJS8CuhNJ0fODE9P97Q6kqoV4TGiUzMGMx24KBwxU4
        0Tvraz6DvFBeySPFTMMFvRw=
X-Google-Smtp-Source: AA6agR6ai6q0lBtrf2qtpNH+yrd+VMoMDdPMY1TIROsatQVgH3Cij6SbX8W0jTVWRQ1EY/CjhiBTCw==
X-Received: by 2002:a05:6402:2905:b0:452:2604:ae96 with SMTP id ee5-20020a056402290500b004522604ae96mr1686754edb.31.1663002411405;
        Mon, 12 Sep 2022 10:06:51 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-43.ip.prioritytelecom.net. [217.105.46.43])
        by smtp.gmail.com with ESMTPSA id r6-20020a1709062cc600b007262a5e2204sm4711317ejr.153.2022.09.12.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 10:06:50 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, ji_hun.kim@samsung.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: vt6655: fix some erroneous memory clean-up loops
Date:   Mon, 12 Sep 2022 19:04:31 +0200
Message-Id: <20220912170429.29852-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some initialization functions of this driver, memory is allocated with
'i' acting as an index variable and increasing from 0. The commit in
"Fixes" introduces some clean-up codes in case of allocation failure,
which free memory in reverse order with 'i' decreasing to 0. However,
there are some problems:
  - The case i=0 is left out. Thus memory is leaked.
  - In case memory allocation fails right from the start, the memory
    freeing loops will start with i=-1 and invalid memory locations will
    be accessed.

One of these loops has been fixed in commit c8ff91535880 ("staging:
vt6655: fix potential memory leak"). Fix the remaining erroneous loops.

Link: https://lore.kernel.org/linux-staging/Yx9H1zSpxmNqx6Xc@kadam/
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 5341ee0adb17 ("staging: vt6655: check for memory allocation failures")
Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 04d737012cef..56c3cf3ba53d 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -631,7 +631,7 @@ static int device_init_rd0_ring(struct vnt_private *priv)
 	kfree(desc->rd_info);
 
 err_free_desc:
-	while (--i) {
+	while (i--) {
 		desc = &priv->aRD0Ring[i];
 		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
@@ -677,7 +677,7 @@ static int device_init_rd1_ring(struct vnt_private *priv)
 	kfree(desc->rd_info);
 
 err_free_desc:
-	while (--i) {
+	while (i--) {
 		desc = &priv->aRD1Ring[i];
 		device_free_rx_buf(priv, desc);
 		kfree(desc->rd_info);
@@ -782,7 +782,7 @@ static int device_init_td1_ring(struct vnt_private *priv)
 	return 0;
 
 err_free_desc:
-	while (--i) {
+	while (i--) {
 		desc = &priv->apTD1Rings[i];
 		kfree(desc->td_info);
 	}
-- 
2.25.1

