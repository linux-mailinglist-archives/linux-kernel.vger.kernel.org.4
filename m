Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665216E2B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDNUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDNUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:52:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C159C90;
        Fri, 14 Apr 2023 13:52:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EKprcJ000859;
        Fri, 14 Apr 2023 15:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=PODMain02222019;
 bh=NxbvTkdDUYWgYk2KxzZ355WJYZH3W8GQt9XSU73NXbA=;
 b=HMH2FV+1xDM0XEXBpAe3LVZBD7eb7tCFtWrOAJijn3siauBX4TMTB9cZAOR6FgTAt+R2
 PAwTYOZeAEbiVyo/reQafvtyOea6ATaXhL2jrGTyDAT2WDhkFq9bKCLRllYBPGuik1c2
 FcdgbSsNMvPd0vB1AXGeRU4RpfwhxFwm8wm8zlerG0eEYj5w9vPrBnhob68Vw8sKwp2H
 R0ptF1BwhG1CcZi2ryIvak1OsxrOX59KqjvcpQ8woEtLlT/RTo5VvrFJMhL0PzVIWgcd
 IEAxUo/BcGHOvvPCT3HjMMfrlrQbuIaYDUziBXaOBAf98HT1MqH1CKB6xLhgjk0BmQJ5 2A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pxm3qajym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 15:51:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG41SaFgYApSEBKtOXgu53NooTgsfE30n3cXgpQkW8n/HZ5fxl1VnvxOm5ja8wB2KgWXlQX8MTXpVTKW3K6WNfSBYFZ+Pbbd4qS4cvm5rJ5tp3ciaoq13GZW6oG2iV0+dE886tgCJBkiE0ng2xYMp/Hctub/9JwrGZ4XNqxGQ3joHJiTCEiNQu8f2h0npkmSxN1tv3vcuUHKHcqrN9MuRYU2lU3MvgdPD5YYpdi7sAwP4Dk3v4e2TLeoGncFA9KDsrtd3xd6BOqvxzD0oo3o3kEH6oQgRXaQGUNLaoFxTvm1WoKEnBxz9E6C5DS4uwfNvJPaIwakgAYjl4mJvA+37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxbvTkdDUYWgYk2KxzZ355WJYZH3W8GQt9XSU73NXbA=;
 b=nF4Ecc/430AsmgbW4HOFI73JmwviJp51wWhytXF4A2iNVpuLJsR65neW51m/GMr50VBsc8q/SP2yb1KdxGpkv1Q0BW+pbnR4HEdp0D8d61GcSp4wCHzR3Bopl+jUubExt9xd5rINab0qUxsxuz9q6PcDHGor3yJTy62CxPs9x1Kzeqf1+L1lIrEI68UxCF+RWRraeRRnl7A8uPVuadajTRVG1MKWKQ1CcU8u+bEk79Z3YdYsDvjohIcxdnFTgY9HC0dgq6RQUAgQo6S90fFkBwFhveBCl2yQfesIfG3qEjK0cN/+B/603/7CUDE3h2bgRL4v+o3WmCbr0yvynKLbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxbvTkdDUYWgYk2KxzZ355WJYZH3W8GQt9XSU73NXbA=;
 b=MazA6Jc9Wj8DoFnW5iBGbZSM38Vq7++KWCyXmExenMsnsyR8G45QGDSMgfEDYsa57W9HZDtIaD/nruvIcl6zQn4OAGJKfU+XP65kYRAZpp8BlGqHv5wjJ/YVAdr0+REqgq28yJdH6DIHEx/VV54WHxkIH7hc4/+OstpH2ks/jys=
Received: from DM6PR19MB4344.namprd19.prod.outlook.com (2603:10b6:5:2b7::15)
 by CH3PR19MB8086.namprd19.prod.outlook.com (2603:10b6:610:17e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 14 Apr
 2023 20:51:48 +0000
Received: from DM6PR19MB4344.namprd19.prod.outlook.com
 ([fe80::fca4:a8fe:2382:8ea0]) by DM6PR19MB4344.namprd19.prod.outlook.com
 ([fe80::fca4:a8fe:2382:8ea0%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 20:51:48 +0000
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
Thread-Index: AQHZaNWIKX1yNV3tR0mmPS6rY8pN+a8iWY2AgAHpewCAAQVXAIAAlYgAgAEhQYCABFT8gA==
Date:   Fri, 14 Apr 2023 20:51:48 +0000
Message-ID: <6ABC85BA-AF2D-4D2E-8CA8-32E372570DA0@cirrus.com>
References: <SupportforCS40L26BoostedHapticAmplifier>
 <1680819415-28806-1-git-send-email-fred.treven@cirrus.com>
 <ZDI0p5Rkp74SzJCv@nixie71> <20230410085634.GV68926@ediswmail.ad.cirrus.com>
 <ZDSqfHemG8pKj1k7@nixie71> <20230411092708.GX68926@ediswmail.ad.cirrus.com>
 <ZDYakQMOPsPTbGe0@nixie71>
In-Reply-To: <ZDYakQMOPsPTbGe0@nixie71>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB4344:EE_|CH3PR19MB8086:EE_
x-ms-office365-filtering-correlation-id: 73369bcd-4ec2-4940-13ee-08db3d2a10e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fprn2U+D+RDkg4c6bDOn9h3PW3fI12SvU4yGAkuQlqL2lzAyHIojuqp5hVHUoDXHtG1Gk2/bPdX8zl0K6wDDhMyAPgti9+8Xa4eijNx1UUWnZs6+2CrYj1gpeL6F1uT6iq2fKlcX5xx9rfK3nMW2H+9iIH01Er89DpNg3Z0S0j+BabO81vypya8N6gQcRSL1kfL0O5HKGaFsQv53Z8z4Z4wDRZX1DicmGt0tBr2z24xNgshgoJU3xwnHoRbVD+ESOEQXbqQghyrwU0gWtpsYy/sm5rd7pUzLUgC5I4Z7c0sEVZzs1xn90p92iG88Kfq84RLwuMzNzctL0w3+307upsJbzTuIWXX178XK73g8pfnE90vVInpKtLXTmyieyDhfrHKnfaC2U3dLHmrD7e/coWTE2b9wx2HKEn3eaa3Nh853U+bjd8lxx+manZr/yE2RFh7jmO015PeeEGHMSzZHus0rG8cE3V7s8dD6jjMX6gi7/vcV/9qbnrKfkn3PsCXzihQby9Qt+b0qDtti04gRxw6W6SAfApvAagjDN8Fh8EE/H1zv8kJkrkiCmjlZMwlsfFCMdpSE6pSjyjFHf5OsnsCwjaDRjdEDwY1YUL5di1VczpgzjNNeaol/kLuC3mWe6cc7q3ALga1mBKd5oXnPDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4344.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39850400004)(396003)(366004)(376002)(451199021)(66899021)(91956017)(478600001)(71200400001)(54906003)(6486002)(2906002)(2616005)(7416002)(33656002)(8936002)(64756008)(186003)(83380400001)(86362001)(38070700005)(122000001)(316002)(36756003)(5660300002)(66446008)(41300700001)(107886003)(6916009)(6512007)(4326008)(8676002)(66946007)(66476007)(66556008)(76116006)(38100700002)(26005)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1pDQ0tPR0c0TkFMVDZ6b2F1UGwyUlRkeThDdTErY0JPNkYrRy9zeWh6Ykxy?=
 =?utf-8?B?TjRlVHZQdi83NU9paGdTREdFTjVaSURtcmFxdEtPTFZNV3hPb0FEUXE1bzJV?=
 =?utf-8?B?T0dVWEZCMS9qNnBvdzhGcmxQcjl6NVR3a1NJcENSRkNhTTJTRHR4OXhxbEFO?=
 =?utf-8?B?TzZmaDg1UU1WWXJPRUJ2TC9KS1A3ZEpKdWc0S0NxVEI4Yy9md0dHQkFPY1dL?=
 =?utf-8?B?bzhpK2k3SXVoMzZnbFdtMkV4eHpjSndSekxsOFp6TnFRSjQ2Y1M2K1NZZHRp?=
 =?utf-8?B?cWYwbThTOVVYT0lUVlJZaHRCMGVkMWtMRHhSb09DeWg0NmMzNWRzZkRHVDlQ?=
 =?utf-8?B?MmdLL3JDZm4vcHU2WCtRek5aaUsreEh2MC9lckNpMnkvQTlqdmJCMzZFTzhM?=
 =?utf-8?B?L3M1RHZTdUlxOE5jbEVKWjhwYStveDU0RmdyTE84MWVZM01SUVNaakNibmV0?=
 =?utf-8?B?TjNKaWc2YmhkNzBQRDdNamoxRVU4UmpDT2RCaU1UaDltcUhVaTBobVpyYXVU?=
 =?utf-8?B?V2x3cmpGMVBJQVpVejBudnlFNVZ5b01DZnNuSDIyTG9mYSs3cnZ0aFd0YnRF?=
 =?utf-8?B?U0tZSHpLemwrRVhhYVBMWFB1ejQyRE13eVB5dUttRHFWbDJHOFJvaGtCQ2c1?=
 =?utf-8?B?aENVaGUzL01XMmdQKzU2elNKZzMrbGZjYXBSY0NPaXhvV0VpRVNkbDcrRTU5?=
 =?utf-8?B?d0t6V3ZwZFlNblY3SnNpbHZoekdQc2lXczNLSmZRVitzblJyUUUrOUVyWGhh?=
 =?utf-8?B?Y0puUjhLaUU0cTAydnhoWjU5S21HRXpITlNVUW9XYlZqZldlRFhEM2hTay8y?=
 =?utf-8?B?bmQrNW4xOGw5aG9jTHVhOFdCL3NGR2RJMFNBR0ZFTDF3cmVnTTJBdmpLZlJz?=
 =?utf-8?B?a3ppdzRwc25tR3MyblY5YU0zMHNuKy9CSjRBTUJ3eXJDMW16RUlNTUdTVEw0?=
 =?utf-8?B?dmMvWlJpTWMwd250eHZjWlkzNjFCNjlEUlZwWlpXVGxQZng4c1VucmhmL2Nk?=
 =?utf-8?B?d2dXQlVpUHRENEVlMEE5VHNBM1U2WXpMYUtKeW5qSU1rdDQ4eUw1NmF1a0w2?=
 =?utf-8?B?b3FQaFpjTTJWeG5HYnJlVnJJbmFWOGJWWXRTRDFaT1J3TjZCdStBM0h1TUJy?=
 =?utf-8?B?bzNnd0JQdUVENHJldHlVd2t1RXViL3Fzc0txbnRHRVVmRDgxOVVPZXJESDN6?=
 =?utf-8?B?RloweFJqd0FzV05aQWZzZUI3MU9ZRnR2Z1A1dVlhaWltYzh1ZG04MlZwTGVv?=
 =?utf-8?B?RHNVU2JqUlQvU0doS3ZDeEpaTHNmOGlvQ2lPZDY3cWxvbDRYUzgxUW8wRkY0?=
 =?utf-8?B?N2tIWTAraW1ySk12cVRkeGtVSjNjOFJkTlNtWkNsejVKZHZRbG5JMEYxUFJz?=
 =?utf-8?B?RHRVdXRaS3EzSldXRVlwMnpWOUsxRlhpQ0hQMzFVN0E1NklBaWtQS0poclRu?=
 =?utf-8?B?b00yTFNrM1lHNUNFTGEzVllLanZLeExnSTdnUVBHOGwxVnpoYzNXZlVHWVFC?=
 =?utf-8?B?N2pRemVvSEFJYlo3Y3JRYzJ6cTRRL1h3NEwvMXVMendsbDVMc21XRGgvOWM5?=
 =?utf-8?B?N0tFYzRSTXRENlVma1hmSlNtNEQ2c2ErYTBuaysrMU95WDYzRnZHOFpqeEIv?=
 =?utf-8?B?VFFQMFRoNjdOdTJZOHFPV29QMnFDaFpkU3pRdXlnUWVqaUJOaTNkMkZGVy9r?=
 =?utf-8?B?WkJZMjVVVEYzbWdPWUpaU2tzd0xmanNZaG5xRVZ1Y0h5MDVkK1laZUVNSmtK?=
 =?utf-8?B?UUJ2MHdTcFduWFNYZXZxcmNURjJJYWJUbmhnd2NkVGIyV1dpMkcva2lrOVNj?=
 =?utf-8?B?Yk5wU05Yc1RvRXJGWGQ2aENiMS9xS1FTVFQzNlFNODhrUHRVQTluR3lJVWsr?=
 =?utf-8?B?K2FHUlJaQVdvUWZNd0U2d0VQUStaTnhRT1lPclJWNWpiRnZtTjcwS1ZLWisw?=
 =?utf-8?B?UUIxRG1DWXlMR0V1ZlpWRXFhS1NkNXFnUWNKUUV4S2xVanJUWEVkNVREV1ha?=
 =?utf-8?B?TTBDUXMxM1huS2ZUNmpzWWNiZFlQTVRnWVh4U0ZYNGZOMWdDclVXU1c3ZGRm?=
 =?utf-8?B?cmt5SkZDR2tKZko4V2xaQklETWVSK2xuZzA5R0V0MU4zWEpRL0d0TWRFbGQ1?=
 =?utf-8?B?eGFmWW80a3dReUZGUTd0dmNQS3pUZW16eDdWWmJwell2OU1OdmRCcjBKUUlS?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0205B85E849B1C479D9723704718043C@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4344.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73369bcd-4ec2-4940-13ee-08db3d2a10e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 20:51:48.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIOJlPBCXd9KoN33eaFATpl/7/O1LLqiKeXitzjzoutS3jkX2gbSUar4uICtCQohoRodbWzWv0is2zVhO99vsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8086
X-Proofpoint-ORIG-GUID: SbvqjAk-kgkcjE33Zei4p4bPteiMW243
X-Proofpoint-GUID: SbvqjAk-kgkcjE33Zei4p4bPteiMW243
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

DQo+PiArDQo+PiArIHJldHVybiBjczQwbDI2X3Byb2JlKGNzNDBsMjYsIHBkYXRhKTsNCj4+ICt9
DQo+PiArDQo+PiArc3RhdGljIHZvaWQgY3M0MGwyNl9pMmNfcmVtb3ZlKHN0cnVjdCBpMmNfY2xp
ZW50ICpjbGllbnQpDQo+PiArew0KPj4gKyBzdHJ1Y3QgY3M0MGwyNl9wcml2YXRlICpjczQwbDI2
ID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7DQo+PiArDQo+PiArIGNzNDBsMjZfcmVtb3Zl
KGNzNDBsMjYpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgc3RydWN0IGkyY19kcml2ZXIgY3M0
MGwyNl9pMmNfZHJpdmVyID0gew0KPj4gKyAuZHJpdmVyID0gew0KPj4gKyAubmFtZSA9ICJjczQw
bDI2IiwNCj4+ICsgLm9mX21hdGNoX3RhYmxlID0gY3M0MGwyNl9vZl9tYXRjaCwNCj4+ICsgLnBt
ID0gJmNzNDBsMjZfcG1fb3BzLA0KPiANCj4gUGxlYXNlIGd1YXJkIHRoaXMgd2l0aCB0aGUgbmV3
IHBtX3NsZWVwX3B0cigpLCBhcyBub3QgYWxsIHBsYXRmb3JtcyB3b3VsZA0KPiBkZWZpbmUgQ09O
RklHX1BNLiBNb3JlIGNvbW1lbnRzIGluIHRoZSBjb3JlIGRyaXZlci4NCg0KVW5kZXJzdG9vZCwg
YW5kIEkgY2VydGFpbmx5IGFncmVlIHdpdGggdGhpcyBjaGFuZ2UuIE9uZSB0aGluZyBJ4oCZbSB1
bnN1cmUgb2YgaXMgd2hhdCB0aGUgZWZmZWN0IHdvdWxkIGJlIG9uIHRoZSBkcml2ZXIgaWYgQ09O
RklHX1BNIGlzIG5vdCBzZXQgaW4gdGhlIC5jb25maWcuIFN1cmVseSwgdGhpcyBkcml2ZXIgd291
bGQgbm90IHdvcmsgYXMgZXhwZWN0ZWQgcmlnaHQ/IFNob3VsZCBJIGFkZCBhIGRlcGVuZGVuY3kg
aW4gdGhlIGtjb25maWcgdG8gYXZvaWQgYnVpbGRpbmcgdGhlIGRyaXZlciB3aXRob3V0IENPTkZJ
R19QTT8NCj4gDQo+PiArew0KPj4gKyBzaXplX3QgbGVuX3dvcmRzID0gbGVuX2J5dGVzIC8gc2l6
ZW9mKF9fYmUzMik7DQo+PiArIHN0cnVjdCBjc19kc3BfY29lZmZfY3RsICpjdGw7DQo+PiArIF9f
YmUzMiAqdmFsOw0KPj4gKyBpbnQgaSwgcmV0Ow0KPj4gKw0KPj4gKyBjdGwgPSBjc19kc3BfZ2V0
X2N0bChkc3AsIG5hbWUsIFdNRldfQURTUDJfWE0sIGFsZ29faWQpOw0KPj4gKyBpZiAoSVNfRVJS
X09SX05VTEwoY3RsKSkgew0KPj4gKyBkZXZfZXJyKGRzcC0+ZGV2LCAiRmFpbGVkIHRvIGZpbmQg
ZncgY3RsICVzXG4iLCBuYW1lKTsNCj4+ICsgcmV0dXJuIC1FTk9FTlQ7DQo+PiArIH0NCj4+ICsN
Cj4+ICsgdmFsID0ga3phbGxvYyhsZW5fYnl0ZXMsIEdGUF9LRVJORUwpOw0KPj4gKyBpZiAoIXZh
bCkNCj4+ICsgcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiArIGZvciAoaSA9IDA7IGkgPCBsZW5f
d29yZHM7IGkrKykNCj4+ICsgdmFsW2ldID0gY3B1X3RvX2JlMzIoYnVmW2ldKTsNCj4+ICsNCj4+
ICsgcmV0ID0gY3NfZHNwX2NvZWZmX3dyaXRlX2N0cmwoY3RsLCBvZmZfd29yZHMsIHZhbCwgbGVu
X2J5dGVzKTsNCj4+ICsgaWYgKHJldCkNCj4+ICsgZGV2X2Vycihkc3AtPmRldiwgIkZhaWxlZCB0
byB3cml0ZSBmdyBjdGwgJXM6ICVkXG4iLCBuYW1lLCByZXQpOw0KPj4gKw0KPj4gKyBrZnJlZSh2
YWwpOw0KPj4gKw0KPj4gKyByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW5s
aW5lIGludCBjczQwbDI2X2Z3X2N0bF93cml0ZShzdHJ1Y3QgY3NfZHNwICpkc3AsIGNvbnN0IGNo
YXIgKiBjb25zdCBuYW1lLA0KPj4gKyB1bnNpZ25lZCBpbnQgYWxnb19pZCwgdTMyIHZhbCkNCj4+
ICt7DQo+PiArIHJldHVybiBjczQwbDI2X2Z3X2N0bF93cml0ZV9yYXcoZHNwLCBuYW1lLCBhbGdv
X2lkLCAwLCBzaXplb2YodTMyKSwgJnZhbCk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQg
Y3M0MGwyNl9md19jdGxfcmVhZF9yYXcoc3RydWN0IGNzX2RzcCAqZHNwLCBjb25zdCBjaGFyICog
Y29uc3QgbmFtZSwNCj4+ICsgdW5zaWduZWQgaW50IGFsZ29faWQsIHVuc2lnbmVkIGludCBvZmZf
d29yZHMsIHNpemVfdCBsZW5fYnl0ZXMsIHUzMiAqYnVmKQ0KPj4gK3sNCj4+ICsgc2l6ZV90IGxl
bl93b3JkcyA9IGxlbl9ieXRlcyAvIHNpemVvZih1MzIpOw0KPj4gKyBzdHJ1Y3QgY3NfZHNwX2Nv
ZWZmX2N0bCAqY3RsOw0KPj4gKyBpbnQgaSwgcmV0Ow0KPj4gKw0KPj4gKyBjdGwgPSBjc19kc3Bf
Z2V0X2N0bChkc3AsIG5hbWUsIFdNRldfQURTUDJfWE0sIGFsZ29faWQpOw0KPj4gKyBpZiAoSVNf
RVJSX09SX05VTEwoY3RsKSkgew0KPj4gKyBkZXZfZXJyKGRzcC0+ZGV2LCAiRmFpbGVkIHRvIGZp
bmQgZncgY3RsICVzXG4iLCBuYW1lKTsNCj4+ICsgcmV0dXJuIC1FTk9FTlQ7DQo+PiArIH0NCj4+
ICsNCj4+ICsgcmV0ID0gY3NfZHNwX2NvZWZmX3JlYWRfY3RybChjdGwsIG9mZl93b3JkcywgYnVm
LCBsZW5fYnl0ZXMpOw0KPj4gKyBpZiAocmV0KSB7DQo+PiArIGRldl9lcnIoZHNwLT5kZXYsICJG
YWlsZWQgdG8gcmVhZCBmdyBjdGwgJXM6ICVkXG4iLCBuYW1lLCByZXQpOw0KPj4gKyByZXR1cm4g
cmV0Ow0KPj4gKyB9DQo+PiArDQo+PiArIGZvciAoaSA9IDA7IGkgPCBsZW5fd29yZHM7IGkrKykN
Cj4+ICsgYnVmW2ldID0gYmUzMl90b19jcHUoYnVmW2ldKTsNCj4+ICsNCj4+ICsgcmV0dXJuIDA7
DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgaW50IGNzNDBsMjZfZndfY3RsX3JlYWQo
c3RydWN0IGNzX2RzcCAqZHNwLCBjb25zdCBjaGFyICogY29uc3QgbmFtZSwNCj4+ICsgdW5zaWdu
ZWQgaW50IGFsZ29faWQsIHUzMiAqYnVmKQ0KPj4gK3sNCj4+ICsgcmV0dXJuIGNzNDBsMjZfZndf
Y3RsX3JlYWRfcmF3KGRzcCwgbmFtZSwgYWxnb19pZCwgMCwgc2l6ZW9mKHUzMiksIGJ1Zik7DQo+
PiArfQ0KPiANCj4gTm9uZSBvZiB0aGVzZSBmb3VyIGZ1bmN0aW9ucyBzZWVtIHBhcnRpY3VsYXJs
eSBzcGVjaWZpYyB0byBMMjY7IGlzIHRoZXJlIGFueQ0KPiByZWFzb24gdGhleSBkb24ndCBiZWxv
bmcgaW4gY3NfZHNwIG9yIHdtX2Fkc3A/IEluIGZhY3QsIHNvbWUgb2YgdGhlIGZ1bmN0aW9ucw0K
PiB0aHJvdWdob3V0IHRob3NlIGRyaXZlcnMgc2VlbSB0byBiZSBkb2luZyBzaW1pbGFyIHdvcmsu
DQo+IA0KPiBNYXliZSBvdXQgb2Ygc2NvcGUgZm9yIHRoaXMgcGFydGljdWxhciBzdWJtaXNzaW9u
LCBidXQgaXMgdGhlcmUgbm90IGFueSByb29tDQo+IGZvciByZS11c2UgaGVyZT8NCj4gDQpJIHdh
bnRlZCB0byBhdm9pZCBtYWtpbmcgdG9vIG1hbnkgY2hhbmdlcyB0byB0aGUgZmlybXdhcmUgZHJp
dmVycyBpbiB0aGlzIGluaXRpYWwgc3VibWlzc2lvbiwgYW5kIEkgdGhpbmsgSeKAmWQgbGlrZSB0
byBrZWVwIGl0IGFzLWlzIGZvciBub3csIGJ1dCBJIHRoaW5rIG1vdmluZyB0aGlzIGNvbWJpbmF0
aW9uIHRvIGNzX2RzcCBpcyB0aGUgcmlnaHQgbW92ZS4gTGV0IG1lIGtub3cgaWYgeW91IGZlZWwg
dGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbWFrZSB0aGUgY2hhbmdlIG5vdyByYXRoZXIgdGhh
biBsYXRlci4NCg0KPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAwOToyNzowOEFNICswMDAwLCBD
aGFybGVzIEtlZXBheCB3cm90ZToNCj4+IE9uIE1vbiwgQXByIDEwLCAyMDIzIGF0IDA3OjMxOjU2
UE0gLTA1MDAsIEplZmYgTGFCdW5keSB3cm90ZToNCj4+PiBPbiBNb24sIEFwciAxMCwgMjAyMyBh
dCAwODo1NjozNEFNICswMDAwLCBDaGFybGVzIEtlZXBheCB3cm90ZToNCj4+Pj4gT24gU2F0LCBB
cHIgMDgsIDIwMjMgYXQgMTA6NDQ6MzlQTSAtMDUwMCwgSmVmZiBMYUJ1bmR5IHdyb3RlOg0KPj4+
PiBJIHdvdWxkIGZhciByYXRoZXIgbm90IGhhdmUgZXZlcnkgc2luZ2xlIGF0dGVtcHQgdG8gY29t
bXVuaWNhdGUNCj4+Pj4gd2l0aCB0aGUgZGV2aWNlIHdyYXBwZWQgaW4gYSByZXRyeSBpZiB0aGUg
Y29tbXVuaWNhdGlvbiBmYWlsZWQNCj4+Pj4gaW5jYXNlIHRoZSBkZXZpY2UgaXMgaGliZXJuYXRp
bmcuIEl0IHNlZW1zIG11Y2ggY2xlYW5lciwgYW5kIGxlc3MNCj4+Pj4gbGlrZWx5IHRvIHJpc2sg
b2RkIGJlaGF2aW91ciwgdG8ga25vdyB3ZSBoYXZlIGJyb3VnaHQgdGhlIGRldmljZQ0KPj4+PiBv
dXQgb2YgaGliZXJuYXRpb24uDQo+PiANCj4+PiBBIGNvbW1vbiB3YXkgdG8gZGVhbCB3aXRoIHRo
aXMgaXMgdGhhdCBvZiBbMV0sIHdoZXJlIHRoZSBidXMgY2FsbHMNCj4+PiBhcmUgc2ltcGx5IHdy
YXBwZWQgd2l0aCBhbGwgcmV0cnkgbG9naWMgbGltaXRlZCB0byB0d28gcGxhY2VzIChyZWFkDQo+
Pj4gYW5kIHdyaXRlKS4gVGhlc2UgZnVuY3Rpb25zIGNvdWxkIGFsc28gcHJpbnQgdGhlIHJlZ2lz
dGVyIGFkZHJlc3MNCj4+PiBpbiBjYXNlIG9mIGZhaWx1cmUsIHNvbHZpbmcgdGhlIHByb2JsZW0g
b2YgaGF2aW5nIGRvemVucyBvZiBjdXN0b20NCj4+PiBlcnJvciBtZXNzYWdlcyB0aG9ydWdob3V0
IHRoZSBkcml2ZXIuDQo+PiANCj4+IEkgc3VzcGVjdCB0aGlzIHJlYWxseSBjb21lcyBkb3duIHRv
IGEgbWF0dGVyIG9mIHRhc3RlLCBidXQgbXkNCj4+IHRob3VnaHRzIHdvdWxkIGJlIHRoYXQgdGhl
IGNvZGUgaXMgc2hvcnRlciB0aGF0IHdheSwgYnV0IG5vdA0KPj4gbmVjZXNzYXJpbHkgc2ltcGxl
ci4gVGhpcyBmZWVscyBmYXIgbW9yZSBlcnJvciBwcm9uZSBhbmQgbGlrZWx5DQo+PiB0byBlbmNv
dW50ZXIgaXNzdWVzIHdoZXJlIHRoZSBkZXZpY2UgaGliZXJuYXRlcyBhdCBhIHRpbWUgc29tZW9u
ZQ0KPj4gaGFkbid0IHByb3Blcmx5IHRob3VnaHQgdGhyb3VnaC4gSSBhbSBmYXIgbW9yZSBjb21m
b3J0YWJsZSB3aXRoDQo+PiB0aGUgZGV2aWNlIGlzIGJsb2NrZWQgZnJvbSBoaWJlcm5hdGluZyB3
aGlsc3QgdGhlIGRyaXZlciBpcw0KPj4gYWN0aXZlbHkgZW5nYWdlZCB3aXRoIGl0IGFuZCBpdCBr
ZWVwcyBhbnkgc3BlY2lhbCBoYW5kbGluZyBmb3INCj4+IGV4aXRpbmcgaGliZXJuYXRlIGluIG9u
ZSBwbGFjZS4NCj4gDQo+IEZhaXIgZW5vdWdoLiBJIGRvIGNvbmNlZGUgdGhhdCBoYXZpbmcgdGhp
cyBjb250cm9sIGluIHRoZSBkcml2ZXIgYXMNCj4gb3Bwb3NlZCB0byBEU1AgRlcgaXMgbW9yZSBu
aW1ibGUgYW5kIG1ha2VzIGl0IGVhc2llciB0byByZXNwb25kIHRvDQo+IGN1c3RvbWVyIGlzc3Vl
czsgSSdtIHN1cmUgeW91ciBiYXR0bGUgc2NhcnMgd2lsbCBhZ3JlZSA6KQ0KDQpJIGNvbmN1ciB3
aXRoIENoYXJsZXMgaGVyZSwgYW5kIGl0IHNlZW1zIGxpa2UgeW914oCZcmUgYWxzbyBvayB3aXRo
IHRoaXMgc28gSSB3aWxsIGxlYXZlIGl0IGFzLWlzLg0KDQoNCj4+PiArc3RhdGljIGludCBjczQw
bDI2X2lycV91cGRhdGVfbWFzayhzdHJ1Y3QgY3M0MGwyNl9wcml2YXRlICpjczQwbDI2LCB1MzIg
cmVnLCB1MzIgdmFsLCB1MzIgYml0X21hc2spDQo+Pj4gK3sNCj4+PiArIHUzMiBlaW50X3JlZywg
Y3VyX21hc2ssIG5ld19tYXNrOw0KPj4+ICsgaW50IHJldDsNCj4+PiArDQo+Pj4gKyBpZiAocmVn
ID09IENTNDBMMjZfSVJRMV9NQVNLXzEpIHsNCj4+PiArIGVpbnRfcmVnID0gQ1M0MEwyNl9JUlEx
X0VJTlRfMTsNCj4+PiArIH0gZWxzZSBpZiAocmVnID09IENTNDBMMjZfSVJRMV9NQVNLXzIpIHsN
Cj4+PiArIGVpbnRfcmVnID0gQ1M0MEwyNl9JUlExX0VJTlRfMjsNCj4+PiArIH0gZWxzZSB7DQo+
Pj4gKyBkZXZfZXJyKGNzNDBsMjYtPmRldiwgIkludmFsaWQgSVJRIG1hc2sgcmVnOiAweCUwOFhc
biIsIHJlZyk7DQo+Pj4gKyByZXR1cm4gLUVJTlZBTDsNCj4+PiArIH0NCj4+PiArDQo+Pj4gKyBy
ZXQgPSByZWdtYXBfcmVhZChjczQwbDI2LT5yZWdtYXAsIHJlZywgJmN1cl9tYXNrKTsNCj4+PiAr
IGlmIChyZXQpIHsNCj4+PiArIGRldl9lcnIoY3M0MGwyNi0+ZGV2LCAiRmFpbGVkIHRvIGdldCBJ
UlEgbWFza1xuIik7DQo+PiANCj4+IEhhdmluZyBhIGN1c3RvbSBlcnJvciBtZXNzYWdlIGZvciBl
dmVyeSBwb3NzaWJsZSBmYWlsZWQgcmVnaXN0ZXIgcmVhZA0KPj4gZG9lcyBub3QgdWx0aW1hdGVs
eSBhaWQgaW4gZGVidWdnaW5nIGFuZCB1bm5lY2Vzc2FyaWx5IGdyb3dzIHRoZSBzaXplDQo+PiBv
ZiB0aGUgZHJpdmVyLg0KPj4gDQo+PiBJZiBhIHNwZWNpZmljIG1lc3NhZ2UgaXMgYWJzb2x1dGVs
eSBuZWNlc3NhcnksIHRoZW4gYWRkIHdyYXBwZXJzIGFyb3VuZA0KPj4gcmVnbWFwX3JlYWQvd3Jp
dGUgYW5kIHByaW50IHRoZSBmYWlsZWQgYWRkcmVzcy4gSG93ZXZlciwgdGhpcyBkb2VzIG5vdA0K
Pj4gc2VlbSBuZWNlc3NhcnkgZWl0aGVyLiBTaW1wbHkgcHJvcGFnYXRlIHRoZSBlcnJvciBjb2Rl
IGFsbCB0aGUgd2F5IHVwDQo+PiB0byB0aGUgY2FsbGVyLCB3aGV0aGVyIGl0IGlzIHByb2JlIG9y
IGEgc3lzZnMgYXR0cmlidXRlLg0KPj4gDQo+PiBTdGF0ZWQgYW5vdGhlciB3YXk6DQo+PiANCj4+
IGVycm9yID0gcmVnbWFwXy4uLiguLi4pOw0KPj4gaWYgKGVycm9yKQ0KPj4gcmV0dXJuIGVycm9y
Ow0KPj4gDQo+IA0KPiBOb3Qgc3VyZSBJIGZlZWwgc3VwZXIgc3Ryb25nbHkgb24gdGhpcyBvbmUs
IGJ1dCBJIGRvIGZpbmQgd2hlbg0KPiBkZWJ1Z2dpbmcgaXNzdWVzIG9uIGRyaXZlcnMgdGhhdCBk
byB0aGlzIHRoYXQgSSB1c3VhbGx5IGVuZCB1cA0KPiBhZGRpbmcgdGhlIHByaW50a3MgYmFjayBp
bi4NCg0KSSB3ZW50IGFoZWFkIGFuZCBpbXBsZW1lbnRlZCB0aGUgY2hhbmdlIEplZmYgc3VnZ2Vz
dGVkIGhlcmU7IGl0IGRvZXMgc3RyZWFtbGluZSB0aGUgZHJpdmVyIHRvIGEgZ29vZCBkZWdyZWUs
IGFuZCBJIHRoaW5rIGl04oCZcyB3b3J0aCBtYWtpbmcgdGhlIGFkanVzdG1lbnQuDQoNCj4+PiAr
c3RhdGljIGludCBjczQwbDI2X2RzcF9zdGF0ZV9nZXQoc3RydWN0IGNzNDBsMjZfcHJpdmF0ZSAq
Y3M0MGwyNiwgdTggKnN0YXRlKQ0KPj4+ICt7DQo+Pj4gKyBib29sIG11dGV4X2F2YWlsYWJsZSA9
ICFtdXRleF9pc19sb2NrZWQoJmNzNDBsMjYtPmRzcC5wd3JfbG9jayk7DQo+PiANCj4+IFRoaXMg
aXMgZGFuZ2Vyb3VzIGFuZCBhIHNpZ24gdGhhdCBsb2NrcyBhcmUgbm90IHByb3Blcmx5IG1hbmFn
ZWQuIFdoYXQgd291bGQNCj4+IGJlIGEgY2FzZSB3aGVyZSB5b3UgZG8gbm90IGtub3cgdGhlIHN0
YXRlIG9mIHRoZSBsb2NrIHVwb24gZW50ZXJpbmcgdGhpcyBmdW5jdGlvbj8NCj4+IElmIHlvdSBk
byBub3Qga25vdyB3aGV0aGVyIHRoZSBtdXRleCBpcyBsb2NrZWQgaW5zaWRlIHRoaXMgZnVuY3Rp
b24sIGl0IGlzIG5vdCB0aGUNCj4+IHByb3BlciBwbGFjZSB0byBncmFiIGl0Lg0KPj4gDQo+IA0K
PiBZZXMgSSB3aG9sZSBoZWFydGVkbHkgYWdyZWUgaGVyZSB0aGlzIHNob3VsZCBub3QgYmUgZG9u
ZSB0aGlzDQo+IHdheS4NCg0KSSBjZXJ0YWlubHkgdW5kZXJzdGFuZCB0aGUgY29uY2VybiBoZXJl
LCBidXQgSSB3YW50ZWQgdG8gcHJvdmlkZSBzb21lIGNvbnRleHQuIFNpbmNlIGNzNDBsMjZfZHNw
X3N0YXRlX2dldCgpIGlzIGNhbGxlZCBib3RoIGluIHRoZSBjc19kc3BfcHJlX3J1bigpIGNhbGxi
YWNrIGFzIHdlbGwgYXMgb3V0c2lkZSBvZiB0aGlzLCB0aGVyZSBhcmUgaW5zdGFuY2VzIHdoZXJl
IHB3cl9sb2NrIG5lZWRzIHRvIGJlIGdyYWJiZWQgYW5kIHRpbWVzIHdoZW4gaXQgaXMgYWxyZWFk
eSB0YWtlbiAoaW4gdGhlIGluc3RhbmNlIG9mIHRoZSBjYWxsYmFjayBpbnZvY2F0aW9uKS4gQmVj
YXVzZSBvZiB0aGlzLCBhdHRlbXB0aW5nIHRvIHRha2UgdGhlIGxvY2sgZHVyaW5nIHByZV9ydW4g
Y2F1c2VzIGEgZGVhZGxvY2suIEkgZmVsdCB0aGF0IGl0IHdhcyBxdWl0ZSBjbGVhciB3aGVuIHRo
ZSBsb2NrIHdvdWxkIGJlIGF2YWlsYWJsZSBhbmQgd2hlbiBpdCB3b3VsZG7igJl0IGJlIGFuZCB0
byBhdm9pZCB0aGUgZGVhZGxvY2ssIEkgY2hlY2tlZCB3aGV0aGVyIG9yIG5vdCB0aGUgbG9jayB3
YXMgYXZhaWxhYmxlLiBXaGF0IGRvIHnigJlhbGwgZmVlbCBpcyB0aGUgYmVzdCB3YXkgdG8gaGFu
ZGxlIHRoaXM/IFNvbWUgc2VwYXJhdGUgdmFyaWFibGUgdG8gZGV0ZXJtaW5lIGlmIHdlIGFyZSBp
biB0aGUgcHJlX3J1biBzZXF1ZW5jZSBvciBub3Q/IEEgc2VwYXJhdGUgZnVuY3Rpb24gZm9yIGRz
cF9zdGF0ZV9nZXQoKSBmb3Igd2hlbiBpdCBpcyBub3QgaW52b2tlZCBmcm9tIHRoZSBjYWxsYmFj
az8NCg0KPiANCj4+ICsNCj4+ICsgY3M0MGwyNl9wbV9ydW50aW1lX3RlYXJkb3duKGNzNDBsMjYp
Ow0KPj4gKw0KPj4gKyBpZiAoY3M0MGwyNi0+ZHNwLnJ1bm5pbmcpDQo+PiArIGNzX2RzcF9zdG9w
KCZjczQwbDI2LT5kc3ApOw0KPj4gKyBpZiAoY3M0MGwyNi0+ZHNwLmJvb3RlZCkNCj4+ICsgY3Nf
ZHNwX3Bvd2VyX2Rvd24oJmNzNDBsMjYtPmRzcCk7DQo+PiArIGlmICgmY3M0MGwyNi0+ZHNwKQ0K
Pj4gKyBjc19kc3BfcmVtb3ZlKCZjczQwbDI2LT5kc3ApOw0KPj4gKw0KPj4gKyBpZiAoY3M0MGwy
Ni0+dmliZV93b3JrcXVldWUpIHsNCj4+ICsgY2FuY2VsX3dvcmtfc3luYygmY3M0MGwyNi0+ZXJh
c2Vfd29yayk7DQo+PiArIGNhbmNlbF93b3JrX3N5bmMoJmNzNDBsMjYtPnNldF9nYWluX3dvcmsp
Ow0KPj4gKyBjYW5jZWxfd29ya19zeW5jKCZjczQwbDI2LT51cGxvYWRfd29yayk7DQo+PiArIGNh
bmNlbF93b3JrX3N5bmMoJmNzNDBsMjYtPnZpYmVfc3RhcnRfd29yayk7DQo+PiArIGNhbmNlbF93
b3JrX3N5bmMoJmNzNDBsMjYtPnZpYmVfc3RvcF93b3JrKTsNCj4+ICsgZGVzdHJveV93b3JrcXVl
dWUoY3M0MGwyNi0+dmliZV93b3JrcXVldWUpOw0KPj4gKyB9DQo+PiArDQo+PiArIG11dGV4X2Rl
c3Ryb3koJmNzNDBsMjYtPmxvY2spOw0KPiANCj4gVGhpcyB1bHRpbWF0ZWx5IGRvZXMgbm90aGlu
Zy4NCg0KQ291bGQgeW91IHBsZWFzZSBjbGFyaWZ5IGEgYml0IHdoYXQgeW91IG1lYW4gaGVyZT8g
RG9lcyB0aGUgbXV0ZXggbm90IG5lZWQgdG8gYmUgZGVzdHJveWVkIGV4cGxpY2l0bHk/IFdoYXQg
YWJvdXQgdGhlIHdvcmsgcXVldWU/IElzIGl0IGNhbmNlbGVkL2Rlc3Ryb3llZCBhdXRvbWF0aWNh
bGx5IHdoZW4gdGhlIG1vZHVsZSBpcyByZW1vdmVkPyBBcmUgdGhlIGNzX2RzcCBmdW5jdGlvbnMg
bm90IG5lY2Vzc2FyeSB0byBncmFjZWZ1bGx5IHN0b3AgdGhlIERTUCBldGMuPw0KDQpJbiB2MiBv
ZiB0aGlzIHBhdGNoLCBJIHBsYW4gdG8gaW1wbGVtZW50IGFsbCBvZiB0aGUgc3VnZ2VzdGlvbnMg
aW4geW91ciBjb21tZW50cyB0aGF0IEkgZGlkbuKAmXQgcXVlc3Rpb24gb3IgZGlzYWdyZWUgd2l0
aCBoZXJlLiBUaGFua3MgZm9yIHlvdXIgaW4tZGVwdGggYW5hbHlzaXMuDQoNCkJlc3QgcmVnYXJk
cywNCkZyZWQNCg0KDQo=
