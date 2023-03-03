Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAA6A9C49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjCCQvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCCQvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:51:44 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A625D8A7;
        Fri,  3 Mar 2023 08:51:13 -0800 (PST)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 323EbLtY022308;
        Fri, 3 Mar 2023 16:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=omV0RcD+XUO/iuy4Vn60S5kx5v713oNFs3+FN2JhR+0=;
 b=NRK0lIAQbm38322h+6PVLGRlzYUU7SHNhOU2lQ9TmK6iju8hc5hjHb2Bx8tpBK4lwcaY
 955+QyKffaaXpMDcsZMfSqcp62+12tTwPLT8lOTbnbfVgno0WXmLIsQQJSXyOdOukKBM
 bzpSPnUjVv8CWBbhrgZPg8vZKb01JjnxyMd5+mu1mGWIv0341LNTY/iY/AENjL64E2CB
 Todo9+OWOqisaIgjoc+ZYt9YStmCsNytuorcFGyZAXEbHWOjRbbhqegOkNxUOCMxNl4U
 o45rO7FTde++KI/6DZBVxUwnXv2AEdMvxHkCKZIksb5PuCt6tTz+ceoBEkJ0TND0uFNV yQ== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 3nyarj19f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 16:51:03 +0000
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 323FCKnm028605;
        Fri, 3 Mar 2023 11:51:02 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3nyej4d5m8-1;
        Fri, 03 Mar 2023 11:51:02 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 500773095A;
        Fri,  3 Mar 2023 16:51:02 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     mcgrof@kernel.org
Cc:     jim.cromie@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH v3 0/2] dyndbg: let's use the module notifier callback
Date:   Fri,  3 Mar 2023 11:50:54 -0500
Message-Id: <cover.1677861177.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=376 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030146
X-Proofpoint-GUID: B_Q6P7jJvauwpo7s1WbD08NB8Bm0zI-O
X-Proofpoint-ORIG-GUID: B_Q6P7jJvauwpo7s1WbD08NB8Bm0zI-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=364 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030145
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jim Cromie hit a BUG() while toggling jump label branches in a module
before they were properly initialized. This isn't currently an issue,
but will be as part of his pending classmap series. Seems like we
should covert to using module callback notifier for dynamic debug
anyways to match other subsystems and remove core module code.
First patch is just a cleanup.

Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@xxxxxxxxx/

I've rebased this series onto modules-next tree. Although the first patch
is a cleanup entirely internal to dynamic debug I think it's a nice cleanup
to have as part of this series.

Thanks,

-Jason

v3:
-rebased to modules-next tree
-updated changelog as per Luis Chamberlain's suggestions

v2:
-Fix: error: field 'dyndbg_info' has incomplete type
 Reported-by: kernel test robot <lkp@intel.com>
 Link: https://lore.kernel.org/oe-kbuild-all/202302190427.9iIK2NfJ-lkp@intel.com/
-make ddebug_remove_module() static


Jason Baron (2):
  dyndbg: remove unused 'base' arg from __ddebug_add_module()
  dyndbg: use the module notifier callbacks

 include/linux/dynamic_debug.h | 13 ---------
 include/linux/module.h        |  4 +++
 kernel/module/internal.h      |  2 --
 kernel/module/main.c          | 30 ++++++---------------
 lib/dynamic_debug.c           | 51 ++++++++++++++++++++++++++++-------
 5 files changed, 53 insertions(+), 47 deletions(-)

-- 
2.17.1

