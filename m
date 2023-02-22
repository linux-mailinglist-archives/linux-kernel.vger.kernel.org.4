Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2255269F322
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjBVLG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBVLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:06:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9D38E8D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:06:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s5so8266897plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1oUqD0B64LlWvcXDAVUy8knDp8BntXqrwMmbwuCMIXE=;
        b=AJuFkwEAxJqTvcWtbcKGitPp65vJFpUAVoD55ms83WfeK5P/O2MwPkgBHOJU3OL1I1
         J8nTp+lYAu66PvcOZPfsSjXLljNl9t8NPE8h1iw/+JYzltoBd5Y9d6rzmIEzr3uJmKx2
         thTmaIJTSkIfltYSRBw7Gk0thbjxXXPdCKCxLgLXQAHfx5eP2gXR1VXTZn5Aw4e56s8i
         XCacgCcSierk/XXdPgFlUvLf5O2qeO2TIXFHL0XbgobpNRbISuJwPJC8dB13CtO4lms+
         V5UdRmIDrBg5EdrudTseL+awwxR40OHd1jX2FQMJW6cp796ZsgtY26LqMF/PVVZnSzaM
         WChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oUqD0B64LlWvcXDAVUy8knDp8BntXqrwMmbwuCMIXE=;
        b=JngeHwEOnf2mWnF3uZ1uIlDvWaN/CSWTjcwwPaelqwXSrtmi2kp3JnGdJZCq8QrYJf
         OLpwbJpNFxnpDdIUaZmCCRwmojEoeAs9daFNSluOPRDLxsluA9uLlMLqWfsBhRzec4Kb
         HIUb40ExGqS6e+D1x13Ku3c8mgaH8patyqAFVqNJO8BRJT6m1SNLnJI13x0wGYoladfu
         iolp980M+bL3frxmlFmUhCZbGpPNdImHTgkIcL1p8uen9CgYNewPgl/FSA3ag5mK4Ewt
         tKo0b5o4ZC5UvuFHkJyLy5Akdjh66iocbAwtzBbQ4hxPmV0M2stGLZKo9SyRz7ACqvlC
         b8Mw==
X-Gm-Message-State: AO0yUKUhXqM+V2Q5tDBFsgjl+5YRYu+rUkNFZENntQQrzd+WfMjfLcZ3
        +8plDfUlA99X2Zg1EHhAdaLmTQ==
X-Google-Smtp-Source: AK7set8w5uB5oVrK46eH/7ewYH05ix11gutzKyoIs5e/5yDFdMB1ZyJ/Po/cZPKBstyl0S22HiK5IQ==
X-Received: by 2002:a05:6a21:6da0:b0:c0:af73:be4d with SMTP id wl32-20020a056a216da000b000c0af73be4dmr10019546pzb.54.1677064012307;
        Wed, 22 Feb 2023 03:06:52 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b005a91adff67asm1324429pfn.175.2023.02.22.03.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:06:51 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] OPP: Simplify set_required_opp handling
Date:   Wed, 22 Feb 2023 16:36:36 +0530
Message-Id: <cover.1677063656.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
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

Hello,

The required-opps configuration is closely tied to genpd and performance
states at the moment and it is not very obvious that required-opps can
live without genpds. Though we don't support configuring required-opps
for non-genpd cases currently.

This patchset aims at cleaning up this a bit, just like what's done for clk and
regulators. This also makes it possible for platforms to provide their own
version of set_required_opps() helper, which can be used to configure the
devfreq device propertly.

Jun,

I haven't found time to test this through yet, though there isn't much anyway I
guess. Can you see if these can solve your problem properly ?

Viresh Kumar (3):
  OPP: Handle all genpd cases together in _set_required_opps()
  OPP: Move required opps configuration to specialized callback
  OPP: Allow platforms to add a set_required_opps() callback

 drivers/opp/core.c     | 113 ++++++++++++++++++++++++++++-------------
 drivers/opp/of.c       |   3 ++
 drivers/opp/opp.h      |   4 ++
 include/linux/pm_opp.h |   5 ++
 4 files changed, 91 insertions(+), 34 deletions(-)

-- 
2.31.1.272.g89b43f80a514

