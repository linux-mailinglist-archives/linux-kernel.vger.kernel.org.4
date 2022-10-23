Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8E609757
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJWXjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJWXjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:39:16 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2079.outbound.protection.outlook.com [40.107.114.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799D65027
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsrO1egGz3G38J/Iq1TrMRkWbCeMAoq6JKaFpTRg+YFDS7wXRXz0arC1qiHC2RLadTNIU1EzWMzkBSWqCOiGVyZ0ralhyHLYeS+shVb5jtNhTEnVmkDVovlrQtkvJNI4cdBfmYOBfa6Qqk6RH8roWHHUJ9ft/B767CYh5GsXhx2rDAsdBSDKkL2GnqxZSHnu35gVaWjC7HDsS5gmbeO/ESBBgG6W5MVLOC/3BwUj6VoRUZCFfKetT0l0ZjQsInVviqQceElylFAb0i9Eaezw3QBNeBB8YUCsO5OEvM1OdF/yWeVrhHwK1eYqOXrhjDoj0K5IEqaKm7D9iZkGL9BEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnRO+u9ddNsfJ5OK2jo8stiq8S3D3vyVBu8cCPh2SfM=;
 b=m8KjrNhJ/KufBmW4dQ8ciUfuHKRjMOV4kCcy9cm882pB9Z+/C2pWnoFV/eokW0ezvqlxuBF5wt1gz75lhg+ISRgLXK5J8SruWj6MEWnoKk5HloL8tPvYvuVnLKUQGaW94MHiKC24SWeAKBhCHruEhr/RGkx1zrvaLajWFLebtriGCbzPfosI3BGy/imU+xwh99hGXUXjqPl+V6JX+OKe8xoNLC0uxJsBZ78GqKlRS0TzUx3ItY2XsjTOu7jAhxWkgUL3xl22EwVmf4ez3Zp41qtHlKFyVP3CEybnzIvXK8BbSHtDFeNN5rDhCoeYbRIEoF3AMJRuEWQ9JyR7cDkwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnRO+u9ddNsfJ5OK2jo8stiq8S3D3vyVBu8cCPh2SfM=;
 b=S2FpuziN0xc/s48gFzN6J1liXgra+E+TVm0joWJp5dYh7bQ/Rt35rEB0+aiEJH0rULNoiQKt+uloAajRImH5UZFa3iKVpMznNwCdhomVi/2E8irYmfZUE9ml/ojZ32TAtOv4closlArUQ+vARpH/G4BbN94SVP7d0ljnBEh0gqA=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYVPR01MB10815.jpnprd01.prod.outlook.com (2603:1096:400:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sun, 23 Oct
 2022 23:39:14 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%9]) with mapi id 15.20.5746.025; Sun, 23 Oct 2022
 23:39:14 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm: memory-failure: avoid pfn_valid() twice in
 soft_offline_page()
Thread-Topic: [PATCH 2/3] mm: memory-failure: avoid pfn_valid() twice in
 soft_offline_page()
Thread-Index: AQHY5SbywzQfaUx2YUuSU7SOzvCE7K4cpwKA
Date:   Sun, 23 Oct 2022 23:39:14 +0000
Message-ID: <20221023233913.GB4024629@hori.linux.bs1.fc.nec.co.jp>
References: <20221021084611.53765-1-wangkefeng.wang@huawei.com>
 <20221021084611.53765-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20221021084611.53765-2-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYVPR01MB10815:EE_
x-ms-office365-filtering-correlation-id: b2d4b9f2-2c88-4645-0365-08dab54fcb25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SaEuUThp0eyVa9KPGPjEH74sINf1FiFdfKamdsuDHvxQV1r3lkNUFrY2JzU+dDipnfLrPUU+U+Me4/IlNMu5rtpm5ePmumNovYBIoAdlQCHJ6FvVDH+3vAuTuBD/GDAmQVfwYML150rK2gN7mSSblGrwE5Xm8fxWZ/5wAcBaxJvS7rt2ySo9tBhVvewJ62puOGyNfE4OOwVMFcfdpTnK1wxAvEbrcOjP++VnEQ12Z6oqYlZ5qf3UQdsxM8pHwssvGeUqZbXxbBunQSlBBmmwmajhMA9cEpryk0ksd6moLIxrCMw36e3z9RLBrS/Ha7bq6s4A+nuzqbQcQHX6jyMd/6qt3X3ViNrL4WRiDAUQTXv4eJQ8HbsGvjgyqZbu7/BIPDZKxp/D0Y+HvBOULoagpFZmJdElYtMsy5b6jv17IMx7YdoRSfnC+KlwdIB4U0sgNtuh+pw56FQQQObUvvqN5WRmC7xlduSRQjzeWnRpq7N2FbzWP6zIOYNr8tmarcBSq2QFnhdSz36j3Ky9c+unLpk+dAaLs1IOg3JuHCQy8XBRmZdzsyywj7tI6MsMXKOEGUaJUJ14txJq1YbeONnyDkk9gFnrr9MuC0gSYUtrNM/dmxb0tBhi/LFrY1hLDyjVLEDd8RuhBAIIYq8Rks2wh5d5cUuQOI5Fq/dTobSdPgut2doPGEkMi9AfOAlkj76Ed4ZYzsHNPFmkS0fIOT1soNpaYnEtpWUV349nAS7Gf3YYHCBUo9E3Xno+u7jgy7yiAs7N7MPWPHWGWHMHSBoqyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(85182001)(2906002)(1076003)(6916009)(54906003)(66946007)(6506007)(316002)(41300700001)(33656002)(76116006)(8936002)(66476007)(66556008)(558084003)(6486002)(8676002)(86362001)(5660300002)(4326008)(66446008)(64756008)(38070700005)(82960400001)(71200400001)(26005)(478600001)(38100700002)(122000001)(186003)(6512007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3ZqNm5JMGFXYUZ1dXRPSmFoY2ROenFBMU9HN3hsMXlDcTFzTzZGK3VDbTVT?=
 =?utf-8?B?cEhnU3lxbVd3TVQzdWUxL2s2cDgwc3Fja3RoNnZxQW1TWmhIZ095WkVSbWlK?=
 =?utf-8?B?V2tOeDVlaVNpTnVVL21FbkI0TG5PLzlramVjNFM2RitJZm5JZSt5TjRtS2FV?=
 =?utf-8?B?ZXNNSkVYUDlzaXdJR3AwWnZma2M2QzNsWlk5ZWt3M0tWenBRNHpNSlNEVzBm?=
 =?utf-8?B?eHlRSjdvNnNFSmFjTm1PY3ZtRlZNcDExaEpCTFpWK0FZc0x5aDBxL2FzaCs0?=
 =?utf-8?B?NVZQY2FWb2RLRDZJZzhyeHVRWEg2SWZFYTBVZXJ6OHI0QXM2SHZzTDl3aEdp?=
 =?utf-8?B?ejcwbTZnYUFpaGxHNGVWWnJ6bVZobWpuRkxHZGtsNGlvVW1iSkJSM0VFaHR4?=
 =?utf-8?B?dERjNG5FQ2dIZytLSy9wZUEvblJNOHFpSGhVSm5HZ3ZQOWltTWFrL0IwMVA2?=
 =?utf-8?B?eXBnSmtLQktmamVWVUJiSVRIZDByTEZKNmxpYmtLRGF3K01wTEZRY3ZPWEJ5?=
 =?utf-8?B?Mndray9RdGM5bTUzeXUzUHQzK3dnay9qbGtYT3VwN1ZwZ0pTTnB4WmxWYmlB?=
 =?utf-8?B?S3QrbnNzK1dRRFZybzRXcWVTUnpxMkVPaDBOemRsN1hGVHpWQVFIZFNld0Jz?=
 =?utf-8?B?U0VTVzczSy81RzU3Y3FDdjNDNHR3alNOeXhhQXdDWDBKVkx3N2ZtOG90UVdv?=
 =?utf-8?B?TTYycjROVUh6U3ZXQ0tCaHEwM0xzd3NYWTBHLzAybC9WdlFzOUNHTTNsemJh?=
 =?utf-8?B?ZkFlQVJycE1lTEtwUitmbk5aUFJvZDJLV1F4L0JNSXNFSTlFTGE0NFNWTUJ2?=
 =?utf-8?B?b2E1TVVkRVRNVDRsTitRNzZkdDJ2Zy8xRGhGRFg2UysyaERFcXd3MUJxcmVn?=
 =?utf-8?B?RGNOYXJSYlpZMHNDbmNKWEVOK2V5Y2VPQ05vN2NIMEpwL0FNNXBKSk4rY3hv?=
 =?utf-8?B?TjZKQys4Q01yVDFVKzE5RmNVYlVXT2pYdWNPMVlNR0NzQWJBajdIR1E2V3hs?=
 =?utf-8?B?U0xPaDdQSEJLZnBVZUI1bG9DaXM1TTdqc3lqRHoxRktFejFNalVEaklUdndp?=
 =?utf-8?B?ZHhHbTU0eithWElMaHE1clFMaHZZOVVDVlovVkxvMkVKdlNyUTU4Yk4yK1A1?=
 =?utf-8?B?U3FRTTFJWGJWUlFrc01WRWZrWjRXZSswU0dvaDlobW9rRVRpUjBDWHlpcTkx?=
 =?utf-8?B?azRXNkRBc2hiSWpNZ3dzVldoa2xHblNiNkt3dm9ySEpYdHRnMDJuaExyWXh5?=
 =?utf-8?B?VGZkb0FGUDBBRE1mOGFmWkRTc3I2SG5WT0xNbm1mbHZ6VnBONjMxcnRLRnZR?=
 =?utf-8?B?MWNsV1hwcUoxQnBmSVROKzlNd3ZMeU9FcjhpbHBQOHpIQ3dWS3VSSE1PNUpw?=
 =?utf-8?B?N3J0bytrUk9XbW1Za2F1Mk5YRUR2L1FOMXZOd2UxcENramtUMjkrMGYxeTBS?=
 =?utf-8?B?UEVmQUNxUWV4R0VUNytyZEVMZ1BiaHYrdnZqbUZIZldSRlNDR2JkTGlBaWt3?=
 =?utf-8?B?Y29hVS9qOG5yY3pJMGo1VXcwdGVyRHI2c3B0REVnNW1lYkNpdkFLeWVENjZu?=
 =?utf-8?B?T3lCZGk4Z01qM0JUWVlXZWN0MUZNRERwM3pOd21mYjNMNTBzS2xEVGlGcUdP?=
 =?utf-8?B?MXJRRlIzRGtNWWdkU2dSTWsrQzBmaVVaSE5xQmdXbUdNbDlnMVBMYVlqWVpz?=
 =?utf-8?B?NU5zcTJVaGdPaWZlWmJsWHF5ZjVwUVhEWW9TS1QxOVcxWEQxbXlXVnhkTUN1?=
 =?utf-8?B?TkhGNWxSeDdoYzIwSC92OUZlcmVZNXA0Q1QzYU85ODk1bDJsejFPSFBmaFdC?=
 =?utf-8?B?bHVPbFlnb1B0UGh6eEJZR3N5YUxPUUNtWmR0RVAzUExteTVsOWRHWTY5NXM0?=
 =?utf-8?B?ajhScEV0NmZHLzhIVDR5N1hPMkFhZnVRcmxEazJDK0ZESlR1VlJnaFJteG0w?=
 =?utf-8?B?bUZERWV5QTdaWTNjVU5LTVd6K3QvNTlQTGtKQmZicGZ0SW4xbnp0NHRvVUtN?=
 =?utf-8?B?SXRSVGtzTkhBNDJlQWZSL2FIdkd3aTRFSXNYVjBNbENHZjNFMXVwWGZrNi9t?=
 =?utf-8?B?VlJIU2JJblpLV0JmbmJ0Z3E4VmFsNFlreTdKME00Y1hGU2JDdWJvMHFQQ3ps?=
 =?utf-8?B?RitFcjFTQ3FENG5BV0c2eWhSWFVmMTRYaGx2Z09QVjlPOUNWQU9udnhsMGww?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B231350B22EEE419F8427CA9406D7CA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d4b9f2-2c88-4645-0365-08dab54fcb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 23:39:14.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8EKsDMAoNOYzH/sW1rH7pdChW7mjy5Esn/EfgCEvn3Vb1pVaHwTMSVCuWcjTFC+QjocEmy0qKUxczb03tm35w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMjEsIDIwMjIgYXQgMDQ6NDY6MTBQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFNpbXBsaWZ5IFdBUk5fT05fT05DRShmbGFncyAmIE1GX0NPVU5UX0lOQ1JFQVNFRCkg
dW5kZXIgIXBmbl92YWxpZCgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VmZW5nIFdhbmcgPHdh
bmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxu
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
