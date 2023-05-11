Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58D6FF3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbjEKOUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbjEKOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19330D0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683814787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lmFRF2TZuEObZMk+uaDrCeYwUIk6PWDK4ywYGE1ryCc=;
        b=Jejv4V+3tzV6NTCeHVRIw8TAurij+tqcKBgaKTTLZcAXNlR0JkJmaDY2lJetYx5NcFNUab
        ymnorFKQ/XV6v+/bhqCq/7WXLbuQgc7SudiMwXvQ1aDS08rzz7ANKPQ3A7X6uiU0calyvb
        M9L940tD298OHPk3kaoDu5Be9OKyzs8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-jrw1xZ9dOQ6T052OmcWqUw-1; Thu, 11 May 2023 10:19:46 -0400
X-MC-Unique: jrw1xZ9dOQ6T052OmcWqUw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7516df3c3ccso532591185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814786; x=1686406786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmFRF2TZuEObZMk+uaDrCeYwUIk6PWDK4ywYGE1ryCc=;
        b=A22OWfbap/x4TqOF7+C4MJVQVNaa3Fm1HqGuFTi2FOk21CNr4WAaGgDImNTM4MXVve
         7OkxeGntwS9TLTJsviw1jNnPP/Pct1OxMc7Q4aHC99W74OKOprR4kcUbD3+ffWKy0F/X
         ovg9RHdkHPtajUO/AsisopxJphFRczS2kTX08/VPzkk50PoSWu3O55lpU6Vf6i0d4aZA
         2xqymZNwh4U7Wh+LNOztmaYz4gvpp3g71QfItslUWscI5HxskKDW4ULFbVov74LVitTN
         groI/sTn2rmxMfR08zItAWawyinDujfvMae63ZsFMnHzNhGDL6X5JnMO5a3HDZWVbmU0
         /F4w==
X-Gm-Message-State: AC+VfDxUS+7F4Vf1D+JzDu3NouvTGCsWsS1WF2zYTLbvEF+XtBiNAxdo
        fGm1vFl9Z1NLCvT8+0dHEjVa8dhUrBcG/cOM+u38GDGtndj2kqjt6XXHH4Ny1KY9Wsosa7OsUOv
        7RucnZ62BrK+lB91gF3MLO+Q=
X-Received: by 2002:a05:622a:308:b0:3e2:4280:bc5b with SMTP id q8-20020a05622a030800b003e24280bc5bmr30079685qtw.21.1683814786171;
        Thu, 11 May 2023 07:19:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FzyQh8b87hw8KaZmgl2++XPvzsJKaMS/SIvidPWN60cXZIyw5zW71SuOdND2P/IydvswKfw==
X-Received: by 2002:a05:622a:308:b0:3e2:4280:bc5b with SMTP id q8-20020a05622a030800b003e24280bc5bmr30079659qtw.21.1683814785946;
        Thu, 11 May 2023 07:19:45 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id oo11-20020a05620a530b00b0074db94ed42fsm965516qkn.116.2023.05.11.07.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:19:45 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v5 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Thu, 11 May 2023 16:19:18 +0200
Message-Id: <20230511141922.437328-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces initial KUnit test suites for the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

v5:
- Removed most of the exported functions from fake components
- Moved all KUnit expectations/assertions to the main test module
- Removed standalone use case to simplify the code
- Removed instances counters from fake components (using device.id instead)
- Set header size in the .parse_header op
- improved bridge get_put_list test case

v4:
- Fix build error

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
 drivers/fpga/tests/fake-fpga-bridge.c | 203 ++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  40 ++
 drivers/fpga/tests/fake-fpga-mgr.c    | 271 +++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h    |  53 +++
 drivers/fpga/tests/fake-fpga-region.c | 245 ++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  40 ++
 drivers/fpga/tests/fpga-test.c        | 551 ++++++++++++++++++++++++++
 12 files changed, 1430 insertions(+)
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


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.40.1

