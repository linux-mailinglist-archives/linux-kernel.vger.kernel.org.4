Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2131766DFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjAQNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjAQNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:55:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5EB3C3E;
        Tue, 17 Jan 2023 05:55:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q8so10501555wmo.5;
        Tue, 17 Jan 2023 05:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z60P+F5yrVPU+RcrdTjGo7YHCmfZ47F2G2bKTQG7QcQ=;
        b=ZYBe+xbXY0HrXWRYOjW1aeiRtYtxZfds1/0dMWPVBZSUa6fDFQeD1puw25NfpeJIlp
         qKk89WDEks39dvtQMGhl/hACUXC+H7llXvQfqVhxRq6t13lcNNooQtekL+Trj579qVrN
         6mr0voeX0Zy3cdq/ehUYuO1sEazhbRwxpUtjd24Zpq+DBmTCJZ3HSEw/RiWs5Idm3quy
         vyNUfzJ1SFotkLsu47Op0/3ksURz3WqmPE2gAScxma+fdJ+mlTc8lpdrAUsiu6Yy7Qn3
         UNzJuKTYY6Y/sG1wjIIxURu2KM8CjFDGgGD5nAOAuPXCq553H3bdzdVbCxANdlgmSwpG
         IoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z60P+F5yrVPU+RcrdTjGo7YHCmfZ47F2G2bKTQG7QcQ=;
        b=RLvrtAynvhsvclQ7b3raXCPCOKewOmFaVCKBRrrVlzLTmYGwDg9FlS8TUGY+nxWYnB
         oV/wwCIyA8W8dIpK+N4mbFD0U6m1rrjCeaLuyH78im4GaZBKehMIDFc/hHerrJR7qUyJ
         UpyyuxkC4u4LAyP8P7oU8Cf9xlOASLGOauNr77K9h90ENU+EEjNQevU5Z8LNk6UbYRsH
         esGd0OonalJt0nRO/Y10ZfAQnXGN+33mH2v7N7CjRrwXhS9uR5qBVJuUx0iWTr0y/VX0
         8rb3DlSgq5SGwkb7AclGI+VLTa6IRn4WzoEiYhRTbT1MYvb3PErkJzviLpZsYkgLXUu3
         s2ww==
X-Gm-Message-State: AFqh2kpyYB6H5DLjt/Dc1sWbeO1b4R2hK6gdyDBm0or9L15CJwgBucEZ
        DTlCyQeiv5Bp+XOWHQIZrk0=
X-Google-Smtp-Source: AMrXdXuEsX79K0f5sO9n79Z74zmNvX8Zxw4uXDYNn7aIl4Yrr44wzNoS41K6GHoVTWNRm5WWwwhxwg==
X-Received: by 2002:a05:600c:54d0:b0:3da:f9c9:cec9 with SMTP id iw16-20020a05600c54d000b003daf9c9cec9mr3282729wmb.1.1673963720425;
        Tue, 17 Jan 2023 05:55:20 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm35147461wmc.34.2023.01.17.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:55:20 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 0/6] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Tue, 17 Jan 2023 14:54:53 +0100
Message-Id: <20230117135459.16868-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

This proposed implementation is more specific and keep the CEIL FLOOR
logic while maitaining the possibility to provide multiple
configuration.

The first 2 patch drop redundant F entry redefinition.

The 3rd and 4th one try to align rcg2 set rate to what clock core suggest
by using just what determine_clock pass to clk core.

The 5th one implement the change with also some macro description on how
this new implementation works. On determine the old v2 logic is used but
for set the requested parent is used instead of researching.

The 6th one migrate the gcc-ipq8074 driver to this new implementation.

Changes v3:
- Add qcom_find_freq_exact
- Drop re-search on rcg2_set_rate
- Rework multiple conf patch to follow new implementation
Changes v2:
- Out of RFC
- Fix compile warning from buildbot related to F redefinition

Christian Marangi (6):
  clk: qcom: gcc-ipq6018: drop redundant F define
  clk: qcom: gcc-sdm660: drop redundant F define
  clk: qcom: common: add qcom_find_freq_exact
  clk: qcom: clk-rcg2: don't re-search config on rcg2_set_rate
  clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
  clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf

 drivers/clk/qcom/clk-rcg.h     |  14 +++-
 drivers/clk/qcom/clk-rcg2.c    | 140 +++++++++++++++++++++++++++------
 drivers/clk/qcom/common.c      |  17 ++++
 drivers/clk/qcom/common.h      |   2 +
 drivers/clk/qcom/gcc-ipq6018.c |   2 -
 drivers/clk/qcom/gcc-ipq8074.c |  64 +++++++++++----
 drivers/clk/qcom/gcc-sdm660.c  |   2 -
 7 files changed, 196 insertions(+), 45 deletions(-)

-- 
2.38.1

