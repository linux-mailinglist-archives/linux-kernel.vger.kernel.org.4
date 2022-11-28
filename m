Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9463AD06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiK1Py2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiK1Py0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:54:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3B22B37;
        Mon, 28 Nov 2022 07:54:25 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASFROEj011568;
        Mon, 28 Nov 2022 15:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=V9RHMe5UmmTFPxpkSh2dvjoU3yp2xmtmpWOJKhFGpzo=;
 b=SX9t14YmYl85bLbbLxM1S+hgurM+8Zr/sBP+gae88rQeAh6brph4Z7DKK1ldWvMA9yxC
 NuGpxxDVPjosod/fmmXwJ6Co/UXH5UKe7O9HF2G90qPCB9xEQSbi9r7/TG/RodyD0QTP
 EJVK6P6NiXJplpktwcBDFGIm9k548nVjfD56s6zSNdrCRAk94Blo7oiek42o9rfkzEav
 gzYbQsn/V0nCmHfOeLUo/GWtO7MAvH2q0TcczHx9/ssWXIsynof3jrUHAWVHGd7kXI0m
 x46RiIXW+83hqsKgs/YHlvd21wxFpikwIjCLNCHzQwwTz1XFKF+n5oqVGNYlZ6CafbhO oA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vmrm5t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 15:54:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ASFoG4A010579;
        Mon, 28 Nov 2022 15:54:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3m3a2httgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 15:54:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ASFs4xR7602938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 15:54:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B282A405B;
        Mon, 28 Nov 2022 15:54:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4A97A4054;
        Mon, 28 Nov 2022 15:54:03 +0000 (GMT)
Received: from sig-9-145-47-38.uk.ibm.com (unknown [9.145.47.38])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Nov 2022 15:54:03 +0000 (GMT)
Message-ID: <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Mon, 28 Nov 2022 16:54:03 +0100
In-Reply-To: <Y4S3z6IpeDHmdUs/@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-5-schnelle@linux.ibm.com>
         <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
         <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
         <Y4S3z6IpeDHmdUs/@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jGe2FfV0R5QPPmdx1v5v7mwqDGHY7ucg
X-Proofpoint-ORIG-GUID: jGe2FfV0R5QPPmdx1v5v7mwqDGHY7ucg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_13,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-28 at 09:29 -0400, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 12:10:39PM +0100, Niklas Schnelle wrote:
> > On Thu, 2022-11-17 at 09:55 +0800, Baolu Lu wrote:
> > > On 2022/11/17 1:16, Niklas Schnelle wrote:
> > > > When iommu.strict=1 is set or iommu_set_dma_strict() was called we
> > > > should use IOMMU_DOMAIN_DMA irrespective of ops->def_domain_type.
> > > > 
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >   drivers/iommu/iommu.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 65a3b3d886dc..d9bf94d198df 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -1562,6 +1562,9 @@ static int iommu_get_def_domain_type(struct device *dev)
> > > >   {
> > > >   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > > >   
> > > > +	if (iommu_dma_strict)
> > > > +		return IOMMU_DOMAIN_DMA;
> > > 
> > > If any quirky device must work in IOMMU identity mapping mode, this
> > > might introduce functional regression. At least for VT-d platforms, some
> > > devices do require IOMMU identity mapping mode for functionality.
> > 
> > That's a good point. How about instead of unconditionally returning
> > IOMMU_DOMAIN_DMA we just do so if the domain type returned by ops-
> > > def_domain_type uses a flush queue (i.e. the __IOMMU_DOMAIN_DMA_FQ bit
> > is set). That way a device that only supports identity mapping gets to
> > set that but iommu_dma_strict at least always prevents use of an IOVA
> > flush queue.
> 
> I would prefer we create some formal caps in iommu_ops to describe
> whatever it is you are trying to do.
> 
> Jason

I agree that there is currently a lack of distinction between what
domain types can be used (capability) and which should be used as
default (iommu.strict=<x>, iommu_set_...(), CONFIG_IOMMU_DEFAULT_DMA,
ops->def_domain_type.).

My case though is about the latter which I think has some undocumented
and surprising precedences built in at the moment. With this series we
can use all of IOMMU_DOMAIN_DMA(_FQ, _SQ) on any PCI device but we want
to default to either IOMMU_DOMAIN_DMA_FQ or IOMMU_DOMAIN_SQ based on
whether we're running in a paging hypervisor (z/VM or KVM) to get the
best performance. From a semantic point of view I felt that this is a
good match for ops->def_domain_type in that we pick a default but it's
still possible to change the domain type e.g. via sysfs. Now this had
the problem that ops->def_domain_type would cause IOMMU_DOMAIN_DMA_FQ
to be used even if iommu_set_dma_strict() was called (via
iommu.strict=1) because there is a undocumented override of ops-
>def_domain_type over iommu_def_domain_type which I believe comes from
the mixing of capability and default you also point at.

I think ideally we need two separate mechanism to determine which
domain types can be used for a particular device (capability) and for
which one to default to with the latter part having a clear precedence
between the options. Put together I think iommu.strict=1 should
override a device's preference (ops->def_domain_type) and
CONFIG_IOMMU_DEFAULT_DMA to use IOMMU_DOMAIN_DMA but of course only if
the device is capable of that. Does that sound reasonable?


