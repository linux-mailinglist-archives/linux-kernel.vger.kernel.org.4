Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C206CD3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjC2Ht1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjC2HtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:49:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937843C07
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:48:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so59684372edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680076128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6PSanKfEjUCF+wMJiZb9jTOHMRYb1B7bf72IpafPgQ=;
        b=nIClPvIBQjGx43osJmd4bd4NYwWHaqCw3TLEupYo2NeUePaQBkSYFxdJlO6feo5seF
         MhNNlQ4OC8qQCYMlFCdDqY3GJPMc9wh67boKBh4iv2I2xbRB0qpG04dsTmvQQQkw9Z9j
         ai2XX2+gZsOB2lCNzMHA83fly3HNQjWEgeZ5XP8hzDadirM2DTfQ+Nz3TPkR9CH6DnL1
         7mdZQqQiqW/wDDVYnlVXV667RROcQPdNBsf6ddm59Kq6NSYMriw0ejfYIkKZ58NR9iRV
         M1zDxgbt0uxx7tGBy6NTbhZkE92avlV8uwaZw4Mjk9xNxRD7/KhrydVR5qUeVYn4hEBl
         WEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6PSanKfEjUCF+wMJiZb9jTOHMRYb1B7bf72IpafPgQ=;
        b=achvC2goNMzgAebu0/HppOj4WwDsMwzTldEwClclHwz1eZpscCVNZNoQa3aCfSJ+5J
         pUCzV9jaOwvxM7GpmQYLbEs7+zEcfr/HBuNu+Bn4WieN+4Ody/HCT9GQpXbWTBBzCyMP
         14dfubg0TS53M8Bz+PuwdN1uHxXy4avXhxIL9w8K5f8j7f51CNhHexEORCOW9XCqRA9z
         fx7iww1Gxjq/MdtDRPgUcSdg+pafIniWE9Ao7GjWviLSyHndqpzQ66cGKwb0pccVDDnN
         QRNe0grbWiMBlUbOUn3LbhrDoREuJpqwtm001Gz9+dAzBeysJumoB4ZShh6zEdH3JwS2
         OhVA==
X-Gm-Message-State: AAQBX9cbKI//uum+K2DHmi+zFqbqnuSWPlPR6I2qhVBRYwN80b2VILrp
        gIzmex6DpH2RwXHqRa6nzYtIAYH7Zw78Oe35
X-Google-Smtp-Source: AKy350Z0X2IXdmYKrw5GowOyiG/ii/8WHIlrRew4s+DC/3EgtIV1fuS//h1FQs2QewO25fQt6R3KRw==
X-Received: by 2002:a17:906:c285:b0:88c:6345:d0e7 with SMTP id r5-20020a170906c28500b0088c6345d0e7mr17134267ejz.36.1680076127630;
        Wed, 29 Mar 2023 00:48:47 -0700 (PDT)
Received: from lelloman-5950.. (host-79-13-135-230.retail.telecomitalia.it. [79.13.135.230])
        by smtp.gmail.com with ESMTPSA id r12-20020a50c00c000000b00501d2f10d19sm12208300edb.20.2023.03.29.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:48:47 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, surenb@google.com, brauner@kernel.org,
        chris@chrisdown.name, hannes@cmpxchg.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 0/4] sched/psi: Allow unprivileged PSI polling
Date:   Wed, 29 Mar 2023 09:48:38 +0200
Message-Id: <20230329074842.16209-1-cerasuolodomenico@gmail.com>
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
 kernel/sched/psi.c               | 432 +++++++++++++++++--------------
 5 files changed, 262 insertions(+), 221 deletions(-)

-- 
2.34.1

