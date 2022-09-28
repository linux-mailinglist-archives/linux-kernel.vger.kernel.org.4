Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE8D5EE0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiI1Pkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiI1Pk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:40:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E276973
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:40:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SE5W2C032167;
        Wed, 28 Sep 2022 15:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=hCFmLg8CsGpQXJilBEzskBgYXRzHr8lcMkotFLngLig=;
 b=qeLWdqHZEMKIAE6Od27GB2c2x+B4Jh6BcKOyju9QEJVdX1FEBLIuGFzdpJxEa75T2gTy
 n6+Me6KTZe5avWqF34ntc0EU1655MY/pvdHs3oDBHrIutHIczx0afOLefPvueNI05mY8
 s26h8ztJY9tdXaBWUze5WYRwZ2QpwPYWZ+3OARPjgHmIQ1sf5IiGRV0w0LQIHukaHWt3
 lTWTkb+A2KaqzkdjWaRqbN+WXkrfytxDg91qzfqdZyYY6URDZ/1gjVChKPQkjGvOP+IR
 4cuRPEGNXLFKn+wfgzGvCDkDLXtgZ9ONo+Hy94ZISJmqAqDPl60TFUvbKgsSDYrWszVq pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0kt1jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 15:38:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28SDbAM2002244;
        Wed, 28 Sep 2022 15:38:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps6e57r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 15:38:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28SFc1nr022830;
        Wed, 28 Sep 2022 15:38:01 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jtps6e576-1;
        Wed, 28 Sep 2022 15:38:01 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, reinette.chatre@intel.co,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, thomas.tai@oracle.com
Subject: [PATCH V2 0/1] x86/sgx: Add code to inject hwpoison into SGX memory
Date:   Wed, 28 Sep 2022 11:38:31 -0400
Message-Id: <20220928153832.1032566-1-thomas.tai@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=918 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280092
X-Proofpoint-GUID: IQh-LFHvtOo--K_tQRJrrNoDMLciFHC_
X-Proofpoint-ORIG-GUID: IQh-LFHvtOo--K_tQRJrrNoDMLciFHC_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to inject hwpoison into SGX memory. The SGX memory
is processor reserved memory that cannot be directly accessed by system
software.

Changes since v1:
- Add a comment in hwpoison_inject as suggested by Miaohe
- v1: Reviewed-by: Tony Luck <tony.luck@intel.com>
- v1: Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thomas Tai (1):
  x86/sgx: Add code to inject hwpoison into SGX memory

 Documentation/mm/hwpoison.rst | 44 +++++++++++++++++++++++++++++++++++
 mm/hwpoison-inject.c          |  4 ++++
 2 files changed, 48 insertions(+)

-- 
2.31.1

