Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEEF6D0230
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjC3Kyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjC3Kyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:54:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269A7A9B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:54:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t10so74600568edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680173672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqUGHUrm43RLGTh9JpU7D6RY+mMjCNqmEMvavWfCE+k=;
        b=i1tw7IUVN9J9Y//YEW9fGNzDVe3ddS4yYbipPUepEfbMEZlq8mlqN21Jl/M16PXRt7
         DeTeWG2DWMIW3M6PBoidWqmVoXvgdStRpQkKYKi5BCjvjqjivQJfPfPIlhMg5KgMgyKj
         /ZWfBOZ8ROIcunQTF85L0HdzSjL9+QytM7rUJTt37i7uH5y7+ItGE7aHKQkWWhsd2Aix
         xd5vCSYmTOdk87iH8CVkgyOuXhnIivhuIrG7aYs2wKUJ8KPJugdGB22d9NCT4f1Sz1pb
         ExtdYYaLl/eETyz52i9nfrIYn0ZzmoKvWV2W6W7J6omzTvcVf6Qkb6+CX040FRLTq953
         Flgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680173672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqUGHUrm43RLGTh9JpU7D6RY+mMjCNqmEMvavWfCE+k=;
        b=QRDW6x4Me7WQdctzu1vYNGBy8cTFTBmTTQOUhWZu5ROiAsACvPICF+KWgXk96GTPgN
         9QK/aHyNRs2yNunXywdXgo3jFG6fSg0WLEdXqbls5sMVXTSf1zsoJIGoBeNT6fv+3wKz
         LDhy7XV5dge7Ll061s32o5hbHFeLvBOP1QRpuHfr8DOJiNXTc/nNxiYsIRUos0MoA44m
         4GwXD8kzguzydFxPR4DuzFkorJ3S4kQKXwa4I1vmzQd7u+cp+jyf8hqoJxEaFrWn9tB7
         pbGh9DyJTEsHzdEgYOo8OPctrghAbgIe5AdYKODFOzZd5aLyG/Sr2e9ZCZ4hSkUasqsE
         c1Tw==
X-Gm-Message-State: AAQBX9eGsPZLbfU/uh4d8NX5/Mb21kawyOiv47S53D8nVLXoMMXuqFTm
        ZOzfS9bGVWwMYzw2avTAKnt7RAKf426OcA==
X-Google-Smtp-Source: AKy350bzKEQCG6GDsYiBs9L2k+YnYWevEj41NyveTFA56DrwWQFNl8Fd+kMU/hKFZhI4nR5pthnZ/A==
X-Received: by 2002:a17:906:980b:b0:932:4eea:17ce with SMTP id lm11-20020a170906980b00b009324eea17cemr23754693ejb.39.1680173672274;
        Thu, 30 Mar 2023 03:54:32 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-1.pool80182.interbusiness.it. [80.182.134.1])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170906b88600b0093120a11a5dsm17639628ejb.92.2023.03.30.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:54:31 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v6 0/4] sched/psi: Allow unprivileged PSI polling
Date:   Thu, 30 Mar 2023 12:54:14 +0200
Message-Id: <20230330105418.77061-1-cerasuolodomenico@gmail.com>
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

V6:
-fix trigger creation logic now using proper locks

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
 kernel/sched/psi.c               | 473 +++++++++++++++++--------------
 5 files changed, 289 insertions(+), 235 deletions(-)

-- 
2.34.1

