Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C43617E66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiKCNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKCNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:50:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121495B2;
        Thu,  3 Nov 2022 06:50:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bs21so2877965wrb.4;
        Thu, 03 Nov 2022 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xw5SU3w05rjbRP0n5l4+pjIOuu6FqjPKGh7fv85xNvk=;
        b=J6SLq9GRvKPBMDAzpU3p79DKrXjKyCU7xehsz/4TTspVGr1em+rH21FdMNK32Lym4B
         wG+rndEHp8/iZ8rksQs8Bo8H9hJ0x+jJfkXY3D0nizY0Lh4RUgMcsiwr3BvhMWjUpMNT
         Xj1sSTjL7gOrN0XDs2OUtkc02uyedzuWgthwKzo9ldtpXADhbpcc/cKF9nfuETZdKOow
         1ZFccTFFi1lhdq8XNWZ4g/Cjytfppgi2TIOk8qH9IeXROOBvXh6EuXZs1b5UDmhCFyaa
         8wfWSeJqPJi5Y2rVtqnIrwlCVwzRfT8xuinJQJQETqar5pB2dKBgKIU4k/lY/ABPlsq3
         /6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xw5SU3w05rjbRP0n5l4+pjIOuu6FqjPKGh7fv85xNvk=;
        b=t/V0L9YEV3a1FdL3q9v84F1rgyXfjOLH5J0MumEvMELI1R17NSWkkHtISZGpOOqxqZ
         w73SHtlGjbXdZrHjP49FP9dYk2FBidQZzeFl4lPTc4Jsm7HdTowWTO36Zmat9/+4JnRe
         IT7lBpBcqyRotM/mS1cMZC6QrRjT9/01lWqc0wrfxFigqGYT2nWGCvjx77G5ljVOdzpd
         4usxXiseaD20osZoGfBKh1SDtKiUk/ljADNppYQZTvFETd5UwFROyOxoz/tLHS24jV38
         ekDkhaBCXzQqx3diSEm+UvVTiRkNvEZ3jmEWod8p7Ziw9NOIi7E9Hg3jxCD7VWuOv2e3
         59VQ==
X-Gm-Message-State: ACrzQf3xYn3BRwIfEFwOvl4Fbrxyy2tB9ckpPIHNEgEm11Bzi82vEjLf
        g9TcGO4smYX3qKVtxQP4ahQ=
X-Google-Smtp-Source: AMsMyM60Q+Y3yVqxFIrOA1BZ2uh/ZnloKO2ydMmVD3+gzrSS46caSOuUDpvY/D9xxiqnDOa9hN/v+g==
X-Received: by 2002:adf:fd87:0:b0:236:7ad7:d3c4 with SMTP id d7-20020adffd87000000b002367ad7d3c4mr18874993wrr.687.1667483403550;
        Thu, 03 Nov 2022 06:50:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id bt12-20020a056000080c00b00236576c8eddsm957414wrb.12.2022.11.03.06.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:50:02 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 0/4] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Thu,  3 Nov 2022 14:49:40 +0100
Message-Id: <20221103134944.23275-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The 3rd one implement the change with also some macro description on how
this new implementation works

The 4th one migrate the gcc-ipq8074 driver to this new implementation.

Changes v2:
- Out of RFC
- Fix compile warning from buildbot related to F redefinition

Christian Marangi (4):
  clk: qcom: gcc-ipq6018: drop redundant F define
  clk: qcom: gcc-sdm660: drop redundant F define
  clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
  clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf

 drivers/clk/qcom/clk-rcg.h     | 14 +++++-
 drivers/clk/qcom/clk-rcg2.c    | 84 ++++++++++++++++++++++++++++++----
 drivers/clk/qcom/gcc-ipq6018.c |  2 -
 drivers/clk/qcom/gcc-ipq8074.c | 64 +++++++++++++++++++-------
 drivers/clk/qcom/gcc-sdm660.c  |  2 -
 5 files changed, 136 insertions(+), 30 deletions(-)

-- 
2.37.2

