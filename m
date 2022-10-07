Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59C5F7260
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiJGAwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiJGAw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:52:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2049.outbound.protection.outlook.com [40.107.113.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40332BCB86
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNVBZHkAsTcKCF1zEm4+Tw5OuqpUjw1XiPwRk3CAjtG6GmttHGzprWjCLcbPdq4GmIoU26MavBbgkqNhdYZq6TacYf6V2RAHijoLeXHx1SEMZFWaY2UipIkkrXOYbpqZYA0K4SDTznKUKTwysftU+uD1GjI9efHXUVJ/GEB8tlLcLzXpu+Dky24JDikkk+BDn8qYOwbudobc/TUq6b9waknkxySB2QgmwFZpDaU4zM+ceqdHYVqDY077MLbl4g2mm+jy6OF5F3QSVNNonMB9oggdagl2WkcPVfXJAvSWAJCWwfN/+XXHy80EDRdonrfREFXiB/0ybqbhwlidmkzPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDTA1DLhSCzSviFivc/wiB4nMVr3XliDmghjW1o7e14=;
 b=WQfGmPAN5md3lThf1pM9PEZXYSJd2oFgPr0WjM/Qim49c0rYNys5IwS+INBi+ETZiA+2AQO5oeD0MviVFgIH+Ha2VjVOmwLwFY6Xnqke/ot3bLiBZOU13R2y+ueD3RMsla4BpycFUCouQ315bXmtFfEHqWJCpzhM6YHnsitst/nWYq1WAHP9GOIV70UcbicOmRYpQQ4R0QH24fcSrQdt1SbVzh+mgKg1cONYoN7MoLNShyUoQPbFaLlSqubwsJ2O5AQmw2WcRZrlQfhxX8DUCBg8o77SSzhg1bZ54hgF1BOl11kaN7aUZxYCTBv2m2Y6nqLYWoYtluGs8xrfxu/4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDTA1DLhSCzSviFivc/wiB4nMVr3XliDmghjW1o7e14=;
 b=MopiRYZPlI7H0mQjcaQPX2fneHzDZRgseDEg7xIwl0bKS9v7GgNoXyiH4cmv28I9jxvbYewl6J36xGGbw4asaAHeAgW80X9bUfvEiUVFcirUGDh5U/oCYn7SjTBT8JKPkDRznpvTYqcCwum/bYGsGDDWV2/3SDdVP77DadeYLlg=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB10149.jpnprd01.prod.outlook.com (2603:1096:400:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Fri, 7 Oct
 2022 00:52:24 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673%8]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 00:52:24 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
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
Thread-Index: AQHY0X6vlcBWFWa7BkC5YnGY49sNB64CKyGA
Date:   Fri, 7 Oct 2022 00:52:23 +0000
Message-ID: <20221007005223.GC3227576@hori.linux.bs1.fc.nec.co.jp>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-5-naoya.horiguchi@linux.dev>
 <20220923082613.GB1357512@ik1-406-35019.vs.sakura.ne.jp>
 <20220923141204.GA1484969@ik1-406-35019.vs.sakura.ne.jp>
 <a99f0684-b075-7fc5-082a-2c0cc706574b@redhat.com>
In-Reply-To: <a99f0684-b075-7fc5-082a-2c0cc706574b@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB10149:EE_
x-ms-office365-filtering-correlation-id: fa07fe3e-1121-4317-bd44-08daa7fe32a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMFeUzrZLLtOmSHRDU9TaEvaBUeUH5BG4/M4hYfSNMrF4uHCziIFDiZsE0CXpTT4Qv8Le7ezR0vuo09OVK33JL2A6iKDKgd13T8K1qBzaOgv/8q6F9VPmf3J1qPdU581cnBamUppj1XZlIu3rUjkb1LcXpAiCy+tzXVLGBzvnS0lpJwFL6IkNqmrIXMjam+YnuzmWMQ+Zb8KrK9CkSDv0GQB16zzUuED7HS78aOBwSv2YDzP62A1S8TTpjbEWU3bfNCn7r4STxC1idoZXWgqabBzTn+slbzFMp9P3F8FCsx4iVaZqE1J0KnYD7NwiAw5dkboM4jE46EddVyDs3ONQuuC1s+iDvYdUmzwnMeXVBhDme/2vqG3bZDQZu0pyZY8UfLaodkG5pYhJVclZljWg/WJrQFqGszCQDeAu3tAUtMf4/xx3qEYXI7BGGjlmAkicxG/s0td9kRF+3fOG2AVc2yp4DR4HgpFIl/kUtf+zYndSORkNqsCmTZu7v8Mlq/aYX3jxPtKxCS5lrg0VzSogCb8f57a/PvQtHpv/xcbDfh5VH36wZ/UhgcoO7yTMQ5nJu0oXqFIIXjhZELBwHXGR0wcgSZO39tzZ6OhzV5OI/87A/gnsOkSf27Yl17IWJDpxsT3piQaKFyWU8DGOs9VpvpI1KR+t0KyE4ccdJSh8+OspIarea7JdaIc7logRGnlIjyjDl1FQfOoH46IAE3LjQT2UY31l4Fzr2wZHh5I0NCI53PjQ9C7rbW0VA2MgYKfV4INQN1K9BPHmCi/Hvyzww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(71200400001)(6486002)(85182001)(478600001)(316002)(8936002)(66446008)(5660300002)(66556008)(38070700005)(186003)(122000001)(38100700002)(64756008)(66946007)(6506007)(76116006)(33656002)(6512007)(54906003)(8676002)(2906002)(1076003)(66476007)(4326008)(6916009)(7416002)(26005)(83380400001)(82960400001)(86362001)(4744005)(41300700001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHQySHBOTmVLdC9xaStPZXBac3RGL2VCMWltRkZ2QmdUeVdhNFV2eFdDOHY4?=
 =?utf-8?B?RUpLZHA3OSs1QklWK25DRmdUcjhhTHdiNWxENmp5RHNXRW9Ba0dPSDZWSk1h?=
 =?utf-8?B?aGxqdklFbndrZkp5eG9wWE41Y2FpdDBnQTZ6MVlWUFUyZExWTTNreWtUL3di?=
 =?utf-8?B?SlhNdFowQW9WWEpOSkV2Z2RZMStRcW1BT2t1ampjVlJ3eVRRTnRvVjdZdXJp?=
 =?utf-8?B?ZVU3dmQrQWVlVDBvNFNoKzRTZUJMYVZ0VzBKUjBDUVJmZm9KclA1T1E4NmNO?=
 =?utf-8?B?NG5KQzNYYUJVcnRRYmhEb0FCNEtHazV1TGRYZUpvR1pOYUlZRS9xUzExS2dR?=
 =?utf-8?B?Qkt1V2dYaHFNenZoeUpEUE5uODNnOTNMNHliaHVlQ3g3WmIrQkpUR3ZRODg0?=
 =?utf-8?B?Q0xKclF6YnhlL1lsZ1hld3dTSHlzZDA4ODFCQTQzQ1VMQjdoSkZJdkF3OFIr?=
 =?utf-8?B?UDZlZ3M4TDhmOWc4M1BUN21zQWNva1N3L2RmcWFqWmFxUlhuNVlCWXdnSit3?=
 =?utf-8?B?MkNxeTFOa3ViSEVFWERIU3h6aUNZK0t2T3NNZlVNN3hud2V4RWliZHYxaVhW?=
 =?utf-8?B?czVURmx1cXRkd0FPVlFIUituY0JEYWl0UFVyQ1FQLzg5Q2VPd2ZRYWViRnZm?=
 =?utf-8?B?bTFKNnUyQjFaT0Q0dUhWWkl6RjBzSXprRXVtb1Q0NkdKRWR0QVI1aEowT2ky?=
 =?utf-8?B?N1JsV2FORUx3VHZrWHBleHhrOUV6US9PSkErOFc2c0l3MTgxYWhmNzRWKytT?=
 =?utf-8?B?STd1WGFCL0ZpbFpuQi92UkgvTERtWVh0OEJYZXNEeXFRYnIydk80NzdIb2pj?=
 =?utf-8?B?MklZb1pjWnF1L2ZLY3gxbXFPTHVEcXdjY2x3ZFBlYVhuNitPckRCa2RBYXV0?=
 =?utf-8?B?WjlCU2dqNGd1Uno2eVhBODdhN2RINGorK2F3WUhvZ1hoYlh6NnhselBFL01m?=
 =?utf-8?B?cWdQUmdsV0wvaFNkN0ZISUZwUHlldUx5TEd5N1FxZG5rc2RLYUEyU1V1Qnox?=
 =?utf-8?B?amdmcUxDaUFuenJhVUNYZ0orT1RoQng1SHJERjJqRWU3V3FMZEVGM1gveHBE?=
 =?utf-8?B?QnBEYmtyME8wTHVzSkcweHp3cHk4cDdIdC92QWtIR1VxdXp6L1ZrbGtQSjFy?=
 =?utf-8?B?QnJhOG5WUmVHZFh6eDdIblNERnZiT3lSSjNKMVYzVUhObWE2L1ppRjd5ZXVm?=
 =?utf-8?B?Wm9TV0RrWVdDSGczS3V2S2VvOWVIbThVeGZ5eTB1QzZkMFNuQXptSVlyL3RM?=
 =?utf-8?B?MTdJM3ZnRkx0VnoxZGFWTnBHWWVJanRyUVVQT2gyRnZxUW0zeXdJdEp0V1lN?=
 =?utf-8?B?aExJcVpMaVpKTVhZSHJReU01WlpGQ0Y1SVFYejhUSjB5Tm00QmxrZHlnZUFY?=
 =?utf-8?B?Y3FiUE1nRExxWUYvUkFKUmFVc1hUZnp5NDhENk5VWXhlVnpwOFFCYk1ES01V?=
 =?utf-8?B?bjRPc0tuaStNYVdyc1RRRXQxN0dtUUkyMC8zbVdYU25kMmpYNkdoVDRVaTh3?=
 =?utf-8?B?bFFJM0RkNWFCUFkvK0xIWDh2WG83aGptQnd5Nyt6WEdDNGpmYldRZjBkN3ZJ?=
 =?utf-8?B?QXBQdVliUlR6NW0xK0lIY2NHYnZ1ZWJrWkg4bzZ2RjgyVlZvaUg3MHBBWWJZ?=
 =?utf-8?B?ZG5ISFE1MngwUjBuY2p6Rk16aVJrVThCMDRXZTFoMWYwSGlhMkRicmQ1Rkha?=
 =?utf-8?B?MXVLMHdwRG1QbVVVcDBadXl1c0cydUFFZmtKNDBSM3pSRFdFMzN5Z1VBS0wy?=
 =?utf-8?B?RGQwTGxTMmdCSXZxLzFOc0htMEZzSzJ3ZXljcUJiRG0wY3B6KysrcVVsYnl5?=
 =?utf-8?B?cFhsdmdBMkxWMTJVcnBtRFRrZU9LZFpqYVVvMFVZanV2V3ZjR2JsVUQ2bW1m?=
 =?utf-8?B?d1RZaURYSVlOOHZXek90dG1KckdiUGJKNWoxUmlxRHZtMlNOS3NCYUpBMGZJ?=
 =?utf-8?B?d3FWRi9xd0hiMU03bW1VLy82dW5wSFNxb2xiamQraXNqb3pqOWZRYUJ5aEVG?=
 =?utf-8?B?R1dPL2xCbmJ2Wk4zZ21zejYvbWxVT3dkT0FiZWNyR01jeDd3OWVWMjRycHEy?=
 =?utf-8?B?TlZ5a3ZEVkh1SFRVb1Y5V2VzYXNFeWJKTnVzNlVCMENiekRlc2FZZG1DejVt?=
 =?utf-8?B?MC9SY3hWOHo5Ri9HVmYwV3hpRFYyZUFWeEM3TjJnV1lCS2kvZDJmSUtSMnpy?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <264AFC879F877E45B554B646FE553D5D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa07fe3e-1121-4317-bd44-08daa7fe32a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 00:52:23.9117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owRnCeBVO80ekPw+eKi5aw7OsE9ZWQyi7uop6jJKjOt8DJ/43Qs/nqn5NBbn5C453uYHsUFTgKgHnZ7AN7ktyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMjYsIDIwMjIgYXQgMTA6MDU6MDVBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+ID4gICAvKg0KPiA+IEBAIC0yNDE0LDYgKzI0MTcsMTAgQEAgaW50IHVucG9p
c29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBmbikNCj4gPiAgIHVubG9ja19tdXRleDoNCj4gPiAg
IAltdXRleF91bmxvY2soJm1mX211dGV4KTsNCj4gPiAgIAlpZiAoIXJldCB8fCBmcmVlaXQpIHsN
Cj4gPiArCQkvKg0KPiA+ICsJCSAqIFRPRE86IHBlci1tZW1vcnlfYmxvY2sgY291bnRlciBtaWdo
dCBicmVhayB3aGVuIHRoZSBwYWdlDQo+ID4gKwkJICogc2l6ZSB0byBiZSB1bnBvaXNvbmVkIGlz
IGxhcmdlciB0aGFuIGEgbWVtb3J5X2Jsb2NrLg0KPiA+ICsJCSAqLw0KPiANCj4gSG1tLCBidXQg
dGhhdCBoYXBwZW5zIGVhc2lseSBlLmcuLCB3aXRoIDEgR2lCIGh1Z2V0bGIgcGFnZSBhbmQgMTI4
IE1pQg0KPiBtZW1vcnkgc2VjdGlvbi9ibG9jayBzaXplLiBXaGF0IHdvdWxkIGJlIHRoZSByaWdo
dCB0aGluZyB0byBkbyBoZXJlPyBUaGUNCj4gVE9ETyBzaG91bGQgcmF0aGVyIHNwZWxsIHRoYXQg
b3V0IGluc3RlYWQgb2YganVzdCBzdGF0aW5nIHRoZSBwcm9ibGVtLg0KDQpXaGF0IHNob3VsZCB3
ZSBuZWVkIGhlcmUgaXMgdG8gY2FuY2VsIHRoZSBwZXItbWVtb3J5X2Jsb2NrIGh3cG9pc29uIGNv
dW50cw0KaW4gZWFjaCBtZW1vcnkgYmxvY2sgYXNzb2NpYXRlZCB3aXRoIHRoZSBodWdlcGFnZSB0
byBiZSB1bnBvaXNvbmVkLg0KSSBmb3VuZCB0aGF0IGl0IGNhbiBiZSBkb25lIHdpdGggYWRkaXRp
b25hbCBzZXZlcmFsIGxpbmVzIG9mIGNvZGUsIHNvDQp2NiB3aWxsIGNvbnRhaW4gdGhlbS4gIFRo
ZW4sIHRoaXMgVE9ETyBjb21tZW50IGlzIG5vIGxvbmdlciBuZWVkZWQuDQoNClRoYW5rcywNCk5h
b3lhIEhvcmlndWNoaQ==
