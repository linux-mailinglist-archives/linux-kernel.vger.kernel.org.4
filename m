Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A695B5E05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiILQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiILQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:18:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE993D589
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662999494; x=1694535494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h/7VUxxK/gr5mHt8uv27JTJ/cs9sk+zmexkvGe7bA40=;
  b=lwfLNonsIBWnifX7QnG9+LiVA+wSqvsYzWSMaZgx5h78GWFK3unfKQaC
   eb9t2qwfmLjUIRMd4ErX9ah9GOEAPSaEGsziWyzGIX15+J4JKVkULd/tg
   6l3TsSYtG9Vwt2ZGGXeh4Chtf227v4U66ZpEVCxWG/3G6hIZrsru8skJX
   3O3Phe65mlLnIP+sAVffX/aQW0K99AgODjIFovzO/HbAawrwLAdq0kgWP
   fqQuxxivW2d1Ikeugf8NWp1czHK+wXddrypDiKj3/UGvs4hDes/uvF5bE
   e3N2o0oXYgNCYgTDrySUOxOLqtw3IXby6MTxT260trpp1JhMRrdxAmAXY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="278299283"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="278299283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 09:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="593554661"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 12 Sep 2022 09:18:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 09:18:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 09:18:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 09:18:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 09:18:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJQhmJDxsaVZyxuzQ7bCw6d9txF0Op4z6Ny3vjoPWm5n29lbfmXP1Gj+Q7JnA+6RI0GWBsm+j4HVaX/1xls8oFA0STu6CrH7Um3Gam6AEKvHyKO0BKoJoGYO9I5ynPyceWOJUL45SQxCOQnuk+69jS//ttZBJM1Gxn973r9SR1RJgYVU3/XJvZBRUR7/eqmEoq7AiwW2tWjDQTfXC8yzuhVf15ndWwHZUuZvL/fxe1+zsSunvQXRJD5aLQJjfdTg2tsdbRpfTXnx/eXCZ+ZaCW5+6j3h168jUubzX1UmxV0FfEoE1DH6XW4CfmTdEr3nIfCNjxRaNoht6eLiz6Dzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/7VUxxK/gr5mHt8uv27JTJ/cs9sk+zmexkvGe7bA40=;
 b=HnPRp0X7nPS++AjnRT1Zqat67VkYo/l/6US91eQ2VcSXS18lij5GrfBXOHnWgR8q3KCWEGxEjAdjQOUfEAVSoKKa19YWFOxJocTT8BCzvqBw92C32Xeps94WPGu1S99DDPkvBtktu5FrUnj/j1yKj8DF7hkJ0n0buS0ekzBuwsXS/U3Rqi/nec7pHZSh0NxyGIqKqn7zhJsZ1rTzOtuJTv1wk2I3txCZWsTBRM8pi6z7Nd0bbE39hGwZ1Oh9uzZQ9cavxOOF1hw8sQQPXuFylyFM0cVuJW2M2hAo4l6gI2KfOCF1MG4JrpH3tPG3lw+1OadoUuiFHVqq3YRo87FAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 16:18:07 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::97a1:8b3d:19fc:782a]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::97a1:8b3d:19fc:782a%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 16:18:07 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: RE: [PATCH] soundwire: bus: conditionally recheck UNATTACHED status
Thread-Topic: [PATCH] soundwire: bus: conditionally recheck UNATTACHED status
Thread-Index: AQHYvENpJk0QjjzpO0iQiU9SFxRzSq3bxT2AgABIVzA=
Date:   Mon, 12 Sep 2022 16:18:07 +0000
Message-ID: <DM6PR11MB4074CFFE2403AA0B15A30BC5FF449@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20220830074224.2924179-1-yung-chuan.liao@linux.intel.com>
 <1395a163-2e0e-2471-3932-0517a7f6797d@linux.intel.com>
In-Reply-To: <1395a163-2e0e-2471-3932-0517a7f6797d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4074:EE_|BL3PR11MB6433:EE_
x-ms-office365-filtering-correlation-id: 9fb57a9d-1cef-4509-0890-08da94da60b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6bC0/1hUjyxfaG7RSV8bJlavbnVGbsBYw+6cO+kuvl0wqhBNsFQMS3HA9y6vDliZvkthf51OzlI+SSn0/RtRbfBBUBlISH6SYoQWz8FhlsJcDWkElW7C+aVx0rezqsjhRZw71PmMstWoiIT2wIkW6+rrBG4DlxShBCF2Fze9Tj8/NhiLxKvYt48K8FGx69fWTvmdHTItSWu2kQ28G6fQ1/AKUVgEd0/ux2TEcQ9gGzBW3i26QU4FmBEYevKeXyx/VvoIlTt6XaCrNEbX7mIzcbRvensC9nx+RnBOwHNkVeRVMGhrNLx1JfkX1lUKsJp5F0K4gMCzJPJE6HlkdpnqWz8j4+Ym245S8iDOVW907MQhXH3gZ2ZvhDXoyMUUCbvd0JFakrT4pl12q9QGfpeZlJe8j7SZ1HKqiqPvLB/zj36J7qULoJbM5Q50LnX5UHZp6IkzI0AJI9ZtzL31UekLWMWviVpmBMd3SatJ14FpuibEPlDqdtqROUH66UcnkUArBEO9RtmRJTl8KDaq8NlmoGutd/5/nUUk6uzsjkzRwJ0L6gQU5Ztr9knrkgG/MyBQ9MUjMrKfIpQMOug9Ug4g8WXaG10bt09A5f8mVYITyOkOGznvuVk0OPtM+u8B942zsNioatNtRhZRhwxKjgYiUpczSl5auUZzaAS4TXuSATurnUcxVOTyjRldcmre87uCUy9WeV6f292WUWt9lzgMiAhVdap6IhGYZ/kcwwp/1YdBUjCVq5TMX8RdTnKTLglHiXdIj6Zmt/kTwrnEGVS56rYaJVvNTAfD49H8Qas+e4ZlNJGNFaBMZFZaI+Cd8iJ/xRtdjlusv3yVmePPXVjCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230017)(376002)(136003)(396003)(39860400002)(366004)(346002)(71200400001)(54906003)(110136005)(6506007)(7696005)(186003)(64756008)(66556008)(66946007)(86362001)(5660300002)(38070700005)(8676002)(66446008)(66476007)(33656002)(55016003)(2906002)(38100700002)(26005)(9686003)(83380400001)(41300700001)(53546011)(52536014)(8936002)(966005)(316002)(478600001)(82960400001)(76116006)(122000001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEJKdlR0dlh5cHZ6NTRxbVhCNWx2QnF6OGZPYzR0dVJVUmJIK2JOR2ZCRGY5?=
 =?utf-8?B?R1B3cXNYV3BNdXhEVmRNcnVJZllXbEZ5ZGE4ckVVeFNEK0FucXZVRXdxM0Iv?=
 =?utf-8?B?aDdsd3NCSk9HUXV2K21Jcitidzdzei83K0s4TzZyc0hjUU80bytibm92MDd3?=
 =?utf-8?B?N3RMR1Y1Z01EdzN1NW5iSHQ1ajIvREtpYW9jNDJibWFhWGw1Q0tCTTlRTEF5?=
 =?utf-8?B?eTVOQjhDRlNsRGlLajg0L1JTbS83aXFqU2liY1JtS3dHZE9xMkt6K1hKbmkz?=
 =?utf-8?B?TExKTTJHOE9EVjMramhiTXpibXJkZlhXV3dvTW02SWozaVlOVTE3U0lhRDlO?=
 =?utf-8?B?VUJzSTQ2YmI5RzRNTEZjVGxGaVNYNUJyeUVUQnZpVkh3Y2M4eG5vVHdRMUY0?=
 =?utf-8?B?d3hQTmd3a2VJM2Q1c29yUEIyUHd6enBFY0xGQU0yS2MrSkJjZGEvb0ZsS1dl?=
 =?utf-8?B?WVh0MXBqMlVESStrR1FoQTlwcXZsTTFtOUNWRE41VERvTEorbURURmcyTXIy?=
 =?utf-8?B?TWdNQVJhemhoQkJTKy9ZSlZPSG5iNUpJdGJtTTJPSzdTU0ZVNER3TWdnNG0z?=
 =?utf-8?B?aWxCU2FPSjBtSmd4K1RUY091Q1BFaVZGWXRFYkNlR0RRN25lR0J5QkpuTkxU?=
 =?utf-8?B?VWh1czBVYmFCbkJkLzBIeFVQQkdKMlZncUZIQ1hweUpTWW5vSFVmUXZLZXZ3?=
 =?utf-8?B?akY0S3Y3L1RVenhCRGlrM2NneVAyUmFjVmVlcmlVbVVJVTB5OVZTNjRIeTlL?=
 =?utf-8?B?Rkc3SFN6WTRoNlh4REF2TXN0WXA1RUdVYkc5VytnU1JZTnpCRjhrME1id3Fy?=
 =?utf-8?B?Y2IvdnhobUsvN08xQ25lSHUrRXNTT1M3YW9XVGo0MXVPSDQ1NFNyLzdwL1VP?=
 =?utf-8?B?NDExbHNoNjVGclEvdDRDUTFGdWVJVmFFREo1RjA0KzM3K2lvbUlTcWh3UzRR?=
 =?utf-8?B?NEw3ZFdnc3hIKy9IR0hKQXVaQW9XTElKeXdja2J2Zjh5NFRyWGp0akZjWlh2?=
 =?utf-8?B?WHBiTjMvamF2WCtONnAzTjFneU5neTZxVnRQMmUzTDU1Mm9xMWtzUmR3dGNK?=
 =?utf-8?B?ZGNLQTAyTXdmUFVGU3N5UEhnRzRuOW91SVJEdUlvWXA2TTE4OTFYdUNkOGRs?=
 =?utf-8?B?azZ1MmFaZUx2bUszY2NySC9TSllCak5kSDl6VUEweFF0eHN4dnhJcFBTQm44?=
 =?utf-8?B?SjdPdlh5T1ViWjdGdXRQbytnUEdVdVd2Y3MyZWZMTGpGTXZRMWZYb0k3YldP?=
 =?utf-8?B?QTRscTdiemw1YlpHN0tTanVJQnlRWlZzMmsvZ2E3bE9pSHNpUnpBUHplOFdN?=
 =?utf-8?B?VnpXNmJ6cjd4cWVKQitKOHhiQzl1WFhFZlZYVWFBcTlRTldTbkUvUEFGc081?=
 =?utf-8?B?TWovTjJLMVo2WXVOSHlqS0t0REVmMVdmUmZHQWhkV1FwdU1VdTlCaWltbXlD?=
 =?utf-8?B?WU9XcjNXY01GUlBoWVdlUTNaQUlwZ0lGVS9UdmNTWGJYK1NPb0hjcWFQRWlO?=
 =?utf-8?B?QVFobEVGZzJ1VFd3ZWNmZUsxNzdwVXVTK3hHZlU4TmVBWEh2QVFXZkdCcEZ2?=
 =?utf-8?B?NkFrY2RHcmxZUldZbmhHK1lFWjNHeXlMbmNMSlZuaHRMaXErMFIzbGZqbmFV?=
 =?utf-8?B?ZlJ5THY3TnNwTmVBL1U4T3lDUG9mUllUNzVPVUVBYnpHOEZsdmhYNXp0K2dK?=
 =?utf-8?B?YWtBMVljOXBObE1LWHNlVDFPMlphRHB4SjgyVVFvRmNOV1lrazNoelBmSmtX?=
 =?utf-8?B?c25EQ1ZITWJKN0xzSXArNEM5UzdoQnB1RVBHQWZWVDBXVDI2N2FwZnZBVThS?=
 =?utf-8?B?TC9wTG5ESERFZGxJSEcyNVRqNVlSWDYvRk9iNXlLQmtBaGFaSkJrZWljWTN0?=
 =?utf-8?B?Ykh4Z2JvQWJwSmN3NjBkaWJQUk9iRGxhSVR2NjdjeE9Gck1ZOTFOdmNOY0Uv?=
 =?utf-8?B?Z0M0K1RxUnM0eWNLd3JUeDNrRVFQUkdjT0lGL2N2dTYweTNxUXk1b0oyalNu?=
 =?utf-8?B?NDlmMDJEaHZjdXdCc1dKbEZZMHFJcm1EN1ZNSjF6N3NPQitOL1BnQkhBeXpq?=
 =?utf-8?B?N0lQd2FxeDF2Qng3UWREN3hKK3U1d2dkVW1yNDU4THNBS2tBb3NlNGsybVp1?=
 =?utf-8?Q?F8j9n9EVHdJRke0JlKIbESfVG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb57a9d-1cef-4509-0890-08da94da60b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 16:18:07.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJUgRMOAsk+9Olzg9Yi6AfmvwluRVrVr/wKIfXVtF7GX+R913LG98UH8puHLkn3TG4t/bqbPi3LuGIq7XeuGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaWVycmUtTG91aXMgQm9zc2Fy
dCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXks
IFNlcHRlbWJlciAxMiwgMjAyMiA0OjU4IEFNDQo+IFRvOiBCYXJkIExpYW8gPHl1bmctY2h1YW4u
bGlhb0BsaW51eC5pbnRlbC5jb20+OyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7DQo+IHZr
b3VsQGtlcm5lbC5vcmc7IGJyb29uaWVAa2VybmVsLm9yZw0KPiBDYzogdmlub2Qua291bEBsaW5h
cm8ub3JnOyBMaWFvLCBCYXJkIDxiYXJkLmxpYW9AaW50ZWwuY29tPjsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFJpY2hhcmQgRml0emdlcmFsZCA8cmZAb3BlbnNvdXJjZS5jaXJy
dXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb3VuZHdpcmU6IGJ1czogY29uZGl0aW9u
YWxseSByZWNoZWNrIFVOQVRUQUNIRUQgc3RhdHVzDQo+IA0KPiBbdG9wIHBvc3RpbmddDQo+IEkg
cmV2ZXJ0ZWQgdGhpcyBwYXRjaCBpbiB0aGUgU09GIHRyZWUgdG8gdXNlIFJpY2hhcmQgRml0emdl
cmFsZCdzDQo+IHNlcmllcywgc2VlDQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vdGhlc29mcHJv
amVjdC9saW51eC9wdWxsLzM4MzYNCj4gDQo+IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCB0aGlzIHBh
dGNoIHVwc3RyZWFtLCBkbyB3ZT8NCg0KQWdyZWUsIGxldCdzIGRvbid0IG1lcmdlIHRoaXMgdXBz
dHJlYW0uDQoNCj4gDQo+IA0KPiBPbiA4LzMwLzIyIDA5OjQyLCBCYXJkIExpYW8gd3JvdGU6DQo+
ID4gRnJvbTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4
LmludGVsLmNvbT4NCj4gPg0KPiA+IEluIGNvbmZpZ3VyYXRpb25zIHdpdGggdHdvIGFtcGxpZmll
cnMgb24gdGhlIHNhbWUgbGluaywgdGhlIEludGVsIENJDQo+ID4gcmVwb3J0cyBvY2Nhc2lvbmFs
IGVudW1lcmF0aW9uL2luaXRpYWxpemF0aW9uIHRpbWVvdXRzIGR1cmluZw0KPiA+IHN1c3BlbmQt
cmVzdW1lIHN0cmVzcyB0ZXN0cywgd2hlcmUgb25lIG9mIHRoZSB0d28gYW1wbGlmaWVycyBiZWNv
bWVzDQo+ID4gVU5BVFRBQ0hFRCBpbW1lZGlhdGVseSBhZnRlciBiZWluZyBlbnVtZXJhdGVkLiBU
aGlzIHByb2JsZW0gd2FzDQo+ID4gcmVwb3J0ZWQgYm90aCB3aXRoIE1heGltIGFuZCBSZWFsdGVr
IGNvZGVjcywgd2hpY2ggcG9pbnRlZCBpbml0aWFsbHkNCj4gPiB0byBhIHByb2JsZW0gd2l0aCBz
dGF0dXMgaGFuZGxpbmcgb24gdGhlIEludGVsIHNpZGUuDQo+ID4NCj4gPiBUaGUgQ2FkZW5jZSBJ
UCBpbnRlZ3JhdGVkIG9uIEludGVsIHBsYXRmb3JtcyB0aHJvd3MgYW4gaW50ZXJydXB0IHdoZW4N
Cj4gPiB0aGUgc3RhdHVzIGNoYW5nZXMsIGFuZCB0aGUgaW5mb3JtYXRpb24gaXMga2VwdCB3aXRo
IHN0aWNreSBiaXRzIHVudGlsDQo+ID4gY2xlYXJlZC4gV2UgaW5pdGlhbGx5IGFkZGVkIG1vcmUg
Y2hlY2tzIHRvIG1ha2Ugc3VyZSB0aGUgZWRnZQ0KPiA+IGRldGVjdGlvbiBkaWQgbm90IG1pc3Mg
YW55IHRyYW5zaXRpb24sIGJ1dCB0aGF0IGRpZCBub3QgaW1wcm92ZSB0aGUNCj4gPiByZXN1bHRz
IHNpZ25pZmljYW50bHkuDQo+ID4NCj4gPiBXaXRoIHRoZSByZWNlbnQgYWRkaXRpb24gb2YgdGhl
IHJlYWRfcGluZ19zdGF0dXMoKSBjYWxsYmFjaywgd2Ugd2VyZQ0KPiA+IGFibGUgdG8gc2hvdyB0
aGF0IHRoZSBzdGF0dXMgaW4gc3RpY2t5IGJpdHMgaXMgc2hvd24gYXMgVU5BVFRBQ0hFRA0KPiA+
IGV2ZW4gdGhvdWdoIHRoZSBQSU5HIGZyYW1lcyBzaG93IHRoZSBwcm9ibGVtYXRpYyBkZXZpY2Ug
YXMNCj4gPiBBVFRBQ0hFRC4gVGhhdCBjb21wbGV0ZWx5IGJyZWFrcyB0aGUgZW50aXJlIGxvZ2lj
IHdoZXJlIHdlIGFzc3VtZWQNCj4gPiB0aGF0IGEgcGVyaXBoZXJhbCB3b3VsZCBhbHdheXMgcmUt
YXR0YWNoIGFzIGRldmljZTAuIFRoZSByZXN1bWUNCj4gPiB0aW1lb3V0cyBtYWtlIHNlbnNlIGlu
IHRoYXQgaW4gdGhvc2UgY2FzZXMsIHRoZQ0KPiA+IGVudW1lcmF0aW9uL2luaXRpYWxpemF0aW9u
IG5ldmVyIGhhcHBlbnMgYSBzZWNvbmQgdGltZS4NCj4gPg0KPiA+IE9uZSBwb3NzaWJsZSBleHBs
YW5hdGlvbiBpcyB0aGF0IHRoaXMgcHJvYmxlbSB0eXBpY2FsbHkgaGFwcGVucyB3aGVuIGENCj4g
PiBidXMgY2xhc2ggaXMgcmVwb3J0ZWQsIHNvIGl0IGNvdWxkIHZlcnkgd2VsbCBiZSB0aGF0IHRo
ZSBkZXRlY3Rpb24gaXMNCj4gPiBmb29sZWQgYnkgYSB0cmFuc2llbnQgZWxlY3RyaWNhbCBpc3N1
ZSBvciBjb25mbGljdCBiZXR3ZWVuIHR3bw0KPiA+IHBlcmlwaGVyYWxzLg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCBjb25kaXRpb25hbGx5IGRvdWJsZS1jaGVja3MgdGhlIHN0YXR1cyByZXBvcnRlZCBp
biB0aGUNCj4gPiBzdGlja3kgYml0cyB3aXRoIHRoZSBhY3R1YWwgUElORyBmcmFtZSBzdGF0dXMu
IElmIHRoZSBwZXJpcGhlcmFsDQo+ID4gcmVwb3J0cyBhcyBhdHRhY2hlZCBpbiBQSU5HIGZyYW1l
cywgdGhlIGVhcmx5IGRldGVjdGlvbiBiYXNlZCBvbg0KPiA+IHN0aWNreSBiaXRzIGlzIGRpc2Nh
cmRlZC4NCj4gPg0KPiA+IE5vdGUgdGhhdCB0aGlzIHBhdGNoIG9ubHkgY29ycmVjdHMgaXNzdWVz
IG9mIGZhbHNlIHBvc2l0aXZlcyBvbiB0aGUNCj4gPiBtYW5hZ2VyIHNpZGUuDQo+ID4NCj4gPiBJ
ZiB0aGUgcGVyaXBoZXJhbCBsb3N0IGFuZCByZWdhaW4gc3luYywgdGhlbiBpdCB3b3VsZCByZXBv
cnQgYXMNCj4gPiBhdHRhY2hlZCBvbiBEZXZpY2UwLiBBIHBlcmlwaGVyYWwgdGhhdCB3b3VsZCBu
b3QgcmVzZXQgaXRzIGRldl9udW0NCj4gPiB3b3VsZCBub3QgYmUgY29tcGxpYW50IHdpdGggdGhl
IE1JUEkgc3BlY2lmaWNhdGlvbi4NCj4gPg0KPiA+IEJ1Z0xpbms6IGh0dHBzOi8vZ2l0aHViLmNv
bS90aGVzb2Zwcm9qZWN0L2xpbnV4L2lzc3Vlcy8zNjM4DQo+ID4gQnVnTGluazogaHR0cHM6Ly9n
aXRodWIuY29tL3RoZXNvZnByb2plY3QvbGludXgvaXNzdWVzLzMzMjUNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJvc3NhcnRAbGludXguaW50
ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSYW5kZXIgV2FuZyA8cmFuZGVyLndhbmdAaW50ZWwu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhcmQgTGlhbyA8eXVuZy1jaHVhbi5saWFvQGxpbnV4
LmludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiBIaSBWaW5vZCwNCj4gPg0KPiA+IFlvdSB3aWxsIG5l
ZWQgdGhlICJBU29DL3NvdW5kd2lyZTogbG9nIGFjdHVhbCBQSU5HIHN0YXR1cyBvbiByZXN1bWUg
aXNzdWVzIg0KPiA+IHNlcmllcyB3aGljaCBpcyBhcHBsaWVkIGF0IEFTb0MgdHJlZSBiZWZvcmUg
YXBwbGluZyB0aGlzIHBhdGNoLg0KPiA+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc291bmR3aXJl
L2J1cy5jICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3NvdW5k
d2lyZS9pbnRlbC5jICAgICB8ICAxICsNCj4gPiAgaW5jbHVkZS9saW51eC9zb3VuZHdpcmUvc2R3
LmggfCAgMyArKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb3VuZHdpcmUvYnVzLmMgYi9kcml2ZXJzL3NvdW5k
d2lyZS9idXMuYw0KPiA+IGluZGV4IDI3NzI5NzNlZWJiMS4uZDBkNDg2ZjA3NjczIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvc291bmR3aXJlL2J1cy5jDQo+ID4gKysrIGIvZHJpdmVycy9zb3Vu
ZHdpcmUvYnVzLmMNCj4gPiBAQCAtMTc2Nyw2ICsxNzY3LDI1IEBAIGludCBzZHdfaGFuZGxlX3Ns
YXZlX3N0YXR1cyhzdHJ1Y3Qgc2R3X2J1cyAqYnVzLA0KPiA+ICAJCSAgICBzbGF2ZS0+c3RhdHVz
ICE9IFNEV19TTEFWRV9VTkFUVEFDSEVEKSB7DQo+ID4gIAkJCWRldl93YXJuKCZzbGF2ZS0+ZGV2
LCAiU2xhdmUgJWQgc3RhdGUgY2hlY2sxOg0KPiBVTkFUVEFDSEVELCBzdGF0dXMgd2FzICVkXG4i
LA0KPiA+ICAJCQkJIGksIHNsYXZlLT5zdGF0dXMpOw0KPiA+ICsNCj4gPiArCQkJaWYgKGJ1cy0+
cmVjaGVja191bmF0dGFjaGVkICYmIGJ1cy0+b3BzLQ0KPiA+cmVhZF9waW5nX3N0YXR1cykgew0K
PiA+ICsJCQkJdTMyIHBpbmdfc3RhdHVzOw0KPiA+ICsNCj4gPiArCQkJCW11dGV4X2xvY2soJmJ1
cy0+bXNnX2xvY2spOw0KPiA+ICsNCj4gPiArCQkJCXBpbmdfc3RhdHVzID0gYnVzLT5vcHMtPnJl
YWRfcGluZ19zdGF0dXMoYnVzKTsNCj4gPiArDQo+ID4gKwkJCQltdXRleF91bmxvY2soJmJ1cy0+
bXNnX2xvY2spOw0KPiA+ICsNCj4gPiArCQkJCXBpbmdfc3RhdHVzID4+PSAoaSAqIDIpOw0KPiA+
ICsJCQkJcGluZ19zdGF0dXMgJj0gMHgzOw0KPiA+ICsNCj4gPiArCQkJCWlmIChwaW5nX3N0YXR1
cyAhPSAwKSB7DQo+ID4gKwkJCQkJZGV2X3dhcm4oJnNsYXZlLT5kZXYsICJTbGF2ZSAlZCBzdGF0
ZQ0KPiBpbiBQSU5HIGZyYW1lIGlzICVkLCBpZ25vcmluZyBlYXJsaWVyIGRldGVjdGlvblxuIiwN
Cj4gPiArCQkJCQkJIGksIHBpbmdfc3RhdHVzKTsNCj4gPiArCQkJCQljb250aW51ZTsNCj4gPiAr
CQkJCX0NCj4gPiArCQkJfQ0KPiA+ICAJCQlzZHdfbW9kaWZ5X3NsYXZlX3N0YXR1cyhzbGF2ZSwN
Cj4gU0RXX1NMQVZFX1VOQVRUQUNIRUQpOw0KPiA+ICAJCX0NCj4gPiAgCX0NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zb3VuZHdpcmUvaW50ZWwuYyBiL2RyaXZlcnMvc291bmR3aXJlL2ludGVs
LmMNCj4gPiBpbmRleCAyNWVjOWMyNzIyMzkuLjBjNmU2NzRkYmY4NSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvdW5kd2lyZS9pbnRlbC5jDQo+ID4gKysrIGIvZHJpdmVycy9zb3VuZHdpcmUv
aW50ZWwuYw0KPiA+IEBAIC0xMzExLDYgKzEzMTEsNyBAQCBzdGF0aWMgaW50IGludGVsX2xpbmtf
cHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UNCj4gKmF1eGRldiwNCj4gPg0KPiA+ICAJYnVz
LT5saW5rX2lkID0gYXV4ZGV2LT5pZDsNCj4gPiAgCWJ1cy0+ZGV2X251bV9pZGFfbWluID0gSU5U
RUxfREVWX05VTV9JREFfTUlOOw0KPiA+ICsJYnVzLT5yZWNoZWNrX3VuYXR0YWNoZWQgPSB0cnVl
Ow0KPiA+DQo+ID4gIAlzZHdfY2Ruc19wcm9iZShjZG5zKTsNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3NvdW5kd2lyZS9zZHcuaCBiL2luY2x1ZGUvbGludXgvc291bmR3aXJl
L3Nkdy5oDQo+ID4gaW5kZXggYTJiMzFkMjVlYTI3Li41MWFjNzE5ODQyNjAgMTAwNjQ0DQo+ID4g
LS0tIGEvaW5jbHVkZS9saW51eC9zb3VuZHdpcmUvc2R3LmgNCj4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L3NvdW5kd2lyZS9zZHcuaA0KPiA+IEBAIC04OTIsNiArODkyLDggQEAgc3RydWN0IHNkd19t
YXN0ZXJfb3BzIHsNCj4gPiAgICogQGRldl9udW1faWRhX21pbjogaWYgc2V0LCBkZWZpbmVzIHRo
ZSBtaW5pbXVtIHZhbHVlcyBmb3IgdGhlIElEQQ0KPiA+ICAgKiB1c2VkIHRvIGFsbG9jYXRlIHN5
c3RlbS11bmlxdWUgZGV2aWNlIG51bWJlcnMuIFRoaXMgdmFsdWUgbmVlZHMgdG8gYmUNCj4gPiAg
ICogaWRlbnRpY2FsIGFjcm9zcyBhbGwgU291bmRXaXJlIGJ1cyBpbiB0aGUgc3lzdGVtLg0KPiA+
ICsgKiBAcmVjaGVja191bmF0dGFjaGVkOiBpZiBzZXQsIGRvdWJsZS1jaGVjayBVTkFUVEFDSEVE
IHN0YXR1cyBjaGFuZ2VzDQo+ID4gKyAqIGJ5IHJlYWRpbmcgUElORyBmcmFtZSBzdGF0dXMuDQo+
ID4gICAqLw0KPiA+ICBzdHJ1Y3Qgc2R3X2J1cyB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXY7
DQo+ID4gQEAgLTkxNyw2ICs5MTksNyBAQCBzdHJ1Y3Qgc2R3X2J1cyB7DQo+ID4gIAlib29sIG11
bHRpX2xpbms7DQo+ID4gIAlpbnQgaHdfc3luY19taW5fbGlua3M7DQo+ID4gIAlpbnQgZGV2X251
bV9pZGFfbWluOw0KPiA+ICsJYm9vbCByZWNoZWNrX3VuYXR0YWNoZWQ7DQo+ID4gIH07DQo+ID4N
Cj4gPiAgaW50IHNkd19idXNfbWFzdGVyX2FkZChzdHJ1Y3Qgc2R3X2J1cyAqYnVzLCBzdHJ1Y3Qg
ZGV2aWNlICpwYXJlbnQsDQo=
