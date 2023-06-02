Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E110872013D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjFBMNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjFBMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:13:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2095.outbound.protection.outlook.com [40.107.7.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D71B6;
        Fri,  2 Jun 2023 05:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcmnzPWGjzhbLsEVp8i3rX1/2m6Da44u3REsAc71al1wb3qpiU1jQnbESyDb6WOxuyVSkHAs1jfEm1hMlCAMX4QvRAcBK215OiB/KEjZlJx6iwYPZJrucoe8sPUnLmMDT0XBO2qLhdTFBs/YL4okZ3UZbDDlbUBsgPsRE9bB3M2Zt++KBJgSdiVXmRCzwo3Nr6NWGzA7qf3KIs3KtsNXr44+EWCpI32QVyjvp7n9o+goJ/ABamlD1d+fMpBa97/NJHGCoNUlP5iGYtRCUxiETG5tdW5KydjJ04KOAwtuV7nNbeLcDy5JWjpur8lIqo1Zga6+KTbfhnmg4FxEs+oxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8SJmmKuIrCQOucgtBt2G2h1LQlHyJIlZBcpCdUswcI=;
 b=IDtd5uxP6RISQqhoBpQw8NsKGg7Klq0T7fMKvC3vOEYMDC0NciCQtINWJzkFntEKjjLm6R2Pkt+dY58FodlB6KX5lbo4+2NouYSj69LtQ++9yw7/iqO/G3P2tM1NIHpqWfNCKERieqBdiShuhY8v3QgYmesiBSmIuwa038c+5QZs04A8qO10yDj3oN9YkPtZL48oOpNU36dv8ccIkJjSTncrD03vVzymWg7T3yHcUc/+50/sZfOGab8CBaIluk/h0qNW5Zhg2nOy3cj4Qkl2IijWhMzKxGkNCUoI5IZ8RPBzGSp+4v5gY/ri2nsyLagw/0XpyViJu6CuXPjI9Kysnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8SJmmKuIrCQOucgtBt2G2h1LQlHyJIlZBcpCdUswcI=;
 b=K5C4mLTElpTg0hQgyS0aTVjNde9CMaM8Wuj37D8BdyQSVcqIv6CIrGvTS6iUGUehjIf39J82Ri/OiRtRaKo5K4JUcG8zEqwGFSpXzSWkXUi2ZFhtG7VhMuMGR3B3lmsaMeclh7Uf2s0qmSbpOcOP++HgBFSRZqhSohWEUO1y+5Q=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM0PR03MB6241.eurprd03.prod.outlook.com (2603:10a6:20b:156::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 12:12:53 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 12:12:52 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Mark Brown <broonie@kernel.org>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role
 flag
Thread-Topic: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role
 flag
Thread-Index: AQHZlTEkbjROoMVD8k+Rhl00q7eUT693ZJ6AgAAIGwA=
Date:   Fri, 2 Jun 2023 12:12:52 +0000
Message-ID: <7csvw25vhyal2jsznb3jykuijxqpk7bzyguxvl7cyitosgga2w@pxmkce22cm3d>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-2-alvin@pqrs.dk>
 <3fe93662-82b0-4834-b6c3-473669c66210@sirena.org.uk>
In-Reply-To: <3fe93662-82b0-4834-b6c3-473669c66210@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AM0PR03MB6241:EE_
x-ms-office365-filtering-correlation-id: 11cbf7d0-358c-449e-450b-08db6362b0d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kkQNaXk/p4DLQ3BIzcEuzSdgJA76uBxFU5D3t946AnoM/W7CqeRfhU1zcZV3JhaW25VAsbAeBr1PTjwaUB4XpH/+x6W+aDKlscoXMpCBbCkMzRxZpV4V2mcSdCFKiYC0BiGWdxo4UXotrw1ARU92PwJLI8MdW0xaG4NeWeC1+1/I3K2gKVUktt1p8fDZl5egxmV0wkvFC2JmLzuQHp/c7CXoCplpHigRHuj9SjSNezSZDyHzHWc6bXBQcJ+J38VF9ewYOyC5HeyQiJuXBGF/BR1Kfz5UmMfhJN3wyV0fssMyIvF4q/1jShnC+ngoK5hpt+UTqBWdmv0vm7Hi2H98rIrMpj05Fhoyk+mxfyaOMkSk9qpErEzspaGdZpU7Uksavnu+3DymukSXaR5YFrYhJILfqRZh7fr1fIOooN6kHqv6+8Xml+FMZoc+G8hlW3wpJdltsKALGB/TzDHpHwVDcrUSohY1TO0MNLx8/6T+ZeQEyss9SaTexqw2N8CZDHiQFyM2ajrLUtdNRrxmehatqiIuyIv/8JAXI5kOe3K0dZgt0HFWdROZ57N2ynXcvmI9I4Rk9LZiAMjPj9ihzJ3BTwFBakRJPinSD5Na5+0//aNX/EBAf+zuYnjCu542yQ6q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(451199021)(6506007)(6512007)(9686003)(26005)(186003)(6486002)(71200400001)(66574015)(41300700001)(83380400001)(8676002)(316002)(7416002)(5660300002)(8936002)(2906002)(478600001)(54906003)(91956017)(64756008)(66476007)(66446008)(66946007)(6916009)(66556008)(76116006)(85202003)(86362001)(85182001)(4326008)(38070700005)(33716001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFI3VnN5V1VQUG1pbUZwT0Mwd3ltMklTMDFZeS9RL0ZUT2JJNVducXMrSDZW?=
 =?utf-8?B?UHNMUC9QMjgyK2hJNmFraDBaV3N5QUREQkJIWi8zaXlpOVNYRkh0bFFWZ205?=
 =?utf-8?B?dnJrL2ZYR3ZhQTlSbXNWMnY0b2wzdytMRmgyaURnWVdwNHZXZi85aXNzaHF6?=
 =?utf-8?B?MmJzRXpCLzB2L05wZmNVSkVlQ3pEZ2tVemFHKytVaXdNK3hwODJzSWs3Q1B5?=
 =?utf-8?B?aFk0VmxzTEFwdGtQM1JEelo2RGtzWnNId1ZYM1ZkNlQzMzBzblRySWRUdnNt?=
 =?utf-8?B?azJUZWpuRk1rYlVURy9tazAzMjhpc0ZzNWFaOXBseDV2eFNYL2cxdHJhTjBP?=
 =?utf-8?B?dXFDZTQ5d09EcW1kZlJWazgzVTNSZlBqUldiL04rK3RJTGxmK1pKc0Z3NUp6?=
 =?utf-8?B?amlFalJEWlYvSUMwd0VaOGM0Tjk3WGxDaHZaK1ZpS1VLRCs1bFFYYzRYTGFY?=
 =?utf-8?B?NXRNN0pXRmc3UkR2UFh0b0FtT3ZCU0ZBVWNEdW9QSjJLa3JlVzVZdzlDLzFu?=
 =?utf-8?B?UnlZUDltTmltcWFzYks5OFlScUxHcEJMYlE4b3FWK05USk1jMnhqYmFacGlH?=
 =?utf-8?B?UjdncUpFZWc2Y1lVR1FHK1QzSTNEUVRMeFpmUHpWaWk4YjRSTGlVYVRxanNH?=
 =?utf-8?B?a3IzaW1kUS9NaDhSbmlwQ2FwMnUvRGtBMkZNWU15SExGd2kvUkNPWTBhRllF?=
 =?utf-8?B?aFZHNFBKd01Ncnl5dytmWEg4WldDNUs3LzY2Wm1mRmxTMDFhSlkzbHRkL3ox?=
 =?utf-8?B?a2dzUklmcEs3VFZLVXBFYnNWUXc1T3NDdVNTTGZWOVpsMmI1bWsrenRMc1Z6?=
 =?utf-8?B?VWhvNVBtNHo4ZEZ4Qit6Nm5jQ0tLcUpOdHBtZ0ZOUVBDa0p5SjF5VDJ2TFJS?=
 =?utf-8?B?dXZieXg0b1ljMnFKWDZVV1NsSUFmZWxscHZtTjNLaStoWGxGQXh4QkdkV2pP?=
 =?utf-8?B?T3c5akhvTksyMERrT3N3ZG5WMDVsR2hndWFrSHRPNkJaWnAycXE0UnhqS0VJ?=
 =?utf-8?B?eEhBaG1sZWtFRzBvVmVQMHJKSmRjS1JYaVQ3eUd2MDJ0cC83T2svaGxJYzgy?=
 =?utf-8?B?ejRDRXRTNlRiTDQ5VmNtRWY5T2pHc1ByNjQrWGJTckVuZnN2aUsveHVaalZU?=
 =?utf-8?B?QWp1K1c3SGNlUzdUUDFIbTJpMjVIWE1ZU2Fyalh5ai9DWW9EbXdOcStWaU13?=
 =?utf-8?B?UmhGVmgwMnhNN0pkdXhxa3BZTUd1TEFDRlJKZGZLZDFwbnhBLzdtV2M3YnpV?=
 =?utf-8?B?cURKWnhFZEtpVW41SVo3MGhpc3BHUmlXUTdNSmhjaDJBV0JIOU1pZTg5UXVy?=
 =?utf-8?B?MTdZQThSbVZ0eHNvem9rOUN4YVlwZTAxcjZIQ0gwVVgwcUhncEFneWFuUlFE?=
 =?utf-8?B?akJNS3VIZXNWVHlJTFd1QXZSZXRZZklSVWc3N2huZTE1NTczZExTSi85YmFV?=
 =?utf-8?B?dk5NT09WOW5aTHMycml3VVQ1SVpsZnhNRVkwcHYzMkh0RFlNdzJ0cjJKMmpC?=
 =?utf-8?B?K2I4Y2FPaEFpa2xkK0ozMUJRdGpaendyVzVSZ3BXRHJ0ajRxdWxHMVRnV2d4?=
 =?utf-8?B?aCsyNEZNMnhTcnl3b2ZjSUZBbEIzUWRlejFYMzg0VzYrQjl1YnJXTW4vNis5?=
 =?utf-8?B?TnFrVEd3NHN2OFR1Rm5hbmg1MGVvZCtLbmxCd0pPRmNwNEptOXY2ZTE0dnQ1?=
 =?utf-8?B?eTNoeEZSYU1WYzIvRXVUZUNRa1k5b3R2a1J0SEtzY0w0VXR5V1pmU09salpz?=
 =?utf-8?B?SGp1WUZLRm9CcUdrQWxqR2RhdUliQzMrZHozcm1pc2VzZ3VPODBWRy83cmsy?=
 =?utf-8?B?cHpHSWR2NU1OVVArTkpnK0dFYlI5a2JhT0FOSzBWbHh2WGdJeDBobWc4VzU5?=
 =?utf-8?B?bHhCaDZ1VjdlbGUrc2xJd3I2OGRYbGhtRVRQdDV6WHZ0V0pvekpQS1BRZERC?=
 =?utf-8?B?QitKNmgyaEJ4VFZPcE8vUEEycTY4S0ZwTU5Sb1NwREJCa1dGdlZVNmYvclFu?=
 =?utf-8?B?K1JLeUpkRDNpZHBQaS93TTFPQlIzbnJaSlpVQmlHY1NuWTM3Z2hJZGRsTi9t?=
 =?utf-8?B?VWlMRHNqNkVKNjVzbW8vWHNSRXplVUtWVUlXMS9OL3MrWnQ3MWtwMjVmV0k1?=
 =?utf-8?Q?dxufEvvaVBrGEkE1UKtc8esVo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB5985448196F14FB0E98E8CC16C3113@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cbf7d0-358c-449e-450b-08db6362b0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 12:12:52.6974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGqPEqpAM9uNfJo5pXEO9mXYPJwWyKyDcK6LsJg7JCmqhMDJZFuMpl/wUln7O7evjBKzJrZv65NJj1DyCkxvyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KT24gRnJpLCBKdW4gMDIsIDIwMjMgYXQgMTI6NDM6NTFQTSArMDEwMCwgTWFy
ayBCcm93biB3cm90ZToNCj4gT24gRnJpLCBKdW4gMDIsIDIwMjMgYXQgMTE6MDM6MThBTSArMDIw
MCwgQWx2aW4gxaBpcHJhZ2Egd3JvdGU6DQo+ID4gRnJvbTogQWx2aW4gxaBpcHJhZ2EgPGFsc2lA
YmFuZy1vbHVmc2VuLmRrPg0KPiA+IA0KPiA+IFRoZSBuZXcgZmxhZyBzcGVjaWZpZXMgdGhhdCBi
b3RoIGVuZHMgb2YgdGhlIGRhaS1saW5rIGhhdmUgdGhlIHNhbWUNCj4gPiBjbG9jayBjb25zdW1l
ci9wcm92aWRlciByb2xlLiBUaGlzIHNob3VsZCBiZSB1c2VkIHRvIGRlc2NyaWJlIGhhcmR3YXJl
DQo+ID4gd2hlcmUgZS5nLiB0aGUgQ1BVIGFuZCBjb2RlYyBib3RoIHJlY2VpdmUgdGhlaXIgYml0
LSBhbmQgZnJhbWUtY2xvY2tzDQo+ID4gZnJvbSBhbiBleHRlcm5hbCBzb3VyY2UuDQo+IA0KPiBX
aHkgd291bGQgd2UgaGF2ZSBhIHByb3BlcnR5IGZvciB0aGlzIGFuZCBub3QganVzdCBkZXNjcmli
ZSB3aGF0ZXZlciB0aGUNCj4gYWN0dWFsIGNsb2NraW5nIGFycmFuZ2VtZW50IGlzPw0KDQpTdXJl
IC0gbGV0IG1lIGp1c3QgZWxhYm9yYXRlIG9uIG15IHRoaW5raW5nIGFuZCBtYXliZSB5b3UgY2Fu
IGhlbHAgbWUgd2l0aCBhDQpiZXR0ZXIgYXBwcm9hY2g6DQoNClRoZSBjbG9ja2luZyBhcnJhbmdl
bWVudCBpcyBlbmNvZGVkIGluIHRoZSBkYWlfZm10IGZpZWxkIG9mIHNuZF9zb2NfZGFpX2xpbmss
DQpidXQgdGhpcyBpcyBhIHNpbmdsZSB2YWx1ZSB0aGF0IGRlc2NyaWJlcyB0aGUgZm9ybWF0IG9u
IGJvdGggZW5kcy4gVGhlIGN1cnJlbnQNCmJlaGF2aW91ciBvZiBBU29DIGlzIHRvIGZsaXAgdGhl
IGNsb2NrIHJvbGVzIGVuY29kZWQgaW4gZGFpX2ZtdCB3aGVuIGFwcGx5aW5nIGl0DQp0byB0aGUg
Q1BVIHNpZGUgb2YgdGhlIGxpbmsuDQoNCkxvb2tpbmcgZnJvbSBhIERUIHBlcnNwZWN0aXZlLCBp
ZiBJIGRvIG5vdCBzcGVjaWZ5IGUuZy4gYml0Y2xvY2stbWFzdGVyIG9uDQplaXRoZXIgc2lkZSBv
ZiB0aGUgbGluaywgdGhlbiB0aGUgZGFpX2ZtdCB3aWxsIGRlc2NyaWJlIHRoZSBjb2RlYyBhcyBh
IGJpdGNsb2NrDQpjb25zdW1lciBhbmQgKGFmdGVyIGZsaXBwaW5nKSB0aGUgQ1BVIGFzIGEgcHJv
dmlkZXIuIFRoYXQncyB0aGUgZGVmYXVsdA0KaW1wbGljYXRpb24gb2YgdGhlIERUIGJpbmRpbmdz
IGFuZCBJIGNhbid0IGJyZWFrIGNvbXBhdGliaWxpdHkgdGhlcmUuDQoNClRoZSBvdGhlciBpc3N1
ZSBpcyB0aGF0IGZvciB0aGUgc2ltcGxlLWNhcmQgdGhlIERBSSBmb3JtYXQgaXMgb25seSBwYXJz
ZWQgaW4gb25lDQpwbGFjZSBhbmQgYXBwbGllZCB0byB0aGUgd2hvbGUgbGluay4gQXJlIHlvdSBw
cm9wb3NpbmcgdGhhdCBpdCBiZSBtb2RpZmllZCB0bw0KZXhwbGljaXRseSB0cnkgYW5kIHBhcnNl
IGJvdGggZW5kcyBpbiBvcmRlciB0byBkZXRlcm1pbmUgaWYgYm90aCBzaWRlcyB3YW50IHRvDQpi
ZSBjbG9jayBjb25zdW1lcnM/IEluIHRoYXQgY2FzZSBJJ2QgaGF2ZSB0byBhbHNvIGludHJvZHVj
ZSBiaXRjbG9jay1jb25zdW1lcg0KYW5kIGZyYW1lY2xvY2stY29uc3VtZXIgcHJvcGVydGllcyB0
byBtaXJyb3IgdGhlIGV4aXN0aW5nIGJpdGNsb2NrLW1hc3RlciBhbmQNCmZyYW1lY2xvY2stbWFz
dGVyIHByb3BlcnRpZXMsIGFzIGFuIGV4cGxpY2l0IGFic2VuY2Ugb2YgdGhlICotbWFzdGVyIHBy
b3BlcnR5IG9uDQpib3RoIHNpZGVzIHdvdWxkIGhhdmUgdG8gZGVmYXVsdCB0byB0aGUgb3JpZ2lu
YWwgQVNvQyBiZWhhdmlvdXIgZGVzY3JpYmVkIGFib3ZlLg0KDQpPciBkaWQgeW91IGhhdmUgc29t
ZXRoaW5nIGVsc2UgaW4gbWluZD8NCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KS2luZCBy
ZWdhcmRzLA0KQWx2aW4=
