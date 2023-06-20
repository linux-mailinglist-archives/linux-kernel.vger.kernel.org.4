Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE505736779
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjFTJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFTJQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:16:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B01BD0;
        Tue, 20 Jun 2023 02:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atU8YFjZotLtkHr0ofZsKqOXaSwK+1pnSYDt2ZYhhKeHz0l9ohTwOuPBrBb218gqOzREwHu4ZwnlHqO5bxkS8LVLjA9LmRhA94P961BJVxkM3Qt1eUoHzJSNW9Jip7f32qN3KhrYEY7tULQPHJoGZCiwyfLkhKj4tKG9o+RMewcUj8JEjBPpzYR5Z9EgpS2leMzUi7hGnjn0iJ+BYUj+7Ucst2DoRHugqJdGex3qQ338/mF3r0lVweR0TPqV41iIvE79yi/2QkMU6cfQuKJUS5VKQgAchAHtxdZbXBVqc+wZ7O3QHe6ZjSW5NrKweeh0ewMtgFtHS/j+XCMEXCkCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo/+7mVCvbr75nawcSmikFAC/cwgb29bl4QFJApT1lI=;
 b=aX9a3J3tg6gHFPFD0xE2aqqQgZQCkQHPIZu0kN86Qt8MXPWSZaarl9F0jU4vOd+tImk1XvC5kb2cMabKqCPYI7FdG7npA+kYD/svIyy4wagR7Q+mCfS+oByzl4BeNZW3Z9ZwlyCkB/MksaB8Mp0tVeiTgwZ2WXbO1wHYJtts14N9aHL9URumTaVOUR2/ZuygP1GVZbUGvYJQsg5ILiGACkHydoFYqBhJQ5lVNBn4SQMm0Jj0/hkTTutYMrOQmxvbq5YF5zew7eCugeet09QTTXfepADzbcIC3N8thhkmtWWhDa9czc+u9onPIRaNdoQjKo5F0lZVw86NV0eg5PhBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo/+7mVCvbr75nawcSmikFAC/cwgb29bl4QFJApT1lI=;
 b=LzPtDRyU7aKyaEMO3we+yILHZz1qp4a6MHhiRHs5C7vaH9Htdw3LJO3xJYKUQ5V/Nle6uZJO+2xS4oRdSo0OlRXnIBDl6FAJNy8LOq5vbdYWx8don2l/T52TZnsxO+gIfmy4Boeo2YBgC0vBs+9wGuJo/gM73cF1PAlibWHm1PM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:15:05 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:15:05 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 6.1 000/166] 6.1.35-rc1 review
Thread-Topic: [PATCH 6.1 000/166] 6.1.35-rc1 review
Thread-Index: AQHZopsOsrtW736PTUm7YmTp1BDgh6+TaZ8w
Date:   Tue, 20 Jun 2023 09:15:05 +0000
Message-ID: <TY2PR01MB37880A925672099DB347BCD3B75CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230619102154.568541872@linuxfoundation.org>
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: cd753122-d176-438c-bb63-08db716ed5d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Rqv4Ye966RU7JZ8404vbgabF72yDa+qQU3jhDsIIa4NjuTph3gIPmXeTq0ogvDN52FXYZBzzQSIXCZl63jgkpelTjaaAjn0N/gLXNf0U/5Zkgx4E7LEY2Kcix56i4KedymIvVMXlikTfSm83u/J6zkso1FmD2NUROIO0lB0r0bhqXSgb2pP+I+Xj4NjsAiaWr1v+dKDTLE1ORLxKBOtpEh+z+3XcZvUjgM9hW9tKkz+R5FyayizIVJ5N3YuuvafLUChw5OZmgjS3v2yeapbVMPU0WpAqGGRdHT/mQWiXU3o5mzEIpwOXUE8agoFcAFJIm5oAfUMHKV53B7ibDdQCOE6ToH0ctc5PcjFJBvomcHiYBgfwAcPTDImnzz9X2Ir9ecsBzoPykLNrXAmCiU+cFE2zy5uoatVPKvaBWF+6vYAIKUsyM7QGUFakh0Zb/HGp2ZrffItVGqCW77dUVRnfhAZ2Qdqv9pOV/K/u1tk5GiTgXCemF+PtHKWRG1ofC6JpqXdZClI4gf3JflesasjfTfz21uQM0OpnqqYicfgu6BGybW3rNZzTM6P/rFYC7qEdJl4KS6UBVVg36EFvY0zO20/JTyvuuVbAa7XCUqMzgFBL4Y175pOlBzF9D+sYYrKxZqSdZVWlDwJCBzazT6PVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(7416002)(52536014)(122000001)(86362001)(38070700005)(2906002)(4744005)(5660300002)(110136005)(76116006)(54906003)(64756008)(8676002)(66446008)(4326008)(8936002)(186003)(66946007)(66556008)(66476007)(26005)(966005)(41300700001)(38100700002)(478600001)(9686003)(55016003)(6506007)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFJNOVl6d2R6UWNjT2JpOVRLM0Z6NndlVWVjcy9WazZad295dGFURXdzd3Rh?=
 =?utf-8?B?cUZIMjRwd1VvZ2NSQjd0U3JIS2dpdmFHYVcrQWZ1UWtnY0hxSDJ2b2RiMElF?=
 =?utf-8?B?VXJxVFB3eHM5Mkd6NllPcUNCdElVRXYwWm5OZkx4QlZpOEhIVUwzazVtRWJx?=
 =?utf-8?B?c01ma2FEVmx5VGJZVlRLTUg3UEM3ZTdwVjh4b09WOFhPZ0NyV1JvYWgrZ3Fx?=
 =?utf-8?B?ZmFvOTZERDAxZEthUnA0ZTBLYUFRd0x1ZmwybTdxR1JvaXkzeU9sZHZzVkRX?=
 =?utf-8?B?TVFDQjhXQ3lrWS9Ua2MwbGlGUk5TZnlNRDA3N2I0VFhOSW1DSkNUZTU1a3Zj?=
 =?utf-8?B?aXFEWTlGeU5Oc0ZHbkdxaTAwaWxzRURKcmw0b0k5U2tCMUdyZytsUnBVWFdl?=
 =?utf-8?B?UCtzTWc0cG1sUjZ1b1VnNWNXdk1JOTZ2Yk4vdnQrbEFTYXg0aXNwNHp0WW5r?=
 =?utf-8?B?M3psWnF1SUJZU2pHOFhWbG5LM2p3enBiT1lOeFhYQWJvL0pTMHB3RWZ2UE02?=
 =?utf-8?B?N241eGNxb0dLRFU4b1VTYjBzb3ZOZWpra2c0T2J3MWZ6bkc0SEVrb2NNYito?=
 =?utf-8?B?dzR3SmFtdmo1SWhHZC9kM1VGZEp5Z2VENDAvQ0c1QzFwYS9MY1RLQTJwMHNN?=
 =?utf-8?B?WFhGMzMwNXNycnI1NEdrTCttYVlLc0x2Tnp1b2phSkJNQkZEN3JaTGFtZW0y?=
 =?utf-8?B?eU5pc2FSZ1FRb01Id3FZUytWMjY5MGlKdWJwSFkyYkZya3lCbmRsd2J0RE13?=
 =?utf-8?B?Q0NENGNHaDJCZEl1RUQrWnU3UjJWSXRZRmtZNXlUenRqOXhyYVByUXZObm5K?=
 =?utf-8?B?Uzkycis4akU5MUh2WWFjVjd6U3o0eEFMV3BSZ084MUN6M2VpbmtYN3hIVUlq?=
 =?utf-8?B?WjN4cVhnSmZHUjRtRGtYSjRNVFBXU2c3R1UzM0lmemlxSWduVUpWL0E4dXc0?=
 =?utf-8?B?Nk9paFZaWFg0Tk1VTnJscEVSM1J3Z2Z2SHp3cklRNnhQZzlCUTFJVzhKNXVH?=
 =?utf-8?B?bW5Id1RpdVNCV3hCUXVPN09YTVBoWlg1S25JNEk2MmNNTysyUWlONEJ4dG9x?=
 =?utf-8?B?T290U1cvOXdlTThVUkhkQjdqSCtHNmJ4Y1RHODdKc0R6M2Fld0p0Q3pwM3Vv?=
 =?utf-8?B?N0dGT3Y3Yjg0aTRUM2tZZCszUEtFcElMQWsvUnBMVHB4VUNpRnZxNVZES1BH?=
 =?utf-8?B?KzNTSTg2SG9GZExDWThGWEgyR3Fxajk2QVVlSHNsSVFWSEgrenpLblBTdnN1?=
 =?utf-8?B?UDBjMFlVSmovckFHMkpST3pNd296UjVLWU1ia3lxd1lSSXlLWi8zT0xRU3NH?=
 =?utf-8?B?YWhnWVdoRkQ5RWlIa29pL2ZOZ2cwbmQ4OGxwOW5tS0J2Y1lzVjIxcEVJZFBr?=
 =?utf-8?B?cG9OS1VxSkhIQzBiUm1tcDZlYk1NMDJhaXNhVWhuU3VxVWl2MjVoNXU0TnY3?=
 =?utf-8?B?dHVuZHBTSXZvMW5WRHR3QmhvZWFOd3lpZUs1SXM3VW1wQnkwM0JRRFZWQ3Jw?=
 =?utf-8?B?dW8xNktJYXh5ek5SaUdpWjhyb3kwMjBSa0U5YmQwM0tlbkVJU08vVEVWVlho?=
 =?utf-8?B?VFBPYVJuKzEwdUdvbDJ3T1JJanhrWFROeUprWlV4RHlRQ3ZXcGplZEpOK0ZB?=
 =?utf-8?B?ZGlTMDVKY2NEdWpnQ3RPclFGNkFQVG9hMTVjb2N4bjVsMVpVREpQeGxEQ3d6?=
 =?utf-8?B?YXlnU0NaRGxhMWc2T3JGZFB0VUtNeUd0WFlnTFNGdElSYU5ZMkRnZjVpM3g3?=
 =?utf-8?B?N3IzemJWeUl0YjRXeGUxc3A2RkpIQzV3c2FIRThvL1NuN0xFRUpiYW5lUFJ0?=
 =?utf-8?B?OWJ1akNCaFA0ditveCsyV2JaK2xLZ3hYalFnd2NOMFRmdW1DVjVyMnlRZ2RN?=
 =?utf-8?B?S2tST2ZsTUdyanVldVFDa0Z2dFV0TFFkZnpETExBejgzWG0vamFCVlFRWUVZ?=
 =?utf-8?B?dEZ4d1RWbGYzalp3WlBWMmIwYzRFS1ZTUE9LQkRNa2NDTFYwdEp3SXRHbmNL?=
 =?utf-8?B?YWtRQmYwUHEvTi9vVVpJWlE0UHVXODlmQ2FKUG00MWNYYmUyaTVKTTQ1ODIz?=
 =?utf-8?B?eis0OFZ6YWc2VkVqR1BqaVhJcERlcExDQlhQZnBzQklrRUk0VUVyd1lmYVIr?=
 =?utf-8?B?eGR6aHBacXhYOCtWS0pDbDVhUG5KM0pDdmp6ZzJwMDR0RTYzUTZ2em0waFZa?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd753122-d176-438c-bb63-08db716ed5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:15:05.0822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iACvDjcnJNgGDtPWtuE5AikKEXdVU/hcxREZo+xflf/J79/IyqVQ1TXn9+8+AEok1uncyeTaTiuKkT/b7XvOzoM3kFb5laK5pTQ25q54myc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR3JlZywNCg0KPiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgMTksIDIwMjMgMTE6MjggQU0NCj4g
DQo+IFRoaXMgaXMgdGhlIHN0YXJ0IG9mIHRoZSBzdGFibGUgcmV2aWV3IGN5Y2xlIGZvciB0aGUg
Ni4xLjM1IHJlbGVhc2UuDQo+IFRoZXJlIGFyZSAxNjYgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcywg
YWxsIHdpbGwgYmUgcG9zdGVkIGFzIGEgcmVzcG9uc2UNCj4gdG8gdGhpcyBvbmUuICBJZiBhbnlv
bmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWluZyBhcHBsaWVkLCBwbGVhc2UNCj4gbGV0
IG1lIGtub3cuDQo+IA0KPiBSZXNwb25zZXMgc2hvdWxkIGJlIG1hZGUgYnkgV2VkLCAyMSBKdW4g
MjAyMyAxMDoyMToxMiArMDAwMC4NCj4gQW55dGhpbmcgcmVjZWl2ZWQgYWZ0ZXIgdGhhdCB0aW1l
IG1pZ2h0IGJlIHRvbyBsYXRlLg0KDQpUaGFuayB5b3UgZm9yIHRoZSByZWxlYXNlIQ0KDQpDSVAg
Y29uZmlndXJhdGlvbnMgYnVpbHQgYW5kIGJvb3RlZCBva2F5IHdpdGggTGludXggNi4xLjM1LXJj
MSAoMTc4MWIzNmEwOTU4KToNCmh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtdGVz
dGluZy9saW51eC1zdGFibGUtcmMtY2kvLS9waXBlbGluZXMvOTA0MzU5NTk3DQpodHRwczovL2dp
dGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtc3RhYmxlLXJjLWNpLy0vY29t
bWl0cy9saW51eC02LjEueQ0KDQpUZXN0ZWQtYnk6IENocmlzIFBhdGVyc29uIChDSVApIDxjaHJp
cy5wYXRlcnNvbjJAcmVuZXNhcy5jb20+DQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg==
