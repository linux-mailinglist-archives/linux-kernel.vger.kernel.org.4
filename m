Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0016A3DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjB0JFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjB0JFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:05:30 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953BF2B63C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:56:01 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id BC208315;
        Mon, 27 Feb 2023 09:55:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1677488100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8FIt0EVof2ywHvSQWJdF3omOOcuzKr09oKXuq/wVTQo=;
        b=B3N9UBLrbK5CQYPxyaBkjf4AdFobcfBZhRXIrUgtBkegnb3xNCiiWohid8rSevfiDj8aIQ
        nlMnkrvM4J5FjgF48WsJVEkwUVbmQroxmCT6WwQwtWn23ut7MG//hkQGKWpZN1QT7G3CWn
        umKE/6errmp4gNMqpcJH5wLcbU1ekWM4kVTNhQIusn8BjJyGXb9/PddQbKHDhlWgUEiPwA
        G8z5o2kqUK2VeRK8n8EEJmcJh/TsmWyQ2sKyGliuIOi0kz47m9ibwCWHv6SXUeJ3U0tnoL
        NjMKvZgeXuSFPXECXvXIAOdqwOIH+gNq9BpKXDABSpob3pZ9vt2uS6Ex3hyolw==
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 RESEND] nvmem: core: return -ENOENT if nvmem cell is not found
Date:   Mon, 27 Feb 2023 09:52:07 +0100
Message-Id: <20230227085207.85381-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Updated the commit ids as they are in Linus' tree. Added the link
to the report.

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
2.30.2

