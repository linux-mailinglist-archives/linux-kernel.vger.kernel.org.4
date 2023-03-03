Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6886A9246
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCCITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCCITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:19:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B7149BB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677831572; x=1709367572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UtOX23x9zJbkQWMieM2dLujw1wmG5sFME7oel+ihcVM=;
  b=RTaOrGr/rSvXU3tfETXXHnD8slGWMA/LkLLXxNHB5ILO39ZfmwsuKt2E
   vlcAbNPF8yViTrsO+TwvAzqB+aqgBMvpGOypnw41PjsUcNNz9jc2qjRnI
   M1f+d4HoThMi78hExhna9EBwzM314oKiO9U23x2wRICkcmtqQumyu2E9b
   8laB9wlciL2a3wrkIwhJr+CzaOrr3Xa1WqJ6VT9RqybjNSb5QwN//nTdO
   8f80W/ZshnDD1y/KMTh2csbu4xHoRwO9h4NANWCvWTyozeLYwIz0sJ5ET
   mu1rPkWVIUsjTZz7yc2r1R7Oz6Xe/vdUD/JEcAMoR0w73qiIOa90V4uAL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397580033"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="397580033"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="668568912"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="668568912"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2023 00:19:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 00:19:32 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 00:19:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 00:19:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 00:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVCmG+0mVF8lgToIwJK2gOn4hgiG2DEyrvKaw0HR54sU9Komcot8DjvRbQGoX3A+ra6ZBE4WSP8Q1eJYBld6GCEkyBHOj9TdOdEBHp5SFvkNGQeGlXP9+OT1aBZSd5R/j4QF/fatbml90+Agg5wIrLbC24+zTk//a4MtQkD+hYQhND5lkAflFEQw4lredhVXtWjguGuDpBLVE2ieQOQoBpKYOq2KDoCbyiP8nxfX8ZT/EODEC9VgoGtP3Vak/57U8SOH7Jb6WOghwmd2Bpn2yDNczTMxp83LGvDNEPXwOZF5LxXQnkRxw7fuh81mAK07xf01WJUzdjfQ6sSAm+J20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtOX23x9zJbkQWMieM2dLujw1wmG5sFME7oel+ihcVM=;
 b=Qlzr6N/Q5qbE5VSMY2HXtGh+NdgKS1dcsyPe37M5RE8rfiiNiVGWauTYeUmvSfI2+gcZ98J+HDFiRhn22uD29jXhUMQQTWfH68IRQKWUVj+97IUJoo5o8aqb7obTycipOA7Zplictqr22e39TupbC1xnaSar7uURX+/gRPn7uhwa/c4VK++aq5i12B4EkfmdXcuy7mhe/SIQqxw9QgyffekoxlcTRh0wixMpyEcfPP3RNXoZ/vvzYZtiftt/wj5+N33HQUaoA0r/6i6EIH5nz+fPsK+oWGCFaIK4L9wgttmaNlW1xkRzwXKasU4QxVNUNQ51bz+cxCxayboWcfUjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 08:19:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 08:19:29 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Thread-Index: AQHZSx5LcCU69hURF0uHJo/owYzpfa7kSKKAgAEL+ICAAKKKAIAANXuAgAAHqICAAnwhUA==
Date:   Fri, 3 Mar 2023 08:19:29 +0000
Message-ID: <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com> <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
 <Y/+OobufnmGhg/R7@nvidia.com>
In-Reply-To: <Y/+OobufnmGhg/R7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6082:EE_
x-ms-office365-filtering-correlation-id: 92a12fd1-1ed0-441b-b94c-08db1bc002d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLk5cFg+MrndZkKAx9r7cBKP/4XcBl3yGEBHpT7sLyV06HbpB6jkLbGay5nNqPJTDdbms2fpba6vpMElEYXLYlIYgiLnHTxcuDKa5AjtGM8fpmknao2Z2ylCh1kC+PIVi1vvtC4vr6KOxjHwSL3/qdglP614MmDnghOw9TdvhzFE0kdPqO+4AcdXKurGMn30ABSc8ZwqtxudtkTKqFfs6uyCYVhSdnTy0ZPHoLHC4mc9UuE00bqY0x61hhHwE/eZGQRXlLcpPvVDstYCIx4qSDWA0uL2yXT20luHh7iaKX85qt/M7h//TgsQC3Xp2TOnJnjEl5eNpOIkA6XCNLKxNC+hZah9iK6NFlUkhRSknrhuYAqWWZlHD8/omG0DJLJkCpSOVDdYDl5P3fE0zy3qGPjE/Fnl/5+yMoG15o/IeF8hEvAPlFEUY6yPydUuVPErQRLNudBG2I1Zljrnd9Ie0d5oROijUeLVgw07KzIio02OW6hnWykbzLLWHzPz2SoA0gQ+h1UoXrbzaC/Z9c8fXv/jHVWJoq/N6jNTnL47xQsddiyabQJyKKxjHhg9nFAFNi/X3z46X7Stc+NCOIanLXVOrbc4HS3V4iT+ENdhCOyQiYm1sRmGR7mgwxxq1Lq1XlEtTPD56chwX7iJAxT29KenDEGK8UFtmPMYgRO2X0NysWPLsYdaLyVXi1swGZQuiuK4GkdsNIbEoduBNuzMVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(33656002)(122000001)(6506007)(64756008)(9686003)(186003)(66946007)(4326008)(110136005)(54906003)(316002)(41300700001)(7696005)(66446008)(66476007)(2906002)(76116006)(8676002)(82960400001)(52536014)(478600001)(5660300002)(38100700002)(8936002)(86362001)(38070700005)(71200400001)(55016003)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEV4ZVRFdTlWTWptYnZmejJPOTlRK2VGaTNEbW5uNmFwc2dxeEFkdVFpN0ww?=
 =?utf-8?B?UmRCZHd0RUdqSlUrM244SG8wMVdONzNPMjNPWGhBaWxUcHpMcTRheGt2ODJy?=
 =?utf-8?B?UkFRZnphSDB6V0xLT2w1ZFh3YmdnUERHTytFTmhBaWhtRDBONmFWNEhJQmto?=
 =?utf-8?B?S0VJdXpGdmprdHZYQUtGSVpyVFVJUjFqdGhmY0syWXlaV3Z0bTE3WjJXbjRP?=
 =?utf-8?B?T25MWis3cEpBb1ZmZ0tIRlpQcm1VUThrbkNEYnluWG1HSllQbFZJVERkVFAz?=
 =?utf-8?B?VzBHSkxid1Z6S3ArdXB4U25RejY4eGhNd21iOEd1RFVJYzMzaGUxSkFXbXRX?=
 =?utf-8?B?RXRzL2h1WHFXb0NYYUd4OERkRVhWZktoY3hRRUZTNGpBNXN2d1lTWW8yY2h3?=
 =?utf-8?B?UnFDbi9ZTWc1b2NTTE1uQVpmNlI3dmxrVlpObW1DMEdneUpGQWtnOGhvME9k?=
 =?utf-8?B?V1h1Y3FoNnVFQ3VLaVlQVVl5UHJyc1gyTEsyZC9SN3RTQ3dJeFpISXQ1b3lz?=
 =?utf-8?B?MUhQNmZrcjdBR0dhSlpNVFp5L3VsT3J5R3N3T3JVQXdmSzBuWjdWcGJxaWpz?=
 =?utf-8?B?TzRnS0NmZHROQzltMUhsT0lHd1VmaGY3UDNRTW5uWkM2T2hMMlFWYjl2c1V2?=
 =?utf-8?B?UVUySTYzWGVtdkhwbGQrMG5iaWl5cytFM0x1YUZuaVBmQVMySm1RYXIxMVBH?=
 =?utf-8?B?eFJudk90NStJK1NPWUxndkgvQjdwZ0JlVHYvUitUVUJ1dmxHcTVCdnRVVWxr?=
 =?utf-8?B?QlpET3M5dnFlUDRia25MbUxGbDZRT3VZQmtiOFhZeWFXQ21MbXYvYlYzaDNG?=
 =?utf-8?B?MmZub2NIQ2F1bFNESXhyNDZFaXRQM0RwT3YrdklFSjJLNEl2dEZLaElCaFRD?=
 =?utf-8?B?eEZKcU5zZER5TXhoZFNxNWg2QlQ3OWZEc0dBQ2xBSzRERU5UTXk2OUVjbWpM?=
 =?utf-8?B?eXVOTzgzczJ6K082em1OT0N3bDYzZURzTVUwczBNUXhvUkUwWlo3T1pVZDNO?=
 =?utf-8?B?eVMzMm1oUWNEZHVEMEtwNnZKUkkvTU9GZVo4dGNBdlp2eElIMzkzbU9JYlJx?=
 =?utf-8?B?RU9VanJxQ2dNd2pnVVhIR21rSXN1cWdxTi9VVjVvUy9yWUE3Y0pCNkMwaEhw?=
 =?utf-8?B?aHJpd0V2bzdveVZkRUpmSG5icHpydXcwbGQrZFhiZGtoemtDeG5MOUtoL1d2?=
 =?utf-8?B?c3FmeXJoRnpwYytnV1VrRkpzcHpBc2YzUGRlR0NTb2ljdTlKQXR1a3hPdzhE?=
 =?utf-8?B?LzdKMXF5VGRGZEo5WkVqSEhrVkpzOHk1V2xqRlBtQ2FTTlpveHpvRmJNdWRE?=
 =?utf-8?B?QUxrR0lTK1doNlBsT0YvTktkMzFGU0RSTGhaakFQUHVacTZVWXJJY0JWdUh0?=
 =?utf-8?B?SktTZ2V2QXUrWTJCYktGVWlTTHowVTEwei9WQ0k5ZGM0bEJ6ZWYxUDROcjkw?=
 =?utf-8?B?TGwvZG5oK2dwUjVGOWcxMXpoa1FMSmZqNGhpc2s1bGJjcW1qT2lDdEluWWVt?=
 =?utf-8?B?NGt0OEJiMFg0WXl2Sml0ZjZnc250WUxuK09jZWRjd1dXajhxeFFMVzB4SDA5?=
 =?utf-8?B?REh2SllTcEd0WGNEZ0kxSlZwUXkrOWRzbmNJUnRuV0c3Um1yQWtpbE9rd2pp?=
 =?utf-8?B?T2dFczhLZGN5aHhMZi9rN3RtWWV1M2JaMVBBRUp2YXJJOFQxaVBBeTZPbHpI?=
 =?utf-8?B?NGxhRXJoenUrVldjaEZFbC9vVG9qLzRTbGM4aENqUmZTSlNtb2ZHWlRqMkkz?=
 =?utf-8?B?eHdWZWJWbXZFR3VwWTdGUWszZjRkSTA0SmlxbnREalZKUU50cVYrNEFDeWpN?=
 =?utf-8?B?QlZ3d2Q4T21kOUtUNTlpVWFkdWprSThzWmxiSC9BeWg5dUtnbzdZdzBjY1Fw?=
 =?utf-8?B?VGpNeTJhdkpyQ3N4WWEwTVlHT2poMVRFeCtuME1temNQREVNM1IxN3g0MzVK?=
 =?utf-8?B?ZjlTc0FUV2JOZEJsK2tuTHZTK0tCU0FFVGFOZE0rY1ltMDlQbk9ZalRQZTds?=
 =?utf-8?B?Nld0bXEweTBNSG9JTjBIVUtPdFdFN3JFbnRMeUwwUUZuZ1ZkM1oyU1o5d3RC?=
 =?utf-8?B?V0l5aG9KcVFNQTI0SVpmcGJiZkM2dHZsd2VRWllMTVlQYzhYc2U5dU9KdnlQ?=
 =?utf-8?Q?h4gE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a12fd1-1ed0-441b-b94c-08db1bc002d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 08:19:29.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDf0tNdRG0MRQK0GSpHB1eXafAKo6ueHK8ldub9PWVp5lroeoWk3uScWmKfP5w2lYdrjNvuOg7++XjnRjy0Unw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgTWFyY2ggMiwgMjAyMyAxOjQzIEFNDQo+IA0KPiBJZiBJbnRlbCBCSU9TJ3MgaGF2ZSBwb3B1
bGF0ZWQgdGhlICJzYXRjdSIgdG8gc2F5IHRoYXQgQVRTIGlzIG5vdA0KPiBzdXBwb3J0ZWQgYnkg
dGhlIEhXIHdoZW4gdGhlIEhXIHN1cHBvcnRzIEFUUyBwZXJmZWN0bHkgZmluZSwgdGhlbiBnZXQN
Cj4gdGhlIEJJT1MgZml4ZWQgb3IgcGF0Y2ggdGhlIEFDUEkgdW50aWwgaXQgaXMgZml4ZWQuIFRo
ZSBCSU9TIHNob3VsZA0KPiBub3QgYmUgc2F5aW5nIHRoYXQgdGhlIEhXIGRvZXMgbm90IHN1cHBv
cnQgQVRTIHdoZW4gaXQgZG9lcywgaXQgaXMgYQ0KPiBzaW1wbGUgQklPUyBidWcuDQo+IA0KDQpU
aGF0IGlzIG5vdCB0aGUgcHVycG9zZSBvZiBTQVRDLg0KDQpUaGUgQVRTIHN1cHBvcnQgaW4gVlQt
ZCBzaWRlIGlzIHJlcG9ydGVkIGluIHR3byBpbnRlcmZhY2VzOg0KDQoxKSAiRGV2aWNlLVRMQiBz
dXBwb3J0IiBpbiBFeHRlbmRlZCBDYXBhYmlsaXR5IFJlZ2lzdGVyOw0KMikgUm9vdCBwb3J0IEFU
UyBjYXBhYmlsaXR5IGluIEFDUEkgQVRTUiBzdHJ1Y3R1cmU7DQoNCkEgZGV2aWNlIGdldHMgQVRT
IGVuYWJsZWQgaWYgMS8yIGFyZSB0cnVlIGFuZCAhcGRldi0+dW50cnVzdGVkLiBTYW1lDQphcyBT
TU1VIGRvZXMuDQoNClRoZSBtYWluIHB1cnBvc2Ugb2YgU0FUQyBpcyB0byBkZXNjcmliZSB3aGlj
aCBBVFMtY2FwYWJsZSBpbnRlZ3JhdGVkDQpkZXZpY2UgbWVldHMgdGhlIHJlcXVpcmVtZW50cyBv
ZiBzZWN1cmVseSB1c2luZyBBVFMgYXMgc3RhdGVkIGluIFZULWQNCnNwZWMgNC40LiBLaW5kIG9m
IGEgd2F5IG9mIGJ1aWxkaW5nIHRydXN0IG9uIHRoZSBkZXZpY2Ugd2hpY2ggaXMgZnVsbHkNCnZh
bGlkYXRlZCB0byBub3QgYWxsb3cgbWlzdXNpbmcgdHJhbnNsYXRlZCB0cmFuc2FjdGlvbiB0byBh
dHRhY2sgbWVtb3J5DQpvdXRzaWRlIG9mIGl0cyBhdHRhY2hlZCBkb21haW4uDQoNClN5c3RlbSBz
b2Z0d2FyZSB3aGljaCBjYXJlcyBhYm91dCBpdCBjb3VsZCB1c2UgdGhlIGluZm9ybWF0aW9uIGlu
DQphIG1vcmUgcmVzdHJpY3RpdmUgQVRTIG1vZGVsIChiZXlvbmQgIXBkZXYtPnVudHJ1c3RlZCku
DQoNCkJ1dCB0aGlzIGlzIG1vb3QgaW4gY3VycmVudCBpbnRlbC1pb21tdSBkcml2ZXIgd2hpY2gg
c3RpbGwgbWFrZXMgZGVjaXNpb24NCmJhc2VkIG9uICFwZGV2LT51bnRydXN0ZWQgYXMgb3RoZXIg
SU9NTVUgZHJpdmVycyBkby4gU0FUQyBpcyB1c2VkDQpraW5kIG9mIGFzIGEgcXVpY2sgcGF0aCB0
byBieXBhc3MgQVRTUiBjaGVjayBnaXZlbiBubyByb290IHBvcnQgZm9yDQppbnRlZ3JhdGVkIGRl
dmljZXMgKHBsdXMgYSBzbWFsbCB0cmljayBvbiBIVyBtYW5hZ2VkIEFUUykuDQoNClNvIEkgYWdy
ZWUgdGhpcyBwYXRjaCBpcyBub3QgcmVxdWlyZWQuIFdlIHNob3VsZCBub3QgaGF2ZSBhIHJlbGF4
IG9wdGlvbg0KdG8gYnlwYXNzIEFUU1IgY2hlY2sgYW55d2F5Lg0KDQpCdXQgQmFvbHUsIHNlZW1z
IHRoZXJlIGlzIGEgc21hbGwgYnVnIG9uIGhhbmRsaW5nIHNhdGN1LT5hdGNfcmVxdWlyZWQuDQpU
aGlzIGluZGljYXRlcyB0aGF0IEFUUyBtdXN0IGJlIGVuYWJsZWQgYXMgYSBmdW5jdGlvbmFsIHJl
cXVpcmVtZW50Lg0KVGhlbiB3ZSBzaG91bGQgaGFuZGxlIHRoZSBmYWlsdXJlIG9mIHBjaV9lbmFi
bGVfYXRzKCkgb24gc3VjaCBkZXZpY2UuDQoNClRoYW5rcw0KS2V2aW4NCg==
