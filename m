Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A06D657D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjDDOgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjDDOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:36:10 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B9310DF;
        Tue,  4 Apr 2023 07:36:08 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Cx3ci002655;
        Tue, 4 Apr 2023 10:36:03 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pph89pk87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 10:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqz3wasUt8h68/1wFS2Tj1tS5wuVI5yVhaQHOBWbotuocshxXeO2qwy5V7p2HDjBX25bRxPRqGrcaneBbGjsJNpvgKnay3UG2lwz7r6BbSJdYpAwWw7h/0neerZl/Ha9mfolwVNwSMCEAen665V3ixWTMVTkpcy/gktY3VJwG9xBDy90yLTaKrYhopdgNuDIVHdN4GwWoPMWJxjwkg2x42QdPRBggOGgXTyI4m/YVPjuZkgzw+lLmDi+iT9op+y/K2DJEXZS9VR9shRYYWDwF9jcNf74UW7A0+COFz/76Ju9h6k8FbYX5AnSw1+OPiccloRDckb/b58KVPcP4sJFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qQ0Q3hMxM//O7HKioYPELrHiAZdzzZukZyAtyFgHuQ=;
 b=iIFld5diqiUejr+tkHkKakypEV4LXMvx6Jbyn5GSbuTLKEEvXI+cYGo+/QLun7Y6F/PeSbhLmWNTomsmPKdV/OTcZLjEKNZPGx28ZPE1pvSVZZ0fWiHHuKGgUZ+UxqT38GuaIIBpneDYwkFTeHRxNMyfV/R7vEa3dH8nwDFQiXgWtyYC5LuukAdPfmsTgK+Jlms5qmJxO0ZjiVIhuVfXqLUV7N+Y+aXUtpdZzSbBK6AB5KqkxWz+VfYqas0iyT+gFS8BgBWfVTjK6rvajYHTb7sB5Cu1qz6x+aAfY7fIF7PWgqc16cMUoaAR9eRBGjqrICfrztzrDszZ55+ZS4ELoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qQ0Q3hMxM//O7HKioYPELrHiAZdzzZukZyAtyFgHuQ=;
 b=7ZtG3XRNQssIAs1dWNzCIDgDFhCUHfbM7bfFotX3/dseTi50IA/H4kfQRuSU8T/3pFtlFa6dsi1heFUykUUZYOiXxqSwvbNOA2Gc0t2L/KBct1I4ektmrdLR2F1qLl1Kz4pOo5LhyixVLOoScVKQNWpFc+rha+w2Da+oOoBqXrU=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ0PR03MB5728.namprd03.prod.outlook.com (2603:10b6:a03:2dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 14:35:58 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 14:35:57 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Topic: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Index: AQHZYKxFzu/viFi84UyZMktWpJEoz68UqJ8AgAaZoUA=
Date:   Tue, 4 Apr 2023 14:35:57 +0000
Message-ID: <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
In-Reply-To: <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRBeE56Y3dZMlk0TFdReVpqWXRNVEZsWkMxaVpXTXhMVEEw?=
 =?utf-8?B?TjJKallqVmhZekEwT0Z4aGJXVXRkR1Z6ZEZ3d01UYzNNR05tWVMxa01tWTJM?=
 =?utf-8?B?VEV4WldRdFltVmpNUzB3TkRkaVkySTFZV013TkRoaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJakV6TmpnaUlIUTlJakV6TXpJMU1Ea3lOVFUxTmpnNE9Ua3pNeUlnYUQw?=
 =?utf-8?B?aVVUVk1aVEJpYVhoSmFGTXpWalJXUkcwd1JHeHRPRFJEYmpOclBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQ1RtVmpMMFJCYldaYVFWRmpkVnBzWTIwclky?=
 =?utf-8?B?MW1RbmsxYlZaNVlqVjVXamhFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRlJaR2xyTlZGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2FrRklWVUZqWjBKc1FV?=
 =?utf-8?B?WTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZNFFWcG5RbWhCUjNk?=
 =?utf-8?B?QlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRCWkdkQ2JFRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0UVdOM1FteEJSMDFC?=
 =?utf-8?B?WkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGSVRVRllk?=
 =?utf-8?B?MEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldWRkNhMEZIYTBGWWQw?=
 =?utf-8?B?SjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1w?=
 =?utf-8?B?QlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVFOVBTSXZQand2?=
 =?utf-8?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ0PR03MB5728:EE_
x-ms-office365-filtering-correlation-id: eb6fddba-ec1c-4393-71db-08db3519e79e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zESU8sYO82preVXO+RatCNuHQNIxzbUuc2DWU6MbOc9oIrfNXHnuCde6iROYMWUUkWwgDg48xCUqSBzNz2b9HmghjghJp9DwrCXUaNtD6in8rufjtLtubnCCrGxZQiC91FyfqAmCjE6iTUrE48MnFxqK0Ml8iYppt78t5l4/KsVrvwZ34zlRYkE+PWBkhufQ2UCZvPObV+GQIzrooKaS+PNXXXyhDB0NqJAh1n4TYXomMfaz9imuBODIYcLuwdpu3ScaQ1rp7pHxx62HSfiXyjkIOXCFcaBq4QB+qL8dTHsSWWEfIQKxojeysvHTh2LxkXtFEci2GR463xRM8cacQQexKCyKtN9jAql0wZqSapE8z6UbXXGypGhvpt71UHo9o6vvGEma4cocVmAYbBS7v0cZPhPuSFRYvzRr7CTDoFgira91PGp3kUzE1S+RCTmKhaU3DdlhTDN/4fgpXV/VBVsOEh3JE7ENDvhdyXuirJLJSPWzjIyxEo+C8klvBty6SlkI6Rjx/Oojj+w6Uc8QQzv9dOKJffRbpQkYj+c31L+PqeQoLdOVB3zTWV000jK53/vTFiQ5s6gJQvS3IwUctimLREKB54iIPluk1VfdWAgul35quPuwmzbYM65ThfBa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(55016003)(4326008)(478600001)(122000001)(64756008)(66476007)(6916009)(66556008)(66946007)(76116006)(66446008)(54906003)(52536014)(8936002)(8676002)(316002)(38100700002)(41300700001)(5660300002)(186003)(71200400001)(6506007)(26005)(9686003)(86362001)(33656002)(2906002)(38070700005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUVPR3A4RnhrSEkrTjZQZUVJWmlFM3hOUHJTM3FDeUJ3bzFoY0VaeEJEYXhD?=
 =?utf-8?B?ckxGM3pZY2gvNmJUZDljRFhSR1BUU29JRU1mcUorZmMwV3hYdlJwVHJMTFdm?=
 =?utf-8?B?VXdIUjUyQXJSUzVZSFZIalVWb1YxVmpLWDVndld3NEJ0U1FVVWY2RXZ1SHVR?=
 =?utf-8?B?RDhlRGhSQnVGbk8xVDlJK1dKSjVZVEZlMUdPWHdnNTBxZEdtWXowbnlybFAy?=
 =?utf-8?B?VWRKNHBhRUNTTllmU0p6Ky95Q2x6VUpYTVJRbDdmWXRNZjVmbWl4b2Z6eVdR?=
 =?utf-8?B?bndBQXA3ZjdkNlNqeE1idmJENXFQNktVZlFlbnR1OWZuMElIU3N0Qk0vUDFy?=
 =?utf-8?B?V1FNS09ET3B4dXRMYmlYMzRzbkpKM2RiRG5JRTNCT2tSSUJScm1oZXh0Qkp3?=
 =?utf-8?B?eVhOWXJWVml0QnJ6dzExQ2NPaDdVZEtGMUhWNGd1cGpGYTN5TjJQd25BZTFB?=
 =?utf-8?B?ZzBkbHR1UmJuOVI0RzF2NHZrUmFDZzdVQmh1OVhxN2hFU1EwcVU1WU9LYUdl?=
 =?utf-8?B?S3Vzb0N3a1pIRGhUd0RUU241VGdaYkRmeUF6cUx3MHFEa0llbGo4Vi9keGJR?=
 =?utf-8?B?T2lNVjlGYzN5N0RqYVhuVGRwZ2V5d0dYUzRxTjZXU0pmbTNCT2NRUlI1aE9N?=
 =?utf-8?B?cWxaTEVBb2xwSEdhOTJuSFNwbGpvQWtMRUdOWnZySSs0NFN1a1NINTlvRTRj?=
 =?utf-8?B?ZjVTTlk0Y3ZlQkMzamxpZkR3Y2tqUWtYTG9RTk9KalJVZ3Badkl5M2ZhUW9k?=
 =?utf-8?B?T2JYT2dtbWYvL1FvckNnb0hQMzQ3ay9EM29udloyU3VrN3kvYmM0YmJRN0Yv?=
 =?utf-8?B?UlhlVXpnNE1LRXZpaHNLbzd4eitRemhBK3R0WVR5SVRzSnh6Wm5nQTBBakc0?=
 =?utf-8?B?bHc2djJsZmJ2dFJFdTNZVVE3Y0FhcklBRWhHTHF2WFlzM3c3ZHliUTRiZkpN?=
 =?utf-8?B?S1BDL3V1eEZQeVlHR3prck1iZ1NveXIzTCtvRWd0UkVSOEZaV1Npa21IY2FN?=
 =?utf-8?B?RWxodHpMNU82Y0FJa0ZJQjNsYUtjR0FYamVhejVTQkt2S085U0pHbXJWSnRX?=
 =?utf-8?B?M3VzbGErZnJGN1Nramhzb3JKK2hjbmJsdGZaRU5rMHVaRm1xbDRsT1RxalNw?=
 =?utf-8?B?RGsxT2Z1NHBJK3hYMWNzaDRmNHM2dm80UVVuZUZLQWFrYWRIUWJEVlN6QTI1?=
 =?utf-8?B?K3oyL2NMSHVYWkpqME1lQnN0ZmcwZnhpT1BncFNjTStsajRoM094ZTN3Y2xZ?=
 =?utf-8?B?Z1JuSjltbXl5WThYdWhGM2psbmk1bDR0YmQ2bDVCQXl0RjR1TGpQdnNPdGhW?=
 =?utf-8?B?RUNkc1hjTStRNVFTRW1jUFZNbE5nSVA4YTk3ZWhLRCtUZ0Zlc09jZVlsL3F0?=
 =?utf-8?B?dXVmdEQ5N2RSOTUxM2FwWStzcUIzYkVLd2xXQVB5R3lBSk5CelcyaUU1UjZ1?=
 =?utf-8?B?OUJOdUlKRzd6akN0MnhyTk9EQWlVcGNMU2dwWm1vUG9YRlFhbENES2tOWGt2?=
 =?utf-8?B?LzZaUERkTWZBSHFYL2J4OTJsWkZxZGZPaHJ0bXUreW82Sll2eGhQdVljN1dP?=
 =?utf-8?B?aUhpOWJhYm1VdFdxaU0rSE80NCt3YW44bWpsV01sQndKMkwyOXJPa1c4Vnpl?=
 =?utf-8?B?N0Y4S2ZnQyszWDE4ZzJBTE5uMWpRRUlQVnlTUm80NkoyNTlQb041d0NmeTQx?=
 =?utf-8?B?SjBXcmN5Wnh4NW5GcU5OSndMSUtCaHQxWGp5Rkt2dDcrTjBnVGlNZWJGcDR6?=
 =?utf-8?B?NWlvVEVPMzdhZlJDRHBFZVg2UXBjVm9hdS9aTmpMa1NkVVRRVjJ4amNXc0JJ?=
 =?utf-8?B?enduSEo0ZngvV0MzMFE0RDZpZUxTVE1QTE1WaWNYU0RyblorY1c0eVJxakpN?=
 =?utf-8?B?UkxxZG9Ed29FUmRYSFYrT1BwT21yZ0Z5Wi9KUXFqZkgyN013Y2JNRnRabjFK?=
 =?utf-8?B?NmNJSEZMQTdvVzJ0WmdkRWpycGpscnJHbzhjc2NIY0tVUW5PSEZWT3RpT1Y3?=
 =?utf-8?B?Z3dBaGdHSnk1OFVLQjFBNEM4NFBtRTFRZkgvZ0kvVXd0anpZVXZkMThweERC?=
 =?utf-8?B?VDVGN1VPYUI5bWdkUUFyVHBRZzFNcTVFL2oyRXYrUzdOSGdncUV2YUtpejFY?=
 =?utf-8?Q?o5dGnnbVOwXypYL/TSUBQ02MZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6fddba-ec1c-4393-71db-08db3519e79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:35:57.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mumw4fUjWgAZdbCjWvPWaizEt4Z6l0Co/DqFn++3DeA9SCTEdi5aPuVA7bugcdupijI691Gn1BqUEqcqk2vn/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5728
X-Proofpoint-ORIG-GUID: 0Ursxb0qRAWz_Ekjsfrbeo_pe6hjxbdY
X-Proofpoint-GUID: 0Ursxb0qRAWz_Ekjsfrbeo_pe6hjxbdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=696 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040135
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkhpIE9rYW4sDQo+DQo+dGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPg0KPkZpcnN0OiB3aHkgaXMg
dGhlIHdvcmQgIlJlZ3VsYXRvciIgaW4gdGhlIHN1YmplY3Q/IEkgZG9uJ3QgcXVpdGUgZ2V0IGl0
Lg0KPg0KPk9uIE1vbiwgTWFyIDI3LCAyMDIzIGF0IDM6MDHigK9QTSBPa2FuIFNhaGluIDxva2Fu
LnNhaGluQGFuYWxvZy5jb20+IHdyb3RlOg0KPj4NCj4+IEdwaW8gSS9PIGV4cGFuZGVyLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IE9rYW4gU2FoaW4gPG9rYW4uc2FoaW5AYW5hbG9nLmNvbT4NCj4N
Cj5UaGlzIGNvbW1pdCBsb2cgaXMgdG9vIHRlcnNlLiBXcml0ZSBhIGJpdCBhYm91dCB3aGF0IHRo
aXMgaGFyZHdhcmUgaXMuDQo+DQo+PiArY29uZmlnIEdQSU9fRFM0NTIwDQo+PiArICAgICAgIHRy
aXN0YXRlICJEUzQ1MjAgSTJDIEdQSU8gZXhwYW5kZXIiDQo+PiArICAgICAgIHNlbGVjdCBSRUdN
QVBfSTJDDQo+PiArICAgICAgIGhlbHANCj4+ICsgICAgICAgICBHUElPIGRyaXZlciBmb3IgTWF4
aW0gTUFYNzMwMCBJMkMtYmFzZWQgR1BJTyBleHBhbmRlci4NCj4NCj5JcyBpdCBNQVg3MzAwLCBJ
IGRvbid0IGdldCB0aGlzLCBpdCBzZWVtcyBzdXBlci1jb25mdXNlZC4NCj4NCj4+ICsgICAgICAg
ICBTYXkgeWVzIGhlcmUgdG8gZW5hYmxlIHRoZSBHUElPIGRyaXZlciBmb3IgdGhlIEFESSBEUzQ1
MjAgY2hpcC4NCj4+ICsNCj4+ICsgICAgICAgICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEg
bW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwNCj4+ICsgICAgICAgICBiZSBj
YWxsZWQgZ3Bpby1kczQ1MjAuDQo+DQo+KC4uLikNCj4NCj5UaGUgZHJpdmVyIGlzIHByZXR0eSBz
dHJhaWdodC1mb3J3YXJkLCBidXQgSSB0aGluayB0aGlzIGNhbiB1c2UgdGhlIGdlbmVyaWMNCj5H
UElPX1JFR01BUCBoZWxwZXJzIGluIGRyaXZlcnMvZ3Bpby9ncGlvLXJlZ21hcC5jIGNoZWNrIG90
aGVyIGRyaXZlcnMgc2VsZWN0aW5nDQo+dGhpcyBoZWxwZXIgbGlicmFyeSBmb3IgaW5zcGlyYXRp
b24uDQo+DQo+WW91cnMsDQo+TGludXMgV2FsbGVpag0KDQpIaSBMaW51cywNCg0KVGhhbmsgeW91
IGZvciB5b3VyIGNvbnRyaWJ1dGlvbi4gU2hvdWxkIEkgYWRkIHNlbGVjdCBHUElPX1JFR01BUCBp
bnRvIEtjb25maWc/DQpJIGFtIHRyeWluZyB0byB1bmRlcnN0YW5kIGNvbXBsZXRlbHkgYmVmb3Jl
IHNlbmRpbmcgbmV3IHBhdGNoLg0KSSB3aWxsIGZpeCB5b3VyIG90aGVyIGNvbW1lbnRzLg0KDQpS
ZWdhcmRzLA0KT2thbiBTYWhpbg0K
