Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2E637E90
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKXRuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiKXRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:49:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070AA100B28
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id g12so3428478wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KFXcD5/aBYcFLibXAaTRcTYcuQsFKMCk/mHDgk2MPE=;
        b=a7INjNttUqhN+V1+9wb6boOLLQlpK9hSctTnyB6MdZ+1dEuVChM2dXoINPP+KIDqem
         TDQMuwwh6Y2XdTfNkOE1NwRcLGAcg0BUUkV2Cb1FQN69fUqvMlNJmMEDcxo+gU+GZo7U
         sNIXvAc+dveqCNbijj2vbTdA2+KkePUWJN+/2PUsj2Exiycpgpje8CMbF5Av89WEQrdN
         sH9tNcPrmTtGl35D0OhdK/cWMWO3tJ8ptq52fJzzFAnMenVggqHjTFFsxSRkOBYi+NfG
         8ROpfx8c1CwtQbrmvOQwLzNtZyd9eZ3nNcE2+QFF2f6WSjusD8bUYrNGWeCdQ+1TLtdD
         wehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KFXcD5/aBYcFLibXAaTRcTYcuQsFKMCk/mHDgk2MPE=;
        b=WlhnjvBqeQd3rzJesIOFWCvzQu2LoWYAV0aGRfuQqMFvXdZA93yMxz1ym/tNPi/A93
         1c5rlRml/F5KvXjSJ5mky0SQ8GMamJ7B1iMnJTqQRqoCvxd8Mz9U0WfBGk+7FulS5RxC
         rRheE8uTpNXcUihNa5VPl4x/n9tBdM0gc7x6zx46EY7WZvM3c9NT0xvIjUwzs+YGI1oV
         x+bV5vQC2jIfYZNopO+2UhUrRdMcuNeY6UMrRx7aGcFiJp92cwm/+nEYnnkzKIHlgi0i
         pVFOsT3cg00d2Ehjliz0OWVitprbptMLZ7+p/jWmAXcosLN0ffus5Y5Z9ImMqmfmvg3r
         Oe9A==
X-Gm-Message-State: ANoB5pkbxikRHKgzxRIosFElIC1pCfAYQ7qycEG6XFdZe1MMD9b1PozV
        fyyfeo+pvWKMx1JHsR+CNL5bhg==
X-Google-Smtp-Source: AA0mqf5LwL8aKM4fi/jEURxCd0yPCPgYlEa/IAxrEh76YlqGn6ZwasvivmbqpNeXhQ3W+P8eIjB9/w==
X-Received: by 2002:adf:ea43:0:b0:22e:433a:46ba with SMTP id j3-20020adfea43000000b0022e433a46bamr14163225wrn.575.1669312189541;
        Thu, 24 Nov 2022 09:49:49 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003b4a699ce8esm6250863wme.6.2022.11.24.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:49:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Ola Jeppsson <ola@snap.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] misc: fastrpc: Fix use-after-free race condition for maps
Date:   Thu, 24 Nov 2022 17:49:41 +0000
Message-Id: <20221124174941.418450-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124174941.418450-1-srinivas.kandagatla@linaro.org>
References: <20221124174941.418450-1-srinivas.kandagatla@linaro.org>
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

From: Ola Jeppsson <ola@snap.com>

It is possible that in between calling fastrpc_map_get() until
map->fl->lock is taken in fastrpc_free_map(), another thread can call
fastrpc_map_lookup() and get a reference to a map that is about to be
deleted.

Rewrite fastrpc_map_get() to only increase the reference count of a map
if it's non-zero. Propagate this to callers so they can know if a map is
about to be deleted.

Fixes this warning:
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 5 PID: 10100 at lib/refcount.c:25 refcount_warn_saturate
...
Call trace:
 refcount_warn_saturate
 [fastrpc_map_get inlined]
 [fastrpc_map_lookup inlined]
 fastrpc_map_create
 fastrpc_internal_invoke
 fastrpc_device_ioctl
 __arm64_sys_ioctl
 invoke_syscall

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9ecbf673d321..80811e852d8f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -332,10 +332,12 @@ static void fastrpc_map_put(struct fastrpc_map *map)
 		kref_put(&map->refcount, fastrpc_free_map);
 }
 
-static void fastrpc_map_get(struct fastrpc_map *map)
+static int fastrpc_map_get(struct fastrpc_map *map)
 {
-	if (map)
-		kref_get(&map->refcount);
+	if (!map)
+		return -ENOENT;
+
+	return kref_get_unless_zero(&map->refcount) ? 0 : -ENOENT;
 }
 
 
-- 
2.25.1

