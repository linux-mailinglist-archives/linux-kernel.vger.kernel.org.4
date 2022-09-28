Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804CC5EE2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiI1RXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiI1RX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:23:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151AF7FE60
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z2so18202730edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bAT4lI1cS6DeEw/8Q0cGUzgW7gwK5qXIMg6NrWzIWKo=;
        b=fEIfyz2lCaTo35Ue4OkF0Ce0XXDTMNKrW9uOD2H5Cn97v72XOAopWJnlWZxkrScF7d
         D1gfVWLXpX6mprk0QT7U0Y9ZfP2P5byBEQ32LQRkZYf/qDtSm4Rhhv50+gR8f68Yloue
         P6OJd3Ta24r6AREVrl6pKVKk8CfOvABnFByko0wbNtZgIg9EPm/Mr0pjBGWuL9QWoQfD
         r8sKcyhekFWOmI7Bag7qyThRdjrTXB7UhB97qCMr33ZoMFkw7rvZs3DxEGeWu9urmlJa
         JFMLNtGxIfqACdW/SXFNGNc5O6uVRS2m8mQJ/mePChfQ48grsZVQUTckhOhIxV9bHmxx
         UsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bAT4lI1cS6DeEw/8Q0cGUzgW7gwK5qXIMg6NrWzIWKo=;
        b=6naIbD4rIxaJACkjzPTXryUX5GkmllbuHq5lhwzUl0uCsUZ2SRlD/JFantSpEgcBMQ
         qcs4Xl9twBzN9/hWpU7yUhzJYEvc/2KptA4xSsn6SxIcjlDQyHvdt4cmrlm/albW4NNn
         mfXOo7qxLyTI+1O3M4qNGhW3A2NoKSp9IIdvDnX8isJw415rugfDs4q3u5du2HMQ711N
         uG4SMTjupZsrEyBuo1NSZlVr56W/qGvwQ8lcF/VdX+BfXA6REkGz9VI38ss2KO4PnvVp
         UdpdYJ0oD0ZgDsEIhihajZ8k5cM+NmbiDnhbKT3TYmeOVaVEraBrBzIs6XSWIpYb2k/E
         /WjQ==
X-Gm-Message-State: ACrzQf1pqakT4Zp6SvSQ02QEALZNGushAH/cKFIOL27raWLOWPYTTSrW
        vmcpXcKd3uyM3TTKxf1zW6I=
X-Google-Smtp-Source: AMsMyM7VZsEXH6/txaWqMLlbcIlXV7P46ZdA8KCN1Hlp0FtfoZLURwXphOhPimW+QJ1dy03zkv77nQ==
X-Received: by 2002:a05:6402:2694:b0:450:d537:f6d6 with SMTP id w20-20020a056402269400b00450d537f6d6mr35433802edd.344.1664385804315;
        Wed, 28 Sep 2022 10:23:24 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-158.ip.prioritytelecom.net. [217.105.46.158])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b007306a4ecc9dsm2725063ejc.18.2022.09.28.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:23:24 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     namcaov@gmail.com, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [RFC PATCH v2 1/4] staging: vt6655: remove redundant if condition
Date:   Wed, 28 Sep 2022 19:21:47 +0200
Message-Id: <6a4028a10308d3abcd31421a28e760fc3ca61a72.1664384503.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664384503.git.namcaov@gmail.com>
References: <cover.1664384503.git.namcaov@gmail.com>
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

The function vnt_receive_frame always returns true, so checking its
return value is redundant. Remove it.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 56c3cf3ba53d..21d10d9fde47 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -832,12 +832,12 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
 		if (!rd->rd_info->skb)
 			break;
 
-		if (vnt_receive_frame(priv, rd)) {
-			if (!device_alloc_rx_buf(priv, rd)) {
-				dev_err(&priv->pcid->dev,
-					"can not allocate rx buf\n");
-				break;
-			}
+		vnt_receive_frame(priv, rd);
+
+		if (!device_alloc_rx_buf(priv, rd)) {
+			dev_err(&priv->pcid->dev,
+				"can not allocate rx buf\n");
+			break;
 		}
 		rd->rd0.owner = OWNED_BY_NIC;
 	}
-- 
2.25.1

