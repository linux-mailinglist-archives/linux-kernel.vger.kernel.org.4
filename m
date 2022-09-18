Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646E5BBF2D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIRRnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIRRnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:43:23 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96177120B4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbJmUelGZxN/RnQmxprq797Hcrhjw5n6WB2ON7dKkBoYacmkAi0/6ZeUWxHK0Lx6uzkF51niKlYsKniWXFin9CTiaGa0Jv+ZgNptub8h0D+L1PCSHFQFj9K+5zPIpI4BayBk2eHYjSZrJmlspTAxWdBIQs758m0JCofazc/m3MFgLiB7Xq9FdS5itGqx5Lw0S4Bs3zb9pVuzCdeZCdAZc+oQxlYf/VmkEMdSP6lQZKCv0u2Vt0YwTQzgV4gxnY+f039rvhx1DOmF/I7QYtCblYWeZaTgzyrkbbNXbjXKwRxSaw1RaaQS7fdIuaey7pt8GK6ucKpQD/ymUxKJ0ei/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbLkpa5J8QNXLnWkSBq3B1Ru2CRvq1/9KnKQO21XOU0=;
 b=bddtKpdxVx9LHbTQm9hbABdWcX3Le39Y4PN2RoNIOuQ5teL+8UR2REU6wpvMo1D/lcoVYq057mGtI4tgNykGOENYd3bP0LAjtdAlD0ODkuHhBvTynYE15l4jRjB3W7/8L4fhqzWVCF0FJlhUdM0UQMcYYyP8FNrPDDXQiGAtPtLGqTkjl8q9tqYwd+rLGDsh9hI69gEpAFA+gNF61DYvnh7XTPRJrIT1/nRX3lD/rMXrdYBIgT9CQ/NJwwMskQwgSI6aEcOfD2zPvmd1nPMx0mDv9I4NZR7983JfM4/7Ygqdd5RZuVd4gHjn7w/pp/Re5yi08WNMusl7BFVjEgGwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbLkpa5J8QNXLnWkSBq3B1Ru2CRvq1/9KnKQO21XOU0=;
 b=GltrFesxPp1uLc5VHolEoMcMnR/qUySpLLTSp/PLF1yF4pZ855CEE37tsgywPwYKxVxcUrHXreStvNyqcydzfZ8uv3DqtTwFNB5WMpCakCO0UHS9sAeEqNSrg6zJ/gR5j1+HTvnF3gJz1dDM6sjowbnsoFuqDssd1Cai2hSfvUs=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CY5PR05MB9045.namprd05.prod.outlook.com (2603:10b6:930:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.12; Sun, 18 Sep
 2022 17:43:17 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5654.012; Sun, 18 Sep 2022
 17:43:17 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>
CC:     Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix repeated words in comments
Thread-Topic: [PATCH] mm: fix repeated words in comments
Thread-Index: AQHYy0W1aL2z0VLyO0ynuO+0ujw1JK3lSn8AgAArOQA=
Date:   Sun, 18 Sep 2022 17:43:17 +0000
Message-ID: <5443DF6A-0154-47FD-8347-DE3464A1CF03@vmware.com>
References: <20220918100125.25558-1-yuanjilin@cdjrlc.com>
 <b38433a9-191f-9ba8-3230-edb962867bad@infradead.org>
In-Reply-To: <b38433a9-191f-9ba8-3230-edb962867bad@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CY5PR05MB9045:EE_
x-ms-office365-filtering-correlation-id: e762d1e7-fc32-4bb7-fb93-08da999d451e
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NfsrCnsI1j9sfmLILSXeWf6B9td0kE4v5eD+UU2JxnrRT/6+dgLMSC7bSt1aH+ZV6myyC4qOdC9UCrtGfWONpNxrLFbfXcYQqdVX6cFERTZ3Cr4i8i7zaoCqWMf2nyW8vBIQ9DRiGf9lTe3XcO3iLGcQWX/nTM3U+ik6t3AKeoHSsZ+uxOk3HIL7Oai55bK3rzcj407TsGIHqcAV9daNz/kbeggQyFYNrlF4FNCG2Tpwahlc8dpnkHYeCB4ylEoRvC2WhebTfSvlpFeIBfkuuRdfm/8oSKt+nSXrFxEBuI4htyLr0PvqAvMW+p5DdqgqKxYxG/28DFm8RSMq0XwCeZ7QX8Vt0MqUdGATZAzIdu77UZhznxjGjfXwi3oNq4U8jroYP3CWbEk7VuHwWW9PLQUYSrOzzg1H+xcr1MdWFke79buyqjS8wDk5NjIW16pmQHYIoLO2piCXqi3YBjGl5PzrKIptns6KBGeIDTrsUqNE7oqNdFl6k99idr9osxSJIjX+dDZ+SbXSrWUQzkMVElb8foiPyQ5/SgeHUHVUxoFO2q5WDAF8zcMNYzuUJauGqBXe60rbDqi8JorbZIKQE7HpRyWwyH/Zur7Lpw5yPmOQ/IxZf0MjMgmSOQ5LRcjfXHIxXQeT/K/303YxyrpTDpLn2H6dPKleu20gOnCLbZyjobEeFXxfKz/QXKRv8ZNxK1U+B1JaL6oSvrkkc0kBIziYwdGU62bXc8aojaqU9wHaXMNjGxysRXzQQZlCQ6sIZzQ1CChH15AzATV4vD4dCTTBMA+GPTSHdhy2GsriCTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(36756003)(33656002)(478600001)(316002)(6486002)(83380400001)(122000001)(38100700002)(2616005)(186003)(38070700005)(86362001)(26005)(71200400001)(2906002)(110136005)(54906003)(53546011)(6512007)(6506007)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(41300700001)(5660300002)(8936002)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1ZPcXFwcmJEalM1djF4eU9Zam1nc1ltR25jb2ZRNi9PMFczZmdiZGpOY2JK?=
 =?utf-8?B?UW1qVkp0aWJJWVgxVWtGS0lvU3JEVHdGeGFFZnJuVmFoU1ZweWkxMjhaeXVX?=
 =?utf-8?B?amo2dk1lKy9kZ2tORFg4WWJMQjNkNVdnSjVDOFU0b2h5ejNUazlHbHZkQ2p2?=
 =?utf-8?B?VTBaeGdqTVFtTk1McVdyUkE2WnBsa1ZsUlY5SnBKNXNMRHA4T1d1SytLOTUx?=
 =?utf-8?B?UTk3dlFYVWZZVnNjRlZUNURlTkp0SFc3Tjhaa0lWQXVrNnovcnlXQlZrM2d1?=
 =?utf-8?B?Wk11RUVHNllOV2hHenZEQ2tyblB4ZWovU3dDR1krZFUvNUI2TEQxdytvK1h0?=
 =?utf-8?B?WjBlSkplRXhSZk9LdEpLbGJIdGxlS3A4aHRrTTVIekNvdTB0VXBkM3hwOVJE?=
 =?utf-8?B?RkNUZmFzbTNKRlhNalY4WFhhMk5BaXlkZTZlclRNRkordUlaTWZCbmVIZEhk?=
 =?utf-8?B?YlV3dktMT2pETjM0OHJKSCtyaWVqOG56QUlTeHhGOUg2ZDNRMVU5c3dLNS83?=
 =?utf-8?B?LzJpSXRmZEVKZHVpaUpSN0hMSnYrWmU1Z2VGbW5jdU41SzJoQ1o2ZjF2VnpC?=
 =?utf-8?B?ejdRekZjNE5VNy8vYnN3ckRWbnpNajNwZWMrQTkwYkFlYzUyS0IxbzltVTYw?=
 =?utf-8?B?YjZpL2Frb3lRK3VQNTYyVEU2bzdZdnpaVGRoc3dtLzJGcDF1WThFaEZxZnBa?=
 =?utf-8?B?VlE2V0V0M3ljL2twRUZvRkcxTGNLV3p5bFZ5emVRblA4YzVHYU0rWEkwTEtJ?=
 =?utf-8?B?S25VMWpEUmczQnFGWGVuY21pNjN3bEtkVGZockVIdkYwcjBMeGlHci9NbE5S?=
 =?utf-8?B?TFJlVTRHTFNmZ3JNeWhVL0N6aXZiZkxtQmxjVE1TcE5OZkhMQmhqeXNDeVZq?=
 =?utf-8?B?TmdJdXVsNVdONUZDZm5RdHBUV2oxRG5xMCtvZ3RxclVBVUdBOFFpMVlSQ2xl?=
 =?utf-8?B?WGN5bm1MeWJYRll3eGx0TDV0akxyMHo4SGtCM3pmTGlPZEFuUXhkMXc1NFUv?=
 =?utf-8?B?UzZCSVh5cE9za001QmpkMzhaYmpDRExQVTJocXFka1VlYmdZMUhCN1VoeUYy?=
 =?utf-8?B?UjVEYXhsUE5Yd3g2ZjFUUGtaMU54dXB6R05WZTNDSzhaWGV2bVkyRXRIcTNa?=
 =?utf-8?B?WWJrMENobGhZM1NjUm1tWHFxUkFuU0ZmaWxRSVVKSEo1UllZdUwxRTZzRUpz?=
 =?utf-8?B?ZkxxbXN6VjFpMmZBaU5RREVQZTdrVmVYRWZCeCtEUTZDanJFUW16RHp2RSt2?=
 =?utf-8?B?YW5rOEtCZjBMNU9OcGZhTWNXYTJIWDIwZnhJaWhRQnhBWEp2ZUVrVDZNNER2?=
 =?utf-8?B?aThmeUhXRC9yWHdscGZyUUpCcytKeTBhTVQ5WHd6aHNEdzFaQXlXaHNOb0M0?=
 =?utf-8?B?S1I3WG1aRjlTeGkvb2FoOFloTnlUQzVPLy9UM0tvaE92L0pJVTUvYWVPMU9p?=
 =?utf-8?B?UmR6UEFWWVRlMDlkT3lHbDdrTTYrZEJxcmxPSU9ZMEg4TGtYV3V0N2kvSUUv?=
 =?utf-8?B?RGlKdHNrd29xb3NPWHFBMFovbWdSRFpENmJmVzNHWkUvbDJCcGNmZk56eXZ0?=
 =?utf-8?B?YTVFNXphSXI5TTExdkw4RmRRK1Q4ZVdEZ3ZqMHRBL1RINnMrQ3dmK1RzQ3Ux?=
 =?utf-8?B?aFhEd0Z1NVd2Q01GcmRpY2NMZU91L0laQ0pXMWRnaWRneHlQcVNHbzU0NzVH?=
 =?utf-8?B?dysyNXVYaGhndXpQajBTSGNINGM5T1VvTDkrRElCdnJkdkh0STRhSi9qSW8v?=
 =?utf-8?B?T2JvbGJtQnFpa3oxZmxwVytCcUlUVkpPdnpCYU5zcG0xYTVtOExpUzBnM3Zx?=
 =?utf-8?B?OWE0ZkEzODRVeVJzRXBaZjNnQUtTT2gyNXV4aUE1bWsweDkxSkVCUmdVcFc5?=
 =?utf-8?B?dnNEZzhNdVBkWWVkdHpzdGg0YlpFWVpvam9qQnMwdDZ5cnF2VEhsS0hLZWQ0?=
 =?utf-8?B?bXdoNVUybG44emQ3RVJuaklPYW8vWDBDTjA4YnJlakZpbiszWm1KL282aXlJ?=
 =?utf-8?B?RUUvelBtM0c4bXJtWUlPbkhDbDFJZUZhdjVBZDJxTERKdWVlOU9ndXRsMHQv?=
 =?utf-8?B?UUJORi9lVnJzb2IyUm5Za1QybkVSSUdPY25Jd2VhRyt6QjdlM1prcUhHeVBi?=
 =?utf-8?Q?LJDIy1FuoRX37di7c0mk0QHQx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F54E51BEF080147975689D9F073B6F5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR05MB9045
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2VwIDE4LCAyMDIyLCBhdCA4OjA4IEFNLCBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFk
ZWFkLm9yZz4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiA5LzE4LzIy
IDAzOjAxLCBKaWxpbiBZdWFuIHdyb3RlOg0KPj4gRGVsZXRlIHRoZSByZWR1bmRhbnQgd29yZCAn
b24nLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBKaWxpbiBZdWFuIDx5dWFuamlsaW5AY2Rqcmxj
LmNvbT4NCj4+IC0tLQ0KPj4gZHJpdmVycy9taXNjL3Ztd19iYWxsb29uLmMgfCAyICstDQo+PiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jIGIvZHJpdmVycy9taXNjL3Ztd19i
YWxsb29uLmMNCj4+IGluZGV4IDYxYTJiZTcxMmJmNy4uYzJlNzc0ZjY4MTMzIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9taXNjL3Ztd19iYWxsb29uLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWlzYy92
bXdfYmFsbG9vbi5jDQo+PiBAQCAtNzM2LDcgKzczNiw3IEBAIHN0YXRpYyBpbnQgdm1iYWxsb29u
X2hhbmRsZV9vbmVfcmVzdWx0KHN0cnVjdCB2bWJhbGxvb24gKmIsIHN0cnVjdCBwYWdlICpwYWdl
LA0KPj4gICogQHA6IHBvaW50ZXIgdG8gd2hlcmUgdGhlIHBhZ2Ugc3RydWN0IGlzIHJldHVybmVk
Lg0KPj4gICoNCj4+ICAqIEZvbGxvd2luZyBhIGxvY2sgb3IgdW5sb2NrIG9wZXJhdGlvbiwgcmV0
dXJucyB0aGUgc3RhdHVzIG9mIHRoZSBvcGVyYXRpb24gZm9yDQo+PiAtICogYW4gaW5kaXZpZHVh
bCBwYWdlLiBQcm92aWRlcyB0aGUgcGFnZSB0aGF0IHRoZSBvcGVyYXRpb24gd2FzIHBlcmZvcm1l
ZCBvbiBvbg0KPj4gKyAqIGFuIGluZGl2aWR1YWwgcGFnZS4gUHJvdmlkZXMgdGhlIHBhZ2UgdGhh
dCB0aGUgb3BlcmF0aW9uIHdhcyBwZXJmb3JtZWQgb24NCj4gDQo+IFRoaXMgd291bGQgbWFrZSBt
b3JlIHNlbnNlIHRvIG1lOiAocy9vbiBvbi9vbiBpbi8pDQoNClllcywgeW91ciB2ZXJzaW9uLCBS
YW5keSwgaXMgdGhlIHJpZ2h0IG9uZS4gVGhhbmtzIFJhbmR5IGFuZCBKaWxpbi4NCg0KSmlsaW4s
IHdoaWxlIHlvdXIgd29yayBpcyBoaWdobHkgYXBwcmVjaWF0ZWQsIGxvb2tpbmcgYXQgbGttbCBz
aG93cyB0aGF0IHlvdQ0KcHV0IHF1aXRlIGFuIGVmZm9ydCAoMTAwcyBvZiBwYXRjaGVzKSBpbnRv
IHRoZSBkdXBsaWNhdGUgd29yZHMgcHJvYmxlbS4NCg0KU2luY2UgMjAyMCBjaGVja3BhdGNoIHdh
cm5zIGlmIHlvdSB0cnkgdG8gcHVzaCBhIHBhdGNoIHdpdGggcmVwZWF0ZWQgd29yZHMuDQpTbyBh
bGwgb2YgdGhlc2UgbWlzdGFrZXMgd2lsbCBldmVudHVhbGx5IGdvIGF3YXkgYXMgcGVvcGxlIG1h
a2UNCmFkamFjZW50L292ZXJsYXBwaW5nIGNoYW5nZXMuIFVuZGVyc3RhbmRpbmcgdGhlIG1lYW5p
bmcgb2YgdGV4dCB3aXRoDQpyZXBlYXRlZCB3b3JkcyBpcyBub3QgdGhhdCBoYXJkLiBTb21lIG1p
Z2h0IGFyZ3VlIHRoYXQgcG9sbHV0aW5nIHRoZSBnaXQNCmhpc3RvcnkgZm9yIHRoaXMgcHVycG9z
ZSBpcyBub3QgaGVscGluZy4NCg0KTm93IGl0IGlzIGhhcmQgdG8gZ2V0IGludG8gdGhlIGtlcm5l
bCwgYW5kIG1ha2luZyB0cml2aWFsIHBhdGNoZXMgaXMgYSBnb29kDQp3YXkgdG8gc3RhcnQuIEhv
d2V2ZXIsIEkgdGhpbmsgaXQgaXMgbW9yZSBoZWxwZnVsIGlmIHlvdSB0YWtlIG9uZSBvciBmZXcN
CnN1YnN5c3RlbXMgYW5kIGZvY3VzIG9uIGZpeGluZyB0aGVtLCBhbmQgdGhlcmVieSBnYWluaW5n
IGRlZXBlcg0KdW5kZXJzdGFuZGluZyBvZiB0aGVpciBjb2RlLiBJdCB3b3VsZCBhbHNvIGFsbG93
IHlvdSB0byBpbnRyb2R1Y2UgeW91cnNlbGYNCnRvIHRoZSBtYWludGFpbmVycy4gVGhlcmUgYXJl
IG90aGVyIHRhc2tzIHlvdSBjYW4gY29uc2lkZXIsIHN1Y2ggYXMgbW9yZQ0Kc2lnbmlmaWNhbnQg
Y2hlY2twYXRjaCB3YXJuaW5ncywgdGhlcmUgYXJlIGJ1ZyByZXBvcnRzIG9mIHN5emJvdCB5b3Ug
Y2FuDQpsb29rIGludG8sIGV0Yy4gQXMgaXQgaXMgcmlnaHQgbm93LCBpdCBzZWVtcyB0aGF0IHRo
ZSBtYWluIGJlbmVmaXQgZnJvbQ0KdGhlc2UgdHJpdmlhbCBwYXRjaGVzIGlzIGluY3JlYXNpbmcg
dGhlIG51bWJlciBvZiBwYXRjaGVzIHlvdSBzdWJtaXR0ZWQgdG8NCnRoZSBrZXJuZWwuDQoNCkFn
YWluLCB0aGFuayB5b3UgSmlsaW4uDQoNCg==
