Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DB699BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBPSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjBPSDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:03:30 -0500
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38F4D623
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:03:28 -0800 (PST)
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 31GFB6PI021873;
        Thu, 16 Feb 2023 17:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=AbObqMxyDF8vi0XoZFZ2EtiVvkA9vbfZga8rfiQ8Hjg=;
 b=dl3JVSm+e4oadxY8j1FOc18L0vJe00J5eMtiKbfgCYTpubzuiZBpLhrJ3p+ZMH0EpB5U
 ONOb1ViClr6n7V/DYd3rjcQLJPPXI+2bOlj78RGgtJdBnqSJkaJTGVoT2KOkFTaWeqBz
 M/dayX90MewdUsgp9HPGAKfpPy4I4Pw3h8jwefPxHp76UftSaLcU3kZBcSTc9HzMZ7JU
 xJjmaIN+jyIvDlsVavG9atydG8bMUeFCJ52HDyLxRgwuNrMmGSUkZy/BlyGzmYjVopIN
 ItLjhCtBWXspxyEGQ1UoAN/xxVUHcllyW+5g83byFkr4oLFVPRoH5SrhDMcCgxT3gtxD hQ== 
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
        by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 3np4aj2f08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:15:59 +0000
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 31GGkNVN024049;
        Thu, 16 Feb 2023 12:15:59 -0500
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint7.akamai.com (PPS) with ESMTP id 3np783eu7m-1;
        Thu, 16 Feb 2023 12:15:59 -0500
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.222.101])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id C4B016024D;
        Thu, 16 Feb 2023 17:15:58 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, jim.cromie@gmail.com
Subject: [PATCH 0/2] dyndbg: let's use the module notifier callback
Date:   Thu, 16 Feb 2023 12:15:49 -0500
Message-Id: <cover.1676566871.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=260 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160148
X-Proofpoint-ORIG-GUID: Afkbq83VX4L1fF4LGtrX-3AK0HUlYZSO
X-Proofpoint-GUID: Afkbq83VX4L1fF4LGtrX-3AK0HUlYZSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 impostorscore=0 mlxlogscore=184
 spamscore=1 mlxscore=1 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160150
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@gmail.com/

Thanks,

-Jason

Jason Baron (2):
  dyndbg: remove unused 'base' arg from __ddebug_add_module()
  dyndbg: use the module notifier callbacks

 include/linux/dynamic_debug.h | 13 ----------
 include/linux/module.h        |  3 +++
 kernel/module/internal.h      |  1 -
 kernel/module/main.c          | 30 ++++++---------------
 lib/dynamic_debug.c           | 49 ++++++++++++++++++++++++++++-------
 5 files changed, 51 insertions(+), 45 deletions(-)

-- 
2.17.1

