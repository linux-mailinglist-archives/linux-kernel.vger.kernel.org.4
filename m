Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81506DC433
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDJIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDJIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:12:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C44B40EA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:12:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c3so4435924pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681114336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnzM9U/2wJQYT1xeUJqeQOSExBa8HJ4Nk1EmXIm3SbI=;
        b=Wo7VTjUIxqauPd+nQ8OdzJK305Pl6QZIALYA0NuD2pQyglFJZq+iQf/kdsm6YLgNTi
         1ubTmat7kdIjDqY8OqyEI9jTmKeNEecNBahiq4cU1bYN1T2sTPOCd0USBF7bF0KryciJ
         8aY1bI1aXJabvL2OujCs1njJnRHrczh1YqqgTfiY41z5jhpHBJj16RQN2Rsk7FlkrFq9
         S7dcVyHEcOGuKmIHenJVS7ErRxh8Dp6C6xlKIIKk2Vc6Kl3jlYSKwLI3AVi9fmiOs5kt
         ITwwSCZSohI3+b7DEIrq0Xa5dS+JWIikrDBZg/KB1BJn5BD6qYHENJvKFOVSfickOgx0
         gLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681114336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnzM9U/2wJQYT1xeUJqeQOSExBa8HJ4Nk1EmXIm3SbI=;
        b=UNWOV0oqX6i0rEItFRLxo023JfaahgNXOTnCVPL8hTzFiAfpRq4wn+gOv+2M8npREY
         m/AFCJVcykVfbJTMB3D8w+cHCdXuMbN36FufshQRYzgrYmHIzG9+3EIRrgBqTWSeS5dY
         FuqHYn5G0hC9NCQEXBvW5UNGm66wfN8ga036+GBrrwZRDwVmWmmM6O+RInqOe1zS1ayS
         TZGwhiOJ2rhrpzGTwIks+dSRO33KgP3vzt+2rC9/A6GU9I7gIWCKs2wJnAKp5V0lwwIP
         8U0Blhdlqu0ymljsaSPTpn/HFPR3Dk8E99Etf7GJOELmhrBcni8vRDSTLgU7SzW65rzf
         vfzA==
X-Gm-Message-State: AAQBX9dU51bTi8r/z8Q4m7qZbQfK7MA+jgSlO40fTxDB+oqsEVpxGcQW
        U9sxX1l5h2/83NSlS62GtjDyXQ==
X-Google-Smtp-Source: AKy350bUord8cRFocB/vbhlK9SzXZDJ2j/QkcHG5lmGqHHghMRqOnOQcVFXpkHz7I2hXOeHd42c/YA==
X-Received: by 2002:a05:6a20:be20:b0:e4:9ac9:844e with SMTP id ge32-20020a056a20be2000b000e49ac9844emr9920455pzb.61.1681114336608;
        Mon, 10 Apr 2023 01:12:16 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id m17-20020aa79011000000b0062d8e79ea22sm7234100pfo.40.2023.04.10.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 01:12:16 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 0/2] Fix two warnings about rq clock
Date:   Mon, 10 Apr 2023 16:12:04 +0800
Message-Id: <20230410081206.23441-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fix two warnings about rq clock

Patch1 fixes the warning of using the old rq clock caused by
missing update rq clock.

Patch2 fixes the warning that the rq clock was updated multiple
times while holding the rq lock.

Hao Jia (2):
  sched/core: Fixed missing rq clock update before calling
    set_rq_offline()
  sched/core: Avoid double calling update_rq_clock()

 kernel/sched/core.c     | 11 +++++++----
 kernel/sched/fair.c     |  9 ++++++---
 kernel/sched/topology.c | 10 ++++++----
 3 files changed, 19 insertions(+), 11 deletions(-)

-- 
2.37.0

