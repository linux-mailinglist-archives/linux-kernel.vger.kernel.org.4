Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80826A743D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCAT3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCAT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:29:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D05FCC;
        Wed,  1 Mar 2023 11:29:03 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321INt8u001220;
        Wed, 1 Mar 2023 19:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=mwoCZgmqEiqahH9LW1Tt7FC1N1PzUxjkbM41SSBaqCk=;
 b=re8/2evvPJnTwIwzBaeHt5LtN7XW26D/vaACSeCT+0h80f4vWc4Dt1PDP4VNHBTP97M6
 Jz5chrtwxNcfXyb53kSriruBOpWG0osrQAlEbvd9IP+w/+etv2bPqnbVEt1a4UUZ+Mog
 tsEwtI/ZcsHl889NoP3vQVQGOKruYSn2rM5STK66MOPmkA6WD8L6KNwjBPjTNlwQvPwf
 Y6z/rU35fzqUr+EPCp1eDAO/j1neEzVP17199iyiX6M/8anHiROrSPMyEntcblDdYjDL
 Dx/EdbGLnWyJfoM1gb8ODzfEYh3MfrMi/ddnsWSSiS7/IfIMlNU9i1jX0+BsPb6+uvRT kw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2bxthnhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:28:54 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 321H0bJY016417;
        Wed, 1 Mar 2023 19:28:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3nybdkxqbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:28:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 321JSpNL64356814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 19:28:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8731058062;
        Wed,  1 Mar 2023 19:28:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E8B058061;
        Wed,  1 Mar 2023 19:28:50 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.163.79.233])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Mar 2023 19:28:50 +0000 (GMT)
Message-ID: <cfe11fadc3d3e61ce6c7d6f00e1e427edea8a4e3.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND] scsi: libfc: Use refcount_* APIs for reference
 count management
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Deepak R Varma <drv@mailo.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Date:   Wed, 01 Mar 2023 14:28:49 -0500
In-Reply-To: <Y/+hVSSFgeV+yPhY@ubun2204.myguest.virtualbox.org>
References: <Y/+hVSSFgeV+yPhY@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qwF9oPbUN-OGDwGoLA_Qb4js0v65vxmp
X-Proofpoint-GUID: qwF9oPbUN-OGDwGoLA_Qb4js0v65vxmp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_14,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=915 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 adultscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303010154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-02 at 00:32 +0530, Deepak R Varma wrote:
> The atomic_t API based object reference counter management is prone
> to counter value overflows, object use-after-free issues and to
> return puzzling values. The improved refcount_t APIs are designed to
> address these known issues with atomic_t reference counter
> management. This white paper [1] has detailed reasons for moving from
> atomic_t to refcount_t APIs. Hence replace the atomic_* based
> implementation by its refcount_* based equivalent.
> The issue is identified using atomic_as_refcounter.cocci Coccinelle
> semantic patch script.
> 
>         [1] https://arxiv.org/pdf/1710.06175.pdf

Citing long whitepapers in support of a patch isn't helpful to time
pressed reviewers, particularly when it's evident you didn't understand
the paper you cite. The argument in the paper for replacing atomics
with refcounts can be summarized as: if a user can cause a counter
overflow in an atomic_t simply by performing some action from userspace
then that represents a source of potential overflow attacks on the
kernel which should be mitigated by replacing the atomic_t in question
with a refcount_t which is overflow resistant.

What's missing from the quoted changelog is a justification of how a
user could cause an overflow in the ex_refcnt atomic_t.

James

