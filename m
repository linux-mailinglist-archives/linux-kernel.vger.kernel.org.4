Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65503637E98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKXRv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiKXRvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF30109599
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d1so3430643wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vup2T8n4HhZF0U9tpTO6VabW8eaW07MBYBBBLUca2B4=;
        b=z1rd8ZVZ8/yWSTEgtwkLFEgJ0iVO4O9RKQMMvx/lY3fMHNTc/rUCaRnOPo4yJnWj6b
         Y8T6tWEUHNsitwA4aA1s+q7PsUwN9AmDqIhdW7UoN7zxDvb7VO2IEwigTtEpv6q+1pVQ
         e5rFLpur380IYSxFNrougwU/sy9KTPkrE57Gopdb4nvRmWnetE1clntNBRJv3DS2ERTK
         JE3p7V99xAKdohCffWQb+lRbJK8W8f94Hyya2doMcfaDLAcwGwGcmj6hO7wpCtVO/Fn5
         Ncu0iVeYtz1PQrEKFaPXSnjQbN0XuuBbBcDZSufMuXtK1hbsnDbMPUjqSLmryMpcilwl
         3UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vup2T8n4HhZF0U9tpTO6VabW8eaW07MBYBBBLUca2B4=;
        b=KqlHlx5uqhXy3pDrNanzjlg3BUjCoY9WU78ckEqIpn7oj52byfJ0BSRAs+pqFytJ8J
         jiLosGLuUV/kVDRqmolRB3UxoHeNUdLMs/XwjaXaQ90OvegXXQ53oiNSm797Z0hQ1ICp
         f6f6snDNB5zb/Bua5V201yNqKzVkvKSSMZhijlhZISWySs5EjUAdfE8c8Ldlsaf/LWgY
         C3ZKWf8ucxh09yV8IESBzlozq2lKA5G+n16D0G/na9cGZm81kBziehVwTrmeVH/qKY/n
         hlmXehhv4buYjxEQhsTYVi2ydT5bXUVnZDbG33VxxGj/yRAToJsAQDUFAsRpvTUC1NkJ
         Gn0g==
X-Gm-Message-State: ANoB5pnVmpNRa0suunBXlsR0DNgnhk5DCR5+HOv1xRm01dJoR3S/ipj2
        aODxK5cF/LtMhWAUgeUU3rWn7DVlOL7LSw==
X-Google-Smtp-Source: AA0mqf40XwQEHCP+taZvTgll0Nyt4S+Hj0pe8bAsuov/tNW1IEz7O62iJ4tUggvjPpaD9AoiD/MrMQ==
X-Received: by 2002:adf:ff84:0:b0:241:ff1d:f9e8 with SMTP id j4-20020adfff84000000b00241ff1df9e8mr2162856wrr.598.1669312304569;
        Thu, 24 Nov 2022 09:51:44 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/11] misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
Date:   Thu, 24 Nov 2022 17:51:20 +0000
Message-Id: <20221124175125.418702-7-srinivas.kandagatla@linaro.org>
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

Move the kref_init right after the allocation so that we can use
fastrpc_map_put on any following error case.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0ddad976a4d2..b1e16bd56c6b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -748,6 +748,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&map->node);
+	kref_init(&map->refcount);
+
 	map->fl = fl;
 	map->fd = fd;
 	map->buf = dma_buf_get(fd);
@@ -774,7 +776,6 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	map->size = len;
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
-	kref_init(&map->refcount);
 
 	if (attr & FASTRPC_ATTR_SECUREMAP) {
 		/*
@@ -804,7 +805,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 attach_err:
 	dma_buf_put(map->buf);
 get_err:
-	kfree(map);
+	fastrpc_map_put(map);
 
 	return err;
 }
-- 
2.25.1

