Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341DC5B3D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiIIQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIIQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:33:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C939E104
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662741228; x=1694277228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hgpzT+B6iPK6YsDolrLja9Wu6tYS2eKHzAly4B0vF98=;
  b=Vc5PQQAjdKrGOuE36XDIMo/Ejjh4ikFXphsoGMgULuUi6fS8MK4XwfW/
   bOr2I6I/NJSjFPSb0woMxe+OPWXpSu/lXLTMxkTKlurfn1oEOJHrms1Kb
   A5V5d3Bkqm4eUCZOGl011tbKgNwVl9+Bj/mgpLfqq3tyb5Ru6y02IYMN4
   QwWg1p49mIEUZIcyW2GG+agJp4qqyRsF+8NGVWTWxVzmMfMaEiq/vSBYR
   0nHZdGARpMYszTD8NLpM6GV6xGIFFjq0r9YdWVBKboub7NTQV/bAs0dAx
   44oXTOkBdTLsF3qyikYMS507mMcsyPPiHdionPB06Sq7C8LIG7AtQ+RvU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="359240908"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="359240908"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="683697151"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2022 09:33:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 09:33:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 09:33:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 09:33:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 09:33:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abKGTkpwpGPQyDj8cVdhOP2gy9ks0fOcsGttVUkt+LRvaJGYlHVSXU4TTu/jAM8BmcBSWo2ZTd79ZEM9GrkRNv2e+OxYSdyxFWOV8MuoEHWpeWlW7PoMOi9m6C49Qo2YyAz0+NsTa7MYW4hHB8FKdtVzQ9bxrKAmQILmwebZHIuop2sJfMxFaPWYja7c0p3/FgO+/Yy9xx6LBPo8CKntA1x2fDkWdDvazPWCF1xlX7DP2lFnH0p7U/Qi1jGC+47d+Hf61C30vLw6dBYsMtAkus1+YzfosAtn4j02wpthbh1VTKI/swrpQe2hLo6Wxwq1GYfnS8QrtKZp+W0rl3iwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgpzT+B6iPK6YsDolrLja9Wu6tYS2eKHzAly4B0vF98=;
 b=fUPbNZ+XHX0e2Dx1pZ9ly/L5uVQADS+End1d8YDXEusecyoRUjErL67HngFd8P02nwiQa3Xl1bTuj+sl1G/l6C/4PUkvP2i+38dG7DgG9xdLUiohnj1KkdzcDkqTJ8cHKmD8YxPWP1ZEiDHZ5nYe2D5piG1gNDClFipqO72H7iwoEu3ZxkTOItb7EWrgcTEyq2+8FwRP2BcWk/xgC3wFm/gugO+1mmuMIgT8ddOewhJY8BVmO72uLXdW6M/9U87Z5rgm4fDH5l8rlBrpL0C5QUM008f8mfnQupncgohA9MuKwOldgdkDn40STOP9TY9NM0dpr7BcAkwfK7rPZdn/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:33:45 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7ce8:1e4e:20d4:6bd4]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7ce8:1e4e:20d4:6bd4%9]) with mapi id 15.20.5588.016; Fri, 9 Sep 2022
 16:33:45 +0000
From:   "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
To:     "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/15] GSC support for XeHP SDV and DG2
Thread-Topic: [PATCH v7 00/15] GSC support for XeHP SDV and DG2
Thread-Index: AQHYqY/fN570njykhkuRY9XU7M76EK3K1nKAgAxDP4CAAFGgAIAAFWkA
Date:   Fri, 9 Sep 2022 16:33:45 +0000
Message-ID: <a3512279e0ebcd7c4d60926f118dbd435e0b7819.camel@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
         <YxDLFWjIllqqh9de@kroah.com>
         <166271909777.4265.10724483511179344068@jlahtine-mobl.ger.corp.intel.com>
         <b959d485-5986-4524-8a84-6086f1076cc5@intel.com>
In-Reply-To: <b959d485-5986-4524-8a84-6086f1076cc5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d823ee8-d9ef-45ea-aa2b-08da928110b6
x-ms-traffictypediagnostic: DM6PR11MB4563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9UftOrDGe2K2288BX6SofvswtyrflWivRAIkATdH5wYSJ/t4SPP08CmX+7b3s1b2Uh25bCDIdY1F2dIJxSbRxvIZsDOAByD0A5VmpA6xfiAXCorUcjMU+QDcuaqp3KRDOC/d2wLNnFmt25kTfTCkaqYZG7qLsLbZwPgDLHUyjFp4sTlD6Y80m19SwHdFClD4NRuGLRUJkMxEgA3xm48kCI0j1r2la/G+SvRHJFC8q2MVFr9CXyR3yiZ7UvHvrULHsXxT4YC82JeGbBRwQ7wWYPoaBwkVW4mn/1fHizuK1ZZ1HBHFTHnTeeQ5XQyS5cWHrCso+fwPCAc/FZwIKP6XHXqyhC61qGsWTacoueV/Ku4vB6P6NxyonEBhr//LgD7oUSnZyUJMboF3/RngvXNEi7J75pvFGEmP5MV5PP8+5btfqTuI7GvnZcD70F0LVrFVJwp43Rq7qu47yOk7YNrt5++OLhMQiU46NpTQdN3fG9fJDXjOuIx10zJmXdPrjgG5kBNozD9xNK8vOWOj9O2DDS31i0vPJPQoVM03gniPVr4oggc4XV5yDo83yaK8s7aTE8vPxPnbkwi2y+5SiMgyOUdOLwBcBIz3TBLr3qRfVwQommqn3BrjrKfiYoWgX4yEo6QYsrTlViOV9Y5hq+KmlqbiOpIrNUt7L2cZDOlV5k7wiEpyJTROrbXZc905XZxwIXE04+P6sr77FT2v+0Dqbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(396003)(376002)(136003)(38070700005)(122000001)(38100700002)(82960400001)(8676002)(76116006)(66946007)(66556008)(64756008)(4326008)(66446008)(91956017)(54906003)(66476007)(316002)(110136005)(2906002)(5660300002)(8936002)(2616005)(186003)(83380400001)(966005)(71200400001)(6486002)(478600001)(53546011)(6506007)(6512007)(26005)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2ZUTm52QUJNN1A4SFg5Zy9Ud0h0TUhEMWJIWjFEdEVxNU85eWZZalU0YVFH?=
 =?utf-8?B?aXREcDdvbU9hS3JwcXkwM0JTUjcveC83K2sxRDhpSSt6Y2FaWUF1UjdCRUw2?=
 =?utf-8?B?aDBySHJ5NzNkM2FJL0ZxbGVEbTZDNnp6V3ZnNG95QUpjYm94RVZtRTBaVXMy?=
 =?utf-8?B?eXBKSWVLRENwUzFMYTZIV3ZRdmUxUWYreGg3SjNQYTJ5eEMreUlXMlUwT1ow?=
 =?utf-8?B?dEJWc3hVWTFaQlVPcENHTkxJMmxjZXp1cjJFVlpkN3NJVlo4aEZzS2ZqekF5?=
 =?utf-8?B?eTlUcUZWUktINllBSFlxMXRrMjEzMGdLZTdTcGx3RWV4amx0aXNNcWIwUmgw?=
 =?utf-8?B?ZTlUdDZwdFRCclVlaW5SdlBoTFp1eC9yRjg0OVZQRTBCMmNNb0FUb3FRK29k?=
 =?utf-8?B?NE5keExiczNYNUNnRnIwem4wUnJrTS9HOVpJVjlDVWFvcHpmL3R6c0YwUktZ?=
 =?utf-8?B?K052ekFxajkyM01pdW9QSFR0L29adzU4NVEzSmNnTGE2MWZTVC9rd1U3VExy?=
 =?utf-8?B?VDRFUStTSStFejV0TDdtNTRleVdoWnlVWWRlRkEzL0tucGxWNHA1NnpOa0Ns?=
 =?utf-8?B?djhqNnQxaGt1MjBZZEFJdWtXZW1XcG9YU2ttZVVYKzdFS1Z0WmN2cU91aE1J?=
 =?utf-8?B?UmpnblpuSWF3bkxyRi80bkZBdkFwZ25VaDJXd2VlZHB2TTBnZDF4THRVZG4r?=
 =?utf-8?B?amdKNGE0R05ITXJZaU5PN21vRTJPMmNlWWp3UjVDTHZtS2dPRHRVRzhsU2Zi?=
 =?utf-8?B?Vjl3RmlIem1GOUtLYXQ1enplVSttSkNwN1E3SUxkM3BzSHVPbHRLRU5GaFFS?=
 =?utf-8?B?QUovajhjUDJ4UEFnS2Z4eXlFbDA1TXBKV3d3dkUvSmNzWi9PYlZMYm5DNTRC?=
 =?utf-8?B?c3FWbjh2ZXFNUEdNUzBtbVZyRGJwN3JBSHB2VmkwbjVJMlRveWpVclZRQmYv?=
 =?utf-8?B?VG9Rb1FhM1R3aVJpaVlqVkpSTVc3djcrZVhQSkFGVVF4SG9jZHd0VFJoQWFW?=
 =?utf-8?B?OFdkVm9NbWZzbjN3ekRiVDdMbHZKT3N5NHFJU0RsZVlDM3lOSnBYeDY2VFJT?=
 =?utf-8?B?RVVwcnRVOVYzZ0luUG56Qll6T051aCtWYVdVUHdEY0c3bHNhUk5mbkE0QjQy?=
 =?utf-8?B?cHIzY0l3MVlYTUxDa0VGSlBKdXRDNUNSZ1dxRnB3aE9TMWkzTEtjMzkrWERm?=
 =?utf-8?B?ZDNQQ284bjRiaWxGcUp1TWgzLzdtbjgvc1I4OGtOSlNtM1pnNm1hUHVFV1ZD?=
 =?utf-8?B?K0tuYzRCMFRJcjZqc0ZHakFKU1dPTjZ0SmtYZjFMNUIxWHA3WU5vRUs5TkR2?=
 =?utf-8?B?RVRjZXZONFE5Tk5seXcvU0xjNzlua29oeTJKUEdveS9ZLzZ5amJsODhrd3pL?=
 =?utf-8?B?YzNKUFR2R1FwbUZGMVhILzZxZUZwTDRmWkRNMFNpS3NGbERjN0VyenY1K0gx?=
 =?utf-8?B?OHF0T09heVJUWUxaeTZvSHVxcWlUWXg3ODU1MmVLRnovZ2lxRjBkakFvODRT?=
 =?utf-8?B?MXNYdGE3MDl0anBCc1ZGM2I1QkNpc2VwNWNDU2pmZUUxWGlqcng3SytNQjF1?=
 =?utf-8?B?N2lNUWtKVVRTMmloZmgwVjZNck9YUldBMExFSnZmZ3NGUTQxNWRoWVd6cjFE?=
 =?utf-8?B?SVVCbHdEalhRTzRlOXVkS0gzenpyb1NPb2Q0V0ZTRWJBS0hMbmkzYndpbzhJ?=
 =?utf-8?B?UUpPeHNJMHJwN2N0bHk4OFhmVXY5TGFRQXhFV2xUbC9PNjU5SnhlNW9WWDBS?=
 =?utf-8?B?VnIzemtxMXFwcmwvbndaeGpVRFQ0UUlwTEVsV1dGOVhOTkwvcXZxVW9aakFH?=
 =?utf-8?B?cEhWL3piTkxvWU5YblhnSnRUTStwMG5aOXNJbGFPMVdJMmc0bTlDcG5SYzk0?=
 =?utf-8?B?b1dWZFRKSDcyR2IxTW03M1RBOS9TYTR5TVg2elNYTDY4SmtaTHMxUm9FT2R1?=
 =?utf-8?B?UXZ2ZmhvSXFveVVybGQvREY4V25QQjIxK3RZQXo5b1hFL0d3ck5lVU5Hd2FI?=
 =?utf-8?B?QXBMZFpNdTdKaFBnd29qL0UvaUplbjVFUzloSkVaZE1nVWZxS3B3bEVXRDM0?=
 =?utf-8?B?WUhYa2lvWStyVFZ3QUF1MVM2UTNOZENNdVM0aTYycHFyUjRSbjA2WHM1R2xQ?=
 =?utf-8?B?U2daQThaNFFYei81VWJaVkZuOVNTbFV4NW0xMlNvN0U3LzA3WDBEcG9TTjZZ?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3164A4B38820704898B20FC9298FF319@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d823ee8-d9ef-45ea-aa2b-08da928110b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 16:33:45.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmnUUBc94AWMMbQNUoFYTnEcDyQWC23tXdxPCJWRHYghUNbobL+DLBtblXRnu0lkI0j5D3gbQiJc+iELmvLvGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
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

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDA4OjE3IC0wNzAwLCBDZXJhb2xvIFNwdXJpbywgRGFuaWVs
ZSB3cm90ZToNCj4gDQo+IA0KPiBPbiA5LzkvMjAyMiAzOjI0IEFNLCBKb29uYXMgTGFodGluZW4g
d3JvdGU6DQo+ID4gRGF2ZSwgZG8geW91IGhhdmUgYSBwcmVmZXJlbmNlIGhvdyB0byBkZWFsIHdp
dGggdGhlIG1pc2hhcCBoZXJlLA0KPiA+IHNoYWxsIEkgZG8gYQ0KPiA+IGZvcmNlLXB1c2ggdG8g
ZHJtLWludGVsLWd0LW5leHQgdG8gY29ycmVjdGx5IHJlY29yZCB0aGUgQWNrZWQtYnkgb3INCj4g
PiByZXZlcnQgYW5kDQo+ID4gcmUtcHVzaD8gT3IganVzdCBsZWF2ZSBpdCBhcyBpcz8NCg0KRGF2
ZSBhbmQgRGFuaWVsLCB0aGlzIHF1ZXN0aW9uIGlzIHN0aWxsIHBlcnRpbmVudC4NCg0KPiA+IA0K
PiA+IFF1b3RpbmcgR3JlZyBLcm9haC1IYXJ0bWFuICgyMDIyLTA5LTAxIDE4OjA5OjA5KQ0KPiA+
ID4gT24gU2F0LCBBdWcgMDYsIDIwMjIgYXQgMDM6MjY6MjFQTSArMDMwMCwgVG9tYXMgV2lua2xl
ciB3cm90ZToNCj4gPiA+ID4gQWRkIEdTQyBzdXBwb3J0IGZvciBYZUhQIFNEViBhbmQgREcyIHBs
YXRmb3Jtcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBzZXJpZXMgaW5jbHVkZXMgY2hhbmdlcyBm
b3IgdGhlIG1laSBkcml2ZXI6DQo+ID4gPiA+IC0gYWRkIGFiaWxpdHkgdG8gdXNlIHBvbGxpbmcg
aW5zdGVhZCBvZiBpbnRlcnJ1cHRzDQo+ID4gPiA+IC0gYWRkIGFiaWxpdHkgdG8gdXNlIGV4dGVu
ZGVkIHRpbWVvdXRzDQo+ID4gPiA+IC0gc2V0dXAgZXh0ZW5kZWQgb3BlcmF0aW9uYWwgbWVtb3J5
IGZvciBHU0MNCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBzZXJpZXMgaW5jbHVkZXMgY2hhbmdlcyBm
b3IgdGhlIGk5MTUgZHJpdmVyOg0KPiA+ID4gPiAtIGFsbG9jYXRlIGV4dGVuZGVkIG9wZXJhdGlv
bmFsIG1lbW9yeSBmb3IgR1NDDQo+ID4gPiA+IC0gR1NDIG9uIFhlSFAgU0RWIG9mZnNldHMgYW5k
IGRlZmluaXRpb25zDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBhdGNoIHNldCBzaG91bGQgYmUg
bWVyZ2VkIHZpYSBnZnggdHJlZSBhcw0KPiA+ID4gPiB0aGUgYXV4aWxpYXJ5IGRldmljZSBiZWxv
bmdzIHRoZXJlLg0KPiA+ID4gPiBHcmVnLCB5b3VyIEFDSyBpcyByZXF1aXJlZCBmb3IgdGhlIGRy
aXZlcy9taXNjL21laSBjb2RlIGJhc2UsDQo+ID4gPiA+IHBsZWFzZSByZXZpZXcgdGhlIHBhdGNo
ZXMuDQo+ID4gPiBXaXRoIHRoZSBleGNlcHRpb24gdGhhdCB5b3UgYWxsIGRvbid0IGtub3cgd2hh
dCB5ZWFyIGl0IGlzOg0KPiA+ID4gDQo+ID4gPiBBY2tlZC1ieTogR3JlZyBLcm9haC1IYXJ0bWFu
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiBEYW5pZWxlLCB3aHkgd2VyZSB0aGUg
cGF0Y2hlcyBhcHBsaWVkIHdpdGhvdXQgdGhpcyBBLWI/DQo+IA0KPiBBcG9sb2dpZXMsIEkgdXN1
YWxseSByZWx5IG9uIGRpbSB0byBwaWNrIHVwIGFsbCB0aGUgY29ycmVjdCByLWJzIGFuZCANCj4g
YWNrcyBmcm9tIHRoZSBNTCBhbmQgdG8gd2FybiBtZSBpZiBzb21ldGhpbmcgaXMgbWlzc2luZywg
YW5kIEkgZGlkbid0DQo+IHJlYWxpemUgdGhhdCBpdCBoYWRuJ3QgYXV0b21hZ2ljYWxseSBwaWNr
ZWQgdXAgdGhlIGFjay4NCg0KSSB1bmRlcnN0YW5kIHRoZSBmZWVsaW5nLiBSZWNlbnRseSBJIG1l
cmdlZCBhIHBhdGNoIGZyb20gVmluYXkgcmVseWluZw0Kb24gcGF0Y2h3b3JrIHRvIGdldCB0aGUg
cmV2aWV3ZWQtYnkgYW5kIEkgZm9yZ290IHRvIGRvdWJsZSBjaGVjay4NCg0KZGltIHBpY2tzIHVw
IHRoZSAiTGluazoiLCBidXQgSSBkb24ndCBiZWxpZXZlIGl0IHBpY2tzIGFueSBhY2sgb3IgcnYt
Yg0KZnJvbSB0aGUgbWFpbGluZyBsaXN0LiBQYXRjaHdvcmsgZG9lcyBpZiB5b3UgdXNlIHB3Y2xp
ZW50IG9yIHNvbWV0aGluZw0KbGlrZSB0aGF0Lg0KDQpBbnl3YXksIGxlc3NvbiB0byBib3RoIG9m
IHVzIHRvIGFsd2F5cyBkb3VibGUtY2hlY2ssIHJlZ2FyZGxlc3MgdGhlDQp0b29sIHVzZWQuDQoN
Cj4gDQo+ID4gDQo+ID4gSSdtIGp1c3QgcHJlcGFyaW5nIHRoZSBkcm0taW50ZWwtZ3QtbmV4dCBw
dWxsIHJlcXVlc3QgYW5kIG5vdyBpdA0KPiA+IGFwcGVhcnMNCj4gPiBsaWtlIHdlJ3JlIHB1c2hp
bmcgYSBsb3Qgb2YgY29tbWl0cyBvdXRzaWRlIG9mIGRybSB3aXRob3V0IGFueQ0KPiA+IEFja3Mu
DQo+ID4gDQo+ID4gUGxlYXNlIHJlYWNoIG91dCB0byB0aGUgbWFpbnRhaW5lcnMgKmJlZm9yZSog
cHVzaGluZyBjb2RlIGZvciBvdGhlcg0KPiA+IHN1YnN5c3RlbXMuIFVubGVzcyB5b3UgZ2V0IGFu
IGV4cGxpY2l0IGFjayB0byBkbyBzbywgZG8gbm90IHB1c2gNCj4gPiBzdWNoDQo+ID4gY29kZS4N
Cj4gDQo+IEknbSBhc3N1bWluZyB5b3UgbWVhbiB0aGUgaTkxNSBtYWludGFpbmVycyBoZXJlLCBn
aXZlbiB0aGF0IHRoZXJlIGlzDQo+IGFuIA0KPiBhY2sgZnJvbSBHcmVnIGluIHRoaXMgZW1haWw/
IFJvZHJpZ28gd2FzIGluIHRoZSBsb29wIG9mIHVzIG5lZWRpbmcgdG8NCj4gbWVyZ2UgdGhpcyB2
aWEgZHJtLCBzbyBJIHRob3VnaHQgSSB3YXMgZ29vZCBvbiB0aGF0IHNpZGUuIEknbGwgbWFrZQ0K
PiBzdXJlIA0KPiB0byBoYXZlIGFuIGV4cGxpY2l0IGFjayBvbiB0aGUgTUwgbmV4dCB0aW1lICh3
aGljaCBpcyBjb21pbmcNCj4gcmVsYXRpdmVseSANCj4gc29vbiwgYmVjYXVzZSB0aGVyZSBhcmUg
c29tZSBtb3JlIG1laSBwYXRjaGVzIGluIHRoZSBERzIgSHVDIHNlcmllcykuDQoNClRoYXQncyBt
eSBmYXVsdCBpbmRlZWQuIEkgd2FzIGZvbGxvd2luZyB0aGUgbW92ZW1lbnQsIGJ1dCBJIGZhaWxl
ZA0KdG8gc3RlcCB1cCByaWdodCBhZnRlciBJIHNhdyBHcmVnJ3MgYWNrLg0KQWx0aG91Z2ggSSBh
bHNvIG5vdGljZWQgc29tZSByZS1zZW5kIGFuZCByZXZpZXdzIGluIHByb2dyZXNzIGV2ZW4NCmFm
dGVyIHRoZSBhY2ssIEkgc2hvdWxkIGhhZCBiZWVuIG1vcmUgYWN0aXZlIHRoZXJlLg0KDQpTb3Jy
eSwNClJvZHJpZ28uDQoNCj4gDQo+ID4gDQo+ID4gUXVvdGluZyBmcm9tIHRoZSBjb21taXR0ZXIg
Z3VpZGVsaW5lc1sxXSB0aGUgZmlyc3QgcnVsZSBpczoNCj4gPiAiT25seSBwdXNoIHBhdGNoZXMg
Y2hhbmdpbmcgZHJpdmVycy9ncHUvZHJtL2k5MTUuIg0KPiA+IA0KPiA+IEluIHRob3NlIGNhc2Vz
LCBwbGVhc2UgcGluZyBhIG1haW50YWluZXIgYW5kIGRvbid0IHJ1c2ggdGhpbmdzLg0KPiANCj4g
V2lsbCBkby4gQW5kIGFwb2xvZ2llcyBhZ2FpbiBmb3IgdGhlIG1pc3Rha2UuDQo+IA0KPiBEYW5p
ZWxlDQo+IA0KPiA+IFJlZ2FyZHMsIEpvb25hcw0KPiA+IA0KPiA+IFsxXSBodHRwczovL2RybS5w
YWdlcy5mcmVlZGVza3RvcC5vcmcvbWFpbnRhaW5lci10b29scy9jb21taXR0ZXItDQo+ID4gZHJt
LWludGVsLmh0bWwjaGlnaC1sZXZlbC1ndWlkZWxpbmVzDQo+ID4gDQo+IA0KDQo=
