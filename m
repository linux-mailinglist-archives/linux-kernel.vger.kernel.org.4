Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7788605673
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJTEsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTEsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:48:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8AD1B6C9A;
        Wed, 19 Oct 2022 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666241295; x=1697777295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gshS3aCBHKyv/YqU570k+jtlEDuwUaxHxjVhV6AJdfs=;
  b=Bi42hY4cpRyHOTj8uQoSP3/ta6njsJAAhH5moBquZxLRWGtATdOx6x/q
   lmtZEnJcstdfJdVyiH4iIHZ03TH6vf7WdYAwEBfLSo71Nl/e2KYq8O5oV
   0BYN1/XE9feUe94TsxUpLkxxyciCKjwY+OB/muhbl7O7yK12ssHLC4D7/
   vgnVe3QpvvdTbjHqfxz++Kk7nBajruiAQSazuXiStgWtnMP8vHErEcc6c
   m2KUuKy3/mGqZqvxIMuxOq8KqG9vRsi5xtiie2+Bn/YdaqikOblztF/jn
   QCyIRbAI0HQe+Vk3RHGLTUrUYKj8nBt+D2BUfPc3Dmadd7sEbldDLt6RK
   g==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="185623524"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2022 21:48:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 19 Oct 2022 21:48:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 19 Oct 2022 21:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hByBj0etSIBVxiz1mxVmlQL+iW5+rcccPJZEj3frab5HyWBDHlRUk68C5tNzn1bu6uK19N0ku20zSxhNuG8+SNJNiDDkgjUARa36lEnxLJMqDzqjQQdJGgMeAxfWxyiPFUrFg73B8Q1pIwP8JVltPB+tEbeOkxvMp57i27HhYIQ27Ymb96kNkMEKmlATglTX9OYDE2FQwoYZj5XTm89anMwtWxMcI3J7jEmPkIC/3MYvDvDmdSQJK5kS9jMaPQGrWF7gZgjaL6WCoTC1W+90Y1DgskdmYZZhdBCaKHrxwuhH7bXyX3rO3gOaiOPJuWoQVuKywxHrLQFqmoRLg+62Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gshS3aCBHKyv/YqU570k+jtlEDuwUaxHxjVhV6AJdfs=;
 b=cQ7h7pDYsRrct6eVv63KJP6s5xoiaF3RsSa6/e0YhDEbOPTCbXwUrw5q31IWuNPFI2TJx/ADvkCnKnG0Vl1Lz8bsm6m+GD93Glma4aUYqJ8+F9DbkW4TnB5Fi0RWRJg8+FI1DVlaMLKpiagGvIbEosnnjrsAN1DZA4s3ucFXtRlbSFQnZobRvlT2x6aeUUHo0XEb4fInjoVU9m9vMW7883OmJ24bo2b+kdhz05o6ixDIagetVrwC5rqOGVLJMdD6Xst28ZtC4q4TieUOlAwZnuKUg4m6hBI8nDyXvQO89SH8cooCO6p/3l4Iy55sL0x6MgTyWYB1LnWQe5Locq1oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gshS3aCBHKyv/YqU570k+jtlEDuwUaxHxjVhV6AJdfs=;
 b=Cq1JvO7jAyx8EgALXg6mflkFfRlyN5m2+8o3ehIozD4f3LkS6dHyNJHPmzPW6LTvqKxDxQXIKsldr8qJWwbJYNkSxqwqt/LQ9W2CiaKgj7N3YqPOw+2ZNZG6prCHM02K/kturU9ipMGjlF/27artIucRcINmiHylwBWG/WTVkRw=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 04:48:09 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac%6]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 04:48:09 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 SPI for-next 2/2] spi: microchip: pci1xxxx: Add suspend
 and resume support for PCI1XXXX SPI driver
Thread-Topic: [PATCH v2 SPI for-next 2/2] spi: microchip: pci1xxxx: Add
 suspend and resume support for PCI1XXXX SPI driver
Thread-Index: AQHY2UFBTyfpeUhNekua+ha6owgtXq4MXsyAgAptewA=
Date:   Thu, 20 Oct 2022 04:48:09 +0000
Message-ID: <54e27d957050c66a3dd2de2e12c5adae26cd904e.camel@microchip.com>
References: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
         <20221006050514.115564-3-tharunkumar.pasumarthi@microchip.com>
         <Y0gUH1fbB/LijKLw@sirena.org.uk>
In-Reply-To: <Y0gUH1fbB/LijKLw@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|SJ0PR11MB4848:EE_
x-ms-office365-filtering-correlation-id: dc46dffa-6600-4cd7-8f60-08dab256492b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sChmNTVAZzaXh9gwM3G/Iyio1UT6iKLHtpMMo4L1V6mKWTr3RFGGHdjgoxwwk6Aj89N2c7XVP/wQPlAauaMGHgzzDHsQEbR6S57xgREGjmPy4yz+iSmI4QHAWZwd5I1pd+VUjlQWLjssFlV6UscCecgRA0l9xWHdssgiUSUWx7r913u7CVUSn8rrHHTJ7PJ1i54otGyOidd2axnQ8VURuZAI6ZXdDo1jedeUjbimS3BnEyB1PKamVQMaYwCEvLXrxkVuI4IUwMhmMbg/FSfYMWsc6VSN6K4+QDe+1WNEjKQ5rwwk7voRuMdJfTPrYPATCWAIcym6Aqa6HMc1j3QCA1i9YdpZgGB3f4Dj6hwWkb+zLjckbV9l7IiZqz9ymmQ3UtzulLUS3PwFYc3OEnQnr16vbkt9R0VYT9hClm4Ss3nZYW0s2cWsygs9LoKgePyYS3SK6WDVUEEMxJlc7fe34VNXYcyvLPzlqnH/68/nF/jCZkjU0cEt8PUoXV3nazP/pgiYVU002y8CKZiZrlqoP9cKkZAcoCuk57MXgc8w5D89ygC1n1lewqyiTO05mfKo9IikDjGjhEFAKOuuJb/KJ5IEa4pjpceKKHyBF6qPTzHlPLwfN5BuV+ETSTdkMpXsF/1FbsLWIeMtiaAkdk60XiOBDH8NG9jTPKJptX6GtRiq3DOOsKdZDBeWVfu/1q5pp/f8EY0zgwjnhJOdI33nxF9nlod8C4iIQPoLxRa3sIp4orbgf/4R/tdIuGm1wAqNYp9hMY6s3eCW9DuwMEYm4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(478600001)(71200400001)(83380400001)(86362001)(6486002)(107886003)(66946007)(36756003)(91956017)(66476007)(66556008)(6506007)(66446008)(8676002)(4326008)(26005)(316002)(41300700001)(6512007)(8936002)(6916009)(4744005)(5660300002)(54906003)(2616005)(186003)(4001150100001)(2906002)(15650500001)(76116006)(64756008)(38070700005)(38100700002)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXZKeUUrc3Nua1YxeHNVZGlhMTBiakhGMHFtbFI4RmlVUDBvVFhwZ05Yd1l0?=
 =?utf-8?B?NzI3TGpUdnFhTWNVcFJMRS9ycEZRMERtU0M4aFo2L2NFcUprU21Fc2ZIMXV1?=
 =?utf-8?B?YVEybkEwYlNYMEIvZksyaHlGVFY2UklxK05mT3FjZXhnM0NxWTdRVWpxQUJy?=
 =?utf-8?B?T0pSdzlYWGVjemN1UzRJbFpRV0pRVmZ5Z2tseVc4T0NxWXRvazhhL0N5aDJG?=
 =?utf-8?B?OFd5VHdYQXFOS3RaZUVSTGd0OU9IUStLTVVoZllwelp5MUxpRmpVNDgzN0RG?=
 =?utf-8?B?SlBIVnphb3FsWjVqcWc2a0NHU2sxTWZFcFYrVHdPWjJGdmpjbll1QUR6Q0lW?=
 =?utf-8?B?OVlUUVplSDRDSWVpRnJQdDNpOTF4UGV6VHJCQS83Kzkwd1ppdDJjTGkyVmcr?=
 =?utf-8?B?VUdDK0FONWxwbGtVMlE4VGorNHBKanI3NHZRc3B2alJSS1ZiMktLZXdjM3d1?=
 =?utf-8?B?QTgvdEdCTWEvc2o3eGR2cUV5Y2p2QWw0Y09ObjExeVRsTXErTFExczk0eHgv?=
 =?utf-8?B?UlpvZUhwUStXNWl3UGNwUXh1NHZ3YkIyN0pIQ1VWNlZ5bURXaTh0UE5FNGpz?=
 =?utf-8?B?Si84dU4yNmNJaVF4NURiZGdVb25QNXl4YzFMZC9Kdkp3dzNWL1hUeVh5STZP?=
 =?utf-8?B?emNwWmZQUldxQ2ZYc1ExcGhXMWNMRGNjL1pyMFZFSGtZKzVvVWZmR0FCTnJq?=
 =?utf-8?B?VmIwL0lSaGQwYkd2Q1RQSjlqVDAwMUkzWHQxcnFCSi9TeGhVNHh0WUduRVNw?=
 =?utf-8?B?U2I2bW9WM28vM2cwYXljUTR6bWt6dUp2NmNrUCtGRmlTaUN1YjZyT3gzZEF0?=
 =?utf-8?B?eFVrdWt4c2E0NlFtc1BZNnZFMlJvV1hYRUE5TTQxRzZoSnR1ZXR1OExlWG1m?=
 =?utf-8?B?QkUwVWltMHJKOXorQjBhMHdaanB4VERBUEJlK1EzOXpvQTFxYmdJUVFZNlZx?=
 =?utf-8?B?SmVkTnM4ZG5xbEc3NDZYcElzbmlDVjlwMEFjQ2M0OUVsNDY5d2pRMlltcHI3?=
 =?utf-8?B?ZHhUbit0QUNYRmh1c2t2c21GZmFvU1JRa1Aycm9VSVRwMU5LUXhLVk1SSUJo?=
 =?utf-8?B?TGRWcjFEcTl3MU4yY21MYWVPTDRicnlQU051SGV1RHBTUjJjQ2pHZkh6RlBR?=
 =?utf-8?B?U1BBbFBMQTNLNzZodUJNRUFPaWhIcmtiWFVYUnR1ZHFON2xRaUdENzJFVG9h?=
 =?utf-8?B?bmxJZUtRMitSdmdOSUlaYU1vbVFxWEdDRkNVMkNacmIxMkVUaERxckRjcFZE?=
 =?utf-8?B?NjFWRW0zblFqQWtJNFE0ZDlhT0srb1Vxc2pya1lHa284SkoxVlJlN1FPenZx?=
 =?utf-8?B?SzZuM2hFRVJSQUlCM0piWmRkYkpPZk5rUkgzT3hGaUNrVEovOCtGMHJDMm55?=
 =?utf-8?B?QkgzTFgwZzRCNzQ2VXY0emtJUXhSOUU2Um05T1psN3VWYUh3ZWJ5dlVEdjVE?=
 =?utf-8?B?QmFnOXFSa1ZxZGtJdm80SWJoUWhKK3V5MzBBbXBBNWN6L1N1Sy9kRDBBRkhG?=
 =?utf-8?B?MXFnSEJyN3dWNFhpVUtvZjczZVB2eG5Mc0hRVTByNktCS1VadzJXdUVqbXpL?=
 =?utf-8?B?SGZZc1BLT1pRdnBnekxxQUZyZWlETFE0aHZXeWMycDdaYjN0bkt5MmdIZ3Qw?=
 =?utf-8?B?Sk9HY1FFeXNqOFZFUzBnd1NnZXh2Y2JUVm8zSENVOGE0eG9sdEt1Ykl3dW9U?=
 =?utf-8?B?OGRjNVJkTWk1WkRuSTZITEwyWitNcEJ0WWFPeno4aEIxRWxTR2M2cGViMmNq?=
 =?utf-8?B?czhWWjAwaitGYnVwMmRMcU1GWWcxbzdjeXJJWkpoUVFBL2V2L3d5eUY3S2U5?=
 =?utf-8?B?dUtheFZBS2V0eVdKd2c2d00xTmlNL2tadHVoRmlpc0FrTlVVVm9ueDNVM3RF?=
 =?utf-8?B?TEIwUDRPWFZWc2lKNGs3OVhRTVRGL1JnaWlzUHh1dWwxSi9vc1NYNXBzdnA3?=
 =?utf-8?B?UVJacnBta01MamdzcnNvU0YrdVNhWDYyb1NRTHhXRTZwUUFMVUFkb2NTVkV3?=
 =?utf-8?B?L1R2akxoZTM1NUVaT2N6S0F2akpnT3FJUG9acVRyNUhPanA5WFhSaUU0NGpK?=
 =?utf-8?B?Ymc0aDF0cHRLS1p1Q2xucFZIMXl3Ymw4bWltY1YvOFd3VWF4amd3MG5kNVAw?=
 =?utf-8?B?Vks0OWgvSHQ0WmRpRjNQaWJPYUtkOXNSdjZkZFJZOTVKMmZJeHRvSk5kZHda?=
 =?utf-8?Q?fvDVCRNuLGxZRkIypdbyMoj6vuO9eURXQVlGOmyOAXiB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <902468D931373E4BA15523E7C6E0BC82@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc46dffa-6600-4cd7-8f60-08dab256492b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 04:48:09.0244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d01E6d6YKJA2N/SAydxuDsMfWmz/9gXgx78W3QCNcNHitWuZN71+uyU1dUk3bpkyfrz2ZLSObWkauXF3jxQdfjkG+9xn1JXLNlH1o/p5vQuKtc2jtY0O9J3dOXc4/qWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTEzIGF0IDE0OjM1ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4NCj4gVGhlcmUgc2hvdWxkIGJl
IGEgY2FsbCB0byBzcGlfY29udHJvbGxlcl9zdXNwZW5kKCkgaW4gaGVyZSAoYW5kIHNpbWlsYXJs
eSBpbg0KPiByZXN1bWUpIHRvIHRlbGwgdGhlIGNvbnRyb2xsZXIgdG8gc3RvcCB0aGUgcXVldWUg
b2Ygb3BlcmF0aW9ucy4NCg0KSW4gdGhlIHN1c3BlbmQgYW5kIHJlc3VtZSBjYWxsYmFja3MsIHNw
aV9tYXN0ZXJfc3VzcGVuZCBhbmQgc3BpX21hc3Rlcl9yZXN1bWUNCkFQSXMgYXJlIHVzZWQgd2hp
Y2ggaW4gdHVybiBjYWxscyBzcGlfY29udHJvbGxlcl9zdXNwZW5kIGFuZA0Kc3BpX2NvbnRyb2xs
ZXJfcmVzdW1lIEFQSXMgcmVzcGVjdGl2ZWx5Lg0KDQoNClRoYW5rcywNClRoYXJ1biBLdW1hciBQ
DQo=
