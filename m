Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD106034F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJRV3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJRV3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:29:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C893E0E5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666128572; x=1697664572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IjsYPVLF98lq62v0bmqEPEjQ6/xcrUt/tkTeBCnvqeo=;
  b=UKCp2VZtrt7dNCHeMbbz/I2RCseuGqfgi0prqpjPsar0/kd8zoqlIOfX
   nZPO9U1BlFdr+KXMTLwMYHl1Mg6Im2dpSxKV3QRJ42Khnd1PhzvCSaiIa
   FCgyyznh4Yp4Wt9JMbFojnol0Ke/WdKMHX34bYpWQM839uHfoYhSofnki
   Jl7cjWmUtSi9vJE39elgHqdfg7QYcwZeNjy46h9nV50VDVNk2kDvMlKYE
   Owz0vZ+PWGT1Rz6lZsfx78ghZEGGZdDywbip7yI4fqxUTENgYp2bQIMZY
   zs4iDw9pz5/MtzJvxVvMv+7odJknogGQZDdPoqOD8PgnoZpSaySqIDvoR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307349482"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="307349482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 14:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771427142"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="771427142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 14:29:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:29:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:29:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 14:29:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 14:29:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd8KzIVDxbzqs4NYsvGqvptviMBHz4IOOlvANCYK5xE2b1+82H9UvRG6GlPqnq/Jj1HyezIWll0VLEe7JDVFpM5ZShXaCJXsFIpxrZ904h6NOQ1QsmBbz5Dq5wPjIl7PMxWqojCCKNuerRWG4dgnHXW3QsT2e+rA4iF4alTWyD+0kneqpFHIN6YaYYOknqH7t5Uc46GEi3qQJdfWc0655UKXUeJVNv5x24l0zTZvmDZiMGEcCITVi1eUvBbB5DIPUfYVpYmQoGidJXpQicBDqHJlgnHqmhy8/jwTj2dSvjYtKTk08QM2SCLvc15YGyfJh41iGO+p5TNn1RdvVTFIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjsYPVLF98lq62v0bmqEPEjQ6/xcrUt/tkTeBCnvqeo=;
 b=Ahhh9rq65pW2bsPwCtpQ51uFbbEflILCNOrPZczwdP7e8YWsSWV84kf30b66d8LhgdAfSwUTfTZtuwc54/N2sdOr3OkoTFqS6k30VzFlrVgaC0oRBJlYcVWFNR4bM2ksQ/XbLjROteZkJrlJYmtoQilBqvlCL/YPyMsID+3eT7qjYoEuks4WuXcZjyqPFRiX7lTF0qHGLM5A4FCYy8ZQH52tL7YTp+ZkZ1QeIcfiyZ4FQ3CDYgsqXIZSXm1KhcPjNGzR3ZeJYYWrwnT3/zlbE0EgfCCspRi7kyKNOHMmpNGahBqGnRZCs9531z0vjonE9Xzb3fGWwskoPk7m/Mz0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DS7PR11MB5967.namprd11.prod.outlook.com
 (2603:10b6:8:72::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 21:29:15 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 21:29:15 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: RE: [PATCH v3 4/6] x86/gsseg: move local_irq_save/restore() into
 asm_load_gs_index()
Thread-Topic: [PATCH v3 4/6] x86/gsseg: move local_irq_save/restore() into
 asm_load_gs_index()
Thread-Index: AQHY30Hw1PW2GkL5M0i2Gd7SJLBFf64PKDsAgAVE4dCAAA8eAIAANbyg
Date:   Tue, 18 Oct 2022 21:29:14 +0000
Message-ID: <BN6PR1101MB216107B32F33A18605FD3869A8289@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
 <20221013200134.1487-5-xin3.li@intel.com> <8735bpbhat.ffs@tglx>
 <BN6PR1101MB2161B983B1A85CE3803A3EF8A8289@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <629F4B18-CCA4-4409-946E-F00146C6BCB5@zytor.com>
In-Reply-To: <629F4B18-CCA4-4409-946E-F00146C6BCB5@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: 9ab9cb84-d005-4321-bc14-08dab14fce70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lAq5o30ZfbaujW+T8jExReW2bcO5iCSP0UXTgEb7Y7Djglf4/+9ofrQ6kdl1D/SkW5Xosk8WSj4jJgYmbp2yD2xqi40Jzq1a9egE4O/jB86XJR4YwFe9nNx350hrTCZa0svbUcKuhmk1fM9ZZgPhZtQVM03vEHn5VLHWc82+RmXk+uTjq3XJzv7QHe7CZoSj2I8yO1/zkjgTMaUyOSChxJbALbpMNIBztx5o2sfVcpRpq9kppM2z3nN9d9imXa4eyvVqJpDrQzbtbzW6o7qkx5vhABAy8bp7niyAKi9s317arMeRs9ykU0OFRPpdloXCKtcrs0ml1GtqmA53cwAFDmxYTeMqxpp+mPy/GyI4WhKm0Rkh3LF4nnGKpmfC9p2ekZ/vH6FIXgSEoGu+DmfLAGvar5h5oNFr1k6IJCdwJL2AWKkxTgOlImxO5kBOo6zxN8SjoioOfocvDCxceRFRKaLGvkUqnEufvCvoSF4r8XE3c8T3xMz6+rJGohEF5uEK8S6vTGMO0JNYHb76h6GPD1UK0y8gqCNQrkXBrA6EMvL11QepgUlnXY+Ax22yl9DGNbl20tnO1/QqYtCLQsbYQ9Kq8F0CZYh67iHSsq2G08VljssGCHhXWfp6btgliuuNUOVnv/4zZspz8rLEAP57LzXSsFFABQgpUuuBYG/PmSAJZw7iuuouIf0jz/z73VU3Bq7PvHAiBFtDDACORLtGXnaiCR0goC6SjDoe3UmSGN/oUMy0619VuUsEPoGuPm1X0d0vjNBDEHjjLAhaOtixdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199015)(110136005)(316002)(66446008)(8676002)(66946007)(76116006)(4326008)(7696005)(66476007)(64756008)(66556008)(71200400001)(54906003)(5660300002)(52536014)(186003)(41300700001)(9686003)(2906002)(6506007)(478600001)(83380400001)(8936002)(26005)(82960400001)(38070700005)(122000001)(86362001)(38100700002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFJpK0xmVXhpdExoRlFkdngzS3NaUU01YWdmMnBQbzJTQmhRbkF6UWJpdnJB?=
 =?utf-8?B?R3NucXRaWUpWUnVlK2Q4cUwyeXBteDdoSW9tRzl2M2wrRlg3MkVtVjB0dzh1?=
 =?utf-8?B?YURCVXlDN0ZDTmlxS2JGajd5dlJkZ3ZrS1JkdCtIMHlCZU1vMlNNQzJQeHVa?=
 =?utf-8?B?MHZjcTB1bnlKaHhiM201OVIvdmNtUGZxN2VsaXFTN3pPandMTitMNXZYZE40?=
 =?utf-8?B?cmJEbGgyTVRrS0Z5UU5Hc1psbHdFR2dKeWdiUVkvdFQxNmxTZVFQOFJ3Z1Y3?=
 =?utf-8?B?dFBnUGk5ZlgzaVFpSkFtVC9GNnNseFdjYURMZXN3VXdZcXJ0aHpMTFlXT1Q0?=
 =?utf-8?B?enh3a3FSZWRxWmJJRys1SmtDeDRFNUFkM292clhONFpzQmhhUms3aUx4VFFV?=
 =?utf-8?B?a2ErK2tuWHZHZ3BPTDYzb0J0NVFseGw5ZTFNa3pid0FxTkV4UmE2Y3IxRjhq?=
 =?utf-8?B?YXJtdjRVTHNhV2U1cW5RSXloRmVHYTFzOVpyaXpVTm1MUDNCd3d5R3BZNmxy?=
 =?utf-8?B?WmJmZGw2ek5YaFV6MUVBak9id0IrN0NsOFlXa3VzaTRaczdLWXVOTFJaMHk1?=
 =?utf-8?B?c0RHUFdKcTNram11NndYMThtUG91dnZxb0NMd1RGZFptQVlSZUdnMkRWazFN?=
 =?utf-8?B?VmNrWm9mOUhKd0N0TW41WVBvZE5yZ05RM28wT2JaT09XU0kzVHFMUlZ0REpv?=
 =?utf-8?B?TDFtVlViMVpHUkxnRGsrUEFxRi9KY0ZyeFRrcGhBeXNJV2NUV1ZqdXhTUDRY?=
 =?utf-8?B?NlV3VW83ZkRZc2xiNXRZa2VNTnhnR2NaSHQ2Q3IyT0t2Slp3cHhqVjg2QlVt?=
 =?utf-8?B?bHRIOGRmUVBNUi9HSHdTdGp0YjZFR1NoYmpJWkI1aGxHNlpka0MvSEF4c21i?=
 =?utf-8?B?KzJhVWNuVkQ0cFZ0OTNhOFJ6cTFFNnlsY2Y1SXpndUU5UmhwdUJjOVlGUFAv?=
 =?utf-8?B?bFBNbzZmeVV6K1lxZWprT01leFphSHJZd2gvSVJBaloyMXhaQ2tmR3Y2OVRR?=
 =?utf-8?B?REpyQlZ4eTZWWDFFdjNWVldVSWZuRWZBenNMeSs0TmRNSXBMYnR2SDJ4akQ0?=
 =?utf-8?B?YldGb3JXTWhVVUJPSjhIVm9aNUlHeEZqeXVlZndRRW5NWjY0clA3NE9TaUtL?=
 =?utf-8?B?Q2hTK0hObG9ncFVTK1I5VVRHN0d0RTkzNzAxUWV4MnFIZWlJdEJKays5OXo1?=
 =?utf-8?B?WXRLWWpLRFpKSTZ5dTZiWVhqcGM2TFQwN3lsNEJieXlGbFVEUC9CSDhROUh5?=
 =?utf-8?B?VXkrYlhrRlFPUXEvUUM0TitLMDNCRnp6MXVwQ29RYVVHNld2N1lIZkNZeFZ1?=
 =?utf-8?B?V2xyKzRLeHFpa2doNE1xc2VLYVl2V2xNWGwzUFdCYUdLeVZzcW00VFRxYjkw?=
 =?utf-8?B?YmNWeTlnVlYvVEVNa1BVaGJpNmtTbTFOV05mT1VQUEpmS1o1OWRZWmhXcktx?=
 =?utf-8?B?dm9VS0w2dTE3U3FwZEorOW1OZGtQekpCWmF2VG5nanRJc3ZlRnNaVDlZYmJn?=
 =?utf-8?B?MENIZU5qMU9ZdGQwek03a2FtNkJUS3FBMnlyQlBZdnJ5M1Z4YzJVN2d3MzBs?=
 =?utf-8?B?Y1Q0eHJRYXpYYWpqMmV4cVRsaHg0SDc4VzRPV3BoRE4wYTR0QTBGaHZhd0Jt?=
 =?utf-8?B?dnVQWkRlYXhlSWk2UTdYMHlkSkt0dFRrZFpQVkxmSzVUcVhaSGR3TEt1VXFw?=
 =?utf-8?B?SHR6WGxsV3lmWWpCL21OUHkvN0FUYmpxVXoxbytLbis3ZVVEV3RiWVZSMWxX?=
 =?utf-8?B?WGlXWER1ZUpjZTNvNlRwWjVGMk0rYTVtZVlVZG1HMVpTL0U0T1hFaVVwM1VH?=
 =?utf-8?B?N1NSQ2RISUlZYnFjRUpkTWpoZGduMUVXQW5HdTI1ZVRyNEZ3N3hjb2ltUmlO?=
 =?utf-8?B?THpiQWM5eXVDWmxRMnNkTjBWUGIyQldqV0orVlh1cmFDMzF6Z0Q4SG9sT3Ra?=
 =?utf-8?B?ajJMZU5KMFF4K1hPVWg4TXNualRyYTN1ZExVRi90U1FLQUlObktUcDNqcXpx?=
 =?utf-8?B?VUU2NTdmMHJuMXVlcGtwSjhkTkoyVDh0QUM3UW56djNNRnloMDJRSkJyZUlv?=
 =?utf-8?B?WVFBOUdSVGlTRXNWa0NtbWlpN1pjV2U4S1F2L2xjUTFQakdac3dxREpWNHNv?=
 =?utf-8?Q?9EyU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab9cb84-d005-4321-bc14-08dab14fce70
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 21:29:15.0061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCO0tHohcCNziBh5wG8+STFchNB2Fp/veJJYFNBSz8koyowFvIHsMxvY41o2jSLamSuKEpno5cjIzTs4Xxdlfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBPY3RvYmVyIDE4LCAyMDIyIDEwOjI1OjMxIEFNIFBEVCwgIkxpLCBYaW4zIiA8eGluMy5s
aUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+PiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgbmF0aXZlX2xv
YWRfZ3NfaW5kZXgodW5zaWduZWQgaW50IHNlbGVjdG9yKSAgew0KPiA+PiA+IC0JdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4gPj4gPiAtDQo+ID4+ID4gLQlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+
ID4+ID4gIAlhc21fbG9hZF9nc19pbmRleChzZWxlY3Rvcik7DQo+ID4+ID4gLQlsb2NhbF9pcnFf
cmVzdG9yZShmbGFncyk7DQo+ID4+ID4gIH0NCj4gPj4NCj4gPj4gc3RhdGljIGlubGluZSB2b2lk
IG5hdGl2ZV9sb2FkX2dzX2luZGV4KHVuc2lnbmVkIGludCBzZWxlY3Rvcikgew0KPiA+PiAJdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4gPj4NCj4gPj4gICAgICAgICBpZiAoY3B1X2ZlYXR1cmVfZW5h
YmxlZChMS0dTKSkgew0KPiA+PiAgICAgICAgICAgICAgIG5hdGl2ZV9sa2dzKHNlbGVjdG9yKTsN
Cj4gPj4gICAgICAgICB9IGVsc2Ugew0KPiA+PiAJICAgICAgbG9jYWxfaXJxX3NhdmUoZmxhZ3Mp
Ow0KPiA+PiAgICAgICAgICAgICAgIGFzbV9sb2FkX2dzX2luZGV4KHNlbGVjdG9yKTsNCj4gPj4g
CSAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gPj4gICAgICAgIH0NCj4gPj4gfQ0K
PiA+Pg0KPiA+PiBGb3IgcGFyYXZpcnQgZW5hYmxlZCBrZXJuZWxzIHdlIHdhbnQgZHVyaW5nIGZl
YXR1cmUgZGV0ZWN0aW9uOg0KPiA+Pg0KPiA+PiAgICAgICAgIGlmIChjcHVfZmVhdHVyZV9lbmFi
bGVkKExLR1MpKSkNCj4gPj4gICAgICAgICAJcHZfb3BzLmNwdS5sb2FkX2dzX2luZGV4ID0gbmF0
aXZlX2xrZ3M7DQo+ID4NCj4gPklmIHdlIHVzZSBzdGF0aWNfY3B1X2hhcyBpbiBuYXRpdmVfbG9h
ZF9nc19pbmRleA0KPiA+ICAgICAgIGlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9MS0dT
KSkgew0KPiA+ICAgICAgICAgICAgICAgbmF0aXZlX2xrZ3Moc2VsZWN0b3IpOw0KPiA+ICAgICAg
IH0NCj4gPg0KPiA+V2UgZG9uJ3QgaGF2ZSB0byBjaGFuZ2UgcHZfb3BzLmNwdS5sb2FkX2dzX2lu
ZGV4LCByaWdodD8NCj4gPg0KPiA+VGhhbmtzIQ0KPiA+WGluDQo+ID4NCj4gPj4NCj4gPj4gTm8/
DQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4NCj4gPj4gICAgICAgICB0Z2x4DQo+ID4NCj4gDQo+
IFlvdSBkb24ndCAqaGF2ZSogdG8sIGJ1dCBpdCB3b3VsZCBtZWFuIGEgYnJhbmNoIHRvIGEgYnJh
bmNoLCBzbyBpdCB3b3VsZCBiZQ0KPiBtb3JlIGVmZmljaWVudC4gSXQgd291bGQgc3RyaWN0bHkg
YmUgYW4gb3B0aW1pemF0aW9uLg0KDQpSaWdodCwgdGhlIGdlbmVyYXRlZCBvYmplY3QgZmlsZSBz
aG93cyB0aGF0IHN0YXRpY19jcHVfaGFzIGlzIGxlc3MgZWZmaWNpZW50IHRoYW4gQUxURVJOQVRJ
VkUuDQo=
