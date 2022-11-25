Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04AF638BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKYOIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKYOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:08:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966313D33;
        Fri, 25 Nov 2022 06:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669385282; x=1700921282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gd2+K2EpH1xByC96EZM2Gpsxe3joG2Kqu3hKj4ywxI8=;
  b=YlWilnq6AvUCyEDv0BnZbNRgeUthEhNNHwrgjnYD9odEIS06aVeiVA6F
   J6IzRQ9VzUFzhyXBfWF2lVqBq+lUfxqFMVnY2rWa9um6DCWMdexv5PaQn
   qXLNqib7BLAKG0YyxGHgQSwk8tKF+x+LJ9vlXASSGkdgGt4m9FfncBi4w
   M5JtaiEBbtAXsARDHPhXL54uBzeZSbfIY8Pj/WuA7nFX67zYzwcrlpDZ+
   GsffAVIDZ9/gjCAH0rSj12A0FHGggArKLgv0AYWyAM67DVTW69qfhflW4
   ywdgR4Z3mx9fDzb1SP4Qqd0EQfBrkLZ7ruJ6nsSfoFNM9IA3pScJ00cxj
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="125112786"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 07:08:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 07:08:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 07:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh5ANymhWWZyLblzJkNa49kZp1UXgrt7UQ6hyNi1rRi6lYms0WJgYgK6bKUfxf82RNlFa9FITOENcYP3ai4zS37PDmh1SF2JxVPxlgZwEn0BchzlqYzUjglCx3kbcB/jjKCsy7uVWZym2tLCCq9wYlHLroqOQvAMrwuM7TiJRiGfb471vpL3ZoKYMnqDgeMX6ym0N/xNpQmn5mRfdCSU95QNoF6t13GqJ8sEmiUFvaOzh9zu4Rx7A7M2y7rGfOE0CBmW1kMwvJ5YBNa6ziH72SleVBtYd426DsI8gQuo16zs1dtIOrGki5I7CyXfH0PLrlLGCOKSLk5VHymcJPZTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd2+K2EpH1xByC96EZM2Gpsxe3joG2Kqu3hKj4ywxI8=;
 b=OGDimBfjkKh9FK+Lvc52Fo61DnrDEYvNz1F8pSrmTzBhIKdYzwuzwVrVvS8QcVMMHZwddHUiLpe4KQhVfxT7UEnxrugbh0YSP2CJGJLGrfOGFK/4/2jYPEnIYMXaiKa3l++NJdWtLvdPSyvXnr/xQKMq5grmxwQYNsaO2Q6Juq+MoAhbkJ7Yzrb5akc+Bh1WE2Cr6oKoidjYK9wkzmDABYX6Hv7/puiqF4TiNOo/BpIrTutut0mM45hQesw7MGBbyyzrMt1+9CBE6W5Z6uV6gjT/N2J+ChkUL5Zd+S7T3yDDKkyRv7iNIbFYm+3trv0krQwY43GTJ6CwEA5NW4h5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd2+K2EpH1xByC96EZM2Gpsxe3joG2Kqu3hKj4ywxI8=;
 b=IAq6w1qVyGzHLZfKwfoS+nktnEKdWwL2RywtvY/c4Vch6+1J+I1NDvHEIWwGJDqvSVgjoorS9S8a2Z4PMZWLDg9UzPFWoHAL7gSHl4M60DMGtEDvPapg/F+/ZU9XQ7fuqFK+LcYzxGhPiFE9rO6G+yhPwvFq2M+7ElvnV4HNzwU=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 14:07:59 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::97da:d0be:a66e:eb43]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::97da:d0be:a66e:eb43%6]) with mapi id 15.20.5857.018; Fri, 25 Nov 2022
 14:07:59 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new MICROCHIP_ISC
 driver
Thread-Topic: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new
 MICROCHIP_ISC driver
Thread-Index: AQHZAM7Lsa5d3ya6PUi8JI1LXD3jKa5Pp0GAgAABaICAAAL7gIAAAWIA
Date:   Fri, 25 Nov 2022 14:07:59 +0000
Message-ID: <22d1a45e-9c6a-1de0-4703-877d77f77aa9@microchip.com>
References: <20221125130646.454084-1-eugen.hristev@microchip.com>
 <aa27b328-5167-408c-7731-080aa3a4ebb5@microchip.com>
 <5c93892b-4d04-3b55-72ec-36d3519d543b@microchip.com>
 <da0c818e-5774-8280-8bba-4e7e8e683b05@microchip.com>
In-Reply-To: <da0c818e-5774-8280-8bba-4e7e8e683b05@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5384:EE_|SA0PR11MB4621:EE_
x-ms-office365-filtering-correlation-id: b212ec4e-acc8-4d00-057f-08daceee753d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOZemP7m5Guj5r38vou6Wr6CmLds2H2l9WJ8gnwpl3Gsy/Iz1gLYyJDyGp1nDkFemHHKyEYbAbTkn7OCChdG8zKKGINnF4aIE63PMRdXy8DLiMV9Euw84Suarj/c9xWELv+PpTW5BKcGIYEFI2XfJ1NX1owHF0pf/p1j+P+OySVhVTild/NyAWQRsvntp7mOdnQYG+EaKic0FMv2tXPVhQY265qn7E+dpKpBttseY8OyJaQ1aDI/kTsEWzAtVPj6uyNurtAQTNx7bCQpd6nBMPvRPXH0aBsJTOHAZSzQFfp5Ip1vtYs/A2W1GJx0uL85J8pwFKVUYjSImP4uIwEDSCvXRgFbEfYUUgPV/KwDFuyFp/cOr/aiqZVb5lghxYWPuL+RHd0goApu5Zh3oIffHIX90GlzcRVSLSAU7tRD7QEPnws1aCwajEujDPa/v8Yy7fOvpTqyIsHjZp3kI2BUPY8UYIM6qtiFKbT51N2fp5JSIWo7zuYwbsAegbzL/KfSUZACm5EmKewAuqbUM5EydWCrZhromrpSHmMaiSzFV3WlDAhmx96vNiaqIxE0n3S7mUmHuBkUkvUVbYMwdKiL2qROYWF0ZeHb4EQQ4CrLxakHuf+Z6pzW9+VQVZYCC2rzxNqqM9Xi+eUWY+HZHXafomApYBveLfX6TUns9YtP4eEV0/rlJPTZFtDFY55wyJPvZvSfUVLRjscJe3uDTVa7gXiv1GHmpl79wnFiCW6IpzEup65x8hp4MVWWx8eqr3hAEpwKofy3SKeaLhDtR3eBDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(122000001)(38100700002)(83380400001)(2906002)(31696002)(36756003)(6636002)(37006003)(86362001)(8936002)(6862004)(5660300002)(186003)(26005)(6512007)(2616005)(76116006)(66556008)(66476007)(64756008)(66446008)(478600001)(66946007)(31686004)(41300700001)(54906003)(316002)(4326008)(91956017)(71200400001)(6486002)(8676002)(38070700005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmQzVnkvWEt0bTh4bUJadXVyaFlnNVJlSUQ0YWd0dnRrZENsOVg1T2diSENK?=
 =?utf-8?B?Um9JREw0Ymx3T2poRnpmSTBheEVlcHE0Y0pRQ2VLMS80a2hJYzd5RklUY2ps?=
 =?utf-8?B?S2x4UjBOMTZ6VXljUXl1RE5BVWlGMWUyWFlySERDZEpMbU9CM2FQVlpsSmVr?=
 =?utf-8?B?VCtKYXRlQXQ4VzNYcGV4UHBzc0l0eTdsQWFEZFhIZFlZaUF4a1Q0eUwxdTlU?=
 =?utf-8?B?d05IVWVnTVlIRjQrYjVPV2psSUhUaFFoZi85eXlnMDNDRitCQjI4cFY1aUlw?=
 =?utf-8?B?TTBydk80TXp3SlJBa0hCK1JrcERIU3AybjE5N2tESS8xWm9ncTU1Ni9JMTh0?=
 =?utf-8?B?Y3VyeW5iQVo2eDV5eXZwbm93dUhxTmtCa3AvazVLNkFLWjhOUXMzUEV5NFhr?=
 =?utf-8?B?NzRQZXQ1eUdKUXp4QTdTYnJwekFxbnM5eWNjSDIrSllLUm9DVkhlcDQyT2FG?=
 =?utf-8?B?OUdyS25WVTFFRFBxTS9mdFJHdUZzMXkxc2d3a3hZSkZWTkY2SjNpYUFOdmp5?=
 =?utf-8?B?Tk9WRnNqQnUzdytZU3BVMEZhdjNrZk9HUitpKy9IK1p3SFdsRjVQUWdFQ3h2?=
 =?utf-8?B?Yzlha240dmJJdXNnOFF1ZXRZRTJQL1RlMHpWV05RVy9uRUhDSmczemdtMXhX?=
 =?utf-8?B?dHJFV21Ob1F6Yk1zVU9DWlVsQURUMGJFRFZneGR1aGl6eEhsSng5SjErdDFv?=
 =?utf-8?B?QVBHQmFQMXMweXlETFlsM0Z0cVlib1Jza2VLT0lzN2l0T3RHZ3VPbVBVaE5H?=
 =?utf-8?B?TWg5MDNCRFlUTDIwZnovQUVpdU0rSjJKcE5HZzcxT1pyUmtHRDM3dGo2enhG?=
 =?utf-8?B?dndtcis4NkorVXVtSGVyVit5OStIVVUrS3B6TDdzUUxqK211cU9FSHlXTmV3?=
 =?utf-8?B?UFF4VmhzOFJvNXVoZWhjNisyTHpQZ3VWTG0xVDFiY0NXYk1OUzM4RGRzeXN3?=
 =?utf-8?B?b2tXQjNtVjIvTEpZWllKNldnYmlWaDJ1amlMYzcxeEdpeEFnd3pzOG1Ldm94?=
 =?utf-8?B?UHJWUm1mWmxIQ3ZtWTFyRlRjcDhxd2lvV1U1bmVWQ1RvOFhLaVVuNXhqVFJC?=
 =?utf-8?B?dGtpRDRpaWE2dG11bmxDeW02a24vZ0NJckoxSHZEQ3R6SjYyNFlhS3g4YVIx?=
 =?utf-8?B?NTM1d3NjMEVRNEZTSG5lbXZGTVhTVUg0YlUyeHVncWpjczlWaUQwZFNaUzRY?=
 =?utf-8?B?bU5uRENMc0d2REhlUVF4dldWOEZNbFBNaEh4djBMSEkvUUdnVUZ2ajlMYzFH?=
 =?utf-8?B?cWQ5aldVYzgwQ2R4YnZaUUMyMFVMSEFnajdIVDhwOFVXVG9MdnRxOEVsZVpH?=
 =?utf-8?B?a0hESjFyV1d6RkNnQW1pZnpjVXdLT2RYaUJzd0dsLzRQeVNWTFR2OTBPQlhG?=
 =?utf-8?B?cEwxaVRFbWxJdFEwRWVmbU9tWXNIR2dhaGd2akhFVHhQUkRPaWl1UWtIeURu?=
 =?utf-8?B?TkNSQ2RIbEo3T3o5NFUzRWRVcmxoTlhidk53bUphYnJMU1plQ3lzeEJSbVBZ?=
 =?utf-8?B?MmZJeXQ3N3JMTTV6dHBBR2lIRm1qZC9GTmJ4L1luM0MzVDBuU1I5MytxU0I0?=
 =?utf-8?B?bzdSaVFKREZpTkRqUkFjWVozcUhpS2YvNnk0VWoxK21RbTI1U2ZERlNaNzhT?=
 =?utf-8?B?bEV1dnlyZEEvaTRKNHlmVWJSOEt1SStrb0drRHpGTEViOGxnU3IzdE0wbXdK?=
 =?utf-8?B?WkQ3MDd1c3ZiTmxOekl0ZkFTaWlzLzMvL3pET0hRQVlhTVFuL2xIdENyb2lS?=
 =?utf-8?B?TXlCTVliNm4vVmI4TzN3S3BHN1I2L0ZrMFRoNXRnV2FWMDBhNzhXY1RYOWlF?=
 =?utf-8?B?Tmh1TkUxRm1WZHBjNVFhb0ZvNlhQQ0YrUitheVBxYUlkYkd4NStTNlRHSDFr?=
 =?utf-8?B?U0VzbS9heVUvVzBQMzlVS1Y2cEFkMWNMR3g3dDNHK0pmTklaVVp0Z1U3OXRr?=
 =?utf-8?B?VkFWeVZuNU9sT29nL2tmc3FIV3U1dENsY1ZoRG5JNmxBdW13NENTY2drU3dQ?=
 =?utf-8?B?VldNYmNja1Jiejl0YWN4OXl4Z24vOHZETGs5Qk5sNjJUTldJaXZoOFNvN3pB?=
 =?utf-8?B?c3JtdHpvcENRQTVOaXpjeEFCS3NYc2t5M0lUUmRaTFRZbnNKcm1yS0lveWQz?=
 =?utf-8?Q?sCHwFHNZ7rEFHvP+WHmJACbQl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70182DDDD967E6458CD3A4FD90217633@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b212ec4e-acc8-4d00-057f-08daceee753d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 14:07:59.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLKJUpDM/pbjhujKLToBzIyYq5Cw5dG1IqVTWEYg27ogAO9FVwE8FS5Qw9uuJUUL+pVuLlYPzaiX6xSUkgZpj8cMqze76lWpk/N8FD1KmQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjUvMjIgMTY6MDMsIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPiBPbiAy
NS4xMS4yMDIyIDE1OjUyLCBFdWdlbiBIcmlzdGV2IC0gTTE4MjgyIHdyb3RlOg0KPj4gT24gMTEv
MjUvMjIgMTU6NDcsIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPj4+IE9uIDI1LjEx
LjIwMjIgMTU6MDYsIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+Pj4+IFRoZSBBVE1FTF9JU0MgYW5k
IEFUTUVMX1hJU0MgaGF2ZSBiZWVuIGRlcHJlY2F0ZWQgYW5kIG1vdmVkIHRvIHN0YWdpbmcuDQo+
Pj4+IFVzZSB0aGUgbmV3IE1JQ1JPQ0hJUF9JU0MvTUlDUk9DSElQX1hJU0Mgc3ltYm9scyB3aGlj
aCBhcmUgdGhlDQo+Pj4+IHJlcGxhY2VtZW50IGRyaXZlcnMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+Pg0K
Pj4+IEFwcGxpZWQgdG8gYXQ5MS1kZWZjb25maWcgKGFmdGVyIHJlLXdvcmtlZCBhIGJpdCB0byBr
ZWVwIGVudHJpZXMNCj4+PiBhbHBoYWJldGljYWxseSBzb3J0ZWQpLCB0aGFua3MhDQo+Pg0KPj4g
SSBhZGRlZCB0aGVtIGluIHRoZSBvcmRlciBnaXZlbiBieSBtYWtlIHNhdmVkZWZjb25maWcuIEl0
J3Mgbm90DQo+PiBhbHBoYWJldGljYWwgcmF0aGVyIGdpdmVuIGJ5IHRoZSBvcmRlciBpbiB0aGUg
bWVudWNvbmZpZyBpdCBhcHBlYXJzLg0KPj4gV2hlbiBtb3ZpbmcgZnJvbSBtZWRpYS9wbGF0Zm9y
bS9hdG1lbCB0byBtZWRpYS9wbGF0Zm9ybS9taWNyb2NoaXAgdGhlDQo+PiBvcmRlciBpbiB0aGUg
ZGVmY29uZmlnIGNoYW5nZWQuDQo+PiBJZiB5b3UgcmVvcmRlcmVkIHRoZW0sIG5vdyB0aGVyZSB3
aWxsIGJlIGRpZmZlcmVuY2VzIHZzIG1ha2Ugc2F2ZWRlZmNvbmZpZy4NCj4gDQo+IEhtLCBPSywg
Z29vZCB0byBrbm93LCBJIHRob3VnaCB5b3UgYWRkZWQgdGhlbSB3L28gdGhlIGRyaXZlcnMgaW4g
dHJlZS4NCj4gVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cuIEknbGwgcmV2ZXJ0IG15IGNoYW5n
ZXMuDQoNCllvdSBjYW4gZG91YmxlIGNoZWNrIHRoZSBtYWtlIHNhdmVkZWZjb25maWcsIHRvIG1h
a2Ugc3VyZSBpdCdzIGZpbmUuDQpJIGJhc2VkIHRoZSBwYXRjaGVzIG9uIHRvcCBvZiBsYXRlc3Qg
bWVkaWEgc3RhZ2luZyB0cmVlLCB0byBtYWtlIHN1cmUgDQp0aGUgcmlnaHQgc3ltYm9sIGlzIHNl
bGVjdGVkIGFuZCBJIGRvbid0IGVtYmFycmFzcyBteXNlbGYgd2l0aCBhIHR5cG8NCg0KPiANCj4+
DQo+PiBFdWdlbg0KPj4+DQo+Pj4+IC0tLQ0KPj4+PiBjaGFuZ2VzIGluIHYyOg0KPj4+PiAtIHNw
bGl0IHRoZSBtdWx0aSB2NyBpbnRvIHNlcGFyYXRlIHBhdGNoDQo+Pj4+DQo+Pj4+ICAgIGFyY2gv
YXJtL2NvbmZpZ3Mvc2FtYTVfZGVmY29uZmlnIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9jb25m
aWdzL3NhbWE3X2RlZmNvbmZpZyB8IDIgKy0NCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9jb25maWdzL3NhbWE1X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVm
Y29uZmlnDQo+Pj4+IGluZGV4IDg3N2JiZTdiNzc3ZS4uZjg5ZmQ0ZTBkMTBhIDEwMDY0NA0KPj4+
PiAtLS0gYS9hcmNoL2FybS9jb25maWdzL3NhbWE1X2RlZmNvbmZpZw0KPj4+PiArKysgYi9hcmNo
L2FybS9jb25maWdzL3NhbWE1X2RlZmNvbmZpZw0KPj4+PiBAQCAtMTUwLDggKzE1MCw4IEBAIENP
TkZJR19NRURJQV9QTEFURk9STV9TVVBQT1JUPXkNCj4+Pj4gICAgQ09ORklHX01FRElBX1VTQl9T
VVBQT1JUPXkNCj4+Pj4gICAgQ09ORklHX1VTQl9WSURFT19DTEFTUz1tDQo+Pj4+ICAgIENPTkZJ
R19WNExfUExBVEZPUk1fRFJJVkVSUz15DQo+Pj4+IC1DT05GSUdfVklERU9fQVRNRUxfSVNDPXkN
Cj4+Pj4gICAgQ09ORklHX1ZJREVPX0FUTUVMX0lTST15DQo+Pj4+ICtDT05GSUdfVklERU9fTUlD
Uk9DSElQX0lTQz15DQo+Pj4+ICAgIENPTkZJR19WSURFT19NVDlWMDMyPW0NCj4+Pj4gICAgQ09O
RklHX1ZJREVPX09WMjY0MD1tDQo+Pj4+ICAgIENPTkZJR19WSURFT19PVjU2NDA9bQ0KPj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcgYi9hcmNoL2FybS9j
b25maWdzL3NhbWE3X2RlZmNvbmZpZw0KPj4+PiBpbmRleCA4ZjI4YzlkNDQzZjAuLmNjNDJjZWE3
N2YzOCAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcN
Cj4+Pj4gKysrIGIvYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcNCj4+Pj4gQEAgLTE0
MCw3ICsxNDAsNyBAQCBDT05GSUdfTUVESUFfU1VQUE9SVF9GSUxURVI9eQ0KPj4+PiAgICBDT05G
SUdfTUVESUFfQ0FNRVJBX1NVUFBPUlQ9eQ0KPj4+PiAgICBDT05GSUdfTUVESUFfUExBVEZPUk1f
U1VQUE9SVD15DQo+Pj4+ICAgIENPTkZJR19WNExfUExBVEZPUk1fRFJJVkVSUz15DQo+Pj4+IC1D
T05GSUdfVklERU9fQVRNRUxfWElTQz15DQo+Pj4+ICtDT05GSUdfVklERU9fTUlDUk9DSElQX1hJ
U0M9eQ0KPj4+PiAgICBDT05GSUdfVklERU9fTUlDUk9DSElQX0NTSTJEQz15DQo+Pj4+ICAgIENP
TkZJR19WSURFT19JTVgyMTk9bQ0KPj4+PiAgICBDT05GSUdfVklERU9fSU1YMjc0PW0NCj4+Pg0K
Pj4NCj4gDQoNCg==
