Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5509E67E307
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjA0LTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjA0LSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255B1286C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b7so4678281wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5cQYAWnc8iQ0UrchsvjPr/IR5ASImNBAqD3wKXZO3g=;
        b=cY/6mrjFUq0WtDE7zWolaFcIY/oeOsBT9GGOMoO/gi8hILJXxphqdTTa/B5+NxTDoJ
         30PoRcdzHo2uKwATYyINDslTkoDCoPLeHN2MUxlsZ+y3sm9Ud02Rxleoz5XpMDwhkdXq
         DLNmGqoAa1I0oRauqJLYbUTHe/9D1IzYyTOvvSacnVfxxrnbokm4teCimaIedh2+5o3f
         OmT/+4Y/HNpMTTxmopaXt6ohtIVpdXFkQaYyyOQZKolDGzfaI5FCk085VP+3CC2wR0qN
         2Bb1bXUYyVdiADDqLP9X5wRJwhDWHNjcqKAeo4+7E3SdHnSEiJR4MNIiMKftTJ72WAa+
         H5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5cQYAWnc8iQ0UrchsvjPr/IR5ASImNBAqD3wKXZO3g=;
        b=qiGGfwjvg/1nScB81PW+mbkK4ey6OrQal4/GEv+Yr8iHhHtDB4J+9AhE5TfFmU5JiK
         JZ4J2FHCjJmoGXip7sl9jF9iCq5mjX6y/EvKBVCQBezhsral83PhzHqLu4u+YBA5EG2A
         5Bj9VuHubTuIaR87NlPMc26BNWQ4Qgc6cqWZ+AbHm+h3+brofsAM5m44uUMBzN/Yri1Y
         iNu/Bp43tM55FnGjFY3l2NGC6x8kqL55ynBPqlhQG6nVPYBMoPpZTxriwyWZHf8bB/01
         mRmhWLhonVcp5kGNhYuZkeW3E9iukd1ORPx5V1nYCYeXrcCUdjLF0ojNbP1XbK6K69s6
         r4VA==
X-Gm-Message-State: AFqh2kqFNXKEhqpUPoEQbkoxF6t+91Mc2Elp8RrqmgHjCGtvae3wlmqD
        PlFBZqvK07+TjmjgrA0cIRbEAHJWah6QzH0H
X-Google-Smtp-Source: AMrXdXsiujKOWkhMhvd9ZBCLCHx1jxySqtZ+1Uu3aSrtA6Wlmk3uFt4GTFuNrptvd72SkTVbMda+tw==
X-Received: by 2002:a5d:5190:0:b0:2bd:fde4:885c with SMTP id k16-20020a5d5190000000b002bdfde4885cmr32337324wrv.63.1674818296362;
        Fri, 27 Jan 2023 03:18:16 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 27/37] nvmem: core: return -ENOENT if nvmem cell is not found
Date:   Fri, 27 Jan 2023 11:15:55 +0000
Message-Id: <20230127111605.25958-28-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

Prior to commit 3cb05fdbaed6 ("nvmem: core: add an index parameter to
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

