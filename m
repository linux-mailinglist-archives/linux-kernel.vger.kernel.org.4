Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B667CC01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbjAZN01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjAZN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:26:23 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967A1700
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:26:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q10so1772308wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CgZCmvfGO3SPQAtQLahtpu87ciTMKtyvlqYrbLNGhD4=;
        b=UuGyR9NUP3louI8CYUsVL/XR8XK8kubDZF1PlK4dgaYGlPlzS15qnp84HUHRgduieX
         arVlhSwwEINRzOl0n/IsjBatoSj+M1RarZYY/aY59YEXfzx3nA5VPWXuZyY80iV1rJhq
         H9aMZ8li9MMxFltAOc8Y5cJi0wSNzHOAkNW1tQ029Qlqbp4QDTUK7JeYillCDM4uqY36
         KVfX1FTjPQJ+v++jmXnleoJd9M3l7KNGVvCaDk43Jf/RXFhJXdY1i7hA8xJl+8y3OUQm
         ZypbQiPeyWsQJASovwSlULNV8D2JtFLNk22MoGxcvYO/o6Ya2khs6M6AB4yXjWCTNne8
         ul9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgZCmvfGO3SPQAtQLahtpu87ciTMKtyvlqYrbLNGhD4=;
        b=FjSSt2z/LKVjJcCKvD4KlJNd9QvvHvdyPvmIa2vqq5NUyJkDBgkPExw07I6aabFNF9
         XU/8yKCwyrchBIV+Vj0V/568gOB5tQpNWqUZxgNcwcy3Vm1D8IYcKxNKh8OrQEAtZ9Gv
         NMeKKg/96IOG/35fdq4nuq1cDUDNhMGiGC5IoqTySIO8wWLEVVNqLLvsRJ5u3ZWdMLiN
         ZU7Gpm9HQX67Azuiaq8wJc9gVKRL+nf8d+uVTjsyOeEoZo+mQA88DqfIhU7YByyJkMcG
         tl3TdX/W26yKSysxhqUbZ2JNE4nH3W4MRU0ExDKevIoqXJtUq2b/rNsj6RuR1WMfE0QQ
         z5gQ==
X-Gm-Message-State: AFqh2koO5L9yTwMPyrEgZ3akEf/2oif3CbqNiKV+fBrDXC44MTtuzUSJ
        kM6jczT/Pa+wLnOzBtZuj/ZtZQ==
X-Google-Smtp-Source: AMrXdXthCp8w1hnTv74k4Zivout9X76Tna2PMqBTt8A6wHuhcQuRU+5h3NwDadJnyOe4Oq8Jz6TuNQ==
X-Received: by 2002:a5d:6f15:0:b0:2bd:fdd8:2d0a with SMTP id ay21-20020a5d6f15000000b002bdfdd82d0amr37524998wrb.40.1674739579143;
        Thu, 26 Jan 2023 05:26:19 -0800 (PST)
Received: from orzel1.c.googlers.com.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b002b6bcc0b64dsm1326108wrq.4.2023.01.26.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:26:18 -0800 (PST)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, rad@semihalf.com,
        mw@semihalf.com, upstream@semihalf.com,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>
Subject: [PATCH 0/2] net: wwan: t7xx: Fix Runtime PM implementation
Date:   Thu, 26 Jan 2023 13:25:33 +0000
Message-Id: <20230126132535.80339-1-mindal@semihalf.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d10b3a695ba0 ("net: wwan: t7xx: Runtime PM") introduced support for
Runtime PM for this driver, but due to a bug in the initialization logic
the usage refcount would never reach 0, leaving the feature unused.
This patchset addresses that, together with a bug found after runtime
suspend was enabled.

Kornel Dulęba (2):
  net: wwan: t7xx: Fix Runtime PM resume sequence
  net: wwan: t7xx: Fix Runtime PM initialization

 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c    | 11 +++++++-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 29 +++++++++++++++-------
 drivers/net/wwan/t7xx/t7xx_netdev.c        | 16 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.c           |  2 ++
 4 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

