Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7469AAB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBQLrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBQLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:47:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DB966CF3;
        Fri, 17 Feb 2023 03:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676634439; x=1708170439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gPMrzQ0CoKeGTUCMKD7QyHomwfi33dHxpCP1h0SEIqo=;
  b=PG7pZeNwkp+LFjkFZeljt14fCOVC4N/6xohSb8+6Bq3JOogE63GWWiMm
   WDouibGkhT+sJvGBk0aIGnin3u9yGJGi9L7JJTrdgiT2afXnuXfSPjuw4
   xpKvVCCF9piTwGlvXkDDRrFZtdrsxja77yLNq5cr5dtm0++mBqPISKkxz
   z8JFTs6MqufbA8jYWGnxpaZYu4mSX76Aynu4mVr/RIG7mp4VprPK7TQYC
   g+S8njKu3LHqE1uwL3ia98Gio99K6gcJv815YFmrpRvgoh4NJVa9frDA/
   9mR6x3ywhqpUVlIq/bCd9tQzjxh/m1CVx2x2gz+SiDxAUtr9KSuaH3XHO
   A==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="197488558"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 04:47:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 04:47:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 04:47:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrZC6Jdm+QLOky0KDicDABMM1VJaU57l8u0jDFEPS4bwz0BwRZA9QDAPekxUGNi3QebvoG/glCGvk4wa7mOah5Lgm9/fEqkDTCP18llLCEwhdx7uqxnJFG9EzH5s1U6SfJFHMoihLL7Ss1/DZrlS44w+NrdzKuIRZ3yMhWma96hRkI84F4C4vw9MzrMCAmf/akJuz7QS5nKJCaHPniEnMq28VFrraqYyibPYH09au4C031htgJf3KfUypgf8QCHTdStwM6DYPcj0OySCcPXTLj87B/zRwX0UjInG8srKJ6h5zoI0AkxydK1jkKA/QZTz9uDnZ4vyLNeZKsGSdbxZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPMrzQ0CoKeGTUCMKD7QyHomwfi33dHxpCP1h0SEIqo=;
 b=Wb7AyyFxyj+caDPDlDB/Xa/4OgLbSdsUdTxvqfP6FlvXgzZJpKYtvx7P2gp3H45uZjHJthlxhPaxZTBcC33mBK4wBcRVvonj552AjVPevrtLugOyI9CmGEQD6ZP1qVyOf0nRExcwl3pRyDgcD1Tl+e7/4H78i9998pC+ImoiTcqxumywLj3u53WirseTs9+79Ykf+j+e0Y+6rfFwGkJN+Vzm54uKKFlPfocW+G5KQ6KIF0wnEspTZYF7Xq6vEU9o3Unp3VeueNaYzLG/Xtwz08WtqRCC4i4E8xZtbUMPNAreZPz2bM1FhWa2et1dXPPlS4mSlT3QXIBPR+n4dJ0P5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPMrzQ0CoKeGTUCMKD7QyHomwfi33dHxpCP1h0SEIqo=;
 b=A0n+yuBRmF+Q9dPAvDGHV2UfkXl5lRNYEeAXX8SpSxeG2d8om4XfnmnMTL1j4A6VjlGK8DUJnbGOzc2YfrIsQR9VlRntwpeG8qB9UpFJFszCc45ahKFH+olKbob/MNcJRNhcpTqLI+ODtKdpBFafN7q41PhLICELIh3WGfojK1Q=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 11:47:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 11:47:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <broonie@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linus.walleij@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] pinctrl: at91: Remove pioc_index from struct
 at91_gpio_chip
Thread-Topic: [PATCH 2/2] pinctrl: at91: Remove pioc_index from struct
 at91_gpio_chip
Thread-Index: AQHZQsWU4BuE2Uclhk2RmJeYCj/ZHg==
Date:   Fri, 17 Feb 2023 11:47:14 +0000
Message-ID: <1df2c180-4ab6-b0c4-0e06-c56e3137ae40@microchip.com>
References: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
 <20230216-gpio-at91-immutable-v1-2-44f52f148ab9@kernel.org>
In-Reply-To: <20230216-gpio-at91-immutable-v1-2-44f52f148ab9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BY1PR11MB8032:EE_
x-ms-office365-filtering-correlation-id: 832e81e7-6c82-4d3f-a86d-08db10dcb6d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5xH8sSJ3uDihBHW9SLZui3xAaE4cch9js+Ke6hQKPylKrpNP25wb54xS9I8sI6HDFLUl3LoIpq43UEBVlEyotk1CPbriL2p02dEMSFwMUCzb5ZJHgAqR5cSvf9cyQpbwFvmCgPmdS0PMaMia3ETRWQxDbDRl+uoVbPtBjCjqNCVVho0e08oo/XeJtbCEFmYsIem2GJQyA3SSNvJi922h7gUT2XEIZGIsF0NJcmN1XZGgscnnvkO6tHHZzS3NNacXefEZLHLQGGtB21Rs/wE6CKiX4GPi68jsuO8tFJ/wx3u20g/dSMxTbI1yw7gd9PTH/sOF62xZs3rdjDYD6YUkcqcZObGig4iXnLyWpjM2pbUAqgaxuK5tT6uLGlGOid50satMcPj/cJUvTl4dV0bbtvIu1QuL4xicvxAHnhKT/FihsANKEJR0v7on4tR/P7Xl0gGatiIlldEB1Rd4fELviAMzmho6jh5ZOmQ9cWGZZ+gN917gNb+VX6kuMJ+iX74FsMMnMrTmjUqS5c+S/xsDjcl4cHCIUM81kTn5LsJZrDDckePRfAdSKD4dbPRrrOgXKO85HsFYC2Urmo+evMKC3e60EZb6v3FDEZnOSyW8msMe2MM01nXDXP10T54RztOcv+93IF86W6GYo6//LjevcQ/4NmiJ0qekFpSU4g3Q2FtGd09ICsZAnrAmLgqE5eLzDdM3fywrF0WsXmMSDD+Xaw2ACB/ph2+WTprVfByGyBoAyQRJiu5Z7mKCtxdOkQaTnJl02gbhLuYAIvgypkxoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199018)(66476007)(91956017)(64756008)(38070700005)(66556008)(66446008)(31686004)(83380400001)(8676002)(4326008)(76116006)(41300700001)(38100700002)(316002)(8936002)(66946007)(54906003)(6486002)(110136005)(5660300002)(2616005)(122000001)(26005)(86362001)(31696002)(186003)(36756003)(2906002)(71200400001)(6512007)(478600001)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mmx3eGdGOUVybVc0bmFtZTUxWEZyV0s3emxzR00xanpBSmZXMGZtaVBmUklx?=
 =?utf-8?B?NkVYN05kMXRBc2NSd25PbjAyWDhOZVNEeGtlSU9wYStiUTdFcG9hMFRLVHR5?=
 =?utf-8?B?eG9VR2NIT2wxWVVvY2Y2SkNOV09JY0l5MW5YU2VZSHh0TWVQdmF3VTNlS2Jy?=
 =?utf-8?B?RjNxWHNlMmg5dWZCanI1SXZxSjdDdllOUGdZQ3hETHpRcXRiU0gxdkUzeU9y?=
 =?utf-8?B?MWFlekhNMlFPSzJpOEFuM21NbFhVbmwwZGt5YjZzeFhSeHdhYi9ZTnFIUU9C?=
 =?utf-8?B?VnUvQ1Job3hQS2FNN1lIWWxZZ2kxQnhBdjM3TUJoV2Zia1dFQXRGYTNiRG8z?=
 =?utf-8?B?bHQvL2lxWmlsUGViQVJDNGtFSVRESVhTcVFQVkwwWG5XSDQxWXc4WE1PUktB?=
 =?utf-8?B?aFh2WGM4bHVTa2FLMjgvNjIxRnZTbXduR0g5ZW1tTy96VTBRTGRSRWkrZ0Zh?=
 =?utf-8?B?RDhQckdzdjZTeWtoS25aRnhHL3pRMkZoVGNiMnhYOG12ZVN0N2YzOVhUYVly?=
 =?utf-8?B?ajMzQW1hK2szTjByUkV0MGpURFFRdDgrcHBOYTUzTitNdkcwNkh1VEFUZmU0?=
 =?utf-8?B?Q1pBUHhOd1VnNllLekVvRGdnT05FUit6ZjlESGtCMDBSRFo4bW9QWk8waEZM?=
 =?utf-8?B?R1RiTjZLQ1Rzdkl4dHY2N0hwS3Uyb3ZQbVc4azdEaW1iaUI4c3h5OXpTOXI1?=
 =?utf-8?B?ZGUveTQyUWNJajJwQ1dsSWZXNWQyVks2Nnk2My9vcXpVYnN5VTdiSFZ4Mm9m?=
 =?utf-8?B?Y2ZWbFpxRk5GUGJVS3BVVVR2OW9sSUJzODZibGZ0RnBBdjk3b2oyWkZXUVlF?=
 =?utf-8?B?S2Fsb295Zmp2eHg1anlqcXpWSG1nZzRaM2g3TGJpYWExdllYdjRFN1BHNlF0?=
 =?utf-8?B?WE8wRWsyR09DbWRhZlR6Y2pTWXBTWjNqUFpQYVJrVXFkWHdVRGU4YU5yNnV5?=
 =?utf-8?B?QTN1YnlNc215dFRjYzJ0S3pQMGFGS1FCTE1rR2dhV0VJWHBDRFJNQ3l3ZlZT?=
 =?utf-8?B?N2ZIdU90OUt0b0Qyd0pCenkvSkxvUkRzQTBtTnlMMit1TUZva0pOa0F3OWw1?=
 =?utf-8?B?ajQ4Wi9jeVBHWjFnVm5oTVlWbnNSOFJaM1gvRi92eWhHR3dGTGpNdUxDNzJW?=
 =?utf-8?B?em1YTThuVjdVQ05UaklERTFnS1EybXFCdE1yam5Nc1drRERyTTdkZ3F6NnVp?=
 =?utf-8?B?Y3Nwcm90Y0NNeEZvbkd6eGxhUjlRRDRLbXBUQW82VElNaXRpeXhhYitzTnoz?=
 =?utf-8?B?RmlIKzdsRkRrWDJZOFdkaW9lb24vYXJpa1JLYm5TUWpCM3duMCtUN2o1Ym56?=
 =?utf-8?B?QUxrMWNMMlhFMUF6MlZhdUE4YStNL3NGcWhhcjVGREc0aUVFZTB6MU5VeFYv?=
 =?utf-8?B?ZU40WmdrY3pPL0pYanUyajAzK09Bc2NPdWdkOVhHUkp5WHBKeUk3SXJvT0FD?=
 =?utf-8?B?cUNqdnFaVnlobitWbmtScENsTHpMZ3dJNEs5VG9wcjhWVUxGZEw3OG1pZTgw?=
 =?utf-8?B?bEVTdVB0dVAzQkQ3SEgyZm1YRkVNbGVxdk9zNE9mSXRHc3hUb0tsZkdEaFBa?=
 =?utf-8?B?dmtXL2d4RG56OUViaHhjSmdxcElqR0pKWWZxbTg1bFVzMDdSUmFsU3FWNmFC?=
 =?utf-8?B?dUR0UFl1ZkNnS1hOZS9MUC9xbnNycmtNSXRheDBxZ1FUZnFReXFpaFRVeFEz?=
 =?utf-8?B?Q3BWaWNpQU9kcXM4alZFTk9BTStCZUFGdWJpUUlaMW96L0pULzArMUt4QUFh?=
 =?utf-8?B?WHIwSzE3cDBtM3B0dHBweVV1OEhFQ1NnN0FLQTZ5bGtoc1p1KzQyY3ZLQ3RN?=
 =?utf-8?B?N2JUL1lSbHYwdStueEtBd3MrL0NHeEFrQ2krVGI0K3dscTBBZHRuNzNvcFQ1?=
 =?utf-8?B?K3RFaGVjTENXUWx4SjF5Y2d6SXVTcnd0MFV4bWI4QlQxd3cwa0I5cTFUNXl1?=
 =?utf-8?B?anJ3UzNmK2JmUU1SNHN5L0N3Q2tEd0FOa2Y4WlFMRy9LNkM3T0R6QVJ6eUpj?=
 =?utf-8?B?SDZrR2lTNU9kVW50aHRQTktiZXAzN0VYRlVudEI1NDhLNGNEc2lVWnJEUkZy?=
 =?utf-8?B?Mk0wQS9lSDRyYXZRNHI0MHJ2U3J6S2ZvRXAxeDRQZjNIS2JEZmhBblJTZDNs?=
 =?utf-8?B?cmgwZWdDQkhEZERUcm1YRzZGcXo0L2dtTDFVSEk1M1E2NDBadm45UE82c3g2?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04ACBF904BA8A4469584465EC57ACCDD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832e81e7-6c82-4d3f-a86d-08db10dcb6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 11:47:14.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvvsperq1J9xJ3Tmc3xlty4Lzs0HWo3DYR73MRX6AgeiaaKTB6rhsuxmKmiuiOBl7AOwyI03GSFH4n7J4aqOqRVTWsmnyJ7HZScXQxaNnSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDIuMjAyMyAxNzo0MywgTWFyayBCcm93biB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgcGlvY19pZHggbWVtYmVyIG9mIHN0cnVjdCBh
dDkxX2dwaW9fY2hpcCBpcyB3cml0ZSBvbmx5LCBqdXN0IHJlbW92ZSBpdC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0t
DQo+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMgfCAzIC0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJs
L3BpbmN0cmwtYXQ5MS5jIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jDQo+IGluZGV4
IDhlY2Y1MmVjOWI5Yi4uYTFkYjZhYzliZDJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0
cmwvcGluY3RybC1hdDkxLmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5j
DQo+IEBAIC00MSw3ICs0MSw2IEBAIHN0cnVjdCBhdDkxX3BpbmN0cmxfbXV4X29wczsNCj4gICAq
IEBuZXh0OiBiYW5rIHNoYXJpbmcgc2FtZSBjbG9jaw0KPiAgICogQHBpb2NfaHdpcnE6IFBJTyBi
YW5rIGludGVycnVwdCBpZGVudGlmaWVyIG9uIEFJQw0KPiAgICogQHBpb2NfdmlycTogUElPIGJh
bmsgTGludXggdmlydHVhbCBpbnRlcnJ1cHQNCj4gLSAqIEBwaW9jX2lkeDogUElPIGJhbmsgaW5k
ZXgNCj4gICAqIEByZWdiYXNlOiBQSU8gYmFuayB2aXJ0dWFsIGFkZHJlc3MNCj4gICAqIEBjbG9j
azogYXNzb2NpYXRlZCBjbG9jaw0KPiAgICogQG9wczogYXQ5MSBwaW5jdHJsIG11eCBvcHMNCj4g
QEAgLTU1LDcgKzU0LDYgQEAgc3RydWN0IGF0OTFfZ3Bpb19jaGlwIHsNCj4gICAgICAgICBzdHJ1
Y3QgYXQ5MV9ncGlvX2NoaXAgICAqbmV4dDsNCj4gICAgICAgICBpbnQgICAgICAgICAgICAgICAg
ICAgICBwaW9jX2h3aXJxOw0KPiAgICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgIHBpb2Nf
dmlycTsNCj4gLSAgICAgICBpbnQgICAgICAgICAgICAgICAgICAgICBwaW9jX2lkeDsNCj4gICAg
ICAgICB2b2lkIF9faW9tZW0gICAgICAgICAgICAqcmVnYmFzZTsNCj4gICAgICAgICBzdHJ1Y3Qg
Y2xrICAgICAgICAgICAgICAqY2xvY2s7DQo+ICAgICAgICAgY29uc3Qgc3RydWN0IGF0OTFfcGlu
Y3RybF9tdXhfb3BzICpvcHM7DQo+IEBAIC0xODY3LDcgKzE4NjUsNiBAQCBzdGF0aWMgaW50IGF0
OTFfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIGF0
OTFfY2hpcC0+b3BzID0gKGNvbnN0IHN0cnVjdCBhdDkxX3BpbmN0cmxfbXV4X29wcyAqKQ0KPiAg
ICAgICAgICAgICAgICAgb2ZfbWF0Y2hfZGV2aWNlKGF0OTFfZ3Bpb19vZl9tYXRjaCwgJnBkZXYt
PmRldiktPmRhdGE7DQo+ICAgICAgICAgYXQ5MV9jaGlwLT5waW9jX3ZpcnEgPSBpcnE7DQo+IC0g
ICAgICAgYXQ5MV9jaGlwLT5waW9jX2lkeCA9IGFsaWFzX2lkeDsNCj4gDQo+ICAgICAgICAgYXQ5
MV9jaGlwLT5jbG9jayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gICAgICAg
ICBpZiAoSVNfRVJSKGF0OTFfY2hpcC0+Y2xvY2spKSB7DQo+IA0KPiAtLQ0KPiAyLjM0LjENCj4g
DQoNCg==
