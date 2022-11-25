Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0006638458
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKYHPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiKYHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166B2A404
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so5602832wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YCEA4bX7xlb/eznlDG7rp7FsiAOcQoyW0cnp9hHCYY=;
        b=gIjnKSNZXVDh8Xp672Qo8soLbxRNmlA9BSlBkLKXGZ6IFOCwxGsnnUqCWVfAAM0LIO
         2X4udjlZ3nfdiq6tScbCGYW5N5m4cKLHoelNCsLsgiL6UV6FpbD/wKFmSibGaHxcBtvz
         DfQZdO+iu3HQ6VlOhcU4I292+2KjiEdi5wale0WvdilPFNl1U7RCsfSdzdQcw09LUxsw
         iHZUpZ+oAZEFGOM1ofOAmyf02x9wYhuuNdY3KwIGN98luQ4l96f8VrGp167XEuji4FUL
         ZjtAcJSx4sOD9iR97/o23VvW/qwf1qkJGavPWePZRnOPmQBeFoP+3U0akkATE3b+1BQE
         4JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YCEA4bX7xlb/eznlDG7rp7FsiAOcQoyW0cnp9hHCYY=;
        b=4fbVUzVMpVnL/X35ph15pFC4Cm4iDDGfy4Wr/uMPT++GAbKbIeH+xV4PZVMRLoSQdx
         sT4367LIiNtBbmtQyCzvcpUgV8u6g39dncIliydMSZovtCl5uXN1ivA81w9dQS7u4QM8
         VbWReQOEWbRYL/Xia8Ojtnt/TJpoU8sWE7P3f9UMYcSgxc+LJB/Tphf94Kw0/YqHz1XO
         Ov1VPcXcwL7iqP8R4zrPf3u5GXjhbN2z6mYp1s2Y8T9VX08Z8FD7FNiFBOjNGONubpfz
         5pfwpBuKesEUxdG9zK7HKMef56BrDYG3PunKp+fHFqNUBNRwyzzqi1O74DgBRR9kcNqK
         VFWQ==
X-Gm-Message-State: ANoB5pn/FibcepMzQtkC2z28OyO42XGR9nIiRjWTl2/+d6ZxKDPHHT2/
        DHYmKyEp/lgXnsLeKe7uc/kfKg==
X-Google-Smtp-Source: AA0mqf7fxpKSCR3zTr3CDBbklE7qKIKwusVrPEdRXS8x4Q4orvRYeyFneMVlVmrlVYqX7VqkYewE2g==
X-Received: by 2002:a05:600c:3d99:b0:3cf:cab4:a42b with SMTP id bi25-20020a05600c3d9900b003cfcab4a42bmr12563028wmb.36.1669360489404;
        Thu, 24 Nov 2022 23:14:49 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/10] misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
Date:   Fri, 25 Nov 2022 07:14:00 +0000
Message-Id: <20221125071405.148786-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
References: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
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
index 9e83743eaca1..0d9f1eb9a0ed 100644
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
2.25.1

