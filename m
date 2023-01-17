Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759DF66E1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjAQPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjAQPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:10:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F3B40BE1;
        Tue, 17 Jan 2023 07:10:21 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HF8psd035724;
        Tue, 17 Jan 2023 15:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HGhYI6PTtHYBXEVbsKJGAI1Wmj2tP4eKOCoTV7iwyJs=;
 b=eaNX9tYWpzzcZDxVArtK0bNsln3sxnVpiCHXI1kvx259UXLWGWmDaZ6CRvwXk2kxrGKB
 ZHqrFUvZlArrbwZ4q/h2alKJhrnzZ4EXK9zweMUexT4TZkEtnrKPc0tSDGGKvkTbTYVX
 T5fRJ9zZ27yliP7JLPqvVAHYrLsltj/VFRtRsQ6pcxNRxudyH/PgnptAOhvL0ZX0+s1k
 IV0SBsHd+tqJ46W0C2tQ4EdoKB43TMZaj/z2EsLvZfRJk14DGpb0ytRNyAvhG6yQ/ijW
 J+4rpYbBG0xfVqQ/aiJdHh7dDntbO0AfWsuYTPdnbL+Pgxelh1LMqMqK4nC5Mr/qpIsg +A== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5qb62b17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:10:12 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HErATQ019293;
        Tue, 17 Jan 2023 15:10:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n3m17dx07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:10:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30HFA9da10027604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 15:10:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86FB958059;
        Tue, 17 Jan 2023 15:10:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24AC558061;
        Tue, 17 Jan 2023 15:10:08 +0000 (GMT)
Received: from [9.160.180.199] (unknown [9.160.180.199])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jan 2023 15:10:08 +0000 (GMT)
Message-ID: <849e5a33-519c-be63-7400-2843a8440620@linux.ibm.com>
Date:   Tue, 17 Jan 2023 10:10:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/7] iommu: Allow .iotlb_sync_map to fail and handle
 s390's -ENOMEM return
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
 <20230104120543.308933-3-schnelle@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20230104120543.308933-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ivzef_09X9otzHbPWZHmD3cvnwV8aBcw
X-Proofpoint-ORIG-GUID: Ivzef_09X9otzHbPWZHmD3cvnwV8aBcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 mlxlogscore=844
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 7:05 AM, Niklas Schnelle wrote:
> On s390 when using a paging hypervisor, .iotlb_sync_map is used to sync
> mappings by letting the hypervisor inspect the synced IOVA range and
> updating a shadow table. This however means that .iotlb_sync_map can
> fail as the hypervisor may run out of resources while doing the sync.
> This can be due to the hypervisor being unable to pin guest pages, due
> to a limit on mapped addresses such as vfio_iommu_type1.dma_entry_limit
> or lack of other resources. Either way such a failure to sync a mapping
> should result in a DMA_MAPPING_ERROR.
> 
> Now especially when running with batched IOTLB flushes for unmap it may
> be that some IOVAs have already been invalidated but not yet synced via
> .iotlb_sync_map. Thus if the hypervisor indicates running out of
> resources, first do a global flush allowing the hypervisor to free
> resources associated with these mappings as well a retry creating the
> new mappings and only if that also fails report this error to callers.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


