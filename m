Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523275B68D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIMHmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIMHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:42:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23AE2251F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663054949; x=1694590949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zm+ARdFd+fdOLAFo9lAec6JBs6tWf9TF8CzNg6UXsGM=;
  b=SgMASpghb8CqOo8TjupiMQfPGBUhkujElVfN73IFthF1a7dO7nBp7X73
   fHG+LQlngwHQuAReQ7UqUTI6h4OK5FqMMq/O9IU329V3L0o/IlXfzRoif
   kl9mDL+W95dPrSoujZm19A8fSwTf61thLX7gBJYdKhgfN5QKEXPRAxvPh
   zZsyPkW65Pse8zcNvGohYMWA9n6FIw/7n39MahLlm1W8TpF1oaiFGkwEp
   Csp25QuHY1yYIRCn7p3WTxKUM+8epAcwd9GdXHHJUPhSmXDwrmTQVwIrh
   gULHUobO2Ml8L5ORwu96O1/GWGxJPRH7jl8Xh7TYrBjyicYY65wT/U+Xp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298072008"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="298072008"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 00:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="649562457"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2022 00:42:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 00:42:28 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 00:42:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 13 Sep 2022 00:42:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 13 Sep 2022 00:42:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOAjL2GpjGPKP3AAqD/Lxcy8CcC9whCdcQ9Ex12bCSNmaakN1FxvMBwTqN8qvpPuR1dSx+UfzXxCau5XkZnlvqyL1r5wS7hM75aq/nuyG9sp2Hl5G4nDU/entY7stM4nJ1Fn1kwW4AdP6fv9WxSri8Gf+CnUnvS3l6OXf0y05/QeIu9gDOS2Z5a1scOwfnf0GXHgy9uIUJ+BMr5gEARBQeWNEEWVHAhvLRfStiLkwjuGQ1ytk/xJJo6vGnmuGNFD4c+0a7uyHINeE/utkZCWrMKfzq+p1PqFMpIQWQFD/MowaifFSj90uOC7UuQF6JXQmZf/gnPrVEmxVz4FWnktxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm+ARdFd+fdOLAFo9lAec6JBs6tWf9TF8CzNg6UXsGM=;
 b=VDEKEC3IFDAfwJfpbb2MF1BNqlRFdJfXt5oiXZwQk1tRcuqtLp+58ez2ThM2ICxkC/hQyPKJeBQXPFUl2oaIL4O0Tf+RB5pVmnTZrNtaiXkPdIRHSrhbIvS3yQ8PZq/90cyfxWjF/QK5sclsl2GoSlQy4zPqnRAmGUmF7qOhI9jFGUn90DVfk6bjKw7Q6D2H7cLgrjNaHxSOwXxNCYutw4x8wlWjMwEGxRN08EZeGbx6SjSi4xl5hPmGzFS/Q2kMQ7MWtrKbsx4VV37JNy7wlItcQU8ZiA324HiVdCHjnFQ5ndcFhmuHmzOX3nPxt3PTc7Xc62VHHY//ZBC7f7O6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 07:42:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 07:42:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Topic: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Thread-Index: AQHYxlL15aXn1csO5EOwQ10Vd62MPq3cr0MggAAwhICAABtcMA==
Date:   Tue, 13 Sep 2022 07:42:21 +0000
Message-ID: <BN9PR11MB5276B919C9E933088473224F8C479@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276B65B2EAF97D53719D2FE8C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <af6a3ae8-d4b2-517d-8b14-15dd20392a00@linux.intel.com>
In-Reply-To: <af6a3ae8-d4b2-517d-8b14-15dd20392a00@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV2PR11MB6045:EE_
x-ms-office365-filtering-correlation-id: 887d1c9a-8824-482d-1f1b-08da955b7dca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LLTHVoSspQPzvZx/m/9D7EMY78WSWdMuq5woJXK01Z057PFAa+6xEbV+ivYwEhasWlkT+fPoGXteTcCeCmaQhXD4Bo4rCBvxJDcSwp8BPWHf1/RcxZ6n4bg10ccxtC/b29fY1oQjaMLLZyOa1mNZJltC3hFKwcDWJEvZD9XTJFQ/SvbZwrceg1l3aJ/Bxq48ydJklUWeJLMN4dvrPcj3c8E7yVHLpG6vQjZHR1k6WbQzdtNOs0ZABsLQ6yPRoXYBfZkzeT4Fdu1BiitgCL0CX7mXh63f4voTETyIWVAXfzFt72HUqAuacD4M3JS9XgyeJlgguNHD5xaA0OjtNLF2YrZJovIwfcxS7OIy/2f6+YNQfKVUFxp5X05EDc4SZJcZgSi+P0kLGgUklpKWP/7FLBN01wGsxT4YxXuk4v1Lc04rV6w/8JdKbwSqaLem549jfrX4jIFRhv+N5JP6gS+1gjeDDb1Yezf1Xfp9KvzP9J7d2aSaDfO9PhaQU5NpUeZamQbBwLG3m6UO5+EskHDTq9+F1wEkskR+eXShoBd72f9/KeVHepKc0fWJr2LccSOIJKuSN/o2JCqlttfO9b3FiNORtQwJ1KNJR7j1r9fcArc96fzSJ7qI6pzN2REBcHxypR2uBhg41mWhS0Znm8oPTcXbsLGMOOuaZdm1ehhzWbV086J12EgdKD9qT7L9aJWUYKbT30amKhvNpiLw1WvchO23PugA6Gr7O6WUyN2OS8zFn/8rPEqhlVXv7EI5SfyGwiu3ZKceg3bgj35xUuW3MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199015)(55016003)(53546011)(7696005)(9686003)(33656002)(5660300002)(76116006)(66476007)(6506007)(38070700005)(66946007)(110136005)(82960400001)(2906002)(66556008)(478600001)(316002)(54906003)(64756008)(66446008)(52536014)(4326008)(26005)(86362001)(122000001)(41300700001)(8936002)(186003)(8676002)(83380400001)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anl4Qm50ajJ6cVpkWmhidzE0UnFjb2VnemI0bUNEUzdiNHVvRy80Qnpuempr?=
 =?utf-8?B?a1RoTHl6VVdRQmhMc2paUWlwRHNkdjlvS3BYYVpuRkdPaUczaVEwcktkcUJq?=
 =?utf-8?B?M0dSK1I4ZDZRTDR0U2x1d3lEdGRoRVBXb3VCRUtNNE11Wk1JUUxzaUpHc2s4?=
 =?utf-8?B?U0VYYkVOVE9wZ0ZtamxNVUJuby9iWFZ3cWV1TG9MREU4Q0JVdGFqVTRyUENG?=
 =?utf-8?B?dFRubUFvRXBSblVKWDBzOVYremVsc3gvNEIzaWRac01TRlo5eDVMRWtZOVJj?=
 =?utf-8?B?OHNUYVRMMVFMWmtyU2pBazV1bDI0NXh0SFUwdUw2TUZKVWUvaGxqd3dnVmlw?=
 =?utf-8?B?elNWV3R0Z1BkdFR4bXQ4NkwwQURHYUtpQUdjWHlQL29lUHRHSTNING5VZWtu?=
 =?utf-8?B?ZWRsL0dLdmlJdmlOZlVvOFJhNGwwL1VRUFFDR3lYbjEyMEtkR29yS0xkdDFH?=
 =?utf-8?B?aXNQWVRMMjgySDk3QW54YkNvdGpaU2M4aGtNbFBqM09Ja2liQVJxTDE1NW5N?=
 =?utf-8?B?cDlNa3dLWkZBT2F6M1NiUG1xYXJXdmNMTmxoYURCUFZ3Qy9aODZqdDdnbkdJ?=
 =?utf-8?B?S0dpQ2lnQkZKTTloV2Z3T0pnTHhQZXkyQVJQZWZkck0vbEdKamNqZEVsSHpP?=
 =?utf-8?B?MkNXVitqb1N4M3Z4NERrZlg1eGplUDNEbDNMRk5MY2RSN3ZrK1MxeEV0VDF1?=
 =?utf-8?B?T01qdldORjB4WjNISWdrYVhVeUZwVkU3VVRMcVFmdzdnT0JwWVg1Y0JHL2p3?=
 =?utf-8?B?amdNVEkvWFdpUnp2MWxXbUh0c3djU2pZUldhY05aSE5QVDg3cFZSRW0xeHBU?=
 =?utf-8?B?YU9vYXZsZEVqTTRkZXpRSDNiUjFDT1NZTjZCaTV3Z3F0UGtQQlVMMG1IZFJz?=
 =?utf-8?B?a3VOczVIOWdjMCtuR0xsM0RRUSsxZXFPb0drSEZWak8xS0dqeWdiTDg5K0ZT?=
 =?utf-8?B?b0wrQVpqRDJLWkNPTGFtTC81emViNnlTSmJwbkNtK0g1cHNtZ2ZMK3ZVcmx2?=
 =?utf-8?B?TFlaaENEeUsrN0NqMnluMzlXaEJNK08zVlBjRFYvQmU2QVI3UDBaN0psampw?=
 =?utf-8?B?Zmx5M1EyeVlXemhrb202Q0RwakpMVmdHcXNrSGoxRW03aDRkRnI3eHBzeEdz?=
 =?utf-8?B?Q2hxejBvSC9ONlNPL2VxYVFFV2o2VHNqcElqWkQydS82UkdjenA2OFJ2WkNZ?=
 =?utf-8?B?YVBZcXRIV2gyZGlzK1BIOEtONWJrMmhDalhEWWVNWjVNOVVWMDNXeGV0VGNH?=
 =?utf-8?B?bjJLY0JhdVY3K2RNRC9NcSthZ1RnMjErbHFERWZIRUhmaXlrSXJVekQ4MzJP?=
 =?utf-8?B?TEZaOWo2Z1RrY0VMQWd6bEVLTUsrK2pwNFpmNVI0aUQ4alFHSUNHMWJiWEMw?=
 =?utf-8?B?NktPU2pQVTJqekorRlZURHg3SzlsbFdrK2tNak5uazQrYzg4cDZ1UFlMY3c3?=
 =?utf-8?B?UEVmV1pQQ1Jzbm4rOVM1NzZ2WmRqREZIRGtIUVQxQlQ3YmVOaitYVncrMnJI?=
 =?utf-8?B?VUFDN09Balp2L05GTy9NaXZCYVhYUTQ2MmxvR3IxbzlBZVJ4SHpPSTlIZHdx?=
 =?utf-8?B?WDZjVFVuNUxaKzVhc0dwc3l1WWZXTWhjMWFPTThhNE9XZWtYakRrSmJFUVRt?=
 =?utf-8?B?QW9Bd2ZUbFI0UU4zYkt4MERvNHpwS1I5YVdVdkRPT0I0Tm01ejVha0RoVHo3?=
 =?utf-8?B?VCtPVHBETGRhUzg2WUtxTjd2SGxHT2t1eXpEL3JrSFoycjZJclowQk5lSnhT?=
 =?utf-8?B?cFF2QnpHVjJoN09xN1VRTlM4ZTArSTN3RXVjSVBRUWhYa1AyRXZBWGtxY2ln?=
 =?utf-8?B?VmVnYzBwdUV0QnhSMVBqU0N2R2YreWdJZVZoekErb3NwRUtXYVdXWFZLZTVK?=
 =?utf-8?B?UHNRSENaazlqYi9Yc1FOZEU0UUx3YXB2TTVLb2svblNpbFU2Tkp6Y29ud1la?=
 =?utf-8?B?TEh1NFRib3NTR1Nad2ljRUhkMDFDWjg4UmFPZHNaNUMrVWl3NWlLMWJ1Wkdi?=
 =?utf-8?B?NTRoWVUzeDBOdkx0UDFTZ3VUYUNlWDZVclNkclM0dnhDeDJvTG9xcWJxSnk2?=
 =?utf-8?B?VXBpbmpkdkppRDhrZWxLemt6MU1NdkFMMFBQc1c1b2N2NVVhWU1HQzFma0Rx?=
 =?utf-8?Q?DFqOGdWVPDsHBbYvdIrqgU4UC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887d1c9a-8824-482d-1f1b-08da955b7dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 07:42:21.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOGDR2wdGdt4rh/24TgyOrxB8e99uy9VaJiH1CAV+mu9SMCqpepNdINpPjOPDWSqEUiYRp61u5x1JxS6rJhQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMjIgMjowMSBQTQ0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBP
biAyMDIyLzkvMTMgMTE6MTMsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9s
dSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIFNlcHRlbWJl
ciAxMiwgMjAyMiAxMDo0OCBBTQ0KPiA+Pg0KPiA+PiBQcmV2aW91c2x5IFBBU0lEIHN1cHBvcnRz
IG9uIGJvdGggSU9NTVUgYW5kIFBDSSBkZXZpY2VzIGFyZSBlbmFibGVkIGluDQo+ID4+IHRoZQ0K
PiA+PiBpb21tdV9kZXZfZW5hYmxlX2ZlYXR1cmUoZGV2LCBJT01NVV9ERVZfRkVBVF9TVkEpIHBh
dGguIEl0J3MNCj4gPj4gZnVuY3Rpb25hbGx5DQo+ID4+IGNvcnJlY3QgYXMgdGhlIFNWQSBpcyB0
aGUgb25seSBmZWF0dXJlIHRoYXQgcmVxdWlyZXMgUEFTSUQgc2V0dXAuIEhvd2V2ZXIsDQo+ID4+
IGxvb2tpbmcgYWhlYWQsIHdlIHdpbGwgYWRkIG1vcmUgZmVhdHVyZXMgdGhhdCBuZWVkIHRvIGVu
YWJsZSBwYXNpZCAoZm9yDQo+ID4+IGV4YW1wbGUsIGtlcm5lbCBETUEgd2l0aCBQQVNJRCwgU0lP
ViwgVk0gZ3Vlc3QgU1ZBLCBldGMuKS4gSXQgbWFrZXMNCj4gbW9yZQ0KPiA+PiBzZW5zZSB0byBl
bmFibGUgUEFTSUQgZHVyaW5nIGlvbW11IHByb2JpbmcgZGV2aWNlLg0KPiA+Pg0KPiA+PiBUaGlz
IGVuYWJsZXMgUEFTSUQgZHVyaW5nIGlvbW11IHByb2JpbmcgZGV2aWNlIGFuZCBkZXByZWNhdGVz
IHRoZQ0KPiA+PiBpbnRlbF9pb21tdV9lbmFibGVfcGFzaWQoKSBoZWxwZXIuIFRoaXMgaXMgc2Fm
ZSBiZWNhdXNlIHRoZSBJT01NVQ0KPiA+PiBoYXJkd2FyZQ0KPiA+PiB3aWxsIGJsb2NrIGFueSBQ
Q0kgVExQIHdpdGggYSBQQVNJRCBwcmVmaXggaWYgdGhlcmUgaXMgbm8gSU9NTVUgZG9tYWluDQo+
ID4+IGF0dGFjaGVkIHRvIHRoZSBQQVNJRCBvZiB0aGUgZGV2aWNlLg0KPiA+Pg0KPiA+DQo+ID4g
SU1ITyBpdCdzIGJldHRlciB0byBlbmFibGUgc29tZXRoaW5nIG9ubHkgd2hlbiBpdCdzIGFjdHVh
bGx5IHJlcXVpcmVkLA0KPiA+IGUuZy4gZG9lcyBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gaGF2ZSBh
IElPTU1VX0RFVl9GRUFUX1BBU0lEDQo+ID4gaW5zdGVhZD8NCj4gDQo+IFBBU0lEIGlzIGEgY2Fw
YWJpbGl0eSAobm90IGEgZmVhdHVyZSkgb2YgYSBkZXZpY2UuIEhlbmNlIGZyb20gbXkgcG9pbnQN
Cj4gb2YgdmlldywgdGhlIElPTU1VIGRyaXZlciBjb3VsZCBlbmFibGUgaXQgYnkgZGVmYXVsdCBh
cyBsb25nIGFzIHRoZQ0KPiBJT01NVSBjYW4gaGFuZGxlIHRyYW5zYWN0aW9ucyB3aXRoIFBBU0lE
LiBDdXJyZW50bHkgb3RoZXIgUENJZQ0KPiBjYXBhYmlsaXRpZXMgbGlrZSBBVFMgYW5kIFBSSSBh
cmUgYWxzbyBoYW5kbGVkIGluIHRoaXMgd2F5Lg0KPiANCg0KT0ssIHRoZW4gaXQgbWFrZXMgc29t
ZSBzZW5zZS4gYW5kIGxhdGVyIHRoZSBQQVNJRCBjYXBhYmlsaXR5IGNhbg0KYmUgcmVwb3J0ZWQg
c28gYSBkcml2ZXIgY2FuIHF1ZXJ5IHRvIGVuYWJsZSBjZXJ0YWluIHVzYWdlIChlLmcuIFNJT1Yp
DQpiYXNlZCBvbiBpdC4NCg==
