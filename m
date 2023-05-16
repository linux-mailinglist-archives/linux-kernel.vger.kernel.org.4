Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF770587A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjEPUPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjEPUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA97D9C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5174E63D91
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCBDC433A0;
        Tue, 16 May 2023 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268076;
        bh=6CLuxrIav2439MrPgOxLsybmU0ZxykMENHio5PB5Xks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuJ537HFxfcwhdqwCP8FY0Iz+JnIIEcw+QdKeU4PnmNDYL/WVfrqMMCxzuIZ6eXCs
         3f9dFRNu/A3vXHLgWDe5fvmcRFazgvPMJo+AD0Agor6XUqgoQaPRbLe+Gy3Mvodwvq
         yZWJh8hpJ2gWwW6Y/LeKSuaYs/6IsH6gxZFhKZnr6dp4c4qK3YEmwu9aymaHj/B9NX
         p1TIc26HTglrtf9u5RrYB3Fwv9sY0cYNgsigJyLYbqpNN6Wnyjkxo6MFKtzk3Ednsx
         DWOVIRLCVNHJesogc+ASjuUbKgnQW1B874rgEDwlKV8PWSdMWeLKtBBRwbtmC4Qm99
         uhmZKCIs1NFeA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] libnvdimm: mark 'security_show' static again
Date:   Tue, 16 May 2023 22:14:09 +0200
Message-Id: <20230516201415.556858-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516201415.556858-1-arnd@kernel.org>
References: <20230516201415.556858-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The security_show() function was made global and __weak at some
point to allow overriding it. The override was removed later, but
it remains global, which causes a warning about the missing
declaration:

drivers/nvdimm/dimm_devs.c:352:9: error: no previous prototype for 'security_show'

This is also not an appropriate name for a global symbol in the
kernel, so just make it static again.

Fixes: 15a8348707ff ("libnvdimm: Introduce CONFIG_NVDIMM_SECURITY_TEST flag")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvdimm/dimm_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 957f7c3d17ba..10c3cb6a574a 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -349,7 +349,7 @@ static ssize_t available_slots_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(available_slots);
 
-ssize_t security_show(struct device *dev,
+static ssize_t security_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
-- 
2.39.2

