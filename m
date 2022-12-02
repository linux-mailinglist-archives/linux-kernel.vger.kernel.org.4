Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0164090D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiLBPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiLBPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:13:27 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72446D7C9;
        Fri,  2 Dec 2022 07:13:09 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2ExPJG015551;
        Fri, 2 Dec 2022 15:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+vXSUVUk7bLhNEiXhNiA/XbCIgif/TlzJh6tQqMJnfE=;
 b=fJs+ADdfLYiJ98AT7l5Tkrr5noRzdDOxZ5/hUX98sWHyvjS3E1pKOhOe49527L+JYbv4
 vR9Pdfp2gd3pIlKc4Dv3hojbGJkUo0kazlWklChb35NVYbUntaReu+mPGoA9KVvHXdfS
 wuSc7ERmZJHADXwhdAAfZ4N7fn/ZeG6GLKllYZ8FHm49voaKovmtycVi4GjcSoC+AzM+
 5gcyS1saQSKDXfw/lB+J0LqpdvjaIxsWr4i6eUTIR0v/t5SQbMj3e0edABdaEGmwrISD
 fn67iPN4t+iirA5XVOPL2D0o9j+rh9vsSgfN3I/Jizl9x1xNiflhLmAldu7lM9okFqdT BA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m7hku3th0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 15:12:57 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B2F6etY006982;
        Fri, 2 Dec 2022 15:12:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3m3a2j1ee9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 15:12:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B2FCpfo10158594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Dec 2022 15:12:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C5814C044;
        Fri,  2 Dec 2022 15:12:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DDCD4C040;
        Fri,  2 Dec 2022 15:12:50 +0000 (GMT)
Received: from [9.179.19.13] (unknown [9.179.19.13])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Dec 2022 15:12:50 +0000 (GMT)
Message-ID: <175d97e1a9d29d712f0334e37fc207a50c3ac5e7.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] iommu/s390: flush queued IOVAs on RPCIT out of
 resource indication
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Fri, 02 Dec 2022 16:12:50 +0100
In-Reply-To: <Y4oO8O4wCnWAeoGS@nvidia.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
         <20221116171656.4128212-8-schnelle@linux.ibm.com>
         <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
         <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
         <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
         <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
         <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
         <Y4oO8O4wCnWAeoGS@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8JoyAEGA4bwn0M4McjA56awsTr37D9Ih
X-Proofpoint-GUID: 8JoyAEGA4bwn0M4McjA56awsTr37D9Ih
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_08,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=647
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-02 at 10:42 -0400, Jason Gunthorpe wrote:
> On Fri, Dec 02, 2022 at 03:29:50PM +0100, Niklas Schnelle wrote:
>=20
> > @Robin @Joerg, if you are open to changing .iotlb_sync_map such that it
> > can return and error and then failing the mapping operation I think
> > this is a great approach. One advantage over the previous approach of
> > flushing the queue isthat this should work for the pure IOMMU API too.
>=20
> I think it is pretty important that the "pure" IOMMU API work with
> whatever your solution its, the iommu_domain implementation in a
> driver should not be sensitive to if the dma-iommu.c is operating the
> domain or something else.
>=20
> Jason

Agree. At the moment, i.e. with current mainline and even with the
IOMMU improvements in Joerg's queue, the IOMMU APIdoesn't work when the
hypervisor returns out-of-resource from the IOTLB flush (RPCIT). This
is currently only handled correctly in the arch/s390/pci/pci_dma.c DMA
API implementation. I think both handling this with a hidden/inlined
.iotlb_sync_map in s390_iommu_map_pages() or with an enhanced
.iotlb_sync_map that then must be able to return an error will fix this
shortcoming.  The latter would be something like this commit I'm
currently testing with:

https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?h=3D=
dma_iommu_v3&id=3Da2aecd821fe3c5e2549946a68d8b07e05b288a9b

Thanks,
Niklas

