Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30476E4798
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjDQMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDQMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7D8A7C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681734196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=09NkuzlCCB3Ge2JOTJ1wxbdkj7LdqvwwuNQ5eOLMbKI=;
        b=RjgiZ0Rj0PPHEqc2ckJ1QxC8GNBD5/yjwd6UcgZ+MjggnemfVi0LQ8AkdjPnNcFwfrfanH
        cAbM5I+WIy/f3x2UfgBXwfjpEgF4ILCF9zrG+Ymy36XU3AdiaauyiX+qQ+OGD/1AfU9yRA
        LfVN6PQQortorNM4M3Bz9ijTXzvXu4w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-gXHjMZuuNRqAnzpXgStLpw-1; Mon, 17 Apr 2023 08:23:15 -0400
X-MC-Unique: gXHjMZuuNRqAnzpXgStLpw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94ec76d7a26so116421066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734194; x=1684326194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09NkuzlCCB3Ge2JOTJ1wxbdkj7LdqvwwuNQ5eOLMbKI=;
        b=M2To9yqmvN4wCkc6OwX7NdbP2UGcQ6Uhx6x1VA5swZXc8D8VOy/PPAiL0BtHxiXUwn
         UeLV6lqhTDzJuu8/uwaqVGzhgi8wTR+MNEObk2yETGdsgSgVwUuFfhlr89gOtNQBtOOd
         wXPQ6W6X0/BPFmRMN6vdoVOBnBsWfuxxeRxrBptB4+Y/aZ4Yn5kHEFdXX06X34uCc+eJ
         4gmjiKIH/X/UxRWbUTjkEIleQBwgFy4zIHuqfUdcmY1l30Nte9ogsNqqkInpN9FMkcdV
         ze5y7+knL51dmCcnkCFq8py7rv4leqUbueE/q+pMYR5qf9g8cbhH+7UDcn8UXGz6v92q
         7IPw==
X-Gm-Message-State: AAQBX9fIqknOPj2Ih/bLhnDwPv7tGx+OWfdiofZBRtdpob6PXr6wHj7b
        BVFwXvAdcgQeeSjJPz64ZV+YWU84tnZ6IOE+jGy8jgmoWo/EL8G7wz6aTJvLoFi0ksMp6D3zbJh
        SmFlzv2Xj276wy7yMhZW+NRM=
X-Received: by 2002:a05:6402:1803:b0:506:8da7:fab7 with SMTP id g3-20020a056402180300b005068da7fab7mr7857806edy.10.1681734193918;
        Mon, 17 Apr 2023 05:23:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZXDnFpLsIJ5VLkR0gnGFCXHcZZ4HXhOS2rKPzMLbzelxavH7yOtUvq8bqyqB28TLx9HvdSvw==
X-Received: by 2002:a05:6402:1803:b0:506:8da7:fab7 with SMTP id g3-20020a056402180300b005068da7fab7mr7857794edy.10.1681734193667;
        Mon, 17 Apr 2023 05:23:13 -0700 (PDT)
Received: from klayman.. ([37.163.248.182])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b004fbf6b35a56sm5756618edt.76.2023.04.17.05.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:23:13 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v4 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Mon, 17 Apr 2023 14:23:04 +0200
Message-Id: <20230417122308.131453-1-marpagan@redhat.com>
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


base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
-- 
2.39.2

