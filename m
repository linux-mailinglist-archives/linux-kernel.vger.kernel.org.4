Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FCC5EA9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiIZPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiIZPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:14:15 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91626F7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:57:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y2so4081542qkl.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fVdpPr3f8bRd7B1cM3PWSFoALdvL6AntNtNCVepwQ2Q=;
        b=1d9f5RsBJxy54KAvlvlDlqBnvfh09snGIaY+6tvR2PwJb8W2/H0yK3jGriNt2JmahM
         gqWhIFwuh0UZ+C2UumnkbJWyJ6rDK2pKaxW3puzSUzrz7sSlzakzLN6njU4R/pYzJSIB
         EuFwuwSTppmZFSyDEE7eJVdFYUo9Et/OiqExxX95fifd0xJ6t8vDLsVCXFg8equ7uAz0
         iNmSSjeT76pA7UVs2IMoN/Lf9vxrk+ItFKLIw2pndSHR6oVHp4yIhTQmVRrKY9KJhjkm
         lN8vWWAsrcoQtS+NIFmjYmsrjW0h5S5vkeXtfCCVgzk4o8/Emjt6fufYXfGeZs8kzjQ0
         xPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fVdpPr3f8bRd7B1cM3PWSFoALdvL6AntNtNCVepwQ2Q=;
        b=xP1C0NTk3P0z+DYgpdxITQkoWXZwsnZO4/O4gBOMzPha2VDPVtau0KQ2AEu7ztztnK
         VA/97fdCBwGi0MQTmYCygtoDyKwNhZacs+PzhjL4JrwnTUh7rCFtFo1z7v9+cIq53NUm
         ncDkFM/ZnkZWLRbQnMgO+AKPGabncNv4Cx+0T88h6kj3chOGDXthCKGpGOtA2xGfMU2V
         0buPpQJEbazJ2aLyTcP5Y75ESuNe1XcGrfv5VzeA6NeTyRyH13j2xbJmZZBLrVN7XsWj
         J9KGVavfJqSKAl/YLHg/edRHK2fdlrgKzPSbCLqPf7dpmQQsdh4ISxafMr4T9b+y9z8n
         VrVA==
X-Gm-Message-State: ACrzQf2bjmczsQi6rrxk+K8wS4a6aljWDTZawKzhObKzLPr3H2FwfNvB
        cpSVIp0tmgwA1tdweNgKLSKLuA==
X-Google-Smtp-Source: AMsMyM7NXtNo0d4ehct9h5yaCEQocmeph8T7MmSmFEzl7jaAbmRg6rcj6l4GFeWB8/X7Wf56XopM6w==
X-Received: by 2002:a05:620a:24d6:b0:6cd:f96a:35b with SMTP id m22-20020a05620a24d600b006cdf96a035bmr14048238qkn.471.1664200632354;
        Mon, 26 Sep 2022 06:57:12 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id l27-20020a37f91b000000b006ce580c2663sm11598075qkj.35.2022.09.26.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:57:11 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] memcg swap fix & cleanups
Date:   Mon, 26 Sep 2022 09:57:00 -0400
Message-Id: <20220926135704.400818-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refresh of older patches that fell through the cracks.

Applies on top of mm-unstable.

 Documentation/admin-guide/cgroup-v1/memory.rst  |  4 +-
 Documentation/admin-guide/kernel-parameters.txt |  6 --
 arch/mips/configs/db1xxx_defconfig              |  1 -
 arch/mips/configs/generic_defconfig             |  1 -
 arch/powerpc/configs/powernv_defconfig          |  1 -
 arch/powerpc/configs/pseries_defconfig          |  1 -
 arch/sh/configs/sdk7786_defconfig               |  1 -
 arch/sh/configs/urquell_defconfig               |  1 -
 include/linux/swap.h                            |  2 +-
 include/linux/swap_cgroup.h                     |  4 +-
 init/Kconfig                                    |  5 --
 mm/Makefile                                     |  4 +-
 mm/memcontrol.c                                 | 79 ++++++++---------------
 mm/swap_cgroup.c                                |  6 ++
 tools/testing/selftests/cgroup/config           |  1 -
 15 files changed, 39 insertions(+), 78 deletions(-)


