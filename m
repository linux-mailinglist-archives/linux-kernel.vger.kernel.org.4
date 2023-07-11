Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8574E39E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGKBmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKBmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:42:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79067A4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689039727; x=1720575727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pjQvSwKGPtD6GORpKmEBJKe5RA+Ar69ihZmdbq0qcDQ=;
  b=c4V1RhNjOK2vXsRaHSvvAC5UkNr/8T1idbaqAyLZq9ILFlem7dugbQnX
   1qwq8OfQR7qg/b9/3+3v6oAW6eWOSxwtcBGkr/JGkGK9WLXTlqhqNYCAq
   JRU1Z05UoLkspZrjN0Gs/KPMwXi8bBGRUUQkTpGKvTsnJml6SeTol7IiF
   gdIUdlJW6Q/Zcn/auV5VPDqPteUCDSwLYNR6YJAr+Br8JzQ5X1K/7a+J1
   P/9wTJqq+up0YfftzItGveLLKl1+Gh0Ryew2qdKhCUtHgK2bXNReYlBS3
   rEc+HTE1YhDYQY1EumKZX2ji2WPm0rVfodwPfx65JiO5Z5GU52dR3WdvS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="450862386"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="450862386"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="671198180"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="671198180"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2023 18:42:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 18:42:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 18:42:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 18:42:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 18:42:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XotPmGNv8kJtRj3ybwMhUFvKj4nAIVImI7vZyO99C0dg80DJ6wnDD1+esZKB0e5h5hUikBxnHc1QXuPzeeoMecO39emu0Qsh23UshOibPAL26sKcK62+UpnDLmCUlc9GUNY36cdeI0sw4S6IS/71kiN5cRJHitMo5MRJYm+GLf+WELry+V8cPtqs9ir03hSwLKetR2cZhpOp6z+lTZKMXmKaxWcx3sf2ZtcAFmHIFAxUYj0Oacy+E34C2GSZQxzXR4Hw12J7W3k/M2YHYLrDFsUbiT7L5oHGyDm8iKjYoMSb8lYrh85gtivc0s3thqakM9Z3q5tNoC9uULl/epfa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4D5Ot69cin1zp0ksHEReiMJZ/bViWz6LjH8N34xIn8=;
 b=SpZsq0NjyXoSCWE0p2sC2hk4HI25EF5i7bD0VLSY7RVCy5r9fiYa3pCjHVVVPQO64/FP3QYNKnVOSyfLzAUruq2BrXtCQmfCbzjjWbGPvd7YvQNbsp445gDNWC4l1/g55QA1IjmExPVqEcH7Xl/GhtIA9R5C+1UoQsGFhMYEvBiligcNvBtH5Bdzk4mwggzPwsRUEomhWup1n4YVwbKLFSuSmYTcolxZgp0YWsgA0cCf8zjn7n+JKToDb/ZdjK5LQED1WJOfsroZax42hH0SHevwTXHlZ6N3oCA3OUXE0vX4u+tusWS0usiLAY5aGORgW5kpPzufGXIGky4Cyhis3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH0PR11MB5705.namprd11.prod.outlook.com (2603:10b6:610:ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 01:42:03 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d462:72a2:39da:5ac7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::d462:72a2:39da:5ac7%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:42:03 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Michael Shavit" <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Thread-Topic: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Thread-Index: AQHZsHNM7tdDs3iVJ0y7IfdNR+l0+a+zRwSAgAB1NCA=
Date:   Tue, 11 Jul 2023 01:42:03 +0000
Message-ID: <MW5PR11MB588170AB944EED07823993528931A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-6-tina.zhang@intel.com> <ZKw/xS7wOoRvNfnH@ziepe.ca>
In-Reply-To: <ZKw/xS7wOoRvNfnH@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|CH0PR11MB5705:EE_
x-ms-office365-filtering-correlation-id: 6ed0f3eb-8fcd-4ff3-22a9-08db81b006fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APwvtbbJd5frtOdpq+Mf+1Xnj9VHHAujQ7pF4FBaWpfNCpSZJhWEdPlhQ/9fbo4xbtiYEi8M/gTO+ewrCqfWFP6DOhCxhgD7vFoiC+ZcqDBluUYzMHa4jJAx+E6jp2TlT0vf2LC23WJmrNe28/A7p0BEYvbDpHpivsV/tKslDUuX4GdMFO5HuDXXfkhzTxLoPVGwGgp+owO7x7oEAPH+BQauMb6q3exsxqXq0AJkqU3BUVTXzcZAvKFslZrYbEOe8hjI71I6vWdGMJuo476MfSIKonzNzvhu+NqaQT+FatXEoE38umTbpHlkfKG3+KKVJr9chIbMiJaePGCyEbRKMz6plBRiHiIIl6ELhoXKBJslMSUTSENiYImpX8YPb2AyapGez2ZBDzKht6Bf3lcysYG2EnCBOklPeQzDpNoUFMxHMYrKFJCGVKiepNqtstKDNYB/BtqPPqXfEnt2GSApzhOQYzoOAgCHYCjakEUosJbYrVci8OVAeHf31rMukZrS6rMheXN7XAjfOAryCm4Y8zit3/MEzrvpdY4cEif0NiP5B4ZsrrIBJy3Wh162nfSdA/EvRM3HSkFLW4GDvKdJZik3UoToIVQnhnURQZ6q1lhvhXDsEP75pnl4tL7Fp/qm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(478600001)(55016003)(316002)(6916009)(4326008)(7696005)(41300700001)(53546011)(9686003)(52536014)(26005)(6506007)(66446008)(66476007)(54906003)(64756008)(71200400001)(66946007)(76116006)(66556008)(186003)(2906002)(83380400001)(38100700002)(82960400001)(122000001)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7T+ClMLKcOsFZtmQLPuvXwDQ955jj6Z3bF7Jll0JZlwkmekMpzYiuDQVqU3q?=
 =?us-ascii?Q?CqLuxK+oEVRaCMgeX1W8964lOPJTpYXTWQaPDWpqElTr+YMenpwFRnn31b1w?=
 =?us-ascii?Q?mt7+zDFOYqhOxWuosSAyv60rMreyYYfrTOg32dvjtK+RSeMm/r/diRJxls21?=
 =?us-ascii?Q?tm37VXItkbfSH+4cdU4q4n1Lako/wjwhMRij0ATQ+1+b4egueWPxQ/NhxsJs?=
 =?us-ascii?Q?3ZAD/2v55QgY0TIuQNmE6dZzmVbYOVMebWhw8Nx6WS2Zm1aDwk08FCdTfcdk?=
 =?us-ascii?Q?XZeUTn/uTe3dQXWn+m+Hsmy/JqF252b0ZgPpQTmhChfb8DLF+NhoOcHVk6i/?=
 =?us-ascii?Q?T796InmiAk8MGrXd1WVVSJMQM8PcLC2xm5fcCZRHU5FGb5GTeV9Mci9M5/4J?=
 =?us-ascii?Q?tdqISQJqQk2B4dGIf7GEpFknFCPEJMKIVHcA5thTpq92zlRQOpxJr6+AMEbN?=
 =?us-ascii?Q?Tumhn6fI7dThAqpo66HhcjpmazZG9i6ODOgSlnw77KFB8oTZgALpp+rJU6qB?=
 =?us-ascii?Q?sY1xtF48DMXb0c3ZPR/8AWy4SekpOcd+DWgmlShdb31vdyYCAnSDFCcVxQXS?=
 =?us-ascii?Q?KBB+ctbk1/QjIkeLuwpYG0mze4vFFeUkatsAUYIt3AEdYalPQY18JpfVmmTX?=
 =?us-ascii?Q?dr59HKpPpFptEvxO5If6e91ma/bMTUvwJMZOb9Up1c1UJlaU5rjebEkR5Cxw?=
 =?us-ascii?Q?p6SAdh27EctkQDtpTnX29VRTAfrp5pyWIbz0LWBDKoyUqn//LUGIlYHgTosf?=
 =?us-ascii?Q?SICH6Id0eDUVfb13kP0uj7n0SqrwSGvIqSoZn56iylx8cRZM36396vhcj9t0?=
 =?us-ascii?Q?cU2GkEb9s74aWp06Ei5NF0NVWYpZk7pawcqrQmiQH37O8F7QdJFLjcXwW7Yh?=
 =?us-ascii?Q?InB4WyfgqkmR9oDlgDonyU/EppcbEfopb+MG+xbPUxfXqSWXo4pbXoWFYdru?=
 =?us-ascii?Q?ndqqlte5HlOCBR1Dx/cRk7nNqQ2kI27eUkM8iKbBvctrdlKVjhP7dJCpwWSf?=
 =?us-ascii?Q?gnD8RZ+rOJZyYHdN1t4oUtIU4ThWY4nE6Og7YhYXHowgRhqKsvPC8jXbWfZB?=
 =?us-ascii?Q?h9X2Z9hb23lJJiiZgoYz0XooBCXUaJnia5IuyTWJ/VJJrOzrXZbSQVoYGHBH?=
 =?us-ascii?Q?ua/9AkpDIcpEbvIQEyHcLCdOw5qP3wrc+2InQfvfL+xIhQ5CwbEOOUG0gh1L?=
 =?us-ascii?Q?lsYjpJftul6zmLDUDXvp3+AWVyCZAf7uwVe29bEzEeguMxMn7c8UloHU5ji8?=
 =?us-ascii?Q?DTkIgLhc47ZNlG5+B7XrgD5z1gzZV/vGd7Z01hKBJBYfWg44t8AmpQka45OI?=
 =?us-ascii?Q?g7bKegsKINzpPAAcVbOHLnfJT014ydX8RcYzSAIl3SUcXMNHUdLpui0LW/AO?=
 =?us-ascii?Q?DAggY0ZSb1Ct7lqEZILvOCASZ8ugeQ+BTmXQLACQgxsFaQJZNC0FNOK8qRJf?=
 =?us-ascii?Q?CqrL/pn3YGFIcUO49nLb6mN0YpuRPbXyLs1Za4miUw0a7UOftKQsIyoU6MJe?=
 =?us-ascii?Q?Ts00vB9hXGEVuxanI8VoQNIL9XnMDfxYGFlKAqk1Ey7ulWBA6q42iluntYId?=
 =?us-ascii?Q?xG7T45sitz6VZQG7htlMrykd0wEvj+O+SF+HF2rc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed0f3eb-8fcd-4ff3-22a9-08db81b006fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 01:42:03.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUtfz2bQIMpAi1hkFGWCGa0BZIEuORgtW6loJsxehFcWFX4IbaADBnnhoe1p/U4Qc0QPs2srr+lrnShmIi1C0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5705
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, July 11, 2023 1:29 AM
> To: Zhang, Tina <tina.zhang@intel.com>
> Cc: Tian, Kevin <kevin.tian@intel.com>; Joerg Roedel <joro@8bytes.org>; W=
ill
> Deacon <will@kernel.org>; Lu Baolu <baolu.lu@linux.intel.com>; Michael
> Shavit <mshavit@google.com>; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
>=20
> On Fri, Jul 07, 2023 at 09:34:40AM +0800, Tina Zhang wrote:
> > Each mm bound to devices gets a PASID and a corresponding sva domain
> > allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> > field of the mm. And that PASID and sva domain get released in
> > iommu_sva_
> > unbind_device() when no devices are binding to that mm. As a result,
> > during the life cycle, sva domain has 1:1 with mm PASID.
> >
> > Since the required info of PASID and sva domain are kept in struct
> > iommu_mm_data of a mm, use mm->iommu_mm field instead of the old
> pasid
> > field in mm struct.
>=20
> This is not technically right, the domains need to be a list, and we need=
 to
> search the list. Almost always the list will have 0 or 1 entries in it.
OK. Then, the mapping between sva_domain and pasid is n:1. IIUC, the reason=
 why we want this n:1 is because sva_domain is a type of iommu_domain and t=
herefore may have some hardware IOMMU specific configurations that cannot b=
e shared between different IOMMUs.

>=20
> > @@ -88,31 +98,41 @@ struct iommu_sva *iommu_sva_bind_device(struct
> device *dev, struct mm_struct *mm
> >  		goto out_unlock;
> >  	}
> >
> > -	if (domain) {
> > -		domain->users++;
> > -		goto out;
> > +	if (unlikely(domain)) {
> > +		/* Re-attach the device to the same domain? */
> > +		if (domain =3D=3D sva_domain) {
> > +			goto out;
> > +		} else {
> > +			/* Didn't get detached from the previous domain? */
> > +			ret =3D -EBUSY;
> > +			goto out_unlock;
> > +		}
> >  	}
>=20
> And if we do all of this we should just get rid of the horrible
> iommu_get_domain_for_dev_pasid() entirely.
I think it depends on whether we could get rid of iommu_group->pasid_array,=
 right? In the current implementation, it seems iommu_group->pasid_array is=
 expected to identify the usages that need PASID-granular DMA address trans=
lation (i.e., not only for sva usage).

>=20
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > 20135912584ba..1511ded7bc910 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -1175,20 +1175,20 @@ static inline bool
> > tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream  #ifdef
> > CONFIG_IOMMU_SVA  static inline void mm_pasid_init(struct mm_struct
> > *mm)  {
> > -	mm->pasid =3D IOMMU_PASID_INVALID;
> > +	mm->iommu_mm =3D &default_iommu_mm;
> >  }
> >  static inline bool mm_valid_pasid(struct mm_struct *mm)  {
> > -	return mm->pasid !=3D IOMMU_PASID_INVALID;
> > +	return mm->iommu_mm->pasid !=3D IOMMU_PASID_INVALID;
> >  }
>=20
> And these can now just test if the iommu_mmu->sva_domain is NULL
Right. Baolu also shared a similar suggestion. Thanks.

Regards,
-Tina

>=20
> Jaon
