Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC86D3C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjDCEJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjDCEJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:09:26 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1C7AAF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:09:24 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5463fa0c2bfso197743717b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 21:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680494964;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvFnphnDJhIRgXZm0virLekdKTOQfW5+pHsWaTGGeTM=;
        b=kUeJ2lwf7zRBsYvmzFyuhvCEE7VnpCUYH76GnherL1ruTmM1Q+L5tsiaPdC/GPoqsV
         htWO6WAJiLZ8g8ZFLB8GefKVE3XzbSa6vOy9Z3lcXegrB6UvIFAKz9/wBfd4mrXlfRrB
         hDN/hdPEgV4KST6mXOybEp8IObsyB6LY92r0a/qXB1ZGp2/9tDNf2DyvFFdS5U+djt23
         O8L3WPpxorS17h6DSYn5Itwh2DbSxUWfUYDRF0IAWAZBfMrPKF0ldhBSdk7xmuWk5/IU
         +z55dONWjivicjeZO+Vu9ijlURBjxHM7awcwYi+c5zKLk2s8LSujyoMdAla/zFmSDweD
         GI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680494964;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvFnphnDJhIRgXZm0virLekdKTOQfW5+pHsWaTGGeTM=;
        b=PYHxTaE1qR6eVff80LHX1BAS15h6xR2sg/QJIv0bHz2KmA4TFMzbrN1aMgwRIFa7+7
         mk4ih4QJ5Bi+B4jNrt9lazKuDRbDlcSlQVEbKk/vevzzJWgURkGC+YnpczefvUQSQpSK
         d5/AvgtwxbWY+2qJc8KsRlZ3WpSR9cYaRTQOCkU6sxSLG4srOPbBleMYvOV3QBX+TG2Y
         41O4LSeHKcH3o6BrKw3NZGmXtWJJY7mODgOAdpic96Mms5VxgQaOq7PBFq7BdCTFVkdC
         2Y0ilEiNwhjDjj9THCZDk54Da9bZATEU5yYcRWDNz36Bsrrw+lC+sA/Lc9F0faoqUvf9
         VYzg==
X-Gm-Message-State: AAQBX9ffXFmfNGEr3RhZ8MF2LD5k0zqzbA+kOo5eJ6WUPbuVeFEEBBFl
        r0W9hTv2eKMU7OjoIAvyXw8zjitjI4JOETw2p2liOQ==
X-Google-Smtp-Source: AKy350b9JFkPWrokQWdHW/mPTI0m5GQey0wVu1tdgM2llpJ1XCUx9QOk9xLJdiiSpZr/zZH11ZwiyYXKVXSHDk5itwo=
X-Received: by 2002:a81:ac46:0:b0:544:6828:3c09 with SMTP id
 z6-20020a81ac46000000b0054468283c09mr17689756ywj.0.1680494963814; Sun, 02 Apr
 2023 21:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   Rohit Ner <rohitner@google.com>
Date:   Mon, 3 Apr 2023 09:39:10 +0530
Message-ID: <CAGt9f=TBi3qcbhUPymFGjCFeNNZZ0KQoXSUOT5uA6Dn8PMmnWw@mail.gmail.com>
Subject: [PATCH] spi: spi-loopback-test: Add module param for iteration length
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <manugautam@google.com>,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
+                "only run tests for a length of this number in
iterate_len list");
+
 /* run only a specific test */
 static int run_only_test = -1;
 module_param(run_only_test, int, 0);
@@ -1033,6 +1039,8 @@ int spi_test_run_test(struct spi_device *spi,
const struct spi_test *test,

        for (idx_len = 0; idx_len < SPI_TEST_MAX_ITERATE &&
             (len = test->iterate_len[idx_len]) != -1; idx_len++) {
+               if ((run_only_iter_len > -1) && len != run_only_iter_len)
+                       continue;
                FOR_EACH_ALIGNMENT(tx_align) {
                        FOR_EACH_ALIGNMENT(rx_align) {
                                /* and run the iteration */
