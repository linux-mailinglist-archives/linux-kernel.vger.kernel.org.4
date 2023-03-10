Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929A26B3B53
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCJJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCJJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:49:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C54DF25F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:49:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id k10so18018946edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678441747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ahJSHmQLtPVdmNDDAHsnHqPzzECXMaWekgN5sUQ1o3I=;
        b=YNysE4r2hrmA4kC733zwQhtDIqOKWmSkLHT1XqzoJrcpgnWw7g6SqD0Aw3WFUjhhiK
         /ueCS4E4CUL9uL0Q37MII64qUfgms58a1W56OuEnDTDl2cY7KAhE25Xp7FALDilnA90V
         C1r11RgWkCpekdOQfhE7COCaJYQROpwgLfWvlLZjFnKy4UFT5CvhsqOlaFYTZ+jTtvcI
         O/x3mBO7J0saedWNlauBWen69jRojJ3hj1qRaRByT031hbnQe23xcIXDeCjvvSGluM6h
         Cb1ImX287wJC2N2L9ffwg6wID6OJlOov6g70Uc+PJbvj6v7lghN7bBOSny2/+Ma5fGe3
         LN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahJSHmQLtPVdmNDDAHsnHqPzzECXMaWekgN5sUQ1o3I=;
        b=OVYjQsuOF3il6cWpSDRe1TY4kV0zwZedCMKfvFn4y02dIUidKiXpBZrv0Uwepwkuab
         D2Dytmni3KtcWYt7eNVxd9XmEOEo3TW9vu3BCYBGQtg7Sqxjt0461oro21auyFkOSaUz
         CD8/spgsMpl0Fwxjy6fQGBouYn0gp6ePMlpjrUe8nzmbsBNbrDBheHS+WxnSl3AnXOCj
         7YhzOhMY1t9Fw6c+HvQD2ej8MJSwAh3Hxx11ugWPkj2rtlY7BQTk35jjYYM0FYGIK0Q2
         VoNcA/4nBrz/Q16+x9PS45OPCeqlIU/Ne3XT0kMkpwDmhTpAWsHCmT+NGT9B68+pNgjT
         pM/Q==
X-Gm-Message-State: AO0yUKUxjxfkS++hqWA2S57CenTkb/5QwXOh8SCe9VrFfZDpeuBp6Eg0
        2WWWXGsOEhhijymHpvJFUTjwGvepvsfetWvbCxylVQ==
X-Google-Smtp-Source: AK7set+iYCDzTb+GCZYpdHmKn2K88vNdEu4RiDNgbzG/8IT5j66eDN9fxEz66C3Esgky5rWnaHUx2A==
X-Received: by 2002:a17:907:9611:b0:8aa:1f89:122e with SMTP id gb17-20020a170907961100b008aa1f89122emr32491450ejc.39.1678441747048;
        Fri, 10 Mar 2023 01:49:07 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id s1-20020a1709060c0100b008dd6bf721c2sm746995ejf.106.2023.03.10.01.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:49:06 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: core: return -ENOENT if nvmem cell is not found
Date:   Fri, 10 Mar 2023 09:48:45 +0000
Message-Id: <20230310094845.139400-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Prior to commit 5d8e6e6c10a3 ("nvmem: core: add an index parameter to
the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
found. Particularly, if of_property_match_string() returned -EINVAL,
that return code was passed as the index to of_parse_phandle(), which
then detected it as invalid and returned NULL. That led to an return
code of -ENOENT.

With the new code, the negative index will lead to an -EINVAL of
of_parse_phandle_with_optional_args() which pass straight to the
caller and break those who expect an -ENOENT.

Fix it by always returning -ENOENT.

Fixes: 5d8e6e6c10a3 ("nvmem: core: add an index parameter to the cell")
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/2143916.GUh0CODmnK@steina-w/
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Greg, 

Could you please pick this nvmem fix for next possible rc.
thanks for your help.

--Srini

 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 174ef3574e07..22024b830788 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1231,7 +1231,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 						  "#nvmem-cell-cells",
 						  index, &cell_spec);
 	if (ret)
-		return ERR_PTR(ret);
+		return ERR_PTR(-ENOENT);
 
 	if (cell_spec.args_count > 1)
 		return ERR_PTR(-EINVAL);
-- 
2.25.1

