Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BE731FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFOSMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFOSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:12:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA172967;
        Thu, 15 Jun 2023 11:12:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FGjUja011199;
        Thu, 15 Jun 2023 13:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=PODMain02222019;
 bh=Yz8l3NP7UumtMIfpPMYNPGaqBHAVs3TefDHUm5YyxGY=;
 b=djylbdF6MrrSShrZOjvZXI7Z3a/nsbyecUKO8DhelqblCbEQ6ImQYfX1+CzDLp6X+c9M
 SwrTnLi5IO5YJdQTuBDCRbVvWIVo205AqN8QUTTWPACJHl6kBKPj4vcIZyojWOrlClLW
 CNn66f0B92x9gaJvI/we2YcrcKWbmeO8eVu2b1YidgK6ayFMqf7dlIWT5Ux2KkGcl8Hz
 zyMdL4rzITNALSEDfwvxAposn+9TpuCruKNxixWT4BAQCCNO7mnUG4lVsq/6csPZGjy6
 LckN9nUSPkt/XdWN+/kos4rhqAMakS6NGIPlSUpZktpMGplLr0U/19vk4cZe5Zw23kvg uw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r4pk0dh5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 13:12:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVH7yiYCDJ0TIXGZbCQu0wkxjdZjaOEEK9d5j8itITg+wUI1ALGOTzsGCXANt5ZIRRe1qOpUyLSFIsRj0kfht9WmIY8BlMjQORqPX4xobrU4EEYNcxFNzlH4caJPRbgEXmUIAB0k7MKlseZ/vVSptry4O1ZaYQ4PieVbX1QUS/D0pTnf32mxumVutYnBtl2wXijaBMhwmC646o4Z0I/fDCU6hpM/Sm021bPxTDYntu+QuABRMgMY+R1Is+R60yexYICt/S0NEmIMXvr2dB6iXYIqIZV0vERU5BBq3Cd5NPtCZhuc5KW1e3vqh687heIMB/8MTLJ7+YwiVIisTCBiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz8l3NP7UumtMIfpPMYNPGaqBHAVs3TefDHUm5YyxGY=;
 b=StnRCMO4q4TXK0+hJyYZQ2yoIM+TBobD8ZCeHYGdcsnikqzoJnLMJhHV3oMSJX+ZU+/QWiLV7b9bPiq1EH8f9VrMjgM+tTMLwzoX6mzo178C3Zc0B0Abt9GZjTnGptUhKUMoRkUydyahkRDxsnl2fGwk17shdQLaWDt7LKFauZKgWl7oWQI8nzuThlO1KH2HJJeASclGsmIrtkDk+3tJFmE/mWq6ygouFVwvNcE99Ov+5KCfs5dF+DC2MiFH3VnfepCBNr9MXtOir1KnkgiNO+hju4bNk4GVv1EaTb6duRWcF7pDcnEG/0iRzjQSsac7jQUxyfKjKUfnV2qsDIZFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz8l3NP7UumtMIfpPMYNPGaqBHAVs3TefDHUm5YyxGY=;
 b=JLXbQDBTiB7AM+D351YwlxumILwRHWgx202Un2GKtQrjayjpjTZh76FIDXD/7Q/crguc22QH7U/6q950SXHx6tbtjTcz4DZIisQszfczOqwhd9CvkMZ9d91ZgNLi8l/QwjntHjXfC3tM6DVP4Q5t2RESUCCej5JJrFNwk7tD4mk=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by SJ2PR19MB7486.namprd19.prod.outlook.com (2603:10b6:a03:4c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.26; Thu, 15 Jun
 2023 18:12:20 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::c894:eb36:86d9:a226]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::c894:eb36:86d9:a226%7]) with mapi id 15.20.6521.011; Thu, 15 Jun 2023
 18:12:20 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Input: support pre-stored effects
Thread-Topic: [RESEND] Input: support pre-stored effects
Thread-Index: AQHZnWZJRPFp0nzRyka5D0UkE35WMK+H8QkAgAQ9+AA=
Date:   Thu, 15 Jun 2023 18:12:20 +0000
Message-ID: <5CD75646-02A6-4175-9176-A8DCD059085F@cirrus.com>
References: <20230612194357.1022137-1-james.ogletree@cirrus.com>
 <ZIfFgJJtGCfyIne4@nixie71>
In-Reply-To: <ZIfFgJJtGCfyIne4@nixie71>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|SJ2PR19MB7486:EE_
x-ms-office365-filtering-correlation-id: 631a7b9a-ff79-4e42-fae1-08db6dcc0fac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80lK0IxAqLfumuuZMttt8ZuSQWHIVVa1JZtpzHtsQqFkeaGRmTu3ptRO83mVvHBbLW6Jrmm26qN4JDQj6sS9V/TJp3Aox16KKDL+qSiij2ht+SZVCDz6of3hADV38iIn/rLhxyq45r/hfkxzg8wNf6YXt6I3vtCKL/eDU1yzJW5UMVyXdv0dmZ8TyOMevxVeHACGBBKift9/QDCYvxfCMYcK4cnz7oKErZA0u0g0CnrCiTA1uy1M1iT4XfBcw5qtXB1cxkPYCbG7jVYDvEZOtR6rlidCKxqSKXr3LsHopfY8iO8WDf0SisDaz07+NV8drV03s/R3jnYYDGf6HlB6ydIoEzEXHYxWEcD2dck9ft6qtDTgHSrfj6l++QI+ul4MzyhbvKzbp61U7KPqvfnkucPtUhqPh9n8Qy1u6yjd5DryDweI9raYQ50MX/F48okqsULY9D68mwFfgERi86EMsTv+7LFI7Dw2kccAWXjJz2T/5+kz8w+sewbNj9iGv2MTA4N5CU+MfwQbT8APGOQS42q0sxF0GO+j58n1poyqX8BAzUHK307Lk1vm/DYKNyecTQYJuAL87XWuibMj2ysDvIupLDKT+pqG7TRr9WnnWmaJ7vkhhHYoHwg4D9Xk3i/2dkflzv5gNGYEXG9C4BEHd1PBU7HufC5Wp3HCPOwdjHg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199021)(4326008)(6916009)(76116006)(66476007)(91956017)(66446008)(316002)(66556008)(64756008)(66946007)(6486002)(71200400001)(36756003)(5660300002)(8936002)(8676002)(41300700001)(478600001)(54906003)(53546011)(86362001)(38070700005)(2906002)(186003)(33656002)(38100700002)(122000001)(83380400001)(6512007)(26005)(6506007)(2616005)(95444003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFdkZEh0bDNDWHdMNklHTDVYUXZyMmNsNzNUem5DanpJVWg5a1NRczF1cUxt?=
 =?utf-8?B?OTAzY3pYSjJ1Y3dvZlVKN0RqSnBUZitFVU53TmtRMlBPOTUrcVQxa04xWENn?=
 =?utf-8?B?VXFtNFloM012Yy9JdTJEZ2RhcEVXMml6cSt2NzgweENSNEdwNld6TExYb1Fa?=
 =?utf-8?B?VnVUcWFsM0xYUzYzUDF4aVFLTTYwZVZFdHZZR1dnTlRlMUN5MGxoMUIvRW5X?=
 =?utf-8?B?REdUYmtHejJVRnlkU3NnaUVnelFzR3Y4MjI2dnRYYWY0S1NJd1hCQ2lmZHNa?=
 =?utf-8?B?YWlZTFR1c1oyck9BZks1UFpDZFB5WHZLQ2h5UUcvRWJVNXBLbG0xRWFuMGlF?=
 =?utf-8?B?dUVRMmlJcStYMm83WDUxVEthMnhqdm1sTEhhZGZnV3pORFZ4QVlNOEVQUkQv?=
 =?utf-8?B?VHBGbS9Vc1F4N0JFaUJxVlRVaTJVdzYzTFpmSEJoaE5GTC9iTjFBU0R4Mkoy?=
 =?utf-8?B?UndZUmJlZTZiWjFjVW1pZFhlZCtaeGo2V0ErY1ZkSWVJV2tUR0dWU0tJZHdv?=
 =?utf-8?B?UXozdk96R3o2bEtlUE5jdG9pbEZYRE5yV1VpcWVra1RjU0tJQjdPbk52M2Jp?=
 =?utf-8?B?OGk2emwxTityVFpaSTMweEZQbVlEM0VtQVVpOVZIQ3hCb0NpTzB2RHArYWQ2?=
 =?utf-8?B?WmtjZHVYUUljaW9LeDl3SVk3U054SFhaTE9BNDRYeFZXRllOV2ZCdE9PRTFk?=
 =?utf-8?B?TVY0ZDU1LzRod0pBS0FKUklZR0YvVEQ1VzdiaDVmK0RtcmUwcUFHZUkzZUtt?=
 =?utf-8?B?QnBYNnZ1OU9kV0JjdHdTUDIzam40ckhWSXY5TU9KUVZ5OXVVVFg2SWVyT3R2?=
 =?utf-8?B?V2ZiWDhxdElXNXdhbGpmdVU4cVNDZHhOS0M0U0JXSjhnOG16TDhsVSs2MVh5?=
 =?utf-8?B?cWNsSTNxYWV2ZjdjZktpU0lmRGZZUkZYRGsvajJXTnpreEJwb01ZR2psRmMz?=
 =?utf-8?B?VlZsSTFtSG85akUwTHVla2N4UW5VL2JYbnpzbzBScjR3dzZjci9IRTBqY3B2?=
 =?utf-8?B?bG5qc1VtemdhQk16WFB3MjkxcVZUd1A4dC9uUkgwdkdLMHZrdERnK25sZTZG?=
 =?utf-8?B?VjA4MnEwNDB3UXhBZGFYWC9jQlFURWRaTDRwUUZiM2x1OUNlNE1maGxPWjYy?=
 =?utf-8?B?Q2RUNFlWbnJwcDBBL05kZlB2SmJ6cTlzN3V3OHVMakxtTzRRL2RzL2NDemJz?=
 =?utf-8?B?L0RwcnoxSC8rSUpyY2p2WGFJOWROdTZaTVNFdis1UHF1KzFWckhjaFZjYXY2?=
 =?utf-8?B?ZWxWUDZlVENyTUtJL3RTdkZIaStEZnlad0NwTjFzRzlrQjFFam82VGpqc1E1?=
 =?utf-8?B?dks3UzAyUW4wOU0zc1JMWVc4TUUxRC9SOEdJaW9iSEtZNmhGVjMwTUdaYVRk?=
 =?utf-8?B?QkdJNEt1N2RiSFRnSC9HVm52WWt3OU1YRjZqSU1sQjdTeUt5SEp0MzZmbi9p?=
 =?utf-8?B?eWMxQld0aVdsMVVXODd3dlNMUDh6M2hDTHpJTmFDRFZ6YUgrUVlGZ3Z6dEF2?=
 =?utf-8?B?Nk04bjBiTHVQa2RjTVVaaW5SMnQrMU5OK3lNbFFjWTl4aFlBODl4cEpGeGZn?=
 =?utf-8?B?ZDlZZUkxek1wS0RpNzBXcjBqWGFPdHdiQk91YkFIaWNRUGJwTlVwYTEzM0Nw?=
 =?utf-8?B?YlZjd3czQkc2VW95eVA4QzV5U0tUNXlhdmlGd3pBaVh1UFcvTVhGUXdXZWhp?=
 =?utf-8?B?Zk1lT0dZNXBFK3A1NGlXUTlpbnZtdlNkMk9ic2FlQ25acFQxTlRMV1QzYVo5?=
 =?utf-8?B?WDFUUWwwTml4WGJqQnNqZmRJL0VXcGw1T01DS0YvYU9ibjFrZmpyWUVUbUhh?=
 =?utf-8?B?MStHeGtvMUUraHNxWmg0eFdGQWMwdkRFeFUvV3g0bFlnMG55dEJlQnRCYmZo?=
 =?utf-8?B?OStEa1FsYUg0YklBZUhjb2s0cUpCT0J3YUxTWTRKUEF0aEptQ1N2ZzJjU2JD?=
 =?utf-8?B?Y0ttVEpPMFMzUjBXT2xaNWxROGFhd1J6L0xmOFpkKzdPN3czbnpZeEZCdTFq?=
 =?utf-8?B?bGpHd1BPSmdZc1VyNHBDaVJNMEU3UjI3bnFjLy94b01kL0tNY2ZJZmVIZ0VK?=
 =?utf-8?B?ZnBuOUlLMmlpaDhFclAyNS9zSjBUU2RvSkQrR0hLKzErMHhWWkE1RitieHNR?=
 =?utf-8?B?QkIwa2xGRVc4enBZVHlkQW9OZDJQSkxCQS9CdXJBVENUQndxMXIvWVM1RTJu?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D30985313288142A26FF943F08EC1F3@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631a7b9a-ff79-4e42-fae1-08db6dcc0fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 18:12:20.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqnMkuXIuiWY/lGfudZ04My6u+vGlNb0BjdFMxJpiOclpr12yLJ8+6bQuuhrUi64RHLoC8PzW3pq+YCf4pb4DDDF9jvIcPPUCQGirMy99QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7486
X-Proofpoint-ORIG-GUID: G1_32t1OW-kG8ej0eaECgj6alX7fbpme
X-Proofpoint-GUID: G1_32t1OW-kG8ej0eaECgj6alX7fbpme
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVuIDEyLCAyMDIzLCBhdCA4OjI1IFBNLCBKZWZmIExhQnVuZHkgPGplZmZAbGFi
dW5keS5jb20+IHdyb3RlOg0KPiANCj4gSGkgSmFtZXMsDQo+IA0KPiBPbiBNb24sIEp1biAxMiwg
MjAyMyBhdCAwNzo0Mzo1N1BNICswMDAwLCBKYW1lcyBPZ2xldHJlZSB3cm90ZToNCj4+IEF0IHBy
ZXNlbnQsIHRoZSBiZXN0IHdheSB0byBkZWZpbmUgZWZmZWN0cyB0aGF0DQo+PiBwcmUtZXhpc3Qg
aW4gZGV2aWNlIG1lbW9yeSBpcyBieSB1dGlsaXppbmcNCj4+IHRoZSBjdXN0b21fZGF0YSBmaWVs
ZCwgd2hpY2ggaXQgd2FzIG5vdCBpbnRlbmRlZA0KPj4gZm9yLCBhbmQgcmVxdWlyZXMgYXJiaXRy
YXJ5IGludGVycHJldGF0aW9uIGJ5DQo+PiB0aGUgZHJpdmVyIHRvIG1ha2UgbWVhbmluZ2Z1bC4N
Cj4+IA0KPj4gUHJvdmlkZSBvcHRpb24gZm9yIGRlZmluaW5nIHByZS1zdG9yZWQgZWZmZWN0cyBp
bg0KPj4gZGV2aWNlIG1lbW9yeS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgT2dsZXRy
ZWUgPGphbWVzLm9nbGV0cmVlQGNpcnJ1cy5jb20+DQo+PiAtLS0NCj4+IGluY2x1ZGUvdWFwaS9s
aW51eC9pbnB1dC5oIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4+IDEg
ZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+IA0KPj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9pbnB1dC5oIGIvaW5jbHVkZS91YXBpL2xp
bnV4L2lucHV0LmgNCj4+IGluZGV4IDI1NTdlYjdiMDU2MS4uNjg5ZTVmYTEwNjQ3IDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2lucHV0LmgNCj4+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC9pbnB1dC5oDQo+PiBAQCAtNDI4LDE3ICs0MjgsMjcgQEAgc3RydWN0IGZmX3J1bWJs
ZV9lZmZlY3Qgew0KPj4gX191MTYgd2Vha19tYWduaXR1ZGU7DQo+PiB9Ow0KPj4gDQo+PiArLyoq
DQo+PiArICogc3RydWN0IGZmX3ByZXN0b3JlZF9lZmZlY3QgLSBkZWZpbmVzIHBhcmFtZXRlcnMg
b2YgYSBwcmUtc3RvcmVkIGZvcmNlLWZlZWRiYWNrIGVmZmVjdA0KPj4gKyAqIEBpbmRleDogaW5k
ZXggb2YgZWZmZWN0DQo+PiArICogQGJhbms6IG1lbW9yeSBiYW5rIG9mIGVmZmVjdA0KPj4gKyAq
Lw0KPj4gK3N0cnVjdCBmZl9wcmVzdG9yZWRfZWZmZWN0IHsNCj4+ICsgX191MTYgaW5kZXg7DQo+
PiArIF9fdTE2IGJhbms7DQo+PiArfTsNCj4gDQo+IFRoaXMgc2VlbXMgbGlrZSBhIGdvb2Qgc3Rh
cnQ7IEkgZG8gd29uZGVyIGlmIGl0J3MgdXNlZnVsIHRvIHJldmlldyByZWNlbnQNCj4gY3VzdG9t
ZXIgdmlicmF0b3IgSEFMIGltcGxlbWVudGF0aW9ucyBhbmQgZGVjaWRlIHdoZXRoZXIgeW91IHdh
bnQgdG8gcGFjaw0KPiBhbnkgYWRkaXRpb25hbCBtZW1iZXJzIGhlcmUgc3VjaCBhcyBtYWduaXR1
ZGUsIGV0Yy4gYXMgaXMgZG9uZSBmb3IgcGVyaW9kaWMNCj4gZWZmZWN0cz8NCj4gDQo+IEJhY2sg
aW4gTDI1IGRheXMsIHNvbWUgY3VzdG9tZXJzIHdvdWxkIGFzc2lnbiBjbGljayBvciB0YXAgZWZm
ZWN0cyB0byBvbmUNCj4gb3IgbW9yZSBlbnRyaWVzIGluIHRoZSB3YXZldGFibGUgYW5kIHRoZW4g
dXNlIGEgc2VwYXJhdGUgZGlnaXRhbCB2b2x1bWUNCj4gY29udHJvbCAoYXQgdGhhdCB0aW1lIGV4
cG9zZWQgdGhyb3VnaCBzeXNmcykgdG8gY3JlYXRlIGEgZmV3IGRpc2NyZXRlDQo+IGFtcGxpdHVk
ZSBsZXZlbHMuIFBlcmhhcHMgaXQgd291bGQgYmUgaGFuZHkgdG8gYnVuZGxlIHRoaXMgaW5mb3Jt
YXRpb24gYXMNCj4gcGFydCBvZiB0aGUgc2FtZSBjYWxsPw0KPiANCj4gSXQncyBqdXN0IGEgc3Vn
Z2VzdGlvbjsgSSdsbCBkZWZlciB0byB5b3VyIG11Y2ggbW9yZSByZWNlbnQgZXhwZXJ0aXNlLg0K
PiANCg0KTXkgdGhpbmtpbmcgaXMgdGhhdCBmZl9wcmVzdG9yZWRfZWZmZWN0IG91Z2h0IHRvIGJl
IGZvciBlZmZlY3RzIGJlaW5nIHVzZWQNCuKAnG9mZi10aGUtc2hlbGbigJ0sIGFuZCBpbiBzdWNo
IGNhc2VzIGl0IHdvdWxkIHNlZW0gYXBwcm9wcmlhdGUgdG8gZGVmZXIgdG8NCmZpcm13YXJlIGZv
ciB0aGUgZWZmZWN0IGRlc2lnbi4gSSB0aGluayB0aGlzIGZpdHMgbmljZWx5IGFzLWlzIHdpdGgg
dGhlIG90aGVyDQpzdHJ1Y3R1cmVzIGFzIGl0IHNlcnZlcyBhIGNsZWFyIGFuZCBkaXN0aW5jdCB1
c2UtY2FzZS4gT3RoZXJ3aXNlIG9uZSBtaWdodA0KanVzdCBhZGQgdGhlc2UgdHdvIG1lbWJlcnMg
dG8gZmZfcGVyaW9kaWNfZWZmZWN0IChvciBldmVyeSBraW5kIG9mIGVmZmVjdCkuDQoNCkkgdGhp
bmsgdGhlIGN1cnJlbnQgcHJlZG9taW5hbnQgbWV0aG9kIGZvciBzZXR0aW5nICJtYWduaXR1ZGUi
IGZvciB0aGVzZQ0KcHJlLXN0b3JlZCBlZmZlY3RzIGlzIGJ5IHVzaW5nIHRoZSBGRl9HQUlOIGV2
ZW50IGNvZGUgYXMgYSBzZXBhcmF0ZSB3cml0ZQ0KY2FsbCwgc28gSSB0aGluayBhZGRpbmcgYSBt
YWduaXR1ZGUgbWVtYmVyIHdvdWxkIGdvIHVudXNlZCwgaWYgSSB1bmRlcnN0YW5kDQp5b3UgY29y
cmVjdGx5Lg0KDQpUaGFua3MsDQpKYW1lcw0KDQoNCg0K
