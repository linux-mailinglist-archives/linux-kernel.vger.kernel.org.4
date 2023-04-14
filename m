Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BF86E2871
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDNQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDNQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B42EE45
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681490204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DJ0GWrxA51nbC/Zn4pnMBDV3M5ZmqzGbnQMGek+06Ks=;
        b=ISS+U+saP4xBIT1OEIXZYNBqE0mXQzKlTkU8spZKg7JpNj15hnqS4hMT1/5GTs3p5lPffB
        DWaj4rXBOihts/xcIrmYlGSUGhs9p70RSvKiNSsZvOMZ3xhrxxImE5di6S/bAmskg1OaEP
        qRuz1idMReqggdINwPZOBaOjpk0XPAY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-xD9MRU--PDOlAEZJ110izQ-1; Fri, 14 Apr 2023 12:36:43 -0400
X-MC-Unique: xD9MRU--PDOlAEZJ110izQ-1
Received: by mail-wm1-f70.google.com with SMTP id bh18-20020a05600c3d1200b003f05a99b571so11964887wmb.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490202; x=1684082202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJ0GWrxA51nbC/Zn4pnMBDV3M5ZmqzGbnQMGek+06Ks=;
        b=UAZHYafwmFfUh3a4vk+JjUMw242ogTulx4qDKMTIUV2TRR+6UlA95on7bSiAKs08Aj
         t6GwN3kPtTiR2vBFoeweRXdOWWTNz7RQJ4lgWtDCToKEM9I2Vg03Mv6msPLxCkwswutp
         G6EPXnug+MH8Tt6dUna13ZH/2TI2dL+6O3RYt4YtQ+hMJZw/GxtGC8UZCjGf5LuTeTeX
         uICldc7WaUsfEXKv5OQvoZJ703Y22ho8liU1poGqs018TaAaOiz7eqLE4PdAk3f4KgWh
         bUOKC9SlvKehE0swcVNgYEU09Hkj2S5v5dUeIK9XlGlnhZAZQ8Ih6qWGdCygtDXYQmx6
         q4Qw==
X-Gm-Message-State: AAQBX9f/WjGCwmKHiT3JQR1Ij+ErifjOw2XEE2yd6SR9sLMsJcVWUBkU
        bTpJEP63SMSGsvn8yZGzCSBQK+DgFbbsgEb/ZLMKtjjkKqe0cu9wRXXSlWCFSrA+qYmRuPTa4UF
        GmrsLtNhmerHOqBaQlxFbUsA=
X-Received: by 2002:a05:600c:211a:b0:3f0:3049:b216 with SMTP id u26-20020a05600c211a00b003f03049b216mr4761358wml.28.1681490202267;
        Fri, 14 Apr 2023 09:36:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350YAXC44bXbVqYgAa7lkglrf4AAj1nJPv5tyai2AcnAyynn2u/eDcGmD8aiyji9yNxAYE0Sv9A==
X-Received: by 2002:a05:600c:211a:b0:3f0:3049:b216 with SMTP id u26-20020a05600c211a00b003f03049b216mr4761347wml.28.1681490201989;
        Fri, 14 Apr 2023 09:36:41 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm8312119wms.35.2023.04.14.09.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:36:41 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v3 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Fri, 14 Apr 2023 18:36:32 +0200
Message-Id: <20230414163636.236174-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces initial KUnit test suites for the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

v3:
- Calling fpga_bridges_put() between reconfigurations
- Functions for registering fake modules allocate and return context structs

v2:
- Restructured code into multiple suites to test components in isolation
- Reduced code duplication using init and exit methods
- Using a get_bridges() method to build the list of bridges just before programming
- Regions and Bridges are organized topologically
- Changed bitstream/bit to images
- Allocate images dynamically
- Renamed fpga-tests to fpga-test
- Simplified Kconfig
- Add license info to the fpga-test module

Marco Pagani (4):
  fpga: add fake FPGA manager
  fpga: add fake FPGA bridge
  fpga: add fake FPGA region
  fpga: add initial KUnit test suites

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  11 +
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fake-fpga-bridge.c | 242 +++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  36 ++
 drivers/fpga/tests/fake-fpga-mgr.c    | 386 +++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h    |  43 +++
 drivers/fpga/tests/fake-fpga-region.c | 259 ++++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  40 +++
 drivers/fpga/tests/fpga-test.c        | 479 ++++++++++++++++++++++++++
 12 files changed, 1512 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h
 create mode 100644 drivers/fpga/tests/fpga-test.c


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.39.2

