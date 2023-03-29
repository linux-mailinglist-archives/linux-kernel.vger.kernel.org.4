Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071E56CECFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjC2Pdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjC2Pdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:33:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD6559A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:33:33 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x3so64912462edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66biUXmBUUSHKCNZLVuHZ9fR3doYSQvRiXeKOrB3jZA=;
        b=OeAZpcjJDky/tXcf7kE4FenhbpjfjKM+vaIRfMoNbpk0IPkVXPZQC7GhUNslotMoOQ
         lPrjgJz093PM9/np+N0rukxtnFFygPFnZ19N+66lNMc/7YvziOKuqWbnnX+yindByMaO
         8zdJCoNtylnsW5zVbuEtGx3GUKmHtg4dIEfN0JHxiXFKvGekNgb1xSVZojyjgp8MCtcd
         wKBt29+C2ZM9NThM17NEEm6Q36AMsfps0IT+nmVBtCWJ1glWEXyflW6ZrkD722Fg5vSv
         1ayi69VYvpgdlk1f5wrOzqWwbtF8RsmKH6PjEut3sQESby05JAocgxzXtKE+/YBpXdet
         rlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66biUXmBUUSHKCNZLVuHZ9fR3doYSQvRiXeKOrB3jZA=;
        b=HfAdU45MH/JZnDksFTPsQi7W5Dzx4obDLCQ94k7XBTXDqw/s3FmDB/p79cWHFPoDUZ
         TVsdzFoWD+sgPl9Nx+iY08fuJx2V9dMMsFXG5KyVc71ZNoxQWaHu4sZQLVqrBiLcfsoT
         bnsq4oB7QlUnLnnf1oRjiIgOInP9h9FPCCRX0r0IWUQlKBRaWbhORl8k7KA6IBz/2FCB
         VhH+Eh0X/8qEs46h2A7KeuurJn+U1MioSZIp2tabYL5Vt9pbrxflcEvakFmUupHh4m+O
         mBLWVfqze2uu+5KJQDcWbfg357i0wmpVauvT1JPFXmb/7smv+ZZaMfejqWg94Z80a35P
         zTkg==
X-Gm-Message-State: AAQBX9eaSPo6lRrzlEtL2514FP27ADxCNCkohppztKH/D4y2RjSGRDuV
        CW0jH/f0oSXKF/oRc8EXHI5Q2IMvbKsdeN49
X-Google-Smtp-Source: AKy350ZN5BTDEySZrVeoNiKEAr12khzmJiOyqwYZGMBkWh1IR0cv8YLpCBBT63BnjG2yHxZhQrmtxg==
X-Received: by 2002:a17:906:7189:b0:930:6591:15ee with SMTP id h9-20020a170906718900b00930659115eemr22105597ejk.10.1680104011222;
        Wed, 29 Mar 2023 08:33:31 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090670ca00b0093b8c0952e4sm10193735ejk.219.2023.03.29.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:33:30 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v4 0/4] sched/psi: Allow unprivileged PSI polling
Date:   Wed, 29 Mar 2023 17:33:23 +0200
Message-Id: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSI offers 2 mechanisms to get information about a specific resource
pressure. One is reading from /proc/pressure/<resource>, which gives
average pressures aggregated every 2s. The other is creating a pollable
fd for a specific resource and cgroup.

The trigger creation requires CAP_SYS_RESOURCE, and gives the
possibility to pick specific time window and threshold, spawing an RT
thread to aggregate the data.

Systemd would like to provide containers the option to monitor pressure
on their own cgroup and sub-cgroups. For example, if systemd launches a
container that itself then launches services, the container should have
the ability to poll() for pressure in individual services. But neither
the container nor the services are privileged.

The series is implemented in 4 steps in order to reduce the noise of
the change.

V4:
- fixed psi_open leftover usage in IRQ accounting (patch 4/4)

V3:
- restored renaming patch (#2 of 4) as suggested in review
- rebased #3 and #4 on the renaming commit

V2:
- removed renaming patch (previous 2/4) and applied suggested solution
- changed update_triggers side effect removal as suggested in review
- rebased core patch on other V2 changes

Domenico Cerasuolo (4):
  sched/psi: rearrange polling code in preparation
  sched/psi: rename existing poll members in preparation
  sched/psi: extract update_triggers side effect
  sched/psi: allow unprivileged polling of N*2s period

 Documentation/accounting/psi.rst |   4 +
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |  43 +--
 kernel/cgroup/cgroup.c           |   2 +-
 kernel/sched/psi.c               | 434 +++++++++++++++++--------------
 5 files changed, 263 insertions(+), 222 deletions(-)

-- 
2.34.1

