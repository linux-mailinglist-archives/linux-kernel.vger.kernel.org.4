Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536877330A7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbjFPMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFPMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:01:41 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A964295B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:01:40 -0700 (PDT)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 432963F16F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686916899;
        bh=CoEbYkXLM9I6EtHl3o7AoX98I0DHZFRUcIFR7I6STKc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dImRJiLqPSETtDzvnwcaU1VywvPtshMFg7qidLX41ihwpO/PyDXY3VX6vdASmA1IC
         EMUjy5Oyo6dV1Rombc/b8brDKtIn9EKNTh229v5BEhRcMGXs+QbnItnqs1gToyUesW
         fFhzQPg7chFqi/S1vEIPvt4/UzPrWB35ThadbbW/x0NzBcdo7F1UC6tI12r/gvC4Pd
         mgIg8V83QA6X5mZlt1Ztl9ZfuvOdzEmPI1YMf5/sRt65gGUctRAKSqTaURBh6sJ1U+
         T1GI7k+8yTxwNRcRuDEcx3DZ50im1Y7971NQO2qlQIG+IEjW4qBR5IXs9mvHAFjeh/
         8I6o+Wun91JOg==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4ec790b902bso530629e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916898; x=1689508898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoEbYkXLM9I6EtHl3o7AoX98I0DHZFRUcIFR7I6STKc=;
        b=OiUC6EBFV6qHKyLASQKIk1dg4obMmikMBdIPXJHRZ2HCxcM79GTBSXaLxjurE0nZDk
         Ex2c3lGxG2oa+mv0AayquR+1DxY7llWTPnoNmv1sk7O69O/qOYpdJQ9aNufi6xRXeJVS
         yEQJUzXfXj9l8a3Z8VZQBc5qGQB6RNqRwSmm2za/xGLrUizVN28Z0Ljl0gwRxKe21R32
         kODk7NOhpJJe0HTlrbVtjrQnpV09t54HfaOdxXzthk8wXY3gCewLzuTKi+HG+JXhrcmi
         gCpWOKKbmRXr0Yhsy/puTpcB2nEvrYVkIfGEOsTREaFiFn+fLeVlTVhzYweIbkkH+P8E
         PPhw==
X-Gm-Message-State: AC+VfDwgtKN1ULpISEfGEB/BCZ97U79CumH4JIK5UCzw05GvhzwtG02j
        573gEpgOmKTT/gbUSXrhZ0C98lFEdG7G39/gqZKXQr4ozrKrghGrBatyAo1VL5bR54KpDSQXemu
        MGHNcQzOb+5G9U8rSaOc+u1H+UU8xIQUeWkU0r87ohA==
X-Received: by 2002:a05:6512:68:b0:4f6:3ab6:3d9e with SMTP id i8-20020a056512006800b004f63ab63d9emr996448lfo.59.1686916898655;
        Fri, 16 Jun 2023 05:01:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46BRoTvYftQUooYitnHE0Wunvse1BgfFdrCF5EEZxKPT3kX15gcTmGR7Csi/n4zMFHple5qQ==
X-Received: by 2002:a05:6512:68:b0:4f6:3ab6:3d9e with SMTP id i8-20020a056512006800b004f63ab63d9emr996436lfo.59.1686916898314;
        Fri, 16 Jun 2023 05:01:38 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id f19-20020a7bc8d3000000b003f7f87ba116sm2026642wml.19.2023.06.16.05.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:01:37 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     s.nawrocki@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] media: s5k5baf: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:01:35 +0200
Message-Id: <20230616120136.1026390-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/media/i2c/s5k5baf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
index 960fbf6428ea..69a3bad54530 100644
--- a/drivers/media/i2c/s5k5baf.c
+++ b/drivers/media/i2c/s5k5baf.c
@@ -2031,3 +2031,5 @@ module_i2c_driver(s5k5baf_i2c_driver);
 MODULE_DESCRIPTION("Samsung S5K5BAF(X) UXGA camera driver");
 MODULE_AUTHOR("Andrzej Hajda <a.hajda@samsung.com>");
 MODULE_LICENSE("GPL v2");
+
+MODULE_FIRMWARE(S5K5BAF_FW_FILENAME);
-- 
2.37.2

