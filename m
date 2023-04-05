Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C26D71D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbjDEBAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbjDEBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:00:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3739526BA;
        Tue,  4 Apr 2023 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680656423; x=1712192423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LylAaVJE6FkYwZTqZ5SMrL1JJXEaTHxL/2w2a2vrKok=;
  b=jc16+ZBOmmfKdYV798urnBaOAQUKWYDiuxmqyoFcX2/hZ2aB/ripLdmC
   QnFFIic/E+rdFxoCl1Cf6r9OW4x3PCj1XUMcJDFRScQHH7gvn03RozglM
   OJ7YFF6+0+/PN+zgfND+FsIxolJK0C+qo6i8fFwNao7Eqyls6pifpLk21
   C0j0SV6Cf0MlkxuCNROXKaUwxzRAZwCiCDbRC6tN9zF2HvpxYxOCqLhWS
   A0YSS2JmsLvdNYVNfB+GuOQ7aZvYZru+mLJOJGEl2C68WDWl8KpP4nweC
   yauxYvKrHKFGhNGZkWBle+GXfBnldA8HhPeQxuO1yru8ULOfyjxrSi3i5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370163421"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="370163421"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 18:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="636713160"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="636713160"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2023 18:00:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 18:00:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 18:00:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 18:00:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 18:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2FmysyhijlWJs9iOVhCktiGGLh7tGcT8sYNjbNlAhDWecOHpSCviYRUTD6kVIJVjd9nHgmoE1xRCyltm3Rq/2bq3r7OCGzrxsdnBgPZ2+/wT2vDhWbZ1kJ+qHXy5ZABMZMPsbJkFSwUlg2QSqOAhaDGe/qznRzVb9xh/SecWS1mxz6uK0reS2DJXYeQ67UER5IkGOgnexwpmhbr/vA+j26eSkkI/J5xF85IIo7JUrTk+mVstayWUPwzXbuE6pwgnMFI3Nh4i3U0aclzQcsH1YrW8carEFRLAw52ZNoy3jMHBgzJ2WN/884qQK16adqwgApG0D7x7x59D2QycL7X2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LylAaVJE6FkYwZTqZ5SMrL1JJXEaTHxL/2w2a2vrKok=;
 b=TfZDMpxzAHuWZbxD4hgvr9Q3Yjgfi9PPXIj9PEoItSfpRTPkMQVNeU9LzBqAI9JYsaUMMAF3W68WQ2RWpCZX4tcWQZbVqHT9CPfkB7eQLVJGFBJDhwgipvVBRvdXVCXnGADScl5WPRSkgCNyOB70Y9imShAg6eMGQ93gd8Qj45VgdevG6kk3kQ3C8TJVspdiqvifTyLRj1BOe+3O86n/pwI3i52il+C8R1QHi5ag543ibgRObTOIvo3GRW/iAG/MQ6EXaplMfIRRFX3APy7ftKk8NWWq5ubIz+HbzNpHD70Zxp5JoM5tDLkDW9piMsirT5TiRkadqt5XRNDqigHofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by DS0PR11MB6448.namprd11.prod.outlook.com (2603:10b6:8:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 5 Apr
 2023 01:00:18 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8%7]) with mapi id 15.20.6254.028; Wed, 5 Apr 2023
 01:00:18 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "jstultz@google.com" <jstultz@google.com>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>
CC:     "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Topic: [PATCH v6 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Index: AQHZZnHp9tEAk4U30ECvpgmMgzHBWq8b5xWA
Date:   Wed, 5 Apr 2023 01:00:18 +0000
Message-ID: <542ea1a76fda7cc45e8268697caaada4352f7dc2.camel@intel.com>
References: <20230403211831.4010-1-mario.limonciello@amd.com>
         <20230403211831.4010-5-mario.limonciello@amd.com>
In-Reply-To: <20230403211831.4010-5-mario.limonciello@amd.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|DS0PR11MB6448:EE_
x-ms-office365-filtering-correlation-id: 63b0e7b4-ed56-4893-7cf8-08db35711f97
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwYq+EeCefY3eNoaei9Sw+ZYaO1fFDqv6mL0dzqgmHZeNfMZApmQ+bbhmsSVYuMIF9tKuWOERFRRpLSDb07RHxi0EJmv3lAtcn/LeecVZbea6CVnbiTIOMb/Rl8kMESXw/DjxbT3qaiO7Zbtk1gXa6lLXKEpx43BWs8ePwmIHjyrocfQ60UgqEmJrLS59dGRrXeInlH0mAx3nEsmPTK0My7udbR3N1r7nXaoTcViqbwi3sdiq7aALZWnxriP4VxAO6GSPLhW09ZLTxrcsF2jYHXuHLblaCY59prPhn2I1exZ4ymaf0aIVYX5iVJFUp1HfHw2IXA1oI8LuLTvVd5Zgk0ZXXSX3KcNsi+Dit+mZMnDh7eadk/Inqc84HlZHovnF4S6KXJIdZ1lFsPzl1Eyij91zVDHpkilSdl0GQz9QS0NsFidwisbxjJSHznW5bl/d6woA1i5Ycy7xunG9ws37+CTbvnPRpo8d7HIOMcoMoQuaMpsEPPdXPaexL0KLmO6UiRR34CM/tWzca5pLRX/NpNz6a3y9UgHjuL/YizXutFGIG1MO7XL29DD0wAzQNpHCc/nxsTrEeD9Y4R5U0nIgrWWKaSwMc5TmXV7CbJh2GpNcpM3NFVgWyhGHPRg/2YJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(91956017)(7416002)(38070700005)(41300700001)(2906002)(122000001)(6486002)(82960400001)(66476007)(36756003)(86362001)(66556008)(66446008)(2616005)(64756008)(8676002)(6512007)(38100700002)(71200400001)(5660300002)(66946007)(8936002)(83380400001)(76116006)(6506007)(3450700001)(478600001)(4326008)(316002)(186003)(26005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDJObUp1Qmh5SnlxTFV6eVUxaWUybmhiUS9tbHVHQWl5N051b3BPL0ZVS1Z2?=
 =?utf-8?B?VXZzOTMwdG5mY2psUEMwclFVcG1rVXZpU09TK0FZaHNjd0UwejdwUXlORU1G?=
 =?utf-8?B?eEdHTDk5cjh6dS9XODA3SzJ0b2ttcGIyNktEZE01NWcvdVVRUUZscjVsTDNm?=
 =?utf-8?B?M3VWbG80VzFCbFlRc2JRcEJwYStuaENFbE84eUJXTEhUREp4dE1wUXBNZVVY?=
 =?utf-8?B?RFczTnNxeVBhUitjTGZxNlhINkNDaXZpak1jYk5NQmhUZVBCNjRwb1VqRG80?=
 =?utf-8?B?VEFGSkFLc0U5RUs0Q2VnWTBMMmdtWm16T3l0aEI5RGNPeERnaTZLY3JxdThz?=
 =?utf-8?B?cmc3REZ1dXEwV3R2YS9oV25EV0wvVnd3WmF3VXgrRkI3dStreG92NkdxUVA0?=
 =?utf-8?B?QXBVbC8rbklFdHE3eW9oMDY3eEZZRjI1K2kxWEQ4VGhYNGZpSkRqZEZnQVUz?=
 =?utf-8?B?RTFOUGt4WGxKdWlteTNKZEg4M1BuWnZIdEt6Mm1KMnp6azVwUUljK0x4c21w?=
 =?utf-8?B?cEcvWlJVM0dpckRuK3RBSlVRQkVFZzg1RjZodG1WRlZxYXJrSUMzYTZiWmpQ?=
 =?utf-8?B?NFdnRjcxc0xjZlM3enZudlQvZlpUL2NaRnhRQU1uN2RWSUlmVGNhZ0RKUW81?=
 =?utf-8?B?QnNGV0JEQThUWlFiYW5USWlzOG9rU2tNb0k5SjdZMys5U3lWa1Jsd21CeENJ?=
 =?utf-8?B?U1h4RktiN2lvMWhYWU96UkFwTHZQdUZ3cjBRMnkrOXNDWFcrU0pHaDk5cmdR?=
 =?utf-8?B?ajJSL3h1SzlpNVVZSFNpQmxRUmJLckttR25GQlR4VkdsNkFwbWxPaHVsQTh6?=
 =?utf-8?B?cGZpRTVyK2RWYnlmUU52QzBnbDFCZWdkWWFucVM4RzZWUXc4QVdLN21nWEFa?=
 =?utf-8?B?NTZiR1pSMEthdmpGcWgyOUFpakl3ZExKTTJwYzlXM3N6UDR4WTRndEk4L1E4?=
 =?utf-8?B?SkM4b3BxanZQenBVOUZzLytWQkh4UmFBS1lpTnVIL1FyeFNIRjV6Rkd3bXNJ?=
 =?utf-8?B?MEIyUFNlY2FIQThYQjVGOUl3MmNUeU43YjY2Zms3OHkyT25ZTU5RbEZXVi8y?=
 =?utf-8?B?R2ZJQ2twYzZlcFJlZEo0WU53b2FKeUJrNmxrLzZYU2FlUVkwa294UEdEQTlU?=
 =?utf-8?B?KzNqZjNMUEVLQUdNNFp1Wmg3UjdZRnJMaUhyRGVkNWJsNFdIRTIxb3ZVZjVx?=
 =?utf-8?B?RmhxMSthVDhoZDIvNTZqK1BYV2xCQVhXNzEyaFlrWjdpRFhqcVhYRkNMNjZC?=
 =?utf-8?B?OGpOQW9vcll2R3lwR0JIL0t5eHRZcktzaUhaLzU2R2xWZnl0NURIaXQ0cVYz?=
 =?utf-8?B?MWcwVm53OHRlS2E1SEh1VWlWTE9MTm9yTUpXdzZSb1NTL3dOWWRvZkduam9V?=
 =?utf-8?B?dUR3K2doaE5pLzBlNmNtajEzb2dMT05HNU5pbDR6UDZCK09pM2t6cnkzb2dT?=
 =?utf-8?B?eFlhcFZiSWRES21OckR3MllOZGlQZ3B5bXJZMmt4VGZYUXN5b1dOMlpxdHRj?=
 =?utf-8?B?NllvbFRROTRMMWNaSTAvdWVNTHdJUU1JUnhKeE90Q05mNWZFblFvVTVsVVlB?=
 =?utf-8?B?dmdQRS85ZGRINzdmK0U4ZC9CNnI2SFdUZEQwUXRlQnpJcDViZWI0NzFvcnp2?=
 =?utf-8?B?bkE0aWxaWWdiOUI3bmhKMXVUL1VuMEZMSnpHeTZYSkljY2VwTVVwSnpTNHZI?=
 =?utf-8?B?U0FHUUZIZFFvT3hDTnI3aW9kNm9yUzNFNldUT1B1bUhTOVhiemI5TUd2dzZi?=
 =?utf-8?B?ay9RWXphWEdGOWR6SWErRnVKTDFwU1BCU2c0c1lwUy82YnI5R1o5eUZpSjZr?=
 =?utf-8?B?S3BPdWtUZzVqNjlJNVltSytHc0ZHMGxLMGlDWmxiU0VLTERQV08rTHI3NEFW?=
 =?utf-8?B?YTZSTnQ4VlZITzQxYzJQWElFQUkzbExyL21XbXJNelBBVlhYWGpKM1lEbVVE?=
 =?utf-8?B?OGhoOGVJSXpQNldxWjFrdytBZStyRFdkYkVkZ2JiSXovSmVObU1WWUZMbVVn?=
 =?utf-8?B?QVZ4OU0xSXppV1BWS1VMdFE2SFB5Ly9IbXFVclJwYVF1TDkwQW5ZVUpGSUJQ?=
 =?utf-8?B?QXh5dVV4a0ltWUJOTU92UXNtTWtMMjVRNFRRYTN0TmVSZUpVcWtSaWFacG1I?=
 =?utf-8?B?ZGd2eTRnS2YvVU1tR2xlNEJxUkRiZ2Z3TkJrVFRrd29QbVlFMXF1UXk3VXA4?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91A2B3ABE1019E42BF83A6C44B21CE04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b0e7b4-ed56-4893-7cf8-08db35711f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 01:00:18.0398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VA7uKCoEDP1uvlt9y8M1d0aYZzizOVRJXHRcl6yT9B6ceaIu367kgg3b3fRvSBOSe4Qu+bEHJEb3wuhMB5uW3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6448
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA0LTAzIGF0IDE2OjE4IC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90
ZToNCj4gaW50ZWxfcG1jX2NvcmUgZGlzcGxheXMgYSB3YXJuaW5nIHdoZW4gdGhlIG1vZHVsZSBw
YXJhbWV0ZXINCj4gYHdhcm5fb25fczBpeF9mYWlsdXJlc2AgaXMgc2V0IGFuZCBhIHN1c3BlbmQg
ZGlkbid0IGdldCB0byBhIEhXIHNsZWVwDQo+IHN0YXRlLg0KPiANCj4gUmVwb3J0IHRoaXMgdG8g
dGhlIHN0YW5kYXJkIGtlcm5lbCByZXBvcnRpbmcgaW5mcmFzdHJ1Y3R1cmUgc28gdGhhdA0KPiB1
c2Vyc3BhY2Ugc29mdHdhcmUgY2FuIHF1ZXJ5IGFmdGVyIHRoZSBzdXNwZW5kIGN5Y2xlIGlzIGRv
bmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25j
aWVsbG9AYW1kLmNvbT4NCj4gLS0tDQo+IHY1LT52NjoNCj4gwqAqIEhhbmRsZSBvdmVyZmxvdyBj
YXNlDQo+IMKgKiBVc2UgcmVuYW1lZCBzeW1ib2wNCj4gdjQtPnY1Og0KPiDCoCogUmV3b3JkIGNv
bW1pdCBtZXNzYWdlDQo+IC0tLQ0KPiDCoGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9j
b3JlLmMgfCA1ICsrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9jb3JlLmMNCj4g
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9wbWMvY29yZS5jDQo+IGluZGV4IDkyNWM1ZDY3
NmE0My4uMDYyMTc1Njc5MmM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC9wbWMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3BtYy9j
b3JlLmMNCj4gQEAgLTEyMTQsNiArMTIxNCwxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcG1jX2Nv
cmVfaXNfczBpeF9mYWlsZWQoc3RydWN0DQo+IHBtY19kZXYgKnBtY2RldikNCj4gwqDCoMKgwqDC
oMKgwqDCoGlmIChwbWNfY29yZV9kZXZfc3RhdGVfZ2V0KHBtY2RldiwgJnMwaXhfY291bnRlcikp
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNlOw0KPiDCoA0K
PiArwqDCoMKgwqDCoMKgwqBpZiAoczBpeF9jb3VudGVyID49IHBtY2Rldi0+czBpeF9jb3VudGVy
KQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcG1fcmVwb3J0X2h3X3NsZWVwX3Rp
bWUoczBpeF9jb3VudGVyIC0gcG1jZGV2LT5zMGl4X2NvdW50ZXIpOw0KDQpUaGlzIHdvdWxkIGRy
b3AgdmFsaWQgbWVhc3VyZW1lbnRzIHdoZW4gaXQncyBqdXN0IHRoZSBjYXNlIHRoYXQgdGhlIGNv
dW50ZXIgaGFzDQpvdmVyZmxvd2VkIGJ1dCBoYXNuJ3QgeWV0IHdyYXBwZWQgYXJvdW5kIHRvIHRo
ZSBwcmV2aW91cyB2YWx1ZS4NCg0KPiArwqDCoMKgwqDCoMKgwqBlbHNlDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwbV9yZXBvcnRfaHdfc2xlZXBfdGltZShVNjRfTUFYKTsNCg0K
DQpIb3cgYWJvdXQgbm8gaWYvZWxzZSwganVzdDoNCg0KCXJldHVybiAodTMyKShzMGl4X2NvdW50
ZXIgLSBwbWNkZXYtPnMwaXhfY291bnRlcik7DQoNCkRhdmlkDQoNCj4gKw0KPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKHMwaXhfY291bnRlciA9PSBwbWNkZXYtPnMwaXhfY291bnRlcikNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJ1ZTsNCj4gwqANCg0K
