Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BF36544EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiLVQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiLVQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:10:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F62A60DC;
        Thu, 22 Dec 2022 08:09:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CD8668CFE; Thu, 22 Dec 2022 17:09:22 +0100 (CET)
Date:   Thu, 22 Dec 2022 17:09:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221222160920.GA10193@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de> <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt7g27lv.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 06:45:32AM -0700, Jonathan Corbet wrote:
> Sorry, the argument is that the subsystem profiles there were created
> for the very purpose of documenting subsystem-specific patch policies
> like those found in your document.  The hope is that, someday, people
> will be able to go to one place to learn what special hoops any given
> subsystem will make them jump through.
> 
> This isn't something I'm going to dig in my heels on, though.  But at a
> minimum, could you add an entry to
> Documentation/maintainer/maintainer-entry-profile.rst ?

What about the following?  This moves the file to a new
Documentation/nvme/ directory and then links it form
Documentation/maintainer/maintainer-entry-profile.rst:

---
From 3471fc6f0b584c4372d7c4c2b2b8e1b5aed970f0 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 12 Dec 2022 11:09:55 +0100
Subject: docs, nvme: add a feature and quirk policy document

This adds a document about what specification features are supported by
the Linux NVMe driver, and what qualifies for a quirk if an implementation
has problems following the specification.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 .../maintainer/maintainer-entry-profile.rst   |  1 +
 .../nvme/feature-and-quirk-policy.rst         | 77 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/nvme/feature-and-quirk-policy.rst

diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index 93b2ae6c34a99b..cfd37f31077f6c 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -104,3 +104,4 @@ to do something different in the near future.
    ../riscv/patch-acceptance
    ../driver-api/media/maintainer-entry-profile
    ../driver-api/vfio-pci-device-specific-driver-acceptance
+   ../nvme/feature-and-quirk-policy
diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
new file mode 100644
index 00000000000000..c01d836d8e4151
--- /dev/null
+++ b/Documentation/nvme/feature-and-quirk-policy.rst
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
+of the standards.  Linux uses identifier-based quirks to work around such
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
+should be fixed before it is shipped instead of relying on Linux quirks.
diff --git a/MAINTAINERS b/MAINTAINERS
index bb77a3ed9d5423..d53b3a6cdc67d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14827,6 +14827,7 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git://git.infradead.org/nvme.git
+F:	Documentation/nvme/
 F:	drivers/nvme/host/
 F:	drivers/nvme/common/
 F:	include/linux/nvme*
-- 
2.35.1

