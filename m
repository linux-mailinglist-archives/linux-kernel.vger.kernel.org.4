Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65547670CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjAQXOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjAQXNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5353B22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673989099; x=1705525099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hr67FwvGUVxgX180gbdBmP4zdJvJKX7v9o94g3z3Hh0=;
  b=nH13jQUCguXC0ADc/MClndVIPkSkIAXZCOS6ybm+Z9oDM2yylkYvUlGY
   pt3GNIoZkeYuTdVfWy+61M6o3o3X9rl00TpCEUBmpaBXWG5HmDqRPku+g
   aKjhq98lJVGdrHqHfryye59lhdPr7XElRCbLKgBo5DvA2PweOzK9rxbUh
   yvobph8tEvIrYRY09z6fgxXtU+NRFccmQfRcz4NZtQhntoo9gidwuhmV5
   jzq2Wi0566kJsvBl/ibBWTDnSrs4d6D2q6rbJnUNk00CnBiud/pTOg9/J
   Nue906SJUz25s6E8dMEnOVOOuMQ29bfqAEQV8VBXinCWFUp3n/kagiLmV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304499910"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304499910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 12:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="801891833"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="801891833"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2023 12:58:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 12:58:18 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 12:58:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 12:58:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 12:58:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8kVueodSNEm99FGbJMJEHyeJjLKKbwF/IQZaWRCswbfLUObokkePZLCGADvUWHw2iS7VTdIYCXvfhomSgXIufsSoMSLiWMoZ0/RGoJL/LKKKtM2gSLVzVr3dD+mjTCEcnHv+uesOj37qD5nzoCnuWTlKqVoNq0y24wqERaMCX8hCf/JXkHJlacd60s1+Chyc9S4/lzr80e7kHoOMY8uTRnLR4na206FhSdH1BuzofP9mZ8H4feuouHY6ysMEixgcClTHS7K7egjc/dUtVS8Q5oShVSDhJCxydjX59P4FjpleMXWXLKxhsxmtysBPvOBYHsjikHmDJWnj1eZEmRx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr67FwvGUVxgX180gbdBmP4zdJvJKX7v9o94g3z3Hh0=;
 b=Fqt5g8hxzIsHA44qENcFLKHceQQLQ8tiPRYr9dEAlOMmnFuV6ljw7Zh8VfSvfvrRc00g5co3BsMUuiVHYVeXx6Hugq337GI3Izv8dASmVKHKFaACKHtdqHOxgxWUws9vgknRWJqhdLFDkyFoeMxafR9sd6eHzhJLNeVjlUTwoMrQ4CXy+xjGQrGzSfAGk/c8F8KC7D1kZnUFVoaQgHkpeVs5FPaFq4UQ1WUYI690aRPbHHzepY6JOvDFuKcketAOMdJOErAX8Fn7ONNHXS1lqA7Hh3OzSFx5zHs2fZBHjRWI2DnUHuYWEyA5IgTvsScvamO2DX0fIbUAtzlj7e6edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 20:58:14 +0000
Received: from IA1PR11MB6076.namprd11.prod.outlook.com
 ([fe80::7e0e:8bf8:b12d:fcab]) by IA1PR11MB6076.namprd11.prod.outlook.com
 ([fe80::7e0e:8bf8:b12d:fcab%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 20:58:13 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Thread-Topic: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Thread-Index: AQHZJEAjPJqPA6/3BUKKuoCqIYf3wK6f4BgAgAL0VgCAAATOAIAAHzEAgAADRwCAAAImgIAAIYUAgAAD5/A=
Date:   Tue, 17 Jan 2023 20:58:12 +0000
Message-ID: <IA1PR11MB6076660471E9C688E79A2B20FCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com> <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com> <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com> <Y8brnyIltcgtUvPn@zn.tnic>
 <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
In-Reply-To: <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6076:EE_|IA1PR11MB8173:EE_
x-ms-office365-filtering-correlation-id: 110c5543-a511-440f-b494-08daf8cd8c2a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9eFjrErBv7CwBYgtMB14zQ7drgBxd1I2bkQA8M+nWxunqIrw/TkBGnRGN1+8W7NMgw64fsbxf0TMIVq8xJUQDpZTSinJBofSZ6myHlX82hHVRRUfI1SqfWyrPSF1VGJN2oq2AR8la2ZL6qDTBwNxcGowcti2vdRNraCgM4e2KzmZwGCPQQ3htRcsxFyupk8s0nVqli37GojojgnQmz1KB6QT6QCPHaZgmTSQECkmfvL5rS3FQicAXHVzsYnQ4Mpp2TYqxxWnPZClcHAz0B3r66yMzlZAJNNHJ7Z4V1SuUasQN/GrtYwS3b2XMLFNLtFG01Oo09iCTSKsVUcNiTO0xJ5+D8uknELeL5o8VLIRNzSYDy01sRBsWWYsIfIrbUF10SAN0Xr6DS3zw8qDQOs2dapc8tXLf3e8conaeZrrmcNgvcJTW+/bq/UFjBRmuA1K1CFQVAOV4v8sGSJM+8RiRDVPkr6XhsM96O/RmHlS+8aDKDW1djdv27v2Lf/GLqWxmowoi+b8F940aaHH3Sf35XiXtuqIL6rEado7TxNvSIrTes82/pp2Xhf31UX3oI4kMhEw4Y7uY3gPoQ7k67Vh8sG4fgNJEg2m/CTYqCLEKFXkZvzhZxITf29Ae3V97IpxyWKxkSaXLtxBdLr+XMt1LaZFqxfzhspzUyGP61hzCasaphexjWHV3qZX2juWIT+FyamYccbqBfc1MQNvQ5iifI2U658YRv5eZ1E/9GIkMr3ITncs6NSLUN9zM4g1lOuHeD7NItJK/GvRfFVhpZpPKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(38070700005)(86362001)(2906002)(66946007)(64756008)(52536014)(8676002)(8936002)(55016003)(66556008)(66476007)(66446008)(4326008)(4744005)(76116006)(82960400001)(83380400001)(5660300002)(33656002)(122000001)(38100700002)(71200400001)(110136005)(7696005)(316002)(54906003)(966005)(41300700001)(478600001)(9686003)(26005)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+rTXQlImd9Z2oKCOnXaXmMTg36usR2VOzu8K230IX+grVQ9uoXqPwmxiBuzt?=
 =?us-ascii?Q?VDTd9Qq5sn5Ht150iPgHcjaKqwXCUWkQjJL3n4xzN4kr6orwyGIk8M1H73d8?=
 =?us-ascii?Q?NAW1NOmoB0Isp19AvOcaPKjp6/jnceo5EL8KzjXC4TzFMYQb5oqPU4sKovCc?=
 =?us-ascii?Q?7aF6ahOOCUQl7GqpCcJe4K9W3QVA4bHbnr/oCazJESrm7xNPE0W/VcjAD0pY?=
 =?us-ascii?Q?NeU7CeQ1vlB8Lu+sp8K6K8Wk5A29git6TNv6ft4mojxsEx0tbf72Tckv1aV+?=
 =?us-ascii?Q?jYmzN030XWgPtziv3Kzmfki2x5raPIkbpUGwyFEJXrSPQKucoTcDIlhWCBiV?=
 =?us-ascii?Q?o2USKdo87t3OP5u9id468vY3zNGHLm/TUmS7e+GkKr66k+5zCAoMFXMnZOkD?=
 =?us-ascii?Q?eH1TAsX9rgOnesG9Uqze8oYiRJ+0cyiTdsILGUOwu6+1/WTyWIjniCIqv+1h?=
 =?us-ascii?Q?Zsv1gB2NwYdz55GGJJIqri1w2wbCsnx99KwGT8IoaG4eDKxmtokYclg/5kbL?=
 =?us-ascii?Q?F3OQS+VbLMwhH1CQ2iiIfCarPIXsdM/lak49Wa3qRNfpF7te/0DfcD1zXd3Z?=
 =?us-ascii?Q?n8wyKUbd94oSBMNZ63TMAZzS6509TICiol1OXKYziO/98xk3cSHpUPp7OYdJ?=
 =?us-ascii?Q?GBgSRAzHN/DkEz+s2W+qRF2ZX+aDP3qrT6XZjYjDiwS0WcyxODXo0Pv05JH2?=
 =?us-ascii?Q?h+Cs+y/WX8TBHOU/rvWPM64t3SDJx3c4g07jOTNs8fMGQVhrWOeJZ49FInch?=
 =?us-ascii?Q?qm8X1Ym+EEsrWCu7H7zj5fDu3s3x4YTnFkvPh+TVmx/CpDk6yVymvQaKHIhO?=
 =?us-ascii?Q?06Bwv5tN/JW1cX+Baryy9nIgYou9s4o+qA1x1fNqd0gdJaSDjHfJ1rwEqcus?=
 =?us-ascii?Q?yTOSpxSTSpDytK5IStsYtmZO4KeucEHXoF7qZQ8o1PpbM/OGZTAImiuJOcGh?=
 =?us-ascii?Q?DcSq0OKSEw148nk9d32d4ObgIp3NmT5ntn0MgeLElguCGJ0Ld/4xJ8Xr1vsN?=
 =?us-ascii?Q?+D2RhIMRU4iS3y4wNigva5UFJtNzMBFb1xqpOnfTyZWWriq8Gpja6u520MMh?=
 =?us-ascii?Q?AIi7rgWWiMqYooG/5PBg3oqh2TlF96W/vEOsOjdTCSilwvFKpfpVuh4GtINt?=
 =?us-ascii?Q?0hk2O4jaHJG568Ks+GYCa2+cjhoLs6bKZ8Qfx8wvx5jvpEER3hrgOwTTx4dQ?=
 =?us-ascii?Q?XiV4aMEV8FKx0KkKAsWnnLOvU6FN/WdIqSZMb1e7EjkDEq3tC4tsxv+ZF+85?=
 =?us-ascii?Q?PeVWB0deJlmbcmihNLBuc7R28XzvlMEZCpx1fLAMbSk3qJRxWUWyCmxy3R1x?=
 =?us-ascii?Q?WIGbN+QFT/6+BzwpAsWook85Jpc9JIZBQ8ai3ZRa8f5IxmWcGvnRCa2No7Z+?=
 =?us-ascii?Q?7BhYB7ya/q7auyltprLX8Dyo7lEptlkj6GYVSZ6JmLrqSEq479vLIr7ZhlwJ?=
 =?us-ascii?Q?IYZ+i0vS9FCnZWS3Owyd1jtc05y5vPMlROM/5XlFjM2qMKHdyCK3/PPyZYLO?=
 =?us-ascii?Q?vwNgaVTFcrvkoW05Rv58fPM0zBsGiGuKJT6M6ZGd45Of3eC2jAjG1UkuhVbC?=
 =?us-ascii?Q?pZZFixizWyNuZBi0i7gc6IYK1k66+a2R+IYx2Ocd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110c5543-a511-440f-b494-08daf8cd8c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 20:58:12.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00tID4MksaV5aYr0N5bgTi+vvzaWhuf6BIafkfIQeWR+QlkI4ADmshVaS4m/wB4Ky65wxHb6RtuvxyH6FJscPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If there is no microcode, we don't print anything. So what's loaded in th=
e
> CPU is the latest version. When we have something we can always tell if i=
ts
> successful or not.
>
> Its not a microcode file in initrd, but a matching microcode to load. If
> none is found, nothing to worry about.
>
> We just agreed to show both failed and success for late-load. Doing this =
is
> consistent with that isn't it?
>
> https://lore.kernel.org/lkml/Y7iYLbEJSYnVn+dW@zn.tnic/
>
> Ingo's:
> https://lore.kernel.org/lkml/Y7k9DNz%2F%2FvqBAvZK@gmail.com/
>
> Should we treat early loading differently?

Getting a better set of messages from early microcode update would
be a "nice-to-have" feature. But if there is no agreement on what those
messages should look like, perhaps just skip this part for now.

Then Ashok can move on to the real issue of allowing LATE_LOAD for a
microcode that supports the new "minrev" header field.

-Tony
