Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9353C733BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjFPV5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPV5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:57:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BF2967;
        Fri, 16 Jun 2023 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686952625; x=1718488625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ovOnablKwFQ/9XqqNvWsYuXkcLj3f2e0L//5oDT3HSQ=;
  b=P6WGgwOJwV9lLjzJT19fC2w30yBUsSt6kM5YO9Dl+jkPaa/ezAPjxrwt
   hgMOnkYPSfhLPoHcBK66HYMSlMPUVPwPyLEW4Oqn0/E3nOxsTKkBBug/e
   CnkWlJEwOy5K2SJALdOORmXOmw5ER8QDgnhVXLkx6HjRGBwfoLHxaZL7Q
   XwooVc9wg5QBn/E+sNK95U4al9MlecMn5rbrJWVqIfJL55MHgkCzPDe17
   65vSFCadmQira5He63tN/8byQCmDiYuqOupJPHhJP/2maBD4bdfllElgA
   TlReLfljYBXWvp5QeuxzQI9oKZdL1E9SHvC29wVJF5iVGh/2CZf7qZqje
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="425261272"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="425261272"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="778298852"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="778298852"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2023 14:57:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 14:57:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 14:57:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 14:57:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 14:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l++ndNtdtMfYInMzDVNC+fkOJzNy0pf3c1dZA7/LQ/kx3nvU7Tbj6BT+0+18oZZhMY6noGZILpDdBBRWjsZKIcVFPhhF3WFe9YtQO5S7Dvor3mT8TA+MVCXkB18eVaoGFnMexu6Qle9u8641C9G+BC8dkrk/4qrbWSb5RCGgInrtCJi9WnFtSXhegbuvieRSnUbo186G0E5mB33YazTweCCt+84dR3wiIs2OTl4+PBGnLMFC6gaZusc++wy8hlmded4O56QEEFz9v6OzvDXRGZwm3fC8Eczc9jCQmOPHQzCdSjYH2JXHDnS7p9VY3EmLbuWMn53iYw3bvY0DcTKBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovOnablKwFQ/9XqqNvWsYuXkcLj3f2e0L//5oDT3HSQ=;
 b=e+OydH2d/umQEZGgU0LIqjvG/Ky24zWHLmjt2p6ayeBWUoS6XVsRFyr36C9VzKuM8Te5Xigi4cRoqNKWI6hRpOD5v2bz81792mlM7tJvpjSqO2jJOgYaTX9htvb3BJmdI/7q7gpXcI6yw3iJx9AfBS9Ds1WNuwE2FTFIHObTnzeIVbD9o2Fyet1vpgcB9CPChM4FI9Up2EUxjoiznyDROu+hKYc1CphmuV/E15pp+/CQeff9ENzKkMskJt41HTu0FTEmOw66A4KOg3/z/BodQcRb/L4HvPjSjx3HCTczzo8NUWIc9sELE/QPNH9s1EdMG3aGn53QAB/c7vbZZSDmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 21:57:01 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 21:57:01 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZl0kyNzTj3/3/50ykPnbIRiA00K+MLxWAgAHbUMA=
Date:   Fri, 16 Jun 2023 21:57:01 +0000
Message-ID: <MWHPR11MB0048F68F717892378FF64E5FA958A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230605010117.794691-1-utkarsh.h.patel@intel.com>
 <20230605010117.794691-2-utkarsh.h.patel@intel.com>
 <CACeCKaeVw4UJ8oCj-wmWgf6TCcKYdprqb8Wdu-g2ZC5npgs71g@mail.gmail.com>
In-Reply-To: <CACeCKaeVw4UJ8oCj-wmWgf6TCcKYdprqb8Wdu-g2ZC5npgs71g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|PH8PR11MB7144:EE_
x-ms-office365-filtering-correlation-id: a9850cdf-6172-4de4-5379-08db6eb49d6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/EpRUeROYonP7UiBCO4AUkI7CeM7r8Yma8f1B/FXE5nG4MrVg7dLNZq/MBqhEGD0YinhDWfNyJiwPGc0Bkf4lsj1DzqUAHURy4YPVLR3VzROYgoK5bVUk+ITuXWlPlI02MI84KBEjNy0EMvJEEqyjg0J9KcsrfNtu7nVMwRDMbJdUMO65s6hfm3Lq8oP0Fa1o7Dtn1TlhGfFaFMj82zzN8nz0J9QKHoxnt5ZcwnJvrqbh4Bi4ykOtP81xoxpBOvJAMLV7EbaVpOkkklRNiRQYV7sTBzMWKICuLhUZ2O6nHacLZ+0qWWkfYQAbFzfIPf6gvXN8QuOvs6F0PCH6sh1hfTtbAeNhnSETnOJXLBrHf8/vaRLvvBG1DmvaH3QrujgsZPq7omd93LOSLNJS7QHZbK9WP50X4HPT72V2MAjtStvNsUmVb0rrpou1GIPI+m9jZAzqwqPIWIlrENYmnS8+in1U/8ekLpxleCDHgcLJvTTERt+oWSFUC68MBih1s9HXHLBoLI4AZ2fylWEm9Pnra25Y9PD0Ya1Yc79r7cqXKoQgHBuoBrEPdC0aheb5evA4bRlF9loZVpqMWTDeByzRFrqSkwEMuKO+K/Ko0/k9eeNX8eWYJwkfWMSWricF9f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(26005)(7696005)(8936002)(9686003)(8676002)(41300700001)(82960400001)(478600001)(71200400001)(66446008)(76116006)(4326008)(38100700002)(66556008)(86362001)(66476007)(66946007)(64756008)(6916009)(54906003)(33656002)(122000001)(38070700005)(316002)(55016003)(83380400001)(52536014)(5660300002)(186003)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1BuanpvenQvMzcwK0pDbCtzbmpLMEc4bndOMEtMYUNnbEFTUmY0NEtIRnB4?=
 =?utf-8?B?YTNCQXNlanRWNy9RcG5WL1dsLy9xdkdFU0JSTnNkTU4zWFRwdnRNL2lOZ1pQ?=
 =?utf-8?B?L2w3UmNjUWFOMWp6SmNPUlNFMW85RFg4SnVRekxlUVhTdm54dWJrNk55RERB?=
 =?utf-8?B?OExrYXllNDdKYWhoTmt5bFc5OXcwankveVhDQ3IyNldRTTRSNTg1VDl5VHRn?=
 =?utf-8?B?b0dRdEdYaUdLZ2FOcDkzU2VWVFoxSTNEQ3VYK1YvUk1zWVRhbHR6TU00Rjdj?=
 =?utf-8?B?S0hXUlFlTjE1RVdYMkpFTjhOSEpvZytMRTFwN3hzc01iVWlpNklwdXN6MHA0?=
 =?utf-8?B?R0U4OWZuS2FWamNsWnVtcEI0RTltdk03VThWZE10aDZwcTdDazBFQ1Nmay9L?=
 =?utf-8?B?Zmx0NDJiVE1wVG1ubUY2TEMydVc0ckVMYTBtajdYdFhBZmF6R055bUppaDZB?=
 =?utf-8?B?M09SMmZ5OGFEVHpnejdCb1Z3SEZ3ZXVrVGNpdTVURGg1YzJodXRtSDBIaGVj?=
 =?utf-8?B?WU5HZmMvbmVWaGZZcFpnTXhnSFBhYzZRS2p2bXo2K3ZmYTVLUERLZVRhTjZS?=
 =?utf-8?B?Q3ZpVnVZOHIrUDYwdFJpUE8yd25RNUg3ZmhHdXYvaXZ6YW52YmdnYzlCVjZl?=
 =?utf-8?B?YU9Id05hOXJLMzFwUWlmaW15cTBkK2VWNkduV3FjY1VzeUlEY0EzTE1aWU1a?=
 =?utf-8?B?bDJKSUVmRnlFNWFWd3cxMm5vTzIydjFLNExVTDhzQkFoYmRIQWNoSkdISlpr?=
 =?utf-8?B?WXh3MFZiNHVRV3dLWFJCSWhaMlBSL3FiaE4rUzNaaURGMjZoaFlVWUp1Tzd3?=
 =?utf-8?B?dkhPQVpCOGgyY3Y5MXpjQ2tKcCtlbFhmZElvZUdsNTZBK2Q3VzViczlNSnVM?=
 =?utf-8?B?Y1F5cWJQT3RjSCt6QkZHNnNxWmxzcVpYRGhvVUcvdGJQWVlCaENCOTEwNUsx?=
 =?utf-8?B?MisrNnFkcHpqazRrMHlZQTdwNUNqbTRuUmY4NEFENDdlajNEalh4YUZCUkZs?=
 =?utf-8?B?MTZrTTI0L3dWc3BUNG81YzZudythTXdIU3MvZFB1TjhjV0FCOEdHTXgwM0Er?=
 =?utf-8?B?ancvM3Z6UXl4VEord1ExdXczVDJJSWVZL1lNZmpuRHVoZ1d2cHgxWVVvanZU?=
 =?utf-8?B?ajgyTDFWSnBJQms1bHNpMFM2d3pDSmVnWTlTbFkzTmlvNUxJNG5SVXBuTkUr?=
 =?utf-8?B?bFVaemxaSkVBQmJnWVpPSGpYYkdnaFlJTXpTTW5oMjRjQ0JQaDZZdGNVcjFh?=
 =?utf-8?B?SkJFd2RJL09KeTZ5UDhnNWNtazNITzVEWGdoc1BXdFVjNldnU3ZEN3UzQ3dv?=
 =?utf-8?B?N0Uwb0tYSThqaGxuVStCQTRIZGEyb054ZjhJNlJvWlh1WlhqdUtwUHd2L3Ni?=
 =?utf-8?B?V0RGbU1xT0lrczdVcnVGNHRJU0grNTdrRm5jNUR6RlN3SUZISmxWd1NJck9M?=
 =?utf-8?B?b0VuYmRNcmVxUVdvR3JLQk5JSVgxak5jYitNYmJhcFhseXBmNE9OK2RVTjZV?=
 =?utf-8?B?NW02RHhDN1hJd0NnaGlIVEptT3hDUUR0UUpNdElBVjlHMTNGS0JvU2ZZZ25H?=
 =?utf-8?B?cFZyWUdEYkM4c0k1eWgxS1JxdGlzTHdVUnVBbXIwMEUwRklESWNJeldhckwv?=
 =?utf-8?B?Y2lhd3puUUhDK2tpUy81M1RtV09ad3RrSDdUSE1PTmNxQ0lXdm9IcVJaUFBQ?=
 =?utf-8?B?d0RGZVRlR2RMa0NacVRpMGpVazJvRk1WNEJHSGFOQUR4WTJhQnNwaWhCLzBJ?=
 =?utf-8?B?WW1vZUFjTk5ERjR5Q0Q2VDYzZHBQaktldExzejZaYU9IVXF4aGZmalRvSzAv?=
 =?utf-8?B?NEdKUSthVzMwaXhCYStXaDU1NEhpNnhZVjZxNXlmdnpFZW16VEFWcUZ5NmJq?=
 =?utf-8?B?YkRlaTkxWmpLT3FVd2Fpa2h4WHVCTzVtUFNQU1M3THh1Sm1TbDJXQXpIUENx?=
 =?utf-8?B?aDN3S3JhSm1NRnZWVTV2akV2d0dFSDlTVWpacnJvYm9LV3BNMVdTeXljcHk0?=
 =?utf-8?B?OGhQaDJlbEs2ampnTEMyMG1aOEVKK1FSU1ZjVldDN1FUd1ZMNE9vazN4c0xQ?=
 =?utf-8?B?d21pSzhyaFdCc1JZQ1RWWUZJRmFsZTROVzEwbytadUZjdk0zc3Y5dG8zNFV4?=
 =?utf-8?B?Ry9lZFNOT3dFRFRJbUxBbmhETnhYSFRzOXdHTm1tMHh1dXlHQ21Oam44eHN0?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9850cdf-6172-4de4-5379-08db6eb49d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 21:57:01.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhF1CrV5YlHESdy843hFIkntuDgz9hNS9q5O9Gnpzf49tKrygc9fsg3PHSwaS0H5OiOYA5gBRk6aOzav5nXgGjXYJ+jJbvGjjGxXFfZP0Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
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

SGkgUHJhc2hhbnQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyBhbmQgZmVlZGJhY2suDQoN
Cj4gPiBDb25uZWN0b3IgY2xhc3MgZHJpdmVyIG9ubHkgY29uZmlndXJlIGNhYmxlIHR5cGUgYWN0
aXZlIG9yIHBhc3NpdmUuDQo+ID4gV2l0aCB0aGlzIGNoYW5nZSBpdCB3aWxsIGFsc28gY29uZmln
dXJlIGlmIHRoZSBjYWJsZSB0eXBlIGlzIHJldGltZXINCj4gPiBvciByZWRyaXZlciBpZiByZXF1
aXJlZCBieSBBUC4gVGhpcyBkZXRhaWxzIHdpbGwgYmUgcHJvdmlkZWQgYnkgQ2hyb21lDQo+ID4g
RUMgYXMgYSBwYXJ0IG9mIGNhYmxlIGRpc2NvdmVyIG1vZGUgVkRPLg0KPiA+DQo+ID4gVGhpcyBj
aGFuZ2UgYWxzbyBicmluZ3MgaW4gY29ycmVzcG9uZGluZyBFQyBoZWFkZXIgdXBkYXRlcyBmcm9t
IHRoZSBFQw0KPiA+IGNvZGUgYmFzZSBbMV0uDQo+IA0KPiBQbGVhc2Ugc2VwYXJhdGUgdGhpcyBp
bnRvIGFub3RoZXIgcGF0Y2guDQoNCkkgY2FuIGRvIHRoYXQgYnV0IHNpbmNlIGl0J3MganVzdCBv
bmUgbGluZSBjaGFuZ2UgYW5kIHJlbGF0ZWQsIGtlcHQgaXQgdG9nZXRoZXIuIA0KDQo+ID4gYS9p
bmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvY3Jvc19lY19jb21tYW5kcy5oDQo+ID4gYi9pbmNs
dWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvY3Jvc19lY19jb21tYW5kcy5oDQo+ID4gaW5kZXggYWI3
MjFjZjEzYTk4Li5jOWFhNTQ5NWM2NjYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9w
bGF0Zm9ybV9kYXRhL2Nyb3NfZWNfY29tbWFuZHMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgv
cGxhdGZvcm1fZGF0YS9jcm9zX2VjX2NvbW1hbmRzLmgNCj4gPiBAQCAtNDk2Myw2ICs0OTYzLDgg
QEAgc3RydWN0IGVjX3Jlc3BvbnNlX3VzYl9wZF9jb250cm9sX3YxIHsgICNkZWZpbmUNCj4gPiBV
U0JfUERfQ1RSTF9UQlRfTEVHQUNZX0FEQVBURVIgIEJJVCgyKQ0KPiA+ICAvKiBBY3RpdmUgTGlu
ayBVbmktRGlyZWN0aW9uICovDQo+ID4gICNkZWZpbmUgVVNCX1BEX0NUUkxfQUNUSVZFX0xJTktf
VU5JRElSICBCSVQoMykNCj4gPiArLyogUmV0aW1lci9SZWRyaXZlciBjYWJsZSAqLw0KPiA+ICsj
ZGVmaW5lIFVTQl9QRF9DVFJMX1JFVElNRVJfQ0FCTEUgQklUKDQpDQo+IA0KPiBXaHkgYXJlIHdl
IGFkZGluZyB0aGlzIHRvIHRoaXMgaG9zdCBjb21tYW5kcyBpbnRlcmZhY2U/IElzIHRoaXMgaW5m
b3JtYXRpb24NCj4gbm90IGF2YWlsYWJsZSBmcm9tIHRoZSBDYWJsZSAocGx1ZykncyBJZGVudGl0
eSBpbmZvcm1hdGlvbj8gV2UgcmVnaXN0ZXIgYWxsIG9mDQo+IHRoYXQgaW4gdGhlIHBvcnQgZHJp
dmVyIGFscmVhZHkgWzFdLCBzbyB3ZSBzaG91bGQganVzdCB1c2UgdGhhdCwgaW5zdGVhZCBvZg0K
PiBjaGFuZ2luZyB0aGUgaG9zdCBjb21tYW5kIGludGVyZmFjZS4NCg0KQWxsIHRoZSBjYWJsZSBk
ZXRhaWxzIHVzZWQgdG8gY29uZmlndXJlIEFsdGVybmF0ZSBtb2RlIGFuZCBVU0I0IG1vZGUgaW4g
dGhpcyBkcml2ZXIgYXJlIHByb3ZpZGVkIGZyb20gRUMgaG9zdCBjb21tYW5kLiANClRvIHN0YXkg
Y29uc2lzdGVudCB3aXRoIHRoZSBleGlzdGluZyBpbXBsZW1lbnRhdGlvbiwgaXQgd2FzIGFkZGVk
IHRvIHRoZSBleGlzdGluZyBob3N0IGNvbW1hbmQuIA0KDQpTaW5jZXJlbHksDQpVdGthcnNoIFBh
dGVsLg0K
