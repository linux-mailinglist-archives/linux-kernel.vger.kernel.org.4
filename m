Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D56031CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJRRwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiJRRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:52:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277EC643F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666115534; x=1697651534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EH0Z4vn/tpsKDY1fkl5hRE4Or1B6xjAoqHGd7/T1w8g=;
  b=blOJx1WJ9UC0lpwzXCP1TcMSKmIqFojKLrCaEfxh2XAKyTHW5xPouVbi
   vZRiAP/4QCG/9PlTsuYhG11bYY6Dz5tIXUe0TIw/82rP27YEZ2mgKgvN3
   Pf/jUddS2RDPiyUMeToM5jscWbkNE022JNnGwc3FOx/vbv7ukCqGjzzy3
   INeHuLaFtNZlztx5yhohS+IUbLuC2+Fw5Q/3yAoF5P0AeK/yeKUH54JFi
   w0ZtbZ27phdBetf/5SBFWHo+CGGg2Ujh0DVMfPHE2/JWHMunJmpN0SVWT
   KvjXZdRZqEJMBqcqSbIuw8pHo/YYQ5/FQrfcsX71PQFloIiZ5PzJLvLuM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392490139"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="392490139"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 10:52:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="803864923"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="803864923"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2022 10:52:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:52:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:52:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 10:52:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 10:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDo5xMZsS2KQxeTdeUIIsll0qb9UBnv9BxRu57wBMv+iZ6zZduTVbcPLIvb0AzGw7kXciLi0DxpzLFVHHYT+H1qcCB68nQGSrTUdyycASjJdgjEkEVruU6jRvZL1ET5aYiLslzDfK+M5YfHQR4mtzQWEcoy83Qz5oXD9CWCIx9XHGWr/qitfEvgorQ0Yao2vdHbM02G9EIg9w+/VlC4/wR0g1at/Ip4k9Gfmt0b7fG2t3L2yCPgAmGnu2cAtHYeNSTLuz4Bf1EUgzuMt4EGnw7A1aeGS5BpK23U9OdVhl4MmDluA+gl+DIA/NE1/wX8wFEktZ88bUTPWcc0J4Qkp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH0Z4vn/tpsKDY1fkl5hRE4Or1B6xjAoqHGd7/T1w8g=;
 b=JBYUSYMzQoIJlKkp2kgp7YC7SD+VukvMLUv4UV+4Tl7iBzNm0VWAfclGpRLT8K11UhJU5y8dXDBOrIovXOuYXnABQcaVkTLfZFtGuFUGZ5bbkzL6Hm7DBWi/QXblz75ypyaBX+L/ViqXF2ULYrSLtpdpst+C80UlgrbBwJ6mu8DlB823H4DUJPkFXKW83wG81N45Ck3QB+3JsLdvY3FGvncFDvxBs3bJhRlyvPO2IZuxb+71fQ/3whVw8L5d72XiiZmY9wg+sb5qF2vYmnWgWpceSdQMUyIH9Afp0CUozRteFRaU4BrZhpbynqEM01fYgyd1i+LdcHphOpe1B/U+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Tue, 18 Oct 2022 17:52:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 17:52:05 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mm, hwpoison: Recover from copy-on-write machine
 checks
Thread-Topic: [RFC PATCH] mm, hwpoison: Recover from copy-on-write machine
 checks
Thread-Index: AQHY4oIadTZfEDJ1Q0qrPavLe2NwBa4T1nCAgACPbZA=
Date:   Tue, 18 Oct 2022 17:52:05 +0000
Message-ID: <SJ1PR11MB60838C1F65CA293188BB442DFC289@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221017234203.103666-1-tony.luck@intel.com>
 <20221018084342.GA3743869@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20221018084342.GA3743869@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6336:EE_
x-ms-office365-filtering-correlation-id: 63baf717-4882-481a-41a2-08dab131781c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zkqN5qrKU89hBXko1jxGxVfYc/5baXmpB3mamrNmqdu/RF4UbETSk3S8XTnQTVvopZ7akozxPb9wABsblEfJN1FgNgVbDIgRCW8d3Pa+Ypxs+WlPiNrefOPM+O1BOLo8jmtweS6N9uKdYSYRF8Tfz/F5QAif3Shwa17ebpEyO6bSzWGC/CZLM1ujHc4Ge7Mioeo/Qvexh7MdB7eaie3OTu0A24ZHhmkyBMXv9MoTdP/ohSx9QlUrmjJowIy/01hYIaBsxoZYZ4UCgyWRVBHvEbWRA/s4h6DbqNQugodKdFc4/OqGwYQrZ6UNBTsEqKkR/20wYRvLK3NuwSAUYhUJovT9wW8NA3LCrmWip1OfhoPuR5jHRx8BMtQ5MCnOhIrRnqOvZ3IyUV/7f7jjd0ncOdPfaOlLqMKx6mRJ1lys8IBfOTvyb86dLCATBF25+EidKIWkcxGYbSeudo/0e8D4XocM5lmjrzvftbi+ofoNWI1ItFBKPLeoJynPtu0sMeW8WUx5L3Ze0DclrDaCBVRUcJVHd12Nh3CHYDCF7lhaa5P6LqnTuH3peeuf1b3mstjfOTVTe4sm5FivabzRdN8WyHzh0eZ7ReqAdbX6BvnVPyzLfMvIOPBlEY7F4xEl0W3CA6iv9Idp5LdwXAQfesqv0S3m2B0IsTxQO8nlz0CmpW7bPqpKzChps6p9oE+nDs9Rs6QwfHGgEOlmtxmc9pfuvJDIYfr/EDSy400yF7RjwjDJuJjMGTNwVSW9dx9z9jO/HSXff9WMNv7dveaJ+r1qYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(186003)(2906002)(6506007)(7696005)(26005)(54906003)(5660300002)(316002)(6916009)(86362001)(38100700002)(82960400001)(41300700001)(66446008)(64756008)(8676002)(66476007)(33656002)(76116006)(66556008)(66946007)(9686003)(83380400001)(122000001)(4326008)(8936002)(38070700005)(55016003)(52536014)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWY5S0p6V2dOUHA2eGlDZDEyRnB6ZlVZL2JKWWtkUWRUOEVvRmZEbGphcWtT?=
 =?utf-8?B?UUg1YXhjZ3hyNmVRUUZFMHJzeVdkcnVTbyszY01jNjh0bHhONU5idllFenBD?=
 =?utf-8?B?ak9vQU14OHBUMHdyVEh1Z1RxY1lqRDR3Z084SG1adU5JQ3NhbFI0TWhxdVNj?=
 =?utf-8?B?UVBBQWtoYWhhcXZ0aVFsdWlzYUYzbEZTRnorMXljbVoyN1lRUzhjVEtQVGVJ?=
 =?utf-8?B?dFBYQ2g5SE05L2JIWWlZNUp6TWIrWHpZdHdLUHE2SkVheFpjbUlveEVUSnJ4?=
 =?utf-8?B?TlB6RmhQcnlCS29yL0NEY3BjSFhBUUVSK2I5by85eGl0VEsrM0ZlNXhubVNM?=
 =?utf-8?B?S2F4VG5LSzV5TExpMWpkSXBaS2dLbUFiN1FzMkJlZVM3UW03dFJGaGZGcU4x?=
 =?utf-8?B?OGlhUTY3dVlyaVlGVFVvb1JWRHBoRWtpR2dOeERDZWdOdzE0QmZHZU5WdmZs?=
 =?utf-8?B?U2drT0NFU2ZkUmFrS08yZzU1OUs0WDA5NUI3TEdmanpEU21TVjJYMzdyNEZC?=
 =?utf-8?B?NE03RE9KS3pLZmRiZ0V0VWkyM3ZNeTBDelpNMVpteFhxZXNWdWI4VmVZYUhJ?=
 =?utf-8?B?NUV3SXpqSCtJd3F1OEx1eUtFR2hqRmM2djRqMzVQUjN2QWRaVWJVb3N2UTF0?=
 =?utf-8?B?NTIzYjJDVW1kSHR2clZZekFCMXdXbld2NEhGWndDa3pydGUzdG13MENjeG5o?=
 =?utf-8?B?QTFHMVF6L0hMaWE0NVQva2U4ZCtJbVRYNjVXbWd3RFo4WVFnTlNCZmxBdy9i?=
 =?utf-8?B?dElCQjBoQ0U0MWNQQ3RZazVyQW9CTDljeXZESFVDQzlVYm1MUmREcHJmRU5r?=
 =?utf-8?B?eEJueFVMODJodDlaaHFTS1JpNlhBbDRONmNNSmdDWENJZkRRZFhLU0ppQUU2?=
 =?utf-8?B?NnlRZzdjR2ZmOTFFOGZvLzczRC9jWm1VZDJBUjVOYkhsd3F5UUlKYmlMYy9Y?=
 =?utf-8?B?TnBWdi9US3JDbVRnazR2NEtpVkdiTWwrSEZxM1lsVW01RzVESFhvUUYyVXVN?=
 =?utf-8?B?WEk4S1lhMnFBakRaWU9rUHYvb2JDMXFobzZrM1gyMVNka281Y0IwaHg2WGhw?=
 =?utf-8?B?WTNGS0Vhc05XQU9VMFJaaDE5czdES1BUUEhZRU50aG50NjlKUmJ0L1QvVVA5?=
 =?utf-8?B?VTR1bFdJRm8yQnlBSVhCSStlYTdGdWpSNW1od0xCMjRVTittZG1uajR5bnlW?=
 =?utf-8?B?eDQ5cE51WENvL1IwdXlZQXRKK0YvcUU0bjVLUzNyWlYvNDVMM2VjS1BvVUQw?=
 =?utf-8?B?S3BNU3pHbGdvSlJPNGFWcGo0NXZ3ekhZbjV4TnAxalhPeFRXSnl1UHdIc2VF?=
 =?utf-8?B?a3IyNEFqZ3BRa2pGZHQ0WTl5ZXhHQXlNbWx5b0hlMmtqL1gxRWQwWEw5b2gr?=
 =?utf-8?B?c3JPalBPYjBST0w4UjdnZ1RmckxuZmdVOWpPbEZrcVU5YytmYUZxbFFaeHdW?=
 =?utf-8?B?eXQvL3BLYlFIVWY4My9nYkFxR1NBQXdSMVpISTJoSk02Q2xrUmRtV0JuOFIv?=
 =?utf-8?B?SndZM0pnTWtCWW5jbWtoVXRxTEJrNU1jZERzb1lFaHRicXJJUTNTbEhXTEtV?=
 =?utf-8?B?cms0MXdxWHRXZ1ZodmFVa0NTQ2phaGV0RFBPUkhScjU5U2czTncyUkpnWmxK?=
 =?utf-8?B?c2d0bHV2SSt0VzJUU3RHWFJLQTVNY3pNaWYyS3dVek5vUnVrOEZHTEZSNUZl?=
 =?utf-8?B?SXNreFArM3EvK1hmdXBpMU16aHZud1h6WVdvRVRYb28rMC9UQzBEK2Fvbk54?=
 =?utf-8?B?ZmJWYWZIZEtjZzBZSVRjbXJJdjVlZ1FKNHp1WUFvMUZIekpFNDM0LzFWZlhX?=
 =?utf-8?B?RURvOEprTUY4TGNVMWZFZUljSmFhbkYwL2VjNmZ3b0JwRHFIaVNHUEdEZW51?=
 =?utf-8?B?Q1BabHgrTW9DcXphMFlIV1h6UHZxMDV2NXVqc214enltRnNZS1NGYm9uY0Fq?=
 =?utf-8?B?emY4ZjJLeGVzWisybUZZM1R3ZVVkVGxvUFBMdUd3Q0xYRzNxSmF1clBxQXdY?=
 =?utf-8?B?WmFBRVJVMmRZZWRIWC92c1I5L21EbkFLVGhPdFpXTEdUMG8wUElQZTJRQ0k2?=
 =?utf-8?B?aFY3aUozUzJyRndZNFFjUjMwL1NZMmpMd1kxYlFsK0xPVzllRWxPVnpXQ2I3?=
 =?utf-8?Q?1dYEpn/5AD6SQY+8rgW4cahlK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63baf717-4882-481a-41a2-08dab131781c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 17:52:05.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2ZPUtblN9v06uH/8BFlLIyVkH+X9030V/tmmBUQNq4ajstgbiqTqrOsFEiF8qZUiK1YoG5TyoI0LFhqugWUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKyAqCS0xID0gY29weSBmYWlsZWQgZHVlIHRvIHBvaXNvbiBpbiBzb3VyY2UgcGFnZQ0KDQo+
IFNpbXBseSBjYWxsaW5nICJwb2lzb24iIG1pZ2h0IGNhdXNlIGNvbmZ1c2lvbiB3aXRoIHBhZ2Ug
cG9pc29uaW5nIGZlYXR1cmUsDQo+IHNvICJod3BvaXNvbiIgbWlnaHQgYmUgYmV0dGVyLiAgQnV0
IEkga25vdyB0aGF0ICJwb2lzb24iIGlzIGNvbW1vbmx5IHVzZWQNCj4gdW5kZXIgYXJjaC94ODYs
IGFuZCBpdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IHRvIGRvIHdpdGggdGhpcyB0ZXJtaW5vbG9n
eS4NCj4gTWF5YmUgdXNpbmcgLUVIV1BPSVNPTiBpbnN0ZWFkIG9mIC0xIG1pZ2h0IGJlIGhlbHBm
dWwgdG8gdGhlIGRpc3RpbmN0aW9uLg0KDQpBZ3JlZWQuIFVzaW5nIC1FSFdQT0lTT04gcmV0dXJu
IGlzIGNsZWFyZXIgaGVyZS4NCg0KPj4gLQkJaWYgKCFfX3dwX3BhZ2VfY29weV91c2VyKG5ld19w
YWdlLCBvbGRfcGFnZSwgdm1mKSkgew0KPj4gKwkJcmV0ID0gX193cF9wYWdlX2NvcHlfdXNlcihu
ZXdfcGFnZSwgb2xkX3BhZ2UsIHZtZik7DQo+PiArCQlpZiAocmV0ID09IC0xKSB7DQo+PiArCQkJ
cHV0X3BhZ2UobmV3X3BhZ2UpOw0KPg0KPiBNYXliZSBJIG1pc3Mgc29tZXRoaW5nLCBidXQgZG9u
J3QgeW91IGhhdmUgdG8gY2FyZSBhYm91dCByZWZjb3VudCBvZg0KPiBvbGRfcGFnZSBpbiB0aGlz
IGJyYW5jaCAoYXMgZG9uZSBpbiAicmV0ID09IDAiIGJyYW5jaCk/DQoNCllvdSBkaWRuJ3QgbWlz
cyBhbnl0aGluZy4gQnV0IEkgZGlkLiBNb3JlIG5lZWRzIHRvIGJlIGRvbmUgd2l0aCBvbGRfcGFn
ZQ0KKGl0IGlzIHdoZXJlIHRoZSBwb2lzb24gaXMpLiBJIGdvdCAibHVja3kiIGp1c3QgaWdub3Jp
bmcvZm9yZ2V0dGluZyBhYm91dCBpdCBpbg0KbXkgcGF0Y2ggLi4uIHRoZSBzeXN0ZW0ganVzdCBo
YXBwZW5lZCB0byByZWNvdmVyLCBidXQgSSB0aGluayB0aGUgcG9pc29uDQptYXkgbm90IGhhdmUg
YmVlbiBoYW5kbGVkIGZvciB0aGUgcGFyZW50IHByb2Nlc3MuIHRoYXQgc3RpbGwgaGFzIHRoZSBw
YWdlDQptYXBwZWQuLiBOZWVkIHRvIHRoaW5rIGFib3V0IHRoaXMgbW9yZS4NCg0KVGhhbmtzIGZv
ciB0aGUgcmV2aWV3Lg0KDQotVG9ueQ0KDQo=
