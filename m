Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA5F6FEBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjEKGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:53:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27F46A6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so54991385e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788013; x=1686380013;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnSwAOoxlqKsXEXi0phXp7gBU+q/tFtYjSr+OR+jm4M=;
        b=CXqgb/HikTjFy3EMgMfK5CKnIkrDsvskiIiJIOOxZwqPmQiHsjvHHs/JkxmYqGp6ss
         1qALilLHB0wpDAxsq8XuvjmEbrRAhMvDLoumakHlT7NmJx+5WXbtqvk+ehWHaG+A3yo0
         RCdzgleIiZ0ws/E2qNN8gV+59IDp+mzts3MmbrPB/otHrcZeRMvuqoV0IFwbZu7rBY29
         R3IiqwwSb9d9KblyGv56EkJDf2WFAf0QJ1USkXolwdEYTR6lZe60JMzVdawUy++vijQQ
         qEvYSGFIv0tpJN2x4CU1Q4dUsaqRZy5eHKxVXD2r6qJMo//tA36CoObiHNcwVAd9S/5J
         zW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788013; x=1686380013;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnSwAOoxlqKsXEXi0phXp7gBU+q/tFtYjSr+OR+jm4M=;
        b=de8w9uWB0jt+NwGS8n5QfcWpFLOn5YrpmOAGerheOI3GcgBH8cP+8hzE4hLjo2AuB5
         ybWBzIb5KqfHvrWxTdP8LPfDt0OBKMCMPm4TeMzxV3CRyswExbZtt87mpEaV6VOJile/
         /Hpr+Rfq5w7mqixQMZ/p4tpEwuMQG1eOtMpXYRjzOq7Bb/P+IM3U2DemnWh4ypo0b9m9
         jRahV8fny6bzbRx8FziocSE0HirI9ebcagKt7HSq8wRczwXvXZqF2mIZ8xrxEaliElvc
         2FXoDHHihcCU5PeIgt+kkuy03+lN0A425th/AmwbIHF8HaM8xFLzABx1dtfwN58XwAfT
         TxHA==
X-Gm-Message-State: AC+VfDxTLwxAQB2l68zjXooW50zrLxhekUWwqr20PQAYzKwI1zEb0R+u
        B1NfjzV9s3pVrt21qxYdXR9ajA==
X-Google-Smtp-Source: ACHHUZ4KMC8NWau0qULaC1VFjP+QGmYjTCO5cguh96ufu2bK3AiDVLT93ToJ+tMq32AXxxSWtPlGJw==
X-Received: by 2002:a05:600c:214f:b0:3f4:23cd:6dcf with SMTP id v15-20020a05600c214f00b003f423cd6dcfmr10023464wml.15.1683788013146;
        Wed, 10 May 2023 23:53:33 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:3110:8b33:cdf9:dea0])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b003f4e8530696sm1038257wml.46.2023.05.10.23.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:53:32 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 0/6]  coresight: syscfg: Add config table load via configfs
Date:   Thu, 11 May 2023 07:53:24 +0100
Message-Id: <20230511065330.26392-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set extends the configuration management support to allow loading and
unloading of configurations as structured tables.

The existing coresight configuration configfs API is additionally extended
to use this table functionality to load and unload configuration tables
as binary files.

This allows coresight configurations to be loaded at runtime, and independently
of kernel version, without the requirement to re-compile as built in kernel
modules.

Additional attributes - load and unload are provided to in the
/config/cs-syscfg subsytem base group to implement the load functionality.

The load attribute is a configfs binary attribute, loading the configuration
table in a similar way as the ACPI table binary attribute for that sub-system.

The configfs binary attribute mechanism supplies a strictly size limited
kernel buffer, providing better safety than other mechnisms, and also has
the advantage of being accessible directly from the command line, and being
part of the existing upstream coresight configuration mechanism in configfs

Configurations loaded in this way are validated and loaded across the entire
system of components atomically. If any part fails to load then the whole
configuration load will be cancelled.

Routines to generate binary configuration table files are supplied in
./tools/coresight.

Example generator and reader applications are provided.

Tools may be cross compiled or built for use on host system.

Documentation is updated to describe feature usage.

Changes since v5:
1) Possible memory leak removed.
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
2) Reuse mechanism for reader code revised. (Christoph)
3) Unload mechnism now by name in standard attribute, rather than
entire file
4) Mechanism to check last loaded configuration can be unloaded.
5) Documentation updates.

Changes since v4:
1) Update coresight/next - 6.1-rc3
2) Update to lockdep fixes to avoid read lock race in configfs.

Changes since v3:
1) Rebase & tested on coresight/next - 5.19-rc3 - which includes the
fix patch for earlier configfs works.
2) Lockdep investigations resulted in re-design of some of the code
accessing configfs.
3) moved load and unload attributes to root of cs-syscfg. (Mathieu)
4) Additional minor fixes suggested by Mathieu.
5) Memory for configfs loaded and unloaded configurations is now
explicitly freed.
6) LOCKDEP nesting fix for configfs base code (fs/configfs/dir.c)

Changes since v2:
1) Rebased & tested on coresight/next - 5.18-rc2
2) Moved coresight config generator and reader programs from samples to
tools/coresight. Docs updated to match. (suggested by Mathieu)
3) userspace builds now use userspace headers from tools/...
4) Other minor fixes from Mathieu's review.

Changes since v1:
1) Rebased to coresight/next - 5.16-rc1 with previous coresight config
set applied.
2) Makefile.host fixed to default to all target.

Mike Leach (6):
  coresight: config: add config table runtime load functionality
  coresight: configfs: Update memory allocation / free for configfs
    elements
  coresight: configfs: Add attributes to load config tables at runtime
  coresight: config: extract shared structures to common header file
  coresight: tools: Add config table file write and reader tools
  Documentation: coresight: docs for config load via configfs

 .../trace/coresight/coresight-config.rst      | 265 ++++++++-
 MAINTAINERS                                   |   1 +
 drivers/hwtracing/coresight/Makefile          |   3 +-
 .../coresight/coresight-config-desc.h         | 105 ++++
 .../coresight/coresight-config-table.c        | 431 +++++++++++++++
 .../coresight/coresight-config-table.h        | 151 ++++++
 .../hwtracing/coresight/coresight-config.h    |  98 +---
 .../coresight/coresight-syscfg-configfs.c     | 513 ++++++++++++++++--
 .../coresight/coresight-syscfg-configfs.h     |   5 +
 .../hwtracing/coresight/coresight-syscfg.c    | 101 +++-
 .../hwtracing/coresight/coresight-syscfg.h    |   6 +-
 tools/coresight/Makefile                      |  56 ++
 tools/coresight/coresight-cfg-bufw.c          | 309 +++++++++++
 tools/coresight/coresight-cfg-bufw.h          |  26 +
 tools/coresight/coresight-cfg-example1.c      |  62 +++
 tools/coresight/coresight-cfg-example2.c      |  95 ++++
 tools/coresight/coresight-cfg-examples.h      |  25 +
 tools/coresight/coresight-cfg-file-gen.c      |  61 +++
 tools/coresight/coresight-cfg-file-read.c     | 227 ++++++++
 tools/coresight/coresight-config-uapi.h       | 105 ++++
 20 files changed, 2503 insertions(+), 142 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config-desc.h
 create mode 100644 drivers/hwtracing/coresight/coresight-config-table.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config-table.h
 create mode 100644 tools/coresight/Makefile
 create mode 100644 tools/coresight/coresight-cfg-bufw.c
 create mode 100644 tools/coresight/coresight-cfg-bufw.h
 create mode 100644 tools/coresight/coresight-cfg-example1.c
 create mode 100644 tools/coresight/coresight-cfg-example2.c
 create mode 100644 tools/coresight/coresight-cfg-examples.h
 create mode 100644 tools/coresight/coresight-cfg-file-gen.c
 create mode 100644 tools/coresight/coresight-cfg-file-read.c
 create mode 100644 tools/coresight/coresight-config-uapi.h

-- 
2.17.1

