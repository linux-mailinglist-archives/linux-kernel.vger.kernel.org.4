Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855156B91B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCNLfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjCNLfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:35:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863843B3FB;
        Tue, 14 Mar 2023 04:35:01 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E9av0m021189;
        Tue, 14 Mar 2023 11:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=am3zZ2C/XWzajjqB/HupC9PYLFgVp8MlDDfDuP3stuo=;
 b=hCiyiBncSMJWZL3dL3arZOk0uPcW7RpMuMa6W0FqSDZ+k6vpdK038UeSRSO83OFq+T3H
 m3WlBzrA2L2Iu3wJf92U8o+nbSfAM5wzulEGE0CI23vJLfUJRDiQ/u1e0amgOdnZxJqF
 Io2sFockwv93FFzBXIaLA032uEDzWcHGYkhgOF285vppqQz+3QTLmfbb+4JnNq7FRrVT
 j0e8/XrBeVIzJVdI4QPU5ADpMsLemJNo9DjLkFI837GHsCl7VWiAEooVfI4u9sAzExfl
 6r9jd3kOvmlUmLHBlVlxYI/VfVrj1fzuDoxRgU94FMX6EYWms1fNitMCWTYBZPX7YQC2 7Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3papenaww3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 11:34:52 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E8RisW019166;
        Tue, 14 Mar 2023 11:34:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3p8h96kqgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 11:34:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32EBYksU35127972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 11:34:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B6C22004E;
        Tue, 14 Mar 2023 11:34:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03A4920040;
        Tue, 14 Mar 2023 11:34:46 +0000 (GMT)
Received: from osiris (unknown [9.171.45.127])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Mar 2023 11:34:45 +0000 (GMT)
Date:   Tue, 14 Mar 2023 12:34:44 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 18/36] s390/topology: move to use bus_get_dev_root()
Message-ID: <ZBBb1GOcpMoGvxKK@osiris>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-18-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-18-gregkh@linuxfoundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZgrCox1lb5hIWnLNS9o_3hhsqgttnlDf
X-Proofpoint-GUID: ZgrCox1lb5hIWnLNS9o_3hhsqgttnlDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_04,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=606 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:29:00PM +0100, Greg Kroah-Hartman wrote:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
> 
>  arch/s390/kernel/topology.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
