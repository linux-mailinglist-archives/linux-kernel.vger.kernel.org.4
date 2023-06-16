Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378E8733561
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjFPQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFPQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:06:38 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADB91FCC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:06:36 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qABy1-00G6Sm-I7; Fri, 16 Jun 2023 17:06:30 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qABy1-00034Y-0C;
        Fri, 16 Jun 2023 17:06:29 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] nvdimm: make nd_class variable static
Date:   Fri, 16 Jun 2023 17:06:28 +0100
Message-Id: <20230616160628.11801-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nd_class is not used outside of drivers/nvdimm/bus.c and thus sparse
is generating the following warning. Remove this by making it static:

drivers/nvdimm/bus.c:28:14: warning: symbol 'nd_class' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/nvdimm/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 954dbc105fc8..5852fe290523 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -25,7 +25,7 @@
 
 int nvdimm_major;
 static int nvdimm_bus_major;
-struct class *nd_class;
+static struct class *nd_class;
 static DEFINE_IDA(nd_ida);
 
 static int to_nd_device_type(const struct device *dev)
-- 
2.39.2

