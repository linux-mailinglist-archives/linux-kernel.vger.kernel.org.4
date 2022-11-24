Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2C637E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKXRwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKXRvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00415B4F7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bs21so3463261wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rylusfgUDpkkWgalnBLghu7kEy11PXXS0gvZ7chhswg=;
        b=XPDXYp9KiAJX835BXQlDYnHHGeXq/je8vdMyi6suSfk5joz+t4t3Hi30Uqhrs5LSMY
         ZtoieTiw+0jj5/harETzmyCF80lZt7CYCpwfWpBGEZR6rghIukacHhfWEvpKOn5iyJna
         XN5m9TDzeklaY52nPzYMLyANOTuGGWU86Y1RcoJ4Yg2a9JdM4o6jUVqVBkyJUV8lyLpb
         hnHJResQwXk0qcFzSht+0L5dJEpFEdr1bljA2QzFBEf8kmjV979hIT6Kb+/dNjfKEkn+
         47FHpwUDE3Fal69YeLagMO/96ZcmCCYgRQLpiBSGA8tie10+F1g0ONa3lh249vur0mKb
         qboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rylusfgUDpkkWgalnBLghu7kEy11PXXS0gvZ7chhswg=;
        b=UNTmCcRYnR1UrK+lY42fD2ALTj4WbdEImi3yRYhuMchU5UDSxW8xRTO4Cgh7K5OjSX
         mMBxezkv83MSYZjmWOBmhqbM5ruR3CFzaB2zlkf6HQbrhwJJUJOvBMtwM95qPY4dpeXe
         loIUhI7lDctyvlE9b6nR5brQP1eGhqRmx9c7G6m4bulhXN53gIovmaLFVHd8LecDsNBR
         /6h2JytNBms+1Jca7aGKBFLJUqaYbhBwmHLrxDuKuF8v1TR4WineONE2oNiG0kxjloBe
         Q3Sv1mfv608VyHI8hVnd933/jR2eKqybjcshEpIK7G1E4riG7dwm6ai/obIj07txxbgT
         2xfA==
X-Gm-Message-State: ANoB5pmojEP8A1L1mjhEjQ8PAkTl2y0apbEm68ZlCyKVQomPM3Hh9Dyu
        Bar2vAsNRh26w4Mm67f+uiSkxve1l3hIvw==
X-Google-Smtp-Source: AA0mqf7YYfEU+aHSMZkd+Lg99Olb7J0LABBto9g40UcKL9A2ryrilcIhSjNUOFWh6lzsw23IoZG0mg==
X-Received: by 2002:adf:dc02:0:b0:236:77f4:6e19 with SMTP id t2-20020adfdc02000000b0023677f46e19mr21398695wri.638.1669312311888;
        Thu, 24 Nov 2022 09:51:51 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/11] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date:   Thu, 24 Nov 2022 17:51:25 +0000
Message-Id: <20221124175125.418702-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

dma_set_mask_and_coherent only updates the mask to which the device
dma_mask pointer points to. Add a dma_mask to the channel ctx and set
the device dma_mask to point to that, otherwise the dma_set_mask will
return an error and the dma_set_coherent_mask will be skipped too.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d3147e4313cc..9ddcaa4def06 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -279,6 +279,7 @@ struct fastrpc_channel_ctx {
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
+	u64 dma_mask;
 };
 
 struct fastrpc_device {
@@ -2309,6 +2310,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
-- 
2.25.1

