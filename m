Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C3616BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiKBSI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKBSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897DFC;
        Wed,  2 Nov 2022 11:08:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f27so47485738eje.1;
        Wed, 02 Nov 2022 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bJiWx1wliVbcBA4hLVtU2HKADrW2hjL3FgeqkhgWtw=;
        b=MuOr6WgUNRTbGp0fKCLMkl/k7dGETn0MCPk6OvhPg3lmMvlQgmcuBFQ+ABDIQVEfIR
         wFZp5SWC4EFvbN0KmunKKO77/O/BC7U/qywpY2f1LZBtchRftfHVF3XlxDQXgmGoQ3Cu
         HRfmoLIhb4dl4QLwwj8v/orGggqh47FggbluTDhATnJPTKIyLEFUq6U5YhVS+2MCTQVG
         Gk2wEwdsPhpcbyRz3cEpnHhdYsYto1gGKo/qcRpNS7dSxQpynS9SIQ1g/wDHuap9qgst
         EArzOONtTazMJBiM1MR40HcTRdRrPXfFh+vXs2vu6s+5u1L8ble5iN+quusR0rM+WQoX
         JcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bJiWx1wliVbcBA4hLVtU2HKADrW2hjL3FgeqkhgWtw=;
        b=4ZAWPumnIsQTaMEfJV65iERLk4HGPIu9gSOyxFI2BUf1THW1X9+NgnxeXjPmzJZsLG
         a/xF9Z8YGiJhOQrUxFYjrA13bJt1T7RkZccRlq+Kgi8t7HLum4mRwBCNU6KBdv3snywS
         jO2zpoG9BpLWi7yiUGX/5LdhX+4LDN+lXw6XTmOXykM6Hq8YspSw69kPBmKNlFyRi3H6
         PM7diodsjy+xsjr1jajq0eF+XwwRTmW4mySaPSPQlNuDr/vU76ZYKYHTyzt6uDGgyiPV
         kc5UYHWQzsNwKtp7nUWWLPeTXqv125miFVAn8Ivdky/l8x91rSW0iR4ZGM0nXmGov8wN
         TM9w==
X-Gm-Message-State: ACrzQf3OYzeMulMo1OD9Ia5viidP9tfzhwidiUYHKRq5abOgCq9RJnKc
        xkiXGRFSM3Xa8/Br8Fb7F/Q=
X-Google-Smtp-Source: AMsMyM4280G5nDkbI8u023cMcU5BlS9r2WOVAAA+6//bk1OD+H9jRtahZ1KPvN75QhuxsNTEmyAj5Q==
X-Received: by 2002:a17:907:b15:b0:7a7:19a3:e9e7 with SMTP id h21-20020a1709070b1500b007a719a3e9e7mr24606410ejl.361.1667412498590;
        Wed, 02 Nov 2022 11:08:18 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:18 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 01/11] media: cedrus: remove superfluous call
Date:   Wed,  2 Nov 2022 19:08:00 +0100
Message-Id: <20221102180810.267252-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102180810.267252-1-jernej.skrabec@gmail.com>
References: <20221102180810.267252-1-jernej.skrabec@gmail.com>
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

cedrus_try_fmt_vid_out() is called two times inside
cedrus_s_fmt_vid_out(), but nothing changes between calls which would
influence output format. Remove first call, which was added later.

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
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

