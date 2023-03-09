Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7006B2BB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCIRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjCIRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:10:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9B28865
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:08:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so9838121edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 09:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678381681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IW6jOhEQae0VahvJ9lpEAcJtiLMnzIs5xUlg7BvZZk=;
        b=MPbJfhEdxadekYy9b0KrGA43OzUuCz3m1Mfe4CqfRt06h5tQE3UhRzGL7VmC2Up/Tn
         /Rg8Pg86KOgcgeFysVe3Slr0M/1L1hDTUs579QlIfPwed0aSuxiFMZOs+bDneufr1Pd0
         xX2gc19fi+CjAZHjpNQrvDD4Sd0S00KmPYQgHnX0DdwACU6/Hj6mckLrp1N3sLEqc3OM
         2pJ7lJco+ErLFnxaCpvLnvTGvd5DNrPjQrBgjjjSTymEjySBqisjhZRmSOzPqIluU5fG
         ZDPSxyHIvMftFl/Llj5KEw99MQW4ATui101kpR8sOOiYssOiABmblhDq0FrD2QkINSBI
         XwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678381681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IW6jOhEQae0VahvJ9lpEAcJtiLMnzIs5xUlg7BvZZk=;
        b=EA2Nyxvry6maDj2pHocc9/0V4CfZrDaWCbRbukg1aTeJKuFOtquLLtobhiCp2Y1n6p
         bn5EwOmjqF193C1RA3Kv69URXCcsWhmPTwUrWeviA2cgLriX+eUIpfz2qg+iIIqjurrw
         +keDXL+1VP5DOSxmGCjZ44k+IJXIPbHGVi4w5wOGQ5dfe3kaYvTVAFxSdtRGCBOJaAKA
         L5vPWTzN4R93AX8Uit039EXA+ohw3oxQQFGt4r8s3kavJfRkJGHYkpmHTtATAV8rcOYE
         TrWsFeUSC+bRkmqFdvB1jys5nM3ZjtICy6C44GUI5dIfl3nfDgahclYduEfzQpc/a1Y3
         NhjQ==
X-Gm-Message-State: AO0yUKU8D2xj9NuWcxtHGuT64XV3zk5y1UdHc58ger+YkYEhzmYHazr0
        jlL942razmNqBYuOvyIbjB60+8swsGpaJw==
X-Google-Smtp-Source: AK7set/A2XtQsaVyS5fbr8946mBTRI0WB9xHh0hBR0vCHiYcdihatOE+Y51jNuX2/nk3QA17uvQdUg==
X-Received: by 2002:a05:6402:716:b0:4ab:554:37ea with SMTP id w22-20020a056402071600b004ab055437eamr20660956edx.4.1678381680794;
        Thu, 09 Mar 2023 09:08:00 -0800 (PST)
Received: from lelloman-5950.. (host-79-22-154-28.retail.telecomitalia.it. [79.22.154.28])
        by smtp.gmail.com with ESMTPSA id bj8-20020a170906b04800b008d85435f914sm9154867ejb.98.2023.03.09.09.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:08:00 -0800 (PST)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH 0/4] sched/psi: Allow unprivileged PSI polling
Date:   Thu,  9 Mar 2023 18:07:52 +0100
Message-Id: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Domenico Cerasuolo (4):
  sched/psi: rearrange polling code in preparation
  sched/psi: rename existing poll members in preparation
  sched/psi: extract update_triggers side effect
  sched/psi: allow unprivileged polling of N*2s period

 Documentation/accounting/psi.rst |   4 +
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |  43 ++--
 kernel/cgroup/cgroup.c           |   2 +-
 kernel/sched/psi.c               | 412 ++++++++++++++++---------------
 5 files changed, 250 insertions(+), 213 deletions(-)

-- 
2.34.1

