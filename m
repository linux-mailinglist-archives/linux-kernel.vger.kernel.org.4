Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D04162D8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiKQLCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbiKQLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:01:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166AEDD9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668682766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NHqZVSUZPL4fN7KKyUIajXaGhTjFsMLtpxufRffoPO0=;
        b=aR+d7/lRGlTbVD4c+0G670OGH6P18nE9zakR1G0atcq9pwIZdRSDc09iOlqzSTgTKl3m0v
        0qDTZznSJgPxGRwC4aG3hW6lvcHPu3dJrujeIvRtlKwsC8XlN84MSmoAkoqC7f8HDOBtym
        LLwIB50f472AGIe0dsUqloLgokxp24o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-Dm1S-QSBOXmhIZtfBKefOQ-1; Thu, 17 Nov 2022 05:59:25 -0500
X-MC-Unique: Dm1S-QSBOXmhIZtfBKefOQ-1
Received: by mail-qv1-f71.google.com with SMTP id lb11-20020a056214318b00b004c63b9f91e5so1270621qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHqZVSUZPL4fN7KKyUIajXaGhTjFsMLtpxufRffoPO0=;
        b=yhfw5NOLuCRVYG2YTNQAyEzHOF4Ix8GiNIYwlxlifrWmwSJcmzINcIOoMTsPR18tfx
         80xEzGQfD725KlNNQ3uyTn9GvXZvI2sk7Gqb58OGyl2OcS1SzvGCqr5Q6xqj9Tsvou51
         b+0l6a6pL1DzeFT1nXOPLeyoNPFbXb1CuUHQhtPn3IcpFEzTlqS+TdEL83d+/LqaCmHv
         E5Z9f7mNcQNZBlhlk7r809Oj8QFB9fx5CBHniUB3J6ydBHfmVNmWmP+DwjjfsKhowFLv
         CJiOsMKDUkBQ8H8z+c8P8uCT/z1TIW7dC5i2pzkFMwD3mYbNfv8bw+jI75AwfwaRL3Sz
         b02g==
X-Gm-Message-State: ANoB5pmH6yeRt5VbcYMZFvr/u6wRHFHksP1UrR1Rf1fpjghBWzxUXqd8
        8kmB9YTNC06FcQ3fzza7oWc/I31aTsYgvSI+c2k19J8APB32G5bo96CAfxrgiz7QmKU8Kr3JMkW
        oYpnO2C7+zB66KFnlYj5ysQIR
X-Received: by 2002:a05:622a:1c1b:b0:39c:d5cd:848e with SMTP id bq27-20020a05622a1c1b00b0039cd5cd848emr1598588qtb.294.1668682765185;
        Thu, 17 Nov 2022 02:59:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4tEcsbNaCntauYyT3prVUMPVvxQYyD+D9GBgxd8uTGR7ZKequMv/3F6KVAscjxQWvnFW7ULw==
X-Received: by 2002:a05:622a:1c1b:b0:39c:d5cd:848e with SMTP id bq27-20020a05622a1c1b00b0039cd5cd848emr1598583qtb.294.1668682764977;
        Thu, 17 Nov 2022 02:59:24 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id d7-20020ac86147000000b003a5c60686b0sm202843qtm.22.2022.11.17.02.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 02:59:24 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: add debug message showing which unused clocks are disabled on boot
Date:   Thu, 17 Nov 2022 05:58:29 -0500
Message-Id: <20221117105829.256717-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
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

The clk framework on bootup will automatically disable all unused clocks
on bootup unless the clk_ignore_unused kernel parameter is present.
Let's add a basic debugging log statement here that shows which clocks
are disabled. There is already tracepoint present here as well, but
there's nothing like a simple, good ol' fashioned printk for simplicity.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 57b83665e5c3..ddf5a48e72b6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1352,6 +1352,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	 * back to .disable
 	 */
 	if (clk_core_is_enabled(core)) {
+		dev_dbg(core->dev, "Powering off unused clock %s\n", core->name);
 		trace_clk_disable(core);
 		if (core->ops->disable_unused)
 			core->ops->disable_unused(core->hw);
-- 
2.38.1

