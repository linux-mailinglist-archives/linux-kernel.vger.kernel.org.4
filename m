Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC386A600A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjB1T66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjB1T64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:58:56 -0500
X-Greylist: delayed 1450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 11:58:52 PST
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F8211F2;
        Tue, 28 Feb 2023 11:58:52 -0800 (PST)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 31SFcO7Y032202;
        Tue, 28 Feb 2023 19:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=jan2016.eng;
 bh=YOlQK+46DJKYK6TKdktXOrnFvwYoVuQ6cgNrlLTlTWo=;
 b=Vh0/QunG3oaF0KqXB/tGJJF2jMkab2El7kBdCGkoDeUVm4iw+e354nrD+SPzXzGpovTW
 2nz7tYgpor2ZGZe0y6LF/K3TEwWew/1SU0KdzpvObXhgWcM2+pdOLjewgTeNeUu9ySUM
 lgR263GMZo0F5ZSO9FjmgnbGazGGvb4oJE6wVlsJUwXBmHHl41hbB7nd8knYmTGjboXT
 7nZX8vjG9qVx9TgVJqJjGRbByhkNsBOQXJFxetv8zeivbtUDln+sEBN+0u44ajxDVBRQ
 Z8nVAr3VN/9ixrmfn6hzXTCpsHd1gLlTLRiD1JYal9SCO+5bLEJHfO6zmtTFIFP7zHD5 gA== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 3ny89q6d9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 19:34:41 +0000
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31SFoUZP017426;
        Tue, 28 Feb 2023 14:34:40 -0500
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint4.akamai.com (PPS) with ESMTP id 3nyej3vwg2-1;
        Tue, 28 Feb 2023 14:34:40 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 2470160207;
        Tue, 28 Feb 2023 19:34:40 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     jim.cromie@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: [PATCH v2 1/2] dyndbg: remove unused 'base' arg from __ddebug_add_module()
Date:   Tue, 28 Feb 2023 14:34:21 -0500
Message-Id: <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1677612539.git.jbaron@akamai.com>
References: <cover.1677612539.git.jbaron@akamai.com>
In-Reply-To: <cover.1677612539.git.jbaron@akamai.com>
References: <cover.1677612539.git.jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280162
X-Proofpoint-GUID: X2RkHrAwvsg98I6acqzS2dBrqDELXsGB
X-Proofpoint-ORIG-GUID: X2RkHrAwvsg98I6acqzS2dBrqDELXsGB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=990 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280162
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ddebug_add_module() doesn't use the 'base' arg. Remove it.

Cc: Jim Cromie <jim.cromie@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 lib/dynamic_debug.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 009f2ead09c1..8136e5236b7b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1223,8 +1223,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt,
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
-			       const char *modname)
+static int __ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
@@ -1265,7 +1264,7 @@ static int __ddebug_add_module(struct _ddebug_info *di, unsigned int base,
 
 int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
-	return __ddebug_add_module(di, 0, modname);
+	return __ddebug_add_module(di, modname);
 }
 
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
@@ -1408,7 +1407,7 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
-			ret = __ddebug_add_module(&di, i - mod_sites, modname);
+			ret = __ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
 
@@ -1419,7 +1418,7 @@ static int __init dynamic_debug_init(void)
 	}
 	di.num_descs = mod_sites;
 	di.descs = iter_mod_start;
-	ret = __ddebug_add_module(&di, i - mod_sites, modname);
+	ret = __ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.17.1

