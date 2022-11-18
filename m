Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A928662EE48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiKRHZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRHZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:25:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0713D0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668756321; x=1700292321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x/fJn5X+D0hvO5jlxCjENfdAWJo+nSbnfgkf4t5Yd4U=;
  b=lcg14tVDjJjtl7AURZZSkUkD8toePZshr9CgpqJtFJC4dcWrovrVIQ4V
   czvyO5aqL5uFbpiCxPhuAdz4pKJuqf24vYLLez6sXzlV8p7yEpl9ZuMgA
   xUJWQDxU1Rup9FMPzCgrHB22TqOIeJNOF9LobtbWai35rPMnzDBIYNZqP
   hv/buLvuEvaxF35kIz6mobTVNhakl788MBt7vvQmFUBFG00K8TUbNtANx
   sgY0DPTrbx3QNoudsYaCXmxnHYd0EfeTMebH2NcAx/OqvSIk2d6hM0EHC
   VX8fbwIiXkQ0RurawSskeab5QbJ7orYK0yFW++DpD3SknvH6TgV+sbu7H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292778075"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="292778075"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:25:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="673111932"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="673111932"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2022 23:25:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 23:25:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 23:25:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 23:25:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 23:25:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG9O7hBxupjwYkC1ahV1lEh9IX1h1KurDex7+lWKItN/9IWI1OoEOpt48ttX+RYRIZZvG0Vs1IDPPJPxMQw2zDysK/ze3K4RJ4P59v3z2Tg++web/CHmb4tHhws6qeuW5lXRf5C2WCZf25R5JXoeCxYaN9ggR5wiMw3G7mfS4JlFXvYF1GJUMmGx6TgTnO+Cbt11B2or9ki0TyM3Q+phcy8nf8C0bhplmn+gXDAXrWXAxNJUrUL5d9IxHW3+CsGVtkg4GQ0V+VVBsxnrSBj3x3Imgu5da4R1fHs0wHIyXNWkYJNd+vaCqMzb7lc/qwJlaTIIqxm4GX/XiAdMg54UMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/fJn5X+D0hvO5jlxCjENfdAWJo+nSbnfgkf4t5Yd4U=;
 b=D7APFDa3jVLL/8mjUqI2GjjNvRR8ANNECY0z5xRzDZV9OwiKLbKtlgFdYrqHRm0blYS3EbHzTEA2+3qChEpnXaG0hwycOjX7Br9oYADnyhfnf8st4Fk+gtFq5pGkNbP7tYb/JqdfzPN5dEKaPYlyTkGWIyeO6VqAU0reWNmtYCpdp9QuO+uuNLv3yNs6K6rDpVmHx6rNCJs3z7SQfvU5H6IjyL9y/hVQ+loNRdE7ApTELovF9n6MXLtL/E0wEZxh3rC8rhsAHwYvFzEnzVgKvSd2ekrqMPdNLid3KpWSAOXGDkFS+oXw2+5yNH1Wzgnu6WFuGDWz+i5+BC49ShUYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DM4PR11MB6238.namprd11.prod.outlook.com
 (2603:10b6:8:a8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 07:25:15 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::40a1:5197:e1df:bb6c]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::40a1:5197:e1df:bb6c%11]) with mapi id 15.20.5813.020; Fri, 18 Nov
 2022 07:25:14 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v4 0/5] x86: Enable LKGS instruction
Thread-Topic: [PATCH v4 0/5] x86: Enable LKGS instruction
Thread-Index: AQHY460TCMsy70udPE6Kcega6pHikq4VwjKAgAAkZgCALo+L0A==
Date:   Fri, 18 Nov 2022 07:25:14 +0000
Message-ID: <BN6PR1101MB216139DE17AE8AABBEF0BCD0A8099@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221019102310.1543-1-xin3.li@intel.com> <87ilkfaona.ffs@tglx>
 <BN6PR1101MB216116E243237CDABFE77B3AA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR1101MB216116E243237CDABFE77B3AA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DM4PR11MB6238:EE_
x-ms-office365-filtering-correlation-id: 6fcd2854-6a6b-4bf2-4026-08dac936091a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXL5EdJ+MzVwmyUOlZs/EmP7v/J+EEjCBGuy4AhGyCyEDgDhfyo9778zGp55JoVvZxmd1k0PYZHDrgY6ZTY4JEnBAudGhMtblngKycGXErVk9ell9C8MY4qdDyJB6Z4MWWg1hwuRVF8gvmu0W86BN12+BRVgbvmOHf/1e+T0p28rI3WL8M+s/+4RsSmHdLIZ0Z//yhIqJjVzBnWQWarMIzwXrATs6rp1xwJjV1NT0hseZv1XYUMdJh+pOANuakoG7rHBC8nLJXwtQwk+HIQmfFtTAb1BMt1vf0id7+vmNGJKO6rniTcY1tcjQATtIOtRXflD9Iyv83JcwLn7V6PKcNzDBJ6uYASDRWvDz0nbn7JXSeuyWRxjdYaTWkh3SzBO8pALaexVR/Nh8/v41EHSHSk+hc3q26iwvVOYXoqoSxrzel2qYX6m0r3P5t2uCzmqRUdV82UteeLt3zXcDZCekoBsq3oFJGaIt21f+e7SzptMFYFo/lDMessZJil1K6xR5jtd972iVHR1YRLYfBCQIKKOFPx1pMmKDKa/TAaZ/W/szI3s/aY4swMw5wPQXIAGp4R6PfkIlwO3Q9ybSqFpP9S5jUvYR4+huuAUh3zAT9QcLpwKTe/QhNSXVY4HJqeUv1JbYMqB+iLFpnl7AZlAZkDGJLOXVB9CZpjxJmZSj4F8EnIhNMKrI0a+0D5+cJ1mhOttw4bZU3u1VTbc99QtyKW0E8u1PyOrBYeoLeSWTUZfWn2EUfYDDkoLMLI3rEv/xFZwagAobDrlWFWwH92APw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(2906002)(83380400001)(41300700001)(33656002)(55016003)(76116006)(86362001)(66476007)(6506007)(186003)(38100700002)(7696005)(110136005)(54906003)(38070700005)(26005)(82960400001)(122000001)(8936002)(52536014)(5660300002)(8676002)(64756008)(4326008)(66556008)(66946007)(66446008)(4744005)(966005)(316002)(9686003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T2FeKb6jvdAUVmZBCHRS4fuHcWt9iGio/y2wHCrd51SVmrecPg7wPawXqvjO?=
 =?us-ascii?Q?uK3T0/GK6AEMRVDkZexOD4Xaj5DP2hbq9cpo20tJNRbDTQO7lmcBEBTxrnT8?=
 =?us-ascii?Q?87F7jhU/nbQ8Po6GShtGfQjrS8mb6B7U+oX74jRx/Plxk3dqOVRHqvfdBn62?=
 =?us-ascii?Q?zt6dgNFSmvEEYm1zDGbVHHus41vvarEsilaSYnWUGOqo+27ZcRxt073RgC/4?=
 =?us-ascii?Q?oTpaO7IBtKT4zu1CSW2OHwgxONAaZyiXpou4aVjrj3DH615oVmLIzeiLvRPM?=
 =?us-ascii?Q?PNAS3W0TtklpBbeH1u+TqdPLfEvwZTDcX3tqXhpmD3YltWpg1B5Gd+3w+RlB?=
 =?us-ascii?Q?79aexn0OULcl2qI05VIe95a1GYqVcoXNrJVIYCqI4L65u2TMjKVDBPlJOCtq?=
 =?us-ascii?Q?xWg5XTleTvjnG+6HSnuiupPzJM9YwpiuhYwPXCXlotExBpxseEajPxmG1dnb?=
 =?us-ascii?Q?fjuC3BdHe9FLBZj23gpNi7aCCY+9N1vFfZCluE0WLzNUB5ClI+7tDlv9wlJZ?=
 =?us-ascii?Q?0xa4AF6b6gb3gL5wHsg72xVs6S9RRnaIjN/5vJ2Ib4HOdPH7gdX4P2JI4BYi?=
 =?us-ascii?Q?Ac8jCQXn26s1LI/9UqHUkcinLHKMfd4Bzc7ai8caXojpsU3OMSEH0y7GC/Eb?=
 =?us-ascii?Q?0q4fiEm02cv/2QPQ7gKfMqe2TshPVnUxEgW0sTHex1W4D2yY0phV/IjEe8Oy?=
 =?us-ascii?Q?vFqTqDTqQ7+8eusqJESEupl9yiF4GwlbbWt5gCNsQB5fi4ehMSSzgLtn9LSN?=
 =?us-ascii?Q?ofL5FN/FaSq9Qz4UIPmh8c8D5M2LonzKoU7N/xOi8WR+1gszlA/mmffzA8XE?=
 =?us-ascii?Q?vFVp5HwfqYXV8O8lcew3SevB97XZSX/WkufvOVbHZ4jPeauuFfQkP/h51NMR?=
 =?us-ascii?Q?o0KQa4X22zHoAWNTqXgEyFe3GpYMW0rwK9f21uuRhJQm9oN5tB7qe2QU8Sps?=
 =?us-ascii?Q?vGPFUaGr3hILETo6uMXJziM0jl9wyMeWboiOv4CUVu2ZkwflE121Cpnul8vI?=
 =?us-ascii?Q?vSz2uQLmTEWAuSzdvEWSobSP1p7OZ/o4SlNF4vG0TqIJPwba5JmI7nJJ2fG4?=
 =?us-ascii?Q?ulGFRZ0tu2lOIZ0/MY1V3AbTWVI71CsVmgdjpqu15ImsrsTvpNrAVJrZcfAu?=
 =?us-ascii?Q?+Ps1n2pfInltKYhtgo4bajBdL4CYBsH/Z/OrDrfLwXyARC/LyTocVimdxzMb?=
 =?us-ascii?Q?WCSqzq2LSBEFfrLcAdJqqh8l3AbC4CcQmPKYtxhf0HGSVPQSl2FmPnQHyoza?=
 =?us-ascii?Q?fxZC5vjywnMpDXdZunw4SVdioDIGplOLxu3304qDSZQipFZ1jxnqSpgWWN5+?=
 =?us-ascii?Q?3Q1QjVIKSszbNZgYk7TcNYKI1j7cAG0m14BreWlyttbqItP6ufRbm2fIAKVU?=
 =?us-ascii?Q?akfWyc2n+l0GWnEzQSmmWYqFNe02kh9v2Q8D+9lfCRyIQGQ/xu9Qn1JB1sfu?=
 =?us-ascii?Q?0lCK9mrreqgl3dxaV9kwKxvT+QDv1p5/rmUPDOgAxmwpJdY9dUECwhe/dQXP?=
 =?us-ascii?Q?3VdKS0zQfhNTqCrPmM1FcsZLHmH+w3d6VjEELJ6WVru2zAh7houuaD9bHMki?=
 =?us-ascii?Q?7DQ13Ts0AR2mE3z610g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcd2854-6a6b-4bf2-4026-08dac936091a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 07:25:14.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7K0MsyAC5iZaKWrKlBbBbR+B34SX2zC0OsmwCNE1+QBHvfSPeNDQDaUJzr0Lk+a+MoUB/vMKnlJD5O7WUknhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, Oct 19 2022 at 03:23, Xin Li wrote:
> > > LKGS instruction is introduced with Intel FRED (flexible return and
> > > event
> > > delivery) specification https://cdrdv2.intel.com/v1/dl/getContent/678=
938.
> >
> > So I have two versions of the same thing in my inbox now. What's the
> > difference?

Hi Thomas,

Should I resend it?

Xin


>=20
> No difference at all.
>=20
> Sorry for the confusion, but maybe I have an excuse. A few days ago, I se=
nt an
> email to the LKML and it seems lost. I got to know it until Nathan Chance=
llor
> replied; and my original message doesn't show up here:
> https://lore.kernel.org/all/Y02eZ6A%2Fvlj8+B%2Fc@dev-arch.thelio-3990X/
>=20
> Last night I sent this patch set to the LKML and waited half an hour, the=
y still
> didn't show up, so I did it again, but this time both worked.
>=20
> I have sent an email to owner-linux-kernel@vger.kernel.org asking for hel=
p.
>=20
> Xin
