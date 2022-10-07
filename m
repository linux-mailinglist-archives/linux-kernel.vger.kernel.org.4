Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391565F725B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJGApd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJGAp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:45:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2049.outbound.protection.outlook.com [40.107.114.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48D8E0F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsYEILdxIgJLji+SzohxgKwH5OYrEo/ISU4yYkYL1Ezxh0MQAb/8LMY9mQuxErgDLGE+ytFGr9J0uT78yfOnbnIPR7tWPvdM+2yfEoocOW2kJAV9YFBINzA7fNMKtCjPzhFWb7Tr58bHOeFHKkSatRi1ZnmQ6ts9LnknUUGm/zX+RUsWBSX+Z97w9SI1YrRHckjWRTcq4XXH1G420OkQwHUXb6PS18jsgJt4PtuNRdmsMMNH4iNRI+tspjeynnPpDSrtHm8UnaAN8UEfyM33n09b+CLc6H1nGWGzoeBa0KbrM5JbUQArx67EC/LTWvbdOpoinmmVpooeLV++yVb8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCj3FxqmW0nWuB61mohj/wSTpaK0UBGVx7Sl7+mRhi8=;
 b=bVJ96/2MBubwYrktljlzIZVp1HvxkJg7cM11gTTsIIb3QXkhSN6UM7a7Ys5UNulh/4UUTUpH2t1yOH4nyMFtb1kK5/2Dpo7bovNFnymNCI5Yp5GiP5CTMFJNqSBCSVuAbVGtdrRwkgN+fzPl5i+egELkc+353/4jkoRbvDsAMyNsHB71EMomzKfEcpa5DoV4W6QJgB0Vce5cXfObDJWX6r5GBmUg8xs9HSJqMPOIEpaShjuzA0By5h8aQwyC+c7jpCUBVZrtQ5WBala5++6UurojULfdpBq35dK7kv8tQSEueyewQbv0a6ypn/IyVbbiJh5eq5YRkzpICdMCh0IjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCj3FxqmW0nWuB61mohj/wSTpaK0UBGVx7Sl7+mRhi8=;
 b=c4q1fys8wKtVhZfnot7pqVW/oYccG9s05zduKQsZlRWcF08dDyTEw9FLf1m/Mhcq2G8Chy/NqHgzIRs7XiFGpA4Qyoj+sGzlVQNElpvmUGc2CBJsa36qFe/YCmrcmLfI7fJvKb0n7NZhm2zdEpYCpJAB6c7RM4zic5/ieBC3r5E=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB5988.jpnprd01.prod.outlook.com (2603:1096:604:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Fri, 7 Oct
 2022 00:45:23 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673%8]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 00:45:23 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
Thread-Topic: [PATCH v3 1/4] mm,hwpoison,hugetlb,memory_hotplug: hotremove
 memory section with hwpoisoned hugepage
Thread-Index: AQHY0ArcdHIUTTnqNEKZccQtIY0xxq30EqqAgACHoACADZGwgA==
Date:   Fri, 7 Oct 2022 00:45:23 +0000
Message-ID: <20221007004501.GA3227576@hori.linux.bs1.fc.nec.co.jp>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-2-naoya.horiguchi@linux.dev>
 <91a4759f-88e4-f9ac-aff5-41d2db5ecfdd@huawei.com>
 <20220928012647.GA597297@u2004.lan>
 <e75128b5-ea83-48b4-8371-d146ed391f86@huawei.com>
In-Reply-To: <e75128b5-ea83-48b4-8371-d146ed391f86@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS0PR01MB5988:EE_
x-ms-office365-filtering-correlation-id: a5b6d84e-ab44-4c3e-42ce-08daa7fd37e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJ7WS9k0vsG/FvYigFLFiGPlBrRpGAw3Q/9eSGcw9Gw+yCdJrcWoN4o28WW/48WjXIwVq7c8qs06ekYbCtxYXmeygMwHgnThC9fjTUdp6yXxqebaq/ltTIPjgTl/nvI/ADRAnlMkNF41ANNU5CS2cFOLfXx4J0AyAu3d1xu3DeCenMDQaP+Od1mpKrAH18wr/SgiMH8fcHgj+AX1xYmBqM6JXLQsyBJ4yBxCbj0Q+EJTK38/VMQIqvkvULAmO9wi+D8+Ee6k44AikejMH11YT01itJVirtaRBBWToY2PQMwX1noa3FqJOeMq9k1Mg2L70CjpvPtSrgxacrywBDgNBYGidE23RABRGuSMEwRsuN8htQGiFQOEN4ImmNv+9ao7U3GxvzrP/DLEq9qdkkmOQ8YmP6DGX4bxVVIMf6w6wo2VoZ8vOveyYPG3ZbgFwvuyh344jxpnsIO+QJjnAw83IPvXfmw4RQwMbx1W6vRF/oR9KQ6X5P7MgmFySF70hQlHPSC6O2Ljhtkr1cu71/FpTgm7sw5S9V4VzJuiIYB0HiaW5R0djsQwlT5q68yvVB1+Zp2NJMg2eI6y/jlh39eOMuaWp7g5l1a+k4reYtABdKNIvwR2Kn9Z+GQLMYwBgtLCtDse1qHLig7GZMLA1kXL7hNXm7AHhfIjl1ky6dKBVIjxdY3rZ50eJ9zO14aE6O5+qh0RYW8J3AaUvsWCKZhk3fmme0jBgXUe6oA6Phui7v4fMVhSWq/Hb0yM2k6247LEUzpdhkRwgUzhETh6EuCgOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(5660300002)(41300700001)(8936002)(38100700002)(122000001)(66446008)(76116006)(8676002)(66476007)(66946007)(66556008)(4326008)(82960400001)(64756008)(38070700005)(85182001)(33656002)(86362001)(2906002)(7416002)(6512007)(9686003)(26005)(6506007)(186003)(1076003)(478600001)(53546011)(71200400001)(6486002)(6916009)(54906003)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWVWVUh3TUVURXlEc1VmY3AzMVI0a29zYnNwcDJaSFlRY1lTcWY4dk9jT2Rz?=
 =?utf-8?B?c2hqQ1VyVzNmaDhrcmxIcFI1NmpOb3FBLzc3Tlh1NlVXbUlqdXhrQ0x0dE1L?=
 =?utf-8?B?eUcvMzFaQTR5TDh2L0I4b0FRM1V0NFRxRTJOMjlxd2gyL1BmUUZ5akgvNWVq?=
 =?utf-8?B?b3kxYS91MzRJak5aOEdKMlVMNDVsVHNGV3FrY2szWDNXR0xybmwyM1JwRzhP?=
 =?utf-8?B?TTNFRWRla29KbTRGN1NkdkVaQ2Jqa1FkR3hCMTg0MzdhWlNjQnRxSXNwcUZP?=
 =?utf-8?B?YkZWeW56a2dxVWFjSFJkbDEvdTU3bFNqbFRNaDRlTFphYVRUWEJaeGNMd1BH?=
 =?utf-8?B?VGJDeXpWbVAzbFU2Qndmc1VYWjBSclRjSWpsbk1LdDBLZ3NqQWJXUlhpcU9h?=
 =?utf-8?B?UFh3TmNqeFIzaitoTEs0OERsQ1hRU0Z2bkJyWVE2RnQvWFZXYnNFK1ZVUGUy?=
 =?utf-8?B?NVhSMmVCcGxORVM0dnpMa3Jhc1NQWFpRUERDMlBlaTFFdTgwdURsVFQ4aGJU?=
 =?utf-8?B?dnA3QlluZUNaUDlPandGVWZGZ2R0ZmNXc1lHeC9aNkRmQkdlZGtobTlQdVFh?=
 =?utf-8?B?SEM5L04wdnJBUlhWaFhpQ1hkZzBMcXh1MWhDV0NRaGQzOVJKY0xTQWNQakNi?=
 =?utf-8?B?c2poRmxDMjZjNVZjUXJtcEh0d3FIaDVDWW4yNHJaRmM1SDZzUWh2aUFMeHM4?=
 =?utf-8?B?WUszYkVhMStnNHE4cTNub1VlYkxLeWNKT05td242SnV6L2t4aUFsT3pyanJU?=
 =?utf-8?B?dnpiL0xiOVlHT21vdnFyKytHNjZmV0lENGJSRWk3Ymt0NmFSdENGWmZRbGhu?=
 =?utf-8?B?eGZEcElad0pjU2ZkMGlUWi9yN09tMG5rMnNLTDgxd2JPRVBIRHZqOFhDNytO?=
 =?utf-8?B?MmxJZXIzKzhhZGg4TGhORnhaYTNTazhjT09ucy91STBvcDZISGpEWEpHUlBy?=
 =?utf-8?B?dlFMSTVDQ1pzRmNLSUFlZzVRajlCeHBScGdrK3NwSGlGNzdXTTJSZCtXVHdk?=
 =?utf-8?B?UmRRd2xZMkdvRTczQXBsR3FLKytLUjVoTUJWeWlYdmdlcnk1SXZrY2xzR3dR?=
 =?utf-8?B?YjRibTh5OXM5Wm56YWIyK3pjTlAvTStHeFVXOHlRdEpEZDhrUzJ4b2w5MDZM?=
 =?utf-8?B?akZnaU9FRFkzRklwZ1RmU3dBc081Z0wvcWhlUXZSdkM2UVY4aC8yb1BDTGlJ?=
 =?utf-8?B?amlqbnp5ZHFWTjRETkJzdjN5ZWxtVVpJODZKWnQrMmFOS1Q3L1IrNGFGQmMw?=
 =?utf-8?B?SWp2ayt2RkJkd0VUeHdlMjFiZ0JtMjkyMVVDOHBSbndtYVRtTmpSaXBsNDB5?=
 =?utf-8?B?djM5eWZiU2lLVC9Jd25PZmxwa3duWkZhWkp4UmFyUTJEdnpBalI0dXRLR2NF?=
 =?utf-8?B?dFBlbko5T09ZWnBWcUF3MFpCMjlEMERPdHNmK1JaVGNSOTBLbFRtVGNjNW1V?=
 =?utf-8?B?Nkx4dTZxMEYzNDZTeGxCMlJ6TkYrTEtIV3dsbG8yeHRabkdMdXhtZHpEV011?=
 =?utf-8?B?eTdSck9yMWF5eDFmWkZlUmg4ZTdPeWtWTWc2TzRMVXFnbTVEenZ4OHZUZWxj?=
 =?utf-8?B?V09XZWt2NngxSDFIY244eHBxQndLcmZZZ25FZTgrZ1R2UUdheEdxU2hpZnds?=
 =?utf-8?B?ZlUxZlpDOTNacWtpTEVzZ1IvSkR5Y0pVeEUzWjJ3ajNZVldRWHFhMTRZMUlI?=
 =?utf-8?B?amRJNEtyMVd4Mis4eVpDOEt3WjU5a1RTZ1NOUVJVc1RqSkhXSDVrekVGUm12?=
 =?utf-8?B?bTJJd3FseVhCeUY4TVFGNFlreFZ3OStMSlcxVXM2Z29RcWxtOW5Gd2ptVVEz?=
 =?utf-8?B?Z1lFV2JVT0xMWmVyUGZWckJqbEhINWxPemR4V3BzSkVBblNOVzMvSkFSMmpS?=
 =?utf-8?B?SVFjQ1hKZ3FNcTEyZk5meENMN1Y0RkgrejZORlRJYVBFckdNNEFqaFJYb3Jq?=
 =?utf-8?B?MlNNM1BYZmd1OVNtSzFtQjBYNFZ1MWhTSTRJd0o3bW5JbkJQeVh5bGRRQzBZ?=
 =?utf-8?B?VDRsVWVWaVJyREpHeDlRdHhGdEQ4SkEwYnBRSFdpUDlBeUI2VVc3UmYrR2Vl?=
 =?utf-8?B?WDNnOVBKc1BORXVidW1NMEowMXRzUC9rOXBSdm0yOEIyU2RsclZwR1pzbk5G?=
 =?utf-8?B?VkZ1ZVBmOWRVZXBFWHJtbnZ5TnRTY1N1ZUtLU293MFFmelBUSmdsdjBSZXh0?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74A3270784BB5C4A9C66CB87731976AB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b6d84e-ab44-4c3e-42ce-08daa7fd37e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 00:45:23.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqCJ5Njbj2n7T5WKKSKqTNr4Ly4+4wUvZ6bNJfTLoMXPEyckKlay/pG/buxMmJ/TIrmiDt4VpdUbEE7JZOJT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgMDU6MzI6MTJQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi85LzI4IDk6MjYsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPj4+IEBA
IC0xODE1LDYgKzE4MTUsMTMgQEAgaW50IF9fZ2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lzb24odW5z
aWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCi4uLg0KPiA+Pj4gQEAgLTE4NjIsNiArMTg2OSw3
IEBAIHN0YXRpYyBpbnQgdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9uZyBw
Zm4sIGludCBmbGFncywgaW50ICpodWdldGxiDQo+ID4+PiAgDQo+ID4+PiAgCWlmIChod3BvaXNv
bl9maWx0ZXIocCkpIHsNCj4gPj4+ICAJCWh1Z2V0bGJfY2xlYXJfcGFnZV9od3BvaXNvbihoZWFk
KTsNCj4gPj4+ICsJCVNldEhQYWdlTWlncmF0YWJsZShoZWFkKTsNCj4gPj4NCj4gPj4gV291bGQg
d2Ugc2V0IEhQYWdlTWlncmF0YWJsZSBmbGFnIGZvciBmcmVlIGh1Z2V0bGIgcGFnZXMgaGVyZT8g
SUlVQywgdGhleSdyZSBub3QgZXhwZWN0ZWQgdG8gaGF2ZSB0aGlzIGZsYWcgc2V0Lg0KPiA+IA0K
PiA+IFRoYW5rIHlvdSwgeW91J3JlIHJpZ2h0LiAgVGhpcyBzaG91bGQgYmUgZG9uZSBpbiAiaWYg
KHJlcyA9PSAxKSIgYmxvY2suDQo+IA0KPiBJZiByZXMgPT0gMSwgaXQgbWVhbnMgaHVnZXRsYiBw
YWdlIHJlZmNudCBpcyBpbmNyZW1lbnRlZC4gQnV0IGl0IHNlZW1zIHRoaXMgZG9lcyBub3QgbmVj
ZXNzYXJpbHkgbWVhbg0KPiBIUGFnZU1pZ3JhdGFibGUgaXMgY2xlYXJlZCBieSBfX2dldF9odWdl
X3BhZ2VfZm9yX2h3cG9pc29uKCkgaWYgdGhlIGh1Z2V0bGIgcGFnZSBpcyBhbHJlYWR5IGlzb2xh
dGVkLg0KPiBJZiBzbywgd2UgbWlnaHQgc2V0IEhQYWdlTWlncmF0YWJsZSBmbGFnIGJhY2sgZm9y
IGFscmVhZHkgaXNvbGF0ZWQgaHVnZXRsYiBwYWdlcz8NCg0KIyBzb3JyeSBmb3IgbXkgbGF0ZSBy
ZXBseSwgSSB3YXMgYnVzeSB3aXRoIHBlcnNvbmFsIG1hdHRlcnMgdGhlc2UgZGF5cy4uLg0KDQpZ
ZXMsIHRoYXQgY291bGQgaGFwcGVuIChhbmQgYWxzbyBpbiB0aGUgY2FzZSB3aGVyZSBNRl9DT1VO
VF9JTkNSRUFTRUQgaXMNCnNldCkuICBXZSBuZWVkIHN0b3JlIHdoZXRoZXIgSFBhZ2VNaWdyYXRh
YmxlIGZsYWcgaXMgY2xlYXJlZCBvciBub3QgaW4NCl9fZ2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lz
b24oKS4gIEknbGwgYWRkIGEgcGFyYW1ldGVyIHRvDQpfX2dldF9odWdlX3BhZ2VfZm9yX2h3cG9p
c29uKCkgdG8gcmV0dXJuIHRoZSBmbGFnIGNoYW5nZSB0byB0aGUgY2FsbGVyLg0KQnV0IEkgYWxz
byB0aGluayB0aGF0IHRoZXJlJ3JlIGEgZmV3IGludGVybmFsIHN0YXRlcyBkdXJpbmcgZXJyb3Ig
aGFuZGxpbmcsDQpzbyBpdCBtaWdodCBiZSBnb29kIHRvIGFkZCBzb21lIHN0cnVjdHVyZSBsaWtl
ICJzdHJ1Y3QgaHdwb2lzb25fY29udHJvbCINCnRvIHNhdmUgc3VjaCBpbnRlcm5hbCBzdGF0ZXMg
b3ZlciByZWxhdGVkIGZ1bmN0aW9ucyAobm90IGluIHRoaXMgc2VyaWVzKS4NCg0KVGhhbmtzLA0K
TmFveWEgSG9yaWd1Y2hp
