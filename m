Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D565C343
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbjACPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjACPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:46:43 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC9D11C16;
        Tue,  3 Jan 2023 07:46:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+KOleEeoA7ZDFa+Tsu75rsa0H4Ob6yI9F6IhZ+fBsu6Y2XaSj9ZUtXMN7+9+3/LtuAnPWMC8qRc1SozmoKnB/th4moXGl2weDlC0IqngDO8JbfYYB26DKZGW9YBFYp4b34fHiAG/6wtMmCkuF7DWRoBnOtHMCheVpjssw0Rvly6qu7MCtHgdom4mA63mCOsYHpqLKNSOiDhr+7c/HYI/YvfaGCM9uwlQWNKjMwdUuZL6euHxG8VbLCKVh6djtyz0GDb1ggI59mkplvyPMABNnoInpcdHhq9wI1GXcVQPhdTTA13LP219Go66NVR0UeNZB/Vhbp6pqL1bIM43ika3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbpBtiz0fQS/P35ruITTp5W4Fl+SlKtZbhXBofZfhkc=;
 b=AIdRphx70XvdYsy+ILBc/N+0oMRcJH+XLHTWofQxNSd8+alFa60eLkL52uF08cS3R01RYUHRKUD9Z6czZOACiK4ERT9lN349suH7kCWDBY9EyhK5VPTLs35lt0jHaJ2K2ZLg+DJKuuy/jFDRhlqYqLr6npDigOjOZDQ0S2BSHFHIxLhfst3fKCk0U/HilFzuEvW8GWMO6MhBHNKaAx8lhDC6wk/xXPcC97gPB7V2Na5oe5ZoCWWbf8wjJptaT0DSLTsmo2Ts5y6Flp9RtQvHJc0pBB1ou/3A+a12w0SGt8SY8u6PWhldQ/sGMHH+d8pjfHLqvbmBJOEg8o4nKvr4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbpBtiz0fQS/P35ruITTp5W4Fl+SlKtZbhXBofZfhkc=;
 b=ZsQkgCZpL5qoaDRXGd0pa0VSMtrxXtJyu+/WNsrdpKuvCRz68dISuQFKQIUXkJu2Zw52uw/I1SElXBsS+0OqyMkoc4/vDpkBJl0iVy/vTEznl84TVeUQjC5knAHnRff85pSRVLufeq6fJo11sHjFPWYDk5lpM0rSgPx9JNz4jYA=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB10975.jpnprd01.prod.outlook.com (2603:1096:400:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 15:46:37 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 15:46:37 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Topic: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Index: AQHZFYCNlCsLkG/3E0Cexn6vTGGaoK6McgmAgAAOnPCAADi/AIAAI8Dg
Date:   Tue, 3 Jan 2023 15:46:37 +0000
Message-ID: <TYWPR01MB87753C261831519F4D6788E5C2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
 <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <Y7Qk/EgOI9mkJIjn@google.com>
In-Reply-To: <Y7Qk/EgOI9mkJIjn@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB10975:EE_
x-ms-office365-filtering-correlation-id: ab380505-8575-49f9-51b4-08daeda1b305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L1pDimmpBXEj2smt/pzk2ZnAkKFPo8MVyLJMCKekxFcufsZmvDqlSiKBSHJB0pjVjRtsp2e30qs1nkdjATXfff8glOIHH8/uymrkfo2LE/y//oG2ijYuFiaUQIl7rXuRRsOiw/EDhDCv2riQNjA9GWwCiXngwwibSnYlzO6s9u+LI/P+qYINe39bw1P5vfCXHrYvPUcWwtbTllkA5aGRvLRV0KvTeHK/gNT/4aJ4SVlcHc6WQxdNMp49Dl7Y6scGDseGAyk6FYOTIGhk+ga8FuKptowuVWjHW7V0FC0ieIgLUKEf5Oc6pt/2KtC7QOYmSDTmyjJkwARclMNoKhWuAoStlmfYLhHWM6Kap1j2gyDkMx0DGRgdZGouXgaz375wCE1JKk6vnpxNXgY1X46O8gMeSFfTnUaLHo6Ya9/Ke1NZtnaZXfmSOZcchi1Rh7dF36Mo1rEESH7wqK9iZ8ikRfgGZl6IpGgs1Ub6IOWp7QcK5LhB6Z4wJ4tPixmBdRtD2ipzrav2LKGwCumNAkJoY1II0rbTZIhXABblH51NVhETexe9LjhfVO3ZIuvr+c4yEvG4/mU9MmjT/qXqwsmda9lJx2GDaxBvRU5EwbQ3Z5jwuPmtPQHJgWp15uASqjXdQMW6HLZdrQvRL796YHPpRBvM8d7B+AqnASQqZ6iaH6PidhoqBztVIYXLrr7fnsbEvb+tzO8+BLrorsNJ5eoFM2DeNyZ4LSEX1m7dWFLbmmk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(83380400001)(55016003)(86362001)(33656002)(38070700005)(122000001)(38100700002)(316002)(52536014)(54906003)(2906002)(6916009)(4326008)(8936002)(41300700001)(7416002)(76116006)(66946007)(5660300002)(66446008)(66556008)(64756008)(8676002)(66476007)(186003)(53546011)(26005)(478600001)(9686003)(6506007)(71200400001)(7696005)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0NJYXJWODdzREJRKzljVDlZYjlKbEVwY3dFN2owcmpCWm5QU21pL2VadjND?=
 =?utf-8?B?MERXTy9VRGtxV0pvblhSdTNZWmNjZURPY0hUWXVpVU5CT0JReVhvU2VxUE5V?=
 =?utf-8?B?d0xIWnQvK3h1R3UyQkhWdFZraWM5UHM0SVROVmE4alZCQTF1K21oNjB6a05n?=
 =?utf-8?B?c1dYbkZxbS9oZmNOdFBhTWtqQXVUeTlReE0ycnB1VGw1Q1JBS0luMXMwZ0VM?=
 =?utf-8?B?WFNQTCs4ZWZxQS9FdVd4cEdTeWJNZkpxK0Q5S25NaGRud2EzUDJCQVdPSS92?=
 =?utf-8?B?ZG5WYSt5bFo2b0dtYkFyR0IvcGdpWXlTaWlzcGM1b3R5UHVmMWRGTGtaU2h6?=
 =?utf-8?B?VUZUZzY1WUgrMytPVDlFcmN3WnRVZ0lqci9xdUg4Y2prb2UzZjYzWDZHWVFx?=
 =?utf-8?B?SGZpVGhNODU5dGRIalI2SnlQbHJqcVpoeGszYTlvU3NBcm1iZnk4Rk45aWgr?=
 =?utf-8?B?Q1pEQXhUOVNUTnFDNmlyVnNPNWF3Vm9sSnNxa01KTCszSXNYR1VsbkFFenNL?=
 =?utf-8?B?TUpyRm93VTg4OEgzNFNST1NmcXV6OXZ2eTRPSlM0TFhwNDVyNllOMW1jNzZQ?=
 =?utf-8?B?eC9hNGkySE1uODR5aENBQVpBQTRhM2RxY0Z6ZXQwbjFXR3hydGt3UHkzVjFC?=
 =?utf-8?B?ZEQ3MTBvSUdLQW5CRk9OT3g1VzFQNFJtUjdzeDRQZlpmMXd2NUxCMWpsZURi?=
 =?utf-8?B?UzJ3bThvR25ycWlYSUsxT0ptWURQQ2tNSFdpM3g2UGc4K0d2YVBMam1ZeTVq?=
 =?utf-8?B?bWllUlFSUEtCT1FJWkZxNjRCRVZGUEpRdWdraTZtV2lmbWpYNXl4N3YzbnVG?=
 =?utf-8?B?VU1LbFJJUkRKVFdmazVHTzl2SXovSkgrM1gvcnoydkViWHlheDMrdHQ0clBR?=
 =?utf-8?B?ZjVrWE1NeHM3WHk3NGI0Sjg1a2Rscy81VDlaZ083ZVphTUhoYldGdlZhSTRz?=
 =?utf-8?B?bXkrODhYNmlsVGgxWU9qODJHZ3I3L1FBM1pmcmJ5WXVYMW9HYkFXTjJ6YnNC?=
 =?utf-8?B?alkrdU5hWHVPdU9YOGpBMDQ4V0VkQ2NpOHBZNG9uMWsvNnl1anIvMEl4bkhL?=
 =?utf-8?B?UnBCWDRla2VndmtwN2o0TkgxdnI1VFNhdERYQ0ZwaStlWTBCWUEzK2k5MU9r?=
 =?utf-8?B?UWgwbXgrMWVXamlPZzhmVTVieDNNUVhMTW5qa2dzamZaaVE4WVpJZDluY2Iw?=
 =?utf-8?B?ODlTVkJEN0JrSlZnNVFmc1N0SlpBRzFmUzRZbGRkMVptUkpOYVBOTEFRTkZy?=
 =?utf-8?B?NUI3Qk83MHJoOHduNjlIS0Jqby9qQnNQWlhQRGVRUzZnUTA1dUozZ0czejUw?=
 =?utf-8?B?b0I0MXpobWdGNmtNL3pBTTM4NFNWRktQeWprUnNLbzJaVnNtTmZZS2ppNm50?=
 =?utf-8?B?NTJjMkE0TzByais1MWYyeWswaGRyTGRSK3ZlTkpRcEswV1hBQ1hoNWhLK25n?=
 =?utf-8?B?RkF0Wkl5cGZXOGlvYWNpOW5mR1I4MFduNm9oOXM2MjVIRDFJNCs1NUQwVDd6?=
 =?utf-8?B?N3pzU1pRL1l3VVoxK1EwSWdZM0RSd0lsTi9oWWQ0blFNRlQvN1pCcCtWd3RC?=
 =?utf-8?B?QUlNMnN6LzY0TEg0ZTJ4ZnlHVlJNdVZFWnVvS1RMMGNIV2lxZjFscWl5a3Bh?=
 =?utf-8?B?M0s3UE1IbzQ0SUxyKzRvWTJhZ1JtcEpTYW8zcEpXQ0liQkk5SENWcHlpNmEr?=
 =?utf-8?B?Q1FqenBBL0o4NzkzcUhmbXNaWFZWK1hsSE5kSFVmZHpORHd1Q0o5Ti93cTlY?=
 =?utf-8?B?QXM2VXBvVG1STkEyNjF6S0l4MjVmNW5SeTNxL2tiVWRYRUl0djk4N0paSXdn?=
 =?utf-8?B?ODVzd1dVcEMvb1I0SHBlbGJEc25hM2F1aDMxWitQN096T1VTdmhLUE5pZlI1?=
 =?utf-8?B?cFpNRnVBVnVyVGV5VW5WT0Q1cFhDREl5VG14ZW1YWXZkMWd5VEMwaTNvN3FM?=
 =?utf-8?B?c2FISWhUNFgrd1YwSEpwOFJsSC9td0E0L2RUbUppMDd6WjJDdDZVbkl5czc4?=
 =?utf-8?B?cmRESGpCd3YzODloTnRnRENKQXU1SkZjTGVMdm9GcjRreU9TNXE0cGJiRzZE?=
 =?utf-8?B?V1lBRnYyNS9DOXBtaVo2NUUvc3F1VlVBQXNqSjFYUitnVS9wdlZyTmFrL1RB?=
 =?utf-8?B?WFo3ZWVidkpSTlNkckoxRjlLVnAyUUZLWUk2Y045bk0ydVphSi9DQUZmYzBF?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab380505-8575-49f9-51b4-08daeda1b305
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 15:46:37.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABZYZLB2O5ErrEisGoLvNlXd/V+3Nk7GmW+27EwV48QzZBZUg+77o+ZHJvrgYlP6jMUXbSntnM1rFF60y9EH62L83IYDbnieE2hk8C2rXEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlcywNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IEZyb206IExlZSBKb25l
cyA8bGVlQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDAzIEphbnVhcnkgMjAyMyAxMjo1Mg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gbWZkOiBBZGQgUlovVjJNIFBXQyBjb3JlIGRyaXZlcg0K
PiANCj4gT24gVHVlLCAwMyBKYW4gMjAyMywgRmFicml6aW8gQ2FzdHJvIHdyb3RlOg0KPiANCj4g
PiBIaSBHZWVydCwNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+ID4gPiBTZW50OiAwMyBKYW51YXJ5IDIwMjMg
MDg6MzcNCj4gPiA+IFRvOiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5l
c2FzLmNvbT4NCj4gPiA+IENjOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5v
cmc+OyBCYXJ0b3N6IEdvbGFzemV3c2tpDQo+ID4gPiA8YnJnbEBiZ2Rldi5wbD47IFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+ID4gPiA8a3J6
eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgU2ViYXN0aWFuIFJlaWNoZWwNCj4gPHNy
ZUBrZXJuZWwub3JnPjsNCj4gPiA+IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0Bn
bGlkZXIuYmU+OyBMZWUgSm9uZXMNCj4gPGxlZUBrZXJuZWwub3JnPjsNCj4gPiA+IGxpbnV4LWdw
aW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IENo
cmlzIFBhdGVyc29uDQo+ID4gPiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgQmlqdSBE
YXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPjsNCj4gbGludXgtDQo+ID4gPiByZW5lc2FzLXNv
Y0B2Z2VyLmtlcm5lbC5vcmc7IExhdXJlbnQgUGluY2hhcnQNCj4gPiA+IDxsYXVyZW50LnBpbmNo
YXJ0QGlkZWFzb25ib2FyZC5jb20+OyBKYWNvcG8gTW9uZGkgPGphY29wb0BqbW9uZGkub3JnPg0K
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIG1mZDogQWRkIFJaL1YyTSBQV0MgY29y
ZSBkcml2ZXINCj4gPiA+DQo+ID4gPiBIaSBGYWJyaXppbywNCj4gPiA+DQo+ID4gPiBPbiBXZWQs
IERlYyAyMSwgMjAyMiBhdCAxMDowOSBQTSBGYWJyaXppbyBDYXN0cm8NCj4gPiA+IDxmYWJyaXpp
by5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gPiBUaGUgRXh0ZXJuYWwgUG93
ZXIgU2VxdWVuY2UgQ29udHJvbGxlciAoUFdDKSBJUCAoZm91bmQgaW4gdGhlDQo+ID4gPiA+IFJa
L1YyTSBTb0MpIGlzIGEgY29udHJvbGxlciBmb3IgZXh0ZXJuYWwgcG93ZXIgc3VwcGxpZXMgKHJl
Z3VsYXRvcnMNCj4gPiA+ID4gYW5kIHBvd2VyIHN3aXRjaGVzKSwgYW5kIGl0IHN1cHBvcnRzIHRo
ZSBmb2xsb3dpbmcgZmVhdHVyZXM6IGl0DQo+ID4gPiA+IGdlbmVyYXRlcyBhIHBvd2VyIG9uL29m
ZiBzZXF1ZW5jZSBmb3IgZXh0ZXJuYWwgcG93ZXIgc3VwcGxpZXMsDQo+ID4gPiA+IGl0IGdlbmVy
YXRlcyBhbiBvbi9vZmYgc2VxdWVuY2UgZm9yIHRoZSBMUEREUjQgY29yZSBwb3dlciBzdXBwbHkN
Cj4gPiA+ID4gKExQVkREKSwgaXQgY29tZXMgd2l0aCBHZW5lcmFsLVB1cnBvc2UgT3V0cHV0cywg
YW5kIGl0IHByb2Nlc3Nlcw0KPiA+ID4gPiBrZXkgaW5wdXQgc2lnbmFscy4NCj4gPiA+DQo+ID4g
PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+ID4gPg0KPiA+ID4gPiBUaGUgUFdDIGlzIGJhc2lj
YWxseSBhIE11bHRpLUZ1bmN0aW9uIERldmljZSAoTUZEKSwgaXRzIHNvZnR3YXJlDQo+ID4gPiA+
IHN1cHBvcnQgY29tZXMgd2l0aCBhIGNvcmUgZHJpdmVyLCBhbmQgc3BlY2lhbGl6ZWQgZHJpdmVy
cyBmb3INCj4gPiA+ID4gaXRzIHNwZWNpZmljIGZlYXR1cmVzLg0KPiA+ID4NCj4gPiA+IEkgaGF2
ZSB0byBhZG1pdCBJJ20gbm90IHN1Y2ggYSBiaWcgZmFuIG9mIE1GRC4gIEluIHRoaXMgZHJpdmVy
LA0KPiA+ID4geW91IGFyZSBub3QgZXZlbiBzaGFyaW5nIHJlc291cmNlcyBpbiB0aGUgTUZEIGNl
bGxzLCBqdXN0IHRoZSBtYXBwZWQNCj4gPiA+IHJlZ2lzdGVyIGJhc2UuICBTbyBJIHRoaW5rIHlv
dSBjYW4gZWFzaWx5IHNhdmUgKzEwMCBMb0MgYW5kIHJlZHVjZQ0KPiA+ID4gbWFpbnRlbmFuY2Ug
c3luY2hyb25pemF0aW9uIG92ZXJoZWFkIGFjcm9zcyBzdWJzeXN0ZW1zIGJ5IGp1c3QgaGF2aW5n
DQo+ID4gPiBhIHNpbmdsZSBub24tTUZEIGRyaXZlciBpbnN0ZWFkLg0KPiA+ID4NCj4gPiA+IERp
ZCB5b3UgcGljayBNRkQgYmVjYXVzZSB0aGUgUFdDIHBvd2Vyb2ZmIGZlYXR1cmUgZGVwZW5kcyBv
biBib2FyZA0KPiA+ID4gd2lyaW5nLCBhbmQgdGh1cyBpcyBvcHRpb25hbD8NCj4gPg0KPiA+IEkg
YW0gbm90IGEgYmlnIGZhbiBvZiBNRkQsIGVpdGhlci4NCj4gDQo+IEludGVyZXN0aW5nLg0KPiAN
Cj4gQ291bGQgeW91IGJvdGggZWxhYm9yYXRlIGZ1cnRoZXIgcGxlYXNlPw0KDQpJIGhhdmUgbm90
aGluZyBhZ2FpbnN0IE1GRCwgaXQncyBqdXN0IHRoYXQsIGFzIEkgYW0gZmluZGluZyBvdXQsIGl0
IGxvb2tzDQpsaWtlIHRoZXJlIGlzIGFsd2F5cyBhIHJlYXNvbiB0byBub3QgZ28gZG93biB0aGF0
IHJvYWQuDQpJIGhhdmUgdHJpZWQgc2ltcGxlLW1mZCAod2hpY2ggSSB0aGluayBpcyBhIGJyaWxs
aWFudCBzb2x1dGlvbiwgZXNwZWNpYWxseQ0Kd2hlbiBjb21iaW5lZCB3aXRoIHN5c2NvbiksIGFu
ZCBpdCBkaWRuJ3QgZmx5LiBXaXRoIHRoaXMgdmVyc2lvbiBJIGhhdmUgdHJpZWQNCmFub3RoZXIg
YXBwcm9hY2ggYmFzZWQgb24gTUZELCBhbmQgaXQncyBub3QgZmx5aW5nLg0KSSdsbCBlbmQgdXAg
d2l0aCBhIHNpbmdsZSBkcml2ZXIgc3VwcG9ydGluZyB0aGUgdmFyaW91cyBmZWF0dXJlcyBvZiB0
aGlzDQpNRkQgZGV2aWNlLCB3aGljaCBpcyBmaW5lLCB5ZXQgdGhlIHNvZnR3YXJlIHdpbGwgaGF2
ZSBub3RoaW5nIHRvIGRvIHdpdGgNCk1GRC4NCg0KPiANCj4gPiBJIHBpY2tlZCBNRkQgYmVjYXVz
ZSB3ZSB3ZXJlIG5vdCAxMDAlIHN1cmUgb2Ygd2hhdCB0aGUgSVAgY291bGQgZG8NCj4gPiB3aGVu
IHdlIHN0YXJ0ZWQgd29ya2luZyBvbiBpdC4NCj4gPiBJIGhhdmUgcmVjZWl2ZWQgbW9yZSBpbmZv
cm1hdGlvbiByZWdhcmRpbmcgdGhlIElQIG5vdyAod2hpY2ggSSBkb24ndA0KPiA+IGhhdmUgdGhl
IGxpYmVydHkgdG8gZGlzY3VzcyksIEkgYW0gc3RpbGwgbm90IDEwMCUgc3VyZSB0aGF0J3MgYWxs
DQo+ID4gb2YgaXQsIGJ1dCBiYXNpY2FsbHkgaXRzIHN1cHBvcnQgbWF5IHJlcXVpcmUgZXhwYW5z
aW9uIGxhdGVyIG9uLg0KPiA+DQo+ID4gSSBsaWtlZCB0aGUgc29sdXRpb24gYmFzZWQgb24gc3lz
Y29uIGFuZCBzaW1wbGUtbWZkIGZvciBzZXZlcmFsIHJlYXNvbnMsDQo+ID4gYnV0IGhhdmluZyBk
cm9wcGVkIHN5c2NvbiBhbmQgc2ltcGxlLW1mZCBkdWUgdG8gaXNzdWVzIHdpdGggdGhlIGR0LQ0K
PiBiaW5kaW5ncw0KPiA+IEkgaGF2ZSBtb3ZlZCBvbiB3aXRoIGEgY29yZSBkcml2ZXIgdG8gaW5z
dGFudGlhdGUgdGhlIHJlcXVpcmVkIFNXDQo+IHN1cHBvcnQuDQo+ID4gV2UgY291bGQgb2YgY291
cnNlIG1vdmUgdG8gYSB1bmlmaWVkIGRyaXZlciBpZiB0aGF0IG1ha2VzIG1vcmUgc2Vuc2U/DQo+
ID4gSWYgd2Ugd2VyZSB0byBtb3ZlIHRvIHVuaWZpZWQgZHJpdmVyLCB1bmRlciB3aGljaCBkaXJl
Y3Rvcnkgd291bGQgeW91DQo+ID4gc3VnZ2VzdCB3ZSBwdXQgaXQ/DQo+IA0KPiBJZiB5b3UgZG8g
bm90IGhhdmUgYW55IHJlc291cmNlcyB0byBzaGFyZSwgeW91IGNhbiBzaW1wbHkgcmVnaXN0ZXIg
ZWFjaA0KPiBvZiB0aGUgZGV2aWNlcyB2aWEgRGV2aWNlIFRyZWUuICBJIGRvIG5vdCBzZWUgYSB2
YWxpZCByZWFzb24gdG8gZm9yY2UgYQ0KPiBwYXJlbnQgLyBjaGlsZCByZWxhdGlvbnNoaXAgZm9y
IHlvdXIgdXNlLWNhc2UuDQoNClRoZXJlIHdvdWxkIHByb2JhYmx5IGJlIG92ZXJsYXBwaW5nIG9u
IHRoZSBzYW1lIG1lbW9yeSByZWdpb24sIHdoaWNoIHdvdWxkDQpsZWFkIHRvIGlvcmVtYXBwaW5n
IHRoZSBzYW1lIHJlZ2lvbiBtdWx0aXBsZSB0aW1lcywgd2hpY2ggaXMgc29tZXRoaW5nDQpJIHdv
dWxkIHByZWZlciB0byBhdm9pZCBpZiBwb3NzaWJsZS4NCg0KPiANCj4gTWFueSBwZW9wbGUgYXR0
ZW1wdCB0byB1c2UgTUZEIGFzIGEgZHVtcGluZyBncm91bmQgLyB3b3JrYXJvdW5kIGZvciBhDQo+
IGJ1bmNoIG9mIHJlYXNvbnMuICBTb21lIHZhbGlkLCBvdGhlcnMgbm90IHNvIG11Y2guDQoNCkFz
IGl0IHR1cm5zIG91dCwgaXQgbG9va3MgbGlrZSBJIGRvbid0IGhhdmUgdmFsaWQgcmVhc29ucyB0
byB1c2UgTUZELA0KdGhlcmVmb3JlIEknbGwgc3dpdGNoIHRvIGEgc2luZ2xlLCBub24gTUZELCBk
cml2ZXIuDQoNClRoYW5rIHlvdSBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGxvb2sgaW50byB0aGlz
IHRob3VnaCEgUmVhbGx5DQphcHByZWNpYXRlZC4NCg0KRmFiDQoNCj4gDQo+IC0tDQo+IExlZSBK
b25lcyBb5p2O55C85pavXQ0K
