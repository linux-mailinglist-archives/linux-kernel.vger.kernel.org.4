Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6118269592A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBNG0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjBNG0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:26:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C717CF2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676355990; x=1707891990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q6OaY2M9rekRhZ0tJe7t8Ev6s8168KSAZtExo/RsTDI=;
  b=mUiDn3p8REEQAMQcMywGdbvRxvsH9HvM498fS2JoaIDhubElKPKDp2Qf
   4RmyBVJJ6caNhrHhLEcziMRYyfPm21TVHYuQoOUSr5T0wepvnztmNAn7V
   40yNYTYpEFiuV76xsouTPu8QA9p8lOVT7vfyQOKi5HwcyYg7S3+QCX27e
   Euv2kxxhiAHzQAOxJPh9CeOvPPqRuBw0PRAKzYeGU5nHkvpDJyR+zF0az
   n9H14RgLusj3dOr/JQyPtfuhYO6nJGmRqnniUhDewM+0YnJSwT/hQB9bo
   gyYLb6sWuGmtohW3MAXtHoC1HMl7hI48wnI3rb63v6rta1xneESC63J9Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332403478"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332403478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618928956"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618928956"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 22:26:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:26:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:26:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 22:26:28 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 22:26:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTm+y9Lh8kBVij1wRnB8NudeoVEJChnNo3hYZnUo5wuypfyNt/cRNHhlLj16vO1jPGSaGi6ODiUcrwybRLM4HHsk5vTHBAHbK4WhivtUtK5NHVEvIYUelDvDnGhT2avUGZm7vZIx8WSSzfDVK6bombqldy+qkE+y6a/jYF5Obr5354MbiW9N/rl8Nd2fL5wHsX0D4ci6iJ1djddWAmJetsOdrNtmE7QEQuW+p1iPQeUT4KWnbrFeg2AcU+6GIG5Bqy8IbT8QJy4UBM2/3/z5NUG9SFwlR3N/cuwve0j5F+5X5UrtTekCm2uMKSvCAa/5Ugx/D9PV85ekdKIzjP/YAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pimQj4wPjOhPAGhomyqObJd8qnXT1GmHXE71qFlszv0=;
 b=PyNuyQnIPZ2uscBw80W4CXm8Ju+VS0tNSWMBttYavkAJU56vr1sb4fVpjpt4j3fqObJwMBZqNfG8ujfATWBPQOfz4jU6PiFpnHT8Vxoh+3lTZGXEwKVilKCRH6QmKcOTi09EBr6iUY7pEhXvEFnIJ2xSmEb3YFLxX9DHavYQzJ/mmL2kyuuOIBNEi1u4lhgxOJTXeRQJb6sT4ZOHUAJ23EFWiuS2J3dcxUm6DHNQB0IJlfKTJyOoKXLYBn+50/mnqxC8xSxbFuLH66cNQ50fHUTXJmZcr/OAi4V8p7qYaVsJg0GzPk8EBBewEtpkCMQJnYapYcZ874bjz2EofNTVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5599.namprd11.prod.outlook.com (2603:10b6:a03:3af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:26:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:26:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Thread-Topic: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Thread-Index: AQHZPaM4X827KMb2AkC/Wtvslyhpl67NEuaAgAAlj4CAABH+gIAAItkAgAAafoCAAAb1gIAAAJAAgABvEpA=
Date:   Tue, 14 Feb 2023 06:26:25 +0000
Message-ID: <BN9PR11MB5276D28B4A4BF8DD3AF1A2828CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica> <20230213103455.02f3ac37@jacob-builder>
 <Y+qR5zC8ZOkVphgv@nvidia.com> <20230213134402.194ed7fd@jacob-builder>
 <Y+rFW80DUHvf3hQP@nvidia.com> <20230213154345.0f76eea1@jacob-builder>
 <Y+rLqg66BBPsfsRK@nvidia.com>
In-Reply-To: <Y+rLqg66BBPsfsRK@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5599:EE_
x-ms-office365-filtering-correlation-id: 432b294a-d45f-4a52-b85f-08db0e546662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZeEKj5WMxpmCv6KeYuIqlaRJjWmJH/YHE+t0on6Biqqzfydblzdu5vZTBVaKIoG0+s+Lzuu77NZekZlbqBQBunjzSiQPuY0YLK1nbKeiudGVagPNbBNvu5wxRqaEAoMsAKwPi21cQfW67ALkl6JNzI+3uz7FKQlAquAOGPEvO/XLZGZ/70u6uO5xuPeSJIPzCLAALWsupNN/YRtKL713UFWsM7z5SjW7/25QbsZ8VyPeJc+E1xurj/RDF4prjMN+EX1irTXaCa+cJ5z5zsVeJGWDDY7o2OBWUO4pFMAfU4wMsADuXtT5Kr8mR7CvJhEEam5Kx7sUD9Nuyo990bKcsySsy7J62Cu9Pl0jnfTsy6WTF+GJU0lrb+fFQIgF9GkyFtdJLumBBxAiTtufqVew1IC9MnMHijY9nZe94k/259K7MZWQfyFr2W8HTEqSHAmhLPyXPPTWFRmz4FRZxZdnmlk9Gny2zyHto4DlDqJ9s1abOM0vxD2d8ht8RnnR0qH98ZGmjTcOYrCIdxu9hKzqi+l7cpYGa236N1ac+WVOB75GyFsoVmP9mwg4rlYUgFHowrfv08TtrD3UvwfcZAM/wY0c67dYIDS2iNAGn/B37TEoAPPOoYjLKKELxy8Zl5yyhsib/vgGCvU6dFOZboNgRhM7JaU4SmeSf8z/JW/9BdY2mUtSLlFAY0aCRwStdFkM1TdqV9jhi43aTrSBrL2ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199018)(122000001)(52536014)(8936002)(7696005)(316002)(478600001)(9686003)(186003)(71200400001)(4744005)(26005)(7416002)(5660300002)(55016003)(2906002)(33656002)(38070700005)(86362001)(6506007)(38100700002)(82960400001)(54906003)(110136005)(64756008)(66446008)(41300700001)(8676002)(76116006)(66556008)(66476007)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q35/+UEyWSCv7uEnkdD+vaAlHmCkLwNffvdNlkg2gGqc8M7lWJ9llbjxmLy4?=
 =?us-ascii?Q?z5+rW5Z7hsrCdj44V720FjffmZmk9B2dYgoBUKTUOE46nVQ2RUPRJm/ikv8G?=
 =?us-ascii?Q?hpvM7TAd60Q/IxuCZi4Gy3tsnJFjWx9pfKxNu4azKUUWe/5jSMTbH/7eQcij?=
 =?us-ascii?Q?Z9bDc7JQRpSReyhcchZnHaMAFsR57iwmUz8b9ANUHRts1vLVtmwOuspdFuxJ?=
 =?us-ascii?Q?rpjnlnsNqgjmlMJmj0sN8WQPMzXYTuitKm4A9f0OsDOcQtj5EI7JFKEzbixf?=
 =?us-ascii?Q?8X7InSL8Dg9YB/c4gpfjGLP/TjP9rEMIjn6toa4E99O30TJGqNEku0Ru3LLz?=
 =?us-ascii?Q?UaZ5JSLtFgTgfRBwXfzmXN5qniKiVvlR6Cg6ZXPGl9e1+OK+skk7VBd+8X7l?=
 =?us-ascii?Q?e2cvubEDZInl4R98zRb6wng5IRBmICDh+zUas3Dc26JaOU81jeAhM//MgxrS?=
 =?us-ascii?Q?0HuTKkR2nBL2lgTU7sA3TFwFHIFYi6RgHw5lkDP5AWCtLKrX3PN3D4AKisdx?=
 =?us-ascii?Q?HalnDYYJfXaOjEJnaTRh59oh9IHd4Pfqn5DgAscHQvNOeDVMamjoO7OoQxRU?=
 =?us-ascii?Q?w5FUPkC1fBp/dAbHUm5EW7oNdqkwTeLrd9vPG7Tq3rQqBFkYgccTbp42Yt1f?=
 =?us-ascii?Q?mVadBy+kwH2e96d/3wqHmwjGpdbaJjzdhmSInrsxqbg79N4bOyXqlxzpUM/K?=
 =?us-ascii?Q?rV+o8nzYnYVNln+jQtYJZrNUDYi6RZPbde/dVuXaQNoy4j3tbLyNusKVd/LD?=
 =?us-ascii?Q?um6uFyXX4zcP8Y6Ic2AAcZWk+ioayPP5axyQY0GyH/UQUvFZe/3Kj89sDXlT?=
 =?us-ascii?Q?2nmNCUOgcLs7p26bfXmBxw0ZyshYGP+sxx6jnxCjToqIfu4M7uuwoeMxCxlh?=
 =?us-ascii?Q?tTnvbfekQzauMUs6RGLRHFYscE6UTRb7/1HkwUzbM0ygFg8Q/hbpk7M3zdMx?=
 =?us-ascii?Q?+PD3MuF35wMCRUJX0uqvUdkgTsu5v9J+nXztMeMCEJxhTMIKSFm3om9fZZZP?=
 =?us-ascii?Q?XILRU3i+WfdRCSgwN903+erPOuJLrNHWadSLaICqVIvcwR0gk36Uj6iX6mby?=
 =?us-ascii?Q?UYTmpni74j4QQc3fydH+g3RFVsJ4UMutRei9eqqdtb1j8rY1LEsFD2ZeVlEn?=
 =?us-ascii?Q?USP0qbHTBmY3N/65qVp9lqOp57L13AeYKiFR5MHZ4lqNcsQxLnqyt3+Ftf+U?=
 =?us-ascii?Q?ByHP0jMYxaAXjbAPi44DfcRsB4Aq3DA28tWU9ZzcJJ0iP7RbOFPhvSiU839M?=
 =?us-ascii?Q?mKvb+U3haDC257YEINPHDRalZWdlQy8dcXC8+7AjaZb+5Q3U3waBUw6trZvo?=
 =?us-ascii?Q?nhaaSxGYZtlxTh29BqZhxZ/gZje63t1estj5k+nTqQzx/MwBOTuUQDKKsAMi?=
 =?us-ascii?Q?O/pJ+ePbwNBnHFz5vphFu5taHa9JQ2hIlwn7jXSq7uE7qm57zfwPcfesRT6C?=
 =?us-ascii?Q?R+/2yAWMS36HyJ8yOX2JPxhto/twascZ9R7RVpCRZnl2IIFHcoJnMjM7z/jL?=
 =?us-ascii?Q?MTx6cMcBxCrO5/arympFkkKppjz5s0xEVxly8kne1EpjpuLi+voaU0+3rm8t?=
 =?us-ascii?Q?cXiceUxTc6LURM+DcKeg2qTA4tI98+wbvFcT8LL7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432b294a-d45f-4a52-b85f-08db0e546662
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 06:26:26.0219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNrfNTG1UA3gza+N4pINLZ4wqd0GOtHKU3EXlTJnRMQIMvy1RD/VrM+fDXj4prWVCa8+EnI/cIjHpFAVgfdoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5599
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 14, 2023 7:46 AM
>=20
> > > So if a cgroup comes it is just a matter of putting charges in the
> > > right place which is auditable by looking at calls to attach pasid
> > > functions.
> > shouldn't we charge cg during allocation? Or it might be too early for
> > iommufd so we have to wait  until attach?
>=20
> We need to sort this all out. I would expect that iommufd will have an
> allocation API.
>=20

yes.=20

btw presumably iommu_global_pasid_ida should be move to iommu.c
since it will be used beyond sva.
