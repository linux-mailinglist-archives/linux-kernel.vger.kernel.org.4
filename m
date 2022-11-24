Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66336637CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKXPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKXPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:24:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D4D7AB08;
        Thu, 24 Nov 2022 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669303479; x=1700839479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O4K+idGwU7Z994w1I3xwU122zXsxK/pqgjf5HEnnYpo=;
  b=FGYoAQCVb1qX72mZ6FimDugrgzbJJSTDOwV7REhCg3Be0BZTbiqJnP+k
   41U15h73wHuyT1E0wGpIWYoOktVdBgUi8xbAGvpPymzfemSFirufQMYRC
   JEouKz4YX8j0V5kpRRXnyXV2z+CNJHHt+bsQkdzd1vEIi+d1B9wqeELk7
   tiF80yowVkg4WX1iLqY2PKWC7HZkBI8pnyiJuVN+cNhvD36sPTrDVz8xp
   0t/O0olSNReMQNdeLQUzY7aE2rne37IsCyLiHWnRfay4QhMLgUd4Vgs4Q
   k5invPN1CxnvjRCF1Ircv2FExpFeZ1RpiexW93DHMx2gSGmuiy9WAnzZo
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="188534396"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Nov 2022 08:24:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 24 Nov 2022 08:24:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 24 Nov 2022 08:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwsWzVLn4mjMLnDc6CsYaIMoJDR3I0krtQgn2f00L4tr/09js5nz+9+FMeCZJCeX2/Pm5Kde8d9FfnW6Su4oxryRrQziJH57qyl0CJ39QV7VMWwZhIzIusoBH8bL9XuMQUoFW0TElvYxGKAG8WGLvEhEYmkNL6pKQO3GeXdXbf/Wac31ZQHS3jAqUMKwAtj86WsFVTjbtMXNoxUtDlj3lF9KmI65OlIsgAnzMcIzc+Mw3PDP6XLnKVwLFh1c5tSDjdiZCEhNp0bnUYVMTRE7WEFsPuNaCFCs6c6HVfP1js4Md6ywo9ehBa41Jx8kRiqZg69CxBr7IuznHHsni0A1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4K+idGwU7Z994w1I3xwU122zXsxK/pqgjf5HEnnYpo=;
 b=HSUw8RWL0FTyyvLmQiAIXTky7oeLXH6GDlBAKtU+FHArgLXwSsUuuVyNik76mFEDMIT/bwPhemBUaINzmxPHAaE1RziI8ktLE+hwaeN2iEA4SJlmMAngnM0E8UJCLEJslgE2TJGsvwrxRf97QHWOKaaRgyLHXGjvTGU7vIjLjfdMkYxl18u4spRf1oNWJouawqgRXFic36Pw2HK2NEcJUvkJkRd2dcPJUq6PQ+hDBRU3CDHeorwPPlFfJRbzzpgXFiKNRlL74++OG55Vmk/WkOLnSt+jXWMzEeoDbWhfpW7uAUZp95VVFx7BUrMUOGMt1Yhlsml5HsgTBP6i7YRsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4K+idGwU7Z994w1I3xwU122zXsxK/pqgjf5HEnnYpo=;
 b=RuT/w0mKbCXGqIAWP81tNBD6MBD8F3CrbOuc371l248mrorsnovC9ERJkkMHskUtA6jRr8pLfYKuNDa6EHDn7CW2QKV7cSFKsjvMotYItsc2oBEvSRLWGmpJNlA2J4m9lItsrj9RfQNu4lk0OFM8HXcr89aifinItQu8WJn63j0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 15:24:31 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Thu, 24 Nov
 2022 15:24:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Topic: [PATCH] ARM: dts: lan966x: Add otp support
Thread-Index: AQHZABjZyvbVFtO2hEWcTe1o6ycoJA==
Date:   Thu, 24 Nov 2022 15:24:31 +0000
Message-ID: <05bf7b50-c86d-57ba-cb74-9902b8466008@microchip.com>
References: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
 <c108d42d-dae8-0852-d89b-160b70b196dc@microchip.com>
 <20221123104550.3hnod4bo4yitisy3@soft-dev3-1>
In-Reply-To: <20221123104550.3hnod4bo4yitisy3@soft-dev3-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM6PR11MB4596:EE_
x-ms-office365-filtering-correlation-id: dff74de4-bf89-41e5-3cf2-08dace2ffc1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ZObu4bBXgVPgJuzreNNBl+BwxcV+Zv+PF8OY56AlSFhiS+vc+KkCqMMXIL0MofGMxuAh5Xq2+9vqgoz7C4Oq1sRJcBC0B0dy90VoXJm2Ckx0j3q2KPabi2Uzph+GmXRQDadwJ8PQRhi9fTwkh54AwjeeOG5iykrcBcsRVt/NPPyabS2OfK4VqxeOIrikHly6/I+hd0Y39PZ1sJZ/wJeWaMmpI2dY+y9YtoEwlc0YHA/c2/Pd47PClUJuoH8bvoWjgQD1xv22tUOkeIm+5oi92enaoNsj30DOXttDKQX/vG0iN48UyTTf7EhGEtx1tUhkNFJ0S79lJ5ffNXffAywUsqY+ncgSElk7VrVFKpW3rqFaEeUZsTXcCKugO6wywQP4JmapNb9SBOUF3rkMXNymwUMt++qs1XUkCbMWFN/Rr9RSLRksYkNmlnMTs/RNyQsb6P8n3qy5Q1aihmVLYaEzcgx04sR+5DKb2FEapD8rYul4BafiwllJbr9DU1ze/jrhscjo/XUk3kwTaJLbYq/qIoJNY/gTHDq5A/NY7qTXPsITTqe0Tb3zCJdwpqh8ebiGIudQm84I0javtuw3X3iQCtnvJaq8PofcX7I3dc4TlMY2SYmd+ftYJ8W1mzaKuhBDTy9Jm0fHEL3dJ/mtN9m+ej/V00jkNIYuXRzyECEyPnvxbzhUXq17deKKvnsdRwlnNQbt/AaFbKzhArLAo+wR+NtEynzTcty+lL6EK0dhmrNd3pgj6yiR0c/vbWFPXkNJ8HUNc8AY8/tTolZ0EaXOJDErYWCbqLJu1EmFPEctTiEguUV3HrZEy+wwkuhdFh9rOdbCGa2kPGMz4PCTt361w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(37006003)(54906003)(122000001)(38100700002)(6636002)(41300700001)(36756003)(66446008)(4326008)(8676002)(64756008)(66556008)(66946007)(8936002)(5660300002)(6862004)(66476007)(91956017)(76116006)(316002)(2616005)(186003)(6512007)(26005)(83380400001)(71200400001)(478600001)(966005)(6486002)(31696002)(86362001)(53546011)(6506007)(38070700005)(107886003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGp3L016YkJmR0tVMmRadTVFZ2MvU1ZzWXQ1V2RWZE8ycElvRXhOaWdvNzQy?=
 =?utf-8?B?V0NldUN4TGhucTUraGl0UU5Jb3NGbXREYmo2Q3FlR0wyeFNub21UU0ZjSlNo?=
 =?utf-8?B?TVk4V1BGNVNZMkZWYnppTU1IZlVkT1Bmd05kTmxYejZqK1VkRW96TDNLVnVa?=
 =?utf-8?B?cmpUelhJenFkYk1NZGJjcWN3azRoODViMXlzRGxEbDBtM0prRDd0bGpHQkw2?=
 =?utf-8?B?aDVUWW1WcUIxbEw1V0ZKYTByVk5YK0hQZzV3aWtNKzc0dFhpK0p2ZGlNdFJl?=
 =?utf-8?B?b3VjSDJIa1RkM1kwbW5ndXcyZEpPakZQRE1HV2hzeDNjUmZsU2lBM29ueHhG?=
 =?utf-8?B?QlVzOXZ4MEJpaHhsTW42NlhpK0J1dTNFbzd2bThPeUYrUkw4bTlad3NMbXd3?=
 =?utf-8?B?Yk8yZVpieHpGbW53VFJ2ZVdXZ1pCUkhMSzZ6SjZUQUN4SmI0VWdNeW43YVZ4?=
 =?utf-8?B?K3J5S3NIeFF4TElPM09CYmYzbmdaNTkrMnFwQ3QzaWdhUThHOE5iOHZINWFN?=
 =?utf-8?B?MnczeFB6ZFdMYWJJdStrVTExOEVxeExIbGZKV0dORUJqbGNEWUo4ZjlURE9n?=
 =?utf-8?B?Q1dKR1owWWtNU1FFUE40RjlQRDAyY2NVMlRhc3VCSlJzL0dTeG9PczRiUWI4?=
 =?utf-8?B?QWd5MVhwWE9STW84U3lRc05uRHVKUjBiRkNqeUZzeXlUNmxTdWRicmlKUmFO?=
 =?utf-8?B?RStsbG82VDlvZW1ZTDV3WGViVXorLzB2aldaTXkvdk1sOGhpdkg0b054RDQ0?=
 =?utf-8?B?a3oyNU11b2NMQ0t6L2hHckZvOGRkUTNCRDhFSnY2SEVuVFVPenc3WDhYVktM?=
 =?utf-8?B?NVBPZHJ4dGdBd2w0NU5kQndXZDdFUG56cDRqbzVUWFRvY1oycFhjdEk1UjFi?=
 =?utf-8?B?RzVRUCsyODdqejVDMy90M3RsNGQ2cGdOcTA0TXRtT0lFS3RjeE5OSitPUENk?=
 =?utf-8?B?d2xZR2tBa3k4UDlJazU5M2NEb3ZVTStOcWR3TnBkS0NjK0VIcDlxUzZXaGJX?=
 =?utf-8?B?Wk1yY3pjcyt0YTBXN25yUHQ5bmpNVUhPU1FWdm1waVBDQlZZajZHdDB6REFB?=
 =?utf-8?B?cDdBVDY5czN3cXpyejdEenBPejVzRG1KSG5jRERlK2RTblBBdE5sbVVUTjBk?=
 =?utf-8?B?ZW9NSjg2VDgyM1BqRHlkc1lwRHY1M01vVmJjNnNJNEd2c1lpYWpjVXgyN3ZE?=
 =?utf-8?B?NkNmZ0NkN1lCQ0hJU2FaanNlckVNVFpHK0ZGY0JUQ01MN1RBVjlYK1JQdDd4?=
 =?utf-8?B?N0ZRVm45bkNNd2VnM0NQYkgvRmxxanFyVzRpY0RUbzdoZ09UNGx1QmNvNUlS?=
 =?utf-8?B?a24vR2FVRkptMjFvV0ZqRnFHM2UyTDEwN0g5QTUrdDFYUkZVUGhyNS9MUitD?=
 =?utf-8?B?bTFrK2YwUEs1bGpMQ0FZMFJvOHJEc3BhWmRrdkNwSTJWNFQxSGFmR3RUS1VI?=
 =?utf-8?B?VjBLdy9pMlBrUVdDVkRTbEJZRzV1OVdaOExjUjRnbUJncDJJeGlGQWs5SElj?=
 =?utf-8?B?TXJ3dmJjSGtmRkQxd3BVSGJ4TXV4NVRZN1JLemNVQTR1Z2F4VGRmbFRoUEpy?=
 =?utf-8?B?S3NyTzV6RVpSN01LbjRNOFVFSUdyT1NhaG4yUkJidlhra2ZOQ2FCSWdEMVhS?=
 =?utf-8?B?NFNrWmZGQ2EyVHE4UmpQQUxHQ2xiSkMvZEJCQ0V3QjBxcEE2R20rTWZJcU5i?=
 =?utf-8?B?SEFHVUt6Wks0TzhLWElGWHk0Rjd6ZVMrU3NKNzBsZjRaZzd3K3VYZjFtdzln?=
 =?utf-8?B?VFNrc244ZVA2ajJGaytGbmRPMkVtYTUzUkp5THNkZXlHR2U3N09SUjlqRVdk?=
 =?utf-8?B?emV6SlNvazhtMmFnSHdyRzZ0Y0ZzbVUwNnNjZi82Z0NPMEREcDVvcU1aQ3R6?=
 =?utf-8?B?MTcrQTUzVG5XdHEwQW1VdWVLMExDcnByanZJR3RnY0VpNVBQcGtheWFVbG5t?=
 =?utf-8?B?Qi80QWpndDJTMVozV09DYmMvTmg2RFRyUjFLdE41b0VUSkgzRTdZTXVVYk9m?=
 =?utf-8?B?aEtycXRncStJQ1hIUGM1em53M2ZIUGRTWitOd21HYUZsRmxvT0NLUTlJcldR?=
 =?utf-8?B?TUVmQWVvVXJmSUkySGlwbVY4bi91OFJodXlvZFdPbzB4TnZ2eW9pM3ZXYkVp?=
 =?utf-8?B?MCs3aE16NFdYcnV1bENtZkREOWdOUlNXNmh3RnJqVGtOWFVmVVFHYTcwdVRY?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <500767861513F042B674961E98FEB94E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff74de4-bf89-41e5-3cf2-08dace2ffc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 15:24:31.4658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqQb9zdu/pPEqq93rInYu4FGsWQ6sMgBQ/sFGmSbBQn9cvhv/Ur9A6oSgrh6sHQdyVJN+vR8QqMN94cIEp6XQxHn/Mk1dcAaU5dypEWXxGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4596
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMTEuMjAyMiAxMjo0NSwgSG9yYXRpdSBWdWx0dXIgLSBNMzE4MzYgd3JvdGU6DQo+IFRo
ZSAxMC8yNi8yMDIyIDA3OjQyLCBDbGF1ZGl1IEJlem5lYSAtIE0xODA2MyB3cm90ZToNCj4gDQo+
IEhpIENsYXVkaXUsDQoNCkhpLCBIb3JhdGl1LA0KDQo+IA0KPiBJIGp1c3Qgd2FudCB0byBsZXQg
eW91IGtub3cgdGhhdCB0aGUgcGF0Y2ggdGhhdCBibG9ja2VkIHRoaXMgcGF0Y2gNCj4gd2FzIGFw
cGxpZWQgYW5kIHJlYWNoZWQgdGhlIGxpbnVzJyB0cmVlIFswXS4NCj4gU2hvdWxkIEkgcmVzZW5k
IHRoaXMgcGF0Y2g/DQoNCk5vIG5lZWQsIEknbGwgcGljayB0aGlzIG9uZSBoZXJlIQ0KDQoNCj4g
DQo+IFswXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xLXJjNi9zb3VyY2Uv
ZHJpdmVycy9udm1lbS9sYW45NjYyLW90cGMuYyNMMjA2DQo+IA0KPj4gSGksIEhvcmF0aXUsDQo+
Pg0KPj4gSSB3aWxsIHBvc3Rwb25lIHRoaXMgdW50aWwgWzFdIG9yIFsyXSBpcyBhcHBsaWVkLg0K
Pj4NCj4+IFRoYW5rIHlvdSwNCj4+IENsYXVkaXUgQmV6bmVhDQo+Pg0KPj4gWzFdDQo+PiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA5MjgxOTUxMTIuNjMwMzUxLTEtaG9yYXRpdS52
dWx0dXJAbWljcm9jaGlwLmNvbS8NCj4+IFsyXQ0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjIxMDI1MDcyMjE3LjM3MTU2MzQtMS1jbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Lw0KPj4NCj4+IE9uIDE2LjA5LjIwMjIgMjI6NDksIEhvcmF0aXUgVnVsdHVyIHdyb3RlOg0KPj4+
IEFkZCBPVFAgKG9uZSB0aW1lIHByb2dyYW1tYWJsZSkgc3VwcG9ydC4NCj4+PiBUaGUgYm90aCBs
YW45NjZ4IFNvY1MgKGxhbjk2NjIgYW5kIGxhbjk2NjgpIGhhdmUgdGhlIHNhbWUgT1RQIElQLg0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1p
Y3JvY2hpcC5jb20+DQo+Pj4gLS0tDQo+Pj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRz
aSB8IDUgKysrKysNCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPj4+IGluZGV4IDIzNjY1YTA0Mjk5MDYuLjc4NGNhYmEz
Njk0ODUgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+
Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+Pj4gQEAgLTE2Myw2ICsx
NjMsMTEgQEAgcG9ydDc6IHBvcnRANyB7DQo+Pj4gIAkJCX07DQo+Pj4gIAkJfTsNCj4+PiAgDQo+
Pj4gKwkJb3RwOiBvdHBAZTAwMjEwMDAgew0KPj4+ICsJCQljb21wYXRpYmxlID0gIm1pY3JvY2hp
cCxsYW45NjY4LW90cGMiLCAibWljcm9jaGlwLGxhbjk2NjItb3RwYyI7DQo+Pj4gKwkJCXJlZyA9
IDwweGUwMDIxMDAwIDB4MzAwPjsNCj4+PiArCQl9Ow0KPj4+ICsNCj4+PiAgCQlmbHgwOiBmbGV4
Y29tQGUwMDQwMDAwIHsNCj4+PiAgCQkJY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZsZXhj
b20iOw0KPj4+ICAJCQlyZWcgPSA8MHhlMDA0MDAwMCAweDEwMD47DQo+Pg0KPiANCg0K
