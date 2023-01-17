Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8166866DB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjAQKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjAQKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:51:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD830B0F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:51:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q64so31962269pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qv3+yV9+eofjieTuH2mVG8C/taeKBT9SvSjPfL56ZFQ=;
        b=aUCvEg0B+P31h76Y3HZmMoUkBhEyM8cjPKMpyQGD/5/mL68U8QjrRwILQmQK1fPPrw
         q5AkaXPUYBcmEH/a/IZqBG39DMI+pxzbggyXGvUiiF637j+CXHn3Sn2Zs6qdfjo9xHg+
         BX4EJe87AtemE3Rf+cxwpyp8OVTNgUIJecovJy6seClAvW1PI101ZjhNUv3itaDu3Kwt
         2STJKajSfd1qZ1RJDo08BN20OerLeqNipFlEit9obY6pUxHIAKQbdFhzigORhhxjgdSR
         zp3kW99Q7J0v5n73n2xSPHnkFr8SVsPw2CHv/FWCps/1qr6+uBSAhOGl2acA4Mv0pC0M
         /LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qv3+yV9+eofjieTuH2mVG8C/taeKBT9SvSjPfL56ZFQ=;
        b=wMVv4HD/a8nEWbzi1p174tORQsRYcGvM03aaRhxv0CW3m1erJDFULq9QTq5FQMRcC0
         sL9/t0EW++SkWNSVYGTSCB0UHs1h0kfWEDD8p617onY5hNaIm3BYpNoDXVhEb7el2ROb
         9yGzICL1p+CZwmWbVqbMPX51qwILx++f2/QQAW5U3CKQxAIgK7nxTzYQ9ANp6rD8L1R3
         hNZQPzmbKTeZC45twX9kNziCV5qu8GvUQKuSoswYWzDnF77zZtNjwy6odIc/b3gvSmdI
         FIrbNyghHGbkJ/Q0UOfbVZVDoqY2kGU0Q7gIJb9w0oO3oDOBhlcu4+jzH9ycDtcnjnEA
         kFBA==
X-Gm-Message-State: AFqh2kpOwYy1oSU+G8S95XYKKi+iBCvN+ncqfslEhcyCHCD1AEbmm0FL
        voDc5GPJ0SoMGALQlrKJFkxVUQ==
X-Google-Smtp-Source: AMrXdXvg6bn70HgdVxCt2dJQKYms9v+nzSHw+WudL3Q2o3TXVQMlbY67oLgZJW+pXpou9mmuenBI0g==
X-Received: by 2002:a17:903:2596:b0:194:7a99:d5cc with SMTP id jb22-20020a170903259600b001947a99d5ccmr2907711plb.12.1673952698120;
        Tue, 17 Jan 2023 02:51:38 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902eb8b00b00189c93ce5easm20848645plg.166.2023.01.17.02.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:51:37 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH -next v4 0/1] drivers: base: cacheinfo: fix shared_cpu_map
Date:   Tue, 17 Jan 2023 10:51:32 +0000
Message-Id: <20230117105133.4445-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
--- v4 ---
break after we find the shared instance.

--- v3 ---
Remove unneeded semicolon

--- v2 ---
Rebase to the latest Linux codebase

Yong-Xuan Wang (1):
  drivers: base: cacheinfo: fix shared_cpu_map

 drivers/base/cacheinfo.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)


base-commit: 9ce08dd7ea24253aac5fd2519f9aea27dfb390c9
-- 
2.17.1

