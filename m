Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1D65BD27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbjACJ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbjACJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:27:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715DE0B4;
        Tue,  3 Jan 2023 01:27:08 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3038rnia031537;
        Tue, 3 Jan 2023 09:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mR+fL4sHpM2IjvOZKJOk8JnSeuFPchXAScxPuKjD2d8=;
 b=BkSlJCEgmHB4iwqbXBsYtvdh3iCmjs6wl8pg/CwLl/NE2zKW1QE/gwAC5FLfxx1LtNcA
 W1CPhpxEem8pjlVWBMOVEy4/rT70QnNgIMxrdidG5qseBLegUB4QGHTMIfwd1zGUoM3m
 E8QDz8UkQsElzMjUs2ec+brZMJSa/nCTnbuTwEdNqaxBMfkw2jqaNcMkYdIdKAfyKHGa
 X/wgVu4AjnxHtJcUmyq4ytmoMk5+XtQ3dou7C2i5Yoa7dfoFq+6gj1KOXl4QPUR6vomK
 4eovBade6OBtFpmbKNfdLAju9A9dm0egKV9pSM1NFmZCk5cdqYZPC3e1ZM/W1hMymgaL yQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvh8p8k73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:26:57 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302EEjvS011509;
        Tue, 3 Jan 2023 09:26:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6akt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:26:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3039Qpe649611220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 09:26:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E302F20043;
        Tue,  3 Jan 2023 09:26:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0425020040;
        Tue,  3 Jan 2023 09:26:51 +0000 (GMT)
Received: from osiris (unknown [9.171.83.23])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 09:26:50 +0000 (GMT)
Date:   Tue, 3 Jan 2023 10:26:49 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com,
        linux-kernel@vger.kernel.org, Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v3 2/7] iommu: Allow .iotlb_sync_map to fail and handle
 s390's -ENOMEM return
Message-ID: <Y7P02dYnvGgbqA2C@osiris>
References: <20230102115619.2088685-1-schnelle@linux.ibm.com>
 <20230102115619.2088685-3-schnelle@linux.ibm.com>
 <2f1beb15-e9e4-d8ab-1b68-c83f1a53c5c5@linux.ibm.com>
 <3e363da787126a4e8f779988ced92ae4624e3ec3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e363da787126a4e8f779988ced92ae4624e3ec3.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OaaAjdiGbONlT31k2AbBpa-LO5f64S6H
X-Proofpoint-ORIG-GUID: OaaAjdiGbONlT31k2AbBpa-LO5f64S6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2023-01-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=601
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 09:16:22AM +0100, Niklas Schnelle wrote:
> On Mon, 2023-01-02 at 19:25 +0100, Alexandra Winter wrote:
> > 
> > On 02.01.23 12:56, Niklas Schnelle wrote:
> > > On s390 .iotlb_sync_map is used to sync mappings to an underlying
> > > hypervisor by letting the hypervisor inspect the synced IOVA range and
> > > updating its shadow table. This however means that it can fail as the
> > > hypervisor may run out of resources. This can be due to the hypervisor
> > > being unable to pin guest pages, due to a limit on concurrently mapped
> > > addresses such as vfio_iommu_type1.dma_entry_limit or other resources.
> > > Either way such a failure to sync a mapping should result in
> > > a DMA_MAPPING_EROR.
> > > 
> > > Now especially when running with batched IOTLB flushes for unmap it may
> > > be that some IOVAs have already been invalidated but not yet synced via
> > > .iotlb_sync_map. Thus if the hypervisor indicates running out of
> > > resources, first do a global flush allowing the hypervisor to free
> > > resources associated with these mappings and only if that also fails
> > > report this error to callers.
> > > 
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > Just a small typo, I noticed
> > [...]
> 
> You mean the misspelled DMA_MAPPING_ERROR, right? Either way I did edit

I think Alexandra meant the below:

> > > +		/*
> > > +		 * let the hypervisor disover invalidated entries
> > 			typo: s/disover/discover/g

Now you know why I always complain when people do full quotes and not
trim replies to relevant parts.
It is sometimes very hard to spot comments :)
