Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB26472B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiLHPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiLHPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:19:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A170B86;
        Thu,  8 Dec 2022 07:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670512650; x=1702048650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cgHFGdNlV2FuTFM2+XBgejFEMtofZUQ6KCT1IpFMlXQ=;
  b=UWHVUQbWwGGrNVVGgHUzeEtlKdcFa8UAaGwcYKuAe1loqB1noW2dl0wL
   irLd1F5Znud2lQhvvFfgcBMrY+mqB+DS35nnaQqX+C0wNrghxaYT1oRCt
   ++6D9o2jfV1UURZjX5xd3erenECSmBqiDTcDGaqGQTTlurj/TbxuxILId
   y+gPExIp8OWRpo7O4AKdtL0dXaAB2ChwwtmrI4q0COzI01I47ebMligIu
   tkpDVfatObLg0XbXbVZLGs/6hsLROWx5bCks5qGA1OBMCCLopJmh6+gu2
   VvNawtwrlUFhgeONv19VwDO19G29jRyyVLkBuJVJYffF/+Mx17SScv2mW
   w==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="192251469"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2022 08:17:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Dec 2022 08:17:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Dec 2022 08:17:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ9zbhdmMoq9Vr+giZPfaYri/ROi8MDW9jOwirK6Stjl+ANZwjegn9xZCdMlh15fri6eeKhL7GAHFLgYbsVWcs3RNGZqskJig410K/iczznsZZ3g+FDS2N7nZcpBY4fRYqk+5DeK/1IMCA8CtD0BRNmyaoh/BVn+4t1HQrPZYglpE6auF9twG1OZD8O3RaensKqqyoypjx5HS+pbO0ZbZs4atDVYWERvFyRvi1yGGs4kaCFErwEaLxln4SKr8u38fEFMW+2mcVK5MX3fNbs+PqIQ7AiYEfPt7x/RwcgfFnmMmpk54vLogC19Jvt165wlkDhWWQQV8sEvVQ6plfiCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgHFGdNlV2FuTFM2+XBgejFEMtofZUQ6KCT1IpFMlXQ=;
 b=OF0P2mICNfDsAmyeXSNR+og0DGwD6SDkwtUwnG7fwQaABiAxSgOYgAjHUHDcXKJF95xWztKZfJ/d3aSB6CHqSHL/z9iRZ0m7IeJyao4hT1funUnmp32h2ul7gELbHD629hjYUHVnnsd4okGJfXYtSBUVV2wcGgdQgt/LQteCsZdM44JrNMkBDUVEqF0OpCgNSOr/Op5XDQUJXGK8qMtQRgDcs1Vimm7/O/CAyd314AfzdSVvL91AH3nyix+4Fwo0JdIvkyIgXDGBDmG1g5gjHIrhwgMCys4bilWqOasPWYnrXmAyIS3PKsiql0XbIMPjXM6NSRvWIW4NbLHE9FX4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgHFGdNlV2FuTFM2+XBgejFEMtofZUQ6KCT1IpFMlXQ=;
 b=DlYQnZc33uU0Q7PKwKzS5qr27JG/5EdNVPabmi8LU9hFjR8Brq0x7BDXFecMR386u95t6inR7KGYxc7v9xaLONR9ywP/djihcYiUVaOOJOnmtxLedKcIe5gBdd1fZL7/8EIlxS3dO94tbH2Iq4N6iY1RpZJieTOYQ51nnqmaRgo=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN9PR11MB5388.namprd11.prod.outlook.com (2603:10b6:408:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:17:25 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 15:17:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] clk: at91: do not compile dt-compat.c for sama7g5 and
 sam9x60
Thread-Topic: [PATCH 3/3] clk: at91: do not compile dt-compat.c for sama7g5
 and sam9x60
Thread-Index: AQHZCxgt6NCOpKjWHUKL0ZXP2YbkRw==
Date:   Thu, 8 Dec 2022 15:17:25 +0000
Message-ID: <27ab1e71-6fdb-af0d-7dd1-a7731c1e2e95@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-4-claudiu.beznea@microchip.com>
 <Y5H3EH7kPOwGI2SQ@mail.local>
In-Reply-To: <Y5H3EH7kPOwGI2SQ@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BN9PR11MB5388:EE_
x-ms-office365-filtering-correlation-id: d785c26c-ece2-4a69-e12e-08dad92f4fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ck0/kOcXiLibkVIrCQ0TgJI5Q1dRB/sqs58bFzdCl0cdAkr2vjk14mJa+w9woOErR/9ANPbU8C5RWi//6bEdSxKszZR15/U0fmhje1SLmzkrcXMiU5/XKcxvxO13Pgga46dqEpiVqeDlCatGiTWDjKRaqO7j2RksMTIdW0s7t+X3uIf9h2gHcnKN7o8f+u8dUb0qZdTi5J7lm3raDwNew7S/mK0lJ3eE6i9nV0dM1GS/gWm5zYVxwmrCt5gVBbSDxXSV5F4CEh6vT4jChp0+HlOwgnA8aV/xf/fAtT9pkFv/pimi6qDm4TR7OO0AMIErQEusajKZxgwba5xR7X32weo6d5J3WVJQBlAzP0sUJa5gt0k8KtRkggrhtdpEVV47V41SEL2TpFbWsJ/K+mk6HLYnQ2cWgdt2CTyJFBGVEIeKvmU67aikvyZIw4MFSySDhPxiHnNnPdrVSsSiJoLItSWAi6p6qsk75/vlZ+7J1KaFjm0NgUQJJV22FCfNrhAeU2BhUYBIAGpjOrWmghYoWYp+lByxeWypUxHRZ0O+Ab3OINxq+n32m0RtSOi5Qfv2FGb+cLfGGzo01d3cN3hZxtfrA+F6GNtisICrYy9xkWCmSWZM1LKxkgAt5JBIgiEad2ZvVxvPRowjRQTevjFYP+7PkROSM9IMRBfDmKbwRkwdsCprdSCeVi2jfiNHwkfy+I5gT15VGldXGrGMYg4Sgg09YdGyszMAS0akxBMpt2Ekxpx7HsNLItGPXXwuqKNPSagNzIOw85krJqLXsYBvYaprWs9Y0RlfyKWutqUhJQQ+9RoguflYO/DqwVDfbs5OXwtTmDiyPxuWfJKWejUvn0FlcoMZng2X/Nma3nkFQNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(36756003)(31686004)(31696002)(66446008)(86362001)(54906003)(66476007)(4326008)(64756008)(8676002)(8936002)(41300700001)(66556008)(66946007)(91956017)(76116006)(2906002)(38070700005)(122000001)(38100700002)(83380400001)(6916009)(2616005)(316002)(6486002)(966005)(5660300002)(26005)(186003)(6512007)(478600001)(71200400001)(53546011)(6506007)(138113003)(60764002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MllSc0JvUWdVTm00M2EyZ25aamNrWnpMelVsdEpjYkZsZTdvdFVQMTRWbzdh?=
 =?utf-8?B?S3BITStMb08zTW5oZVNIbUtVZ3crSUtxbU5xSk96a0RMbmdsQXBmVFNYZmpD?=
 =?utf-8?B?YXdFWXB4Nm1vYWdEdWhpMENvQ2JyS3AzdHovTXFJUG5BcDJONkhiTVZQYmd3?=
 =?utf-8?B?M3paSmlyTVlBU1ArV0pMd1QyOEVISEFLcmhRRzRMU0EwUmtoUExJUW5vMGJ4?=
 =?utf-8?B?WTdaLytTVUdWZ3V6bnlkaVI0UFNsYVZWZUk5SVcyTUV2Tm11dnVrbWNJTnky?=
 =?utf-8?B?dndNamJnY1hLNUF0NXRudkJJbkpNUFEzN0xqUlRQVlY5cUpEcHZiRUFKbWZS?=
 =?utf-8?B?OWFGUWlxcktRRGFTY1hLL1dGTWR3UmdiaC85emZHMHROdnZoS1lpQVgrbkpZ?=
 =?utf-8?B?YmdjRlh6WHNIUWIzOW1pb2JyRVloZVJNODYyNU5iMC9SelJXWEUzY1MyWEFZ?=
 =?utf-8?B?MC80dVZXa0NDSzZONW43NC8yaC9OZ2p3NXlTZzZkZDdkaitpMDZpcTFjcHRQ?=
 =?utf-8?B?Mzl2U3VsSzI1Zm1SNVdLU1VDaHRncGozSXRMLzBnVWlBOWh3djlxMFhYNWt6?=
 =?utf-8?B?V3VxbHlTSEswNEs0dWdvbUFhamhCT1M2L2hRQm44S2MySS80ajhiMWVBbWRp?=
 =?utf-8?B?cjhEQzU0Y250NG5lUE9Bd1Mvd2hxWFJSeHFrcEUxT2JHcktpV09MTk1PaUI4?=
 =?utf-8?B?Y2VMS204TlFxeW9KMFdORVZpS1JzMXRDaWIwM05pWngvUXhGcVlBdjd5dHZL?=
 =?utf-8?B?aWlvdGZWY1dvbitNd2dFcHc2NFN6am1TdTA3a3JTL2hUZXZSZXNDZHNnRExq?=
 =?utf-8?B?Tmoyb0tMRXdzQnV0YWpEeWJsVWxmT0dWb1RXU0VPQ0VITkd0b2VDWWM2QnVG?=
 =?utf-8?B?d1ZVdFdtTHdZdmpuOUl0RSt1OU50UVhoNGJjM1RxRTYyOUlsSUJLbUJHeE5M?=
 =?utf-8?B?a1M3eFExTngydDBPMGx4ZDREZDNCdDZ2MVpGRCtjRUxBSWVUV25GTjBGR0ZC?=
 =?utf-8?B?bjEvTnBxSlBuMHZRU3dKeXUxT2IzVFJjTXRYektoVlJMaVVWMzduYjlhZjRL?=
 =?utf-8?B?SDhEaVY0N1NscnVndXFJNmpzTVI1SVhOWHlFZTlJVW5iVVVKUEVEbTI5NzZM?=
 =?utf-8?B?ZWoxMXJBNVJrdWMzTHBEc3ByaG9hcEhpUE9qaklYRUhSVDdVcmVEMXBkYTJO?=
 =?utf-8?B?ek5yUUV6c0RGQm9vci9vdUNtdGZkYk9VZzFRd2Z6NzJVNUdNMndWdlc2THh4?=
 =?utf-8?B?bENFaGh3MFBYOFFlanNqd0lMSmRuMURvck9scVROTnFxd2paVVR5NHQrUjhX?=
 =?utf-8?B?YW8rSUxqd3EyNkdlbm56SUx5MFZ4Mi8ycGdoVktXZTE1TjVtVWVLUnRIOGZU?=
 =?utf-8?B?WHpiNGJ3RGlxL05iRlFKY3FBQ0RQVythdmFBaitGTld0ZFN4YUVKYnl2RUZQ?=
 =?utf-8?B?TjFWMjNLcER3YysranZkY1NGWkRIK3JLR1FtRUZJRUVYaDNrSDUzNUdoR01Q?=
 =?utf-8?B?RnNJc3JPY051TnNUZVloYzZ3ZERISUx1THpKRUI0YzVCdWozdlEwdVF4ckFp?=
 =?utf-8?B?QkxWcjFuSjRlV3IvdHNBUldXTC9YQ2ZXN3NaR0Y3Y09RME4wTVpoYW9TZCtC?=
 =?utf-8?B?VTZlZmc5SDhCY1JUbllEbTNzV1BIYnJRV2hNMkRKNTJhaUMyd0pvY1BDN3FX?=
 =?utf-8?B?M3ROai8yT3ozQVVzR2VzUDhYZi9YdHY5ei8yT05SclpUbTgrZXZENXhJSmND?=
 =?utf-8?B?aUIwT1BRVCtFNWNzZ21EK0RzQi9qYzZkQ2lxa2U1bnBVdEtWL3FramMvUXZC?=
 =?utf-8?B?YXh6QlYwSWxwcW81S0tIOVFaVjY2M0RsTHdYM0t3NUxpb2VJcmZQMUw0bllO?=
 =?utf-8?B?a1VuYWNUK0ZBWUFxVDg5eVFkeTlPcTRnVUNKTHYwcTJiNlF6Q05zZEc4UVJL?=
 =?utf-8?B?SjFIQmhWUWFtakFpMmtpNUJndGwxNnduY3MwOGhvY0o5VG5xRVFPNmVrQkNk?=
 =?utf-8?B?Z0F2YUUrdVdxVFE1TjJUM3ErQmYzQzRkQW1QeHZ3d0hWL0pZRHBxNlg5dy8x?=
 =?utf-8?B?TVNGT1dKL29pYkR3bkZCTTVLU241SUpCNjNKeGRScG1OTHBJN3p6WERyam45?=
 =?utf-8?B?UkJkQXUrQ0hUNjBDWDlsVDU4a1NiNC9TNHcwUGFJeUFuci9jNzZzc1F1UjU3?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB9ECE7A231B5144ADCF651E01598B74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d785c26c-ece2-4a69-e12e-08dad92f4fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 15:17:25.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF7F0x3iU7HrbC3LnH36x75S+hxMFA5olNw7eY4G6Qc26Lj21yF6Wn03lyKoOGoz5pKaqlXoYS9BIxB7Mrp5C9o0uGdjvl3qnKe2jIcdRx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5388
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMTIuMjAyMiAxNjozOSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMDgvMTIvMjAyMiAxMzo0NToxNSsw
MjAwLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IFRoZXJlIGlzIG5vIG5lZWQgdG8gaGF2ZSBk
dC1jb21wYXQuYyBjb21waWxlZCBmb3IgU0FNQTdHNSBhbmQgU0FNOVg2MA0KPj4gYXMgdGhlcmUg
aXMgbm8gaW4ga2VybmVsIGRldmljZSB0cmVlIHRoYXQgY291bGQgdXNlIGl0LiBUaHVzIGF2b2lk
DQo+PiBjb21waWxpbmcgZHQtY29tcGF0LmMgZm9yIHRoZW0uDQo+Pg0KPiANCj4gSXNuJ3QgaXQg
dGltZSB0byBkcm9wIGR0LWNvbXBhdC5jPyANCg0KTXkgYXNzdW1wdGlvbiB3YXMgdGhhdCB3ZSBu
ZWVkIHRvIGd1YXJhbnRlZSB0aGF0IG9sZCBkZXZpY2UgdHJlZXMgd2lsbA0Kc3RpbGwgd29yayB3
aXRoIG5ld2VyIGtlcm5lbHMuIFNob3VsZCB3ZSBndWFyYW50ZWUgdGhpcyBvbmx5IGZvciBhIGxp
bWl0ZWQNCnBlcmlvZCBvZiB0aW1lPw0KDQo+IEkgd2FzIGdvaW5nIHRvIHNlbmQgYSBwYXRjaCBh
ZnRlciA2LjENCj4gaXMgcmVsZWFzZWQNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMv
Y2xrL2F0OTEvTWFrZWZpbGUgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvYXQ5MS9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL2F0OTEvTWFrZWZpbGUNCj4+
IGluZGV4IDc5MzAxZTFjMWMzNi4uODkwNjFiODVlN2QyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9jbGsvYXQ5MS9NYWtlZmlsZQ0KPj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9NYWtlZmlsZQ0K
Pj4gQEAgLTMsNyArMyw3IEBADQo+PiAgIyBNYWtlZmlsZSBmb3IgYXQ5MSBzcGVjaWZpYyBjbGsN
Cj4+ICAjDQo+Pg0KPj4gLW9iai15ICs9IHBtYy5vIHNja2MubyBkdC1jb21wYXQubw0KPj4gK29i
ai15ICs9IHBtYy5vIHNja2Mubw0KPj4gIG9iai15ICs9IGNsay1zbG93Lm8gY2xrLW1haW4ubyBj
bGstcGxsLm8gY2xrLXBsbGRpdi5vIGNsay1tYXN0ZXIubw0KPj4gIG9iai15ICs9IGNsay1zeXN0
ZW0ubyBjbGstcGVyaXBoZXJhbC5vIGNsay1wcm9ncmFtbWFibGUubw0KPj4NCj4+IEBAIC0xNSwx
MiArMTUsMTIgQEAgb2JqLSQoQ09ORklHX0hBVkVfQVQ5MV9IMzJNWCkgICAgICAgICAgICAgKz0g
Y2xrLWgzMm14Lm8NCj4+ICBvYmotJChDT05GSUdfSEFWRV9BVDkxX0dFTkVSQVRFRF9DTEspICAg
ICAgICArPSBjbGstZ2VuZXJhdGVkLm8NCj4+ICBvYmotJChDT05GSUdfSEFWRV9BVDkxX0kyU19N
VVhfQ0xLKSAgKz0gY2xrLWkycy1tdXgubw0KPj4gIG9iai0kKENPTkZJR19IQVZFX0FUOTFfU0FN
OVg2MF9QTEwpICArPSBjbGstc2FtOXg2MC1wbGwubw0KPj4gLW9iai0kKENPTkZJR19TT0NfQVQ5
MVJNOTIwMCkgKz0gYXQ5MXJtOTIwMC5vDQo+PiAtb2JqLSQoQ09ORklHX1NPQ19BVDkxU0FNOSkg
Kz0gYXQ5MXNhbTkyNjAubyBhdDkxc2FtOXJsLm8gYXQ5MXNhbTl4NS5vDQo+PiAtb2JqLSQoQ09O
RklHX1NPQ19BVDkxU0FNOSkgKz0gYXQ5MXNhbTlnNDUubw0KPj4gLW9iai0kKENPTkZJR19TT0Nf
QVQ5MVNBTTkpICs9IGF0OTFzYW05bjEyLm8gYXQ5MXNhbTl4NS5vDQo+PiArb2JqLSQoQ09ORklH
X1NPQ19BVDkxUk05MjAwKSArPSBhdDkxcm05MjAwLm8gZHQtY29tcGF0Lm8NCj4+ICtvYmotJChD
T05GSUdfU09DX0FUOTFTQU05KSArPSBhdDkxc2FtOTI2MC5vIGF0OTFzYW05cmwubyBhdDkxc2Ft
OXg1Lm8gZHQtY29tcGF0Lm8NCj4+ICtvYmotJChDT05GSUdfU09DX0FUOTFTQU05KSArPSBhdDkx
c2FtOWc0NS5vIGR0LWNvbXBhdC5vDQo+PiArb2JqLSQoQ09ORklHX1NPQ19BVDkxU0FNOSkgKz0g
YXQ5MXNhbTluMTIubyBhdDkxc2FtOXg1Lm8gZHQtY29tcGF0Lm8NCj4+ICBvYmotJChDT05GSUdf
U09DX1NBTTlYNjApICs9IHNhbTl4NjAubw0KPj4gLW9iai0kKENPTkZJR19TT0NfU0FNQTVEMykg
Kz0gc2FtYTVkMy5vDQo+PiAtb2JqLSQoQ09ORklHX1NPQ19TQU1BNUQ0KSArPSBzYW1hNWQ0Lm8N
Cj4+IC1vYmotJChDT05GSUdfU09DX1NBTUE1RDIpICs9IHNhbWE1ZDIubw0KPj4gK29iai0kKENP
TkZJR19TT0NfU0FNQTVEMykgKz0gc2FtYTVkMy5vIGR0LWNvbXBhdC5vDQo+PiArb2JqLSQoQ09O
RklHX1NPQ19TQU1BNUQ0KSArPSBzYW1hNWQ0Lm8gZHQtY29tcGF0Lm8NCj4+ICtvYmotJChDT05G
SUdfU09DX1NBTUE1RDIpICs9IHNhbWE1ZDIubyBkdC1jb21wYXQubw0KPj4gIG9iai0kKENPTkZJ
R19TT0NfU0FNQTdHNSkgKz0gc2FtYTdnNS5vDQo+PiAtLQ0KPj4gMi4zNC4xDQo+Pg0KPiANCj4g
LS0NCj4gQWxleGFuZHJlIEJlbGxvbmksIGNvLW93bmVyIGFuZCBDT08sIEJvb3RsaW4NCj4gRW1i
ZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29t
DQoNCg==
