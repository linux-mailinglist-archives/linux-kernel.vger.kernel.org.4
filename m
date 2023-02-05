Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61168AE1E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 04:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBEDCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 22:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBEDCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 22:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1370813DEF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 19:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675566108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rc1Rh+5JjEe0b8phxZCvxG2nnz2wqGygUGi1H3bm4Pk=;
        b=heODJUh6dmqvcJ7uR50XkiKGFLb6cbcZGYUuiJ7R1qQr7fNXuUroVlQfp+ZfKxCq+JXOLQ
        5NucuS53KV5A/bYboppfAQFfehEbG5iweeACVz3xvPMDeJZ7InJbsPSQkki4TZiv+0VTsU
        o4t42f7RPiQ3oyFzjuvICGBVqL5g64c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-77-NWDoARzdO9euS5ouWNNkFw-1; Sat, 04 Feb 2023 22:01:46 -0500
X-MC-Unique: NWDoARzdO9euS5ouWNNkFw-1
Received: by mail-qt1-f200.google.com with SMTP id t5-20020a05622a180500b003b9c03cd525so4720944qtc.20
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 19:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc1Rh+5JjEe0b8phxZCvxG2nnz2wqGygUGi1H3bm4Pk=;
        b=pys+mqR7tJ2qZuUtqarcCJpKQiyMWVJjb5DSFAOTJTFuyLIOkyfOv9vmuyjAeVvdwM
         fU0dcyDodyyNPuG2J0fcdhG0+z4J7bQuf4YQfoMD9xXoe05kZy17IYtqKgFDI7Xm7Qd0
         v8K9TzGcIHZPHeZTg2dU9pPodKKNefrh1dmwa2gIRgUlMyJhSRB5B1b0RhyyZSHGfWja
         LGxmAKxzlphgY8p0BUBtajH5su7aRkpVG/9PqVUm2lKtFxxIsia1lqSKSXT6HvHdavO+
         baumiaEIcQYZ2xeBTqX+qki102ph5Dxvqs7C2PoIn7K6FGZGe5pxVLjWlS5/hmd8D6wB
         45Pw==
X-Gm-Message-State: AO0yUKVkICEnnGodGZb+Fe1aAeg1Tw8G/M29nFitd6hOp8MLhpE4/reK
        emMdBfiHqnWOeFmfPgUqGMwp7/jykj7jyl8jRrfovP1XJBZ5cxywhbkiMgRnTVlbY22OsxOPurI
        CpPd6fxkoFjDsyScMWkDlYCnp
X-Received: by 2002:ad4:5191:0:b0:537:77b2:8aab with SMTP id b17-20020ad45191000000b0053777b28aabmr23430360qvp.27.1675566106438;
        Sat, 04 Feb 2023 19:01:46 -0800 (PST)
X-Google-Smtp-Source: AK7set8bN7F7Fny2DRi/DyfvIZwdVQGkpozPBd6lorCA4FvWU8tSytLGnd4Yc7/ZDZ6JBiU3+JXWnw==
X-Received: by 2002:ad4:5191:0:b0:537:77b2:8aab with SMTP id b17-20020ad45191000000b0053777b28aabmr23430344qvp.27.1675566106180;
        Sat, 04 Feb 2023 19:01:46 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b24-20020a05620a0f9800b0071ba3799334sm4791906qkn.58.2023.02.04.19.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 19:01:45 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] clk: imx: set imx_clk_gpr_mux_ops storage-class-specifier to static
Date:   Sat,  4 Feb 2023 19:01:38 -0800
Message-Id: <20230205030138.1723614-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/clk/imx/clk-gpr-mux.c:73:22: warning: symbol 'imx_clk_gpr_mux_ops' was not declared. Should it be static?

imx_clk_gpr_mux_ops is only used in clk-gpr-mux.c, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clk/imx/clk-gpr-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-gpr-mux.c b/drivers/clk/imx/clk-gpr-mux.c
index 47a3e3cdcc82..c8d6090f15d6 100644
--- a/drivers/clk/imx/clk-gpr-mux.c
+++ b/drivers/clk/imx/clk-gpr-mux.c
@@ -70,7 +70,7 @@ static int imx_clk_gpr_mux_determine_rate(struct clk_hw *hw,
 	return clk_mux_determine_rate_flags(hw, req, 0);
 }
 
-const struct clk_ops imx_clk_gpr_mux_ops = {
+static const struct clk_ops imx_clk_gpr_mux_ops = {
 	.get_parent = imx_clk_gpr_mux_get_parent,
 	.set_parent = imx_clk_gpr_mux_set_parent,
 	.determine_rate = imx_clk_gpr_mux_determine_rate,
-- 
2.26.3

