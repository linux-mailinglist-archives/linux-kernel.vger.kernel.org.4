Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9573743EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjF3P0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjF3P0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049B3C06
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pTZLRXwcw8c+1Shghlas5G3dNG4xAQUuz+2LmMHOLAw=;
        b=PYTcmn6uVtor3OTPWhZXAz8eLcMjPDgpBI7MvAZHSd/0032GuWs4HmedD+KQTbhYtNZN2W
        fT52H3Et9vJ52vsxqDhQDjRblB5S+u5OErFJt1KZQiNVj/g8PkgxM/4lyqfBg2yYh3O5r2
        Ths1diHZC3uzL3ipvetw3oJxFGmciIU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-oyvP7eFgNCKbm_lKOXa-kg-1; Fri, 30 Jun 2023 11:25:23 -0400
X-MC-Unique: oyvP7eFgNCKbm_lKOXa-kg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51a595bc30dso2410747a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138722; x=1690730722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTZLRXwcw8c+1Shghlas5G3dNG4xAQUuz+2LmMHOLAw=;
        b=hvbNvcl/TH9dxVEMur+K/ufbvJ4GtThMtdZ++Rbhnnx5GDf5w9ZJ/Dw4wHLO+ubCPo
         9LhdHwKMHQ8Ai6/4/VK3YTOViZVsGgdt7Eox8NSlDH+o7FajLP8c0uwc4YLplY18zM8O
         +uupFDRyJr7MweDqdsaQWIKmQ5JpqfDJjfKOGRrRdNG9UfrV3oCvBIpmff22HJIgbaiX
         9I/xasrlFqv0JYjcoCCftkMeehdQGl9jk/CP18Oxg3mfLUHfzb8xjT5wqh9y1DeTMEAp
         7Pmp+QIfJBduWRlVAqZ3iRmRCxlAgofq/46g0Seuj5/5moJCK6oY6Zt8TqUx4qjkrrjg
         3IWA==
X-Gm-Message-State: ABy/qLY+KIK8IPMNMaMG5A1Ti5EBRga4yAcqti05bOR2V+Fd9SAN0wlb
        BGsrh7OsA8QtP3smm8F1w20UCgF90hBA4Z3pBQuXhmMMCDFSfL4HaTHGdZrjy1I4eq1r66c/gXW
        hogO98BGMooHnwp63/OOcOj5qrTZ+1Pk=
X-Received: by 2002:aa7:d94f:0:b0:51d:a2d9:85a3 with SMTP id l15-20020aa7d94f000000b0051da2d985a3mr3181559eds.8.1688138722424;
        Fri, 30 Jun 2023 08:25:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpZ1E3ISdqu1dZGV3xOqoRPZ2q3DWDuGhB8rfauzXHCbp83s8SSHSQdnEbEC1AbMJKRq2piw==
X-Received: by 2002:aa7:d94f:0:b0:51d:a2d9:85a3 with SMTP id l15-20020aa7d94f000000b0051da2d985a3mr3181547eds.8.1688138722167;
        Fri, 30 Jun 2023 08:25:22 -0700 (PDT)
Received: from klayman.station (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0051def9be785sm813230edq.85.2023.06.30.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:25:21 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v8 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Fri, 30 Jun 2023 17:25:03 +0200
Message-ID: <20230630152507.30219-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces an initial set of KUnit test suites for the
core components of the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

v8:
- Using memset to set header and payload of the test image
- Using sg_miter_* functions to check the image in the write_sg op
- Includes sorted in alphabetical order
- Add commas for fpga_bridge_ops
- Improved Makefile

v7:
- Dropped RFC prefix
- Add comments to explain fakes and helper functions
- Changed the implementation of the Bridge used in the Region suite

v6:
- Restructured the code into self-contained test modules
- Added tests for the basic behaviors of the components
- Improved programming tests for the FPGA Manager
- Fixed code/comments mismatch in the list of Bridges test case

v5:
- Removed most of the exported functions using shared buffers for stats
- Moved all KUnit expectations/assertions to the main test module
- Removed standalone use case to simplify the code
- Removed instances counters from fake components (using device.id instead)
- Set header size in the .parse_header op
- Improved bridge get_put_list test case

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
  fpga: add an initial KUnit suite for the FPGA Manager
  fpga: add an initial KUnit suite for the FPGA Bridge
  fpga: add an initial KUnit suite for the FPGA Region
  fpga: add configuration for the FPGA KUnit test suites.

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  11 +
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fpga-bridge-test.c | 175 +++++++++++++++
 drivers/fpga/tests/fpga-mgr-test.c    | 311 ++++++++++++++++++++++++++
 drivers/fpga/tests/fpga-region-test.c | 211 +++++++++++++++++
 8 files changed, 724 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
-- 
2.41.0

