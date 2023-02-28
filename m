Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C646A5FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjB1Tek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB1Tei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:34:38 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2292686;
        Tue, 28 Feb 2023 11:34:37 -0800 (PST)
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SEp3JJ031686;
        Tue, 28 Feb 2023 19:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=Rm2I+xUpxyU9C7t3/vtyprv1mAm+Mrk03UV578Qhsm8=;
 b=f3wkJVtKikZWcC7d4v9AfBnd2x7IPd4gccrBDGCbYdndvn7AqQbSHmWdsF+ZTsmqdJYq
 HyAkrOE1vTPQ8Gio5lOj1CVPzy7opH5TxiEY0J5FZtrYMQ/xoLbU26QNCCgYoNUfHE7p
 HlHDgWtMWoybnWiF+FWx9WS8ci3NQMSaTD2oZYJwdqbvET33jbpxgGCncnCsYmnGNVPl
 hPERHVl4csZ4QxOu2/39ZxS1HUu2VH1nXBj3pBeOSDW6PjiUFfOxX+fN6DW8HnpyhpNW
 HtmqADjHzv5kyKNwbD1P4yZReNZsUUrlLhCzjz9dcWFdk01uMlSSwXR4FJ+g1lG5eVCn wA== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3nyb8vdwdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 19:34:35 +0000
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31SJ1abt017445;
        Tue, 28 Feb 2023 14:34:34 -0500
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint4.akamai.com (PPS) with ESMTP id 3nyej3vwfs-1;
        Tue, 28 Feb 2023 14:34:34 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id EE49F60207;
        Tue, 28 Feb 2023 19:34:33 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     jim.cromie@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: [PATCH v2 0/2] dyndbg: let's use the module notifier callback
Date:   Tue, 28 Feb 2023 14:34:20 -0500
Message-Id: <cover.1677612539.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=340 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280162
X-Proofpoint-ORIG-GUID: Y-mmjMlJvEym0tF7KNUKq900edPgg7U0
X-Proofpoint-GUID: Y-mmjMlJvEym0tF7KNUKq900edPgg7U0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=231
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
anyways. First patch is just a cleanup.

Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@xxxxxxxxx/

Thanks,

-Jason

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

