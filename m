Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1D6D0FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjC3UGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjC3UGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:06:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9751040A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:06:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so81103382edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680206781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cSZDIQT19TuAOD4yPAjxwue6/4LocysQ+ii6DVPBa8=;
        b=guzQ5DNXzxJfxqkr/QipTiRpyJh7NimJbxe7Zpvc1EfoPZ7AA2QcRhoTUHf72ZF8bH
         Ca+51v6VwF5gLJgGH1aUL8bu/hAnR2/N+nhXke0/oU9oKRVgH/CSx2JDYa0u8O6yeqe/
         pVp2ZwRWNriNsBA15mu5eMn4R0HWwjwgUB3F4LuNXV4nBLzjXclKMBSG/hyU7r0UtW5j
         Wqlp8wuleX21Vka6Z6xAwLJybhZaRoAhd9aF9qVNpMR19YhwT5Jw6epeq278X/JxVrCc
         Ca9JmCMvD9TzYYRHMFVlN6h3G6vDuQgUI4VxGEc/7jwwrcq0AA03mPq0wlsT3jjInnj0
         Q+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680206781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cSZDIQT19TuAOD4yPAjxwue6/4LocysQ+ii6DVPBa8=;
        b=U8/5yv5FpdJEQW+pyGYpsV8dGvohgrUhSzvSn7tRk1805z6DDka/HXr26WkGYu/IDZ
         KIOecEYPISWl/6jyPracUp5R+1NX0bGJyEVLk8gJBRBfFqJd8+2pTHlspI4U8xX8ScPn
         ApL5TQltKgXEcfLuZ4C5E/iE5hvsczPMNRg5m/6qW8PSPmKvlteFU5+0ysGp3qtimaRa
         LcIJdtVoj0so1QP4rDPOzv2Pu36gLNBHCYQL8SbDhhXyXAam1hnO52bh3t04mcKp9NS3
         tfg3RVk+sWm9/7Vm3BIa7CvTkk9M+UWFI+CxQyVq3nfTr6m3Imi28ruir4dPRlFsuY2H
         eS4w==
X-Gm-Message-State: AAQBX9eiNeXKTRTLDx5qprQFlQ0ZSdBIf29kAi94fzj5wiPU1TDQ5P0N
        Psm1XQVguyz2Hqp67O7YlEflJgYqMdOTMg==
X-Google-Smtp-Source: AKy350bAaEbUSuzdF4T6gnrPX/r4haVqBFge8+z2P79Kg4gaUqgIThxWkyQjW5rFv4cDSSy3qenzFg==
X-Received: by 2002:a17:906:c0cc:b0:93a:353d:e38b with SMTP id bn12-20020a170906c0cc00b0093a353de38bmr25350941ejb.37.1680206780697;
        Thu, 30 Mar 2023 13:06:20 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-1.retail.telecomitalia.it. [80.182.134.1])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709064e5100b009312cc428e4sm161101ejw.165.2023.03.30.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:06:20 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v7 0/4] sched/psi: Allow unprivileged PSI polling
Date:   Thu, 30 Mar 2023 22:06:10 +0200
Message-Id: <20230330200614.132354-1-cerasuolodomenico@gmail.com>
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

V7:
- fix code style in psi trigger create/destroy aggregators paths

V6:
- fix trigger creation logic now using proper locks

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
 kernel/sched/psi.c               | 443 +++++++++++++++++--------------
 5 files changed, 276 insertions(+), 218 deletions(-)

-- 
2.34.1

