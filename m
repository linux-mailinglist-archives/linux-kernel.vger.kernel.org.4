Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B546C13B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCTNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjCTNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:42:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC8524D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:42:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t5so10098746edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679319744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrZdAoTHd1rYa6+2bns0LZXrcUZt1Y0m6OA8qCzTSf0=;
        b=nKq81/J0FvmXA5JsN+7z0xgyaD9ypIJv/BMXgeposmSq7l8XikkO3z4up7Arj9kxwi
         VuV2Ip6nA1LpGeefrIatp+un0KTSs0rYOS6Tns2H8z0qDvBpOQn4PGu/17PQCK9/UrzB
         yjh5iCdll2J6urVxY2BAcIEfwBQm44lRHj4nFo9prwAtLKSjAEph5Ln1HT9R9Y9bLrc1
         9VArIsZE/0RK4GeOFr3eStNrxoP7l7MQOVxbIByaB70Fr0BlXOjIEf+KCuOyZH/BI93l
         GP1lLQIpAnmwfrEAXAGbt+3Jw8C7d0gMuunLiRhQY6q7LhdK5hkG2BqUO/wAk0Yf9dUc
         ETjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrZdAoTHd1rYa6+2bns0LZXrcUZt1Y0m6OA8qCzTSf0=;
        b=mahimEdt+KzKgCOQ9RykHwKY3S96YbS1CJg9lPhuENhtIfMGT555Et2DfO63LLrZ33
         UnibwJfgHxqWVIcyqi9YuIkJh4c3bK0B7d27jH4x68J5kcZbDa98lVYoe13asCJ7cE0K
         KRcvDOEhIP8z3hvH614e9M7j+hvAF705idkf9vxLY/5KcxczZSr0BKjqp9p/kEsQjTnk
         VNwh49c1FZWY8Jzk2TUzpAKe6FhuWbHacmZ3bDONEWzfXzgaWxVyhgoTC6+OZLCPvJRx
         3OEUtu6kbmiMjc8p0LjOZ+6BVkSyI3rb5MQQjrH+cfK6Kg68SozCyfOGaLocjOHzOWQU
         frmQ==
X-Gm-Message-State: AO0yUKVocvmEnUJq3xkta6kjJAQ31DgJ+CxpopJyJrRXUUhp1ERVF8Zj
        jmoW36AAAccLZ3cbHe5Sm3hbOw==
X-Google-Smtp-Source: AK7set8a5ZEuGsV4rxIxgp5mWPOeREMId+pRDTv53eMzIMjUrfk9Hm1tTkVX6dtosamqVSw3/ut4yA==
X-Received: by 2002:a17:907:86a8:b0:937:9a24:370b with SMTP id qa40-20020a17090786a800b009379a24370bmr1347382ejc.67.1679319744054;
        Mon, 20 Mar 2023 06:42:24 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906409700b009334a6ef3e8sm2368602ejj.141.2023.03.20.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:42:23 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [RFC PATCH v2 0/5] Allow genpd providers to power off domains on sync state
Date:   Mon, 20 Mar 2023 15:42:12 +0200
Message-Id: <20230320134217.1685781-1-abel.vesa@linaro.org>
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

There have been already a couple of tries to make the genpd "disable
unused" late initcall skip the powering off of domains that might be
needed until later on (i.e. until some consumer probes). The conclusion
was that the provider could return -EBUSY from the power_off callback
until the provider's sync state has been reached. This patch series tries
to provide a proof-of-concept that is working on Qualcomm platforms.

I've been doing extensive testing on SM8450, but I've also spinned this
on my X13s (SC8280XP). Both patches that add the sync state callback to
the SC8280XP and SM8450 are here to provide context. Once we agree on
the form, I intend to add the sync state callback to all gdsc providers.

Currently, some of the gdsc providers might not reach sync state due to
list of consumers not probing yet (or at all). The sync state can be
enforced by writing 1 to the state_synced sysfs attribute of the
provider, thanks to Saravana's commit [1] which has been already merged.

[1] https://lore.kernel.org/r/20230304005355.746421-3-saravanak@google.com

V1 of this patchset was here:
https://lore.kernel.org/all/20230315132330.450877-1-abel.vesa@linaro.org/

Changes since v1:
 * Added the qcom_cc sync state callback which calls in turn the gdsc one
 * dropped extra semicolon from pm_domain.h

Abel Vesa (5):
  PM: domains: Allow power off queuing from providers
  soc: qcom: rpmhpd: Do proper power off when state synced
  clk: qcom: gdsc: Avoid actual power off until sync state
  clk: qcom: Add sync state callback to all SC8280XP providers
  clk: qcom: Add sync state callback to all SM8450 providers

 drivers/base/power/domain.c        |  3 ++-
 drivers/clk/qcom/camcc-sm8450.c    |  1 +
 drivers/clk/qcom/common.c          | 19 +++++++++++++++++++
 drivers/clk/qcom/common.h          |  2 ++
 drivers/clk/qcom/dispcc-sc8280xp.c |  1 +
 drivers/clk/qcom/dispcc-sm8450.c   |  1 +
 drivers/clk/qcom/gcc-sc8280xp.c    |  1 +
 drivers/clk/qcom/gcc-sm8450.c      |  1 +
 drivers/clk/qcom/gdsc.c            | 26 ++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h            |  6 ++++++
 drivers/clk/qcom/gpucc-sc8280xp.c  |  1 +
 drivers/soc/qcom/rpmhpd.c          | 19 +++++++------------
 include/linux/pm_domain.h          |  6 ++++++
 13 files changed, 74 insertions(+), 13 deletions(-)

-- 
2.34.1

