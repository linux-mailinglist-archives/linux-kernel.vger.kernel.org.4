Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441095FFE88
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJPJ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJPJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:58:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C92FC04
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z20so8388331plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtzY9AfvtG9xTgyGyHBnIXaAiiTuXFCltxImevKgkqM=;
        b=kZM/bndEKtYZijRanfxD1Z+Sf4sTpaSccjAzYHXv/rMYVsufpaab6hBFkzyavqDBTX
         0CBqFm1Wy/jzMNK5SQMI1bvoTLSlH9JW4dsUOXw1Kg3/JvQOcFl6rYTa/ba0jP0LDJ8Y
         oLLqnmayYKm4ExXowfk4CrwfomehgboEhOGMVj3h5Aj09hSSBRasCsCkZJ8HCj2XytoG
         9fkeisH4wX9bweAfmo9fM2m2/p3stboXKE9fQWJBrBF7Szx6pnImFe56/O8gbKPH6AX/
         UAIFRwED11tWPijhsTaJ5ynnSwNWHLHR3h7XZVrrd61FX3I65X8HXewPW5rbJGc8euuo
         6scA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtzY9AfvtG9xTgyGyHBnIXaAiiTuXFCltxImevKgkqM=;
        b=VK4ev5wuRX7FvK0vm9bINT0dY857xH8qLolcJ37ofogvhYjyDmW0dNmDUeSCAv8xaN
         BSxiqSnk/0j5fOV0CgJch03XqyoTC1EX18o031m5ye660APKFKAnzFLWBcuyQMetLkf0
         0Oae+K6GsOMFMeCJURaY4tJFjT/SCVm100b6cC2om+47usnFerHy1vN+470CKJid8CXR
         SkcX4jSkrQSUufNWrUpTO2pOLvOflbodv41SRSUoWTBVJd0Wx+pXukEPe41s7v4GRsaN
         VM2C8jcW1z62P2acypDwyM4tD/7jduipuPBSHqiYzQ54l2JzvAXBN0h9RpafcUYQdK41
         Pl9w==
X-Gm-Message-State: ACrzQf1Pzzvnsu1Ovj8FybeysqhwAVURIooUj+zrIPLJ5rAC+Xq44PJj
        8aQTod04pWCErTF0M2FCmDENiO9yCF2HUw==
X-Google-Smtp-Source: AMsMyM4RdVjokxZyQinSeGmUgZIlLlBTWY8+LMqU0RtxFplW7uEesRom6zx6CveHQx9ymnlr2yl3QA==
X-Received: by 2002:a17:902:e982:b0:17f:ca1f:aa44 with SMTP id f2-20020a170902e98200b0017fca1faa44mr6388293plb.76.1665914313066;
        Sun, 16 Oct 2022 02:58:33 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001745662d568sm4481838plg.278.2022.10.16.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 02:58:32 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] Manage domain power state for hibernate freeze
Date:   Sun, 16 Oct 2022 17:58:12 +0800
Message-Id: <20221016095815.2550034-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The series tries to fix a hardware lockup issue caused by missing domain
power state management from hibernate .freeze[thaw]_noirq hooks.  The
detailed description of the issue can be found in commit log of patch
#3.

Shawn Guo (3):
  PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
  PM: domains: Consolidate genpd_restore_noirq() and
    genpd_resume_noirq()
  PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq
    hook

 drivers/base/power/domain.c | 130 +++++++++++++++---------------------
 1 file changed, 52 insertions(+), 78 deletions(-)

-- 
2.25.1

