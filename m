Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4167DDF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjA0Gsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjA0GsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:48:20 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E41630A;
        Thu, 26 Jan 2023 22:45:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV5om6YK4UswUE+ftZVbf9obTodGVdDO/j8JlnApcmxTPwLZmyg1iIUYBTVyw69gY1XgsAD8bwwLh54dwZQlpMDHnqWQ86dlBMYejpmTyF4HTTi1kZlu0E0OtSQbpU04NEXw6TLaNrIivT+twxwzKTcUxouP2e5rn7MMzpNCwvbSQZJKuGa6pnKnkZtyT3t+fGJtKLQS5HrbKOwoHTdhMm/yXd1RuASYW0rFd+4d+I4sZ+6oQ8sYd/gMyKHnuPTZD4XsmBFm9VLIUPqGB1Ada0xrI8rKUXl59Q9Es723JeN1a7p1ngI0TF+Ii9fq4gZ1e5FM9xqQwxD/w15Uy2E42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BFLHIeab7XSDCYAmPCbl2ZFAXCKq2In362Wd2eteGs=;
 b=EavpSdQZHc4gL2/o01jcXWThdyG262td1/RwappG351UY6AJ4MAImn/Q5vLRzw1r5IKIGBxhOaxrjtb1qS3MQV8xdcd4VHoQv+VUnFW55jwtsl/3oyucC/krUSZnx3qchTkToLSYag55eE1HQYItZU2hUyJ4ju3ACLvJlxPnr09gwm6nHOyCUvAyGe/kYjtaZcoeiFSmQ7rHc1CCNf50FOOFBQxScswZiwca//ixC0Z6/LNcVjTj0bSx9BchHeYo9d5JrGuVdZleV+suqNbyMpMsueBQa4LpVmspdM3Sflaf11qOE1NOhb78SnMYak5poUy7CBvTdyAcbrNKGYKdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BFLHIeab7XSDCYAmPCbl2ZFAXCKq2In362Wd2eteGs=;
 b=CYQKj8XIpkKV6lLO3V+xWBy8kSbzVL3G8VPwclkuijEv8sS/x1rZ+iCylLUWZtBW9uEocwlzaMbVsCzm1UAi/BcmDaVIErmFFZ2M42tOSF5okbkJhRfGFDAmy3pITdzLv2lKzNoyLVLLE6vkl9/H3jY7n3WhIdlY2LWZ1Kymhr8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB5754.jpnprd01.prod.outlook.com (2603:1096:404:8059::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 06:44:26 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b%3]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 06:44:26 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 18/35] Documentation: mm: correct spelling
Thread-Topic: [PATCH 18/35] Documentation: mm: correct spelling
Thread-Index: AQHZMhpWCfbq1XFJhUiz5J+iPUh7MK6x0WKA
Date:   Fri, 27 Jan 2023 06:44:26 +0000
Message-ID: <20230127064425.GA3836285@hori.linux.bs1.fc.nec.co.jp>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-19-rdunlap@infradead.org>
In-Reply-To: <20230127064005.1558-19-rdunlap@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYAPR01MB5754:EE_
x-ms-office365-filtering-correlation-id: 1d84f687-8abf-4035-4caf-08db0031eeb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJ3a0AZ1h18YIFQo30nene7JGtCT4dx94S1K/EdlUSrks66KLsMF5c4QpqlyU1epX3afzvSiWMjBGlse6UYgQ2mnZ0yAoduYTWF55XuhSRXhWpU/LSirYwAj40Z1b1gmBvAK7NSLT6NQ4jVL2MwlqG/QaZbwTVufmiH9ZYVrd2/fFBlFxy9oN2x9sEu8kHxfGYxh6oa0ivH+h/VLmabuq+tKGwJzlvfNg5MPIMPMtU4N39tm0cyaRdS8rZy0jMl7stUzJ1kTJk40eAb1n96QBr+DW/sUKF1zN3V+5npuXrpi36EnTzLVLCi8UdEc00Hw0LvJiyapZX5zB6pd5vlQxXDqYuM5hBr1j4C39qqOqpbBI3aCHV4jfB3aNGVOQ03q2Wy/4UJsWEzKmcqscmI+txe+nZJujBPB2hTsmJ3wd922jhaf5O2/1L9oxkhgztHQuGMbrlpIoJCbi5FGrWLgLaBFcMJ2NwZit0LU4Fr3LYtIPWXWEZK6TzFLBEu982rS7ChNW/veqYTJrWKoGp+bF1qKB4c9cMI9tnwfnA/mslHi2oatvstA3qnuZIxRj+OKj4pl5jHmL/xPthBL0M35kluE3+YmCbhLxzEPmcvj9qRMBKvDMUa70jJfmj+hCY19TLxPAzmu+bN5mYGyg6YiBT6Ns5Xie5D0JikaxgwEu2snrhKZhRNbArMoO6Xak4P8rcZ/Fduaq/Mgc3oeQ8Z+bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199018)(38070700005)(41300700001)(33656002)(64756008)(66476007)(66556008)(66446008)(316002)(66946007)(76116006)(86362001)(4326008)(478600001)(6486002)(6916009)(8676002)(54906003)(85182001)(122000001)(5660300002)(4744005)(186003)(26005)(9686003)(6512007)(2906002)(8936002)(82960400001)(71200400001)(1076003)(38100700002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVBBK281dHJBYm9uSEs4SmQ2Y0VBTkhBWitISUVqTkpRL29Pb2cyTTV5MkpG?=
 =?utf-8?B?Q2Rzb2lLZkNJaVpPY2pzbURodFlDcHdQaXVOMWRQYUo4Umd5YThWUDFZWWpj?=
 =?utf-8?B?aHZrRm1LcVM0eHFQdE1DbXI0K0cyQ2FCYzlrbEdaL2RwRlhtdmRSN2hQc2hw?=
 =?utf-8?B?bFdzckszaXIvYUhKcUcvZ0VNb2llOGlJSVBZS05zM25WNnpWcXl5cWRMNysx?=
 =?utf-8?B?SWgwZTNkZEFrall2cTRlbGdsdGJuWkk4bFgzWkxzQ0d5OWs1bzZZbkpVeFo1?=
 =?utf-8?B?ZHdSNW1aVUIvelJxQzRPS2hwK0xjQytvMHhYVUtzNHpCYlc5ZVo5WXppb1Mz?=
 =?utf-8?B?L0Z2K3ZmRG1wLzZCOElKNlpXN05DYW1vanZXZUZ4dkNuMGJlWStFdThha0da?=
 =?utf-8?B?UStvVnVOS0hDM21oUUZVdVNjTFpuZis1TW1xZ0dJeHlLR1dYeDNzRGgxVU55?=
 =?utf-8?B?Qk9MeEh3QW5vL25rZ3FLSjZZa3c0YjJxMU0vSGhkQ0NrQ2MzWWlnN2w3Z2VQ?=
 =?utf-8?B?M2g3K0tqb0gxZGIvRTBuKzhFZUVDTXpON2tEdWdCbEpwWWIzRFFNU21PK2lo?=
 =?utf-8?B?SUNsZGo2YkVJK09uMGtXOHZFZk5LRnZFazJVL3RDVHAvSSt3endlUGpudEUw?=
 =?utf-8?B?dXdvY0NSa1VwS0ZUZmdBSkErdy94R09NYUc0alNJUkVMYWY0YlZmVGtCSnVy?=
 =?utf-8?B?Wkc5TkhzM3Bza3dCNVpPYk9xQnNLeElOYmxURjR0M3JobWF0bU9SOVFETldo?=
 =?utf-8?B?SXYzWU5vMGdmMFpwUmdORmh6d1NObmF5Q3ByK0pGOElqRVpxNHBmaFlBUE1V?=
 =?utf-8?B?eUdROEZTWmJ2eWtFNU01TkNtUnp0aXV1OHBaYU1GZmFGVVdTblJLTjJkOU12?=
 =?utf-8?B?RldWTjBDUDh6V1ZBU2J1eW9KbG45K2I5aXlmaThDSnkvYlRhSnc1VGVpY3Vz?=
 =?utf-8?B?dkN0bEpwZWlOMzk2MTR4a3lHVVZHSmN0eS9TZlYxUit3M1d3TDZuS3VvdDZG?=
 =?utf-8?B?dTBqVkYyU2EyWGFPdUxGaTFIRlFZbmtZZ04wZTNhWHF1emxDWlgvYTRNbDdw?=
 =?utf-8?B?TENMSE8vaTVmb21nWHJIaEZZbkwyRDV0eWFTV0Q5dUZ2akRtSm03LytCYUxR?=
 =?utf-8?B?SUpNODk3bHV2ZEFZd3pEZ0s2TVRzVzA4alJoakdLbjlBdVVpTlM1YkhYWEdQ?=
 =?utf-8?B?Nm5BdlYxVXRGN2szWXJYQjV1bFdvQkRDenJldkljLzE5QVp0eDFBRlRab1ov?=
 =?utf-8?B?TGx2ZDJGcHlpZVdVTEZaSFEyYURDRTRGZkI3QzVOMzAxYXZzQWo4SmN1bFUw?=
 =?utf-8?B?TlE5VEdqMzdFTFFCQnRkNWx6VHFIOFZtREVjdkRuY3AzZG9HSWZZMVZZSW45?=
 =?utf-8?B?ZzJ0OUNOYXRQbzExcENWYWkxd2lKNTBDaTQ0bksyNXk2NDRTWWR6Qy91WGNo?=
 =?utf-8?B?S3VqVENxVFJSblZ6YUdPVWJWWXg3dW1hMlc0em9ma0VUdldTVG41aXlCM0g4?=
 =?utf-8?B?eXBINTNWRnp2Sk5YcTAveEpjZnpnNWx4V3lmMjBYczRiR2c1NURVT0JYaXJk?=
 =?utf-8?B?Z0xXOGhKR2wxWXZEV1RGY3NWRzM3TFJ3MHdrR1lxMStNVzg1clpDc2RKcldw?=
 =?utf-8?B?M20zYSsxZmJOMWNpaGpvUVpPTDRWRlJyTWczQm53TFlQVkhYOGdyZThETmhS?=
 =?utf-8?B?Z3Q1RGNkY3JGckp3S3BKOFFBT2F2ZWdSRVFtL2ZLT2ExczZkb0ZKdkJta3JQ?=
 =?utf-8?B?NGJJaWxHaStkTTJhK3Y3WVB3T09CUXFXYm55V3lXeTMxaUJQZVUwaHN3WWVZ?=
 =?utf-8?B?ZkJhd1I0b3ptckhMbU1USHlvdElza2YrNnR2TVZ3TWl2VlRqZmlwNmpVdHhL?=
 =?utf-8?B?U0pZRXd1RStyVHJBUFYwSUVqR0hld3BjbmVQWkRWK01hc1psRi9Ybm52NU5H?=
 =?utf-8?B?MTFVcG4rRm40S2diZmRsOG0xd2FYbWlwc1Rib2EyUEY4aUxXWUJZeGxjQzdq?=
 =?utf-8?B?Zlp2ZEdZVjFPdG4waEZKWnNLaVc3UzY1bXZNRDdpcXBFSVI4MVhxaU1FZU5v?=
 =?utf-8?B?L3Irc1V2SlZuTXFmRWcxUHlDcndxTmt2L2Z2UklDeEVISmpRSGJkQitoaHNq?=
 =?utf-8?B?eTRLS2hEcExkUW9mMDBGUi9adkpwRHIybXdXa3JaRkxWN0FuaTVsc2Z3a1M2?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63A95A8AEAE5DD4B974C250E49F34A76@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d84f687-8abf-4035-4caf-08db0031eeb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 06:44:26.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6srOL3J9hQQztPLsi9CR41S6MdKq/bjHqvVHF8YxrbyH5Th0oXDNoxTIyjWSa3ZUoB0ueFk2NRxVKhA7XYpR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKYW4gMjYsIDIwMjMgYXQgMTA6Mzk6NDhQTSAtMDgwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOg0KPiBDb3JyZWN0IHNwZWxsaW5nIHByb2JsZW1zIGZvciBEb2N1bWVudGF0aW9uL21tLyBh
cyByZXBvcnRlZA0KPiBieSBjb2Rlc3BlbGwuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBE
dW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IErDqXLDtG1lIEdsaXNzZSA8amds
aXNzZUByZWRoYXQuY29tPg0KPiBDYzogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlA
bmVjLmNvbT4NCj4gQ2M6IE1pYW9oZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPiBDYzog
bGludXgtbW1Aa3ZhY2sub3JnDQo+IENjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0
Pg0KPiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0KDQpMb29rcyBnb29kIHRvIG1lLCB0
aGFuayB5b3UuDQoNClJldmlld2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNo
aUBuZWMuY29tPg==
