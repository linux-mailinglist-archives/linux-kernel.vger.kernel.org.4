Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29416AD6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCGFiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCGFiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:38:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185092E0C6;
        Mon,  6 Mar 2023 21:38:06 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327418ls032457;
        Tue, 7 Mar 2023 05:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=VoBTceaYt9JCGmcdLxZJw8x/bOhn6s3tw9JaQeRiKy0=;
 b=j/N1ga2KFROODXy2i4nxPXv1sYnepvLBfco1bHXAvBSpYycFXi7j/Vq1rWPpHXlVQkPl
 e/J6FgyGVlbbWhYNyMSpXKZ0AjFcY3PZ5/fyZNTajflPvgayUCBWDBkDUKf5+jbJxDCC
 OjWDaz82NaudEQimaavTl+dJj1F/daAelRMdIs9tIjgm8/U/qycRSjr2GazGRI2fLN6Y
 WDZsHaWWQUVF3LjaaQgzNkjm/yOvliMtCjec7n08TGxrYCJv9o+KCORezY6zGXFZmehT
 GpjcNk8ncrvq3cDPDI+/J/2bVpPWRE+pFCmSYn/1eQ86Hw9DLq7cBd57UPWNS/X9GyDX 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4wswvcra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:37:55 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3275UMpr029385;
        Tue, 7 Mar 2023 05:37:54 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4wswvcqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:37:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326Lld6m011365;
        Tue, 7 Mar 2023 05:37:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3p418v2xsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 05:37:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3275bo4W58720734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 05:37:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 673FC20043;
        Tue,  7 Mar 2023 05:37:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAD6120040;
        Tue,  7 Mar 2023 05:37:49 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 05:37:49 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 28A2460235;
        Tue,  7 Mar 2023 16:37:48 +1100 (AEDT)
Message-ID: <eb19afda911f4868ec6ff194738afcfe7050d5c1.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 04/13] powerpc/dexcr: Support userspace ROP
 protection
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de
Date:   Tue, 07 Mar 2023 16:37:47 +1100
In-Reply-To: <CQZW0SBFI6QM.3FW6O6LJ0PVS1@bobo>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
         <20221128024458.46121-5-bgray@linux.ibm.com>
         <CQZW0SBFI6QM.3FW6O6LJ0PVS1@bobo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2JSq7H7t-gkreVYe1Rk65jyRWOcElRP_
X-Proofpoint-GUID: khednyvDzsNf_GUNhkpbdt17rekD4YC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxlogscore=834 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-07 at 15:05 +1000, Nicholas Piggin wrote:
> I think it is not quite per-process? I don't actually know how the
> user
> toolchain side is put together, but I'm thinking we can not give it a
> new
> salt on fork(), but we could on exec(). I think we could actually
> give
> each thread their own salt within a process too, right?

Yeah, the error case is we return further than we called in a given
execution context. A forked child may return after the fork, meaning it
needs the same key as the parent for the hashchk to work. Exec can get
a new key because we can't return with any existing hashes. I haven't
seen enough of kernel thread support to know if/how we can give threads
their own key. I believe they go through the fork() call that copies
the parent key currently.
