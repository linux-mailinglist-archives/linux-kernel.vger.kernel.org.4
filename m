Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427116B3A36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCJJTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCJJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:19:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD6572BC;
        Fri, 10 Mar 2023 01:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678439709; x=1709975709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XoaZ4aO2Rxz/z4PPgcvUJjKxA2L97LqNjmOAYyP/NdI=;
  b=Z2vbL74x6uMmG9IfT7B/S2q8Oq8+wik64paHZfm8ICMpZ0CsfiTiFBj9
   ojvfU9GXX2naPyM8rL480oBMEuyMiVOSGORIHeXEHRwMVqDm926PZvyT6
   HdHaiVXB6mCP56BWXFVC6yWJGFxTj+FH99LGltgxtl+PI2CO1tmhl8Dqx
   ScHEJDxd3cZpDbyR0b0GZ+dTE24v0kZzQohToc8xEjbBumFuivvGSR9A0
   waBuxcRFFhoNXDcLJaUqeDtnunHwZOMP1xYJ4e8todT+eAG+f3Z0HtO0z
   3TIjLV3c2AmDLkaqJAV5WKGUMedMywIrR1k5TblSuY8P32QTS9iqYiaxx
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673938800"; 
   d="scan'208";a="215684271"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2023 02:14:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Mar 2023 02:14:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Mar 2023 02:14:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWYU+ZMF3GmNVLbFCpEcBi7E03zZV8+cClY0YulIPfhwetv3Ofbaj1+kCKqWPX7CX5RlfTNeOygYX3Jzesl9h/xoht/qZVLVGZnq+TtakmD9p4IM5tvAzc6sr29WbNEaztPSGOiOUd8U2H35FM7VpvEK5/2Sl05dGy6iLFH7+lpAzwZg4Qg6d/zU7c6ZnOp2RtH6Zi/8AjwW1ye7xUIXwCVIZ1NEuhtWLhnH6CMkKoxzxXxrWj2yyccNb++2yDwq9hrHJ7jVppxkEQwO6uS9hYN9JJhwm5Qi5Tgc0m4DjpqmT5LzQ5/8wCpKDgG/yCfOF0OENo7HACzd3uBtcXbpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoaZ4aO2Rxz/z4PPgcvUJjKxA2L97LqNjmOAYyP/NdI=;
 b=VGGdn7R3He78+jj+oamKUEInkbbNhS/pj2HHTsSM9L4mlP4XDXeM6xPUPa0MrnjArOL1QOH2yKaIs6c8xAZyLXkShz61v/E4kmrDV6gfPBL1b8ohe0onm1Sav0FfM27TbmvLJuWxVgFVXtS8AMIEMGZTjHq0e2FPW251FuEhMguYGeKTveo40AFfSTCDAWvm01aCHy1nlBhtD8wqKGqe8ct7WPN5/7+2siRPUJQsA4TAdI8WDJqWYTY2rzRgCs7PBB4+7PmxWB1bUarkWMmwNAecmNKNcdOL9hvH+V/oga65Dn3/YZJ5M6d+Ow6rNPYv4tOW3vGwJZu3wqcotR4oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoaZ4aO2Rxz/z4PPgcvUJjKxA2L97LqNjmOAYyP/NdI=;
 b=IOYpvgwGWR8369f6uF8bsAe7d0SatTRyRCifC44WNdz3I4k167kUnXwtRRsfqVtwcQWQ7kI3QkzaaSY+bwMsbIOO1/Ao9b7bz8/gyGa3SNghWXrshUk8CrHYCg0s27i2yPijVD5fDl/I3ulpfbz/lK28eNlpTpK9dAH2jt4VTrI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:14:57 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 09:14:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <chengziqiu@hust.edu.cn>, <eugen.hristev@collabora.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <dzm91@hust.edu.cn>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: remove dead code in at91_adc_probe
Thread-Topic: [PATCH] drivers: iio: remove dead code in at91_adc_probe
Thread-Index: AQHZUzDILSzB7cTC0E+juALPPXDwjA==
Date:   Fri, 10 Mar 2023 09:14:56 +0000
Message-ID: <cc97cfe5-e90a-d901-147a-2bb829a4409d@microchip.com>
References: <20230309150502.400312-1-chengziqiu@hust.edu.cn>
In-Reply-To: <20230309150502.400312-1-chengziqiu@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SJ0PR11MB4830:EE_
x-ms-office365-filtering-correlation-id: e9a7565c-1d97-4eaf-2eed-08db2147eab6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6f8s5QxhLZmGlyv0JVc/0wJA7w2vqTik6dfIjxjeVmE9uZmYhjNOffIbOKt+ym4+xBqvYmg0eeFvbenRueTCcMEuI71nqWnsKjHULVf0jTnt1KSPmCCFRH0EM0oB//6dwjVaev8Ba8mVF1Eq/1wRQ52J9NpYzt2rfv+ObvJyfpTs5I+2Mg8mFU4hrIjEYLidf8JzBM20xHqoKMeDmgnkFQqDpgDrP8zZHMeDHkD7oiQNig7qole5jh2Eu3vXzn4HewxzgcJj3L+EpYABjE2f/rgZoqT+j1cqaWB9ZSUAiiqJIxqi/GMiENuIwFsEWqZFqZHN19and1klaVdCLz+3GRQGlTLBJlgJKJmkLHEi2+LvzqKPlseRIgiQ9BtLL2g/H8ggRo1/cMISo1MeuNIWLgEaHK5cqiNGFXm7tbXw+Jy9Kpy0As+lKYWdDoNnbVBbFq6w1Gy/h8n080udLA5RdO5xKywpWlNMt8/1Vyet4L7dea8f+WdhdBhM076M+9M0hzI07KuY9TbG8NcHoQZpzR2Sldqluw4gbus8XeMf/ewx4iPRqgr0CiwNcf8fmSubJnu8Ycop07z/SK6FiXlLa+fq5AwHz9QF3MLF1FVZITPTfnuJBZYwxQzo4nBs9ZZ+TSsYzLuTUyeZvFI0pCWTEBeeA2cn9T25/doSTTK6Dflvu0TwZB2rXkbQ/bGLAWD7gI3DsfvV0YHAeLqxsIKvuUAAx/8M/LM7XJc21nxBQ97vndG0i4hptpm0hOC6CSmEp4QZdTTtxbsUx9Zxy1DzFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(36756003)(83380400001)(6506007)(6512007)(53546011)(26005)(186003)(6486002)(2616005)(91956017)(86362001)(66556008)(8936002)(76116006)(41300700001)(66476007)(64756008)(66946007)(8676002)(31696002)(2906002)(4326008)(5660300002)(66446008)(38070700005)(122000001)(478600001)(71200400001)(316002)(38100700002)(110136005)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUVNMjVHZzdGcXNORytrSnlZU3piYzBNVi9iWmkwbGtuakdMNC95Z1RJZjJH?=
 =?utf-8?B?TFQvQ2hSb0RWVVVRVkdQeVJZcjN2ME1UdWlpdmhaN0ZFVGx5NFlXZzVFSnB5?=
 =?utf-8?B?SnhFRElCaG9yd1NiaW5HODdOUERGdkhmWm53cUhXQ0lGNVJDanJnMlBJSnNP?=
 =?utf-8?B?MmJNWEJJQ2dBaEJEWGlRbTNRdnZYUHF1bGI0UGlHU2U2NHY3Mk4vNXEyVzZ6?=
 =?utf-8?B?YUl6NTVzVzdZR3NGNGxoWXRKVUxBVVFyYUdYYTFlc3BZQXZYRVVGWk1SYTRu?=
 =?utf-8?B?cldRaDlzRGNnNTlxSWxpb202K253eDVrVyttMkc4ZUYvNVlySTNoRTQybVNm?=
 =?utf-8?B?NHp3TXR3ZFlaY05qTWR4MkovS2FaUVJoVjVkallIQkl6ajF3S0hvaVVRNXhT?=
 =?utf-8?B?Ykg2MHBTdHlVRURaanY4S084S2NqTFpxSHpCQ1JlM25odW9DSFcxcXNZalB2?=
 =?utf-8?B?WERLWWFtMWlJRTJPNGxoL1lGM0Y3QzlkSk00Y2dDVk5SZ2hlVC9EWVJnSzBy?=
 =?utf-8?B?cFU4ek5iemJ0OFhuSy9PR05tRjFTRFpBRFN4WFEzRE9UQmVLK28yYWZtVVVD?=
 =?utf-8?B?b2Q2OFNVMjVuQzhaUGZKdm1CMnVVTzZxeHJ4SkhhS3haWWJkMmptVCsvVWUr?=
 =?utf-8?B?dTZQVEZ6SWtkRkZvV2I3ZkMzR3FiQlFLYll5bTZDZ3lyempXdnduY1JEcU9S?=
 =?utf-8?B?RVY0UnR5UW45aDZpYUo5ZkRxWnFOOFNjQldscmxrUTZzOWgrM2NSUUVNUlZu?=
 =?utf-8?B?Y1ZuR0xKNHNXbzkxNjhlZTVMRTZDdGZSblQweXhEdENSYnp2Ri9HbVJVb2Jx?=
 =?utf-8?B?YXF2a2VsVkZyRmNJc1YxWHBqV3czRkNBck9IY0hCSGtQY0Q4NG5yb2VwbVM2?=
 =?utf-8?B?ZzRKaEljV1kvK0pwTnhydFptUkdnZ0pJczhUSEs4QmF2WGZaaWFtdTZKTE5V?=
 =?utf-8?B?WEZDV0hPcENsc3dBaWxMc29aQlVlZTE5YUZwWkZNa3VoQmw5ejZZZVpwbEJE?=
 =?utf-8?B?MGRSTFRhZFVzNnRFc1FGWDYyUlllL3RNWnpZOGNtanV5TmM4UVNtaW9wSXFP?=
 =?utf-8?B?M2taY0haYmFJcGpzRDZ6WnFIdnJwbHppTmF3WWNySXhpZTByZGk4amZ6d3JK?=
 =?utf-8?B?R201Q0s4UVZVNHpZVzdjbzY0c054SGF6cklsUG5CYkNJUkZOWDBWc0hOWnRv?=
 =?utf-8?B?c1c3Sk1OREJlOVB4dkd2V2w2SGo5d2w5UFFES05LdjBIcnRpZ0t3dTJMR091?=
 =?utf-8?B?VUdRbS93Z09RdFJENnJmTGp6MjlQRDlrNmU0dFVHbUdzVnRkY201d3hjMXh0?=
 =?utf-8?B?VHdLZ2c2Q09iYmhmR1pSR0RNVVRWS0hwQzgvZFRqeW5ZOEdrV0E5Skc1WXpP?=
 =?utf-8?B?MXBTRWRnaWc5eHhNTHRiYTZBaWFrUkEwdGkvMDcvOUVEMEVSZlM3M0pwWnVP?=
 =?utf-8?B?Nnk3VjFyNGFQcHVuWmVkeXREcFVUek52VXpxSkQ2L1hTOC9vQ3lVZFg5UDRV?=
 =?utf-8?B?blRZV0h0QStGc0ZWQmRyblRZQ0dkSlNHbVp6MDZ4aWorTzlsV3JuOFBwcjNk?=
 =?utf-8?B?YndlQmhCWFJTZTMyb2phdThCK2VGTUg4QlVLdDl6dFJESk53TmQvSVU3Y3Zh?=
 =?utf-8?B?OEFxNE9jRVJzV2EvSnFrazA5RjdaVnpNR0JmYzRvM3RXMjR0SUdMYmt6dmJG?=
 =?utf-8?B?QmUyQmN3S0ZxSXZINEVSbDZZTzdMclMrNWp6VjVyQWY2YzE5UlVjRzFRRXlN?=
 =?utf-8?B?c0FoWjJ3bjIzR1lCVS9DSEZyeitCcmYwdjltRnhiRGJzbkRrS1VjM3dBYk9K?=
 =?utf-8?B?VXJESXVpZUs3VEtSZTNOdVNNYkZsb2FGM1VwaUZucGM2SmhyTlpDMDZGdlZR?=
 =?utf-8?B?ck1FZHBTM1NpK0U4OWpSNEZDdWN6S3hUSEpvbzJEcTZXbWJ2VTZ2Z1ErbElR?=
 =?utf-8?B?M0QvT2tmdFhidFRRakUvc2FBejZkZEJEcUhJTTRybWl6emQyTWNBZmQ2dVhD?=
 =?utf-8?B?d2J1K1VHNFJYcG5QM3huYWV3czhDYUhMNUxOMzNTTS95WkdHemRTVmZSRzUz?=
 =?utf-8?B?QzVnV2ZmU3U0RjlOSlRVVTFTbFFrbjIvWUllVlVRem9JeEpqWkozSjM1SGZS?=
 =?utf-8?B?S3ZEOE1sbU1BR3orRkJIVlFYWHd3QU4rSzF5QThMNU40cWhhbEJjbnhkTmpZ?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98FAB22AEE79344FA0C397B27BB7E5AC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a7565c-1d97-4eaf-2eed-08db2147eab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 09:14:56.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vXc8QmqoOITheKgsXOC3Chxnd2Hr+zGEVDEuvtIESjkvxP1OcUAXtfOGxap+7A80IubB4Sk6v+CiQz6K7stsTu99oAxz/9isdImHn3Uxa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDMuMjAyMyAxNzowNSwgQ2hlbmcgWmlxaXUgd3JvdGU6DQo+PkZyb20gdGhlIGNvbW1l
bnQgb2YgcGxhdGZvcm1fZ2V0X2lycSwgaXQgb25seSByZXR1cm5zIG5vbi16ZXJvIElSUQ0KPiBu
dW1iZXIgYW5kIG5lZ2F0aXZlIGVycm9yIG51bWJlciwgb3RoZXIgdGhhbiB6ZXJvLg0KPiANCj4g
Rml4IHRoaXMgYnkgcmVtb3ZpbmcgdGhlIGlmIGNvbmRpdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENoZW5nIFppcWl1IDxjaGVuZ3ppcWl1QGh1c3QuZWR1LmNuPg0KDQpJIHNlZSBGcm9tIGFu
ZCAxc3QgU29CIG1hdGNoZXMgYnV0DQoNCj4gU2lnbmVkLW9mZi1ieTogRG9uZ2xpYW5nIE11IDxk
em05MUBodXN0LmVkdS5jbj4NCg0KdGhpcyBTb0Igc2VlbXMgZXh0cmEuIFdoYXQgaXMgdGhlIGNv
bnRyaWJ1dGlvbiBvZiBEb25nbGlhbmcgTXUgdG8gdGhpcyBwYXRjaD8NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgfCA2ICstLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvYXQ5
MS1zYW1hNWQyX2FkYy5jDQo+IGluZGV4IDUwZDAyZTVmYzZmYy4uMTY4Mzk5MDkyNTkwIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+ICsrKyBiL2Ry
aXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4gQEAgLTI0MDAsMTIgKzI0MDAsOCBA
QCBzdGF0aWMgaW50IGF0OTFfYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICAgICAgICAgc3QtPmRtYV9zdC5waHlzX2FkZHIgPSByZXMtPnN0YXJ0Ow0KPiANCj4gICAg
ICAgICBzdC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gLSAgICAgICBpZiAo
c3QtPmlycSA8PSAwKSB7DQo+IC0gICAgICAgICAgICAgICBpZiAoIXN0LT5pcnEpDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIHN0LT5pcnEgPSAtRU5YSU87DQo+IC0NCj4gKyAgICAgICBpZiAo
c3QtPmlycSA8IDApDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gc3QtPmlycTsNCj4gLSAgICAg
ICB9DQo+IA0KPiAgICAgICAgIHN0LT5wZXJfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYs
ICJhZGNfY2xrIik7DQo+ICAgICAgICAgaWYgKElTX0VSUihzdC0+cGVyX2NsaykpDQo+IC0tDQo+
IDIuMzQuMQ0KPiANCg0K
