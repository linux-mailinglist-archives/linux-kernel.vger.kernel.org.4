Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC2699B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBPRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:16:16 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C64E5DD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:16:09 -0800 (PST)
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GBu31p014287;
        Thu, 16 Feb 2023 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=jan2016.eng;
 bh=znw4YrFqpIaBX4rLacoBi016gNZbgppMkgnYRofczVY=;
 b=WVI1eCSPgwnYzHMKdcZBcKh0yhTcRtup7+qgefq8SHtk+8bM6khIL6bvbM25MRZvprYX
 Nk8Rq7bWzQtNesTYz+7rP25QNQNocKkTn8tMloMmRBP7yH5jRQnstEFvbWBKp0o1GScO
 vSlGpIsngkyFx89jMbVqXOSXhtAeZF35ZabToJ2HaVh7ZlQAcfT5kbZs3xHjeGHpG23K
 egSJwqiNasIa5TIaA/B77cp2LgnAmd9SsZSp35sffYTZnTF8XHJCaj8123R1shvs5qwB
 CvEI6JB1HL/fgQMpouqjMcRrP7C0cOIrGfXLPRIUV6siZS5WEHIC2wTX4jbeyqoDt2z/ 9Q== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3np3xv0vs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:16:07 +0000
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31GGoRf2003728;
        Thu, 16 Feb 2023 12:16:07 -0500
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint4.akamai.com (PPS) with ESMTP id 3np783pwmq-1;
        Thu, 16 Feb 2023 12:16:06 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 8F4586024D;
        Thu, 16 Feb 2023 17:16:06 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jim.cromie@gmail.com
Subject: [PATCH 1/2] dyndbg: remove unused 'base' arg from __ddebug_add_module()
Date:   Thu, 16 Feb 2023 12:15:50 -0500
Message-Id: <d4cbbab44667c1833c91e7aa16173650b799ad31.1676566871.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1676566871.git.jbaron@akamai.com>
References: <cover.1676566871.git.jbaron@akamai.com>
In-Reply-To: <cover.1676566871.git.jbaron@akamai.com>
References: <cover.1676566871.git.jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160148
X-Proofpoint-GUID: mxq1yZhrOqJmQFnqee4IvmpYaxTwX8VW
X-Proofpoint-ORIG-GUID: mxq1yZhrOqJmQFnqee4IvmpYaxTwX8VW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=962 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ddebug_add_module() doesn't use the 'base' arg. Remove it.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jim Cromie <jim.cromie@gmail.com>
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

