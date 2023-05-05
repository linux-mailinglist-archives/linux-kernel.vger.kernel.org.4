Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532756F8B05
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjEEV3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjEEV3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:29:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4190F213F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683322136; x=1714858136;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ct9jA8uj0TBlJubhPsdKuhSkXFE3pWNvQDrir/VFsbw=;
  b=jYg9vUGSjJMdCH7D1VwHQaFyN3cUW14PJKNzm5OY+WolD6SzLIHKDSX7
   UG0SL/EuK5I3AunZ8Td4atB288ZQANEDRYaqbgi+MAuNiTeAv1VoW4AvJ
   F239hRYM2cfKUX6UWuOEa/KH61O9YDsov806bYqQ3E14isaQOKIPBUEEk
   cWdqmZLhpCUaKlyvplJsySHFBvetlJr8PVC6b1YWG5MFyW7HdrUvxPs8s
   ok4igmhF0HitVoosK39Ki84jYx6aF5fOc41rha8Luk0n+D+wvm9mPjhAw
   hNoMMNsKa9cFEuL9i36m8doGZ/RXEGOEC9nxWQAHvK4PniXEIFkwaeejh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="346770402"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="346770402"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="762610735"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="762610735"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:28:55 -0700
Subject: [PATCH] base/node: Use 'property' to identify an access parameter
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
        dan.j.williams@intel.com
Date:   Fri, 05 May 2023 14:28:55 -0700
Message-ID: <168332213518.2189163.18377767521423011290.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of 'attr' and 'name' in the context of a sysfs attribute
definition are confusing because those read as being related to:

	struct attribute .name

Rename 'name' to 'property' in preparation for renaming 'struct
node_hmem_attr' to a more generic name that can be used in more contexts
('struct access_coordinate'), and not be confused with 'struct
attribute'.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/base/node.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index b46db17124f3..2cada01c70da 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -162,15 +162,15 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 }
 
 #ifdef CONFIG_HMEM_REPORTING
-#define ACCESS_ATTR(name)						\
-static ssize_t name##_show(struct device *dev,				\
+#define ACCESS_ATTR(property)						\
+static ssize_t property##_show(struct device *dev,			\
 			   struct device_attribute *attr,		\
 			   char *buf)					\
 {									\
 	return sysfs_emit(buf, "%u\n",					\
-			  to_access_nodes(dev)->hmem_attrs.name);	\
+			  to_access_nodes(dev)->hmem_attrs.property);	\
 }									\
-static DEVICE_ATTR_RO(name)
+static DEVICE_ATTR_RO(property)
 
 ACCESS_ATTR(read_bandwidth);
 ACCESS_ATTR(read_latency);


