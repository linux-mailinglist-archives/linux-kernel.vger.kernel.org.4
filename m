Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531565F7637
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJGJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJGJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:26:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B9A1176C6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:26:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso6727998pjf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDa4fYIyPpnZcWibGvKtypceWD40K8dmEbb3u80G0WI=;
        b=L40uxyR0CollaFGUsOY6UFpQoE7hzC6H4hwR6PpBjp1I7LWrmKmTsXtVJikTBAmJpl
         p39jjC02y4EE6Yq9+2SuvnZYdaGAjV2+96bVR++2hWXWBhzBLt7fWctyu8pDJVjLioEL
         QyBrtd6vbOZvQI7jHCVG7e3SRk8pdlZ/drC0sxtbhz8EEWCbC4Tq1BHejyackmdEZubB
         Ssr2zh8A+28AqEFKZu721RihY51Gi9jA7xrhB6tJisvD5S8g1RMfwA30Q50HFehD+FsA
         9uP6RfG5J/74jQq+ZrbvyIzQhfSGo7YGx5iNCe4IL/yPbJoMyx0yMoCby1GxPZ7VyyTv
         ThUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDa4fYIyPpnZcWibGvKtypceWD40K8dmEbb3u80G0WI=;
        b=y3WkC299MQMoN2B4kjLFoJaguhOe+FHK58aMvSjBMcPxBRHhjBR9GxFjzYANsRCtzF
         /UDCsf9XDMnjNeeiU6UZKoHlVY5rXo95+YOtM9GjA3ghqS5mWOe5AxAGThTijhj4RFfU
         zdZlMuTC+5CXfGxc8fvcmmkoErxgWH6b91xwRdtcAyyXcy37+Qd2zjLptXagwheyeGrv
         zQ4Jfh8RUPFGMYUmZxSbobe4iLNqvR3T/AHvxaX6GuAlw7VfWWa1N+6FRO7AZBAJO66E
         S06shyfP9KYhfG8B+nxzu5EPv18KJLCuMdwHF16kYk4N5NYBQL3nyB0da8p6+J0qdStT
         SmYw==
X-Gm-Message-State: ACrzQf1XTS9Wr5OajG+3dpoPEXpQuczDjgmB7TOEqRt6cPmkLZpRXqVQ
        7w0wY/yPzamEx8JicdsUWZwIEg==
X-Google-Smtp-Source: AMsMyM4lrZeF2gYZGijDyGwnJnt3Ew81JbBCVh1HfqgLs39WbwJTTWGlhAhILaunsy/Au06JxEGYCA==
X-Received: by 2002:a17:90b:4c05:b0:20b:a8f:de4a with SMTP id na5-20020a17090b4c0500b0020b0a8fde4amr8082457pjb.199.1665134787338;
        Fri, 07 Oct 2022 02:26:27 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b0016ef87334aesm1069394plf.162.2022.10.07.02.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:26:26 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 0/3] ipmi: fix ipmi memleak and unload bug
Date:   Fri,  7 Oct 2022 17:26:14 +0800
Message-Id: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

Our users have reported a memory leak. The IPMI driver consumes a lot of
memory.

We found this problem because IPMI was slow to release messages after
being disconnected, causing what appeared to be a memory leak.

Fix commit as:
  ipmi: fix msg stack when IPMI is disconnected

Two other issues were solved in the process of solving this problem.

1. Unloading the driver takes a long time.

Fix commit as:
  ipmi: fix long wait in unload when IPMI disconnect

2. Memory leaks during driver unloading.

Fix commit as:
  ipmi: fix memleak when unload ipmi driver


Zhang Yuchen (3):
  ipmi: fix msg stack when IPMI is disconnected
  ipmi: fix long wait in unload when IPMI disconnect
  ipmi: fix memleak when unload ipmi driver

 drivers/char/ipmi/ipmi_kcs_sm.c     | 14 ++++++++++----
 drivers/char/ipmi/ipmi_msghandler.c |  5 ++++-
 drivers/char/ipmi/ipmi_si_intf.c    | 27 +++++++++++++++++++--------
 3 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.30.2

