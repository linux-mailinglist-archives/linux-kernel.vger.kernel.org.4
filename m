Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C9D5B330F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiIIJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiIIJJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:09:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41F237F9C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:09:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u6so1503376eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=u4h5rh1/7ebU+oz1gbKVh9qvXaWbHW7SaMiwSJOBlk8=;
        b=dF2+n+HrpcXh6mJROrascPsihmSVsPXZEH4nSJLfj6w4CSw5aSOG3YW8j/IzpHs2TM
         cTbkizNfGMT3s0GNOzrN/xA3h/0dgvXlE2s0HMfRJShPdaQ/woiVIk3nS93dxqX2ujl/
         GrDEBiRk9/JY6nGMxg2mbDqJCf7gbUwsamqDmF1kEl8+F4P+HeSdNp9mqgTadj9EkZTX
         +6rmlAjmBbKXmVNi/4AQ49R4sVAYti4LXbtPtiB4hYNHENdJ4SWISGQPsQzzDG296Xi4
         o7eodjtjZc4vOZCSQ4Q9brYf0KMuK4GNxqUxy1LWsqW8vm6tuFWjhwjQkFDfZlymlgNZ
         3Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=u4h5rh1/7ebU+oz1gbKVh9qvXaWbHW7SaMiwSJOBlk8=;
        b=NJwYjvDT1+bbENynCcHn1CyNxstzGQyc8Tv7PBE4pJbQ8QX/mm+C3psGqpUnr0n1ox
         zI/j/BqsdYRFGEAN2pRk+jvL6rE3C9+OZej46GYHRT586qykdcLhiImgkp7GDSZIKKA3
         7vUkfvH+biS8m/Kha0h6vRSGLFQACbTHci0NjGzakrEl7xsv9w46hcZkxAgCSQgGJaa1
         mxhk3OImud4wGzGhCKPRV6pfi14glU9TVMJGgs5PRae4JBpFBIuQYHPklP95g47AqYzy
         gWays8rv2P3nhjgwz8yHnbcjUfoEYqr1QrcKftxhTc+Fi2HIL+yBuoMwjUNi1RljNK99
         oByA==
X-Gm-Message-State: ACgBeo3HriwPPr36v4zO+LfzlUGinnoGSTlffErxTJBYLg0Se6rRVNZ5
        b28esmUNbnWiByU4MLVtpAs=
X-Google-Smtp-Source: AA6agR6U7CUlydBrgp8xw3+cbyHTg0d1YgbUdDrKtYpfDtOG4mLIi8J+rk4LB8PCsMUajANBZchlSA==
X-Received: by 2002:a05:6402:190d:b0:447:ed22:4d0d with SMTP id e13-20020a056402190d00b00447ed224d0dmr10808933edz.309.1662714588404;
        Fri, 09 Sep 2022 02:09:48 -0700 (PDT)
Received: from localhost.localdomain ([131.155.244.90])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7d594000000b0044e9a3690e0sm24001edq.9.2022.09.09.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:09:47 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: vt6655: use memset to make code clearer
Date:   Fri,  9 Sep 2022 11:08:57 +0200
Message-Id: <20220909090856.18427-1-namcaov@gmail.com>
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

A line of code sets the entire struct vnt_rdes0 to zero by treating it as
unsigned int. This works because sizeof(unsigned int) is equal to
sizeof(struct vnt_rdes0) (4 bytes). However it is not obvious what this
code is doing. Re-write this using memset to make the code clearer.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
v2: re-write commit message because previous message describes a
non-existent problem.

 drivers/staging/vt6655/device_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 8e2a976aaaad..a38657769c20 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -867,7 +867,7 @@ static bool device_alloc_rx_buf(struct vnt_private *priv,
 		return false;
 	}
 
-	*((unsigned int *)&rd->rd0) = 0; /* FIX cast */
+	memset((void *)&rd->rd0, 0, sizeof(rd->rd0));
 
 	rd->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
 	rd->rd0.owner = OWNED_BY_NIC;
-- 
2.25.1

