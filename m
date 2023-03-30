Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049886CFDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjC3ILH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjC3ILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:11:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F5D40CA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id er13so32217728edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680163863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcfsx3+lEOdU4JMFCIa3wAXKh+KcRIHf2I4sfnMfCSg=;
        b=n1ZbVFQRerQ/rBn131XWcKuy5vTJ8yoRHrm5xZW4N8ToHcJzZFn+1wCVgz/3ZRqA7h
         fRD75b/CZI1m/isb+dwQizQ6darfkWRJyN3kEXws8tnLt+GPtvqToysmbzPppj4zVDFh
         WTZQbh2yvRMq9/bRvP02ltkRahtzQ0hHM+EXoY7+H+OdAdNEUuQOawNac/3nCCyqgSDX
         0Lr55WZ+Duev2rUHFVXKJpDnbR+Yt9MCAWGWjiKsHblwWc9vAJ0a/pUnvSp1BerNONN1
         V/50MDBNsVlpc25x5sTVWe7VMXgQ94JXiIf2xN/2fBhbk9J+xsW+jI1HNtTQLBM6ZGMI
         VPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hcfsx3+lEOdU4JMFCIa3wAXKh+KcRIHf2I4sfnMfCSg=;
        b=2hDNW7R3afDXI6ZtRN7+3nD1SDDRhZKx64XcaEcyP2ZPuHTLX4f2eJhQbduMB0eaX0
         g6JFQ2Nb3CfdL1eeJQaZi3rKglYLmFO2DmtnqlZlPNT/7lmLe1yNfjGjheEU9B3Qm6dk
         6XFYmA1bbimtm4UmmYPCTNDtiiUAuULvVfmd0xUmMrvtOYI2eRizIjWD9YO1Y/mdbfFs
         fVbtgu9Fy4Zwi4ueLBbJecEs2n/JmCfhYMu+jBmlkSxd82XulFX4dsFc+8hVEyAFdvcz
         trae3lvDEyz3tMzUARKk/yAjXwBu6araVxYI69A6lLoBMejbjpZhcGp47D41HFnDuwAz
         g2uQ==
X-Gm-Message-State: AAQBX9eJeaUqDzAYosCgJbteVT1X35lX5mYm/0LeluaCCAL6C1eNNrLF
        nAfRtOeGnRgOMObHHiw7frqjEqliobQUeA==
X-Google-Smtp-Source: AKy350ZMXYunL1zqMNVOI4iXe/Wpr2wwuDXL2YgUdLvyyEKR804z5Gb+itjG9xtA3g9yiIraZZQ6UA==
X-Received: by 2002:a17:906:9f19:b0:93c:847d:a456 with SMTP id fy25-20020a1709069f1900b0093c847da456mr25947850ejc.22.1680163863466;
        Thu, 30 Mar 2023 01:11:03 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-1.pool80182.interbusiness.it. [80.182.134.1])
        by smtp.gmail.com with ESMTPSA id sd24-20020a170906ce3800b00931024e96c5sm17589672ejb.99.2023.03.30.01.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:11:02 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v5 0/4] sched/psi: Allow unprivileged PSI polling
Date:   Thu, 30 Mar 2023 10:10:56 +0200
Message-Id: <20230330081100.11871-1-cerasuolodomenico@gmail.com>
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

V5:
- few suggested code style changes in psi.c and psy_types.h
- fix trigger destruction logic now using proper locks

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
 kernel/sched/psi.c               | 458 +++++++++++++++++--------------
 5 files changed, 280 insertions(+), 229 deletions(-)

-- 
2.34.1

