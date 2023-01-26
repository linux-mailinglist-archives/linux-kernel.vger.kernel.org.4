Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C32967CBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbjAZNNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjAZNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:13:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8510346092
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674738816; x=1706274816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qZR7ZBAF2iACk5w8LGTu1m4Kcs6Y2soZrQ6qAqDmxU8=;
  b=ccWISA6uIaC/RA7+/W/Jy/WKA5ECowvl8EGf1cVjZFTBQNSlzCnLiLXP
   5AVENgN2npIxMw1ruNLCxFz6EaXeS+hwg6ztVGRBYHeioBJPOHfkVJ1nr
   t3k9n1Cy5pUCJbD/HPMZKDBorUtXqWSP0PJfN/j/F5axiz+nCN7Ak8kG3
   qu6nI5mVx2xDm4O52BBLI+kKa0OMmBxY3oO9zYGLDy1rDVo0OzOIlKBjU
   y+Jxud51h9cLDbgVUDVojGOkCphq/xjGEexjDmMjyyFqi2Ivlkq5X5WEK
   rAvib2muxct05KXgx4sO9hf+Nttb0J/xqRHOy/IGcwNlC/o9NPhRDroNw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="325476653"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="325476653"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="664841777"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="664841777"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2023 05:13:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 05:13:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 05:13:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 05:13:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 05:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKxwvQJSGaVvSHqyYg5/uHeAhrSGjzgbbzwQgZrCzYfZyU8M/H3D0fq+/VnT388W/eB0Ccys8hKQODiAa6hs8QGpQoG//it1/1wrlTOPIHgHMkjJtvJOKqw2UeEkeagQ5gl0PtYrFip1B/T+sARWZ1Wkg9ebEt6GgVrJVLwHsLWaFE0dA4Nm4QfbXhxLk2tMfw0SX4YZeS0kzw9LgLD0adkea9gXKDfzwq7lBN1AuENTsbbS0sHv3ZmHevTqu3ETIHM3zsTYi/mH36tWvjPRKreGD0oqn9S4TZxoKc6SNPmeVqecfRirYl7YdnSa8bola9fg0v9Fs8JenJ6tGCaTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZR7ZBAF2iACk5w8LGTu1m4Kcs6Y2soZrQ6qAqDmxU8=;
 b=S/YveNrya4Kxq0e+FPAQ6GcZYcFDbzBLC1VeSSiUI3wamHepjljq5WkM5YAVKYr3jBZs4UNyAfp/5cFx90n35vDbwMtbO81DIBwNlnNrxX3qjabMnlkEBN4HOCbaDrWE1k/LMyZNmxmtNPEh68sasXH0CbWXhX2qQKgjmcCOKpKknjHZ1oEEgwAz2Ui5dyhlnA0HVAbNz3XdJhy9abuG8pdeLxmjhkb9raDmyTaa3+xhLu36xwTXS8VP5TjjoOb1gvXtbg/aBbYWqGeoiP0xE+mPNvuad/e5ISvwNZFTgK1gLbWEvI8R3bF3c0aHlj/9dnXeLMVnynP4nKz9eLRqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BN9PR11MB5548.namprd11.prod.outlook.com (2603:10b6:408:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 13:13:13 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 13:13:13 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAIPWoAAAWV6AAAtT1dg
Date:   Thu, 26 Jan 2023 13:13:13 +0000
Message-ID: <DM8PR11MB5750118EECE1BF835CF0393BE7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com> <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
In-Reply-To: <Y9E7PNmSTP5w2zuw@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BN9PR11MB5548:EE_
x-ms-office365-filtering-correlation-id: 9d7f9cfb-220f-44c9-e2bb-08daff9f1449
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/I113lcVAJFuJvbNGvtcXr/Qjj6mkYn1w0C4II9Rx6ayur/bnjB2KCBJmxPt1lkn7OsU54AEhi2nqbXlHHSiolKaM2dpmsQ+ZGpgxfnTMPtezATLJOwlufgB11280RCk02R9AHPodBYKSTk3OC5O0CNgleAspe05SE/f+eSE5uDZUadnKvC2GhUotUpzd+CcpO+Bb3EYR/Kg/TtI/ulVIHPh6Gqam99m95qlJhA/ucxwLlV0Qw3tP10ufZaPLIEYcA3Llf9chFnXQfpYCyVvWBdxwRQX3qodVkhr2AKzRWwOrN/Ar3k2YDA3f1C2MRHtqgW0be1LG0K9BNGD6UW8YT4M/AAIpGn8DhT0QPfg7vQVPr7M5n1/VBB6jYCuwpxenXKi6tjYhOAvcTz2s0H4VMj9v+b8G35VX6A1hQ/xAfJplqSZYhkemWvo+xVikY3McCS2+wRE0zbiTzpdO3JNfW/eAzpVnJKnqZ+CS+Kd5vMOHweBol9Tt4wMb2nh4x9vjBIWC0N058s7nseMKMkfpWkvfXGPk5jlKfEx7nCTx842RloGjdcf7eiofNxY5KCDpGeMIkxhPPOQigFdcjHQPumI29nZeAWNwMERA93g0slYEi8+oAig7TiuQ98BGxQMOLOmzAYy06GxpfEUl7xeUfRw8hWYcN4u6I9T7UNjZjT7qJsd1npTIEH+g7mDqNQkCTMWWXwE0QLSY83mBYs2QEevZF9sgfs0M1ztwGB3gQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(33656002)(7696005)(71200400001)(8676002)(316002)(54906003)(478600001)(82960400001)(6506007)(5660300002)(7416002)(2906002)(4326008)(76116006)(66556008)(66476007)(64756008)(66946007)(52536014)(8936002)(41300700001)(66446008)(38070700005)(55016003)(122000001)(38100700002)(26005)(83380400001)(86362001)(966005)(9686003)(186003)(110136005)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2psQm1QTFhvcjVSMTI1U3E3RFJ0Uy9lY1FZSGM4dE9Ua0hoUVRCWUlIV2NP?=
 =?utf-8?B?NC9GUllRR1VLdVZSNENROHhOK0xVM2RKSHRWUytjcWQvMUNLMWtpRFBRK0tz?=
 =?utf-8?B?cmVLRTA3VVF4dnpKQnJxT2dON3ZaNmltZFhhOCtxdGxRa00wUEE3Y3lGM1NK?=
 =?utf-8?B?VWdPRVlFY2Nzdis5SkJGTFJtTjlBTUNXQ0dkUitHSTJCQ0NXaUtTQnZIeFJ4?=
 =?utf-8?B?S3Nmb0Q4ajR6K3BNUGl1dWxFbGZuTEp6bFNyS3RLZ2pCbUZVVGpYVm50NE4x?=
 =?utf-8?B?YVpBZU10SzVyUWgwNHRrYzAxYnp1Z2JXbzE4N20zWjRyTmhjNW4zaGczaVpF?=
 =?utf-8?B?WG5xdys0SHl5SXZLaU9QdE5wN2RSYlZ3QUNtRG9wOHNWNjFtV3JCNGx5THlL?=
 =?utf-8?B?am9nbDRKbTFZTERmLzRsVHVxWTloeWZkOHU0aUdRQ2taWkNIQm5OVVZzbXdS?=
 =?utf-8?B?czNhNUZDc2JuRHd6M0xNVzRQeVRpRjhCMjVBOStiUytHWFdhaE0vZ0dKSWRK?=
 =?utf-8?B?di8xbmpsM0dsVVhjSklwWEFta3lhdkx4U08xZS8yYVlackFwTWhpMU5QNEJQ?=
 =?utf-8?B?L1FPVEgwZlp4Ky9vS2drbXZlNitCcDZYSjN0cGFhQ0xLaEFIQVo3WFRNcGdY?=
 =?utf-8?B?WlcrcVo2RWVYZmhmM2pmUkRNS01jUWYwa09uTGVrY3VTR2lMWE9TTmpHMzYw?=
 =?utf-8?B?amVxNkV3RTQvUjQzYjVzVmhpWG1sVTFlTTZFZXE2N05ZblJPTS9KcGFXclNh?=
 =?utf-8?B?NlVEbjNGNU4yL0hzRmpDc1RCU3N2TDdGZ1ZBMnc2dUhmS0Rhc09iRHIzbmFl?=
 =?utf-8?B?dE9yc1pLS0xYN2dkUVhRWUltamVET3NpZThZdHoxSDJLZzNLNUdjaFdkNVdP?=
 =?utf-8?B?WTBFcDQ5Z1ZnWmVEMml1Qlo0ZEJTRlBKOGE1QjF6MTlXWDB3NlVNLzlCVGpi?=
 =?utf-8?B?MUY5QkJEa2YvU2pMcCtnWFRHOVdtSENIV3BLVFBqUCtGWHlLMHJRRE81dllq?=
 =?utf-8?B?enNibnpVQ3d4elZ1MkVDVmUvZ2JickFyaUtMcW5qaklHcWNsR0J4ZVo0QUkr?=
 =?utf-8?B?UkVNcDVqTHhYMDFselMxSzVqTjdmMWthVitoa3p2Vzl0TmRhbTlFbjRPTEdJ?=
 =?utf-8?B?bkF4OHY2MjV0YTNDQzJiOTh3WEw3V0VuSHBwVzlrV0ExZXh2N3pzNFBuZ0Ez?=
 =?utf-8?B?SEZlR1ZmU05JbnFjNlB6ZGplR2ZCRVBoMndUdTN3Q1hBUnljWkZmQkU1VUho?=
 =?utf-8?B?T3BIdmM1SElZeGozaVVUQjQvUjJZVEhzeUNOM2RiT25EbDM4V0NFSlNWemRD?=
 =?utf-8?B?WGE2YUlHK2tSMFRpYjZ5OC9oTzYvRE90ZnlsS0s3SmZLV3I3ZXhIakFPS0li?=
 =?utf-8?B?eUc4N1BiUzNUZEQzdlNLMkM4TndXYTVhSWRwN0FoaDVJSDV3NHJlcjdsekpm?=
 =?utf-8?B?bXd2QXB0anZEMmMxcXVlMkU2WitQdDA0S0pQK3hsUlhrTksreEtaNW5Gc3JC?=
 =?utf-8?B?TVNzRVhkUmNlMHo3WHUrcFQxSVFJSHdyem1KMXpBN053dmU5NDBFTG1GZW9X?=
 =?utf-8?B?WjBoeStTa3J3UUdNcm5rTWdGRHA5L3BDc3ZoZTZocktiSXpTeUZRbHJwQjk3?=
 =?utf-8?B?WkovTlVleW5ibWhkUDZmTDlmZzJVUXBPbHAySWZCTlgzMEZJQ2FSMTlGak03?=
 =?utf-8?B?WUNYdXFzRmJQZ0hya2s2WFhJREs4SEl5WGwvY2tOYWlCalhGR0gzZm5DUWRx?=
 =?utf-8?B?bThYR0RUcW5Eeit2QWRUdUFvUW5jNVVsWGZIN0E1Wi9nZjU1WSt5My9Zd2tx?=
 =?utf-8?B?ckRRcStyMWlZaDZTV3BtdmxVeDdNV0Q0T3BoaW05N1hIY2R3cGp5cHEvWFdp?=
 =?utf-8?B?UzRqV0t4M3BsYldYMjF5R08zUjZsYUZkc0I2NGZPU3p0NnNQa1A5QzR0c3ZH?=
 =?utf-8?B?dWdUVXhJOERzY1h0Yy9saVVHRy9rWUZjekxiQys5cVV4d0R2MlZJNkJ4SWZv?=
 =?utf-8?B?ZGdaMW84NzIrQk1rOEVxQkttQnVCWE5LWlI4Z1ROOUhDQ1RRKzJFeU1vZE9D?=
 =?utf-8?B?UEVERSt0ZncrLzNtMWRrMElyWWtvWGp0WnVHWjBEQ0hISVZ5elpYMTdaUHUv?=
 =?utf-8?Q?XpE3rmCthsXpUQXV2rWCWj7x5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7f9cfb-220f-44c9-e2bb-08daff9f1449
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 13:13:13.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRatveSsgmoczf4RSS2cM1PSxLFrdn+RKsWFQL5hcNut3oGKKxBXC46j4p3dCAK69OyNfN3Lm24vz7WIzxhPlXwH94tZS4bZ/2M2UllQJ58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPiBJIGhhdGUgdGhlIHRlcm0gImhhcmRlbmluZyIuICBQbGVhc2UganVzdCBzYXkgaXQg
Zm9yIHdoYXQgaXQgcmVhbGx5IGlzLA0KPiA+ID4gImZpeGluZyBidWdzIHRvIGhhbmRsZSBicm9r
ZW4gaGFyZHdhcmUiLiAgV2UndmUgZG9uZSB0aGF0IGZvciB5ZWFycyB3aGVuDQo+ID4gPiBkZWFs
aW5nIHdpdGggUENJIGFuZCBVU0IgYW5kIGV2ZW4gQ1BVcyBkb2luZyB0aGluZ3MgdGhhdCB0aGV5
IHNob3VsZG4ndA0KPiA+ID4gYmUgZG9pbmcuICBIb3cgaXMgdGhpcyBhbnkgZGlmZmVyZW50IGlu
IHRoZSBlbmQ/DQo+ID4gPg0KPiA+ID4gU28gd2hhdCB5b3UgYWxzbyBhcmUgc2F5aW5nIGhlcmUg
bm93IGlzICJ3ZSBkbyBub3QgdHJ1c3QgYW55IFBDSQ0KPiA+ID4gZGV2aWNlcyIsIHNvIHBsZWFz
ZSBqdXN0IHNheSB0aGF0ICh3aHkgZG8geW91IHRydXN0IFVTQiBkZXZpY2VzPykgIElmDQo+ID4g
PiB0aGF0IGlzIHNvbWV0aGluZyB0aGF0IHlvdSBhbGwgdGhpbmsgdGhhdCBMaW51eCBzaG91bGQg
c3VwcG9ydCwgdGhlbg0KPiA+ID4gbGV0J3MgZ28gZnJvbSB0aGVyZS4NCj4gPg0KPiA+IEkgZG9u
J3QgdGhpbmsgZ2VuZXJhbGx5IGFsbCBQQ0kgZGV2aWNlIGRyaXZlcnMgZ3VhcmQgYWdhaW5zdCBh
bGwgdGhlDQo+ID4gbmFzdHkgdGhpbmdzIHRoYXQgYSBicm9rZW4gaW1wbGVtZW50YXRpb24gb2Yg
dGhlaXIgaGFyZHdhcmUgY2FuIGRvLg0KPiANCj4gSSBrbm93IHRoYXQgYWxsIFBDSSBkcml2ZXJz
IGNhbiBOT1QgZG8gdGhhdCB0b2RheSBhcyB0aGF0IHdhcyBuZXZlcg0KPiBhbnl0aGluZyB0aGF0
IExpbnV4IHdhcyBkZXNpZ25lZCBmb3IuDQo+IA0KPiA+IFRoZSBVU0IgZGV2aWNlcyBhcmUgcHJv
YmFibHkgYSBiaXQgYmV0dGVyLCBiZWNhdXNlIHRoZXkgYWN0dWFsbHkgd29ycnkNCj4gPiBhYm91
dCBwZW9wbGUgd2Fsa2luZyB1cCB3aXRoIGEgbmFzdHkgSElEIGRldmljZTsgIEknbSBza2VwdGlj
YWwgdGhhdA0KPiA+IGEga2VybmVsIHdvdWxkIHN1cnZpdmUgYSBwdXJwb3NlbHkgYnJva2VuIFVT
QiBjb250cm9sbGVyLg0KPiANCj4gSSBhZ3JlZSB3aXRoIHlvdSB0aGVyZSwgVVNCIGRyaXZlcnMg
YXJlIG9ubHkgc3RhcnRpbmcgdG8gYmUgZnV6emVkIGF0DQo+IHRoZSBkZXNjcmlwdG9yIGxldmVs
LCB0aGF0J3MgYWxsLiAgV2hpY2ggaXMgd2h5IHRoZXkgdG9vIGNhbiBiZSBwdXQgaW50bw0KPiB0
aGUgInVudHJ1c3RlZCIgYXJlYSB1bnRpbCB5b3UgdHJ1c3QgdGhlbS4NCj4gDQo+ID4gSSdtIG5v
dCBzdXJlIHRoZSByZXF1ZXN0IGhlcmUgaXNuJ3QgcmVhbGx5IHRvIG1ha2Ugc3VyZSAqYWxsKiBQ
Q0kgZGV2aWNlcw0KPiA+IGFyZSBzYWZlOyBqdXN0IHRoZSBvbmVzIHdlIGNhcmUgYWJvdXQgaW4g
YSBDb0NvIGd1ZXN0IChlLmcuIHRoZSB2aXJ0dWFsIGRldmljZXMpIC0NCj4gPiBhbmQgcG90ZW50
aWFsbHkgb25lcyB0aGF0IHBlb3BsZSB3aWxsIHdhbnQgdG8gcGFzcy10aHJvdWdoICh3aGljaA0K
PiA+IGdlbmVyYWxseSBuZWVkcyBhIGxvdCBtb3JlIHdvcmsgdG8gbWFrZSBzYWZlKS4NCj4gPiAo
SSd2ZSBub3QgbG9va2VkIGF0IHRoZXNlIEludGVsIHRvb2xzIHRvIHNlZSB3aGF0IHRoZXkgY292
ZXIpDQo+IA0KPiBXaHkgbm90IGp1c3QgY3JlYXRlIGEgd2hvbGUgbmV3IGJ1cyBwYXRoIGZvciB0
aGVzZSAidHJ1c3RlZCIgZGV2aWNlcyB0bw0KPiBhdHRhY2ggdG8gYW5kIGRvIHRoYXQgaW5zdGVh
ZCBvZiB0eXJpbmcgdG8gZW11bGF0ZSBhIHByb3RvY29sIHRoYXQgd2FzDQo+IGV4cGxpY2l0bHkg
ZGVzaWduZWQgTk9UIHRvIHRoaXMgbW9kZWwgYXQgYWxsPyAgV2h5IGFyZSB5b3UgdHJ5aW5nIHRv
DQo+IHNob2Vob3JuIHNvbWV0aGluZyBoZXJlIGFuZCBub3QganVzdCBkZXNpZ25pbmcgaXQgcHJv
cGVybHkgZnJvbSB0aGUNCj4gYmVnaW5uaW5nPw0KPiANCj4gPiBIYXZpbmcgc2FpZCB0aGF0LCBo
b3cgaGFwcHkgYXJlIHlvdSB3aXRoIFRodW5kZXJib2x0IFBDSSBkZXZpY2VzIGJlaW5nDQo+ID4g
cGx1Z2dlZCBpbnRvIHlvdXIgbGFwdG9wIG9yIGludG8gdGhlIGhvdHBsdWcgTlZNZSBzbG90IG9u
IGEgc2VydmVyPw0KPiANCj4gV2UgaGF2ZSBwcm90ZWN0aW9uIGZvciB0aGF0LCBhbmQgaGF2ZSBo
YWQgaXQgZm9yIG1hbnkgeWVhcnMuICBTYW1lIGZvcg0KPiBVU0IgZGV2aWNlcy4gIFRoaXMgaXNu
J3QgbmV3LCBwZXJoYXBzIHlvdSBhbGwgaGF2ZSBub3Qgbm90aWNlZCB0aG9zZQ0KPiBmZWF0dXJl
cyBiZSBhZGRlZCBhbmQgdGFrZW4gYWR2YW50YWdlIG9mIGFscmVhZHkgYnkgbWFueSBMaW51eCBk
aXN0cm9zDQo+IGFuZCBzeXN0ZW0gaW1hZ2VzIChpLmUuIENocm9tZU9TIGFuZCBlbWJlZGRlZCBz
eXN0ZW1zPykNCj4gDQo+ID4gV2UncmUgbm93IGluIHRoZSBwb3NpdGlvbiB3ZSB3ZXJlIHdpdGgg
cmFuZG9tIFVTQiBkZXZpY2VzIHllYXJzIGFnby4NCj4gDQo+IE5vcGUsIHdlIGFyZSBub3QsIGFn
YWluLCB3ZSBhbHJlYWR5IGhhbmRsZSByYW5kb20gUENJIGRldmljZXMgYmVpbmcNCj4gcGx1Z2dl
ZCBpbi4gIEl0J3MgdXAgdG8gdXNlcnNwYWNlIHRvIG1ha2UgdGhlIHBvbGljeSBkZWNpc2lvbiBp
ZiBpdA0KPiBzaG91bGQgYmUgdHJ1c3RlZCBvciBub3QgYmVmb3JlIHRoZSBrZXJuZWwgaGFzIGFj
Y2VzcyB0byBpdC4NCj4gDQo+IFNvIGEgbWV0YS1jb21tZW50LCB3aHkgbm90IGp1c3QgdXNlIHRo
YXQgdG9kYXk/ICBJZiB5b3VyIGd1ZXN0IE9TIGNhbg0KPiBub3QgYXV0aGVudGljYXRlIHRoZSBQ
Q0kgZGV2aWNlIHBhc3NlZCB0byBpdCwgZG9uJ3QgYWxsb3cgdGhlIGtlcm5lbCB0bw0KPiBiaW5k
IHRvIGl0LiAgSWYgaXQgY2FuIGJlIGF1dGhlbnRpY2F0ZWQsIHdvbmRlcmZ1bCwgYmluZCBhd2F5
ISAgWW91IGNhbg0KPiBkbyB0aGlzIHRvZGF5IHdpdGggbm8ga2VybmVsIGNoYW5nZXMgbmVlZGVk
Lg0KPiANCj4gPiBBbHNvIHdlIHdvdWxkIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgYW55IGNvbmZp
ZyBkYXRhIHRoYXQgdGhlIGh5cGVydmlzb3INCj4gPiBjYW4gcGFzcyB0byB0aGUgZ3Vlc3QgaXMg
dmFsaWRhdGVkLg0KPiANCj4gRGVmaW5lICJ2YWxpZGF0ZWQiIHBsZWFzZS4NCj4gDQo+ID4gVGhl
IHByb2JsZW0gc2VlbXMgcmVhc29uYWJseSB3ZWxsIHVuZGVyc3Rvb2Qgd2l0aGluIHRoZSBDb0Nv
IHdvcmxkIC0gaG93DQo+ID4gZmFyIHBlb3BsZSB3YW50IHRvIHB1c2ggaXQgcHJvYmFibHkgdmFy
aWVzOyBidXQgaXQncyBnb29kIHRvIG1ha2UgdGhlDQo+ID4gcHJvYmxlbSBtb3JlIHdpZGVseSB1
bmRlcnN0b29kLg0KPiANCj4gVGhlICJDb0NvIiB3b3JsZCBzZWVtcyBkaXN0YW50IGFuZCBzZXBh
cmF0ZSBmcm9tIHRoZSByZWFsLXdvcmxkIG9mIExpbnV4DQo+IGtlcm5lbCBkZXZlbG9wbWVudCBp
ZiB5b3UgYWxsIGRvIG5vdCBldmVuIGtub3cgYWJvdXQgdGhlIGF1dGhlbnRpY2F0aW9uDQo+IG1l
dGhvZHMgdGhhdCB3ZSBoYXZlIGZvciB5ZWFycyBmb3IgZW5hYmxpbmcgYWNjZXNzIHRvIFBDSSBh
bmQgVVNCDQo+IGRldmljZXMgYXMgZGVzY3JpYmVkIGFib3ZlLiAgSWYgdGhlIGltcGVtZW50YXRp
b25zIHRoYXQgd2UgY3VycmVudGx5DQo+IGhhdmUgYXJlIGxhY2tpbmcgaW4gc29tZSB3YXksIHdv
bmRlcmZ1bCwgcGxlYXNlIHN1Ym1pdCBjaGFuZ2VzIGZvciB0aGVtDQo+IGFuZCB3ZSB3aWxsIGJl
IGdsYWQgdG8gcmV2aWV3IHRoZW0gYXMgbmVlZGVkLg0KDQpXZSBhcmUgYXdhcmUgb2YgVVNCL1Ro
dW5kZXJib2x0IGF1dGhvcml6YXRpb24gZnJhbWV3b3JrIGFuZCB0aGlzIGlzIHdoYXQgd2UgaGF2
ZQ0KYmVlbiBleHRlbmRpbmcgbm93IGZvciB0aGUgb3VyIENDIHVzYWdlIGluIG9yZGVyIHRvIGFw
cGx5IHRoaXMgdG8gYWxsIGRldmljZXMuDQpUaGUgcGF0Y2hlcyBhcmUgY3VycmVudGx5IHVuZGVy
IHRlc3RpbmcvcG9saXNoaW5nLCBidXQgd2Ugd2lsbCBiZSBzdWJtaXR0aW5nDQp0aGVtIGluIHRo
ZSBuZWFyIGZ1dHVyZS4gDQoNClRoYXQncyBzYWlkIGV2ZW4gd2l0aCB0aGUgYWJvdmUgaW4gcGxh
Y2Ugd2UgZG9u4oCZdCBnZXQgYSBwcm90ZWN0aW9uIGZyb20gYSBtYW4taW4tDQp0aGUtbWlkZGxl
IGF0dGFja3MgdGhhdCBhcmUgcG9zc2libGUgYnkgdW50cnVzdGVkIGh5cGVydmlzb3Igb3IgaG9z
dC4gSW4gb3JkZXINCnRvIGdldCBhIGZ1bGwgcHJvdGVjdGlvbiBoZXJlLCB3ZSBuZWVkIGFuIGF0
dGVzdGF0aW9uIGFuZCBlbmQtdG8tZW5kIHNlY3VyZSBjaGFubmVsDQpiZXR3ZWVuIGRldmljZXMg
YW5kIENDIGd1ZXN0LiBIb3dldmVyLCBzaW5jZSBpdCBpcyBnb2luZyB0byB0YWtlIGEgbG9uZyB0
aW1lIGJlZm9yZQ0Kd2UgaGF2ZSBhbGwgdGhlIGluZnJhc3RydWN0dXJlIGluIHBsYWNlIGluIExp
bnV4LCBhcyB3ZWxsIGFzIGRldmljZXMgdGhhdCBhcmUgY2FwYWJsZSBvZg0Kc3VwcG9ydGluZyBh
bGwgcmVxdWlyZWQgZnVuY3Rpb25hbGl0eSAoYW5kIHNvbWUgZGV2aWNlcyB3aWxsIG5ldmVyIGhh
dmUgdGhpcyBzdXBwb3J0IHN1Y2gNCmFzIHZpcnR1YWwgZGV2aWNlcyksIHdlIG5lZWQgdG8gaGF2
ZSBhIHJlYXNvbmFibGUgc2VjdXJpdHkgbW9kZWwgbm93LCB2cyB3YWl0aW5nIA0KdW50aWwgcmVz
ZWFyY2hlcnMgYXJlIHN0YXJ0aW5nIHRvIHBvc3QgdGhlIHByb29mLW9mLWNvbmNlcHQgcHJpdmls
ZWdlIGVzY2FsYXRpb24gZXhwbG9pdHMNCm9uIHNtdGggdGhhdCBpcyBldmVuICh0aGFua3MgdG8g
dGhlIHRvb2xzIHdlIGNyZWF0ZWQgaW4gaW4gWzFdKSBub3Qgc28gaGFyZCB0byBmaW5kOg0KeW91
IHJ1biBvdXIgZnV6emluZyAgdG9vbHMgb24gdGhlIGd1ZXN0IGtlcm5lbCB0cmVlIG9mIHlvdXIg
bGlraW5nIGFuZCBpdCBnaXZlcyB5b3UgYSBuaWNlIHNldA0Kb2YgS0FTQU4gaXNzdWVzIHRvIHBs
YXkgd2l0aC4gV2hhdCB3ZSBhcmUgdHJ5aW5nIHRvIGRvIGlzIHRvIGFkZHJlc3MgdGhlc2UgZmlu
ZGluZ3MgKGFtb25nDQpvdGhlciB0aGluZ3MpIGZvciBhIG1vcmUgcm9idXN0IGd1ZXN0IGtlcm5l
bC4NCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmENCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRl
bC9jY2MtbGludXgtZ3Vlc3QtaGFyZGVuaW5nDQogDQoNCg0KDQo=
