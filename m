Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B086516CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 00:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiLSXqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 18:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLSXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 18:46:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759C62EF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h10so10234249wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yr50kGZ2450z0JMZkOL/NEsv1hM43iRa7NeYnFZkjVI=;
        b=MOex3KLKCQYhUotZX7/B/KhZvxqwBh8UaequZfF08NeutFy0+idJ2u9TWqsXUPF+3k
         hWtj19GtCqptCf09wl2Aeze/S86gf8nKGZTZgQUKG4XHDnhnGLR+D7Is7TYspxEUf6Oo
         fsPggGo6M1QXdU/0oTJzRTXKVsJ3rClCQo3LxyjKy/xXfVGbLv9WtCYSBsZAuPfUESZb
         ydjq/8daeaZtPxg/dzzPi2OCj21UECHSw/CExtFLhnqQNp2JcmTyB2MfWh28cr1i+LTx
         5Prtry+bkx6TVDwcx3D+iQMPl9xwnf/kaA+MXhw7TJil/biGReAAWGp/GDUTyFmGdgfn
         GGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr50kGZ2450z0JMZkOL/NEsv1hM43iRa7NeYnFZkjVI=;
        b=dPck+aNet19+jiqeEQi1MjQds6aLb6ufEk17PXEbyzsr8oxyUhjklYnGR19U//isC3
         JIxRfTQ/+fkuoLNlHuKwM5XQngrk3Heg434bXWP4zHKIaA2IYllJoTr2iRzGWqZAcH7b
         F5GEv8qhpO9lXowqI1NxaDVjNr6pMCKGLNu1Kwcu5UmVesauEwhTo5zy9TFswaxhyq2D
         AqduE3+YB5ivBv7ZkhN+OSkMF26SE7OLU3KWPrKxicWlg4Ed/Vg94md+J2lt6bBxZFmK
         hu0m5XkPgdjvMC2nMBRJzdRIZyjdHX60/+EFqFgDrMBSIwfzMqHtQ7nP/NnWkjzkbhZ5
         8atg==
X-Gm-Message-State: ANoB5plBu83v5+OiEg88AHob01Ttv6XzTVaYu72KauhxXwPz2dndRPC4
        nmpvcEGpD6rUwv1a6KiG6aWoDg==
X-Google-Smtp-Source: AA0mqf59lCchRdJOK5FjlgooiF0rQlDlNJpSe5xw2sAHTbylBfplcnKiqa/FuKNeBLgjBGbLPEsiCg==
X-Received: by 2002:a05:6000:1201:b0:242:46cf:687c with SMTP id e1-20020a056000120100b0024246cf687cmr25600816wrx.32.1671493602427;
        Mon, 19 Dec 2022 15:46:42 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:bce1:4a06:7ceb:6940])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b002383fc96509sm11165148wrt.47.2022.12.19.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 15:46:41 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 0/6]  coresight: syscfg: Extend configfs for config load
Date:   Mon, 19 Dec 2022 23:46:32 +0000
Message-Id: <20221219234638.3661-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set extends the configfs support to allow loading and unloading of
configurations as binary files via configfs.

Additional attributes - load and unload are provided to in the
/config/cs-syscfg subsytem base group to implement the load functionality.

Routines to generate binary configuration files are supplied in
./tools/coresight.

Example generator and reader applications are provided.

Tools may be cross compiled or built for use on host system.

Documentation is updated to describe feature usage.

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
  coresight: configfs: Update memory allocation / free for configfs
    elements
  coresight: configfs: Add in functionality for load via configfs
  coresight: configfs: Add in binary attributes to load files
  coresight: configfs: Modify config files to allow userspace use
  coresight: tools: Add config file write and reader tools
  Documentation: coresight: docs for config load via configfs

 .../trace/coresight/coresight-config.rst      | 202 +++++-
 MAINTAINERS                                   |   1 +
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../coresight/coresight-config-file.c         | 583 ++++++++++++++++++
 .../coresight/coresight-config-file.h         | 139 +++++
 .../hwtracing/coresight/coresight-config.h    |  27 +
 .../coresight/coresight-syscfg-configfs.c     | 361 +++++++++--
 .../coresight/coresight-syscfg-configfs.h     |   4 +
 .../hwtracing/coresight/coresight-syscfg.c    | 137 +++-
 .../hwtracing/coresight/coresight-syscfg.h    |   6 +-
 tools/coresight/Makefile                      |  52 ++
 tools/coresight/coresight-cfg-bufw.c          | 309 ++++++++++
 tools/coresight/coresight-cfg-bufw.h          |  26 +
 tools/coresight/coresight-cfg-example1.c      |  62 ++
 tools/coresight/coresight-cfg-example2.c      |  95 +++
 tools/coresight/coresight-cfg-examples.h      |  22 +
 tools/coresight/coresight-cfg-file-gen.c      |  61 ++
 tools/coresight/coresight-cfg-file-read.c     | 227 +++++++
 tools/coresight/coresight-config-uapi.h       |  76 +++
 19 files changed, 2339 insertions(+), 53 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config-file.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config-file.h
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

