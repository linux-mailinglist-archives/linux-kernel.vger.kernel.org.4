Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F1689FF8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjBCRIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjBCRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB935A9132
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P+vuSKEpv7Ptnqb54aBjdlAa8wCTiq9HDLYMTKqctAU=;
        b=YX2se+78B5ITSPLAoHs/7527DOQWYL0UQg0oTrKNLSqFemm0D1WUr1/ZScEWNKPepdwU3J
        /Bq7SuEBrUXRo2Ihedy5cj1tcdDBHZOExnGBWgTGmPdPiQtqGNtNJqZfWvowfMrVIYLk2z
        iNzNiweU6LNvsbvvAQWwm+2vCXbQm40=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-UgLcflunOKCF_M8Uyb9IOA-1; Fri, 03 Feb 2023 12:07:15 -0500
X-MC-Unique: UgLcflunOKCF_M8Uyb9IOA-1
Received: by mail-qv1-f71.google.com with SMTP id jo26-20020a056214501a00b0053aa15f61d4so3061143qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+vuSKEpv7Ptnqb54aBjdlAa8wCTiq9HDLYMTKqctAU=;
        b=QAMm9ljEKFhQtQx0KU7nFD9nAyaIffAKz6ZmkMtuwUpPr78MQsO7fZquzNWmEHFcBN
         zNTFoGmx4djKyOc9whEIrCglAnc2ldgKlukJmFunN1WM5i/PRwcfbxGlHxwZsysA+/2G
         mw/x0J4XSVEroe+uiHk8s3D5FKsHEr8gGGM9r8TUB0YKIOZhnVdZl08g9gvAeu0NfIWj
         IUMflbaj9QmzOIze13ahQiCJOyn1IBItTqWOW+syPjsC4mNIiRZNopFa+omrJZGw1Lv3
         m4iIWZ1VxN1I4iKhGcknAOzkcsHxwwPDwoRQULE23MsWIFh4GWuHwgnuomBVEEhId/d2
         ipXA==
X-Gm-Message-State: AO0yUKWo3TLT96KoHdWOsWURjK6O7cV76LI8Glv8OIgJnIk18NzNS065
        bYYfzjqP0bWXqsYbiR+OGoPq/p99Ygr2/cebkeaw329wy+t5IHXHe25iOCJKjYTIQAPRqYbe3Zc
        +N/LAFX02N6ENHqtu08RRBFY=
X-Received: by 2002:a05:622a:10c:b0:3b8:5c86:37ea with SMTP id u12-20020a05622a010c00b003b85c8637eamr20570114qtw.61.1675444034630;
        Fri, 03 Feb 2023 09:07:14 -0800 (PST)
X-Google-Smtp-Source: AK7set+kH4s2nd8RhLz2fKDsH8hHgdZOlZ8qWJ/WU2eD0T5Of2sUyULk312vzsiW/h/v7QBn28adWw==
X-Received: by 2002:a05:622a:10c:b0:3b8:5c86:37ea with SMTP id u12-20020a05622a010c00b003b85c8637eamr20570093qtw.61.1675444034444;
        Fri, 03 Feb 2023 09:07:14 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm1884287qtg.33.2023.02.03.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:07:14 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 0/4] fpga: add initial KUnit test suite for the subsystem
Date:   Fri,  3 Feb 2023 18:06:49 +0100
Message-Id: <20230203170653.414990-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces a KUnit suite to test the core components
of the FPGA subsystem. More specifically, the suite tests the core
functions of the FPGA manager, FPGA bridge, and FPGA region.

These components are tested using "fake" modules that allow
observing their internals without altering the source code.

The test suite can be run using
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

Marco Pagani (4):
  fpga: add initial KUnit test suite
  fpga: add fake FPGA region
  fpga: add fake FPGA manager
  fpga: add fake FPGA bridge

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  15 ++
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fake-fpga-bridge.c | 214 +++++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  36 +++
 drivers/fpga/tests/fake-fpga-mgr.c    | 365 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h    |  42 +++
 drivers/fpga/tests/fake-fpga-region.c | 186 +++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  37 +++
 drivers/fpga/tests/fpga-tests.c       | 264 +++++++++++++++++++
 12 files changed, 1175 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h
 create mode 100644 drivers/fpga/tests/fpga-tests.c

-- 
2.39.1

