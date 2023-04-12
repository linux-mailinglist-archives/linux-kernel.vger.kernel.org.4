Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8A6DFF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjDLUUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDLUUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:20:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9AD6E92
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:20:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f69fb5cafso70060757b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681330830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e9ZxJh3TAe5K3gzUNy1jfSfsgplGS4KJVghK4pqaL44=;
        b=RqkXxES0OfNwPYeIL/5G35UUzVo7uQxrnlPEEdikcqpHvn47El4pqOr8wYq89tVYpi
         HLr5cEJ4JWQ/jdmfCM1YLMqTvSOQEdrI0K4uTEPItrANTfRQE6q78sTohPcxUfDxnoId
         GKILHRa3UsQE7QIiLjy4676jyAbppyl2apcFdIrdT81Z/GSUrMUojJAk/Mt1Efkqv12C
         LPSsNJi7gAahp0cgj6peliWo6ySRByBOpX6bsVdkpPfFNoztlWanLgJgl6nQu7EcgYix
         chFoSfKibQihVpxlLXIXEwFdvvwXm8FGIbFg35F607LmD80apOHuKs82vYA1iA7OSUxc
         VO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9ZxJh3TAe5K3gzUNy1jfSfsgplGS4KJVghK4pqaL44=;
        b=ia5+R6Y9cKfmc4G+c4TBzx3Zc1PN21EomJ7VUAAaCmqh2sW6NpQN2wVLt224sDYzKs
         LvdYs08gbYG6uz4jjfHcgmWSR390xDlNr80cD/NDX+5+SWkix+wO6252dFKaqE8ElvC+
         pkzqo02PuXsgTqFjhWB4mnvGVpaJJAbrTXMw2c8UZ2ywO4yx0Ob6csx3wRhCz9botobr
         asr5SWOtkJiDHq3AxCaXFT5FBGnkLsSsfsRz8o3CgTZVySH7pN/OlCT7FnBoIqrVfAPM
         PpLcYj4bydOXuimer7XFxy0iFUhF91sIahdpXNwpPSKtG9iKYSJLlGLeuZ4+BSDwLx/E
         ZjUg==
X-Gm-Message-State: AAQBX9d7VOWqxvDlmsj7524JlYlx98ZXjkDR8COc1yn7UAqOkUvDMTN5
        1Sl4CDFoFKFmbHzkQRGqZNiULDTQ66oLgA==
X-Google-Smtp-Source: AKy350YQOCReGiGW58DM+oddgfzjHmmemt6sUL2CI3v1hQw0K6lwaYBsWidBXZzu5MdRQSQMY/CmhofzLYKttg==
X-Received: from rohitner.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:413])
 (user=rohitner job=sendgmr) by 2002:a81:a74a:0:b0:54c:7a1:ef50 with SMTP id
 e71-20020a81a74a000000b0054c07a1ef50mr9024881ywh.6.1681330830221; Wed, 12 Apr
 2023 13:20:30 -0700 (PDT)
Date:   Wed, 12 Apr 2023 13:20:09 -0700
In-Reply-To: <20230412202009.3750955-1-rohitner@google.com>
Mime-Version: 1.0
References: <20230412202009.3750955-1-rohitner@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412202009.3750955-2-rohitner@google.com>
Subject: [PATCH v2 1/1] spi: spi-loopback-test: Add module param for iteration length
From:   Rohit Ner <rohitner@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, joychakr@google.com,
        Rohit Ner <rohitner@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI test framework is designed to run each test case for
a list of lengths.
Introduce a module parameter to limit the iterations
to a single value among the list of lengths.

Signed-off-by: Rohit Ner <rohitner@google.com>
---
 drivers/spi/spi-loopback-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 313106eb8d40..675a73cf1579 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -53,6 +53,12 @@ module_param(no_cs, int, 0);
 MODULE_PARM_DESC(no_cs,
 		 "if set Chip Select (CS) will not be used");
 
+/* run tests only for a specific length */
+static int run_only_iter_len = -1;
+module_param(run_only_iter_len, int, 0);
+MODULE_PARM_DESC(run_only_iter_len,
+		 "only run tests for a length of this number in iterate_len list");
+
 /* run only a specific test */
 static int run_only_test = -1;
 module_param(run_only_test, int, 0);
@@ -1033,6 +1039,8 @@ int spi_test_run_test(struct spi_device *spi, const struct spi_test *test,
 
 	for (idx_len = 0; idx_len < SPI_TEST_MAX_ITERATE &&
 	     (len = test->iterate_len[idx_len]) != -1; idx_len++) {
+		if ((run_only_iter_len > -1) && len != run_only_iter_len)
+			continue;
 		FOR_EACH_ALIGNMENT(tx_align) {
 			FOR_EACH_ALIGNMENT(rx_align) {
 				/* and run the iteration */
-- 
2.40.0.577.gac1e443424-goog

