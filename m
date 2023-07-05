Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3803874818D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjGEJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGEJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:56:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B3DE41
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688551013; x=1720087013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mm9gK02IAPCVn7J7eZdjkNgz+XkPhhobhoQ36w4SPaA=;
  b=R8lQkDofe6UHglJk9w+g1KGtPHMyyXI7lNLHDNlMBOUHN8Ic0pWsZlyG
   6lSbNiVwztnJdecv+kFK/uSy98xc2yfYrsOXpdt51inXlHmVcz2WpHmhL
   D0sexmdgPeJKw/oU5dxAiyFj7/S7gi/ZcW1ltN2VzJX8m4KiMgLgU9ku4
   5xtIb0XB0DYBUwj+5FFvzx8Nt4lvc5Ke9XkGcHhFsO31k1/KEqthsRjfG
   7nAaNs5uewgD3tBoa25W4TEpQy2CL4pcw297u+i9tpjMkOAIaqqQVx9/w
   IfhobCACyf3H/iNvCLZDVYAVHzha27HLVeVqRUWOcO05lhc+uM/WHsQLZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="426983942"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="426983942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 02:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="754304300"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="754304300"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2023 02:56:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 02:56:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 02:56:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 02:56:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 02:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBXX3P7DZYTwqO2x61Exgo8laiqPcpvTNk4u+C1d6AfKI5QkpQ02HKzuO8d7DnIwfhCubu7OAV3rShbH70kz2KX1i4bOTkIVKgydnCb/NkTbgUaeFDW7h+5oLqk6ieL6AatSXVMeXNLVr8qHpygwn6IZgkI/w2FTn1FDCiCrXBWWZLU76xk2jKLrmtVEc96Cvkzvj0HXoxPqqhNxAaqjYimP5Za0NzKbxLSvlKX4a15jwm0GEk5mtxMbo5txCkz+sdWJqPIGHDGmErIGoZ/X49I+ULUmChZDuSwSlnL8sCiPFfL2lc01IkO+LIN9B8jnGpMOetLYyEdzKm96KJcRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm9gK02IAPCVn7J7eZdjkNgz+XkPhhobhoQ36w4SPaA=;
 b=iGpu4o+eYe+6LlS+FEMr05qdlWZjH4fOYjx8Meo+XotlV0cNyAS9rEFEnVrdiZuu+8RccOoCocwMPm0yDXnMLgiyeEluswP0VocFYHbB6Xj1M1eKceIXHLh0r6/arMrG5YVv6u23vj13LbWbU6VeKNpCsy6hv7kf4yxSqcWAYQlXLO1Y0vvUo3rVQMC9f+Ukm6SRDqDCsyYfz9W1TtYKcvjlKwhkiyQmVUR9XnGq7edNqIYu9LgT/6hCx9wjclmNeP8qsW2BDaYtImTfpkp2ZFxG7/P4+vXcJf9r/d3YLzWkI3O8wOh9mNOQTwmzTlz0E6BtvqzAH7KZ5kt948xg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SJ1PR11MB6105.namprd11.prod.outlook.com (2603:10b6:a03:48c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:56:50 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a284:d072:336c:f233]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a284:d072:336c:f233%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:56:50 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Thread-Topic: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Thread-Index: AQHZmHAAx5RbbLZUakKJUTzXs8dX169+AmQAgAAYP4CAASOlgIAr2New
Date:   Wed, 5 Jul 2023 09:56:50 +0000
Message-ID: <MW5PR11MB588179952AEDB50D9259549C892FA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com> <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
In-Reply-To: <ZIBxPd1/JCAle6yP@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SJ1PR11MB6105:EE_
x-ms-office365-filtering-correlation-id: 4e56af4a-9e7e-47e7-d6c1-08db7d3e2753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpBRCPR4Ub1FWPqGsOYVm7ZzWgZfyQm8e+SlVFDFW/Z3LTwJhyz46KGIV6e0dt2XA/XdR9OYUJpMwJ+tgY+Kg1BzihnKEnvkkcmM+ogVcJUyRx0CiGHzi9udfhIhveVy1f5kNdAssi2sbCp5/be8BvvBNSlTyofJb0yXYCXHdhriYx4DLXcqK6UGHDb6+DDhpwKn+oCw0RK/sRTKdx5B1I5/UnuSIlZgGULa8R7YIgiMAlQk5jKNxcikT5y7KqO3qtDpBiNKYMXeECdQRdZV0T/bkKyt9IB1Jsa6PfNzONt6QVhWsiztecJRamD7N9qfXtUokjGZC0XEwbdvR1ey1VNewbsqkudbEDhVFtojZtUb8qG3dTdRG84WKbLzosMSQ3qWyhsGNVYNpkdN/tf5HRdpUEmISCOJmaZ8shjCaIeJLhOcv8Jtt+tTbGj16JuFsh/1pHCAM0P5sDiipETNss/ST9MRBSsf8aZSuzIDnVv7/gca20b0na4pQBoY2DuK1FijZdFqY/OAqkTUEDw2flQ3UvYrx1zXSA15yqAqHa+Pf1X1wdbIHEa5LryZOreaW0EPu5/MVkmhSMUbNl7P90CWldirmIs6F0zApl6i57xNtLN7zJ6YmKYl9zz0I5zv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(33656002)(7416002)(66946007)(4326008)(76116006)(66476007)(64756008)(478600001)(66446008)(66556008)(2906002)(316002)(8676002)(8936002)(52536014)(5660300002)(83380400001)(41300700001)(55016003)(9686003)(38070700005)(86362001)(110136005)(54906003)(38100700002)(7696005)(6506007)(122000001)(186003)(26005)(53546011)(71200400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?99sd9ehyYh5GnGj2xvYjWM35asL34iTfYRiCkVs1qDmSTFgpGS0KUPRKjEyY?=
 =?us-ascii?Q?NVdjEikS+d0B6WhczkmVwf7oXlhX8NNwN8yBmgYb82hRwC9IJSb6dAD4V/4g?=
 =?us-ascii?Q?RPqM8vqML9HHar3DLEbN/IBq0xYqCiNb31Gvcb0FmZdlmz1pf2DfCwGQezPB?=
 =?us-ascii?Q?yrZYymchu9K+tDGZxB2cvq/8+u1LmdF2Xkn4PapM+qimF8GFUDuoBmm7eAob?=
 =?us-ascii?Q?xoIKBiKrjcUXrJl1uqoxFHjUKyJ8qK+difR1PqnGfLJPEasrGFanlKyi8Euc?=
 =?us-ascii?Q?2M9qt1NZLKVIs+2kEYFqPq9TOYc8F0Oko6WJ+pxPlboJfFbmZ7dZqojdRaO8?=
 =?us-ascii?Q?mbZKBYJYD4pRTBoKiucWisaZG83UiuV1rU3xK8dI08RRxn4xM++Cf68p5f8P?=
 =?us-ascii?Q?7brl8L1x9F4iPvVzszmTFzj7szWODRIk7wfPov4VT1lS0Bd1MBIP/EWxYzVd?=
 =?us-ascii?Q?H8AvjIwURWv02JvQ7wRlXpK0W9KKc4qrALXPz7bZy6ao4yu9VTXZCABOH5f4?=
 =?us-ascii?Q?k8wRaIDqb/Giddkb7Cq9A+M1Q6R8LWl4Xyrq6LycXI0AnbimHWUnGf6gf4jw?=
 =?us-ascii?Q?Q6mAAqhyBJVBsRWgrbFIIZgc32/UJfEm9JK0k/I6BBZKJpcr/EN3zmbNSdW0?=
 =?us-ascii?Q?kMBiZVIhU02nINPwaZN3KUDJrWss6S9ot4TIw7notgc2Ku8beQZXbOpVt72o?=
 =?us-ascii?Q?D3rYbmLS9vdXx54v/jpKvuN84g/2ZjwAEmoKTD2po5Wc7+vNNEAxFp368V0M?=
 =?us-ascii?Q?+XHJ59vpXbJQwPN/wjcIoz3WZmK2tBKvD2xsXLDGcvwidlg1n3CL0BYmDg9N?=
 =?us-ascii?Q?wQ+dYs+lC6Aurot3ZeocBjDQfxkrOgO39veDNi3+xw+lbsmLDKFWA+R6j/os?=
 =?us-ascii?Q?tqlJgGWOsTUQR2tg8EeVYynp8wGh4DIpfHN36EHpJp6WNyYxz/HskBIRyblv?=
 =?us-ascii?Q?deoEB4dbE3kCEpAeAzyA0dRYAczu6vKyILDBw4ToBX34W2TCOyZ1YyAGJI2C?=
 =?us-ascii?Q?AkqMJC7Wx7wWnTqyuDkdcjncRUIR/2wEjS2j0fhYyNaxqxuMgBHd3oysmgOk?=
 =?us-ascii?Q?tcpKIbuaKqz/mO9ZwqPDWVSqALmTrC/ivOhpPCY3Ad+vIrbZoWfhW73K5kU1?=
 =?us-ascii?Q?3pF7ttBb7MOVuRDBjL4jNB0IqyFuN5ICS5sGJQIRiTlPJLqNwGXjyTpqXNEX?=
 =?us-ascii?Q?2d5oF7IbyAnDuD4HxI6meWnyfoP1TqinsDpmGfPATMonK1n0GPcPR4OyDJhW?=
 =?us-ascii?Q?7I2anSUzOCsA5oJy+xB3nOzlElOfxYXxNptUyPkQ14PKDEgwavrdOjk7u7ee?=
 =?us-ascii?Q?ZbaMSB1bzVm8jWdXXIn5+ZLiUx0IUQ+e+0UOhVR2/hJhdXEJLpwDn0mKgiGf?=
 =?us-ascii?Q?xzDLE70xJnsLauaEiCQYj0NSZ4PILdcGWr6MYyV0wEdVpjY/jettpL13mHB9?=
 =?us-ascii?Q?i+1xfUY7DpLpScV3SqkCNowQHi8C3TKfr+3JaOpzM/u7XXf6Ruo9ASEBlNkt?=
 =?us-ascii?Q?Ytv+b/MSbNslwykpVLseFrKA5/q86s5y9GgKvUbi2cr6fEMbqXKv8rk6Ly+7?=
 =?us-ascii?Q?D9glLXLTLmlQPqLcLrNqF79dWmtDSZy3ZyPY/Bng?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e56af4a-9e7e-47e7-d6c1-08db7d3e2753
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 09:56:50.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NuvaYowzjU+uCJDvgdyb7N0obMUhKsWkh4OwxDTVlkA9FdAh/2pY5VIcCT/lnqomvSJSMVD+biG+NW40Q8nLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6105
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

Hi,

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, June 7, 2023 8:00 PM
> To: Michael Shavit <mshavit@google.com>
> Cc: Will Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>;
> Joerg Roedel <joro@8bytes.org>; jean-philippe@linaro.org;
> nicolinc@nvidia.com; baolu.lu@linux.intel.com; linux-arm-
> kernel@lists.infradead.org; iommu@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with
> shared CDs
>=20
> On Wed, Jun 07, 2023 at 12:06:07AM +0530, Michael Shavit wrote:
> > > What we definately shouldn't do is try to have different SVA
> > > iommu_domain's pointing at the same ASID. That is again making SVA
> > > special, which we are trying to get away from :)
> >
> > Fwiw, this change is preserving the status-quo in that regard;
> > arm-smmu-v3-sva.c is already doing this. But yes, I agree that
> > resolving the limitation is a better long term solution... and
> > something I can try to look at further.
>=20
> I suppose we also don't really have a entirely clear picture what allocat=
ing
> multiple SVA domains should even do in the iommu driver.
>=20
> The driver would like to share the ASID, but things are much cleaner for
> everything if the driver model has ASID 1:1 with the iommu_domain.
>=20
> It suggests we are missing some core code in iommu_sva_bind_device() to t=
ry
> to re-use existing SVA iommu_domains. This would certainly be better than
> trying to teach every driver how to share and refcount its ASID concept..=
.
>=20
> Today we have this super hacky iommu_get_domain_for_dev_pasid() thing
> that allows SVA domain reuse for a single device.
>=20
> Possibly what we should do is conver the u32 pasid in the mm_struct to a
> struct iommu_mm_data * and put alot more stuff in there. eg a linked list=
 of
> all SVA domains.
If we are going to have 1:1 between SVA domain and pasid, why we need a lin=
ked list of all SVA domains? Would a SVA domain pointer be enough?

I've got a patch-set which takes this suggestion to add an iommu_mm_data st=
ruct field to mm_struct. I'll send it out for review soon. The motivation o=
f that patch-set is to let the invalidate_range() callback use the SVA doma=
in referenced by mm->iommu_mm_data->sva_domain to do per-iommu IOTLB invali=
dation.

Regards,
-Tina

>=20
> > Splitting this part into a follow-up patch series would definitely be
> > easier and helpful if you're all ok with it :) .
>=20
> I think splitting it into a series to re-organize the way ste/cd stuff wo=
rks is a
> nice contained topic.
>=20
> Adjusting the way the ASID works with SVA is another good topic
>=20
> And so on
>=20
> Jason

