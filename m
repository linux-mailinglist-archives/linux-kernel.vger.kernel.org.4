Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52F05B3950
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiIINlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiIINkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:40:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8437677C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:40:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so2776016wrp.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A2vhTeSsXsSpvIFbaQHwGbbYM6Th28pyGCc3psxMXmc=;
        b=XR7NAc8n9CgaS6sCrLfbov4akqFTHC5omKNkd/BEDFCM0i4/j9XPRZtsLVlyvx69K6
         MjiAi93VLDlJqnckjPROM1V2RzAwLqO4xswUF7RyH7cN3xz7GmkXsXR9V3oHiHkZKZtz
         OB9WFJH0y1kafTV8p3F7mNwZtsmHDdg5ID7nhGHbo4hpPn5Cv37Gs1igvFFoyxOtz6Z/
         iMtzjzEyVDpy8ou5QPL60N3+ahKEaPGa1Px3GnHCz63EUuuO64bMg8rlscbFEFpybhxl
         n61rBMtaoNbhNTAEiHs/2VVKCdFou5Hh9rQ8vMPkYHtopGfCoj/DF/fBMTUBizTKzwoy
         W8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A2vhTeSsXsSpvIFbaQHwGbbYM6Th28pyGCc3psxMXmc=;
        b=GUdYBrlDPTcvcF1RsYtyYRiQ2WRSqItTX6acv7ks6bvJ2/wAq1C+PeKDK4CeqDfOPP
         85GrIaNmji+jFCT9YfAmx1u3d0PY/NqT3ufiISqil8MUUM/DOwvLS4kgUGsI+EYxxU00
         NpGGg/DVFibWJ3PnTpMb8DGvKOuPJq8/eYcHbTZ6F6Axvk+9gC5rncjI+azJx2dkcsYA
         /Hrd+I3zRgQOUsC9f9gSHKMZLDq9ddyOZOyOMOKBnYal3fO8+F3EdQgK0fiMTRKEac/8
         PByX2QVMrEVspZKjg9pYx0YiWVMJs16AqLKzCipjFK2ZZo0RvkHrksVCWMZbhnm68VG5
         Xwgg==
X-Gm-Message-State: ACgBeo26xx9BANch0OjIJMD5HFOaQ8ZCvKgsUxdX8DqwqeXBsjY7R+lB
        Q0Jiy+9NoUDYUzyGJit3faV0BA==
X-Google-Smtp-Source: AA6agR4kPNM0GYa6gXcrF6Yjed6kNntcbjOyb0jw5UILcGful/yTZPxtwiQrdMoXlbpG2YzXJDbNhw==
X-Received: by 2002:adf:ec03:0:b0:228:76bd:76fc with SMTP id x3-20020adfec03000000b0022876bd76fcmr8067368wrn.533.1662730838811;
        Fri, 09 Sep 2022 06:40:38 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003a604a29a34sm660622wmq.35.2022.09.09.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:40:38 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 01/10] misc: fastrpc: Rename audio protection domain to root
Date:   Fri,  9 Sep 2022 16:39:29 +0300
Message-Id: <20220909133938.3518520-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909133938.3518520-1-abel.vesa@linaro.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AUDIO_PD will be done via static pd, so the proper name here is
actually ROOT_PD.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 58654d394d17..8bcbc560d4a7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -83,7 +83,7 @@
 #define FASTRPC_RMID_INIT_MEM_UNMAP    11
 
 /* Protection Domain(PD) ids */
-#define AUDIO_PD	(0) /* also GUEST_OS PD? */
+#define ROOT_PD		(0)
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
@@ -1889,7 +1889,7 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		err = fastrpc_invoke(fl, argp);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
-		err = fastrpc_init_attach(fl, AUDIO_PD);
+		err = fastrpc_init_attach(fl, ROOT_PD);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
 		err = fastrpc_init_attach(fl, SENSORS_PD);
-- 
2.34.1

