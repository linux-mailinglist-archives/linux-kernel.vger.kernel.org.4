Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81006AD6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCGFwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCGFwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:52:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8DD4D282;
        Mon,  6 Mar 2023 21:52:20 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3273GOaa027680;
        Tue, 7 Mar 2023 05:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rnO1vo970a8IiD6eGvD4TX8Y3T3DTw5HEVGehV6lsTo=;
 b=oxnK+jB6is+00pXXY2lBXWLpyLDMg9Pfis+YtWYvp9GZqYr6Zx68eHVIfimn+ncxcVcN
 wI5OU6V/8+ftqf4IHWCXVDXtZwiSr1l0rThDQwd2mOrYxtST/IUSO4ceEyHi8g+BdVmf
 XhVa7ADylbPmmNxLi6Js3y2qODUHkf791MRayyDuXEc6cPrq6JZYlMw3UO3hkeROWpk/
 c/C13vo0lt46jUSr6mlr0tOcybXXOnw/g8EfROS0d1lyBuk34tol/A1ox51VVNGEOVyb
 UO/8KRHS/M8aFNN9qAutqJAiVZYmCal80M7bIigy2A4sJ2T5x95Z7AEVieMf8ft7a0UR dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4u1k80r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:52:11 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3275qAEA005886;
        Tue, 7 Mar 2023 05:52:10 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4u1k80pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:52:10 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326M13Y1004489;
        Tue, 7 Mar 2023 05:52:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p41b0txxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:52:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3275q5Qh50004462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 05:52:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A75CF2004B;
        Tue,  7 Mar 2023 05:52:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26A7120040;
        Tue,  7 Mar 2023 05:52:05 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 05:52:05 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 855F460235;
        Tue,  7 Mar 2023 16:52:01 +1100 (AEDT)
Message-ID: <038cf154302db87dda2677607a364f516230a38b.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 13/13] Documentation: Document PowerPC kernel DEXCR
 interface
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de
Date:   Tue, 07 Mar 2023 16:52:01 +1100
In-Reply-To: <CQZWS8VFIL3Q.G9POORQXDKE0@bobo>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
         <20221128024458.46121-14-bgray@linux.ibm.com>
         <CQZWS8VFIL3Q.G9POORQXDKE0@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T6ggWnaarMfcJoVvs1J1XPp7Uf7QhXoc
X-Proofpoint-ORIG-GUID: byI31UQpRTfrsTCPgVzvtG8RpieMV7A8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=890
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-07 at 15:40 +1000, Nicholas Piggin wrote:
> Might need a bit more time and discussion on the API. Interestingly
> because the hashchk aspect is architectural, we may not be able to
> necessarily sanely enable that, because if it was disabled to start
> out with, our callchain up to the prctl call I think would have no
> return hashes set so we'd immediately fail on our first return.

I assumed it could eventually be supported in whatever startup wrapper
programs are built with, so either as one of the first things before
any calls, or the compiler could skip putting hash instructions in the
wrapper altogether. The ELF file itself might even be able to request
bits be enabled, so the kernel would start the process correctly.

As it is inherited, it's also possible for a wrapper program to set a
specific DEXCR before a child runs. E.g.,

	fork();
	prctl(...NPHIE...);
	exec();

I hadn't thought of the prctl call itself causing an unbalanced hashchk
when it returns, but that should be solvable with an inline syscall.
