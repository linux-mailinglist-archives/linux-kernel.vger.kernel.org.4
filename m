Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1C612FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJaFkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJaFkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:40:49 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2099.outbound.protection.outlook.com [40.107.135.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E859767B;
        Sun, 30 Oct 2022 22:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyKR+Y4K9m9MIdk3m70UvKHl/tjDAaDy4K5d+p7KDTL3h/3jqXuUVIErZdA2MR/WQx+poBxBf51Q44VCE+dbu6QazlQ5dtL2EIaRedRgn7U96CiDNcEdBN0QT/zh3e9A9G8JcdLS+63qxehO2DIBNBxsoROohx7Y8jO6YitmZQCt81WKgyj6Sry9TiBHqMrKMEY2xUUCmkeO3XGQh0x72lrZzyDet1+h0opW5Z6EvQU67iOodVPrkbx4he2VyfBeKA+ZWi4BIEEuWaHG/oip0n9Nqs/S+RK4R7WXfyWemf+3b+q565Df/wisSOpfSXJEXxn8w1SjM10gYckTmbd/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VofVYgUmYNtf5X2P+po/F2vKQ8iK/uxHHAVzMaVNwFc=;
 b=dJZTZJBXpGgUpXfDfXc5Te+Nc9vAwElh6vNrS3EFLiiWF/KO+1by7sHjVkI4n24B1gFwYSZlNK9e+64+zNKRBLdJktQ24Bfytip+40E/hojDWO0EqW+0FKRgf1eb1W+a0e0SWIgwYdn9Ti4TvswJUzCop9DafeLzx/0bAY/vZhqb1E+OeDDL0++wfuswd4Sy380+wOdPwUii1e2E2e3s/BPeHGXr6m3G4Tjw6U9TaxEXY/bbGiqAkqc1dQGIvWDA2iCzKJoBO5bVp6tYA7BG1LaWRlr62URywez4D+EWvBi9DClZH9TmGR/4bkLexutZYoxkWShsrhJpgQzWMsZuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VofVYgUmYNtf5X2P+po/F2vKQ8iK/uxHHAVzMaVNwFc=;
 b=mPOh6dF76U9qjwK+cmkrAoItuZp2NZ0Ty9LPXZyv9em2lo/FKlWojf+ITDpQGIYu/7ZivIlSfTObJf6dVbpugAXOHjt2whFxdA94G2104awEwYu4KOklxqfNf1eStBw9iAVSJV7a0KnS+r00u5ehqhHh/wFaZbkttkqYjJbmfQ0=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB1549.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Mon, 31 Oct
 2022 05:40:45 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bec6:d44:3d5f:317e]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::bec6:d44:3d5f:317e%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 05:40:44 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Topic: [PATCH v5 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Index: AQHY56XoXKHaCmTWf0SSjO7OSw5Fe64lc8SAgAKTkwA=
Date:   Mon, 31 Oct 2022 05:40:44 +0000
Message-ID: <349ac787-80e4-4aef-d14c-ed95834350ad@fi.rohmeurope.com>
References: <cover.1666614295.git.mazziesaccount@gmail.com>
 <7895435f7fd31a3b576fc6a59b01eb3202c85d36.1666614295.git.mazziesaccount@gmail.com>
 <20221029152001.5ba70261@jic23-huawei>
In-Reply-To: <20221029152001.5ba70261@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB1549:EE_
x-ms-office365-filtering-correlation-id: 1933bd49-e9de-4cc2-b3e8-08dabb0274c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LB5bSlHYs/JASCNWzTyhn8PTEi9PfLGTcKpbvLDtGV/rcz4SpczzfsclNEZ59xF2c3LSzirW9XR3mBOc6LobKJ5XWjm20vJfeRL3jnHYacHRPVbKy0qfdM30bF/hMeewW4G+bKH1jnzzuBX320/dcc7+5LECoTNOhfYUytoe41neYUtPv5Wy1ViMV9wCuKXh5ETI3KS95MdZnzsDwKH1TPyDRPRlLs/gHvBrTwWJUn01isJlNMa0dEUhe9kFB5lYrivAVacDqUzeWTXrvQWpd8hK77iMtvIelK3k07k5m7kA3gya9/X7MhvmvHq+o+i5nCcC986ByKdC7Rx6K5Oa1eppv4oi2eHFqfPAUT2xy0bNRKPTbq1F9rII8TRz1z3bF5WgyAsX6nPQHKNPoZxeqSqSxqdRUoWHTlbtUXP6Ws5V0BhvkY2iy8Tocc42+avb+cWhMHruIVdMc3cuwD+xyL5pfdhOoHLRuc6FDFnkitTTBB4f0c5RXrBZIyS57E9L8s/NRbl594HQ65hGpvHBqnKBf3GPFXi/S85E/8QrZrG95Q42hVfwTAZtr5kVwool76phYzGozWh+Em5M4VdxJAdwR3MA4aIf/wroW5IEs/IQFP8Np+7d68nY59B7wKBG7fF1bxIbVCaYi5SwKI4Z+bqDBp5GLnXuNp9wBzjhKK+VH+fPFQglMMX7CM5g6p6xaej3yQLwLPWQ0rkD7vjw4Ct8idR1+ftBe3gyB3lueOyG/RcESevaw+Y0vSyzID8gWHGs8CeOCA/ag7HE7N52KWJtFRMbuA5UlpXSQ/fz1GuX1cppespLd7Z9YgeT5A9fA0/j2D3pbXIgqoJUOYAesA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39830400003)(451199015)(38100700002)(6486002)(4744005)(5660300002)(122000001)(478600001)(71200400001)(54906003)(91956017)(7416002)(76116006)(41300700001)(66946007)(31696002)(66556008)(86362001)(66476007)(8676002)(66446008)(4326008)(8936002)(110136005)(38070700005)(31686004)(316002)(64756008)(2616005)(53546011)(186003)(2906002)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXphR1NnODVqQmh3TXgxSEhVdmRtRGYvWEtUTE5oVjhIWktzZ2hkMkdPNTVv?=
 =?utf-8?B?K1JxVlJBbGk0TTBjd2RkZWtWamxmd2hQajlER2xWS2REQ2pTdVd4ZlFLMFA4?=
 =?utf-8?B?UGIyY0NMMXE1eUtFM2s1NnZlOENkYk5yOHY2a2wwaTR1VGpQYVhDMkhPT1Zx?=
 =?utf-8?B?cWxubjU4MG5TOHlwQW9QaGsycGx1L2YrLzlNNEdtNDIzMHdTOEFXOTBRZGlo?=
 =?utf-8?B?TTVsbVhpWUNId3hoRUE5QnhpRkV2R1JRT1JpU1FqeEg1TUNmMWxuS3FVWHhP?=
 =?utf-8?B?b0lBMjFEQTFndjdpSmNNQVFOT0U1V0IrRGlsNTMrZkJGMFhuV1VmcUgwb3Bx?=
 =?utf-8?B?bS9HRHRLaXdkWWVqOTBPblF0WElnZ1ZhZEZ3Q0ZTOURJbzU1SDUyeFZIVlc0?=
 =?utf-8?B?TGkrbUkyMU4raGhpY0J4SFozQisvbk56MC9Ya3l1Qk5hcTUybDNmQ0gxa0hM?=
 =?utf-8?B?cEhJSlNTK3pwWDVrT092NDFWQjRFNkZEd3Q0b0x3SEVEL1VxcmlOMmpwaGxZ?=
 =?utf-8?B?RUNnVWRXMkJBQjhCRTN1ZVJWTXhDd3J1Vmx0YXYxZlF2M0I2dmJ3UE1WS0Ix?=
 =?utf-8?B?a3Qyb1o1NkpobEdQSkYweVhoUlg0N0RlbDBUWjRoLy9nbXlyVmJGMmJMUm5K?=
 =?utf-8?B?ODhwVGE2WkdsOG5UcDRmR05YcjhWWFNVTHh3cUdveG5KSTNGR0JpV0Y1NDds?=
 =?utf-8?B?Ti9FcGxVZjdRRk9ka1VvWGJ3aUw2U3U1aXozdlZMRmhsSlh3T29oTWswUHZP?=
 =?utf-8?B?a0QwdDZ1Rk9ZRG4wVGJ0YmdHZnppc1RwblJIR0c5V3RNT3JSNUMzZWNYTlM0?=
 =?utf-8?B?ckVWYm1OV3BWTzl6OXlVRnIwRXBqcTd2STFJaEQ2dmpNVDhaRzJ3T0gwaFRj?=
 =?utf-8?B?YzFUQUZib1Njd1BlQTJXcU1iWk9BcndCeEhZc3I5SmZGa3l3bTJBcjRmdTZm?=
 =?utf-8?B?ZW9ZbERHWGpMZm5OcW5HTHBlbGVyMXhLd285TVZ3NHNNUEhOci9yaEx4MGhL?=
 =?utf-8?B?aWUzSHdLcGlOWitWRTRqK2RZRHdzQUFGdUJVSnF1VnFlWmswZHVzUDdUN1B2?=
 =?utf-8?B?UnorODByWTZSZk5LRDk3R1NZaTZqSlU3bno4eUZ5UDJVd1pMRldQaUNKaVJx?=
 =?utf-8?B?TE5xanI1T0tuWC9tdHJXcnlSRFAvcXdvWEIwVE1LbUd5ZFRyeXhuczVONUN3?=
 =?utf-8?B?aTIwcmt2dWVLdFJhZkNFcU4ybVNFSE8vTkVQSW14WFBIdHBlZHJZZk94M2VZ?=
 =?utf-8?B?enBtZndqMlQ3Ums3L3BPTEtOSkplZHNiWVlCKzdDaGJjbEQ3SE5RT2RtK21j?=
 =?utf-8?B?R09na2FFdTNIWFFmWXUzcVpsOFVIY2RUZldKK3crYXdEdkJPbEQ3dHVhblNh?=
 =?utf-8?B?dGV3NGFNbitBQlM3dmI2d2pHaWp3cGxIS1lRRUpoSlJBYnFIK2FzOVIwOUhs?=
 =?utf-8?B?ZzJ6QUhxVW82L3VobEJ6THZsUVYzdjVSMlNCcFNtOU5YOEgzLzRBNE1YQ3hP?=
 =?utf-8?B?b0VEOTFEQmxmVnhLK0RlNWN0SkVlN3NwU0VLenNGVVNpU2VqZ2dUalJqdVFN?=
 =?utf-8?B?Q0VMek8weXlRYnF0VTlVdFg1bnVaV1dNQXc0TGkwc200cDJuays0VnY4V2t3?=
 =?utf-8?B?c2k5dmdSSDBvanA2NlhUeGYzd1FqcE1namp5b0tIdjVzVFdtQmVlWk1acDB1?=
 =?utf-8?B?WjcyK0dEN1cvRG5EYzJJNlIzdmhydVZYMVM4akpmbTQyeW14ZFZDYVFudnQx?=
 =?utf-8?B?UUhkU1NuMUFjV3lOeWxnRHZmSVZGSE9QR0w4Z3JucFMxVTg5RWFyUGpzTFVK?=
 =?utf-8?B?aENtVUNQMmNncjZ4SWxiLzhQRkpSQkxjY3R5N1FQRURyakRQRlN2cUVWaGZh?=
 =?utf-8?B?bEpLOHdUb2hEK3BzU0xCTEdwazUwM05RazVzenZmZjdycHF2RVRXOXFPUU1M?=
 =?utf-8?B?QXpyaEJkbTUxcFpONldia2VwMU9qcnJVNGkzays2cS92OVcwUHNWS0hDY0Rz?=
 =?utf-8?B?Zk5jVjdqUXJMRFpXR0hmMmN3OG9WR1BZak1HS1ppZjNYKzQ2SDFUTlhYcW01?=
 =?utf-8?B?YzAwNHNhdWs4OHJLVjBpNVlQVnROTWRzekg3ZWpFaFlwbjh6Q0dqWGliQy9S?=
 =?utf-8?B?a2R1VUhxTk45dm1CNGlSOXNMamZXNTJ3R2RZN3NrYmNCTmFhRTYxTmFjMS91?=
 =?utf-8?Q?ESexRZQyg574R7VpS/AJfe8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0A4D7985AD22D4281772DE601ED1398@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1933bd49-e9de-4cc2-b3e8-08dabb0274c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 05:40:44.9189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJRn+oZ78t0pFVca5UzEFSiCTxAWGIb9DZa+NQaTnLyZ4VmrKYFIJrRHa0p5ZN5LaAermxVe5Oc7qnZQea9PbhZkVCEKttdyP7CkMu+jFzQtGXR1QvkIbhTx02W9y2VW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1549
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjkvMjIgMTc6MjAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIE1vbiwgMjQg
T2N0IDIwMjIgMTU6NDA6NTggKzAzMDANCj4gTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3Vu
dEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4+IEFkZCBtYWludGFpbmVyIGVudHJ5IGZvciBST0hN
L0tpb25peCBLWDAyMkEgYWNjZWxlcm9tZXRlciBzZW5zb3IgZHJpdmVyLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPg0KPiBX
aGlsc3Qgc2NyaXB0cyB3aWxsIHBpY2sgdXAgdGhlIHN1YnN5c3RlbSBlbnRyeSwgSSB0aGluayBp
dCBpcw0KPiBhbHNvIGdvb2QgdG8gaGF2ZSBhbiBMOiBlbnRyeSBmb3IgbGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZw0KPiBmb3IgYW55b25lIHJlYWRpbmcgTUFJTlRBSU5FUlMgZGlyZWN0bHkgdG8g
ZmlndXJlIG91dCB3aG8gdG8gZW1haWwuDQo+IA0KPiBBcyBzdWNoIEkndmUgYWRkZWQgb25lIHdo
aWxzdCBhcHBseWluZy4NCg0KVGhhdCBtYWtlcyBzZW5zZS4gVGhhbmtzIQ0KDQpZb3VycywNCgkt
LSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBh
dCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28g
dXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
