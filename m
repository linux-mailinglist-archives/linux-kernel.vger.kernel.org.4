Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62C76F0F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbjD1AUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD1AUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:20:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897502D40;
        Thu, 27 Apr 2023 17:19:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f46348728eso5664047f8f.3;
        Thu, 27 Apr 2023 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682641198; x=1685233198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ve7uIoGJf2kkE3oRGUKMXB38f7f45Vy05Bqy3ZgBaus=;
        b=h9ulxNNYhVzeT/m2EroqDmWk5YQGS9/8o7FJwIgRwI1b+YuCYDkpLgQlfdJvQIxNts
         0BLwDEc9YeLxcDihKrRNCsRDBQRSXJO8Q6hZMMkKt1c1bBTFOL/ryL+NxU4b3D4ie7iE
         CShIknkSa3ckIlOWcf6nqMCaeZqHha5Zql7M4+67frCfADy/WDUEU9jKQqMBwJLiotfj
         2w/SYcILiGlxFbw4IOLKiycdcUM/B4e6xx2UvdMgoL+SuEcHOYA6lnBCV+9Pe67/AOov
         iEtDq3WQp3dvxO2ThVIIapjKdR2WhfRDza1ONuac2UR8+KK19QhaJtCQrJOvhlN2qMf3
         UUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641198; x=1685233198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ve7uIoGJf2kkE3oRGUKMXB38f7f45Vy05Bqy3ZgBaus=;
        b=QCLmtBIK6rqCpnjBTneww3PnMK7eSRe3XjCf/ewrnNZ8loI5DTWoCY+bgrLi8DF/+F
         ZCL+eHzRPXv745ABEbDQ8w9YKpiv+KlJl1BMiTXkQxxCPl4Tplb+ZrnN6gMrePCiyI3J
         kBYxNa51iOvZnU+GbQ5PKSIKHLsrCAJ8pvVSD9CTP8o8aUUrs5X+LyHcGn8ArLkDAnJt
         EurK62VKxEU6tshQ499AwS9pIJ7c97RoAqmMd4/fCCvG9jchEIFMx7HdHJG8kllRNDyM
         0VJQDqIq/hUx5bvM1xRR49wu6DhQPZy6Tw2HrrLUq1sO2TxErqIAo+L4Y1joMLYcc2E6
         GY+Q==
X-Gm-Message-State: AC+VfDw8XFPMX1FwkE05hbLPKtI7TxNHlLdX31Cq+lSg2xvVxazk7dIA
        Mlsa3RLFkTSzQZipZ6WGtxQ=
X-Google-Smtp-Source: ACHHUZ4bHqUf5OfMA8KtY9+qO8EpkzRC5rdHK5lFi4dD6UPUVf1ncZ/1k7PJyyMYQGoKKBszJVqyig==
X-Received: by 2002:a05:600c:b45:b0:3f1:987b:7a13 with SMTP id k5-20020a05600c0b4500b003f1987b7a13mr2464939wmr.4.1682641197399;
        Thu, 27 Apr 2023 17:19:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id d3-20020a05600c3ac300b003f19b3d89e9sm16362095wms.33.2023.04.27.17.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 17:19:56 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 0/3] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Thu, 27 Apr 2023 17:07:14 +0200
Message-Id: <20230427150717.20860-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series fix a current problem with ipq8074 where the 2 uniphy
port doesn't work in some corner case with some clk configuration. The
port to correctly work require a specific frequency, using the wrong one
results in the port not transmitting data.

With the current code with a requested freq of 125MHz, the frequency is
set to 105MHz. This is caused by the fact that there are 2 different
configuration to set 125MHz and it's always selected the first one that
results in 105MHz.

In the original QSDK code, the frequency configuration selection is
different and the CEIL FLOOR logic is not present. Instead it's used a
BEST approach where the frequency table is checked and then it's checked
if there are duplicate entry.

This proposed implementation is more specific and introduce an entire new
set of ops and a specific freq table to support this special configuration.

A union is introduced in rcg2 struct to not duplicate the struct.
A new set of ops clk_rcg2_fm_ops are introduced to support this new kind
of frequency table.

Changes v4:
- Drop suggested but wrong re-search patch
- Move everything to separate ops and struct to not affect current rcg2
  users.
Changes v3:
- Add qcom_find_freq_exact
- Drop re-search on rcg2_set_rate
- Rework multiple conf patch to follow new implementation
Changes v2:
- Out of RFC
- Fix compile warning from buildbot related to F redefinition

Christian Marangi (3):
  clk: qcom: clk-rcg: introduce support for multiple conf for same freq
  clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
  clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf

 drivers/clk/qcom/clk-rcg.h     |  24 +++++-
 drivers/clk/qcom/clk-rcg2.c    | 152 +++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c      |  18 ++++
 drivers/clk/qcom/common.h      |   2 +
 drivers/clk/qcom/gcc-ipq8074.c | 120 ++++++++++++++++----------
 5 files changed, 271 insertions(+), 45 deletions(-)

-- 
2.39.2

