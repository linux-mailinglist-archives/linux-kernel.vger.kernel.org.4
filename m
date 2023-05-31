Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68720718E79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjEaW1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjEaW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:27:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D7B107;
        Wed, 31 May 2023 15:27:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30ae141785bso135878f8f.3;
        Wed, 31 May 2023 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685572060; x=1688164060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thc5SaTObevmBqBArSyaE35TMCHyyEU9p/VRNvK1Ero=;
        b=MiW/zrUI40dNHJtJ95e6Wad1hpxX2B0918AB5rd7+oAB3Y77JNshAaSW3lByFXrupV
         juXuKljlGH7DH33bdigvE2KXOFPLqHyWMT0wuvqRCKQc1b2YIIwZtQgbB5YYNTWKL2De
         ZaiG/DKrU8HUE8j0skLZNzsuUb2tdgaoHMzA9vBlgrL2pp/TZeUZLemlAOz5YyiJXKUu
         EZIEOFhI4vT3w/h4wCnXFais5Z39wJgai37MLLUkhUGxVJt31D5CRBGOcaQ8PwQbbpP6
         zERdsGBA8VAaE9w7sWEthDscuKFCpzz1TWl+CRF7GtXXNgZ8Tfn1lV9WrwQg9MDjjszM
         xpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685572060; x=1688164060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thc5SaTObevmBqBArSyaE35TMCHyyEU9p/VRNvK1Ero=;
        b=VgLjFj/mH/6W7OZmHRh37FP4mpofKc1bxk7NCUUL3Cl8iNIzCw9cH4/8jvpRlGrdPb
         1qRsyvSnaubi1Dps1u7qDbhMZO1dksADRqR6eOLh/eRcyBuHng8ff9mOyNU3xndgaY5Y
         QcswsSb8QeJQhW5o2NK9QzD81bSJBzJ8McL/YfzTGKQnRbGOBBr76C4MDhdKB8LBC9Mp
         abJa3XuM7XXUFylN+pxxtKV0TlVzyb5LkTNy7V2d8tULciVLdVTsNUNXSilQI9DU5kYi
         OhJ3wKGfQJkRHN2sger25Yapfx5tUEsJT46sFPajcxuzi6ADKEsh5HuwoJnACnNoSTN6
         88Ew==
X-Gm-Message-State: AC+VfDyjvISOBYD6t+1TSkfb+zBuLVj/g2spEyq/CV3i7qnoEFAE1QsR
        NMAk/7CAM/NOD9n2T6V7k/w=
X-Google-Smtp-Source: ACHHUZ4AA/+qgMEnUi/VimgF1/kH89l4vub0qZbaoBjm4zxjU+uRO5Es/Ij9b+HWpfE4dItOJ9aZ1w==
X-Received: by 2002:a5d:618f:0:b0:306:3b78:fe33 with SMTP id j15-20020a5d618f000000b003063b78fe33mr300027wru.32.1685572059685;
        Wed, 31 May 2023 15:27:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id 9-20020a05600c028900b003f6132f95e6sm70020wmk.35.2023.05.31.15.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:27:15 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v5 0/3] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Thu,  1 Jun 2023 00:26:51 +0200
Message-Id: <20230531222654.25475-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes v5:
- Rework selection logic with suggestion from Konrad
- Return -EINVAL and WARN if we fail to find a correct conf
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

 drivers/clk/qcom/clk-rcg.h     |  24 ++++-
 drivers/clk/qcom/clk-rcg2.c    | 163 +++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c      |  18 ++++
 drivers/clk/qcom/common.h      |   2 +
 drivers/clk/qcom/gcc-ipq8074.c | 120 +++++++++++++++---------
 5 files changed, 282 insertions(+), 45 deletions(-)

-- 
2.39.2

