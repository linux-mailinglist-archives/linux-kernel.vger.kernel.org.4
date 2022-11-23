Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20E3634CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiKWBOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiKWBNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:13:30 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C474E06A0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:12:21 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNoEKZ016769;
        Wed, 23 Nov 2022 01:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=KV9wT7ovr0+USrdvGlNejPsyu6sg9F1cXstqGcnOlvc=;
 b=k5K6MOMnzZ+7B6T2Wku4dP0+pwyKkRebkI1iTpGZjqHUzvr0Zgj+NzDbOYI1PP/HJIai
 F9LEuxxuObVVj4TaRvWKsy3lozDXnGvWTkIvXHghmPncm0Dvi19n4mX74YOURTeVaN0z
 INrHTY/F5so4OGBri8S9JtIzZKD1lkahASYJYHs2bHPF3/MVl9rBlIkR2tR2YETLlhuO
 B53vYhJxryLk+qh2G617U46gKdTLSMViRTsimUOv+6pTlU912pf578UdPz3IybjTX3On
 Io2+qYyJxu2Lek3UIxOvEgNJCG/jk8/2sgJnpDLVfKVzYEhNgutEvTQic5MhSEbZ2PSb 6w== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m18ecrf84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 01:12:16 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 51455809F5A;
        Wed, 23 Nov 2022 01:12:16 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D7B778005CC;
        Wed, 23 Nov 2022 01:12:15 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 0/5] checkpatch: enhance Kconfig parsing
Date:   Tue, 22 Nov 2022 19:11:57 -0600
Message-Id: <20221123011202.939319-1-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20220815041548.43744-1-elliott@hpe.com>
References: <20220815041548.43744-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _esjAOwUlCirHf6NBzy3aM-5Xb7spG4A
X-Proofpoint-GUID: _esjAOwUlCirHf6NBzy3aM-5Xb7spG4A
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=523
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230007
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance parsing for Kconfig patches and files.

Robert Elliott (5):
  checkpatch: improve Kconfig help text patch parsing
  checkpatch: don't sanitise quotes in Kconfig files
  checkpatch: check line length in Kconfig help text
  checkpatch: discard processed lines
  checkpatch: ignore a file named b

 scripts/checkpatch.pl | 66 ++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 19 deletions(-)

-- 
2.38.1

