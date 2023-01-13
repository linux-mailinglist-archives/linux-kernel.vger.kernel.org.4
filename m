Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4657866962C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbjAMLvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbjAMLvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:51:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC4D4D716;
        Fri, 13 Jan 2023 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673610371; x=1705146371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+bCaApgb+t9xZX78S8KhKzs7jNUdguuVBwke9DmYlf4=;
  b=m3Qq9P0y3WUxyh6vNwRsE/PywWEyLiI87qGvhp97mlxrpL4ftUbR9LWl
   57Tcb04bIwiv4mJzMgZtQ4I5Hbltapf6DYFG3cNn0fblFrI0a6EnxMK+T
   KLFj5+opuHCSOQtuIbxJAIuc4exdYGV2fc/NcGwEl+M9sao3DesYmYncN
   AMtMg4RNtpldEAOGt3laMd3j3+LvOR2HXMXVgxW2S1vuXZyqcqFhALR12
   W3DYkp8ptB0MIGDs39hskCvpTkmTe2XEb8wjJh+Sov96Vi7lcaCr01fcj
   zEunvifoDttEzBI2nSuxS9HGxm3ylLdysUb024evGx6nfq3n7fGx/4wsL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="311828371"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="311828371"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 03:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="832053495"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="832053495"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2023 03:46:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 03:46:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 03:46:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 03:46:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 03:46:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxlpfyJuJdmPslTgUEK29T594wVvJtkrcBd3UxSbZ9HThb2tbpmYgGkWDlKCv/KKmtoq/hDdtdamxsmkvw6B/Fsylt9GhT6elxPElNFZcuC47BwK/NfGOFZu429kbQuXrQ8ofuzfxnNARX+o3arMwx4j0YZKfMhwt2Awotpdp199tNAGIt+6ecpg3FmAGbgqfWww8eNQ62S3zD1Qj/h9RB953UvJ3MJ+cXs3PKM0OBQt6aCai0E3xZtGYP8u/Wh2WSLJXrCI6yQabq/NmqhzmqVKqQFrLL95Vrfz3OzFKoCnSclj9I4CbKMNN+7c4s6npfiXSybAHSP3jQfeGDkHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bCaApgb+t9xZX78S8KhKzs7jNUdguuVBwke9DmYlf4=;
 b=exGyIWy3FjQopz4V8M/zczVC+f7fVk0Cv6dFnCJQqCdok+Kw80pyHSP+Ec6bmXJB+9U/eJqwt17rRB9KA8/3E3YnuA5RKNxpARvvh/f+yliSGE0Lp3jAYakUq1L9VmstM0oLXhlIFMrpWsrnka2Lv/1n4Ff0Ck8jcq63WdmnGSKZMNp54f4qDCsBcrPh0VhIwxZzG/6dPm7IgDRgCgWRaPk0iYIIAIraGsDiLVBB8aicFMMNBCJC8aqAO5CJ/UxcWpa9BZIvAlBz1BPkujcjM0ZZGt1zOhQbaqtqROi5VG0E8HI9qPw6uZVmv2fbBnGFHm/lSyWczw+U1dGPUkPFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 11:46:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 11:46:05 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Thread-Topic: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Thread-Index: AQHZJQa9JdJI+aJ8s02kRrdU2KA97q6cPyyA
Date:   Fri, 13 Jan 2023 11:46:05 +0000
Message-ID: <12349879d0cfea4828b3ceea4cae0b7b1073181e.camel@intel.com>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB7648:EE_
x-ms-office365-filtering-correlation-id: a4673082-62b5-4281-1ac3-08daf55bc11d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zT1qp5Lem69C4zi8bHD23OiZw3EaRkSWTde56Er1lURvrjKbdIcUES8vIJvQszUKR4RIH4DCpmBPZEFYTqpBDWngcicN1g8UaEZyb20PyH9zhYtL+Xl7BgYhLO2hwD1uOfBLT8ubLg1XYcgnUtjymO1FTtR/HQo9dxk5anJi6phA4Q1SaVaxqlF0a9DAaw0r1Y6bVa1CtGhbJllOfczuDY/rhzhb2C0QMc2BxlslRrekVpWXlb4xKAXL/xtQKIKJDrTCQb6ocKWboPKxZrvMXZaAGdD3QWuM2WSzQXpqlU3O+RyhyhCuLA3BpGWqJbu+ybYKQ6UNEGkvlksHUR9m4UQblCKRvTNIA7Qe6JF3+s074ywfGNiA3RrtRE0aQbfZgH8kMvolhLJTnNJcDLZY0zMw8nD2DTNCWXFOP57+mKgHRkbXgm1CS8ML4IW9fMDCyQUwXfyQG8o+iC9YVqaAF+geb7srF0wcS82K5IsizTcJnJ+769ruPrhgN8TmSGBTYhxmeXsFYkZWiqPUvROymf/N8chyQtuBqAFaNBNHbDyOW8Ntgf7qhpjqmFsxb4J2HYE8g2RzRUgS9kcquRoifdPKTMBmrKFbrGGxRT+dcl3pr+7XoZjrWC7aGWPRc6tkJxrFT3diENGCVrss7EPX5V5izwDbwRgSVHEWy5ohauBCUXtlvXbLTVyLN7KTKVm0qz1D2kEXLVhjXb/CYqrI0FFW0w9FjRGifqvTWzeLHUs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(6506007)(36756003)(6512007)(26005)(6486002)(82960400001)(478600001)(71200400001)(38100700002)(122000001)(186003)(86362001)(38070700005)(83380400001)(2616005)(8936002)(5660300002)(91956017)(2906002)(66946007)(316002)(76116006)(4326008)(66556008)(66446008)(8676002)(66476007)(64756008)(110136005)(41300700001)(54906003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGl0KzNFNmo4U2dVQ1Nvd05WUDY2ZEpMbm9tZXNwck9IaWhDZGZ0aVdNUVFS?=
 =?utf-8?B?QWRCeXFKTDZBejFRRHV4SDhkOGdvMnB1aFhRaEUxTlZvV1MwaE0ybUhIV0Rs?=
 =?utf-8?B?YlZoaUs0SVU1TFBuc2pPTUVTNGhZRk5XaWlMOVlWbjV4aUx2cnVTZUt5M2h6?=
 =?utf-8?B?UlBRcmd4VGFNTmdoRmp2cUlCNk1PejAyRlE0UkVVQStlWmxETjdCeFdPTDcx?=
 =?utf-8?B?SjNKOHliNjdpQko1TXVGRzBNWGU0b0FkUVdCU2lqdmhpeS9IS3ZMcmE2UEVa?=
 =?utf-8?B?MDJxMHlKa2FZNndxdVUzZWFLNVdlMC9GVUtkbE9RZGxBRS9NcGRmRHRqMmt5?=
 =?utf-8?B?U3U2RVJPMHk0NWIxQ3gxOUhQZWFSZ0phL1E5VXRQU1dIQmlYNjNacmJHQVY5?=
 =?utf-8?B?TFI1VGZwKzNqY3p2MVJFRFdHNlViZkh6NTc4Y3hrL3h2T2cyblVFaDRMRWF0?=
 =?utf-8?B?UjY2TXNtSzc4cUUwbHFQMjVjNjlwVlZhZUY1cnlZRURwcUljY29OZ0F1cUhj?=
 =?utf-8?B?REx2YTQ3b3hUaFd6Rk0wZWExZ05RaDduWW5OMWlVa3pPUWdTUmNtUTZLZm1l?=
 =?utf-8?B?NWVTL3F3ZmVhWGZ4b2p0c21hZmVVWmovcEh1TEErbHdDY2hTZHowYzVtcDJF?=
 =?utf-8?B?OXR3Y3d3QmlvQ0pQajgzY2I3MG8yTm5HSGtRc0h1aWJ0bHl2Vk9pR1k5Smx6?=
 =?utf-8?B?QlZFc1ZsVnpNTkZUTy9yMGM3YWtTQ01uUkVVY3l2Q2k3ZWdpaG41bzRmMnFH?=
 =?utf-8?B?ZGRDKy9zc05uU1RsZW5mWkVEWmVYcGtpdVBsRWZnUEhDUmNEWWI1M1VtSUI3?=
 =?utf-8?B?OUJjQ3lEVWo5VE5JMjA3Q080QmJIaU5YZ2JyZkFLMHA3T0d3Wi81VFo3dFZQ?=
 =?utf-8?B?V1k5bVBOR21iNFlxRTNXT3YvQTFKQXN3R1pEb3FJbDRpQ2VGVFlUMHZDQTNV?=
 =?utf-8?B?SnZ4dXhrYWxaMjdZL2oxNjVVQVNDQkZkQy8zbWtWdW9YUW1COGZXSGN3d3JK?=
 =?utf-8?B?R2d3VGRPMDJSUmw4ekExNkxGRFRjRng1VE5iU29jQnkrOFVIckJuSUJJSmNl?=
 =?utf-8?B?TlM4YlFhcE10aEE4Nk9FTWxDSEdPYXJ6b1RtQ3hYc3FoeThqVG9sNkljdW93?=
 =?utf-8?B?NVNlNGs2WHhzZ2lzNHNUWHBJK3VBYm9qajNGK0ZMckhvbndkQm5GNkE5Y3F0?=
 =?utf-8?B?VHFHQmJQd2NkTzdTYzh5cExKU0kzaTl6WjNTelFXeFZsdmpzL3d0RDlETFJi?=
 =?utf-8?B?S084bkJKd0ttYmpnWlVSdFRmY0Q0djAybnV5dmwvaW55dERlWHdndUZnZTg2?=
 =?utf-8?B?TkFJYmtGcTdFUkppNUovaDJHOWRxSFF4dXdyNkY2SmRMdFhLZ040NHg0RVZJ?=
 =?utf-8?B?RzVJQkNFc1l5cTdwdUZBZklUTHA5RklwbGhjZndpSFBjRms2QUhQVm13YnNz?=
 =?utf-8?B?QWZ4QlhsZVV0MkhRVWhuWmdnT3dUTlFId0JDYWJHVHozcXhhc3J0U215TzZk?=
 =?utf-8?B?WUpWUXh2dU9WdFVQYVlmdmJjam05YmE3SkNJMGxpdE9ZaHJ0VWFaelhPTHly?=
 =?utf-8?B?cWZhTjQ3TXBGb2ZnOHFwTCs3RXA3VDNBZTdHSCtsM2xYUVVGeGlHSHVDaU9j?=
 =?utf-8?B?TGxyWmhyWVh2UE1jOXNpQm11UktPTUptTU9QR2hKNUUvMHo4ckVzTkRDWHAr?=
 =?utf-8?B?c0RGWWV5SFZ1SmpJcEl3VWhtemlDRXdxSFBjSE5kcHJBTGpKaG4xSmExaWZr?=
 =?utf-8?B?TUJTVVozczdwY0xJVkNGWjJ4UnRtbUtkL0J1UWx4cEVIRURBNUFPQTduUk95?=
 =?utf-8?B?T2VTOUpDdFlVdm1waUpEMEEyNmFuRTlWVFVteDFNc0tOc1l5TEk0Skl5Qk1O?=
 =?utf-8?B?dS9DSWVTVXRmUzhrTHRyRi9KOGNHZUZjYjZJMDZ5cHVsZ29qZUVVVlNUYm9j?=
 =?utf-8?B?REFuMGFUTjJKQmNhOTNMTVNvRE45MEVSRC9TVUZYR243OTJwZU1obGx2WEhS?=
 =?utf-8?B?UmJ1Vk1OUW5LZkFxOHFtZUZidFZVMkZvYklrc3loSzJ6ZW1mRTlLVWJSdDd5?=
 =?utf-8?B?U1hvbFVmT3hVWXRjVlNSdU1XTWFkejJhcG1FNUwyVk52SHNQN2ZnTk5jMmxo?=
 =?utf-8?Q?nvoGvJpBkZUg2lC1HNPzpBzxH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <753DBFE9EEDAD941B9B4ACC55DFF5E42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4673082-62b5-4281-1ac3-08daf55bc11d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 11:46:05.6616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akcSdkRQ6h+rIqgDXA3TiZVpqI0hYGn36VclsSt5N4Anynw0KpKmpHM+/5MGl1HT924sHBym5vvG+JCsAD/qEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7648
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

SGksIERhbmllbCwNCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2ggc2VyaWVzLg0KDQpJIGdvdCBzZXZl
cmFsICJ0cmFpbGluZyB3aGl0ZXNwYWNlIiB3YXJuaW5ncyB3aGVuIGFwcGx5aW5nIHRoZSBwYXRj
aGVzLA0KYW5kIHRoZXJlIGFyZSBhbHNvIHNvbWUgb3RoZXIgY2hlY2twYXRjaC5wbCB3YXJuaW5n
cy4NCg0KQmVzaWRlcyB0aGF0LCBJIG9ubHkgaGF2ZSBvbmUgY29tbWVudCBhYm91dCBwYXRjaCAz
LzMsIGFuZCBJIGhhdmUNCnJlcGxpZWQgdG8gdGhhdCB0aHJlYWQuDQoNCnRoYW5rcywNCnJ1aQ0K
DQpPbiBUdWUsIDIwMjMtMDEtMTAgYXQgMTY6MTcgKzAxMDAsIERhbmllbCBMZXpjYW5vIHdyb3Rl
Og0KPiBSZWNlbnRseSBzZW50IGFzIGEgUkZDLCB0aGUgdGhlcm1hbCBBQ1BJIGZvciBnZW5lcmlj
IHRyaXAgcG9pbnRzIGlzIGENCj4gc2V0IG9mDQo+IGZ1bmN0aW9ucyB0byBmaWxsIHRoZSBnZW5l
cmljIHRyaXAgcG9pbnRzIHN0cnVjdHVyZSB3aGljaCB3aWxsIGJlY29tZQ0KPiB0aGUNCj4gc3Rh
bmRhcmQgc3RydWN0dXJlIGZvciB0aGUgdGhlcm1hbCBmcmFtZXdvcmsgYW5kIGl0cyB1c2Vycy4N
Cj4gDQo+IERpZmZlcmVudCBJbnRlbCBkcml2ZXJzIGFuZCB0aGUgQUNQSSB0aGVybWFsIGRyaXZl
ciBhcmUgdXNpbmcgdGhlDQo+IEFDUEkgdGFibGVzIHRvDQo+IGdldCB0aGUgdGhlcm1hbCB6b25l
IGluZm9ybWF0aW9uLiBBcyB0aG9zZSBhcmUgZ2V0dGluZyB0aGUgc2FtZQ0KPiBpbmZvcm1hdGlv
biwNCj4gcHJvdmlkaW5nIHRoaXMgc2V0IG9mIEFDUEkgZnVuY3Rpb24gd2l0aCB0aGUgZ2VuZXJp
YyB0cmlwIHBvaW50cyB3aWxsDQo+IGNvbnNvbGlkYXRlIHRoZSBjb2RlLg0KPiANCj4gQWxzbywg
dGhlIEludGVsIFBDSCBhbmQgdGhlIEludGVsIDM0eHggZHJpdmVycyBhcmUgY29udmVydGVkIHRv
IHVzZQ0KPiB0aGUgZ2VuZXJpYw0KPiB0cmlwIHBvaW50cyByZWx5aW5nIG9uIHRoZSBBQ1BJIGdl
bmVyaWMgdHJpcCBwb2ludCBwYXJzaW5nIGZ1bmN0aW9ucy4NCj4gDQo+IFRoZXNlIGNoYW5nZXMg
aGF2ZSBiZWVuIHRlc3RlZCBvbiBhIFRoaW5rcGFkIExlbm92byB4MjgwIHdpdGggdGhlIFBDSA0K
PiBhbmQNCj4gSU5UMzR4eCBkcml2ZXJzLiBObyByZWdyZXNzaW9uIGhhdmUgYmVlbiBvYnNlcnZl
ZCwgdGhlIHRyaXAgcG9pbnRzDQo+IHJlbWFpbiB0aGUNCj4gc2FtZSBmb3Igd2hhdCBpcyBkZXNj
cmliZWQgb24gdGhpcyBzeXN0ZW0uDQo+IA0KPiBDaGFuZ2Vsb2c6DQo+ICAtIFY0Og0KPiAgICAt
IEZpeGVkIEtjb25maWcgb3B0aW9uIGRlcGVuZGVuY3ksIHNlbGVjdCBUSEVSTUFMX0FDUEkgaWYg
QUNQSSBpcw0KPiBzZXQNCj4gICAgICBvbmx5IGZvciB0aGUgUENIIGRyaXZlcg0KPiANCj4gIC0g
VjM6DQo+ICAgIC0gVG9vayBpbnRvIGFjY291bnQgUmFmYWVsJ3MgY29tbWVudHMNCj4gICAgLSBV
c2VkIGEgc2lsZW5jZSBvcHRpb24gVEhFUk1BTF9BQ1BJIGluIG9yZGVyIHRvIHN0YXkgY29uc2lz
dGVudA0KPiAgICAgIHdpdGggVEhFUk1BTF9PRi4gSXQgaXMgdXAgdG8gdGhlIEFQSSB1c2VyIHRv
IHNlbGVjdCB0aGUgb3B0aW9uLg0KPiANCj4gIC0gVjI6DQo+ICAgIC0gRml4IHRoZSB0aGVybWFs
IEFDUEkgcGF0Y2ggd2hlcmUgdGhlIHRoZXJtYWxfYWNwaS5jIHdhcyBub3QNCj4gaW5jbHVkZWQg
aW4NCj4gICAgICB0aGUgc2VyaWVzDQo+ICAgIC0gUHJvdmlkZSBhIGNvdXBsZSBvZiB1c2VycyBv
ZiB0aGlzIEFQSSB3aGljaCBjb3VsZCBoYXZlIGJlZW4NCj4gdGVzdGVkIG9uIGENCj4gICAgICBy
ZWFsIHN5c3RlbQ0KPiANCj4gRGFuaWVsIExlemNhbm8gKDMpOg0KPiAgIHRoZXJtYWwvYWNwaTog
QWRkIEFDUEkgdHJpcCBwb2ludCByb3V0aW5lcw0KPiAgIHRoZXJtYWwvZHJpdmVycy9pbnRlbDog
VXNlIGdlbmVyaWMgdHJpcCBwb2ludHMgZm9yIGludGVsX3BjaA0KPiAgIHRoZXJtYWwvZHJpdmVy
cy9pbnRlbDogVXNlIGdlbmVyaWMgdHJpcCBwb2ludHMgaW50MzQweA0KPiANCj4gIGRyaXZlcnMv
dGhlcm1hbC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArDQo+ICBkcml2ZXJz
L3RoZXJtYWwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgZHJpdmVy
cy90aGVybWFsL2ludGVsL0tjb25maWcgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZl
cnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvS2NvbmZpZyB8ICAgMSArDQo+ICAuLi4v
aW50MzQweF90aGVybWFsL2ludDM0MHhfdGhlcm1hbF96b25lLmMgICAgfCAxNzcgKysrKy0tLS0t
LS0tLS0tDQo+ICAuLi4vaW50MzQweF90aGVybWFsL2ludDM0MHhfdGhlcm1hbF96b25lLmggICAg
fCAgMTAgKy0NCj4gIGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wY2hfdGhlcm1hbC5jICAg
ICB8ICA4OCArKy0tLS0tLQ0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfYWNwaS5jICAgICAg
ICAgICAgICAgIHwgMjExDQo+ICsrKysrKysrKysrKysrKysrKw0KPiAgaW5jbHVkZS9saW51eC90
aGVybWFsLmggICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICsNCj4gIDkgZmlsZXMgY2hhbmdl
ZCwgMjg3IGluc2VydGlvbnMoKyksIDIxNCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9hY3BpLmMNCj4gDQo=
