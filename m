Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E8D717C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjEaJzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjEaJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EA310F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685526853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4FZ3pIxtK0+0afJMzjTGCDky4aLUv5zQ5hfVyGzhYL8=;
        b=YwQRAJ3dpkxPtK8wWDcYT3CviAhZwe/VH51T/AZPXJqHiBpSx91W8AOOyscGD2jZ8XxTHB
        Fm985OpjcBZqEO9KcArqt9z71PYCXiDBWcmG5e1EiICQHzS7ib0U6b/wp9NzIsNwdBo7/U
        5SjMvfzzmnfyQMMG1PuR0vtPDvpZrgQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-YxHJRUcYOKeGEUiRyyiiGQ-1; Wed, 31 May 2023 05:54:12 -0400
X-MC-Unique: YxHJRUcYOKeGEUiRyyiiGQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75b06a31daaso870477085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526852; x=1688118852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FZ3pIxtK0+0afJMzjTGCDky4aLUv5zQ5hfVyGzhYL8=;
        b=TS1NtNcbzPO2SgULB/SuMCqTQiXtCuVECCsuOrgeHf7ZeTwVszMPSnHDtnR0lcUqZa
         NzpnBj1VDRHqBlYXy5CoB635aZ7UGFA+UyqCaDX2HLDmQMagaUmgmvTh9X9lrjp6DO/I
         A0L7h6LJ8Eh0/3Tc4C7VdQw1zAngsfkHxW2VKFuM8wtIuRExhU1gc8ez+ljUCpFSaF5J
         takO60HCfgqk0QBU2Pd2rcHR+JZjf7DeSKCZgIwdGz8vKkVcp/Ef+aJRkv6ZzVP/MWna
         MPcPU8MXokWsWIu0csR/ugmggs1oG9QJEsDBPL7P1TsMduH87MAXnZZC8krkMMmUjAYw
         RYow==
X-Gm-Message-State: AC+VfDwRJyfjZ0SOuF0AUulYqGFSdhu1Tjl9T2b3VIGX2M9vlIDH2clw
        Gk0GIlQohHdtPLHOWuopwJRYwwdGk7m4Lxys172zfbyF+OLYbCECIF0d1VL9ply3aVOpFBqqsh9
        jiBZ9bhNB5Ep6rHkLFoicg20=
X-Received: by 2002:a37:ad17:0:b0:75b:23a0:dec9 with SMTP id f23-20020a37ad17000000b0075b23a0dec9mr4287379qkm.71.1685526852231;
        Wed, 31 May 2023 02:54:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wQpBa+LPgHJQdgdmjdC5g6ia+cugRsaJGrbtx70LY/oqRkx8o3X2jc76h92f418EZytGrjA==
X-Received: by 2002:a37:ad17:0:b0:75b:23a0:dec9 with SMTP id f23-20020a37ad17000000b0075b23a0dec9mr4287364qkm.71.1685526851983;
        Wed, 31 May 2023 02:54:11 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id k25-20020a05620a139900b0074def53eca5sm4902404qki.53.2023.05.31.02.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:54:11 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v6 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Wed, 31 May 2023 11:54:01 +0200
Message-Id: <20230531095405.342080-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces initial KUnit test suites for the core components
of the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

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
  fpga: add configuration for the KUnit test suites.

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  11 +
 drivers/fpga/tests/Makefile           |   5 +
 drivers/fpga/tests/fpga-bridge-test.c | 164 +++++++++++++++
 drivers/fpga/tests/fpga-mgr-test.c    | 289 ++++++++++++++++++++++++++
 drivers/fpga/tests/fpga-region-test.c | 186 +++++++++++++++++
 8 files changed, 665 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c


base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.40.1

