Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4306B3B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCJJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCJJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:55:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5385107D42;
        Fri, 10 Mar 2023 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678442114; x=1709978114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w/S+zxliBMK39kx/8AWzHlWZd45W3FjKQaay/3igQKM=;
  b=zzjtQ8ZHHL32hL9bqMbanQvQ0DJKhuKf2KBj3/cITTAv2+Rj1YkVARk9
   7XSnOonqnq+mPuRRjPE1dIvG84l6V3KEBAH44iO4Iz9yHrAnaWP3+3NMY
   PcYx65EY5grIQG4p6JrepJZ0/KMYofM8RXpElaCfn8G/F1eY3OvRd0iWw
   /j7KfYPYJBwVogMB/c1zmmA/Z33fDY/gUJZsIlZyQYYSJrWjQqQIZRiPP
   TgqDvOrC97aFtQOXRJ9SQNFqKZVCvEbnbT0RNCHlwzr//tbnFt/9YF02m
   RLAEKHtzwOhuHATPWlf5bhCen9B2vb4nQtPqVqxVP7/iyli6UtISoafhE
   w==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673938800"; 
   d="scan'208";a="141348111"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2023 02:55:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Mar 2023 02:55:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Mar 2023 02:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKaigOCwpfGNcHt//N5IVGbZLuRnGqzWdCX9Z+Dz5Qm5RYUITvn6IUalHK4hmCDs5SI2F2WOm2UIViJmTuz1uNNhpyVRdH+D66AQ7o1ebebQZR3bGSOude8QhBR+6lUb3Txyq82h+g0scyrhAyF3Hn5n5D5sociDlcz0F+JaVKV6R+hnzVx7m6Hevmzjw0JCEKSfVZsq2Z/GdmD30qfmH06P1mqeJCZi4w8TdgV1AeOae/Ybq6CRxwBs5BDn0AA1yWBrefIF5sdUI4Dk93K08iHKHZA5HgPy0LlAKdcP5i2HRJIZATmTx75lLeSigVVkvzu2unpaPixKIv36q3vTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/S+zxliBMK39kx/8AWzHlWZd45W3FjKQaay/3igQKM=;
 b=Gquw8punr+gs9l/ZUhZsraqzia/loNWhn0P8quaQ2N/UylsL+dQyNhH24vwFGKkIkEopj6Mj1P7TsaZ6z614a+7l6uMb8OMX05L77SSNPNWPrvPh6IIr6HpOCxAI5bFeQI+KBDzZAXPQH33zyn8LX5jbRx4XyeChWo9gvNDvI+fubkwTN0EAnm2JcQ4seg+1EldCUs4hQ2XKLQlHajKqxfufro84aKKAMJYpQVesXzbqoakTZUmF62Tt+B0WqVVb5fsB0DbVLgWmrQq5QDQxNjjFic9bMrIr94FdTEcR6PEHgn4/IHonKGVJHBE40MrEtGnMaT8gtsnyzY3+vLL1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/S+zxliBMK39kx/8AWzHlWZd45W3FjKQaay/3igQKM=;
 b=qQmTXY99L95xdBwCJ7vZ4Iaj22m32ixB3uw/k1PmCrEbS0mc70wW8Q1mKLH4OzrfuA04R2wrmdhR4DU1E2RC8945oQpGnTAGNyhplwQwHsfv+OUurZlzB/8a+DfM84faxblBvTE2z8KlwGf4+qtoRsKlMBL9P/7fT6DGZavSlAI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:55:11 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 09:55:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <dzm91@hust.edu.cn>
CC:     <chengziqiu@hust.edu.cn>, <eugen.hristev@collabora.com>,
        <jic23@kernel.org>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: remove dead code in at91_adc_probe
Thread-Topic: [PATCH] drivers: iio: remove dead code in at91_adc_probe
Thread-Index: AQHZUzZn2fJwOQ8/AEeL17KvlQ+upg==
Date:   Fri, 10 Mar 2023 09:55:11 +0000
Message-ID: <9b4ff6bf-3ba3-10bd-f766-c1e8cb34a111@microchip.com>
References: <20230309150502.400312-1-chengziqiu@hust.edu.cn>
 <cc97cfe5-e90a-d901-147a-2bb829a4409d@microchip.com>
 <774cfa3a.25898.186cae584b7.Coremail.dzm91@hust.edu.cn>
In-Reply-To: <774cfa3a.25898.186cae584b7.Coremail.dzm91@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA1PR11MB7109:EE_
x-ms-office365-filtering-correlation-id: e4b8bb03-2974-41c3-96ad-08db214d89da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SuByFRKYAB7iLEu711g8SS7PfT6sL5F9JRwqowncPP2jj4oJfGj0DSOEO5Y17e+IIeaTpSiLIDe6pZyQvM034hQ8bRyorAMBtJHRwU4QHjEhjc4IAKhUgd9sw4N0ySy342QRDRtFeiyFGtMadIcAgJTeak2HAZF6yqxUVzhqeQ62f2Fln1KWrj9sST+0BaQ2AoaBQiabdUwbRE7Qa/Igjx829G2JHslpLIUnRSVuq4+uykpAIvSWmIwTfC4u9cj/n6TA5+3wmTAiZgziBZUYOFJ1ft59XH/OB49deghFrmDtbC2jxW+21/lo9hE//ZdqIeI3FbhvRqKUHQJ/CSlBwrQbZ9jEGNoru4/8NnVcmfUy6GGTxo1UHH0l7dj3axgJqAJBZ6qD3pJUNIUhA4pj0OJFEPsx1q3iQdJYl2WkPmoaWr+A6w10LZDP05Lhj5EZT7IdOiaqdMSIb1KtlNB4p6YE15zALqZEnftToG0hkgZ+WR2sYEn5Bg6PrW4qYsTw1oD8+gId/YnGvLdISxSTm/oB+RHpIfqy9ges0myF1JLe/xwdmfARH1OVEBKDlLUU6eh2OUv/VYYNE1Ei7/UvTuyun+oKqOQFU0GxEGmPKYacBBLGanWw/JV6GxzlXrs8Kp+B02O8So4AId+9LVHMuuFziNOS861JCsfKtK77xS/bp3WGKr3LAPwVtV7WznJnq9YtUGBiCO1bMPOZ/oSBxyDHc1iKnPGOMcBxkvi9N1DRWlVg1/FQRf2nzuJZUs9sHmpg4DvXWv37K4F5nOuANg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199018)(31686004)(6512007)(26005)(6486002)(6506007)(2616005)(53546011)(71200400001)(186003)(316002)(54906003)(91956017)(66946007)(66476007)(66446008)(66556008)(64756008)(8676002)(76116006)(8936002)(122000001)(5660300002)(41300700001)(4326008)(2906002)(83380400001)(6916009)(38100700002)(38070700005)(86362001)(478600001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1B3N0liS0YvL2h1Wlo0YjRzYU4vSytDMTFyemRHZVN1d2hLcEFZWDlGSEZ3?=
 =?utf-8?B?T053NDMvdWdtbXNYZEZpZkxqSXNkdm5XL3pySkUvWlBHUWw4TFFuRldLWWtr?=
 =?utf-8?B?czJhWERzUlpSbEhkbUhEakN2ZysyOFVkcUFGaVNOM24zMkN6SkRXVWJkNy91?=
 =?utf-8?B?QXcvaHpFZk5iaVFlV3cyZXQ1R1dpN08vcDl3RVVLcWI3THNBZEZ3RWEydTJG?=
 =?utf-8?B?MWIyOCtRVUlhL29GL2dqSUZOWnBOdnN6UXhhMXZxa2ZNaVpveUpreUZmdW1R?=
 =?utf-8?B?VmhCb3Eyd3cwQ0tmbDFOKytmR01FYWNEMXVSVTdpNUZLMExuNUFQckoyWDhU?=
 =?utf-8?B?SElJaDJ4dmpReHVhTGcwWjBaQmxtK05wQnlDV1pxcSsxMis3V0Zvb3BZd0Rm?=
 =?utf-8?B?b1lzMHY5OCs1YVdOUHVRQkNUbnNZS3Vyam9FeUM1bzFzQjhGOG80ZVdrMzVt?=
 =?utf-8?B?dkNZdW1ZOFpySDNOd1B4QVA0Si9nTFJmTStNcHl6RWFQWW04by9XMXczRmlV?=
 =?utf-8?B?S3hvMmNmNzNvSU1aOW0rQWpKK1JzbHhxRWQxZFBVUkJ4cHV5TXVVL2tsM1NO?=
 =?utf-8?B?UnNiUjVDSGNFQzV0WWU2VTdWWlhnd29Hb2xVcXRMV3BvQXJLOFdaMDVXRWp0?=
 =?utf-8?B?R2dnME9xRmxLYlNUZ2JjMzJicXdZdnJvR3RDTnM1bjBadWpWcC81cjhjKy9K?=
 =?utf-8?B?bXVkSXRTUm0wYmt2a005SWxwb3JiVmUydkdsOVRhNlV5RkpzcmZ1WitaRFdn?=
 =?utf-8?B?c2Q3U0NTdWJlZHZ4TmluL0JObzU4ZGRJcmFCZ3V2WWw0MTgxOU1oWHJqTG9y?=
 =?utf-8?B?VFhDM3lWNVVlTjYweGRCbTluU3VkKy8rbjFBN3UrZHdyb3lTRnUreFpHa2NC?=
 =?utf-8?B?WVlIT1E5VEZaMnBMSW00MU9YYWNuSG1LTGp4L1U1ZXQ5SzNtOWlJMWs5clFU?=
 =?utf-8?B?SVNhLzlTeFhJeHVPUk9IR05wNlYyWlgrWmdCWXcwNDIvK1QwSCs4UUtsUnpm?=
 =?utf-8?B?b0pjU1NWNmtoTHBOcUxOQjAzU3FxdUxVaGhja0EvNlhUaVNVc1hLUkNiUEcr?=
 =?utf-8?B?RW9vQk9mVVp6eTdVMFJ1OVljZHpsSU9jUitzdHVnWHlTdElTVDJseHFIQzdQ?=
 =?utf-8?B?WmZsMkRpeVd0MitBUDVlRlFjN0ZOSGpQV2JvMHhXQVJZM2pubVp1ZFM3N201?=
 =?utf-8?B?WFgyZVJWM1hwWFhWRXA4cnZFcEptQ0t5UzBZNmo4aVNDdHViR3FSSTNIU1lB?=
 =?utf-8?B?OTdWcVM1ZXFhUDNsVHd6UC9zaXRLWTJFNGZGTE84aVNIdHJnalAzNndGSlBJ?=
 =?utf-8?B?UXE5SzNwOXFOSGFvLytTVWw5SHZjQndUWFowaEJkRTMrTzFJMEN1UEhUUDR0?=
 =?utf-8?B?amlJN0JSLzZYa3lFVHV5a2FwdndYNUhIY2hDaUp6OGI4NzdSMFVnWmJaVUdV?=
 =?utf-8?B?YzZEQWZIN3ZBeUEybTh0QjFyb0k2UlpLSnlzZWhhemtjcUFYMG91aldXMzFI?=
 =?utf-8?B?amNzek5leXl4c0U5RzczS3ZoeUtWMjZHUlNDaVVIK09tNjByUmE3L3FFV0p6?=
 =?utf-8?B?WHZUd2ZRT0lMS2p0QndPMkg1eEZubmxYU1dWcWhkQXovUzRhMmdta1ZUbHVZ?=
 =?utf-8?B?RmF0djRPTmMwM3hyWXYxaU1yNTZXcHNzeFA1RFBnZVEreFpzbEtxN0gwb290?=
 =?utf-8?B?d08vS0Z0ZTJ6d3VyZUh0UkFvNmNkeFVEOGxSVGpEWUp5d0hJTzFOV0xPaUpB?=
 =?utf-8?B?TjcwYnMzTzZhYmlrcFNtM2U0eXdTcThZKy9ldUk3OFJhaUNaa3VpeGhIWWxl?=
 =?utf-8?B?VStidjdkSzhueVpkMHI3aGJlUHphTUdyam85dHRVQzd2dmdFZGVNd3JRMVdB?=
 =?utf-8?B?b0dvclQzRTYzZjZzVmhOUnV3WldzemRSSkJHMjMzek1YQkRvTEgwQ3lncHR0?=
 =?utf-8?B?RjRoZ3pVOE85Z3NCYytmeGtwdlVwV3d5Vm1HbkZ1bWh3UUxRc3lLd28zTHFm?=
 =?utf-8?B?Q0o3Y3BFM1JHUWhxdll4YnBSOTFTRDZFNkVFTlhSanJlcXRBRkVJVkx4Q1dW?=
 =?utf-8?B?MDNLVWRSMk4wN2F4KzdGc0VhVkZEWHhLQjNUVFNBSWM1ZnEwMEtHdjdzRUdP?=
 =?utf-8?B?Q1VGT3NSNW5KZkg4a2RlWkZIVng5cTZONUNHTlZ1OWd6NUxmcHEyc21UNFhs?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3383EFBE4D161479FB8D2F0E27F211C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b8bb03-2974-41c3-96ad-08db214d89da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 09:55:11.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPdNF/5e1hFBTNBI22/i89faY/LgxNRMpV28TkCjZSxJaDocZEd0QAdyLAvcYTDO2oiofkmnPTaOafaZaNr9FNgN8C4Ee8nIYGPvxAzMx2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDMuMjAyMyAxMTo0MSwg5oWV5Yas5LquIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+PiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+PiDlj5Hk
u7bkuro6IENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20NCj4+IOWPkemAgeaXtumXtDogMjAy
My0wMy0xMCAxNzoxNDo1NiAo5pif5pyf5LqUKQ0KPj4g5pS25Lu25Lq6OiBjaGVuZ3ppcWl1QGh1
c3QuZWR1LmNuLCBldWdlbi5ocmlzdGV2QGNvbGxhYm9yYS5jb20sIGppYzIzQGtlcm5lbC5vcmcs
IGxhcnNAbWV0YWZvby5kZSwgTmljb2xhcy5GZXJyZUBtaWNyb2NoaXAuY29tLCBhbGV4YW5kcmUu
YmVsbG9uaUBib290bGluLmNvbQ0KPj4g5oqE6YCBOiBkem05MUBodXN0LmVkdS5jbiwgbGludXgt
aWlvQHZnZXIua2VybmVsLm9yZywgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+PiDkuLvpopg6IFJlOiBbUEFUQ0hdIGRy
aXZlcnM6IGlpbzogcmVtb3ZlIGRlYWQgY29kZSBpbiBhdDkxX2FkY19wcm9iZQ0KPj4NCj4+IE9u
IDA5LjAzLjIwMjMgMTc6MDUsIENoZW5nIFppcWl1IHdyb3RlOg0KPj4+ID5Gcm9tIHRoZSBjb21t
ZW50IG9mIHBsYXRmb3JtX2dldF9pcnEsIGl0IG9ubHkgcmV0dXJucyBub24temVybyBJUlENCj4+
PiBudW1iZXIgYW5kIG5lZ2F0aXZlIGVycm9yIG51bWJlciwgb3RoZXIgdGhhbiB6ZXJvLg0KPj4+
DQo+Pj4gRml4IHRoaXMgYnkgcmVtb3ZpbmcgdGhlIGlmIGNvbmRpdGlvbi4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IENoZW5nIFppcWl1IDxjaGVuZ3ppcWl1QGh1c3QuZWR1LmNuPg0KPj4NCj4+
IEkgc2VlIEZyb20gYW5kIDFzdCBTb0IgbWF0Y2hlcyBidXQNCj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogRG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4NCj4+DQo+PiB0aGlzIFNvQiBzZWVt
cyBleHRyYS4gV2hhdCBpcyB0aGUgY29udHJpYnV0aW9uIG9mIERvbmdsaWFuZyBNdSB0byB0aGlz
IHBhdGNoPw0KPiANCj4gSSByZXZpZXdlZCB0aGlzIHBhdGNoIGxvY2FsbHkgc2luY2UgdGhpcyBz
dHVkZW50IGlzIHRoZSBmaXJzdCB0aW1lIHRvIHN1Ym1pdCBwYXRjaCB0byB0aGUga2VybmVsIG1h
aWxpbmcgbGlzdC4NCg0KVGhlbiBwbGVhc2UgdXNlICJSZXZpZXdlZC1ieSIgdGFnLg0KDQo+IA0K
PiBJbiBteSBsYWIsIEkgZW5jb3VyYWdlIGFsbCBzdHVkZW50cyB0byBmaXgga2VybmVsIGlzc3Vl
cy4gSG93ZXZlciwgdGhlaXIgcGF0Y2hlcyBzaG91bGQgYmUgcmV2aWV3ZWQgYnkgbWUgZmlyc3Qg
YmVmb3JlIHNlbmRpbmcgdGhlIG1haWxpbmcgbGlzdC4NCj4gDQo+Pg0KPj4+IC0tLQ0KPj4+ICBk
cml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIHwgNiArLS0tLS0NCj4+PiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgYi9kcml2ZXJzL2lpby9h
ZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+Pj4gaW5kZXggNTBkMDJlNWZjNmZjLi4xNjgzOTkwOTI1
OTAgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0K
Pj4+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+PiBAQCAtMjQw
MCwxMiArMjQwMCw4IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4+PiAgICAgICAgIHN0LT5kbWFfc3QucGh5c19hZGRyID0gcmVzLT5z
dGFydDsNCj4+Pg0KPj4+ICAgICAgICAgc3QtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwg
MCk7DQo+Pj4gLSAgICAgICBpZiAoc3QtPmlycSA8PSAwKSB7DQo+Pj4gLSAgICAgICAgICAgICAg
IGlmICghc3QtPmlycSkNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBzdC0+aXJxID0gLUVO
WElPOw0KPj4+IC0NCj4+PiArICAgICAgIGlmIChzdC0+aXJxIDwgMCkNCj4+PiAgICAgICAgICAg
ICAgICAgcmV0dXJuIHN0LT5pcnE7DQo+Pj4gLSAgICAgICB9DQo+Pj4NCj4+PiAgICAgICAgIHN0
LT5wZXJfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJhZGNfY2xrIik7DQo+Pj4gICAg
ICAgICBpZiAoSVNfRVJSKHN0LT5wZXJfY2xrKSkNCj4+PiAtLQ0KPj4+IDIuMzQuMQ0KPj4+DQo+
Pg0KPiANCj4gDQo+IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gRG9uZ2xpYW5nIE11DQoNCg==
