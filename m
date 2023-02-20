Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC47169C4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBTFY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTFY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:24:26 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB136D508
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:24:25 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K5GCIv027546;
        Mon, 20 Feb 2023 05:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7ox8uMijtXXkEohrTvBG2N1JgHzoiCzkM1DknUH+Asc=;
 b=ESuNviKbWl/HUXDk0ENyS+LFlbmP3unvyVrqJ7h+sGY54vTyr7ydHoMD+jR97/IAV0Er
 sEncbTyx2g0V2d1sWR8YiqyuYNTueJrS8LhY7pYvqmI8MeUSiliXx3b37l/MokYML2rm
 9XmqAgqF/jjUSoXvxRGgp2pafef/Glilt0i1z3xmcX/pku3FWKMZanSEDfIt3MPkolGG
 VuuOEOJtrLD3chBbV32YadpQuw7FYdXZ+qmH1I84jVBQszOe7ABTF3s4H7cJzTIqM19q
 gZLdmBStF1Gsa7yxqmaWC4ynTwL9d5ttBX4j+eHGLvrqHqO2titY8Xi5ijyqti5g761D 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv25e8q5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 05:24:13 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31K5KBGI040214;
        Mon, 20 Feb 2023 05:24:13 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nv25e8q5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 05:24:13 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JKVsq6007839;
        Mon, 20 Feb 2023 05:24:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ntpa6a5xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 05:24:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31K5O7e015860234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 05:24:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F63A20043;
        Mon, 20 Feb 2023 05:24:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07F8A2004D;
        Mon, 20 Feb 2023 05:24:05 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.in.ibm.com (unknown [9.109.216.99])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 05:24:04 +0000 (GMT)
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: [PATCH 0/2] Improving calls to kvmppc_hv_entry
Date:   Mon, 20 Feb 2023 10:53:53 +0530
Message-Id: <20230220052355.109033-1-kconsul@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _PKfNgOHmI7I5CtIkCA1BIxo9NNUuBod
X-Proofpoint-ORIG-GUID: xLglK1mwTnupMrUwXvUgKoLDY-C5P2YO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_02,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=832 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- remove .global scope of kvmppc_hv_entry
- remove r4 argument to kvmppc_hv_entry as it is not required

Kautuk Consul (2):
  arch/powerpc/kvm: kvmppc_hv_entry: remove .global scope
  arch/powerpc/kvm: kvmppc_hv_entry: remove r4 argument

 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.31.1

