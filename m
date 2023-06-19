Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5CF735AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjFSPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFSPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:10:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C3AD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5187aa18410so3682543a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187406; x=1689779406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snu+S5y4+SEbvZxuNqaJKxNoj771q1fsuo3zQR1oJlc=;
        b=XW/t5IoD5oqI+Vp+Gl3zbLsWvZdsIRxACNRjO6CSI8qrSw6uMY8OMl2ObU5ogfm8Jd
         kFPxcrhVvDpKqg8Oc4lHvP+UnbhL7iMvu7VNoj2QJcOF1J8OqILf24OKTsaKbt6HdcUA
         gBqWMDIusLDXq+qIhvHVgJPXrnxYmPHnZ4+p8JXaYIbZyxk4x9SgYUHiRU1RmujvhLRA
         Rcz9+E6LWceMrPFUru4iqnVJaokucWJzy6FgsiA0EdCcvklgV8J0k1BN2NTFYN+F6ydu
         zVLdWd4VL7wpKuSAuf7T3/xv+SXkLVSNEt2DFMtVIowRlb/JkhWhKGbG7+hTqX60zLOq
         QtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187406; x=1689779406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snu+S5y4+SEbvZxuNqaJKxNoj771q1fsuo3zQR1oJlc=;
        b=NVdavCN84Fd3p28SQvtX+MsTH6p7Ujbc0MgoCic/tQBHsGo8Yv5JSIGJH3M8svybxn
         3A/B/lakrIuN5/BdF6r3y/sRc7mGRsMpyC84Elx55Ach2SXk10CHv9xHnuvPijjXEKoi
         xx7b9G7xHlFRlwWonmZUuK5xLD9RRjPYrMpYU5XfqPyD+0BIYSqwVb4L4yd0K297+Icl
         2hgpiKitEpbz3k+heB6fgj9qkbHWCtxZMgnf/ZorubYGjgczgeUpUk+2afo3srYt4iV9
         K2/qHFwwPTKuly1eQE5MOajh/52ENgkxChTKdwIqqpwLvT9u3wkbOlXGka9CLFAfK3kD
         zCLw==
X-Gm-Message-State: AC+VfDzUHS6JuzGNlV0b4IuxYz/A5Z/1bttc26mXI0eCRzr0j7paljzQ
        67cpOI4VM8uHL3xMis0Fji9ewe19IKo=
X-Google-Smtp-Source: ACHHUZ6p1rzi/cv+fMtaGRWBi/CZoN77pk2/R0btD0J8YIKBkR21JIJ9whPigKMIpHXJff9kZtRl2A==
X-Received: by 2002:aa7:db89:0:b0:51a:265a:8fca with SMTP id u9-20020aa7db89000000b0051a265a8fcamr5143511edt.27.1687187405909;
        Mon, 19 Jun 2023 08:10:05 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbd5.dynamic.kabel-deutschland.de. [95.90.187.213])
        by smtp.gmail.com with ESMTPSA id p6-20020a056402044600b0050488d1d376sm13297186edw.0.2023.06.19.08.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:10:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8192e: remove return statement from void function
Date:   Mon, 19 Jun 2023 17:09:52 +0200
Message-ID: <20230619150953.22484-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619150953.22484-1-straube.linux@gmail.com>
References: <20230619150953.22484-1-straube.linux@gmail.com>
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

Remove unnecessary return statement from the void function
rtl92e_config_mac(). Issue found by checkpatch.

WARNING: void function return statements are not generally useful

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 24180670ea0b..b0857c5709dd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -268,7 +268,6 @@ void rtl92e_config_mac(struct net_device *dev)
 		rtl92e_set_bb_reg(dev, pdwArray[i], pdwArray[i + 1],
 				  pdwArray[i + 2]);
 	}
-	return;
 }
 
 static void _rtl92e_phy_config_bb(struct net_device *dev, u8 ConfigType)
-- 
2.41.0

