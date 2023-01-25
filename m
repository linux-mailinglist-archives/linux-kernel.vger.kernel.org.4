Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1EC67B5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjAYP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjAYP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406702A153
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674660560; x=1706196560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UlBpbaxmAXpVqPunXG+fydYnPa9jpkDsgD9Ct426WNI=;
  b=SJSWPgrHz7R0ztsfpaO2h9IG5HVRxdU9ko5/ii/pvGokqfC8dA3oUY7t
   x83gX5vM/SHnXPUYY9CW0BXLoF1+XodJzTeTTvB+W71FL6SvBXd9VdqyE
   e4jXaUK1CLtm7OITd2QiCxKeJaHmFGewjjJ8uI4rEMlzEbdMUgZ4NxMUM
   I+6kq87K6x226PI8D8XKO+42WWB3aKmhV+ozXLAvLT8mN49nfLT5eRpkj
   MrZDh9aXJA6YD1Hs3o7h0y9mCOZ+T5dlrux5vsanfaRa1LpdpqcpkeRb2
   hCZyGoOT3s46Fk/KwKtWL87/EeFNDNJYY54IUpCTgpCnJpuaMMYL294un
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="353868818"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="353868818"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="991303936"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="991303936"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2023 07:29:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 07:29:18 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 07:29:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 07:29:17 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 07:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AilmD49pbrwZkvg4axT3Wysw9RTK/SuLiCbkpvVPQj2fb2E6U71BQcAV8LhbQzWrVQLfnm87cvTJsqsCCkyS1pi8mjqPtoPkOEFrj/+2qtmTbEmY9xqIvxeIOkhno20K/R/60qDGDmIVNaEt+wIi8C29zoAABcfqem96Ip5D8rc9Ja97/D121zu9splO8Zzzp2K9tDBzL2RthjVdjHweP6X9cRb6+OzOy8GnBdfgCyw1DzYI8VCQlUDHRDdsliy1203y0v2e9AAQjviDYkMNqCgxHrCfWGK5WPp0XVqXvOBHqmg6FNPHYQVp6muW1XPaDFgefo1ZY4ZFOb5YTD+ODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlBpbaxmAXpVqPunXG+fydYnPa9jpkDsgD9Ct426WNI=;
 b=aoVqentwWw8fsZMLAE2i0h3vnN2ZF2mV1HSuPLiJBW0vM2lRRhZ56KzHfVoAERg/7VBmXeiAgc1B4u2HIGyyjbmL5obHGdVzHMyL7t+uzgsgs3BWtje+XOAhoKrmpJ+m+EtaHpLLjZEpt7F/quzP8BDn7qPoqRYgZybQLFkJzQIdNEplNDMdJAeLcB6jc60t4ESWFuJamwaWyA+2gynGOgmHKSb8vyNXY/5AGlbEELM1uJ9I23Nr0F/dFHkA7OgBRN9vW1oGyldnbsKVto6mYZjBQyo0SY+0yTf4ytqorswxuMnq6EJl3aLACWGXxMtwk7J6F6juf/yl4e6+ADpzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 15:29:07 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%4]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 15:29:07 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067A=
Date:   Wed, 25 Jan 2023 15:29:07 +0000
Message-ID: <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
In-Reply-To: <Y9EkCvAfNXnJ+ATo@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DS0PR11MB6397:EE_
x-ms-office365-filtering-correlation-id: b95d00af-7efc-4fec-0985-08dafee8e612
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQSs1jsLcw7CGTO/+HU2/2kGstDNJ+wmoBXmK7pZA8yjCxL2LxiAA0sbi4k4CmY4K4t6g+IUFy/XloGkFKAF1j+ZO9xEeLczSw2Taz4vRqg2ZIcZ2Tqq+WIHelVvJV/UxQf7+uVYRzZE28sQwtqGYiO8RhFfZbkwlg82ydArPQkztTMuASUpiMJnmoVcs0mkpKjnJqQHeB34ZtNlwkTbYVYvgU2ZIsUkIVZsjPKgj5fhl5tX83z6T1ka+JLKeoCLN0SiMiDWkSWJ/fNUVsbq5MpDld+Zv0Amixe6rH/mW6QRloM/3m6YathchZE3ITZ2VcV7Q03xmIw3k5PLIb1azGWDr3Y/PDCkfTJLWh9SOUYm2MWxjABh7agemMfXgthuaIrmkV2TGSCBwU1UYTG54tl2QBV70P9HPoqavzk223TKpMrNez5QPMbzKkn9AVlAzQVWqd7zZWfvBavDO1pSkYtl6mNGlLqYaLdUl0wXLfn7xxFbkCRjNgmADhBkUV0zHLT1oK1QA6oU4fFE0HIwMcyQFmTmeDKT3aD9WM/fhhgTx4SUQl6V3sLEL95ZAh0MNgRIbGbaoW9PM+bI1lN2xZAR0EPnhGxjOQqKCY8QMsR2qd3SwM6heho/clyOl9Em9l8MES0wDCIUSWN3mojKZANmDxxXGU4eBeeTTAvQmLFcIo+KbcSO9SvOK4bx9jZX5z2HzB2igOZzhSgUdmNSl5EbHeNfcNwHn8ED7CrQzBn5IWgbew3hAg4l8iGXcAkumCExX+1xl/EnmwNzSQsPDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199018)(66899018)(38070700005)(966005)(86362001)(33656002)(76116006)(478600001)(122000001)(41300700001)(52536014)(64756008)(9686003)(26005)(186003)(316002)(6506007)(66946007)(66476007)(7696005)(4326008)(71200400001)(54906003)(55016003)(66446008)(6916009)(7416002)(66556008)(82960400001)(38100700002)(5660300002)(8676002)(8936002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTQzdnVDdHRjS1o1a0MzOUtqemdxSGhuQkNwbHlQKzA4U0RBU2doaVEra24x?=
 =?utf-8?B?V20yV0Q5OVVudTNxcEJyeWJMN1U4L1BpRTVJakVlRWtaUGtMQWF3ejI1V0hQ?=
 =?utf-8?B?dVpBTXExUW9TOGdrWFFQdDBWdDVJRElQb1Z5NDUyVHFMMmxGYW83YThtSE5s?=
 =?utf-8?B?N2xCSjNudDcwZFR6S0E5TzQyZ2doaE45SFJhU3pvRW5UR29Uck9lMzRCMTBj?=
 =?utf-8?B?R3JZK21La1oxUk5aTnhiMnJhRmtIM1ZQa0NObjlVR1cvaCt5Q0pYSFJoZFhj?=
 =?utf-8?B?RVpRV1Q1SWRpZEpxUmdGRkt1NFJIUEpXMGlzTGx6TlBDYlFNU25SSXYxS25V?=
 =?utf-8?B?dklEeVcvTE8wc0V4TTFNbGorZjF5KzRaVENmRTZWSk0zUHR0T3ZKckxlODRI?=
 =?utf-8?B?RVozNWptZXNCM3YxNGxnOGh6NG9BczdjK0xnaGplZytlOWxBY2NkNVFMR3hj?=
 =?utf-8?B?cS9vWE50V05HbEJ3OEVYTUY5eG9DRUtIQ3lBQWM3MFYvaXNDUEtpODBqM0JZ?=
 =?utf-8?B?REdFbWI4dWtwa2ZxSmwrbklhMk1XblNBRXFJTHNSaGRNS2lpK2JVYXpxTlhO?=
 =?utf-8?B?c05pVkx3TFdUQ2VLQVVnQ2s5T0M3SHI4Qkxxc2ZvbUp6UmJGTDcralM1c1pL?=
 =?utf-8?B?YlBJQ3FwSDZhR05VZUVYVWVXd1U0NnJYU0dEYkxwWjFyWUpBQWhOUi9YMS9W?=
 =?utf-8?B?eGhjVzR4NDNoVld1Q3ZZQy9BMXR3YWVXLy80WStHK1FVTzRLM2R1ZVoyUDZi?=
 =?utf-8?B?MUhXcUR5TmtGYVRQKzl3MlJlanliWnM4VmxsU2JxNFFmLzZIMzlRNUpYdW5J?=
 =?utf-8?B?UzRmWnBWTmpUUTdoSEQzcFZRZ0tFOVJmak5ubHZuQWQ4bk5ZNUh3WENIdmZo?=
 =?utf-8?B?ZVlLZ3V2VVQvY3FqR0JXYlJhVFZFTjViM25NMjFoUVlSbEFPQm9hOXdtb0pN?=
 =?utf-8?B?OURwM3FUTTgzOHM4MUcwWUFMZTdxb0oxYlJEQTJoVkliaGtKZ3RxOTY0NEI5?=
 =?utf-8?B?LzZKUlEvK28rTUE1NnFqRGVwZU1Oc1h4SG9xQUwwcVdtdFB1ZEJiVnN5YXF0?=
 =?utf-8?B?SXlJeUJURlUzYk9qbkgzOW4rQ09PMFpMY3diUFNud0hLQkJJZnJ4dzNqVjdJ?=
 =?utf-8?B?Z05TTFpZZ0ZjS2NFNzdOQTh2TVBGNUxEKzUrb0F5eEdYM3FldGNBWDU3MmE2?=
 =?utf-8?B?RXRSYlBNd0NGc2xYTFVsVU1LOWd6OTdFWE15YXlXcngxbzYyRlVsaFBEeG1n?=
 =?utf-8?B?Ymg4Zk50UzcyZHlwSy9qa0hWSmFHZkg2cExkNHBjZ1RhUEdmdGNEdEhEYXVE?=
 =?utf-8?B?MmFrNkF4OXhiOEtwZHhnalNjcVUwWTZsUS94R0lUamg1VkhPMHdDOTd2ODJK?=
 =?utf-8?B?T3RuYkdwR2s5dHlpNUZIdUFZWnV2bTdSN0ZUTURrSVBFcTRvQ25XYXVpVjE0?=
 =?utf-8?B?MUpRSTFabnp2TU9wWHNxMjBoMC95dHc1b3lpdmxNS2hjMEd1aUVmbDBVTlF4?=
 =?utf-8?B?ZmpWMmY5MWhvWGIxKzZaQjhjSTM5MTBhU2NGMGlWYi96b2VSSDY5Zys5MnJ4?=
 =?utf-8?B?US9vVUEvVzZvc2kzUzJIZ0pHblJjTCtpaVR4ZlZHcUdjTm9kcWQ3eWROM0hj?=
 =?utf-8?B?MnlJY3pGSnFyTHdvTkx4Y0U4aWE1WmFHZkR5eVJKbzNhVVdhY0hoMXhoUjNx?=
 =?utf-8?B?RFViS2dUN1M0UXpQVkM3RHZtOWh6VkFCQ3ZTb2FnR3BCWmw3bEN0MzJjUmJE?=
 =?utf-8?B?eDQzR2VXRzMzYUhDcGpMNURGZ3lybCt3RzRxZEk0M3hiN0p3aFJFYkZYVk1t?=
 =?utf-8?B?bTZPMi9XN21RZzJLY2ZSZ0dYUjd6eCt2U3Vqay80VTZGMmVHWnVLMkQ1a3o3?=
 =?utf-8?B?eHlJMGRSSFFJdEQzV1Y3bU5JNlhlM2tBOUt0djc3a1dCdHY4azQvZFZlUks4?=
 =?utf-8?B?eVZqb1MvcTVkQS9rcjZ0RkEwM1IvaEVGR0I1cUNWZjlQRFBFMDRsUGJtRkF6?=
 =?utf-8?B?RkZVUkRLQmJjdTBKSVpPSXlndWc3L3htUSsrb05JTlE5OEFpN1J3OWg3UXhp?=
 =?utf-8?B?WUpXaU9OUUZ4NlZ2clVKNnBFakZOdG1kcnRkUUZrYml6ZUR6bTR3MGwrOURJ?=
 =?utf-8?Q?84CiGHwVQf/VpDNRs6iINcq7l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95d00af-7efc-4fec-0985-08dafee8e612
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 15:29:07.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tdFWIcUCME5eNZ7+JRtOLX7ZnTfUMCOnMPhePPezIh2BiOaAI6JtlIqQOZ7gk2kfxoVYc869l/74LA/ytIrlPvNEtcT9tVbbO2VYqhxoPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
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

UmVwbHlpbmcgb25seSB0byB0aGUgbm90LXNvLWZhciBhZGRyZXNzZWQgcG9pbnRzLiANCg0KPiBP
biBXZWQsIEphbiAyNSwgMjAyMyBhdCAxMjoyODoxM1BNICswMDAwLCBSZXNoZXRvdmEsIEVsZW5h
IHdyb3RlOg0KPiA+IEhpIEdyZWcsDQo+ID4NCj4gPiBZb3UgbWVudGlvbmVkIGNvdXBsZSBvZiB0
aW1lcyAobGFzdCB0aW1lIGluIHRoaXMgcmVjZW50IHRocmVhZDoNCj4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvWTgwV3R1am5PN2tmZHVBWkBrcm9haC5jb20vKSB0aGF0IHdlIG91Z2h0
IHRvDQo+IHN0YXJ0DQo+ID4gZGlzY3Vzc2luZyB0aGUgdXBkYXRlZCB0aHJlYXQgbW9kZWwgZm9y
IGtlcm5lbCwgc28gdGhpcyBlbWFpbCBpcyBhIHN0YXJ0IGluIHRoaXMNCj4gZGlyZWN0aW9uLg0K
PiANCj4gQW55IHNwZWNpZmljIHJlYXNvbiB5b3UgZGlkbid0IGNjOiB0aGUgbGludXgtaGFyZGVu
aW5nIG1haWxpbmcgbGlzdD8NCj4gVGhpcyBzZWVtcyB0byBiZSBpbiB0aGVpciBhcmVhIGFzIHdl
bGwsIHJpZ2h0Pw0KDQpBZGRlZCBub3csIEkgYW0ganVzdCBub3Qgc3VyZSBob3cgbWFueSBtYWls
aW5nIGxpc3RzIEkgd2FudCB0byBjcm9zcyBzcGFtIHRoaXMuDQpBbmQgdGhpcyBpcyBhIHZlcnkg
c3BlY2lhbCBhc3BlY3Qgb2YgJ2hhcmRlbmluZycgc2luY2UgaXQgaXMgYWJvdXQgaGFyZGVuaW5n
IGEga2VybmVsDQp1bmRlciBkaWZmZXJlbnQgdGhyZWF0IG1vZGVsL2Fzc3VtcHRpb25zLiANCiAN
Cg0KPiBJIGhhdGUgdGhlIHRlcm0gImhhcmRlbmluZyIuICBQbGVhc2UganVzdCBzYXkgaXQgZm9y
IHdoYXQgaXQgcmVhbGx5IGlzLA0KPiAiZml4aW5nIGJ1Z3MgdG8gaGFuZGxlIGJyb2tlbiBoYXJk
d2FyZSIuICBXZSd2ZSBkb25lIHRoYXQgZm9yIHllYXJzIHdoZW4NCj4gZGVhbGluZyB3aXRoIFBD
SSBhbmQgVVNCIGFuZCBldmVuIENQVXMgZG9pbmcgdGhpbmdzIHRoYXQgdGhleSBzaG91bGRuJ3QN
Cj4gYmUgZG9pbmcuICBIb3cgaXMgdGhpcyBhbnkgZGlmZmVyZW50IGluIHRoZSBlbmQ/DQoNCldl
bGwsIHRoYXQgd291bGQgbm90IGJlIGZ1bGx5IGNvcnJlY3QgaW4gdGhpcyBjYXNlLiBZb3UgY2Fu
IHJlYWxseSBzZWUgaXQgZnJvbSB0d28NCmFuZ2xlczoNCg0KMS4gZml4aW5nIGJ1Z3MgdG8gaGFu
ZGxlIGJyb2tlbiBoYXJkd2FyZQ0KMi4gZml4aW5nIGJ1Z3MgdGhhdCBhcmUgcmVzdWx0IG9mIGNv
cnJlY3RseSBvcGVyYXRpbmcgSFcsIGJ1dCBpbmNvcnJlY3RseSBvciBtYWxpY2lvdXNseQ0Kb3Bl
cmF0aW5nIGh5cGVydmlzb3IgKGFjdGluZyBhcyBhIG1hbiBpbiB0aGUgbWlkZGxlKQ0KDQpXZSBm
b2N1cyBvbiAyIGJ1dCBpdCBoYXBwZW5zIHRvIGFkZHJlc3MgMSBhbHNvIHRvIHNvbWUgbGV2ZWwu
ICANCg0KPiANCj4gU28gd2hhdCB5b3UgYWxzbyBhcmUgc2F5aW5nIGhlcmUgbm93IGlzICJ3ZSBk
byBub3QgdHJ1c3QgYW55IFBDSQ0KPiBkZXZpY2VzIiwgc28gcGxlYXNlIGp1c3Qgc2F5IHRoYXQg
KHdoeSBkbyB5b3UgdHJ1c3QgVVNCIGRldmljZXM/KSAgSWYNCj4gdGhhdCBpcyBzb21ldGhpbmcg
dGhhdCB5b3UgYWxsIHRoaW5rIHRoYXQgTGludXggc2hvdWxkIHN1cHBvcnQsIHRoZW4NCj4gbGV0
J3MgZ28gZnJvbSB0aGVyZS4NCj4gDQo+ID4gMykgQWxsIHRoZSB0b29scyBhcmUgb3Blbi1zb3Vy
Y2UgYW5kIGV2ZXJ5b25lIGNhbiBzdGFydCB1c2luZyB0aGVtIHJpZ2h0IGF3YXkNCj4gZXZlbg0K
PiA+IHdpdGhvdXQgYW55IHNwZWNpYWwgSFcgKHJlYWRtZSBoYXMgZGVzY3JpcHRpb24gb2Ygd2hh
dCBpcyBuZWVkZWQpLg0KPiA+IFRvb2xzIGFuZCBkb2N1bWVudGF0aW9uIGlzIGhlcmU6DQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2NjYy1saW51eC1ndWVzdC1oYXJkZW5pbmcNCj4gDQo+
IEFnYWluLCBhcyBvdXIgZG9jdW1lbnRhdGlvbiBzdGF0ZXMsIHdoZW4geW91IHN1Ym1pdCBwYXRj
aGVzIGJhc2VkIG9uDQo+IHRoZXNlIHRvb2xzLCB5b3UgSEFWRSBUTyBkb2N1bWVudCB0aGF0LiAg
T3RoZXJ3aXNlIHdlIHRoaW5rIHlvdSBhbGwgYXJlDQo+IGNyYXp5IGFuZCB3aWxsIGdldCB5b3Vy
IHBhdGNoZXMgcmVqZWN0ZWQuICBZb3UgYWxsIGtub3cgdGhpcywgd2h5IGlnbm9yZQ0KPiBpdD8N
Cg0KU29ycnksIEkgZGlkbuKAmXQga25vdyB0aGF0IGZvciBldmVyeSBidWcgdGhhdCBpcyBmb3Vu
ZCBpbiBsaW51eCBrZXJuZWwgd2hlbg0Kd2UgYXJlIHN1Ym1pdHRpbmcgYSBmaXggdGhhdCB3ZSBo
YXZlIHRvIGxpc3QgdGhlIHdheSBob3cgaXQgaGFzIGJlZW4gZm91bmQuDQpXZSB3aWxsIGZpeCB0
aGlzIGluIHRoZSBmdXR1cmUgc3VibWlzc2lvbnMsIGJ1dCBzb21lIGJ1Z3Mgd2UgaGF2ZSBhcmUg
Zm91bmQgYnkNCnBsYWluIGNvZGUgYXVkaXQsIHNvICdodW1hbicgaXMgdGhlIHRvb2wuIA0KDQo+
IA0KPiA+IDQpIGFsbCBub3QgeWV0IHVwc3RyZWFtZWQgbGludXggcGF0Y2hlcyAodGhhdCB3ZSBh
cmUgc2xvd2x5IHN1Ym1pdHRpbmcpIGNhbiBiZQ0KPiBmb3VuZA0KPiA+IGhlcmU6IGh0dHBzOi8v
Z2l0aHViLmNvbS9pbnRlbC90ZHgvY29tbWl0cy9ndWVzdC1uZXh0DQo+IA0KPiBSYW5kb20gZ2l0
aHViIHRyZWVzIG9mIGtlcm5lbCBwYXRjaGVzIGFyZSBqdXN0IHRoYXQsIHNvcnJ5Lg0KDQpUaGlz
IHdhcyBqdXN0IGZvciBhIGNvbXBsZXRlbmVzcyBvciBmb3IgYW55b25lIHdobyBpcyBjdXJpb3Vz
IHRvIHNlZSB0aGUgYWN0dWFsDQpjb2RlIGFscmVhZHkgbm93LiBPZiBjb3Vyc2UgdGhleSB3aWxs
IGJlIHN1Ym1pdHRlZCBmb3IgcmV2aWV3IA0KdXNpbmcgbm9ybWFsIHByb2Nlc3MuIA0KDQo+IA0K
PiA+IFNvLCBteSBtYWluIHF1ZXN0aW9uIGJlZm9yZSB3ZSBzdGFydCB0byBhcmd1ZSBhYm91dCB0
aGUgdGhyZWF0IG1vZGVsLA0KPiBtaXRpZ2F0aW9ucywgZXRjLA0KPiA+IGlzIHdoYXQgaXMgdGhl
IGdvb2Qgd2F5IHRvIGdldCB0aGlzIHJldmlld2VkIHRvIG1ha2Ugc3VyZSBldmVyeW9uZSBpcyBh
bGlnbmVkPw0KPiA+IFRoZXJlIGFyZSBhIGxvdCBvZiBhbmdsZXMgYW5kIGRldGFpbHMsIHNvIHdo
YXQgaXMgdGhlIG1vc3QgZWZmaWNpZW50IG1ldGhvZD8NCj4gPiBTaG91bGQgSSBzcGxpdCB0aGUg
dGhyZWF0IG1vZGVsIGZyb20gaHR0cHM6Ly9pbnRlbC5naXRodWIuaW8vY2NjLWxpbnV4LWd1ZXN0
LQ0KPiBoYXJkZW5pbmctZG9jcy9zZWN1cml0eS1zcGVjLmh0bWwNCj4gPiBpbnRvIGxvZ2ljYWwg
cGllY2VzIGFuZCBzdGFydCBzdWJtaXR0aW5nIGl0IHRvIG1haWxpbmcgbGlzdCBmb3IgZGlzY3Vz
c2lvbiBvbmUgYnkNCj4gb25lPw0KPiANCj4gWWVzLCBzdGFydCBvdXQgYnkgbGF5aW5nIG91dCB3
aGF0IHlvdSBmZWVsIHRoZSBhY3R1YWwgcHJvYmxlbSBpcywgd2hhdA0KPiB5b3UgZmVlbCBzaG91
bGQgYmUgZG9uZSBmb3IgaXQsIGFuZCB0aGUgcGF0Y2hlcyB5b3UgaGF2ZSBwcm9wb3NlZCB0bw0K
PiBpbXBsZW1lbnQgdGhpcywgZm9yIGVhY2ggYW5kIGV2ZXJ5IGxvZ2ljYWwgcGllY2UuDQoNCk9L
LCBzbyB0aGlzIHRocmVhZCBpcyBhYm91dCB0aGUgYWN0dWFsIHRocmVhdCBtb2RlbCBhbmQgb3Zl
cmFsbCBwcm9ibGVtLiANCldlIGNhbiByZS13cml0ZSB0aGUgY3VycmVudCBidWcgZml4ZSBwYXRj
aGVzICh2aXJ0aW8gYW5kIE1TSSkgdG8gcmVmZXIgdG8gdGhpcyB0aHJlYXQgbW9kZWwNCnByb3Bl
cmx5IGFuZCBleHBsYWluIHRoYXQgdGhleSBmaXggdGhlIGFjdHVhbCBidWdzIHVuZGVyIHRoaXMg
dGhyZWF0IG1vZGVsLg0KUmVzdCBvZiBwaWVjZXMgd2lsbCBjb21lIHdoZW4gb3RoZXIgcGF0Y2hl
cyB3aWxsIGJlIHN1Ym1pdHRlZCBmb3IgdGhlIHJldmlldw0KaW4gbG9naWNhbCBncm91cHMuIA0K
DQpEb2VzIHRoaXMgd29yaz8gDQoNCj4gDQo+IEFnYWluLCBub3RoaW5nIG5ldyBoZXJlLCB0aGF0
J3MgaG93IExpbnV4IGlzIGRldmVsb3BlZCwgYWdhaW4sIHlvdSBhbGwNCj4ga25vdyB0aGlzLCBp
dCdzIG5vdCBhbnl0aGluZyBJIHNob3VsZCBoYXZlIHRvIHNheS4NCj4gDQo+ID4gQW55IG90aGVy
IG1ldGhvZHM/DQo+ID4NCj4gPiBUaGUgb3JpZ2luYWwgcGxhbiB3ZSBoYWQgaW4gbWluZCBpcyB0
byBzdGFydCBkaXNjdXNzaW5nIHRoZSByZWxldmFudCBwaWVjZXMgd2hlbg0KPiBzdWJtaXR0aW5n
IHRoZSBjb2RlLA0KPiA+IGkuZS4gd2hlbiBzdWJtaXR0aW5nIHRoZSBkZXZpY2UgZmlsdGVyIHBh
dGNoZXMsIHdlIHdpbGwgaW5jbHVkZSBwcm9ibGVtDQo+IHN0YXRlbWVudCwgdGhyZWF0IG1vZGVs
IGxpbmssDQo+ID4gZGF0YSwgYWx0ZXJuYXRpdmVzIGNvbnNpZGVyZWQsIGV0Yy4NCj4gDQo+IEFz
IGFsd2F5cywgd2UgY2FuJ3QgZG8gYW55dGhpbmcgd2l0aG91dCBhY3R1YWwgd29ya2luZyBjaGFu
Z2VzIHRvIHRoZQ0KPiBjb2RlLCBvdGhlcndpc2UgaXQncyBqdXN0IGEgcGlwZSBkcmVhbSBhbmQg
d2UgY2FuJ3Qgd2FzdGUgb3VyIHRpbWUgb24gaXQNCj4gKG5laXRoZXIgd291bGQgeW91IHdhbnQg
dXMgdG8pLg0KDQpPZiBjb3Vyc2UsIGNvZGUgZXhpc3RzLCB3ZSBqdXN0IG9ubHkgc3RhcnRpbmcg
c3VibWl0dGluZyBpdC4gV2Ugc3RhcnRlZCBmcm9tDQplYXN5IGJ1ZyBmaXhlcyBiZWNhdXNlIHRo
ZXkgYXJlIHNtYWxsIHRyaXZpYWwgZml4ZXMgdGhhdCBhcmUgZWFzeSB0byByZXZpZXcuIA0KQmln
Z2VyIHBpZWNlcyB3aWxsIGZvbGxvdyAoZm9yIGV4YW1wbGUgU2F0eWEgaGFzIGJlZW4gYWRkcmVz
c2luZyB5b3VyIGNvbW1lbnRzIGFib3V0IHRoZQ0KZGV2aWNlIGZpbHRlciBpbiBoaXMgbmV3IGlt
cGxlbWVudGF0aW9uKS4gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0K
