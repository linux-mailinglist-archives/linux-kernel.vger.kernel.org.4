Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91026F785A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjEDVwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEDVwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:52:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4710812E84;
        Thu,  4 May 2023 14:52:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344LlGgr014174;
        Thu, 4 May 2023 16:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=PODMain02222019;
 bh=dfHF+xdV1nw7KZ89isyluo/uDM03pRQhLFgExetX2CQ=;
 b=gWhYQppvJIuDI9PfEN56qoN5vX1mc2qJBgPISKGGmTZ1rG1+PVtlr0zB5SnxAXRd/B8L
 y8EfaHlukUsJTES+ZFqIWEhSTyjlA6okXGu82GdrRmkwtMRcSNdcTORrBvlrqALUZufB
 rzPKnaKKy1BgXGW6F1z10XjANpiDA+7tPnON61gYyya2/j59ay5cqRQ0WUP7BG9laPyJ
 Id17+XC3qRZ/n8onDTCGd+v7itf/Xgk9wzxIK6kgXaZFdiV+YLhQ4VIWqnesrMYhqhll
 ZdF01ALcS5ENwXHPxoYrFljhb7JeqgQ7sm5kiW46FLm/qvskJV0y/1iwrer0klLX/tB7 yw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3q90n3p70r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 16:51:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0PVmsbS3nIhxKGsm+tfu44wxqiE3ta8ySBqaby2g4RJMcaO8T7wzeSoppCPrwR8w7TkGxE64YOb4bRLR1DMPuAiwFzgIVl09c5TC1OpMkssn+TTyXiU6vtCZlvNmWLiiMlz8m4/WGtxXj4VHVP32/T8RYiIWlgRgUQ7VmIX9k6NtEMkTIaNYAvzPDcJwSQ2M275IRipVfdRjE3GdKAbYBLfOc0/BSRWfyNePkxPEk8beoH4AgXMzoRLwtar3JAPG0EQ7Y68P76+MW4OeN7yUmkeEMa+hEyghA1YId9M4XBFPPHW/JD0sFbkabeWhGpnTtViweN4kBaKpAtj/vMu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfHF+xdV1nw7KZ89isyluo/uDM03pRQhLFgExetX2CQ=;
 b=L744sXykLGWOMxP+4qXW9DRiNn1+bNiXz1euWhZTm7G/pTcj6hyFQSFnHwFx6+jS+uONmSSH0ZT20n8GsD+ICQZM6itjYng8WL/mOPRC8Z3roL/X4endsgt9xDt/zw63oHH1yIm0/MmYDOZQwuyeQ/VCSXmS3Uo+BVNN/DwGeqSnti1n0FmwL8H5wwui7wgbessUigd1+Iz++vzmGxW8o0iyUs5RWiwPKjEErfDBxmJHZlyAqYX3hmVrJzjNsVGps9VCbCxdvmdH7nDNdjQLwB606zKAQPYEMj1sPuQKG5Acrp9n8u5c++W1074amJUH3EWp2ivwBVQjvmdmlqw+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfHF+xdV1nw7KZ89isyluo/uDM03pRQhLFgExetX2CQ=;
 b=XxOO/EeWabMB3OPDx/4PPzd9oIcLZJ/rWqER9JSpvcIVVpkva94Z6BM9Z6wDf8jP+/DNtsDgT0rNhMH47m9XrMDzQzx2JSbavTEM48X7qGlzd92PmnJnA/5zPQrmmfFlRz7or1A8k0jfBKhXfI9lYHZQxzdWnaVggBppAqVyQ9k=
Received: from DM6PR19MB4344.namprd19.prod.outlook.com (2603:10b6:5:2b7::15)
 by SA0PR19MB4205.namprd19.prod.outlook.com (2603:10b6:806:80::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Thu, 4 May
 2023 21:51:38 +0000
Received: from DM6PR19MB4344.namprd19.prod.outlook.com
 ([fe80::fca4:a8fe:2382:8ea0]) by DM6PR19MB4344.namprd19.prod.outlook.com
 ([fe80::fca4:a8fe:2382:8ea0%3]) with mapi id 15.20.6363.020; Thu, 4 May 2023
 21:51:37 +0000
From:   Fred Treven <Fred.Treven@cirrus.com>
To:     Jeff LaBundy <jeff@labundy.com>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        James Ogletree <James.Ogletree@cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Thread-Topic: [PATCH 1/2] Input: cs40l26: Support for CS40L26 Boosted Haptic
 Amplifier
Thread-Index: AQHZaNWIKX1yNV3tR0mmPS6rY8pN+a8iWY2AgAHpewCAAQVXAIAAlYgAgAEhQYCABFT8gIABkzmAgB3sHgA=
Date:   Thu, 4 May 2023 21:51:37 +0000
Message-ID: <7E101F4B-782A-4B8B-B6AB-3E7E282C9A9C@cirrus.com>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71> <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71> <20230411092708.GX68926@ediswmail.ad.cirrus.com>
 <ZDYakQMOPsPTbGe0@nixie71> <6ABC85BA-AF2D-4D2E-8CA8-32E372570DA0@cirrus.com>
 <ZDsPGYJjCNmtizKk@nixie71>
In-Reply-To: <ZDsPGYJjCNmtizKk@nixie71>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB4344:EE_|SA0PR19MB4205:EE_
x-ms-office365-filtering-correlation-id: c04b6d15-f410-4b6c-1472-08db4ce9bc25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A91THFi0surGxpJ207rFh9nUPcfk3CTGHA8m7vCc3lydtiIinSxXXPegx0KwBW2LVQKERjYKHGKQqRkdbbox+48UW8oiv21BLmvH9eJBd7H3ZGBsksJWZBNId3+ePT4uhsJ6RRJbLL0bmBOmfD8YtAJZBu1jPGAM0PpzWAnVYy3gYfr3A2Q7pI0cGESjxgTke4lPZAve9iLTmgEEhLuV4OdmZQ/iZr+EG/ro3zVP/PUV7R/t82S/npkCC4UC8ZlrN24kCFPf6B1IGbu5bVQoIjD5srfWWQx1EpVD8wVnXIwuxrEhjY7wAaegtZCJjezupGTxBYxSw4NI2NVSQUd0PkpYH9QKThZ2bo70VzX7pOQguI6gQfBFM2ZEcxbHaRo09lIbQNn9jkUeKuNY4huJ4Jkuflbo9E5vpfJsF0D46OzmDahYXEL9rhETKQTicP26kciD0AjX6GHVe2j7D9XRlPzTgEIb4gYEOOGl6ZV+yq4ODHnG+LiNYVUBwDnlb2ZLlAUQ1cg+80lkBh4OU4QpxqH5O+v22N1iH/OpTKJRPt/iLwQyM5MJM0Bt8OIFFIN+UTbeW6y0Dd3s6bMgpM67i8U17pY+P7BD6M5jqqAaqiRnjBU1QBijVUyVJdfrgkNQeMyAxpX5u/z9NsGN8VBFHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4344.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39850400004)(451199021)(6506007)(66556008)(6486002)(76116006)(91956017)(4326008)(478600001)(66446008)(66946007)(6916009)(66476007)(64756008)(26005)(107886003)(6512007)(71200400001)(38070700005)(186003)(122000001)(38100700002)(7416002)(5660300002)(2906002)(83380400001)(41300700001)(8936002)(54906003)(36756003)(2616005)(8676002)(33656002)(86362001)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTQrd2g2cXBFbDcxQXBsbUVmeU8wNnhCc3JHYWhPbUtHN25LazI3L0RLTXRE?=
 =?utf-8?B?MTBpeGZQNzU3RjBORnBucDVKaFdOQmNhcllMYzN0VmszZjFMdUYwTTNEa3RE?=
 =?utf-8?B?WDdDZ2JlT3JFRmQvSG1takRvWFRZN1pvWUExeWpTaWdlZjRrVkV6aFA1YjdR?=
 =?utf-8?B?Z3VSTjRtaW9VOG1Cc1oyVnNzZXJTN3ZPS2RYeVBRR2M1bTZPWWdHUGV4S3ZB?=
 =?utf-8?B?ZnV0R3dPNU5BS0pRRStWK3JMWUpycUNXT05DN0RTU2lFTWdVT1hwMGpTNTlN?=
 =?utf-8?B?WWRMR0w4d2NsUm9WTTVGU0FPekxmNUVRL1pLYTRocmJTTDA3T2FBRmxJcTRX?=
 =?utf-8?B?S1V6TzZWZVRPSkE0c1o0TDlUb0xybXpXQmZOM1RiMGNNRHBhclZGSDlMc3hX?=
 =?utf-8?B?WTdOL2d5ZGlUdTN1S2o2RkFCQ1NlTmcyTnUzdkE5b1o4Tjc4VmdhTWxkNkhs?=
 =?utf-8?B?UmJEK1lRUVJDaGppN2NRVjErSERZRTUwUXdnMW1QTUFJNUo4SFNmeDFRU1Y1?=
 =?utf-8?B?N2xvaHFScTdhb2h0MlFuZ3NkbDBGdU1hRVBMd3pkUlJkbmptYlBrNkdwbXEx?=
 =?utf-8?B?TmVJRW80bGdlREprSVEyNGpnYTU0MStOK1UwZVF0dzRZeTdxU1BnRytsckVM?=
 =?utf-8?B?TmFPQ2ZXR1p0VGtEWUhsdVVOdDVnT2RXWlBLODlxd1Y2bTJKMWw1U3pmY1dy?=
 =?utf-8?B?WGdIdXZjUTdCTlMrYkRlbzZENTJlbllYKzJpTVZkWloxSEV2K1Q5UWF6K3Bi?=
 =?utf-8?B?VGtMRmgwVG12aEg5WktuTFZNWWY0OGJzV3htV0lMUG9MaXRpSmFRV2VzWmtJ?=
 =?utf-8?B?TWo0eU5yWGZLa1IxeEtpNzdrZVhNckhSbWg5MzFaTEQvdVRVYU5VUVNCQ0Ru?=
 =?utf-8?B?eGVIYm4xMExyOW5sN1p5cnNobXZLUkdnSW1mOXc3dmZESDRuWWNkK0hmTTM2?=
 =?utf-8?B?ZTlPQjkyWWxYd3MxeHY1bGQ4N2tJS0IrcU9yN0N5T2lSL0RGOC9tT2dEVTlj?=
 =?utf-8?B?RjViaGdhOWZ1VE9nbGR6RFhTdlVpOUE0Q3kwaU03dU1mUkszSmVpdUoxSHdF?=
 =?utf-8?B?ZE1jL0Zud3hRSmxGb0JnV3RQTjVadTdrMDFxTXR6am4wZnlHRS92YXgxaEk3?=
 =?utf-8?B?U1pDL2xOSTBvb0o1TGo2WFZJU1d0RVIwOTI2a2Z5Y1Bla3RwdURoYmJjdnA0?=
 =?utf-8?B?WGExcWhSWEdLRDlXbXFhK2xDbGQzbGtPM3g1TmRvZ0xOTjFWOEJyeEoraDN5?=
 =?utf-8?B?Vy84V20zbXBPQjJid0N5VWx6TGlzd3JHbVVMcFc0cys4UWovYWd2ZFRwdTVS?=
 =?utf-8?B?MzBMb2d6ZXJiYlpTYmorU0FGby90ZHFqNVc5K2hraHh2bWduSEQ1eUVMdEVZ?=
 =?utf-8?B?Z3krUTBTQ3FyK2RXVE9XRG90VVBZU0FGQVVjMHM3U1MzQ2RmZ2lTbm5vK3Z5?=
 =?utf-8?B?Zlovc0hCS25KR0VJYWNTekg3dS9lNXFjam1tSVhTOU52djBLelpCSFdWUzE1?=
 =?utf-8?B?UjA1bnVSQnQyQ2RzeDFkbTJuWVE0T3dnRFFtY2d5ck03bjZqeHkyeWtDelFT?=
 =?utf-8?B?dmJMem1iRCtMem9JcU5HNDAySlNpbUI0b2hZQ1gydG1mZDI1Z1Ftb212ZDdD?=
 =?utf-8?B?YmQ1ZlhHVjZwcm9pcTlqcGQ4aVlSNmZITnZoMVhnS2RERFQ1d0FuSUcxaFl3?=
 =?utf-8?B?aHVId1dZZDFTcUpVajI0TlJ1azVrS1BUZzU0SVdLTFlKVnFOQXd5ampWVWNJ?=
 =?utf-8?B?aEVyN1NpMXJESVJLZGFRdjZxSjRJbWNzbXhEbndORUNuNXRhSUlEVUxPY3lK?=
 =?utf-8?B?TXlEN3RTSzFYYUNtdXY1Y2psbmFwR2JyWFNPcWNxRmRNcVJIbThud0tsbm1x?=
 =?utf-8?B?eU9rSkFyQTZRclJOeHVCZ3FURjhaZ2IxUE5aSSsrZnhwREdIMm5tRG5CeDla?=
 =?utf-8?B?WmcrSE1wWk9OcGl0ak44VEYyMSt5aDI1QUgxR0VzYy8vNDdvYnloY2g4SHhk?=
 =?utf-8?B?RTdoeTFDc004eGZMTEM2NURXTjI5WEErNllRK1B4Q0RHT3pCZ1JyL0R1YTlE?=
 =?utf-8?B?aVd4VjJPbzZpdXVUL2FEZkVZSEhPRld6dUxTYWN4cFV1YXp5VjhjaVkwZzNs?=
 =?utf-8?Q?uCNMS3cJzk959JaIHA5HsLGBb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47B13AE47C8F1840B27B4B4E20E54BC7@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4344.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04b6d15-f410-4b6c-1472-08db4ce9bc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 21:51:37.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HDX/62EdiH9mhZvy72Q9xmpWVM96gaj3nJTymmDSZGP2oNMtOHwuD6alGw/Kg+9owcQW4FtruA+QTfPd0dEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4205
X-Proofpoint-ORIG-GUID: z1wQucJeE-BvXwPXpxsGRV_UqGpMilj5
X-Proofpoint-GUID: z1wQucJeE-BvXwPXpxsGRV_UqGpMilj5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVmZiwNCg0KSSBoYWQgb25lIGxhc3QgcXVlc3Rpb24gZm9yIHlvdSBiZWZvcmUgSSBzZW5k
IHRoZSBuZXh0IHZlcnNpb24gb2YgdGhpcyBzdWJtaXNzaW9uLg0KDQo+PiArDQo+PiArIHJldHVy
biAwOw0KPj4gK30NCj4+ICtFWFBPUlRfU1lNQk9MX0dQTChjczQwbDI2X3JlbW92ZSk7DQo+PiAr
DQo+PiArc3RhdGljIGludCBjczQwbDI2X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4g
K3sNCj4+ICsgc3RydWN0IGNzNDBsMjZfcHJpdmF0ZSAqY3M0MGwyNiA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPj4gKyBpbnQgcmV0Ow0KPj4gKw0KPj4gKyBtdXRleF9sb2NrKCZjczQwbDI2LT5s
b2NrKTsNCj4+ICsgZGV2X2RiZyhkZXYsICIlczogRW5hYmxpbmcgaGliZXJuYXRpb25cbiIsIF9f
ZnVuY19fKTsNCj4+ICsNCj4+ICsgcmV0ID0gY3M0MGwyNl9hbGxvd19oaWJlcihjczQwbDI2KTsN
Cj4+ICsNCj4+ICsgbXV0ZXhfdW5sb2NrKCZjczQwbDI2LT5sb2NrKTsNCj4+ICsNCj4+ICsgcmV0
dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBjczQwbDI2X3N5c19zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICt7DQo+PiArIHN0cnVjdCBpMmNfY2xpZW50ICppMmNf
Y2xpZW50ID0gdG9faTJjX2NsaWVudChkZXYpOw0KPj4gKw0KPj4gKyBkZXZfZGJnKGRldiwgIlN5
c3RlbSBzdXNwZW5kLCBkaXNhYmxpbmcgSVJRXG4iKTsNCj4+ICsNCj4+ICsgZGlzYWJsZV9pcnEo
aTJjX2NsaWVudC0+aXJxKTsNCj4+ICsNCj4+ICsgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4g
K3N0YXRpYyBpbnQgY3M0MGwyNl9zeXNfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+PiArew0KPj4gKyBzdHJ1Y3QgaTJjX2NsaWVudCAqaTJjX2NsaWVudCA9IHRvX2kyY19jbGll
bnQoZGV2KTsNCj4+ICsNCj4+ICsgZGV2X2RiZyhkZXYsICJMYXRlIHN5c3RlbSBzdXNwZW5kLCBy
ZS1lbmFibGluZyBJUlFcbiIpOw0KPj4gKyBlbmFibGVfaXJxKGkyY19jbGllbnQtPmlycSk7DQo+
PiArDQo+PiArIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IGNzNDBsMjZf
cmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICt7DQo+PiArIGRldl9kYmcoZGV2LCAiJXM6
IERpc2FibGluZyBoaWJlcm5hdGlvblxuIiwgX19mdW5jX18pOw0KPj4gKw0KPj4gKyByZXR1cm4g
Y3M0MGwyNl9wcmV2ZW50X2hpYmVyKGRldl9nZXRfZHJ2ZGF0YShkZXYpKTsNCj4+ICt9DQo+PiAr
DQo+PiArc3RhdGljIGludCBjczQwbDI2X3N5c19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0K
Pj4gK3sNCj4+ICsgc3RydWN0IGkyY19jbGllbnQgKmkyY19jbGllbnQgPSB0b19pMmNfY2xpZW50
KGRldik7DQo+PiArDQo+PiArIGRldl9kYmcoZGV2LCAiU3lzdGVtIHJlc3VtZSwgcmUtZW5hYmxp
bmcgSVJRXG4iKTsNCj4+ICsNCj4+ICsgZW5hYmxlX2lycShpMmNfY2xpZW50LT5pcnEpOw0KPj4g
Kw0KPj4gKyByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBjczQwbDI2X3N5
c19yZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gK3sNCj4+ICsgc3RydWN0IGky
Y19jbGllbnQgKmkyY19jbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7DQo+PiArDQo+PiArIGRl
dl9kYmcoZGV2LCAiRWFybHkgc3lzdGVtIHJlc3VtZSwgZGlzYWJsaW5nIElSUVxuIik7DQo+PiAr
DQo+PiArIGRpc2FibGVfaXJxKGkyY19jbGllbnQtPmlycSk7DQo+PiArDQo+PiArIHJldHVybiAw
Ow0KPj4gK30NCj4+ICsNCj4+ICtjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBjczQwbDI2X3BtX29w
cyA9IHsNCj4+ICsgU0VUX1JVTlRJTUVfUE1fT1BTKGNzNDBsMjZfc3VzcGVuZCwgY3M0MGwyNl9y
ZXN1bWUsIE5VTEwpDQo+PiArIFNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKGNzNDBsMjZfc3lzX3N1
c3BlbmQsIGNzNDBsMjZfc3lzX3Jlc3VtZSkNCj4+ICsgU0VUX05PSVJRX1NZU1RFTV9TTEVFUF9Q
TV9PUFMoY3M0MGwyNl9zeXNfc3VzcGVuZF9ub2lycSwgY3M0MGwyNl9zeXNfcmVzdW1lX25vaXJx
KQ0KPj4gK307DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoY3M0MGwyNl9wbV9vcHMpOw0KPiANCj4g
UGxlYXNlIHVzZSBsYXRlc3QgbWFjcm9zIChlLmcuIERFRklORV9TSU1QTEVfREVWX1BNX09QUyku
DQoNCldoZW4gbG9va2luZyBhdCB0aGVzZSAqX1BNX09QUyogbWFjcm9zIHRoYXQgcmVwbGFjZSB0
aGUgZGVwcmVjYXRlZCB2ZXJzaW9ucywgaXQgaXMgdW5jbGVhciB0byBtZSBob3cgdG8gbWFpbnRh
aW4gc3VwcG9ydCBmb3IgKl9zeXNfKiBhbmQNCipfc3lzXypfbm9pcnEqIGZ1bmN0aW9ucy4gV291
bGQgdGhlc2UgYWxsIG5lZWQgdG8gYmUgc2VwYXJhdGVseSBkZWZpbmVkIHZpYSBERUZJTkVfU0lN
UExFX0RFVl9QTV9PUFM/DQpXb3VsZCB0aGUgKl9zeXNfKiBkZWZpbml0aW9ucyBzdGlsbCBiZSBk
ZWZpbmVkIHRocm91Z2ggYSBzdHJ1Y3QgaS5lLg0KY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgY3M0
MGwyNl9zeXNfcG1fb3BzIHdoaWNoIGlzIHRoZW4gZXhwb3J0ZWQgYXMgaXQgaXMgaW4gbXkgaW5p
dGlhbCBzdWJtaXNzaW9uPyANCknigJltIHVuc3VyZSBob3cgdG8gaGFuZGxlIHRoZXNlIGNhc2Vz
IHdpdGggdGhlIGxhdGVzdCBtYWNyb3MuDQoNCkFwcHJlY2lhdGUgYW55IGd1aWRhbmNlIHlvdSBj
YW4gcHJvdmlkZS4NCg0KQmVzdCByZWdhcmRzLA0KRnJlZA==
