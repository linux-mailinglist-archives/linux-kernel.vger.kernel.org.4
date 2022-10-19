Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A750B604E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJSREY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiJSREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:04:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26118DD65
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666199038; x=1697735038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/QMaKbn6tAV6dcnBjdh+yYcDdicVoPb6SMCSR1mcAEg=;
  b=hX9e65feyc40avXHSOzXAvg0P6Bdbmn6mpksvGt6Q1ybBR2LCRUvhvfw
   oWzAMZmhgmoeqSVCFd+GR5GWgggHqKLuvnxuRS1MGbD0C6HZHRaDF27CZ
   Ma5LAxGjTAXLf9EfNlPRJkj4Y+E4GbwzqmwconOxqleTnzad4GpMO90qv
   MC0JwLF+3N9s4boej/1QOCqW/QS0WH/0slzxESP12TR9h4FmTg+ygcazw
   LHvHnh0J2ylOtGpEJNuuEjD5cuktiV/sIOpqiydi++71iGKx6IQXBGfZ4
   NbopyM1ogZJNkfPv//IP7Ys7KeGpq1lwW4khPJXKCW3jEPfSlZJ7jVceg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="368525668"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="368525668"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 10:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="958437333"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="958437333"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2022 10:03:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:03:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 10:03:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 10:03:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 10:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJN1ottmzrBhrUOSIAgUKDFqH5fBAgOlsUXoLvBXCs6lu2AtgUQ5f6zn9qQQpR9alTb2LlFOXuqc/beYKpKtiu0B1IdeskIVgiK+pAFT4IxPMsmhOZnrj8wkqJEtQpH912lKP6tDRUS2Zy1gEvHpj0SqSvn33raF6+FiUixe0C96XXpJ7JKLHJmfgglp+AB0Q59oe9ylCsYC9+xbLW7yZ43R1N7lnmF17G3/gglLlCQZpCutelemBmLvYv68KsWVH7jQIwQzpFLrOFpo7lG1yj+Owo6Zj36AVxjgdOQ4bANpC+JyRJrFvi41HGE0+erMyyQSjrYiY88r0ujhynh8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QMaKbn6tAV6dcnBjdh+yYcDdicVoPb6SMCSR1mcAEg=;
 b=dIBip5U5zIx/Kwvusv4K2wP9o0k0GVH8rrhSlLC5diKK4My36zb5/zpVx5qN7y7s6xSEx2SNeDR9s9Bw88OzYRCy4gDixdaNDAq+k917I1mr5R8kvsmzHinpWp6iR8XJ44LaQHG9AwdKBH2ztj1SpcCKgmSJsKcMfxyqffEDN5A5zX0wVY6nUrXntTkReT8+FiwX42+2KQ3i/aY9SSrrgZwRja24FloImkf32FaJ/FlGv3krXrL9V2JkCFcdWFnsnh82ChjasSj6aXk3pxf+L+g3rNgDIYd/X4IMKDjCo1JYF75gwjTRim+3JywZlzVXFaSisdZ0Ix5VGmgvOhqxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by CO1PR11MB4964.namprd11.prod.outlook.com
 (2603:10b6:303:9e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 17:03:11 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.034; Wed, 19 Oct
 2022 17:03:11 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
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
Thread-Index: AQHY460TCMsy70udPE6Kcega6pHikq4VwjKAgAAkZgA=
Date:   Wed, 19 Oct 2022 17:03:11 +0000
Message-ID: <BN6PR1101MB216116E243237CDABFE77B3AA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221019102310.1543-1-xin3.li@intel.com> <87ilkfaona.ffs@tglx>
In-Reply-To: <87ilkfaona.ffs@tglx>
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
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: 437584ee-6688-4724-87a1-08dab1f3cdf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ov3ChpJlIqHQ/uRDrNhDhJBMYC6L6Lm8SAcXzr+CvjaVSO3hrKiIGc7Exi2lpkes5dyH3AWsr87K3VfGMBW6Vhzxi0YQMCcZDA5hCbD3Q6RaTzKrMlnGPGGOAgswv0c0gV8rCIRCajTreNvcSHDr4BnmWEdLl4ckIRlm5g4rq1ovU7OPPvc1tbv6smQHEtiJhFgmDugwgCJn240pOoTOsCbL+0PKSpElMTsn9NcUdfkpFDX41vQlAxAv8x5W9gyp4//cMW/n3gZ5kaPGHTNHqQGm3tuPuhgffR8ZgeT1FjJ5+CYbYc3ugEV93efZS39NJ8MGpJhEKK0uPSm0rQ1V3IpuDs3U/LD2NVqic7n/tOJu9L3UUr0KgB3X6LlGOuzbFE1FGrQN/PdVPeH2nX+WoM4W2VstU3oTRPXPcDn3dvCa7X2bI+NCRkmSYinzCWhDn8NIkr8lhn3H+sqHzFSX/f2EDFD2C3bkdPFLaScMOgXKElAmgAEuP3BoAL2ax7BTs6nwPA35Jfm6V8dAD6r/qX8fVPPuW1ePVSkBIef2H0OEbYY7OVacum3p32f0nU0Nq2QGzJUcN2d+CgLyv0wRJ8JwTo5Hz1VlkdE/em4i2XlSxqmldmvKC3iLV+zhAGCBKy3VZtwhprbLok3shujFQfC+yEaIYuEjX2KTzQP4ZGocnwCIVDC7ECfG9nJ2qGhZdg7cKEwGA5KU0xejgJhZVxCOi+co5mTBUj/WI8PPE9u8wR+Eh6LPj1Zk07OtRxU/ZAV3mOQrOagEYQTbsdsIAseKEmzBHrQWhLVvcXMgJY00dnJhil4Z+AXvlUp0uWVr3qOFb1ueaGjW4WaHvpyB/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(110136005)(4326008)(66476007)(64756008)(66446008)(86362001)(76116006)(66946007)(66556008)(316002)(186003)(33656002)(55016003)(9686003)(83380400001)(2906002)(6506007)(41300700001)(5660300002)(4744005)(7696005)(26005)(52536014)(8936002)(8676002)(478600001)(966005)(38100700002)(122000001)(82960400001)(54906003)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YRA2QHzRYtBQo8W+/iRrKOC0ox97QwzZSYbC4OQ9fGJjaBqHK89HngkkM/fC?=
 =?us-ascii?Q?r+TRSn5Ke0zhsYwLECIp3pEiRMfBgXMyQ6bFtqOtxKpVgDVQPQ8OYdJwAkhB?=
 =?us-ascii?Q?01rYa5ACMyURiOKz8KAg1PKYLxAdvUknew0MadUcGVlZgr6Nq7ZSe89oCABC?=
 =?us-ascii?Q?/wjT95ufEnSPMQONAVR6SXgns7Xb0mXqALcUHjqnUWROtmF927LFkasYSOwt?=
 =?us-ascii?Q?NnoCxFjCVsFV1224AKx52yX69AkWu5ZJBS+0N5sJvbTJwXCUco1a1IaM0OyI?=
 =?us-ascii?Q?cbQpVxXwlzfWmt5y2AaPYpuYIW5EVyydvzULxSLWMP+A3d7vC5oupr3VwQKQ?=
 =?us-ascii?Q?GXFp2v1BMQH1KKmNPbGulRKcAZo6uN4fhBz8cRDisw6wqzS6a3gSi/wBhqhy?=
 =?us-ascii?Q?CWbuGmMmR1fGEQylB9SDx7Cg19U/xLkGDbSkaxY8nUxH0crbYDptYJHq6KQQ?=
 =?us-ascii?Q?RwwRTzuoeqciVANiJpjU4wCmjSRbAzgtHo4kXv80NrAczVA2vQn4xqh6C6Cg?=
 =?us-ascii?Q?dI31cfNTv5eSV+CYIsUCYu/IF4ZPOEYBfVx4GAJdiKF26bUraKQWV40SWXHB?=
 =?us-ascii?Q?cvKmgsNlihfAn2uiTP1gvGQElr4XvMVjTVSmHfFQMwAiZqzAqwqAyfng/JCD?=
 =?us-ascii?Q?W6kOSn7M9AfMBp/hRuMq0Vg/c3Nien/VzdSGBxUCLcod5X43KifwBN/w4FhX?=
 =?us-ascii?Q?KoqFl1jfVrtxIQMfQSfoRCvxHpTlX7mgaDcgI2mYaO4Att4XJbkQIxoaWICQ?=
 =?us-ascii?Q?KBwi1OxmjlKsYv3SUODTainYfWuy4P/gr3qlbbb+onJA7lY3+0gZle0BJIHd?=
 =?us-ascii?Q?d3xrGvH170SMWNIr398+MT+D9RsTfnyDFeaxImQjyJGNGzbuGnl04ujnGMKq?=
 =?us-ascii?Q?OfipYPd9/HabKj3GV9nK8KxIkgRDvgeKY/mj+cstVxgEsw8kOcCGxR2w93Kk?=
 =?us-ascii?Q?8XOhnHNPkTpVDav77ZG1+GoFrWD1UD3Z1nINOio+H5FwblJ3kgf4xHobOvVg?=
 =?us-ascii?Q?3dIduj2/vTPwZrnuhDGO5PNccokqGwFIqtUAddvOwlkwunYPKm34Kdo0FHuU?=
 =?us-ascii?Q?uacZrpXxHvOfjIxz9JYcKQHxA/2Unv6GYnzwtUuMxHuuZdWGTjdfmOHEApTB?=
 =?us-ascii?Q?vfxVlqlnSh9rMpT9Jl6zvRNEifhjHp+GqkvwEj4HgxbnjNdbPNAafkBefW+g?=
 =?us-ascii?Q?OQ+F19gzSMmnVtA5OfwcDzNG0AdIxUIsL3ejGsmBnjFbxUVUXB1qUZfB+miu?=
 =?us-ascii?Q?Aqs3GHa4+fP2hEt9fmYrnnLuxPdZnPbInmNzFPPghs1NirmdEhRar86GwN3E?=
 =?us-ascii?Q?DFSRI4LT1KTl9kFbOT/ozdp6+QUmht3+u3YsMPMf/1ujXRIhob4VPBNJ6K7b?=
 =?us-ascii?Q?fpu93rfQ8bXZySbA/yop9pifzLJuOp9sTpPp97hIs+fr3UF3Q9kAn/qJ6MS3?=
 =?us-ascii?Q?fT6Xv8V830eq94QfytfIyliHIL40MIN0/brAh+i1M5SzQWMFjhrg4ZVc33M2?=
 =?us-ascii?Q?6l0Ac19Dv1TaIEPIDt0xoOz11xEtVZQIRqAi9WSrTLlMeNsQRjC+gqsM0fj8?=
 =?us-ascii?Q?LN3M4t4T97xGCOxwrnU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437584ee-6688-4724-87a1-08dab1f3cdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 17:03:11.6492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mHq5lpTlBjIWbYO1LSPjK3YVaJO56dMRk4DKNsbWGfKMn8Sq8xRd98l0VBsgy8s0d8BLVRy2sLM90Ht4n8XYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 19 2022 at 03:23, Xin Li wrote:
> > LKGS instruction is introduced with Intel FRED (flexible return and
> > event
> > delivery) specification https://cdrdv2.intel.com/v1/dl/getContent/67893=
8.
>=20
> So I have two versions of the same thing in my inbox now. What's the
> difference?

No difference at all.

Sorry for the confusion, but maybe I have an excuse. A few days ago,
I sent an email to the LKML and it seems lost. I got to know it until
Nathan Chancellor replied; and my original message doesn't show up here:
https://lore.kernel.org/all/Y02eZ6A%2Fvlj8+B%2Fc@dev-arch.thelio-3990X/

Last night I sent this patch set to the LKML and waited half an hour,
they still didn't show up, so I did it again, but this time both worked.

I have sent an email to owner-linux-kernel@vger.kernel.org asking for help.

Xin
