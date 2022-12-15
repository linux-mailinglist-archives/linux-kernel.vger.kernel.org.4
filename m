Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30A64DBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLOMvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLOMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:51:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1CB23E8C;
        Thu, 15 Dec 2022 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eVhFf5MIvGoSrecefTzQcMQnYbPEvxCOEUrQeN+dgu4=; b=chgIZqKedLA0pkL9yfaHto3jZ2
        yVdZKJm1iO213hDaw2ZTSAVzZJww8Mlx6jxxyWfI9m32uQZ2/BNiGFpocGXzt4wjgp8t1NMkPlztz
        ok0o2FVGB6BzAe4Y60hPtnUOuPYjV6mC1AGyDIT8eddyWdiv+o2211ZtdTL13la80kNrlHAq7e96Z
        +I8gldGuh6oZcLU2ZMYzciA07PhpFAM073IfVmR6ZaoTbJ8SM2Oiso9QsJFgDOFSYb9aqnZEObr2s
        PhhGHvalDZNkygrp4uVMSOEiW8UuWAAdrwphObYR4pzyVGWhEh3lXgInAuhl5lE0oHHJfU8uh2J14
        pWmDXVUg==;
Received: from [188.21.169.252] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5ni0-009SxX-QO; Thu, 15 Dec 2022 12:51:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org
Cc:     linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] docs, nvme: add a feature and quirk policy document
Date:   Thu, 15 Dec 2022 13:51:30 +0100
Message-Id: <20221215125130.261098-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a document about what specification features are supported by
the Linux NVMe driver, and what qualifies for a quirk if an implementation
has problems following the specification.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/process/index.rst               |  1 +
 .../process/nvme-feature-and-quirk-policy.rst | 77 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/process/nvme-feature-and-quirk-policy.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index d4b6217472b0a0..0dc33994ddefc5 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -50,6 +50,7 @@ Other guides to the community that are of interest to most developers are:
    embargoed-hardware-issues
    maintainers
    researcher-guidelines
+   nvme-feature-and-quirk-policy
 
 These are some overall technical guides that have been put here for now for
 lack of a better place.
diff --git a/Documentation/process/nvme-feature-and-quirk-policy.rst b/Documentation/process/nvme-feature-and-quirk-policy.rst
new file mode 100644
index 00000000000000..eee19f3d9904bd
--- /dev/null
+++ b/Documentation/process/nvme-feature-and-quirk-policy.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Linux NVMe feature and and quirk policy
+=======================================
+
+This file explains the policy used to decide what is supported by the
+Linux NVMe driver and what is not.
+
+
+Introduction
+============
+
+NVM Express is an open collection of standards and information.
+
+The Linux NVMe host driver in drivers/nvme/host/ supports devices
+implementing the NVM Express (NVMe) family of specifications, which
+currently consists of a number of documents:
+
+ - the NVMe Base specification
+ - various Command Set specifications (e.g. NVM Command Set)
+ - various Transport specifications (e.g. PCIe, Fibre Channel, RDMA, TCP)
+ - the NVMe Management Interface specification
+
+See https://nvmexpress.org/developers/ for the NVMe specifications.
+
+
+Supported features
+==================
+
+NVMe is a large suite of specifications, and contains features that are only
+useful or suitable for specific use-cases. It is important to note that Linux
+does not aim to implement every feature in the specification.  Every additional
+feature implemented introduces more code, more maintenance and potentially more
+bugs.  Hence there is an inherent tradeoff between functionality and
+maintainability of the NVMe host driver.
+
+Any feature implemented in the Linux NVMe host driver must support the
+following requirements:
+
+  1. The feature is specified in a release version of an official NVMe
+     specification, or in a ratified Technical Proposal (TP) that is
+     available on NVMe website. Or if it is not directly related to the
+     on-wire protocol, does not contradict any of the NVMe specifications.
+  2. Does not conflict with the Linux architecture, nor the design of the
+     NVMe host driver.
+  3. Has a clear, indisputable value-proposition and a wide consensus across
+     the community.
+
+Vendor specific extensions are generally not supported in the NVMe host
+driver.
+
+It is strongly recommended to work with the Linux NVMe and block layer
+maintainers and get feedback on specification changes that are intended
+to be used by the Linux NVMe host driver in order to avoid conflict at a
+later stage.
+
+
+Quirks
+======
+
+Sometimes implementations of open standards fail to correctly implement parts
+of the standards.  Linux uses identifiers based quirks to work around such
+implementation bugs.  The intent of quirks is to deal with widely available
+hardware, usually consumer, which Linux users can't use without these quirks.
+Typically these implementations are not or only superficially tested with Linux
+by the hardware manufacturer.
+
+The Linux NVMe maintainers decide ad hoc whether to quirk implementations
+based on the impact of the problem to Linux users and how it impacts
+maintainability of the driver.  In general quirks are a last resort, if no
+firmware updates or other workarounds are available from the vendor.
+
+Quirks will not be added to the Linux kernel for hardware that isn't available
+on the mass market.  Hardware that fails qualification for enterprise Linux
+distributions, ChromeOS, Android or other consumers of the Linux kernel
+should be fixed before it is shipped instead of rely on Linux quirk.
diff --git a/MAINTAINERS b/MAINTAINERS
index bb77a3ed9d5423..59e9f2dfa842ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14827,6 +14827,7 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git://git.infradead.org/nvme.git
+F:	Documentation/process/nvme-feature-and-quirk-policy.rst
 F:	drivers/nvme/host/
 F:	drivers/nvme/common/
 F:	include/linux/nvme*
-- 
2.35.1

