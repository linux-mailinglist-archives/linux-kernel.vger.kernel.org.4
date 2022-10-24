Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98A760BD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJXWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJXWS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:18:56 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E88FD8F63;
        Mon, 24 Oct 2022 13:36:09 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id d26so7645571eje.10;
        Mon, 24 Oct 2022 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnqNra0lgbLAKch8eagvznAxGId4NWgXejGlEDMRG8I=;
        b=lwrCsYSnWfTQh15cwQ7ueF8f2lHMOTa+mOmouTY1ExaPRtPNGsHigtjtgstssCXaYm
         ancy3xk6f/FVT7y7wCLjlA6BsuUUXeHs4ZHkH4SuIUD7KjjDO3846Vc1R0rPTSumc61v
         LalmebgrfMGEjsqMPtBCY00khGcDmd7uTUYZNzbsyXfw6011zIQHliWjCMom/eIGcTUU
         ldtE2WbEj0OpKk06UYAkVBBhrUbOw1UONE7L3m1ucx1O9OA076r1vNBjPrjoUCV+wnK3
         h//Ppkdlb5BCIptz5p+PM7yzrUGr+GOnMtaSUNN3xM3L67L+KB7CKZvV0Su+62ggUxKo
         0ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnqNra0lgbLAKch8eagvznAxGId4NWgXejGlEDMRG8I=;
        b=irVARwCh1dfxT78scbt8RywEu40i/ITAPz7bZ5XwNQ31UiXyW+ebXjAzNgwAgPh5M1
         np50p2DsV0NOxz4BUwSXD2nPSOKKnx4YCBDacUD+kruifvVdIz3LCqgY0z6ZM3tU66xl
         4tvvvDkhobvZZtjQOoBCKv7auL5MoZu3asWLQaS4d66FyEZ7MpDaj0/7UsBRqLBEdRi+
         0k8KijjSqRuw6dfcOUyFapmqX9zdVzkTkh4ziwOZkebXFwdzjbmEFd2O0jxBl71LAy/6
         hjjJgwTRFKicZ1fJdmXz3JW9Jl1DaUNlFO2f054l1dd6khVQTAmaS8FaCf1Mu69zszv1
         CKVQ==
X-Gm-Message-State: ACrzQf1Jmf6XRlOyNiLqhK95OlSNVBWGDoblf2k6c1kUPtg9FDNqdOQh
        +U671U/CwoxqGZSnKIiYrfymghVVBHqeuw==
X-Google-Smtp-Source: AMsMyM4Ycr2oU2oWv7YasBF3FD7v1Z17AUdjCIvRaf87Sh6hZnQbyMESFWwCBG86hp9Bd3BVL2ydTg==
X-Received: by 2002:a17:907:c03:b0:781:fd5a:c093 with SMTP id ga3-20020a1709070c0300b00781fd5ac093mr29229259ejc.89.1666642530469;
        Mon, 24 Oct 2022 13:15:30 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:30 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 01/11] media: cedrus: remove superfluous call
Date:   Mon, 24 Oct 2022 22:15:05 +0200
Message-Id: <20221024201515.34129-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cedrus_try_fmt_vid_out() is called two times inside
cedrus_s_fmt_vid_out(), but nothing changes between calls which would
influence output format. Remove first call, which was added later.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_video.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index 33726175d980..1c3c1d080d31 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -309,10 +309,6 @@ static int cedrus_s_fmt_vid_out(struct file *file, void *priv,
 	struct vb2_queue *peer_vq;
 	int ret;
 
-	ret = cedrus_try_fmt_vid_out(file, priv, f);
-	if (ret)
-		return ret;
-
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
 	/*
 	 * In order to support dynamic resolution change,
-- 
2.38.1

