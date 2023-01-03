Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299365BD21
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjACJ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbjACJ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:26:15 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E12736;
        Tue,  3 Jan 2023 01:26:13 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3037NGv8023801;
        Tue, 3 Jan 2023 09:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xNI+Njd4y4LWoOAgn6ORCMtAq8zpqj9LPMriecoQWEM=;
 b=TTeL730el4q9emrLCA74SZ7dYIBQFoD1OshUibXxon2DJam8ehUUeW7fdJBjLq87N78r
 KbK2PWHNOm7aZTCaajbCh3geQGxINptUZd2anYS9V6bal+joFrbn7qQqlzHQSZowq3Rz
 XSFD5MYs/E+f8jU4KWhDIcBJ524pcqsuyBseRWAFdDGGYUDDUN8sxmH09bsQ0hUZYnNc
 WU4PEWI8tiHiwzmzBPUAm/migTCu0JzOUU6AZt0JOrw4XLc7VsOEvOeP41fx7IDLrGna
 zbrllbBYtOnlAR+fb1NA0pDiGlm1zl3Q7Nhw8/AmXeA60LnXKZS2voGVZhmkCpicJpJR Gw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvfx7t0rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:25:57 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302N0mNL006506;
        Tue, 3 Jan 2023 09:25:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6aks8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:25:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3039PpcR16908836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 09:25:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 770F12004D;
        Tue,  3 Jan 2023 09:25:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 470AB20043;
        Tue,  3 Jan 2023 09:25:50 +0000 (GMT)
Received: from [9.179.26.205] (unknown [9.179.26.205])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jan 2023 09:25:50 +0000 (GMT)
Message-ID: <eeafbe89ce7e8ac7a968f3f6cdb589913a23a7e9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/7] iommu: Allow .iotlb_sync_map to fail and handle
 s390's -ENOMEM return
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Date:   Tue, 03 Jan 2023 10:25:49 +0100
In-Reply-To: <3e363da787126a4e8f779988ced92ae4624e3ec3.camel@linux.ibm.com>
References: <20230102115619.2088685-1-schnelle@linux.ibm.com>
         <20230102115619.2088685-3-schnelle@linux.ibm.com>
         <2f1beb15-e9e4-d8ab-1b68-c83f1a53c5c5@linux.ibm.com>
         <3e363da787126a4e8f779988ced92ae4624e3ec3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pl6lCxqLvX_u_YyHn9wBI0rLjslBv6tV
X-Proofpoint-ORIG-GUID: pl6lCxqLvX_u_YyHn9wBI0rLjslBv6tV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2023-01-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-03 at 09:16 +0100, Niklas Schnelle wrote:
> On Mon, 2023-01-02 at 19:25 +0100, Alexandra Winter wrote:
> >=20
> > On 02.01.23 12:56, Niklas Schnelle wrote:
> > > On s390 .iotlb_sync_map is used to sync mappings to an underlying
> > > hypervisor by letting the hypervisor inspect the synced IOVA range an=
d
> > > updating its shadow table. This however means that it can fail as the
> > > hypervisor may run out of resources. This can be due to the hyperviso=
r
> > > being unable to pin guest pages, due to a limit on concurrently mappe=
d
> > > addresses such as vfio_iommu_type1.dma_entry_limit or other resources=
.
> > > Either way such a failure to sync a mapping should result in
> > > a DMA_MAPPING_EROR.
> > >=20
> > > Now especially when running with batched IOTLB flushes for unmap it m=
ay
> > > be that some IOVAs have already been invalidated but not yet synced v=
ia
> > > .iotlb_sync_map. Thus if the hypervisor indicates running out of
> > > resources, first do a global flush allowing the hypervisor to free
> > > resources associated with these mappings and only if that also fails
> > > report this error to callers.
> > >=20
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > Just a small typo, I noticed
> > [...]
>=20
> You mean the misspelled DMA_MAPPING_ERROR, right? Either way I did edit
> the commit message for a bit more clarity on some of the details:
>=20
> On s390 when using a paging hypervisor, .iotlb_sync_map is used to sync
> mappings by letting the hypervisor inspect the synced IOVA range and
> updating a shadow table. This however means that .iotlb_sync_map can
> fail as the hypervisor may run out of resources while doing the sync.
> This can be due to the hypervisor being unable to pin guest pages, due
> to a limit on mapped addresses such as vfio_iommu_type1.dma_entry_limit
> or lack of other resources. Either way such a failure to sync a mapping
> should result in a DMA_MAPPING_ERROR.
>=20
> Now especially when running with batched IOTLB flushes for unmap it may
> be that some IOVAs have already been invalidated but not yet synced via
> .iotlb_sync_map. Thus if the hypervisor indicates running out of
> resources, first do a global flush allowing the hypervisor to free
> resources associated with these mappings as well a retry creating the
> new mappings and only if that also fails report this error to callers.
>=20
>=20
>=20
> > > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > > index ed33c6cce083..6ba38b4f5b37 100644
> > > --- a/drivers/iommu/s390-iommu.c
> > > +++ b/drivers/iommu/s390-iommu.c
> > > @@ -210,6 +210,14 @@ static void s390_iommu_release_device(struct dev=
ice *dev)
> > >  		__s390_iommu_detach_device(zdev);
> > >  }
> > > =20
> > > +
> > > +static int zpci_refresh_all(struct zpci_dev *zdev)
> > > +{
> > > +	return zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
> > > +				  zdev->end_dma - zdev->start_dma + 1);
> > > +
> > > +}
> > > +
> > >  static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
> > >  {
> > >  	struct s390_domain *s390_domain =3D to_s390_domain(domain);
> > > @@ -217,8 +225,7 @@ static void s390_iommu_flush_iotlb_all(struct iom=
mu_domain *domain)
> > > =20
> > >  	rcu_read_lock();
> > >  	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
> > > -		zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
> > > -				   zdev->end_dma - zdev->start_dma + 1);
> > > +		zpci_refresh_all(zdev);
> > >  	}
> > >  	rcu_read_unlock();
> > >  }
> > > @@ -242,20 +249,32 @@ static void s390_iommu_iotlb_sync(struct iommu_=
domain *domain,
> > >  	rcu_read_unlock();
> > >  }
> > > =20
> > > -static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
> > > +static int s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
> > >  				      unsigned long iova, size_t size)
> > >  {
> > >  	struct s390_domain *s390_domain =3D to_s390_domain(domain);
> > >  	struct zpci_dev *zdev;
> > > +	int ret =3D 0;
> > > =20
> > >  	rcu_read_lock();
> > >  	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
> > >  		if (!zdev->tlb_refresh)
> > >  			continue;
> > > -		zpci_refresh_trans((u64)zdev->fh << 32,
> > > -				   iova, size);
> > > +		ret =3D zpci_refresh_trans((u64)zdev->fh << 32,
> > > +					 iova, size);
> > > +		/*
> > > +		 * let the hypervisor disover invalidated entries
> > 			typo: s/disover/discover/g

I'm blind, missed this one. Added the change now.

> > > +		 * allowing it to free IOVAs and unpin pages
> > > +		 */
> > > +		if (ret =3D=3D -ENOMEM) {
> > > +			ret =3D zpci_refresh_all(zdev);
> > > +			if (ret)
> > > +				break;
> > > +		}
> > >  	}
> > >  	rcu_read_unlock();
> > > +
> > > +	return ret;
> > >  }
> > > =20
> > >  static int s390_iommu_validate_trans(struct s390_domain *s390_domain=
,
> > [...]
>=20

