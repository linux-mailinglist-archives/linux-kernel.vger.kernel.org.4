Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D0A6E1A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDNC5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNC5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:57:07 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2086.outbound.protection.outlook.com [40.107.113.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE02722
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A67+tVscVMNTqW8HgFdEKMTcNnoGjKXk0Ib4UNQuIs3T32N4Fuwjvntx9fxu3VZCmTa2kmcRp/bpOc8vEcw/f6MV2/RumXEDcobSRycxE3jAJ0O0HqG1rP3/AefeYQ8szraerBeOxZWjx/XSmDByf+jA8VIUD0/BIkhsG0TnbmeaAae0zH2qNF/7y/xX2csW6DOGd6bwHAX3yGa3zpOVAPJ04MSl4mOxa9LtcxD5b42xpeecoWEyYyJ1odRbCb/Q4KBTSIr9hhLAak/foEc8pTffrMg3p9qzbjE/wZExPS7invNF0cEW6dN8RQ6IKbEf+0wccInqJWky0EZ6/eEXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA+JfaRTbJCb28Nx3RHJ15hpVrDyYC2+jwVnNz+QJIk=;
 b=NPC+p9weZH0SOoOqIHTodatknWz0z8A36VRTmoxu7exmljvHsLNwu5SpxSxB71JvKColzhaahQBEVe/XwyW+csiAVXOXTSyY31qZyUOrietpmHurZE8uNAijVSKx0zGF8EG5w5osSWNYBvBcKdCF4CXiZp8SlV2lnwgGJcVhfwtDlQP7XWascd1ticsftfntes6MxIExDyu2j9sH7Fl/E52mPmJIQMFSZrGx8jegRXw6mn0bQvrq+y2qBvGG9QuPBKd9M9sjEKimfNp1gORaIC8tnUqNxMPbGpBDiDXlzya77rqg6PgYDnkpl45m/3jRIUKStQMwOeGJ4S4CwQZIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA+JfaRTbJCb28Nx3RHJ15hpVrDyYC2+jwVnNz+QJIk=;
 b=N9qaeLvctjF2cqdNnZp6ATXvFIhek0eb/IUVVfIhewe2Y4aLY2+peZ/zVSXfUj5vREa5v2s+dSI1oGWFZb5zSrnuIsog1j7YU6REyrBY8QOgcrXkv1jOoe+d1YqDvnysYYC36MuTJ+Ino7RkSGweGUBGaQNmxNbkWgXopJ/FEE0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB8789.jpnprd01.prod.outlook.com (2603:1096:400:16d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 02:57:03 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8%7]) with mapi id 15.20.6298.028; Fri, 14 Apr 2023
 02:57:03 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Liu Shixin <liushixin2@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Thread-Topic: [PATCH -next v2] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Thread-Index: AQHZbgLTCH2sD0JeD0exGzkckRoPda8qHYyA
Date:   Fri, 14 Apr 2023 02:57:03 +0000
Message-ID: <20230414025701.GA2522032@hori.linux.bs1.fc.nec.co.jp>
References: <20230413131349.2524210-1-liushixin2@huawei.com>
In-Reply-To: <20230413131349.2524210-1-liushixin2@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYWPR01MB8789:EE_
x-ms-office365-filtering-correlation-id: 6250d5be-5940-46f5-a89a-08db3c93ecf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FcJbgfdrDYnUx0pUOJCcnWB9ChoHCUS2DkTnas3buxwBH9JaVOBCtjynAIEGU6+Tzmz/l1Kp/VO0984q5PrXWA1QZQVqEiQKTOpRakeeS4oBU/2xs5hmrc11ykXaPLy8CLMZePKkCPdm7wZMJTL3gvu0y4sgqXHMWPlLlT+BAsu4hKYCsj6uujKeA3ynVSntrg/v0lmepkqmOSwsADlVBQ7rHwqC2E4POGvDzlEsoBbjEC6pczz7TYzCoV7H6dolpboZkY0m8rbTDXIpV6IG+TbkXmxGg7K6v+h99UWOKovl7xMmKeM3fybIfKQYF7N0r5igSBksy7LQvS8nxDvEuduzJbn24jgGKZ/loMLrv6qO2GRPd2fOokVjLb7YvJip1gwhKRgOb+CkmvHnbXLkD0VWAlkEeEO/zFgE/OP3G4zzK4kx8reuITDLEu47OmK/Y2SqckWYh+EKue9jDkNJyN07MEnxX628DU9Q71pXMtWNVgNdpyMUyS+KCWg1oaf0yUW9KOujXkOwg04XFTm9REsbAdjHFXaGDUngMMBX9muLqcsNvpA3xs5y11aW/gwRUFRfHVl5bUqUGE6KEvN0pctOpOHbaiVnMTaD8ZOu4uJ9JNFDdEXYH7eZVn+ig0PJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(2906002)(38070700005)(82960400001)(86362001)(85182001)(33656002)(38100700002)(122000001)(41300700001)(83380400001)(6916009)(66446008)(66946007)(66556008)(6486002)(66476007)(76116006)(316002)(4326008)(8676002)(8936002)(5660300002)(71200400001)(64756008)(54906003)(478600001)(26005)(6512007)(1076003)(186003)(55236004)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9HeXF5a290K3cxK1hiQWpETVVQVStBeFFWblQ4S3ZmS3FxWDdIaDRuRklh?=
 =?utf-8?B?LzNYQUxlMHczWDczOVNTT1dPZFBTMllBaEdFMkhOTnlkdFU4UWtCbGU1alpI?=
 =?utf-8?B?cDBoeUFBdXZVV3JFYkZjajdVc2dlVTBha01kc1MwWjhWSkV6aVRrU01CZ2pM?=
 =?utf-8?B?cmFWcHF2am5BMXhDV2R3NGsyQTcvZUh6cmtRQnp2QjFtNWttWjlRTUo3TFM3?=
 =?utf-8?B?RTRvTmRhazhpSmJWV05icEV0QkI2NnkySDF1cllUYzFUSWpSV0FmZXlEZWlF?=
 =?utf-8?B?bnVPcWs0RHFYbGR3Ny95VGJMbDkrOElJVVR1amxlRldWMlNQam16L0JVbWdT?=
 =?utf-8?B?TE85YURaLyt0TDBpeDAyZU5ZaEhJTUR3M2dGNCs1Rm5ka1pub1kvM1lSNG0y?=
 =?utf-8?B?T05jQ3Fqd24wdStWMG5TaTRtUHU3aVFkKzBOQnJkdlcvOEZWbTVMczhwbTFw?=
 =?utf-8?B?YnVoU05xeUgvNm1PcE9SZHUybjdUR3AwdUJrbWlHZ1lObEVrNldhMmhrS1J4?=
 =?utf-8?B?WFptbEV3SGFwRTE5VHBIRlhObEJCdGRDYWpwZG96enhDRG8rRGUwVGowSk9o?=
 =?utf-8?B?NFQ1SlliYjlNaEJCTVBCZ2tYWXQ5dVFpWkR1cWNEbkpCSXJFajVkWjdiajA1?=
 =?utf-8?B?SnpuT3JRZm1hZS9BTjZVaUNoR3dqdktYWmN2L0xNbjQ2Wk9hTURvcHlpQmR3?=
 =?utf-8?B?Wnl1TzBQRHd1cm05bDg2WTYzSUdxT1hFN2dwdE84NjA2VXV6SjZzaUoxZlZ1?=
 =?utf-8?B?ZE9EamFRWms1UFlFWnowMGh6eWxrdGVGbkx0L1JITVl1eWZDZ04rR2pyaHlT?=
 =?utf-8?B?V1BBZ2VwOFRlTU9VelhQbnNOUEJmeHpjMTdHMVpZTnAwWGxEcUNxRGlHNDFW?=
 =?utf-8?B?RGxmOWMzeXEvajBldGM4VGtRTnBMVWJnNTJNRWM4YVRxSjlpVUJYNzhSL2k2?=
 =?utf-8?B?ak53U09waVg1SndVY2JER2kyQnRFTVZ4c01oZkErbFFXUWd3MmxkNnZ0ZFpR?=
 =?utf-8?B?UWpqRFl1OWNhWFhkWXh0KzVWOTljdkZzYzdvaE5Xa3o1eFp2cnIyV1E0c2Iw?=
 =?utf-8?B?cFNzb2UwSk9mb1FUTVNERm1uZDNxNEVVazBPZkczTTZobXlVU21rbGN1UnA2?=
 =?utf-8?B?YTNXSldJZ2twNFRKVXIrV3ZtTmhsU1NuOTdIOGlJcUdFMEgxZUM1U3Q4QkxH?=
 =?utf-8?B?emVZOTI1RlR2WFhwaUVtcUNnbE5SZ1RmcDFVMFlFTS85eTloS3F6L2NLcnNZ?=
 =?utf-8?B?enZsMW0vOXZYZjRacFBrbGJJRFhKb1VKenZkY3hXY3hpUkdwS0N0WkR4Qm16?=
 =?utf-8?B?bXFBb0V0UGdLVmI4b3RVcXN5bXZmMFZvZnF5R0pMSFk0c3Jidzdydld2c3Fm?=
 =?utf-8?B?UWVWbzYwNW1RblNGcGdoM0w2U1RjRUd6WGlGMWlEZ0lUU0cvTU1NcCthVXNj?=
 =?utf-8?B?RUNPcW1IaDB0UDFMdVpoNU9NejFYM2ptN1R2K2ZGNUtFSHZEWFovei9lZmNk?=
 =?utf-8?B?SDI1eWhVTmpZZGxmQy91MkYyaGhGS2ZIV3hYS2tIZE4raVFUelh4WXZDWUw0?=
 =?utf-8?B?cGpDR3E4cFdhd1lUQmgvemUzc3NJRysrcUVaejJWSDBzUEtqWDNDZU5LK1hU?=
 =?utf-8?B?OGllcXdaWmREY3FQdWNiLytSSHJtWTZSYjYzZ1d3VHo4TG5jY0VoNXRpdzZi?=
 =?utf-8?B?eCtCU3lrUmdpaDNnZ1Y1Yk9uMmsyRlNoTkR2YmY0QzBua1dCV1JONW9CKzZ1?=
 =?utf-8?B?Z2VPWmRWZmZ5dXAxQ3hraitoVG1qUnVFOUhLOGN6RDBUMGI1WkdDeEpnMHd4?=
 =?utf-8?B?eXNjdFo0eFZqUGc0TVJlU0ZCcjJCNTU0RUhmMFpqelI0dFdld0NINXdsbW0r?=
 =?utf-8?B?ZEhjWXNPcWVRbmN1cWJKajkxbTdEMEJ6U0tORG1sOU52Zlc0RSs4a0tOMk15?=
 =?utf-8?B?c01WeEgwR3kxOW16K0RVU1VnMlNRMzdMZ1kyZDJ1ZDU0ODc0TVFlVTMyWm9M?=
 =?utf-8?B?U29OVzd3TTl4aS9QVkdJd0doT3NFaFg2Qy9QVTBSTzNGVHJRcThNbUlLaktk?=
 =?utf-8?B?aEkzV2gwRTVqOWY0Yk9KTHdaUWhrZHJnbFc4b0dmcmRXT21MbVV1STZONktK?=
 =?utf-8?B?aXBaK21aNE5CQlVOWllFaTFBVnBUekp1akNneXB1ZUNUM1hqRlVzNlBiaTlX?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCF393B1135A624FB64B671766936596@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6250d5be-5940-46f5-a89a-08db3c93ecf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 02:57:03.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GO7Xvc5lJ1FSowXgyDw/6VENi743V2nDHVxSprt/szzoOqVNR2Z1tpHe1r4It+AmOV8TOCTvg7gtKWXXGoKyIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMDk6MTM6NDlQTSArMDgwMCwgTGl1IFNoaXhpbiB3cm90
ZToNCj4gY29weS1vbi13cml0ZSBvZiBodWdldGxiIHVzZXIgcGFnZXMgd2l0aCB1bmNvcnJlY3Rh
YmxlIGVycm9ycyB3aWxsIHJlc3VsdA0KPiBpbiBhIGtlcm5lbCBjcmFzaC4gVGhpcyBpcyBiZWNh
dXNlIHRoZSBjb3B5IGlzIHBlcmZvcm1lZCBpbiBrZXJuZWwgbW9kZQ0KPiBhbmQgaW4gZ2VuZXJh
bCB3ZSBjYW4gbm90IGhhbmRsZSBhY2Nlc3NpbmcgbWVtb3J5IHdpdGggc3VjaCBlcnJvcnMgd2hp
bGUNCj4gaW4ga2VybmVsIG1vZGUuIENvbW1pdCBhODczZGZlMTAzMmEgKCJtbSwgaHdwb2lzb246
IHRyeSB0byByZWNvdmVyIGZyb20NCj4gY29weS1vbiB3cml0ZSBmYXVsdHMiKSBpbnRyb2R1Y2Vk
IHRoZSByb3V0aW5lIGNvcHlfdXNlcl9oaWdocGFnZV9tYygpIHRvDQo+IGdyYWNlZnVsbHkgaGFu
ZGxlIGNvcHlpbmcgb2YgdXNlciBwYWdlcyB3aXRoIHVuY29ycmVjdGFibGUgZXJyb3JzLiBIb3dl
dmVyLA0KPiB0aGUgc2VwYXJhdGUgaHVnZXRsYiBjb3B5LW9uLXdyaXRlIGNvZGUgcGF0aHMgd2Vy
ZSBub3QgbW9kaWZpZWQgYXMgcGFydA0KPiBvZiBjb21taXQgYTg3M2RmZTEwMzJhLg0KPiANCj4g
TW9kaWZ5IGh1Z2V0bGIgY29weS1vbi13cml0ZSBjb2RlIHBhdGhzIHRvIHVzZSBjb3B5X21jX3Vz
ZXJfaGlnaHBhZ2UoKQ0KPiBzbyB0aGF0IHRoZXkgY2FuIGFsc28gZ3JhY2VmdWxseSBoYW5kbGUg
dW5jb3JyZWN0YWJsZSBlcnJvcnMgaW4gdXNlcg0KPiBwYWdlcy4gVGhpcyBpbnZvbHZlcyBjaGFu
Z2luZyB0aGUgaHVnZXRsYiBzcGVjaWZpYyByb3V0aW5lDQo+IGNvcHlfdXNlcl9sYXJnZV9mb2xp
bygpIGZyb20gdHlwZSB2b2lkIHRvIGludCBzbyB0aGF0IGl0IGNhbiByZXR1cm4gYW4gZXJyb3Iu
DQo+IE1vZGlmeSB0aGUgaHVnZXRsYiB1c2VyZmF1bHRmZCBjb2RlIGluIHRoZSBzYW1lIHdheSBz
byB0aGF0IGl0IGNhbiByZXR1cm4NCj4gLUVIV1BPSVNPTiBpZiBpdCBlbmNvdW50ZXJzIGFuIHVu
Y29ycmVjdGFibGUgZXJyb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaXUgU2hpeGluIDxsaXVz
aGl4aW4yQGh1YXdlaS5jb20+DQo+IEFja2VkLWJ5OiBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0
ekBvcmFjbGUuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogTmFveWEg
SG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
