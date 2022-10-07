Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D35F725C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiJGArG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJGArE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:47:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2048.outbound.protection.outlook.com [40.107.113.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46396B5171
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOdpmVnjFayL8MGGizRqg+Fw1MVNNVx+3bfJgkdgJ7enty+egpILaCpS883CXgsuNrgQKv7Z64IKHDNKN9BBmrD2fjRKYbuKrybi/qPMKbaBWfbjhb4wKUEMDAnUG6L0dtIEYo13w2VFsZpL3onvZMjJY3JHJC+5yDlG/8lHVHtNeKLANZqs5pv2D8Ge3R3I7geOuyu5eepAk5eTq7tArov1+hsCaaU5jB6QELtpxMPmmqbfbqm5VfX7hcPfQqJJAEi0zred+TQFCml3nuOM2CrQc2FIggrYBqFMB/s1PJOGzI6WRv2rsgaeg3lDWqQdbYows5t2cTYo0LruNB2f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZQUOmmphdIrIiEm5jID7v1vGHork/qVUG3ClhF2MTw=;
 b=mtTTpSQVZg4V41q7oOjuYTZa+IYosRoAoMdI1T1TkC6u3kFO2KekCTaPTvFa0Pc2Jstf8MzHEDvg7aPpkU+uorB//h2yejbK14s+4BQBC9Ka2V3+i3L30pP3lpN+66aMdqAa16YXUJBFYEWPuJ/h8QOjc/uv1M3/UDsW7mb+wcHGB41RYPmmv6wAtEZijxUstCJL+jgckSrYa8VbDtqy3b1Uy73am1Uc8Qgrppz+pA/OppIKcW7Vt+OsZHPjfzLjL1NqllLndJXN5LmvfB5URfqPokE1/j/0LB9ZFR/8c3wKG6x4u5bCGUMX+tewY0TioEWLo3+thB/5EigeNHBDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZQUOmmphdIrIiEm5jID7v1vGHork/qVUG3ClhF2MTw=;
 b=nPN54BXfLw9UugXFi3ps2GMfo1arxW4wNhQGK9BBRx9Va3uuIdPRASZXAtzbItTHshgCDEd1bllTI1WLrqyuiBKfJDB8BgaIrsk2qXbLc63qoOx+WR8aKtrfT5hnfJ5Ik84vphXSer9oESJAbvRy0iksXWJPpOJAwZ3f9nC+0ok=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB10452.jpnprd01.prod.outlook.com (2603:1096:400:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Fri, 7 Oct
 2022 00:47:01 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673%8]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 00:47:01 +0000
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
Subject: Re: [PATCH v5 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter counter
Thread-Topic: [PATCH v5 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter counter
Thread-Index: AQHYz1aclcBWFWa7BkC5YnGY49sNB63ug1+AgBOqkQA=
Date:   Fri, 7 Oct 2022 00:47:00 +0000
Message-ID: <20221007004700.GB3227576@hori.linux.bs1.fc.nec.co.jp>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-5-naoya.horiguchi@linux.dev>
 <20220923082613.GB1357512@ik1-406-35019.vs.sakura.ne.jp>
 <20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp>
 <542473d1-b687-55b8-24d1-96af715aed56@huawei.com>
In-Reply-To: <542473d1-b687-55b8-24d1-96af715aed56@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB10452:EE_
x-ms-office365-filtering-correlation-id: aa098a64-1ee6-4cd0-85c9-08daa7fd722a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33/20gziTKORkBLWAM7GBUlqVMutwQEXJnlxNV1UCsPf9UDdUWjlbiggPtEFSeWnZ5KBGSTVhzIHi40ZkLhcEVBFAUn07ElEiDc6Zosk6X6Nc8bvFsCZHwa9QS9QsfLVicbdEGXSZ45E9JwRsW0Z38DcEufkGxgjDBDn6oSq5zhZVifsLJbvtjxusfmHjrMmG7d17XeZOtXRNGKlWZeIf/bwZ2ZiNSnfx0opCuwu5qTezCH4h/jtARLq07CFWWAWPufAlwVqeORFe+DkF01qcYEvoKR1KRabaXM0jJsrPay1BVB+rFGzQVG/09yBqgwW+8RwDUh90PMfyVYnn0UG7OripIkY1BwxtZB/jve+34bI7rtyMI7hoYrggKSxQFW1fDz1nqcRVy+KURfBRMEkezVi9jenbU+/Xt01gIudLD09XuJoE+JYyct8DRGhsr/ICdqlaOnfvpXDLKDAZyBwUwRAxoLIJudyS3smAfPXW0h8MVJJGDF5FnzYLgb0sfJ2Q9vlKAdSrAmUzAU9EzlguJNXxZiWlgmm0+R+vZB+h4yLbVTxUobMEspjME+DdlTR9pHaMTpqFZP/oRGRdMROBBaKhFbTzXZrs9J0xOvlIUrlM//BNQUhWuGSUOJP4QommF7FRvjGzw4guzHuweAmKL3W3QQ81s+RMGIfxN4HRNvE/vTyB3uvEvPYDtphUA2BM2VipktDiAJJ6fce5uAX335UR2Yl6eMj88wo7iVTl4yL3bvxw7/TniMjvtWmIMPwesn6RgPMlWGSRxTrX8wGDB8oNIDyw22FmIuvAIjrD00d5b535p5Ursb9jyCyW0jOUouCRkMLhvGl+k1OE5H6Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(6916009)(54906003)(478600001)(316002)(71200400001)(66946007)(4326008)(8676002)(66556008)(64756008)(66446008)(66476007)(76116006)(53546011)(41300700001)(6506007)(6512007)(26005)(8936002)(7416002)(86362001)(5660300002)(9686003)(2906002)(186003)(1076003)(38070700005)(6486002)(966005)(83380400001)(82960400001)(85182001)(38100700002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3U2WFpRb2YxYnVaeWtBNTR1UTVWMmRJM25KODJCaDhpbmduOGg5SkdNOWtZ?=
 =?utf-8?B?S1A2MVVuQmdHWktSSTBzRmpXN1k0N0w4OHFRVlZUeTdrQkozYU03QjZxODh3?=
 =?utf-8?B?Q3BWaTNzUUJleHp2a3ZJTUhnalZ6TjVxelkvaXlPUWhBRitqTC9mVXRUYzR6?=
 =?utf-8?B?eFIrSUZMNk5veWF3SmNTVll1Mkc1UDlNRGt1L1dqWjRicUd3MGhLS2sydVZL?=
 =?utf-8?B?QVo3ckhYQ3pMc1MzOHZYYjN6QTVWcHFySHQ5WENUQ3h0YzBJOXAxNWdxZ2lI?=
 =?utf-8?B?Z0h4Sm9Gd29EMGE4b0l4UThraE9YOGE4dUd3b1E3NjlKb2xaQW45M0dwZGds?=
 =?utf-8?B?alorV1JDRVZiMkkrUG5BRkt2clMwYlZONWJHdnZWSE5uUXVJVHJjWFBYMDB2?=
 =?utf-8?B?eXlrbFhUZ2FaYkgyQ3Y0WHFTa0dSUnhybTJpZFUzR1BTdForT2E4U0MzUWpB?=
 =?utf-8?B?VjltbitRQm8rQitHMDFDSE9BalFzRHJGMW52S2hQQzZ3d2plbXdLVU1NWk5U?=
 =?utf-8?B?UWZVL2Q0YW1VOXp3QjBPSVRRVUROVGpRVVlhVktSNDBpNEJzYUdKQ0JENGRz?=
 =?utf-8?B?aU5nSG9iRHo2NW84Y0dDNEZUdDBsckhPUWNsZERKS2xQQmw1QXEzaENkSzYr?=
 =?utf-8?B?K2svMUp4YjAxZVpJaWk5QXJCdjZaenloWE5xVStydkEvSU9vR0Q0eWt4MFk1?=
 =?utf-8?B?cnFJdjNLdjRpeFlxd1A3K2NFdFhnNnp0dC9qNWNwTmtES0lFL2RzNUJrVld6?=
 =?utf-8?B?bVdDVTlTcFF3U1lkZEhLT2kwQ1dmbkpJZlZEOXFraCt3L2NiNFJpeTZxT0NM?=
 =?utf-8?B?N3kxanBpM2xzdVdhZ1Rmd2ljN1lIckY2aVBLNStrMG4xNHhuTkFuZklzSnV2?=
 =?utf-8?B?cjRKVjVHaFZMbkU1bEdOMHRHNEU4VTRKV3JZQkhBUzNhZ1M5ZGpmR3ZDTFRx?=
 =?utf-8?B?R0FsVmhqdUQ2T05qcEdtVVU1QnNjY3pML2VsVFBpTDNhUGdqZzVVdUI5REkz?=
 =?utf-8?B?aU5ONlJ0bHF2NjR2WWxZOUM5UUNodm1vV0lSRkN2L2I5YWEzVHZoTFZWeng4?=
 =?utf-8?B?QXZKS1pIOUZlY3VuTFJjYnBRRUZPM3J6T1l4ZnpCWHpFUE1aMVl5WTdvVW9i?=
 =?utf-8?B?RGx0dHFKWjhxNnZjOHlTUlcyUlVPVTE0QVJKd0paWGNMc2Z0Qm9UdENlVHNG?=
 =?utf-8?B?a2RueW1KcmRGdzBIellENlpOSzVOcXQ2clU2S01QTWI2bWkvTnNFMWlCZENl?=
 =?utf-8?B?bFRVWVQ2ajZEWlVWUHJzRElpblhXVXJCVmd0Y3dGTFhVTnFlb2xaYjNhdGRo?=
 =?utf-8?B?L0YvN0kyMUhZYUxMdDdiakU3RWtjbTRWRFFMZlJzM1ZNTjVhbXZXUWtIUTRJ?=
 =?utf-8?B?V3I4bVkvWmlIVHlzaWE2YSs0Q2p4RE5kQzg2MzFpd2FOMGM5blR1QlJLQlpB?=
 =?utf-8?B?N3hJdjYrU3BuU3NiNDlGRmpiNHNCQXZYR3N3RG1iU05vcHNrWkJVM1RlYmNy?=
 =?utf-8?B?L1M2eFFWN09NS09zZFhJT3JndEFKNUN1VEM5b1lQb1hzcFhvVUlZVEZrbU4r?=
 =?utf-8?B?ZFRhR3c1YzRmMDNZbjJEdEJGWFJGc2dPaHVMd09lM1hLZFNndE41T0dsSi9w?=
 =?utf-8?B?WDhnOVBKNDJLbmZkZk5CWW1TckxyWEl3SEVFUzA2TzhDREFhNG9zc2pWTCtn?=
 =?utf-8?B?YVdjc3hic0Q0Ym5kR0h5ajNFZkJuVTVHUHJ0VjBod1U1bnF4MjIxdWFQdldI?=
 =?utf-8?B?ZHFRdjRydzN1aEU5OUx0Vm42bktQWWYzSmIyRVBmYlhObTlwV0VCTUtNaUtx?=
 =?utf-8?B?RGtVSDhObEZFamNQVG9CTjcraUQybUs3c1ZZMEZXT0NRSmUxbS8xQlI0dnV0?=
 =?utf-8?B?WkVPbjlwNmtWSzJNdHNXQ254RWNVV3NSanR3M1NqVGZOOE9keHVCcnFWQ3VB?=
 =?utf-8?B?V2M4bURBbzdTSGF5aUN2SDNWZm55RktXYml3d2ZvU2M2SGFwYUdpUkpiUVc3?=
 =?utf-8?B?VTBSYzFuTDd3VS9Ga3JLNmJ4RzZndFplRnptbXM0c1NlS09BU2FuV09CeU5z?=
 =?utf-8?B?ci9VMEZqOGx2UUMrZWlBMXg0MldUUnN0UlY0UWJCRzNUWjVXNGErR1p5NmlV?=
 =?utf-8?B?MmM1d0VyRmZyek1lNXhDT21oN2hSdThiRnZ0WW1RaGFvaHZFNmx4ZmdEOWc5?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27419A988D8DFD4A8173D6EE05176533@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa098a64-1ee6-4cd0-85c9-08daa7fd722a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 00:47:00.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fzx9FB5vBzgvZDd39uZ+9qdkZISu/nYgv4Sg3JkYnuJAb5yKIkab1TeHlUBW0GQAvjor7l2iNMJCksl6/Qc3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBTZXAgMjQsIDIwMjIgYXQgMDg6Mjc6MzVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi85LzIzIDIyOjEyLCBOYW95YSBIb3JpZ3VjaGkgd3JvdGU6DQo+ID4gVGhl
cmUgc2VlbXMgYW5vdGhlciBidWlsZCBlcnJvciBpbiBhYXJjaDY0IHdpdGggTUVNT1JZX0hPVFBM
VUcgZGlzYWJsZWQuDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDkyMzEx
MDE0NC5HQTE0MTM4MTJAaWsxLTQwNi0zNTAxOS52cy5zYWt1cmEubmUuanAvDQo+ID4gLCBzbyBs
ZXQgbWUgcmV2aXNlIHRoaXMgcGF0Y2ggYWdhaW4gdG8gaGFuZGxlIGl0Lg0KPiA+IA0KPiA+IC0g
TmFveWEgSG9yaWd1Y2hpDQo+ID4gDQo+ID4gLS0tDQo+ID4gRnJvbTogTmFveWEgSG9yaWd1Y2hp
IDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiBEYXRlOiBGcmksIDIzIFNlcCAyMDIyIDIy
OjUxOjIwICswOTAwDQo+ID4gU3ViamVjdDogW1BBVENIIHY1IDQvNF0gbW0vaHdwb2lzb246IGlu
dHJvZHVjZSBwZXItbWVtb3J5X2Jsb2NrIGh3cG9pc29uIGNvdW50ZXINCj4gPiANCj4gPiBDdXJy
ZW50bHkgUGFnZUhXUG9pc29uIGZsYWcgZG9lcyBub3QgYmVoYXZlIHdlbGwgd2hlbiBleHBlcmll
bmNpbmcgbWVtb3J5DQo+ID4gaG90cmVtb3ZlL2hvdHBsdWcuICBBbnkgZGF0YSBmaWVsZCBpbiBz
dHJ1Y3QgcGFnZSBpcyB1bnJlbGlhYmxlIHdoZW4gdGhlDQo+ID4gYXNzb2NpYXRlZCBtZW1vcnkg
aXMgb2ZmbGluZWQsIGFuZCB0aGUgY3VycmVudCBtZWNoYW5pc20gY2FuJ3QgdGVsbCB3aGV0aGVy
DQo+ID4gYSBtZW1vcnkgc2VjdGlvbiBpcyBvbmxpbmVkIGJlY2F1c2UgYSBuZXcgbWVtb3J5IGRl
dmljZXMgaXMgaW5zdGFsbGVkIG9yDQo+ID4gYmVjYXVzZSBwcmV2aW91cyBmYWlsZWQgb2ZmbGlu
ZSBvcGVyYXRpb25zIGFyZSB1bmRvbmUuICBFc3BlY2lhbGx5IGlmDQo+ID4gdGhlcmUncyBhIGh3
cG9pc29uZWQgbWVtb3J5LCBpdCdzIHVuY2xlYXIgd2hhdCB0aGUgYmVzdCBvcHRpb24gaXMuDQo+
ID4gDQo+ID4gU28gaW50cm9kdWNlIGEgbmV3IG1lY2hhbmlzbSB0byBtYWtlIHN0cnVjdCBtZW1v
cnlfYmxvY2sgcmVtZW1iZXIgdGhhdA0KPiA+IGEgbWVtb3J5IGJsb2NrIGhhcyBod3BvaXNvbmVk
IG1lbW9yeSBpbnNpZGUgaXQuIEFuZCBtYWtlIGFueSBvbmxpbmUgZXZlbnQNCj4gPiBmYWlsIGlm
IHRoZSBvbmxpbmVkIG1lbW9yeSBibG9jayBjb250YWlucyBod3BvaXNvbi4gIHN0cnVjdCBtZW1v
cnlfYmxvY2sNCj4gPiBpcyBmcmVlZCBhbmQgcmVhbGxvY2F0ZWQgb3ZlciBBQ1BJLWJhc2VkIGhv
dHJlbW92ZS9ob3RwbHVnLCBidXQgbm90IG92ZXINCj4gPiBzeXNmcy1iYXNlZCBob3RyZW1vdmUv
aG90cGx1Zy4gIFNvIGl0J3MgZGVzaXJhYmxlIHRvIGltcGxlbWVudCBod3BvaXNvbg0KPiA+IGNv
dW50ZXIgb24gdGhpcyBzdHJ1Y3QuDQo+ID4gDQo+ID4gTm90ZSB0aGF0IGNsZWFyX2h3cG9pc29u
ZWRfcGFnZXMoKSBpcyByZWxvY2F0ZWQgdG8gYmUgY2FsbGVkIGVhcmxpZXIgdGhhbg0KPiA+IG5v
dywganVzdCBiZWZvcmUgdW5yZWdpc3RlcmluZyBzdHJ1Y3QgbWVtb3J5X2Jsb2NrLiAgT3RoZXJ3
aXNlLCB0aGUNCj4gPiBwZXItbWVtb3J5X2Jsb2NrIGh3cG9pc29uIGNvdW50ZXIgaXMgZnJlZWQg
YW5kIHdlIGZhaWwgdG8gYWRqdXN0IGdsb2JhbA0KPiA+IGh3cG9pc29uIGNvdW50ZXIgcHJvcGVy
bHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3Jp
Z3VjaGlAbmVjLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+DQo+IA0KPiBMR1RNIHdpdGggc29tZSBuaXRzIGJlbG93LiBUaGFua3MuDQo+IA0K
PiBSZXZpZXdlZC1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQoNClRoYW5r
IHlvdS4NCg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VMb2cgdjQgLT4gdjU6DQo+ID4gLSBhZGQg
UmVwb3J0ZWQtYnkgb2YgbGtwIGJvdCwNCj4gPiAtIGNoZWNrIGJvdGggQ09ORklHX01FTU9SWV9G
QUlMVVJFIGFuZCBDT05GSUdfTUVNT1JZX0hPVFBMVUcgaW4gaW50cm9kdWNlZCAjaWZkZWZzLA0K
PiA+ICAgaW50ZW5kaW5nIHRvIGZpeCAidW5kZWZpbmVkIHJlZmVyZW5jZSIgZXJyb3JzIGluIGFh
cmNoNjQuDQo+ID4gDQo+ID4gQ2hhbmdlTG9nIHYzIC0+IHY0Og0KPiA+IC0gZml4IGJ1aWxkIGVy
cm9yIChodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIyMDkyMzExMzQudG5oS0hS
ZmctbGtwQGludGVsLmNvbS8pDQo+ID4gICBieSB1c2luZyBtZW1ibGtfbnJfcG9pc29uKCkgdG8g
YWNjZXNzIHRvIHRoZSBtZW1iZXIgLT5ucl9od3BvaXNvbg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2Jhc2UvbWVtb3J5LmMgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICBpbmNsdWRlL2xpbnV4L21lbW9yeS5oIHwgIDMgKysrDQo+ID4gIGluY2x1ZGUvbGludXgv
bW0uaCAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgbW0vaW50ZXJuYWwu
aCAgICAgICAgICB8ICA4IC0tLS0tLS0tDQo+ID4gIG1tL21lbW9yeS1mYWlsdXJlLmMgICAgfCAz
MSArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIG1tL3NwYXJzZS5jICAgICAg
ICAgICAgfCAgMiAtLQ0KPiA+ICA2IGZpbGVzIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDMx
IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvbWVtb3J5
LmMgYi9kcml2ZXJzL2Jhc2UvbWVtb3J5LmMNCj4gPiBpbmRleCA5YWEwZGE5OTFjZmIuLjk5ZTBl
Nzg5NjE2YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvbWVtb3J5LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2Jhc2UvbWVtb3J5LmMNCj4gPiBAQCAtMTgzLDYgKzE4Myw5IEBAIHN0YXRpYyBp
bnQgbWVtb3J5X2Jsb2NrX29ubGluZShzdHJ1Y3QgbWVtb3J5X2Jsb2NrICptZW0pDQo+ID4gIAlz
dHJ1Y3Qgem9uZSAqem9uZTsNCj4gPiAgCWludCByZXQ7DQo+ID4gIA0KPiA+ICsJaWYgKG1lbWJs
a19ucl9wb2lzb24oc3RhcnRfcGZuKSkNCj4gPiArCQlyZXR1cm4gLUVIV1BPSVNPTjsNCj4gPiAr
DQo+ID4gIAl6b25lID0gem9uZV9mb3JfcGZuX3JhbmdlKG1lbS0+b25saW5lX3R5cGUsIG1lbS0+
bmlkLCBtZW0tPmdyb3VwLA0KPiA+ICAJCQkJICBzdGFydF9wZm4sIG5yX3BhZ2VzKTsNCj4gPiAg
DQo+ID4gQEAgLTg2NCw2ICs4NjcsNyBAQCB2b2lkIHJlbW92ZV9tZW1vcnlfYmxvY2tfZGV2aWNl
cyh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIHNpemUpDQo+ID4gIAkJbWVtID0g
ZmluZF9tZW1vcnlfYmxvY2tfYnlfaWQoYmxvY2tfaWQpOw0KPiA+ICAJCWlmIChXQVJOX09OX09O
Q0UoIW1lbSkpDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiA+ICsJCWNsZWFyX2h3cG9pc29uZWRfcGFn
ZXMobWVtYmxrX25yX3BvaXNvbihzdGFydCkpOw0KPiANCj4gY2xlYXJfaHdwb2lzb25lZF9wYWdl
cyBzZWVtcyBub3QgYSBwcm9wZXIgbmFtZSBub3c/IFBhZ2VIV1BvaXNvbiBpbmZvIGlzIGtlcHQg
bm93LiBCdXQgdGhpcyBzaG91bGQgYmUgdHJpdmlhbC4NCj4gDQoNClJpZ2h0LCBJIHRoaW5rIHRo
YXQgdGhlIG5hbWUgbnVtX3BvaXNvbmVkX3BhZ2VzX3N1YigpIGlzIGNsZWFyIGVub3VnaCwgc28N
CkknbGwgb3BlbiB0aGlzIGZ1bmN0aW9uLg0KDQo+ID4gIAkJdW5yZWdpc3Rlcl9tZW1vcnlfYmxv
Y2tfdW5kZXJfbm9kZXMobWVtKTsNCj4gPiAgCQlyZW1vdmVfbWVtb3J5X2Jsb2NrKG1lbSk7DQo+
ID4gIAl9DQo+ID4gQEAgLTExNjQsMyArMTE2OCwzMyBAQCBpbnQgd2Fsa19keW5hbWljX21lbW9y
eV9ncm91cHMoaW50IG5pZCwgd2Fsa19tZW1vcnlfZ3JvdXBzX2Z1bmNfdCBmdW5jLA0KPiA+ICAJ
fQ0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICsNCj4gPiArI2lmIGRlZmluZWQoQ09O
RklHX01FTU9SWV9GQUlMVVJFKSAmJiBkZWZpbmVkKENPTkZJR19NRU1PUllfSE9UUExVRykNCj4g
PiArdm9pZCBtZW1ibGtfbnJfcG9pc29uX2luYyh1bnNpZ25lZCBsb25nIHBmbikNCj4gPiArew0K
PiA+ICsJY29uc3QgdW5zaWduZWQgbG9uZyBibG9ja19pZCA9IHBmbl90b19ibG9ja19pZChwZm4p
Ow0KPiA+ICsJc3RydWN0IG1lbW9yeV9ibG9jayAqbWVtID0gZmluZF9tZW1vcnlfYmxvY2tfYnlf
aWQoYmxvY2tfaWQpOw0KPiA+ICsNCj4gPiArCWlmIChtZW0pDQo+ID4gKwkJYXRvbWljX2xvbmdf
aW5jKCZtZW0tPm5yX2h3cG9pc29uKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArdm9pZCBtZW1ibGtf
bnJfcG9pc29uX3N1Yih1bnNpZ25lZCBsb25nIHBmbiwgbG9uZyBpKQ0KPiA+ICt7DQo+ID4gKwlj
b25zdCB1bnNpZ25lZCBsb25nIGJsb2NrX2lkID0gcGZuX3RvX2Jsb2NrX2lkKHBmbik7DQo+ID4g
KwlzdHJ1Y3QgbWVtb3J5X2Jsb2NrICptZW0gPSBmaW5kX21lbW9yeV9ibG9ja19ieV9pZChibG9j
a19pZCk7DQo+ID4gKw0KPiA+ICsJaWYgKG1lbSkNCj4gPiArCQlhdG9taWNfbG9uZ19zdWIoaSwg
Jm1lbS0+bnJfaHdwb2lzb24pOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICt1bnNpZ25lZCBsb25nIG1l
bWJsa19ucl9wb2lzb24odW5zaWduZWQgbG9uZyBwZm4pDQo+IA0KPiBtZW1ibGtfbnJfcG9pc29u
KCkgaXMgb25seSB1c2VkIGluc2lkZSB0aGlzIGZpbGUuIE1ha2UgaXQgc3RhdGljPw0KDQpUaGFu
a3MsIEknbGwgYWRkIGl0Lg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
