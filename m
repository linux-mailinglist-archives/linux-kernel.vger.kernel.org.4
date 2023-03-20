Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959026C242F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCTWEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCTWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:04:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898706E82;
        Mon, 20 Mar 2023 15:04:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso10056823wmb.0;
        Mon, 20 Mar 2023 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679349841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd+0yFoDQRRfF746bj1zFlYrl0x8mzuqf7vBafk+Hqw=;
        b=SIrReicCWw3sgX79+J5Uj9k2KBNVe5gwIe/jmTLbIK+LPGPOPlrgrflEZiM6XweaLO
         gSQ1b/OF40VRP+wAVHwPrLyuBosXRVprcC7uiYwr1E+zDg8PEvb3MmmfExwK9XnU419x
         m2wvNTZ5BPzXd69IQ6hsS6wABpOY5OHE9VuxlPPvpzLNn1Gy75IGbMob1FivAXNKKzXz
         3oWy2IqWfJk/mebNVp7zIsAoX25AcQJbgg6Nh7IudIJwzR9HV53bW8YjHdZ2kP47fZbC
         WZfOb0vdXc7YTbzcYsPOZpfPo7UnxPgCMtPpV3ucuEwzDCm/z21OEiA38a/BW5FG/2Ml
         rhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679349841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dd+0yFoDQRRfF746bj1zFlYrl0x8mzuqf7vBafk+Hqw=;
        b=faHRkQb8tpLUTz3rosRYbUyFi+futIvMv04otHWd8DXyQ4S65JWT7Emr2DJUaQ9agT
         foyWZUrJyBYMaP//DnFipR6uEeoPZEDmGLEV2J0EwwxlyB3oTlfj8bpUdHxjELos4tN5
         5gcREFuVDNfXEOmdOArZ/WF36iOzMc14C6Pi1qMvzR4didbngjPatHXYx+UdaR8Qouvn
         IjQOgFuuJCSAx1UTDKjoRNPB8tDEI41STDzweJq7+FtYgxcR9P7Uv1w1YR6UCVt1yXru
         ywn7Us+RRy9mneBI7RioTiv0vpdkpuW19aMNZdCFLQ4Ns16QrEtmmhWRxQmjq6kceC4A
         EhTw==
X-Gm-Message-State: AO0yUKUZLPtMgBF0X7ODpmbWpL8bnwYiycLgqOAJOYhAdvMnGlDGf+xc
        w35gu4mwsu+BxerZ9cJm1kE=
X-Google-Smtp-Source: AK7set8zlBPMrHqsP9WrvynboQImEg2FimQ589tHigxE/nHHnYCbLMyA/wPU8dMxU2AtwdfnXX9V5g==
X-Received: by 2002:a7b:cb91:0:b0:3eb:3f2d:f237 with SMTP id m17-20020a7bcb91000000b003eb3f2df237mr714741wmi.6.1679349840869;
        Mon, 20 Mar 2023 15:04:00 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b003e7f1086660sm17868386wmb.15.2023.03.20.15.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:04:00 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     lee@kernel.org
Cc:     dmitry.osipenko@collabora.com, jonathanh@nvidia.com,
        treding@nvidia.com, richard.leitner@linux.dev,
        benjamin.bara@skidata.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mfd: tps6586x: register restart handler
Date:   Mon, 20 Mar 2023 23:03:43 +0100
Message-Id: <20230320220345.1463687-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Hi!

v1: https://lore.kernel.org/all/20230316164703.1157813-1-bbara93@gmail.com/
system_state: https://lore.kernel.org/all/20230320213230.1459532-1-bbara93@gmail.com/

v2:
- use devm-based restart handler
- convert the existing power_off handler to a devm-based handler
- handle system_state in extra PATCH

Best regards,
Benjamin

Benjamin Bara (2):
  mfd: tps6586x: use devm-based power off handler
  mfd: tps6586x: register restart handler

 drivers/mfd/tps6586x.c | 47 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

-- 
2.34.1

