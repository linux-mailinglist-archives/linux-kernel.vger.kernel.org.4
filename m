Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0B69C70B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBTIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBTIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:55:15 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3859013;
        Mon, 20 Feb 2023 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676883314; x=1708419314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6g4I7PYSjj3iI76KZhBWp5kUiVq7Grb4e0Y2kPh3Vj0=;
  b=T7gb7VkE5rbzjtnmuTjJyCbKSRIgW8k78PVSPnnjZ1PhHV1k/Q6rPvON
   wnsZoXTD1tMTHOqtScDhvtEPWCncjnq2lngOi93F+vaI2xWnVk0pH65vA
   ggy9a3VjkFKBmOxTHUK7Pgau0LZ6P8+QuLAqtGgnQM2WyVqVsinS0wb6H
   qPwZlXAVlFSpq3qK/WYAC3hVrZSti2eIpDGADdmmw+pcnGciMafvmFFTd
   xDmXGOd2ilo3CV6xMhuzT52MZF75xQHvi9O3VxnpetMv2C47K3gwwLJrd
   0g3t9+E5dWIAGkUOYzFLLx31lv3HXkSx0gEMasVlQUsL8wh6iYs7xq3m2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="394837076"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="394837076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 00:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="780575600"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="780575600"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2023 00:55:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 00:55:13 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 00:55:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 00:55:12 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 00:55:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsEkjg96kDO4NNPYy7WzKKjaJK0pQSaE4cikRYG1w19mPDcFVYl8hwAyCEyjfJ7mJSnUxR1A4781sGbkFiyRxGBbGKArFNHV7WFXbdwk0kB+AVVgRj6AoNX66D77GPpS2gQU6R1+bP+jZ9CQ1xyGqhSNwMCv7DeImWDj9+LDFPZQGb0KJnhttbZUy873JuDIITvvBYDoJqjF3yGEEO1NYOE8YqyFysvWzyHZlJXPoqK/H/3gd8NJye9+WYwWdjs+9I2xLhhjQrtp9wZtJ3MLGDreHK/AAGSkergqPZixTPEuI6arq759sy17g0e2wS22xA17yk4iGe0IqAUyGB64PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g4I7PYSjj3iI76KZhBWp5kUiVq7Grb4e0Y2kPh3Vj0=;
 b=cHoH4lRM7tE5XAJdCe/iMhNdT+zJbOnPrlTaKIqe16o9AOg1E3aLDOCcceXg0kVt+RKshkArK5+6HzOSjXLlRp0iqRJgZukF2AOdkMh8LiIdWG1oFXuCpSF7S/aFxivcIWxg16RBlwoI69eQALB6zNFWXecYgt379P+und9rw/G0puAgonijo2SbLvydG6jURFemTespPDI5GYug4OwwPaTvKUNnrEaelPogX0Unf0DdvkaGZlHqgZdujOwi9xVY9rRU69nSmx+80IvmVmklohUwMvqnvAr+Kv/SiUe51REVT9SLLyto5iXeU+Xt9LrhhpelBmwswCv4kfOofcc3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by SA1PR11MB5947.namprd11.prod.outlook.com (2603:10b6:806:23b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 08:55:10 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::83e4:5ad1:637e:5c7a]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::83e4:5ad1:637e:5c7a%6]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 08:55:10 +0000
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>
Subject: RE: [PATCH] softirq: wake up ktimer thread in softirq context
Thread-Topic: [PATCH] softirq: wake up ktimer thread in softirq context
Thread-Index: AQHZQvWDhurDThwZ3UuTeJyBtXbaVq7XiajA
Date:   Mon, 20 Feb 2023 08:55:09 +0000
Message-ID: <BN9PR11MB5370CFD46CA0A2E245AFBE04ECA49@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <Y++5ry75hEI2NWrK@linutronix.de>
In-Reply-To: <Y++5ry75hEI2NWrK@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|SA1PR11MB5947:EE_
x-ms-office365-filtering-correlation-id: 7e544ffe-a8f7-4fd7-f350-08db13202be6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CXYtWFwTTe88Ex0UmQco+8frcJXI7QOtSczpYQrWyknj0WECnjoTNL+OzFAtrehr7wVcCWbkqG3MGLa+hLd1o79GiJP8QksZ6uiaGDr4+jJcChtJHJTpEvhunFnVQQZo/nM9sjQ25pgaiJn4ce053p5yQZusptj3dtibj7cCKy6Jkrmnev88uXtgEA+xd1OVmE7F9ZfYDoeq9Xit52zqeWJ8/v0gurU2784OMTGEM551c6Wvu+y1hlSyahmMHZ4qYkfFkvMepcn6v/Ai+FU52zusKdFrTWAfzd+Sjj459DeIYeBfAScd3atrqes9EB9LEfqDDQqmKmiiTPUAGu/rKxw8XCw7nVrbQVobGCoKOeJobjnNglG1WkiaXFbzbmN49bHh8GwHw/g9fbXmWeSSL2PULBKupDzsDZHyUSymJVfRKuR4geURVIPTRcVfDxuo8zqucyxWbSs39KUzZhLgiAe27klqccnwOSqss8vzKEQHdGQLKwmpLhJBV5N6CaudZNAltSkUd9jSfo+h6fZzaXq329cyX1AeebYUT0I8Mas9FtGwqcJYxu2UI30HrFX+yyU44okHl4EpAyYQ6HHcnxSefQnWzw+GOIESWyPqSBqcQa3fEphbE3jTOblJeinSDJ4t3QcuR3CCbBqLMepjh11rqROhTyWLSAHQ6UmtD5QcbYsGMVGnX2X/GFpCOiK/iqDkdvNdo9DcAfg0v3XFYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(478600001)(54906003)(71200400001)(122000001)(38070700005)(82960400001)(38100700002)(86362001)(2906002)(33656002)(316002)(41300700001)(52536014)(8936002)(55016003)(6916009)(66476007)(8676002)(4326008)(66446008)(66556008)(64756008)(76116006)(66946007)(83380400001)(186003)(53546011)(6506007)(107886003)(5660300002)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEt4Y1hIb3lIc0x2dmx0T0JiUXFlcHRLeklzUUZYbTJ6RXRjaTd6MHEyVHpZ?=
 =?utf-8?B?NDlhM1ZQd1I3bkVxeWl2cC9VenpqMFJkWFMxR1hsdUd1VUxYL2dtZ2RLekRM?=
 =?utf-8?B?Uk1qemV6a3lsQWsxbm15NzNCb0h1bG14bnVGcjM2MzVLdW1GK2RJdU9yTnZP?=
 =?utf-8?B?WUwyN0pSaWRGQWJxK1B5Y28xQmphdkFzdENkZEZGMm12dFZsSlBUb2tSZDUw?=
 =?utf-8?B?NjNuR01jSzcvUlJBMTUzN2QxSGsxRXJCMTdkaXFPVmN1VytZWGZZaGlPaGRi?=
 =?utf-8?B?NWJYRGQ5QkNaMXRVUElObEd0K1I2SFIzb1V6MkhTbmxoa3dIdWRYUTNrQjhx?=
 =?utf-8?B?TW9jM3diTmpkM1NBeXpXTFhCZ2pEQkNMc1NHYkVrOVZPMFE5VXhqaDlhUmYx?=
 =?utf-8?B?ZWtUVXdBMWxBV0V0eVNyL2x0aE8zNWUyZDl2a0dnUjkxT21GeldwTmYwdXRJ?=
 =?utf-8?B?SGEvbnFBR1pNUkJoYU5SR3RlZHhJWXBsSEo1YWQrTGt5S3ozYjU3N3VEMk9T?=
 =?utf-8?B?aW9yQXRaQ1RlM2NTV0pNQ1Rxa3lTV1ZaSjZOZGR5T3grSmo4NmpuczJlaVZR?=
 =?utf-8?B?L0N4b0hWZXphNm1xOWNIOG4xVGErVElHcWwwQTYxd0ZwZ280d1lNWGtxSzJF?=
 =?utf-8?B?WGNRS3JYaXcvcVRIQmMweHlBUU9ZTkNpQUlWQ2JDSlZTeVNaZ3dka0hvNU8r?=
 =?utf-8?B?cUtaNkplTGJNWmQ2QyttMkVEU2g0WFJVQzFVS3Zud3RyN1Jvck1vazkyMkJr?=
 =?utf-8?B?Zmw3YW8zcVpsNk9xTVc5M2JOWXk5cHNvL3FsY3FjYk1qT3M2Y0ZmZ0hTVWwv?=
 =?utf-8?B?TVVBZWIyOU9JMEhZMGVib0RlMUNOMHZQQ3B4TUhKdU5zdE9sbVQxcG5Ya2I5?=
 =?utf-8?B?dVQwUWFBdzgwZWJMQ0VRWnJQcFZJYnErcnQzeldvUkVyUms0elR4TWkxKytW?=
 =?utf-8?B?VXMvT0dxbzlDaXB1eE1qK2NqYmZxZEdZVDFFLzJadnEzNy9hTGhJWDM5dWts?=
 =?utf-8?B?SU8xbzdtYldqV05lOEVDZUc1TFdUYjVRVFBMbDRidFpYQXlkN0RoNGdhbVRv?=
 =?utf-8?B?Y3VYOXgxTkI0SnJOQXI5VG9MQlB5ekNWQndNMDhqNHdxbSttUVI3R1ZmYUlv?=
 =?utf-8?B?N1JmVlF0VnU3Rkw0QjJpQ1I1SUZObDBiQnFsQ3ZRZ3h2R0lLUHZWUFFoV09m?=
 =?utf-8?B?ZzRUazFPTTl4L0tmemhKWU9DYkY4YlhSOEFxNE1pN0N3WWdIeTN2d0NPVStB?=
 =?utf-8?B?Z25FdWZmSWpyUzBYVkFpSE1JNDM3cGg5dmZHdm54bUluYjRpR3dXVmtoQ29J?=
 =?utf-8?B?cEdhTnMzVjFMVExoSEpnOS9YYkhHME1oem81aXlFN2g3dkoxZzFIc2FaRWtE?=
 =?utf-8?B?ZUFWcVpNNVRkRjRmZnA5ZVFpYUdJVGpNY3IwaTFHSEpYdHRjRHViYjhURmEw?=
 =?utf-8?B?NjdSTVJxVHJTT3piSmhBZlQybFdEd2F0eVYveW9XbEYxT2Flems5NTlMR3lQ?=
 =?utf-8?B?RXlaVE91OHFuMlVvZmUveFluaFQyZmZMYXEvcjRTL1AvWkpYcnlwRXRndDYr?=
 =?utf-8?B?dDNxelZOVW9LTk5zZnlrcUhKTXAxVWlad0lzdXZkeTc0anNLYVlxREdYSGpy?=
 =?utf-8?B?MXNRY2hLUm5DSDhSOEFjT0ZWSVRlZWg3b2Y2c01qbHdwaWhVYXhoekVNQ251?=
 =?utf-8?B?dzVtRkFlcHd0KzB3WjlaRGtMMHF5cDR6WFlxbUsvMlhGOHYrY3E5ZGx0eXAx?=
 =?utf-8?B?QlRqSXJ0WmNvdkpNcmtjdGpLTkR6VGpFaHMxdytsRGk5OTVnWG5DTzJYdTdZ?=
 =?utf-8?B?V3dhVWlFOHJPaE1Nc0JGVkp2NGZJYW14Tk1xaEh5aUVWb2FrdGF2MytISUlR?=
 =?utf-8?B?R2RDYldoMVVHemNKM0F6VWQwOXhkV21TeW1FZlp5cWR0eTJYbDg2bmhPVVls?=
 =?utf-8?B?anJaRkhVWlN0NVozNHBkdVB0WEhEdkxxUWJyZXZOYTdDTnVHVmQ5d0pCR01I?=
 =?utf-8?B?QktlQ2pYUjRpZ2pUNHBIczQyUEZOVmZTdXVOcEMwV1ROM0RyRFI1YmF3TTFv?=
 =?utf-8?B?RWVlT1BLdkZoTXpNY05FN09DSUxqOHpybjI0TzF6UHJCcXZmL3FhN3VPb2hI?=
 =?utf-8?Q?JxXA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e544ffe-a8f7-4fd7-f350-08db13202be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 08:55:09.9181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpoZSAq/KtsNb7D9foUDehjwApbi8Un29xLdFx/ABJQNBtkHD5uqLeYBmLJIdWawUP/C8Jx4pFYdLDQQBBNOhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciBoYW5kbGluZyB0aGlzLCBtb2RpZmllZCBwYXRjaCBsb29rcyBnb29kIHRv
IG1lLg0KDQpSZWdhcmRzLA0KSnVueGlhbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiAN
ClNlbnQ6IFNhdHVyZGF5LCBGZWJydWFyeSAxOCwgMjAyMyAxOjMwIEFNDQpUbzogQ2hhbmcsIEp1
bnhpYW8gPGp1bnhpYW8uY2hhbmdAaW50ZWwuY29tPg0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXJ0LXVzZXJzQHZnZXIua2VybmVsLm9yZzsgdGdseEBsaW51dHJvbml4
LmRlOyByb3N0ZWR0QGdvb2RtaXMub3JnOyBQZWgsIEhvY2sgWmhhbmcgPGhvY2suemhhbmcucGVo
QGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNvZnRpcnE6IHdha2UgdXAga3RpbWVy
IHRocmVhZCBpbiBzb2Z0aXJxIGNvbnRleHQNCg0KT24gMjAyMi0xMi0wOCAxNTo1NjowNCBbKzA4
MDBdLCBKdW54aWFvIENoYW5nIHdyb3RlOg0KPiBPY2NpYWlvbmFsbHkgdGltZXIgaW50ZXJydXB0
IG1pZ2h0IGJlIHRyaWdnZXJlZCBpbiBzb2Z0aXJxIGNvbnRleHQsIA0KPiBrdGltZXIgdGhyZWFk
IHNob3VsZCBiZSB3b2tlbiB1cCB3aXRoIFJUIGtlcm5lbCwgb3IgZWxzZSBrdGltZXIgdGhyZWFk
IA0KPiBtaWdodCBzdGF5IGluIHNsZWVwIHN0YXRlIGFsdGhvdWdoIHRpbWVyIGludGVycnVwdCBo
YXMgYmVlbiB0cmlnZ2VyZWQuDQo+IA0KPiBUaGlzIGNoYW5nZSBmaXhlcyBhIGxhdGVuY3kgaXNz
dWUgdGhhdCB0aW1lciBoYW5kbGVyIGlzIGRlbGF5ZWQgZm9yIA0KPiBtb3JlIHRoYW4gNG1zIGlu
IG5ldHdvcmsgcmVsYXRlZCB0ZXN0Lg0KDQpTb3JyeSBmb3Iga2VlcGluZyB5b3Ugd2FpdGluZy4g
WW91ciBvYnNlcnZhdGlvbiBhbmQgcGF0Y2ggaXMgY29ycmVjdC4gSSdtIGdvaW5nIHRvIGFwcGx5
IGEgc2xpZ2h0bHkgbW9kaWZpZWQgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggKHNlZSBiZWxvdykgYWZ0
ZXIgSSByZXdvcmRlZCB0aGUgY29tbWl0IG1lc3NhZ2Ugb24gTW9uZGF5Lg0KDQpkaWZmIC0tZ2l0
IGEva2VybmVsL3NvZnRpcnEuYyBiL2tlcm5lbC9zb2Z0aXJxLmMgaW5kZXggYWIxZmUzNDMyNmJh
Yi4uODJmM2U2OGZiZTIyMCAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zb2Z0aXJxLmMNCisrKyBiL2tl
cm5lbC9zb2Z0aXJxLmMNCkBAIC02NjQsMTMgKzY2NCwxMiBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
X19pcnFfZXhpdF9yY3Uodm9pZCkgICNlbmRpZg0KIAlhY2NvdW50X2hhcmRpcnFfZXhpdChjdXJy
ZW50KTsNCiAJcHJlZW1wdF9jb3VudF9zdWIoSEFSRElSUV9PRkZTRVQpOw0KLQlpZiAoIWluX2lu
dGVycnVwdCgpKSB7DQotCQlpZiAobG9jYWxfc29mdGlycV9wZW5kaW5nKCkpDQotCQkJaW52b2tl
X3NvZnRpcnEoKTsNCisJaWYgKCFpbl9pbnRlcnJ1cHQoKSAmJiBsb2NhbF9zb2Z0aXJxX3BlbmRp
bmcoKSkNCisJCWludm9rZV9zb2Z0aXJxKCk7DQogDQotCQlpZiAoSVNfRU5BQkxFRChDT05GSUdf
UFJFRU1QVF9SVCkgJiYgbG9jYWxfcGVuZGluZ190aW1lcnMoKSkNCi0JCQl3YWtlX3RpbWVyc2Qo
KTsNCi0JfQ0KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUFJFRU1QVF9SVCkgJiYgbG9jYWxfcGVu
ZGluZ190aW1lcnMoKSAmJg0KKwkgICAgIShpbl9ubWkoKSB8IGluX2hhcmRpcnEoKSkpDQorCQl3
YWtlX3RpbWVyc2QoKTsNCiANCiAJdGlja19pcnFfZXhpdCgpOw0KIH0NCg0KU2ViYXN0aWFuDQo=
