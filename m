Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C73722789
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjFENeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjFENe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:34:28 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED0D2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:34:27 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685972066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUIYbUJt+Cl/OQINsVO/8Ug45EH5iacT/hNl2EpfQ/k=;
        b=nX8jdpMVZCkY0JwiNgTs2/AkkYvqZZn70B8zIx8fV36lLjX1u/q+PtFaQk17mqeCzZ9Y9q
        4k9wefyFwIaRU6M6pN0ARpgZ5HslssfZe5panS+n0HArfzJDVAcYFSA4m/Xiu1r9QdY6sj
        eKRekgpftSP1oCaJQ2tFBai8FmQCNHHTtFCONXfZ3p2pynsr8bEMwqHmWOW5sipa5EKFFy
        qccypx4kWWWdfQ1Oe1aZObMw4D80tybwefnIJz1q46x0MZWr+jpcO+u0kU+nizOyge8G+S
        nY89es1Mlw2WrJ+rl4yYaoPreZw0TqtDpTWMoD3Kqt2yoerdRXk0OsXbcVrnng==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2921FF80E;
        Mon,  5 Jun 2023 13:34:25 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 3/4] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Date:   Mon,  5 Jun 2023 15:34:21 +0200
Message-Id: <20230605133422.45840-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605133422.45840-1-miquel.raynal@bootlin.com>
References: <20230605133422.45840-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binary content of nvmem devices is available to the user so in the
easiest cases, finding the content of a cell is rather easy as it is
just a matter of looking at a known and fixed offset. However, nvmem
layouts have been recently introduced to cope with more advanced
situations, where the offset and size of the cells is not known in
advance or is dynamic. When using layouts, more advanced parsers are
used by the kernel in order to give direct access to the content of each
cell regardless of their position/size in the underlying device, but
these information were not accessible to the user.

By exposing the nvmem cells to the user through a dedicated cell/ folder
containing one file per cell, we provide a straightforward access to
useful user information without the need for re-writing a userland
parser. Content of nvmem cells is usually: product names, manufacturing
date, MAC addresses, etc,

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells

diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
new file mode 100644
index 000000000000..641a7d7dad76
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-nvmem-cells
@@ -0,0 +1,19 @@
+What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
+Date:		May 2023
+KernelVersion:	6.5
+Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
+Description:
+		The cells/ folder contains one file per cell exposed by
+		the nvmem device. The name of the file is the cell name.
+		The length of the file is the size of the cell (when
+		known). The content of the file is the binary content of
+		the cell (may sometimes be ASCII, likely without
+		trailing character).
+		Note: This file is only present if CONFIG_NVMEM_SYSFS
+		is enabled
+
+		ex::
+
+		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name
+		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
+		  0000000a
-- 
2.34.1

