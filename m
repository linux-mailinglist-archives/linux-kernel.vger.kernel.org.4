Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C9F6DFE15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDLS4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLS4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:56:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35349D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:56:17 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CIiYHv015652;
        Wed, 12 Apr 2023 18:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=SM5eJ/FnV8ZsDRBAIYcRF+9pM82FpOMuW+feSslqg1w=;
 b=VC8AVLK6m4ZjpB46ciEiAR4PVMREv+HKkw9jz+PeJo6bZs1nhoJA0oWtJkAOd9ryidVi
 NRerF9QPBtVBfrRlrdK8lCEKW9g712Kouvi4xQq6hFL7nyLTYTznvygG885GUzwY9zn9
 05HwK7bWNGjUylAjCxumIubkgpVsm+cZY5V0yW+3Rk/0kfsZdMicYEnDp7UodrXIdk3C
 dsbLdr4PTKJMhrzsaOihOrfgsY2gATRsHiILnnDovdgI8+FmniRSTMA5GAj4JCOXqnEU
 rXLjSxf+hVY4JcGIxhebgHSKHwUbZFrt4Pa2qBY5pS/rSg2CSCqAMkXJfW67ecpQWJbr yA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3px1qc9c11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 18:56:09 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33CGvnw0003067;
        Wed, 12 Apr 2023 18:56:08 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3pu0jb7pu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 18:56:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CIu7Wg5177944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:56:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A72C85805F;
        Wed, 12 Apr 2023 18:56:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F08458069;
        Wed, 12 Apr 2023 18:56:06 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.16.129])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 18:56:06 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] fsi: core: Lock scan mutex for master index removal
Date:   Wed, 12 Apr 2023 13:56:00 -0500
Message-Id: <20230412185602.1592629-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Dx3ZmBpqlWGuCTFFny74eMcB9eK7hnN
X-Proofpoint-ORIG-GUID: -Dx3ZmBpqlWGuCTFFny74eMcB9eK7hnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 mlxlogscore=931 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120160
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a master scan occurs while the master is being unregistered,
the devicecs may end up with incorrect and possibly duplicate names,
resulting in kernel warnings. Ensure the master index isn't changed
outside of the scan mutex.
In addition, add some trace events to debug any further issues in this
area.

Eddie James (2):
  fsi: core: Lock scan mutex for master index removal
  fsi: core: Add trace events for scan and unregister

 drivers/fsi/fsi-core.c     |  6 +++++-
 include/trace/events/fsi.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.31.1

