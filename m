Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9FD5B395A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiIINlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiIINk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:40:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877B9D8ED
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:40:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bg5-20020a05600c3c8500b003a7b6ae4eb2so4478617wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=teKU35NVuwJsPuzsHiszqYgj8G9Rt6TviZAndcG5Pgs=;
        b=BM7EKYaKGpPgSBL7DNPpEUmFnBKlB8UzzfGz/of9ZFpm6Od5Vi9P/M9qiJaVPBHfI9
         hSI95NzQjWF4A+MZIihwxvxcbWMfqlZ0Esfs8g3qldlrMbSOB/Qz6Wa/ymMjdU9zdR8p
         Y6U6xICcOJN/aV0MDHNmU7/g9aI4xloN0gQe5OuyPqnVP9g+lAgj1HEhMozZxUu6y51o
         rWZpOrRgSA9CGQHWDzJ0FligPENeJqDaerwY9m8aTD9bruXNCa/YUC3rmERU/r1VVwTF
         gqE5iVuDv69vr54AmIbvKYiAjDxaOwsuaQFudqsXvRPvMk0aNon8rMBU7L4OVXr4hFA2
         iy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=teKU35NVuwJsPuzsHiszqYgj8G9Rt6TviZAndcG5Pgs=;
        b=DGCRUdiKetr3kcz5vWiDlvZn01/uDqws6kr8dZHuPO+LiOs44N1i+7aZzFaXhm0IdT
         jpOp8sKHhUuxpIhebZW7qMLaxH0u15f+j+LtDebeBq+V8s8W0kBmlUr3Pl9YG2Y/ZmkG
         puX82pEzGTTORWvAwmvgqH/Q1PN5N+yuppo7nKq7ELAw1pji1FAt0J6rE20shcHX1otm
         WyjxeNk8sXANMgc/XadRWvNKRBDSRjoobOfNlp64y70fe1CXv1Ov2bRxVDfKPhVXkX56
         eX11k+7PaD4QGrJ69FM4Vc2k6gPzksXdEwl6UynHMNbcnZ5o5JJWTOPOejY/meRT6Ib2
         YE/g==
X-Gm-Message-State: ACgBeo0Kh8O+uINoIxIcEw2RoiQHUFWYWWP5q4JjZuUu/a2B3bisnzOR
        nfH/IFSGFckckJWg2ul6wahGXQ==
X-Google-Smtp-Source: AA6agR7P5/kQpxuwfoPqwybPp+jgoQ5VueXdIpKZei4AJmJqW6NTiV1QitYNHAgXbkolEt4hAF0/Ag==
X-Received: by 2002:a05:600c:1906:b0:3a5:f9e0:fcb6 with SMTP id j6-20020a05600c190600b003a5f9e0fcb6mr5822115wmq.157.1662730845705;
        Fri, 09 Sep 2022 06:40:45 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003a604a29a34sm660622wmq.35.2022.09.09.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:40:45 -0700 (PDT)
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
Subject: [PATCH v3 05/10] misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
Date:   Fri,  9 Sep 2022 16:39:33 +0300
Message-Id: <20220909133938.3518520-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909133938.3518520-1-abel.vesa@linaro.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the kref_init right after the allocation so that we can use
fastrpc_map_put on any following error case.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v2:
 * added Srinivas's R-b tag

 drivers/misc/fastrpc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d421e3e473d6..8bc9cf5305c4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -745,6 +745,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&map->node);
+	kref_init(&map->refcount);
+
 	map->fl = fl;
 	map->fd = fd;
 	map->buf = dma_buf_get(fd);
@@ -771,7 +773,6 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	map->size = len;
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
-	kref_init(&map->refcount);
 
 	if (attr & FASTRPC_ATTR_SECUREMAP) {
 		/*
@@ -801,7 +802,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 attach_err:
 	dma_buf_put(map->buf);
 get_err:
-	kfree(map);
+	fastrpc_map_put(map);
 
 	return err;
 }
-- 
2.34.1

