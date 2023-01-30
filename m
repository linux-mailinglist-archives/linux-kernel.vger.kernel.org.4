Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE383681391
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjA3OmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjA3OmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:42:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2C91CAD7;
        Mon, 30 Jan 2023 06:42:01 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UDq7a8020611;
        Mon, 30 Jan 2023 14:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=ERu5pi4CSQQZRqkLlHDNtcPDWXqI3pr9EixQuwHCvMc=;
 b=Fi0BTcH9yYnk6I84BszmSMx+hCZl3BN4120WKIVXGDsi1MhNQbEiUGkWszLBJ1WBXgMF
 CsBVJ5fC8b/1r8zYLaReF58KDbjCfLbajxviclHnlltbf1l8GiUwarmAw8C5EzYTQRsJ
 ivb4S2umLcGym2VZxG3q0onGGeWHH76CKztHOL5MmebhJ2q7YB8C9z0ljKjTlEEGoWPn
 z7hmz+Tbl68bCJTuAKkBhe1pD1QCsUIqBin8YyMJoOkgTYn5wBVvBNCYD4WrAkNx/8QR
 +RMgeC0D5PQ8hTQxWG6cwP75D56W+jWf8TxYGgJQDSIJPq5pPNRLqhW0HscuhXHwJfD/ mw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nef5h1an8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 14:41:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U55SqN026906;
        Mon, 30 Jan 2023 14:41:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7jbxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 14:41:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30UEflg543581838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:41:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA5AE20043;
        Mon, 30 Jan 2023 14:41:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 873E020040;
        Mon, 30 Jan 2023 14:41:47 +0000 (GMT)
Received: from localhost (unknown [9.171.84.174])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Jan 2023 14:41:47 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     gor@linux.ibm.com
Cc:     egorenar@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, terrelln@fb.com,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH 1/1] s390/decompressor: specify __decompress() buf len
 to avoid overflow
In-Reply-To: <patch-1.thread-41c676.git-41c676c2d153.your-ad-here.call-01675030179-ext-9637@work.hours>
In-Reply-To: 
Date:   Mon, 30 Jan 2023 15:41:47 +0100
Message-ID: <875yco6q50.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bnjgtFnHs_w3Qq4-qGTcGdwXXlxp6nhb
X-Proofpoint-GUID: bnjgtFnHs_w3Qq4-qGTcGdwXXlxp6nhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_13,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxlogscore=561 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

thanks for the fix, tested on s390 + KVM + buildroot + linux-next.

Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Regards
Alex
