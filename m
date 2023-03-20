Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2AF6C228A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCTUY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCTUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:24:55 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E9A5C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:24:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id n2so14782293qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679343891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pydtgT+7v0cju30MJcNRWWaLuxk5ERuwNf/eKdgFBIc=;
        b=rXjX5bwIxHdfctQ6V3TG59Oyh3QpXwfzgUiGxqpkqiSZutjp00I48TAaSex3tgun/F
         fmirya5bpOeZU0CD+L+3ghhdRdImBObY+fWeAsg/faiQs+/YB98ILJXNKWnzx+zh6zP+
         dWAhNVVVcsG4nSyucT1R1HN6OSxs4HTZnq3O4dc+HJT49CrJjNjZ48UNdiVm+LeUlk+Q
         IceFMgI+l4ZOK9ZzzvY/jqxd30i2PpqvbyvZlDkiVc66yqir2rgcgr+GPvslJsyOUaGs
         PBdv6Z2zsSuqMXhQWSDTg7MK9rBKt607QD/4XSinJOh8DXqUZ82HLnox2/xrd9tmMqF+
         wYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679343891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pydtgT+7v0cju30MJcNRWWaLuxk5ERuwNf/eKdgFBIc=;
        b=R/G5r7l7GfvnkwHoUPSVtrBruAVeVcM0g4PG1y1BuzbE5KifiG/LVeRw41uCbMSAjr
         HjBddz/jkSsqsooLr8KcL9UkLzwnH4S+68TREUeIPHiv+Os4l0fX9PxeGIKC5GOGgnzD
         BhuA0FJLdx0fuA8J3KD9JFIUmW7EjiVhb9E4za7wMLKw/eY5nG2XnyZupg2ZMF8ta1SK
         dcxrkLJcso0WiXFpJ1M9ND0KTDpTiZulX8zPBZCsMW5Oy4nubmbszPsf+vSPjkZDoCaa
         SwtfPrLYZrcTCHBkV7vUQnAsC93GfcS2zYtche+oxm8cloxYwbDOZ7VZW++uhCIbDxCS
         oGhQ==
X-Gm-Message-State: AO0yUKW+d6laJUBroPZ4Towbv5MVioDOv+nILZOPqrKyvxsqIyqC7GYo
        uG7WP8juNu69FEcFO/BZBj2I4g==
X-Google-Smtp-Source: AK7set/4fs8LRafPX4/mj6DOeUTP9gQaUhdfs+2p0RLSsRilO5Ui9bXCybb4NU4NJCFH1KhLpkKIGA==
X-Received: by 2002:ac8:5c16:0:b0:3c0:401f:9c24 with SMTP id i22-20020ac85c16000000b003c0401f9c24mr662117qti.63.1679343891675;
        Mon, 20 Mar 2023 13:24:51 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id d184-20020a3768c1000000b0074688c36facsm2568371qkc.56.2023.03.20.13.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:24:51 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: ipa: fully support IPA v5.0
Date:   Mon, 20 Mar 2023 15:24:44 -0500
Message-Id: <20230320202447.2048016-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At long last, add the IPA and GSI register definitions, and the
configuration data required to support IPA v5.0.  This enables IPA
support for the Qualcomm SDX65 SoC.

					-Alex

Alex Elder (3):
  net: ipa: add IPA v5.0 register definitions
  net: ipa: add IPA v5.0 GSI register definitions
  net: ipa: add IPA v5.0 configuration data

 drivers/net/ipa/Makefile             |   4 +-
 drivers/net/ipa/data/ipa_data-v5.0.c | 481 +++++++++++++++++++++++
 drivers/net/ipa/gsi.h                |   4 +-
 drivers/net/ipa/gsi_reg.c            |   3 +
 drivers/net/ipa/gsi_reg.h            |   1 +
 drivers/net/ipa/ipa_data.h           |   3 +-
 drivers/net/ipa/ipa_main.c           |   6 +-
 drivers/net/ipa/ipa_reg.c            |   2 +
 drivers/net/ipa/ipa_reg.h            |   1 +
 drivers/net/ipa/reg/gsi_reg-v5.0.c   | 317 +++++++++++++++
 drivers/net/ipa/reg/ipa_reg-v5.0.c   | 564 +++++++++++++++++++++++++++
 11 files changed, 1380 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ipa/data/ipa_data-v5.0.c
 create mode 100644 drivers/net/ipa/reg/gsi_reg-v5.0.c
 create mode 100644 drivers/net/ipa/reg/ipa_reg-v5.0.c

-- 
2.34.1

