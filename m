Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540166E1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjAQPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjAQPKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:10:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311633EFE6;
        Tue, 17 Jan 2023 07:10:41 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEvE2s019631;
        Tue, 17 Jan 2023 15:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=z9O9zPZkDqrnCuhkDxkogy0nY3SrET9KftAHRkcEYcQ=;
 b=p5Wwt+KegwJmNq4O+QjUnQtD7Z2aqlPjZ/1Po7cxFBc7jdIhGp1PrR1AtYYUE4w8yVW3
 rx2UDOx89pO/tqwIO2v1GI8nNnpZCMeGn3gUINtnrOBjVcYwBlcjFu8Xn+YwawQBBZnf
 MCQrlqBNXibZrFtB6WUcvefp6sCTw8IJJgwIL/m8w20euOxjxo6/gA6eL/cvE8vNXwww
 a6wHNVvnt173QPzyFvsx0AmTPpm1NpXY35zWi1gLzDg/sxhNZbzuncwo8DseAAbm1/qx
 8xMVD5XfNr7nqL6tAhmutBHJRUh7y8sF147j+53X6Ee5TJaVCCTW4E9qsHPct5tCe8d6 aQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5ww1rc3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:10:17 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HD87pv009261;
        Tue, 17 Jan 2023 15:10:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n3m17nx8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:10:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30HFAEOC24511042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 15:10:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68FDB5805D;
        Tue, 17 Jan 2023 15:10:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 180DE58057;
        Tue, 17 Jan 2023 15:10:13 +0000 (GMT)
Received: from [9.160.180.199] (unknown [9.160.180.199])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jan 2023 15:10:12 +0000 (GMT)
Message-ID: <5989dc61-d589-aa66-bded-2d30dca4d0df@linux.ibm.com>
Date:   Tue, 17 Jan 2023 10:10:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 3/7] s390/pci: prepare is_passed_through() for
 dma-iommu
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
References: <20230104120543.308933-1-schnelle@linux.ibm.com>
 <20230104120543.308933-4-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230104120543.308933-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eaaXeWWJhmccxxKXjvDHgfBnhyuw83KD
X-Proofpoint-ORIG-GUID: eaaXeWWJhmccxxKXjvDHgfBnhyuw83KD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=687 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 7:05 AM, Niklas Schnelle wrote:
> With the IOMMU always controlled through the IOMMU driver testing for
> zdev->s390_domain is not a valid indication of the device being
> passed-through. Instead test if zdev->kzdev is set.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

