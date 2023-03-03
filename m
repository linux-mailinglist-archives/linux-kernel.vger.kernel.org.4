Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B926A9C50
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjCCQwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjCCQvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:51:45 -0500
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FED5D77C;
        Fri,  3 Mar 2023 08:51:17 -0800 (PST)
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323FI5sD031066;
        Fri, 3 Mar 2023 16:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=jan2016.eng;
 bh=J7y7gcoRtlbwLnRX2gMH1qPJetJEk+6THOduYolRlDc=;
 b=BzHXQdgHjVRHi6qCyQ+EK/dGxq5Lmwlj2wst8ME791NRS2IRNvEFHUgL2rxTHXi5vyp0
 Bt8mAMTGJWsEkJi24Mug0a/d2hwTIqx6IgYsCjQNv03Y/CiZ2IFwpIZV5RyggpE3U8y/
 EBgKBOu29nMVxSsRHbt3pGaLr9M/rTzGpkKkmj5J02O+/LD/cizAn5cmTNr5xQXpkIhg
 bxvtw1+7O0ROYZx9YgSjvv+sOrE4/e+RhKOGDw/GFH6w9u0HMVLft055ms2J1jqH09Bq
 kBU3JnBIdWcibLuCauT2HLxT4bLnZs5dekht91ueYfbzmDdeMdPX0oQJd6ukcxurDnWd XA== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3ny835qj65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 16:51:08 +0000
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 323FmoGp031521;
        Fri, 3 Mar 2023 11:51:07 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 3nyej457e3-1;
        Fri, 03 Mar 2023 11:51:07 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 42A523095A;
        Fri,  3 Mar 2023 16:51:07 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     mcgrof@kernel.org
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH v3 1/2] dyndbg: remove unused 'base' arg from __ddebug_add_module()
Date:   Fri,  3 Mar 2023 11:50:55 -0500
Message-Id: <16bcadc508cae9c93249d16a499fb714edb1f64d.1677861177.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1677861177.git.jbaron@akamai.com>
References: <cover.1677861177.git.jbaron@akamai.com>
In-Reply-To: <cover.1677861177.git.jbaron@akamai.com>
References: <cover.1677861177.git.jbaron@akamai.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030146
X-Proofpoint-ORIG-GUID: 0RevVWFJRA62dXoibb_j8wEH0tO6J9ab
X-Proofpoint-GUID: 0RevVWFJRA62dXoibb_j8wEH0tO6J9ab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030145
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'base' parameter to __ddebug_add_module() is no longer in use
after: Commit b7b4eebdba7b ("dyndbg: gather __dyndbg[] state into
struct _ddebug_info").

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

