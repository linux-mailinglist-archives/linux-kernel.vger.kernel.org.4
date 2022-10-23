Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B566095F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 22:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJWUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 16:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJWUFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 16:05:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D25C958
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:05:45 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso4774214pjc.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dikvD5+bFGXRs81xXMLBNykCJfKHBwW8mLASTTcU7RI=;
        b=X4PUWkNK4n5cSmNOGyD8vTdHmKfcZauPkHCbHfGV+Nl0zfx4vZ7cnd+oDJgjcBLzYk
         qJGASSSUnWtK5YM9ptAF27wAM7WlSNQg5Sdu7C2ALtGvBdfiO5sWtwgKkVm6runN99Eq
         qLIZFH98V0s8Ie+49BtQNMnzVCbOnCfZYaextdHe1tkx8Fe5gxFaE8mRTQbwevAF0gss
         gxl264F/JkhOrN6fxHMvwf12MKEzKVXhldzloLhFa19JIWAtgxFfOPuw3HQ+vHZ80YnM
         7vf4XdtSWM5lrR1MEGg7zGejes6obh/2AT+PDklrIYs8oxas6eQpAFAHRpQvMn9/tWRo
         zOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dikvD5+bFGXRs81xXMLBNykCJfKHBwW8mLASTTcU7RI=;
        b=LmmTInHCAqEZ/T0URqA7g+QM5ayE8nZINqUI4GgDgHlv4uyAaO3FrV0KFKPAUo4FTj
         mukc9Hw0hR4bh1CHD4ENbeKMdglbBcUUlrRbqmSYkI2YrEWsexyzfJcaAMCI5NgTuW8s
         QbOcQ8g+MrD4rLn3YvCNd4xyMOtycUR0KqP02G1SYxv0OHsmkf7UyCoNp55xiJ3N5vju
         MyLJeoQLhDRhKeJHxWveItQr7/ksrDYMOgdiAA7w1pK5joNbg7Nwf+81tHMybiQ2BFCm
         UUeMSk6WRgqN/Nl7Iv4wCcwyUotYs+LhMpLtNL+1Ckc/c/c7GwxTqTYAF8eG/C9k7s/g
         GAnQ==
X-Gm-Message-State: ACrzQf2WQDhCxMvnTapOyberEyakkV9xyIJVtthw81ffg9CkSmVDYYG3
        eioRpQ6GJnZbq7wEkA3Id9A=
X-Google-Smtp-Source: AMsMyM780ZAlIMSV2rF8AFs2dr7+bvZW21x/juZGL35aSK+7PEhPQ3AxZQQK6RL5KTW2hVCMTiRMrA==
X-Received: by 2002:a17:90b:390c:b0:20d:a662:dac2 with SMTP id ob12-20020a17090b390c00b0020da662dac2mr62645821pjb.5.1666555544569;
        Sun, 23 Oct 2022 13:05:44 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0056bc0578c7dsm1130649pfm.110.2022.10.23.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:05:44 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove unnecessary variable in ioctl_linux
Date:   Mon, 24 Oct 2022 05:05:29 +0900
Message-Id: <20221023200532.259276-2-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221023200532.259276-1-tegongkang@gmail.com>
References: <20221023200532.259276-1-tegongkang@gmail.com>
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

Returning value 0 directly instead of storing it in variable ret.
This commit can prevent cocci warning as follows:

  Unneeded variable: "ret". Return "0" on line 3030

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 2de2e1e32738..5e1ad7733127 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2979,8 +2979,6 @@ static int rtw_p2p_set(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
 	} else if (!memcmp(extra, "setDN =", 6)) {
@@ -3027,7 +3025,7 @@ static int rtw_p2p_set(struct net_device *dev,
 		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int rtw_p2p_get2(struct net_device *dev,
-- 
2.34.1

