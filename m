Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BBE65DB9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbjADRw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbjADRwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:52:43 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F73476E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:52:38 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id g20so18392225iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fg/enfb4RCctdkewRQV7tDb9j91n7CjfohPG/ug4xNA=;
        b=UJ/LrgnN4pcaz198G+5P7BM0ISpetZ/ZOmv/tKYGHv49MGNMuNjbcTvgQhYh/TLb88
         sO/rvZOiWLxuI4oZx9bDghFf/Br/1GqbVVks/ONde/4HhZpXT6LcTfS53bY7tOYCgnYK
         tUpw/6Ki9kcq90w7Q6Sb11fvO0csYO/Nyqkt+qWgW3uctLqb3J9cDAUBHB7K4arOj4eD
         CzhlyNjJaEr2HjWwCIaIfenzkZMn0cRuJYw0HN9SuPnpMhgYZPEUHIztE2d3duFb8W9x
         IarZy11oiY+Nhu5XoxTt9qRsSS5bneT2xUki/Yeo5LwRBK9wINrffHKFNs5CAyj2EO8+
         xqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fg/enfb4RCctdkewRQV7tDb9j91n7CjfohPG/ug4xNA=;
        b=DwIRi6JsSY5iwM+CNuIYl24XJue3kUsvwxGm00g1Y1j1qt/VYgXbu2BEy7Gz/CYZdX
         xAd65gR0Xo1kRzCWq7rI3pZJ4m8mwGyi0QZGuvhOVCDxa4FYDeCl3oAN6p9kS8jCJpyJ
         j6RaW4cGDnKipf7/1Gl++MXaqZQik13375aipJh0ggKZZKxossqQhu5YepBnbA+D2VTE
         EyjmBXAf+RGr8Yc06A5VaGfjyZsQfEFBcKJj7hqhTSXI1RzkT/tqbAF4NnM+ceimCxQP
         fRQ0bXl6ZeNNKLJ8PUHFiAKVtoNvwejEzD1FpXWGi3QwpYTMGot3gb4QC5RGBydLiJHN
         iiHA==
X-Gm-Message-State: AFqh2kosrciiX3VBQTDCvZ5410JmVy27J0Is6WMEpPjRK9eWOwcMAzYY
        Pxzx5Z9gNLe81RMxGSP3cwP8cQ==
X-Google-Smtp-Source: AMrXdXty1V+JnpVbB5CWeA7DSYM9WrOT7Gkb1e1k1yRFY+fmuPV2xxjTe19RHszSEcB6o6rrr2954w==
X-Received: by 2002:a6b:5010:0:b0:6bc:d70f:8b2f with SMTP id e16-20020a6b5010000000b006bcd70f8b2fmr33993243iob.9.1672854757450;
        Wed, 04 Jan 2023 09:52:37 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id u3-20020a02cbc3000000b00375783003fcsm10872304jaq.136.2023.01.04.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:52:36 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] net: ipa: simplify IPA interrupt handling
Date:   Wed,  4 Jan 2023 11:52:27 -0600
Message-Id: <20230104175233.2862874-1-elder@linaro.org>
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

One of the IPA's two IRQs fires when data on a suspended channel is
available (to request that the channel--or system--be resumed to
recieve the pending data).  This interrupt also handles a few
conditions signaled by the embedded microcontroller.

For this "IPA interrupt", the current code requires a handler to be
dynamically registered for each interrupt condition.  Any condition
that has no registered handler is quietly ignored.  This design is
derived from the downstream IPA driver implementation.

There isn't any need for this complexity.  Even in the downstream
code, only four of the available 30 or so IPA interrupt conditions
are ever handled.  So these handlers can pretty easily just be
called directly in the main IRQ handler function.

This series simplifies the interrupt handling code by having the
small number of IPA interrupt handlers be called directly, rather
than having them be registered dynamically.

Version 2 just adds a missing forward-reference, as suggested by
Caleb.

					-Alex

Alex Elder (6):
  net: ipa: introduce a common microcontroller interrupt handler
  net: ipa: introduce ipa_interrupt_enable()
  net: ipa: enable IPA interrupt handlers separate from registration
  net: ipa: register IPA interrupt handlers directly
  net: ipa: kill ipa_interrupt_add()
  net: ipa: don't maintain IPA interrupt handler array

 drivers/net/ipa/ipa_interrupt.c | 103 ++++++++++++++------------------
 drivers/net/ipa/ipa_interrupt.h |  48 +++++----------
 drivers/net/ipa/ipa_power.c     |  19 ++----
 drivers/net/ipa/ipa_power.h     |  12 ++++
 drivers/net/ipa/ipa_uc.c        |  21 +++++--
 drivers/net/ipa/ipa_uc.h        |   8 +++
 6 files changed, 99 insertions(+), 112 deletions(-)

-- 
2.34.1

