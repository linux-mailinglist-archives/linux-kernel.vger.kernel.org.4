Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A842601C77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJQWdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJQWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:32:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02424973
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:32:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HLmwO0027014;
        Mon, 17 Oct 2022 22:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=axepoFwpQrDrQYXcdV/6jV6ZYyzoOO5W6Iku2bzAuP0=;
 b=Cd/knNbuY+0XHtBl2JHSSNzZ1ogK6VQ+DJBzk+2xqUsync1Rbjju9HqJYaDg9fHuwEro
 vvC6nZP5UBGPo3wKsjsEhMyn6016qadoS9HfNQ6Mh6FLzht7J/Yc9bMDE2DJBP3xMdoL
 68XCwGIeww1w1wuf5HQdgY08fM2b5nScJg5dVbRhIEgSAPXu1mInEA9TO43VQBjnGr5R
 WZrGnSMuqIKDTFzRR8+wwjv5Pp9NKlXZEzQunlv5QvnKTmAOwgLss1x1JgxG/Q2CGXKV
 enx9Zps3u33v/qBGAOe4aIUIKn78GkJANjkM8Qv11ScrsYSzP23dJAa/7z2Ieg/NSaQn 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99nt96dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:32:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HKxNhY015891;
        Mon, 17 Oct 2022 22:32:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr9hvqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:32:38 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29HMWcTt026010;
        Mon, 17 Oct 2022 22:32:38 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8hr9hvqj-1;
        Mon, 17 Oct 2022 22:32:37 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, reinette.chatre@intel.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        thomas.tai@oracle.com
Subject: [PATCH V3 0/1] x86/sgx: Add code to inject hwpoison into SGX memory
Date:   Mon, 17 Oct 2022 18:33:04 -0400
Message-Id: <20221017223305.578073-1-thomas.tai@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170128
X-Proofpoint-ORIG-GUID: yfcvgpH1kbUgstCQrvzJ-PRU0AHOcINR
X-Proofpoint-GUID: yfcvgpH1kbUgstCQrvzJ-PRU0AHOcINR
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

Changes since v2:
- As suggested by Naoya Horiguchi <naoya.horiguchi@nec.com>, add a 
  new mf_action_page_type MF_MSG_SGX and use action_result() to
  show the page type and the action taken.
- Rewrite hwpoison.rst to show the output from dmesg after injection.
- Add reinette.chatre@intel.com to the email list. Sorry that I
  mistyped the email address in the previous emails.
- v2 Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Changes since v1:
- Add a comment in hwpoison_inject as suggested by Miaohe
- v1: Reviewed-by: Tony Luck <tony.luck@intel.com>
- v1: Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>


Thomas Tai (1):
  x86/sgx: Add code to inject hwpoison into SGX memory

 Documentation/mm/hwpoison.rst | 24 ++++++++++++++++++++++++
 include/linux/mm.h            |  1 +
 include/ras/ras_event.h       |  1 +
 mm/hwpoison-inject.c          |  4 ++++
 mm/memory-failure.c           |  5 ++++-
 5 files changed, 34 insertions(+), 1 deletion(-)

-- 
2 .31.1


