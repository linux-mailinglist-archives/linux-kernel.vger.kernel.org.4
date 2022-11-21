Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1376319A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKUGHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:07:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03513F6C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669010869; x=1700546869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NNOI52BGquKkCSJDJyGM61b3uNwkYHGU1LIZ4fMsAc8=;
  b=dH/Sv/7QdtRhkrNOWp9sqRUA2sQSYYmm/iBcLkJjRht4EMANc8Mh2N0T
   7dS/PVFRaaJYxKKlrUxyaVolLyEY6JQiTwRauS91LeUvwWZ7vnJb3k/bA
   uFaJFM4rLKgbcoL3ZYyjcyfEbf528wV4SIVkL3MhO1RdRc8QHIeArbtR+
   FLAPZxtdjCkzA+BgbSYdbiMyWMtWrJvFj//qjOf/TeY0kDDhh2Zvg9Z8R
   d3EwLt0yX/GTsLpvXY6eWdvt96LTIusMQKe+f1RNBGtG9jhw7b4NRynQ8
   sDoGIqO0/TFSJrG0PHg4RJcIy5dYd1WAi0pml5REk5PBwJf+BYBWFVdH0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="312181956"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="312181956"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 22:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="709684246"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="709684246"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2022 22:07:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 22:07:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 22:07:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 22:07:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 22:07:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nptN4/KB1QhLRn2xcFGqOhySKwhQTBZdbQQnussXqHKMj/6pHDnwGn82hJEX1TCCcMcmjA9HO5mhOpk9UpeNfcyKZ++iILNep+1WP6b5tVENGUjh7bPJnT5RNHWxvEeANoFzFsgTdr6nxpKmHhkCb2zrbsjVLaRS+dmQRLrqRlAjwwRB+sQ2hbPdxt481EFHCjBdNDt+0zOULy43spiz6VpsaJ8CcW+ccZk0R2vp86lS7uDYeAhSUdzlyjxW4EWduBmc99GbAMOfjml1cZNnsNYaYP0fZpNUX9d3XVLyEFhNzKCE5MrAfAaPY9/E36R/EJZpSwg9bvSszBPIkl1o0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNOI52BGquKkCSJDJyGM61b3uNwkYHGU1LIZ4fMsAc8=;
 b=CT1G2CNyMaWTiqn1NbGsUr1DC+tV0gsyRjEzYif8akR5uvShnS/lpPeUsD1aZA5RDH0ENz4E3ymoVn91Un7jsMPEHzIrvQy0GvaR0Pn6wS82hTSmS2MOq8OArv10E2vJf9tYfS1VZ+uhGbN2NTOfpnpKnSkNDAdzRun8PhDt2thHTUYkCbHpuMiQqZRfUTW8dnt6qWsKB1nCEM90oLN7mkIHbWqohD1s4tp3SwkC+A1IYE1T9UGTFUNsV3LFxk2VqTMjf23BlIk7lgSgchv8/kwkdsi57+PT/7LdO0lsLd/1QbOMh24atf8PWMKaFLrPdqNzmD2KN8Rw3nV6bhOiJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM5PR11MB1995.namprd11.prod.outlook.com (2603:10b6:3:10::13) by
 MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 06:07:20 +0000
Received: from DM5PR11MB1995.namprd11.prod.outlook.com
 ([fe80::ad8f:801:996c:3e75]) by DM5PR11MB1995.namprd11.prod.outlook.com
 ([fe80::ad8f:801:996c:3e75%12]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 06:07:19 +0000
From:   "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
CC:     "urong.zhou@intel.com" <urong.zhou@intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Gross, Mark" <mark.gross@intel.com>
Subject: RE: Thunder Bay architecture still relevant?
Thread-Topic: Thunder Bay architecture still relevant?
Thread-Index: AQHY+aj9tfAiJjV16UqlkOnWXN+swq5I4ipA
Date:   Mon, 21 Nov 2022 06:07:19 +0000
Message-ID: <DM5PR11MB19959A3DA30832A07094CE678C0A9@DM5PR11MB1995.namprd11.prod.outlook.com>
References: <CAKXUXMyVFw6cec09+R_sQ5EZLKt+3W3ypucjZCbzYBOyRjC2Yw@mail.gmail.com>
In-Reply-To: <CAKXUXMyVFw6cec09+R_sQ5EZLKt+3W3ypucjZCbzYBOyRjC2Yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB1995:EE_|MW4PR11MB6740:EE_
x-ms-office365-filtering-correlation-id: 7474394e-35e8-41b2-89c3-08dacb86a5f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3jclsGSk8RStVphSG4EoiUJS+F1au8tkn1DbTf22UkiOYUCbrs+kpUVx34E0kTP8zJylAm6WhalBhLwDqPgH0sVD0y9PlfwTMUOzIFdez+VEr0RGFA6IhP1WTXTB3gCYo4S2GvRBXZkYbb9W2zAlGK3wtiqno3S1lAyl8zG/5/P7Ht54XgVa7SVaP+gJ2oef/9UsT0s0OEANhLaYS/YE5W0qddQEE0yP2bq7NLtI388tuC3IjkFi32ECXf5RZP22/hli8s/R+47LN21Cg/bQ5meAmQGMoVwTOl405YmdbXkenrp9kDCuFHta4Yzh/w1wE47dEFtW8X4vRPnQ+BrmJfLJ0zdO4qrZBucWO0j6p9OXNiSIryop71u+wJNmDdCsKJwYLPRC8i2WSlc7wWJeH4MPQGOq/r6QJjS3OgeHHDTloPIlHurOy+51mBQFCE0BazAPVD3IP0yivtZ3TrTlJJyada7NbXgIAUGi0OdWLzDzuxpekfJ+zQAgZxnuD5mRuNDNZ2WURS1zlk4zBZ77Pe9eYzfGY0J3yojcplDO2Ry6LXAb9WItOl2z2DmZoegseJtMMCLPOYWkz3RO54Z1hMga57kSJFCNJau5DiEitCPeDLeAig2PAuDV5jNPfA0Tcx7724dx2DVoU+zPIS2JfRtl13rRYLxXngQqNuZVQKynJkYV0EC68EkDDH6jGV7IPo52frRGE/EVJwXxoQh8Gsz0Xeguc1behJIhKdan74=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(33656002)(53546011)(5660300002)(6506007)(7696005)(316002)(110136005)(54906003)(41300700001)(4326008)(64756008)(8676002)(66446008)(76116006)(66476007)(9686003)(66556008)(26005)(186003)(52536014)(8936002)(38100700002)(122000001)(38070700005)(82960400001)(2906002)(83380400001)(66946007)(86362001)(55016003)(966005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGtoVlFLb3hFQWc1MVZjODZsYTVjRUo1Y0NTRXdsbFZ6dkQ5VTZ5aGg3Lzk3?=
 =?utf-8?B?QjlxV1ppN1AzLzFnT2tEUkpoeTRZbm12M1dNcW5NWjk1QXlrNUMzaXVWeWJZ?=
 =?utf-8?B?UWlIUGt5aDVIWXVPWjBRNjh2REhYQUZ1bHpTdFZLSW9VUy9EMGpiZkZBeGJ0?=
 =?utf-8?B?aFJaU25lNGw2U0RpRzdVWjdDQzVmM3BnRURxMi9XVVNhYS8zQ0JVWklGVGZZ?=
 =?utf-8?B?cVNiWW83VDVqK0dSSXg1cXBwLzh4VTN5djFCV1pibWZBNUE0YzlaZlRHYWZK?=
 =?utf-8?B?VWwwaytTVGZONGk0M3BuNVVObVZmRzZwNnVOTFJVOFhORDBmUU5KZ3dKckNK?=
 =?utf-8?B?VERUVUlEZEJ5TktRNnNxQmIzdnNZbnJ1Si9XS1ZvWkJoV25NSWRuVXJxS0o4?=
 =?utf-8?B?Zk5FOTVYSjM2NGlnZGR2dkZpUVFqbVpJVzdYbTZDYTJUaW9obkFzWkZGWmVS?=
 =?utf-8?B?K3BUMGFocXhsaTF0YTZzSEQzNU1QMEVla2xodzFEdzlOSEZrajN0ZnIzS0d2?=
 =?utf-8?B?ajN1alVJQXU5WVpjcWhSelNTQ2VuTExPZlBQVm0xYThFLzlSU3laMDNXZEtE?=
 =?utf-8?B?NVBOSEZEaUdWbkdtN2dCMU5CSVg0NDBQUFlWOVQ4WHFIY3hJRjVYYnJwM3hO?=
 =?utf-8?B?Vit4L0hmWDliSTBzUVhXQmYxbnlsNkVoU0xHZmY2WFQrM3ZrcTdNeHMxQ0Zw?=
 =?utf-8?B?ZlFXcmZJNzZXNXRxUit5V2NTeGc3V25kN3I0VHlIN0hVRUpOTUJkMnFyb045?=
 =?utf-8?B?R0p6akNHcXVyaCttUXBWS2NRRk1ycy9NNkF6OEwzdHhGNGpQMyt0L1UvTUNr?=
 =?utf-8?B?VXRXZCtqSUU0dXh3Z3pmcUlqMXBvYkQ2UThKRFhyR0h5S3dMbGdRYlVQcUwy?=
 =?utf-8?B?UkJ5dmcwclFyeit5WEFLUVR5Q1AwTHBnc2Jib2RrcXBRbHFqdURGWVRYTFZZ?=
 =?utf-8?B?eGwwcTVubUYrWHNwVmUydnFrbjZTSE9udlJQL2RzckJaTGRGRDNSWXlPdFhL?=
 =?utf-8?B?d3JaVXluK2ZvdGM0N2lRbmFyUjIyUk1DL0VObmFacHA1VHl0L1RiUHBOM1lW?=
 =?utf-8?B?ZGZXTkZoUTRYWUxOMkt5NmMyWlIwWDkrRjNiRlV3QjRwb213K1luOGt6Smcr?=
 =?utf-8?B?WFZ1dGhiNXVDVDNtVG9rK0ZHTDhubmNTUEpTOWtYWHpFVW55M1JpZndWbVc1?=
 =?utf-8?B?YjkwZDhNWmJqWTdRcG5QZW1Jb0QwOWMzTEp0NkVpTktuVTlMb1pnOGdPUEdQ?=
 =?utf-8?B?SlZ2ZG1wTFFva3FnZmtwNzhFQXdEV25DQ3lnQXU3OC9nbVJRUHVSNG9peHZJ?=
 =?utf-8?B?R3lLNkN2VkI4b0tzZXM4dnBFOXp2WFhOdzd3YTlEc0FOYXB2MERvNTM0OVVk?=
 =?utf-8?B?UGhCQ0hONDFEZFgvbFY0OWNVWFVXbkpxSFVGY2E3djRZTXYvWHYvZG9wQ055?=
 =?utf-8?B?NWdzbjJ4VUtMTVR1QVVjSXQ2RU04M1pHYjZaQUlscU4vWDVIYnRsZEl0WUpR?=
 =?utf-8?B?UDZuM1o1azdGM09kTDJxV2NlbWgvNmV6aFM2NjFiZnloQjhocDVwWTRpZVJZ?=
 =?utf-8?B?c1MyZVAvZjFSSG5yelJHUDFPUUppSmthT0xsSU1kSzlEU3U2Z2pxL2V5bk8w?=
 =?utf-8?B?dlBNOHhMK2JwL0EybjdwNlh0SzZoNXY3N0xjcUJoYm1NVzRnbWtzN3RGOGl1?=
 =?utf-8?B?S0plRUY3RjhPazJRNms4MzIwaktMMjFtT1ExNU5Pb2lUSEpEYkZZYVU2R20w?=
 =?utf-8?B?S3pYOHFEbzZ0Z25iQlFNTjMyOU9YdDdySWlUSVJieC84WHdvT2VZSlVxblNO?=
 =?utf-8?B?MzR3TGRhbVhJVklUdXZCREFDYWY2T0RpZGFUQkk1Z2FJSjQrMEpQdTVMWGhF?=
 =?utf-8?B?dHBPcXNWcjlvOCtScldYcmlUdUg2TlFyRjNyWHJTcUdsdHJWMVNxWTcvc0RI?=
 =?utf-8?B?djBlRGJoMjlIa0ZyUlJVZnBSdHcwWER2b3licFMzUGYycXd3b0lkbVRkamQ3?=
 =?utf-8?B?Um0rWEs0RjFNNlJFR1NDVjY3eXpPMVo0RytvbjE2ZVFlVkU2ZlpMbnNScTl4?=
 =?utf-8?B?OE5jdHZwWGtsdnNxd2NSWW9Eelp2WDlOWDROUi9OeldzcHoyRnM1bm1ZSWdk?=
 =?utf-8?B?VVJ6a3labkZvT2orS1ZRQXluZEF4bmMyczJRTjY0RlFDcDFsdWdwVytQdGkr?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7474394e-35e8-41b2-89c3-08dacb86a5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 06:07:19.6684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir7V34/vVM3SBJEDrSU69VAY5YQA+buA8LcYFCI4yJdSiEJnOU1caTq2gbJTYRRUsyd/omJI17XIlC/CTMacfHnROyzFWmnfF+a8BuJ66o3PDZYhc3m2iVEbmMHWB+OD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVrYXMsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBtYWlsLiANCg0KQWZ0ZXIgaGF2aW5nIG91
ciB0ZWFtJ3MgaW50ZXJuYWwgZGlzY3Vzc2lvbiwgdW5mb3J0dW5hdGVseSBpdCBpcyBkZWNpZGVk
IHRoYXQgVGh1bmRlciBCYXkgcHJvamVjdCB3aWxsIGJlIHN1c3BlbmRlZCBmb3IgdGltZSBiZWlu
Zy4gDQoNCldlIHdpbGwgc3VibWl0IHBhdGNoZXMgZm9yIHJldmVydGluZyB0aGUgY2hhbmdlcyBz
cGVjaWZpYyB0byBUaHVuZGVyIEJheSBpbiBhIGNvdXBsZSBvZiB3ZWVrcy4gDQoNClRoYW5rcyBm
b3IgeW91ciBzdXBwb3J0LiANCg0KVGhhbmtzICYgUmVnYXJkcywNCktlbmNoYXBwYSBTLiBELg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTHVrYXMgQnVsd2FobiA8bHVrYXMu
YnVsd2FobkBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxNiwgMjAyMiA0
OjE4IFBNDQpUbzogTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnPjsgRGVtYWtrYW5hdmFyLCBLZW5jaGFwcGEgPGtlbmNoYXBwYS5kZW1ha2thbmF2YXJAaW50
ZWwuY29tPg0KQ2M6IHVyb25nLnpob3VAaW50ZWwuY29tOyBrcmlzLnBhbkBsaW51eC5pbnRlbC5j
b207IFBhbiwgS3JpcyA8a3Jpcy5wYW5AaW50ZWwuY29tPjsgbWdyb3NzQGxpbnV4LmludGVsLmNv
bTsgR3Jvc3MsIE1hcmsgPG1hcmsuZ3Jvc3NAaW50ZWwuY29tPg0KU3ViamVjdDogVGh1bmRlciBC
YXkgYXJjaGl0ZWN0dXJlIHN0aWxsIHJlbGV2YW50Pw0KDQpEZWFyIEtlbmNoYXBwYSBEZW1ha2th
bmF2YXIsDQoNCnlvdSBzdWJtaXR0ZWQgaW5pdGlhbCBzdXBwb3J0IGZvciBhIG5ldyBJbnRlbCBN
b3ZpZGl1cyBTb0MgY29kZS1uYW1lZCBUaHVuZGVyIEJheSwgYWxvbmcgd2l0aCBhIG51bWJlciBv
ZiBkcml2ZXJzIGZvciB0aGF0IGFyY2hpdGVjdHVyZS4NCg0KVGhlIGRyaXZlcnMgYXJlIGluY2x1
ZGVkIGluIHRoZSByZXBvc2l0b3J5LCBidXQgcmVmZXIgdG8gdGhlIEFSQ0hfVEhVTkRFUkJBWSBz
dXBwb3J0IHRvIGV2ZW4gZW5hYmxlIHRoZW0uDQoNClRoZSBsYXN0IHN0YXRlIEkgc2VlIG9uIGFy
Y2hpdGVjdHVyZSBzdXBwb3J0IGlzIHlvdXIgc3VibWlzc2lvbjoNCg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8xNjMxNzcxODk4LTE4NzAyLTEtZ2l0LXNlbmQtZW1h
aWwta2VuY2hhcHBhLmRlbWFra2FuYXZhckBpbnRlbC5jb20vDQoNCkhvd2V2ZXIsIHNpbmNlIHRo
ZW4gdGhlcmUgc2VlbXMgbm9ib2R5IGZ1cnRoZXIgcHVzaGluZyB0byBpbmNsdWRlIHRoaXMgYXJj
aGl0ZWN0dXJlLiBJcyB0aGlzIGFyY2hpdGVjdHVyZSBzdGlsbCByZWxldmFudCBvciBoYXMgaXQg
YmVlbiBhYmFuZG9uZWQ/DQoNCklmIGl0IGlzIGFiYW5kb25lZCwgd2Ugc2hvdWxkIGFsc28gcmVt
b3ZlIHRoZSBkcml2ZXJzIGFnYWluIGFzIGZhciBhcyBJIGNhbiB0ZWxsLg0KDQoNCkJlc3QgcmVn
YXJkcywNCg0KTHVrYXMNCg==
