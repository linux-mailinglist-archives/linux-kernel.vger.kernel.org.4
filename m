Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2973351A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFPPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346123AbjFPPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759C0295C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686930259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+g1pX8kL0ywRot5Ot6dsLwBfrWbbWL9qZYh2h2zCWlA=;
        b=a15J1dRVsesGqDNCepfiPPIai5biI0J9iVJUO9aX9hkjz0nlW0KDKqUzdrqIAtM25l4Umo
        OHFXTH6PRjGR4LSx0O7Jq5O7Lo1/Hxg2xeKTHHFIZN3LDAO9sZTLwBuGIsdimn/IDo3jAe
        bZvEfDAfhbbe1q1RJNUL4IHA1tLF4aY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-WqvzgqaXO56kNJ1qLK2WrQ-1; Fri, 16 Jun 2023 11:44:18 -0400
X-MC-Unique: WqvzgqaXO56kNJ1qLK2WrQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75caeec5545so148408885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686930258; x=1689522258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+g1pX8kL0ywRot5Ot6dsLwBfrWbbWL9qZYh2h2zCWlA=;
        b=T0ze/68ozq0AQigBd4fEolxWzUiMXmdqJx374y9SmH1BklyFrndKHFkN1nzPjuJ/aL
         JecJLwjrqQqIGnjqCDYV7jqmKrZUhCccM8S5te+b9OqU5E/97KHo7EqGQCth/Knh7Sbo
         sbtXAGyfSlwXe2lo7t1bTWtBMtesUQVA6ZGmzl72p4tIwKtAuj52kr9ENzB9lQ8FrKin
         iaX4nRTaq+svUP0wFEf9mHzgGvCjuJm9y5SaXK8ruvD3hgodgBYprFD6wUf0ZXdguYVE
         RS9oB6jOawCwAMcbsuATekdA7JSE5TjeEwjYXoeUCPKa4CrqXgZiaEzwJd9TJy7WaXvA
         Omrg==
X-Gm-Message-State: AC+VfDwLzPe31Efm2iZapKDuOXOFZ7pTiQtxwZDQVNbO8h0CLIqsunNR
        yFjB8zEkAQj4ZVFQvNahBZsS3gaW0Mqbz4GXKHXQ/62ttTurkN6aB76oAaRb62d+mvHEcxFzirP
        S61TTyYIvnFj73Vz1HF89Kok=
X-Received: by 2002:a05:620a:8d09:b0:75f:2c0:8e6b with SMTP id rb9-20020a05620a8d0900b0075f02c08e6bmr1736544qkn.43.1686930258275;
        Fri, 16 Jun 2023 08:44:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50s6ldlpCd0E+qjyLKVbBXocyDiNul4FcSx4XVyapvfvYJ9Dz9zu+7AY4yjnF6XrgMoEdfng==
X-Received: by 2002:a05:620a:8d09:b0:75f:2c0:8e6b with SMTP id rb9-20020a05620a8d0900b0075f02c08e6bmr1736528qkn.43.1686930258049;
        Fri, 16 Jun 2023 08:44:18 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-201.cust.vodafonedsl.it. [2.34.28.201])
        by smtp.gmail.com with ESMTPSA id 27-20020a05620a079b00b007607ecd58ecsm4436931qka.59.2023.06.16.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:44:17 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v7 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Fri, 16 Jun 2023 17:44:01 +0200
Message-Id: <20230616154405.220502-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces an initial set of KUnit test suites for the
core components of the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

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
 drivers/fpga/tests/Makefile           |   5 +
 drivers/fpga/tests/fpga-bridge-test.c | 175 +++++++++++++++
 drivers/fpga/tests/fpga-mgr-test.c    | 302 ++++++++++++++++++++++++++
 drivers/fpga/tests/fpga-region-test.c | 211 ++++++++++++++++++
 8 files changed, 714 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.40.1

