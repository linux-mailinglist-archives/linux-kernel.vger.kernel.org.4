Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA668BA3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjBFKad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjBFK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942C21A2E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so6874900wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+yPE9G7Uhxczh+UksvFIhkwl0eS8Qu86GXZF1wgA0Q=;
        b=cwWenJ2zwILkHpUzfj5tmZCisYTZ47GOvi5ur3CgjrxuYgl+WnHKJjuxhsvigQ/szp
         Cfpa+hfeaUU8Bb+ppxtzG3oMg7MlxxwG38v5uoUHqtAukW9nI0T5FQz5iwyL0mM3OMLU
         JhsP7r9+0xNM8Kibrx780gAeAn8i2aXOwaBMZNK6pMUjEy1XFFA0rc0Ea5cs6OcWwBmR
         24qUd0mwFnfktOTCfb34oEDUN19F0CEeE0Q83HC5liZ5wmjBJX74VuvEAGiaZZPllUFk
         IOClUNx4GvULkAEnOmy9VTUq0RAj8vKxt2yc4Zcp9XMIipO38jQfa+cHO1aVmjdvDNRX
         TUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+yPE9G7Uhxczh+UksvFIhkwl0eS8Qu86GXZF1wgA0Q=;
        b=fwv8lwivZmLBQ3Ikfyo7TLZS8L5JZgG4ar9CttpkR7MpnIgLq2KEnLN6pey8TIRq1p
         nPkvPg4w+7VxwpRHu6cV4XLKSP+EqDB0JVMaPrSPlm2TLekpT8nV4IMjB87hLGsXQ/30
         FaYSqv9sb/2ncbBpH0frx72FLi8065Rg1OVrXn3M47ph0JNVrNTs7fWYuKVxlQ2iReIG
         OhwxfteUvbCc567a5o01+G6r0J783g7/QRsBfXVbvaM1LnmT+1Sg8kQVO3V9JTGOTdBd
         8IMyowOF1F/d6SYXQi0Zjk57Rfaz7ZZEAbIsFi5JYlLA3bnTw5INVlD+q8Z7pdierxz1
         EMzQ==
X-Gm-Message-State: AO0yUKWlyUhrUypIwBHiqciW2kzG2lIlNU8kVz/xsyoaXct1SFk+8p+A
        oNRczSzAzBRlF617W13JHzAQng==
X-Google-Smtp-Source: AK7set9qQzKLLmB3futGbLABeVtgAFZd+pN3bbJw1z6S8LZFOMGPhTcg7XpZXydUVZ8ZI6MuazKBow==
X-Received: by 2002:a05:600c:2e06:b0:3dd:1a8b:7374 with SMTP id o6-20020a05600c2e0600b003dd1a8b7374mr18065713wmf.5.1675679327621;
        Mon, 06 Feb 2023 02:28:47 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 27/37] nvmem: core: return -ENOENT if nvmem cell is not found
Date:   Mon,  6 Feb 2023 10:27:49 +0000
Message-Id: <20230206102759.669838-28-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

From: Michael Walle <michael@walle.cc>

Prior to commit e894d5ad177c ("nvmem: core: add an index parameter to
the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
found. Particularly, if of_property_match_string() returned -EINVAL,
that return code was passed as the index to of_parse_phandle(), which
then detected it as invalid and returned NULL. That led to an return
code of -ENOENT.

With the new code, the negative index will lead to an -EINVAL of
of_parse_phandle_with_optional_args() which pass straight to the
caller and break those who expect an -ENOENT.

Fix it by always returning -ENOENT.

Fixes: e894d5ad177c ("nvmem: core: add an index parameter to the cell")
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 81ad6a4c4f86..30057b0094a2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1346,7 +1346,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 						  "#nvmem-cell-cells",
 						  index, &cell_spec);
 	if (ret)
-		return ERR_PTR(ret);
+		return ERR_PTR(-ENOENT);
 
 	if (cell_spec.args_count > 1)
 		return ERR_PTR(-EINVAL);
-- 
2.25.1

