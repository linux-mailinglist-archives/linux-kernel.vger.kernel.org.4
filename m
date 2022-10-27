Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5257F60F721
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiJ0M0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ0M0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:26:38 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72841134AB3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:26:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o2so848541ilo.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1wSBNiDU0GbgrfKwJrfmSl/NSwx/oves1DkSf+koaQ=;
        b=fRsh+Iiat9ICr99/pvvkt4DO77T79TCbEs4IfZwDCZGrkZorR3lFh85IpVwbwgkrmv
         pefjZnPpc/SJIfFQR0weGpfMUZhzbPvegjGQcZHbE47IFtYUuJ8V/D0RWb8m3lXNDz2s
         wTgeBhzYeXD8aYm3mtRdDX4QkTQtaAhQJyBnjMXe+gJWauTPaXzW0VQ8MXLZdN68M1OM
         d7jAYLV1eD2ku0j41lRLnyMaRXcByOXRUGzz20VAowo/kYWVNqk/PZ2XLrHwSdZLnTru
         aTlaG5bh4zWkniGvTMbjPkyCb4PbjeorVmKfW0gzy7cGEWSz1wq9BpD7dRE7ppw/5ylK
         CRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1wSBNiDU0GbgrfKwJrfmSl/NSwx/oves1DkSf+koaQ=;
        b=luCjxCmsA73dkC/1XQuUFDmMtWHEULBttNu4YuiuRw7osMuWiSjfksWXkWm9GCBfWp
         jpxsD40V1l5Dse2KTibf8zers/ZtZbwlXlRP49lr8TKbZtTtmXJ2Ua1cag7kTS5csj/n
         kRvC3s7dhciXMXmJTTM7gfP+qomyXACDJvn6BAET8Z3jQSgEwkkwxuYQw3+exAn0YvCi
         c9vIM9MAP56rbs5OSaHIoLz+XYT7PZTNnm40HihH2ugGYfRqCQEduZUoGHTq+CWRN/cu
         kiz/fu8236Ca1S5WeQrDrjoR0xkmOLV0HbFgflMil83a7P02/yNfSRCRbI2oTGkBpJzs
         w3DA==
X-Gm-Message-State: ACrzQf2yft4XxvrsX98zdb2J05Z+3Rm7edCa0uLXWsThGolzG9rLMcYb
        9fvEq9Y84ysdREVa2LwjRV+28ZRyBcq2JA==
X-Google-Smtp-Source: AMsMyM7EiDaMjRoM7RyMeuChZJy54dnBXY4F9h3eU5eB+F+7RN2Ydquq3D/2o0/qM75/w3EcM3hhmg==
X-Received: by 2002:a05:6e02:1bc4:b0:300:61e9:69af with SMTP id x4-20020a056e021bc400b0030061e969afmr4605500ilv.191.1666873596710;
        Thu, 27 Oct 2022 05:26:36 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id w24-20020a05663800d800b003566ff0eb13sm526528jao.34.2022.10.27.05.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:26:35 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: start adding IPA v5.0 functionality
Date:   Thu, 27 Oct 2022 07:26:25 -0500
Message-Id: <20221027122632.488694-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The biggest change for IPA v5.0 is that it supports more than 32
endpoints.  However there are two other unrelated changes:
  - The STATS_TETHERING memory region is not required
  - Filter tables no longer support a "global" filter

Beyond this, refactoring some code makes supporting more than 32
endpoints (in an upcoming series) easier.  So this series includes
a few other changes (not in this order):
  - The maximum endpoint ID in use is determined during config
  - Loops over all endpoints only involve those in use
  - Endpoints IDs and their directions are checked for validity
    differently to simplify comparison against the maximum

					-Alex

Alex Elder (7):
  net: ipa: define IPA v5.0
  net: ipa: change an IPA v5.0 memory requirement
  net: ipa: no more global filtering starting with IPA v5.0
  net: ipa: more completely check endpoint validity
  net: ipa: refactor endpoint loops
  net: ipa: determine the maximum endpoint ID
  net: ipa: record and use the number of defined endpoint IDs

 drivers/net/ipa/ipa.h          |   8 +-
 drivers/net/ipa/ipa_endpoint.c | 148 ++++++++++++++++++---------------
 drivers/net/ipa/ipa_mem.c      |   5 +-
 drivers/net/ipa/ipa_table.c    |  59 +++++++------
 drivers/net/ipa/ipa_version.h  |   3 +
 5 files changed, 128 insertions(+), 95 deletions(-)

-- 
2.34.1

