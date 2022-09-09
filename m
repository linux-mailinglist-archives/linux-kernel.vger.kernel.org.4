Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7E45B3955
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIINlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiIINkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:40:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72269BB75
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:40:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1335429wmr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p0sGgbM82CjL9PsiMTQ3j5vV2E53Gvm1ePK9SKxgJ/I=;
        b=asHoCOq0torX3QVprYKLe4JhE1kzQs9+Y0jbeleTaDCvpFLa/r3LkLNuFdLZoP/q2+
         hZm1bXPkpib7aUxrpAfTyGbtdJE3fv7x5Sep+lCoqBaMBd9WEpYqcXJqUSOGV5NTrmNs
         1/0HRDZ90o21cXvvd4pAu7kQcZ2soGEDdPHNjzmvRRro5TDc+Q48HFirAEvXXZP06TXW
         b/iogyntgNt4Nz/IwLRrwcCrCfebt8v5DUroD/HRhKRVEk8u1NWbcggLApzeaCVx3JOo
         8GGOcBXKbF1ZvUMY6IHM/FORP8valBI8KHNsHspnaGn/EIT7sHvccxKmMtg2WQMWrcKM
         tUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p0sGgbM82CjL9PsiMTQ3j5vV2E53Gvm1ePK9SKxgJ/I=;
        b=VANYe9I4SHGHX7DDgQ70QsYi/mky7n4UCtQH4ndfR5/ZEuv7AljjyU5LCFqe69T1IN
         AuQxlYtko+Ba38Wm1g+CZLByTtiiWMQxSqwl9VPycopsU5waskhvgyFqzse7OQ5XUYXL
         PVuEqZeKDHXpT0FFn7SFWh+aKhJgeEWjVdwpMJGVEpsq7N7sEZrrDrO4BZEE/wr3GfX0
         S5FRQEh5c6Nkn4fnRRBfPKZwhiK1g35ERfK1D0IWbGSTh0JbsBwGnF//RGjFzAlj1lwc
         DbqAr/8oBvaMAhkaiXKD1/jkxKafXgodKlvIFOsxc97R4f8u5CCEkvedHAKKoVXCrdyb
         eI7w==
X-Gm-Message-State: ACgBeo3mmLeqmTcPFhPwsOvRovX1uLU+Ym5jNIhTSxYB3nZJXq+4qrT/
        rVbzEcA/tioMR/WOjpRYM9i1LfwJFljmmyGB
X-Google-Smtp-Source: AA6agR5njBztb6BGvrHcwV0nT+BG9qXwwn1YbTO8E//YrwUkKWEhTTjqZU7gvdUjaPOw+1VPNTM/IQ==
X-Received: by 2002:a05:600c:35cc:b0:3a6:1785:ca4 with SMTP id r12-20020a05600c35cc00b003a617850ca4mr5775611wmq.192.1662730844058;
        Fri, 09 Sep 2022 06:40:44 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003a604a29a34sm660622wmq.35.2022.09.09.06.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:40:43 -0700 (PDT)
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
Subject: [PATCH v3 04/10] misc: fastrpc: Add fastrpc_remote_heap_alloc
Date:   Fri,  9 Sep 2022 16:39:32 +0300
Message-Id: <20220909133938.3518520-5-abel.vesa@linaro.org>
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

Split fastrpc_buf_alloc in such a way it allows allocation of remote
heap too and add fastrpc_remote_heap_alloc to do so.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9afc3528dab4..d421e3e473d6 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -379,7 +379,7 @@ static void fastrpc_buf_free(struct fastrpc_buf *buf)
 	kfree(buf);
 }
 
-static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 			     u64 size, struct fastrpc_buf **obuf)
 {
 	struct fastrpc_buf *buf;
@@ -407,14 +407,37 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 		return -ENOMEM;
 	}
 
+	*obuf = buf;
+
+	return 0;
+}
+
+static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+			     u64 size, struct fastrpc_buf **obuf)
+{
+	int ret;
+	struct fastrpc_buf *buf;
+
+	ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
+	if (ret)
+		return ret;
+
+	buf = *obuf;
+
 	if (fl->sctx && fl->sctx->sid)
 		buf->phys += ((u64)fl->sctx->sid << 32);
 
-	*obuf = buf;
-
 	return 0;
 }
 
+static int fastrpc_remote_heap_alloc(struct fastrpc_user *fl, struct device *dev,
+				     u64 size, struct fastrpc_buf **obuf)
+{
+	struct device *rdev = &fl->cctx->rpdev->dev;
+
+	return  __fastrpc_buf_alloc(fl, rdev, size, obuf);
+}
+
 static void fastrpc_channel_ctx_free(struct kref *ref)
 {
 	struct fastrpc_channel_ctx *cctx;
-- 
2.34.1

