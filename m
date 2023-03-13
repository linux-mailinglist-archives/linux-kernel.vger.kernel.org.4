Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE1E6B799A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCMN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:56:39 -0400
Received: from mx0b-00209e01.pphosted.com (mx0b-00209e01.pphosted.com [148.163.152.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB8B6BC27;
        Mon, 13 Mar 2023 06:56:34 -0700 (PDT)
Received: from pps.filterd (m0094031.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DCopmc021057;
        Mon, 13 Mar 2023 09:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pod1119;
 bh=m3bETieHSfyCUXcUFDQDpErBfuY6QWpXugRGII6uIaY=;
 b=VbwnKdTGFAJXPaEJH37ghXsQ1/ymNu+x+yZeTP4zCfQROliQCF1IEZVJUeAkzABfXudl
 EwzY7ccy1j+EcQLwO1e/kH3pYLlDQ8VC3KaGuAVIGlYKmgj6WPIgkx5L5p/CnboVzVKB
 MA9ZN5Dj5sPWDR3Spmtotb1NZQvbxu9885Q4AYYZJ3l0fcEk/2CQyH2SHJK6qUCK0nws
 qM+cNOZFE2mMFdQo1WJ0imTKXpjGlS0bx4LMn4vheIcnBk1E0rTeOCUaGdVm45KJoifq
 pVdNOox0892YvJYgYP6ARA4C62KdJAjWdUY/KR6d5sdUZhsj7NS96d2uyvod0SVC0Khp XQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00209e01.pphosted.com (PPS) with ESMTPS id 3pa46qrdyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 09:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjScNe+G0pArAZA/WBDXuFvwSnM1Z2hWprgUvSpzX469msUip1amjkcueeTp5rwNlvrRh2m9NB10zs1og8pUCVOlhjIeRjsU8vsal+Yr4xHJnezywoB6XvJ977v6s2TAAb0SxxzaQzu3Apq3q8u0gD9k2JAV+YgaV7DcGExt4dbYFO8xfuoi8H94CEQZ7BGv39a5fLoddHG9/Kwx1mjA1dRHNA0GC7k/hjJeV8L/Al57heOHM3uZK0GrYcwzue8iOj0uzqzR0V+Hes3X5KatpOzAP/a8m2kl5km6HFowjgQjjZRtr2+iELVJU8IoRGRwxCErUF1Aacdy0N0Lbt2eJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3bETieHSfyCUXcUFDQDpErBfuY6QWpXugRGII6uIaY=;
 b=oFrCS4QTCcQ6gUYzhc4YXSgKwhyovbO14ZWtmyNH+7TJ/UixEkvqP3YLIxLl2HGmE/ha1kDlFvXKZsj1EWWLZQw9Cvd8JDYDXN7pob1TJrzYsjyoWeuEdLoEps/wddzJNbkMhZinoTxl/UHhQXFybxkrbG4ZfD8mAdrO40NkV3GNkhGN66hgGhzapiWw2ZbA2luySOSLa3/Miff9ci9fdfIHQJwhG9hMH2rPeCe7tYc3waXAkqLnitc40a5/tuigZ9r20ccW7H5OIkgVmuWwUNOfhqvTH16jWPANlxYBYQ/faFCymGSkShXaZKC/FQcAF30CDfoDhWaiw6s3ovcJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by SA1PR15MB4435.namprd15.prod.outlook.com (2603:10b6:806:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 13:56:24 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::fb77:675c:d292:6325]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::fb77:675c:d292:6325%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 13:56:24 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpio: mmio: Use new flag BGPIOF_NO_INPUT.
Thread-Topic: [PATCH v2 2/2] gpio: mmio: Use new flag BGPIOF_NO_INPUT.
Thread-Index: AQHZNXrgaDBY931vG0OvRATM+LiFj67LUsWAgC2pdoA=
Date:   Mon, 13 Mar 2023 13:56:24 +0000
Message-ID: <ace51cc4-aa77-7ac0-b83f-12057a9bbae6@ncr.com>
References: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
 <20230126-gpio-mmio-fix-v2-2-38397aace340@ncr.com>
 <Y+jds9U1PgYpXBHT@smile.fi.intel.com>
In-Reply-To: <Y+jds9U1PgYpXBHT@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|SA1PR15MB4435:EE_
x-ms-office365-filtering-correlation-id: 912a82c0-d02d-41a8-8945-08db23cabbab
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIt0GgQYbm/2sitjTY0i6qW0gzkr7bHNV3sAoziUo7Nu6on4vBLglD7E7xBhoke9e7Ch4rYBNPjXzuK3j7j6rJ4L4a+EvehFv+ERfRhQ4ky2iFIvnJjlqdWGtDDfWqJe9UpREcZmQBFxlo1lonKaGeinZOTEK/nG+OfnGvpPztmJ4PnFdoEmpUEZRUqlIOzVGeLD3O9kdjDnsrXC5VMZ/qqlsyDZTNm4yYe5DdKdxr+jwK3afpq0Mnre3qsSmsnpiCCrQLXZe98Dty9DNRlPyjQocCBD6Hs4YJXBB0xdZdVPKZLcq+7cJzBuhmwXL1/HHx6lYv9SFfJjmMwMzWcPNKup01UetxbzPFRp2RjW+YKVtrhU0WelqLv6M6Z/vvYwqJRMdJJEk+l2SbdtnVjtNj7kt0y+6WZQf/P9FNAz7/N4k+3ysB0CvoeByVIwHeMS9iMDzQn+T2X94rE0biIAOcEuOSaKcQmfQEjUH6lflX5gEUH/MWmPz7yXDRBUC4QTJPx1S8cPT28lv61CNO8Z5WEwK/hlwOZHB5ny0Ll1htgemJr0WPjVZSE4Qf0rOejrKANZLyz9b/XyJwE44D6BtqEl4bi9moMp5EThU6vgLagQZbgrrLlWc0uAA0zR0rXZRgqKdPeyhTk2ZR7qhm9GnPIKAuCSJ8IK09IKeFiweNUFmc59zbteFlUSvfdoNdeN8YMdKqagnO3FCmrXovp9DNn+KMPT6wV72t4IEeuFQNdZhKrlWVt8ToVwFTWWrT8PtlBHMS+Eie5NlaFABwxSSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199018)(5660300002)(36756003)(83380400001)(186003)(478600001)(26005)(2616005)(71200400001)(6512007)(6506007)(6486002)(53546011)(66556008)(8676002)(91956017)(38070700005)(4326008)(64756008)(66476007)(76116006)(66946007)(8936002)(6916009)(41300700001)(86362001)(31696002)(316002)(66446008)(54906003)(38100700002)(82960400001)(122000001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDRPaDB5UGxNR3UxbExuRkxWWHN4YXdHVkUzOWlicnpaVmJwM1RoR3BrN0tY?=
 =?utf-8?B?N1RSZjJjeHpUL28ydDNrQ1lUazVLZ0Q4MmJ3Nmd2UFJhWlNrQVZweERwUmJE?=
 =?utf-8?B?U0RjakNtcjhRR21xSjZQK2JFck43UVEvbXlPTnJhRzVURENhVEtkNE1YeEx1?=
 =?utf-8?B?eUNJdE9IQ0lEZEh5NDBSTXZqMlRwOFduM09SSHkwSk0xNzYvajB6Q3plV1JY?=
 =?utf-8?B?N3RoM29tSnRZaFdKTEZYR2V4TEFVVm14eVNCbVlaaEZiajI4VnVyZ3BBYk1M?=
 =?utf-8?B?cjhRckhZYXprZktwWW1Dak4xZWhOMW5wSHllenkxdmxNUndscnhqb2gvd1FW?=
 =?utf-8?B?OHlEM0JiWjdnOElJY1M3b2MwMldNQU4ySkNuUVhLbVhOcU9sKzBrRkhFenpX?=
 =?utf-8?B?cld1QzJsYXNlekIvUG1mS2IvU256WXN2MkxBQXhaWlFGR1dtc3d6dWcxcXFv?=
 =?utf-8?B?MXk5TUVLRlNzSUZOOGg1SlJNRVNxdktrSHZ3NFNNeEpkZk5MZTFQRC82VW83?=
 =?utf-8?B?ejhIZTZ5eW40dE9PdVRSQTFhT0VyQWRLWk1XT3ZPRXZ2d2wwbkdTbnkxSTFu?=
 =?utf-8?B?TnVNMzQrMDdFT2VSKzZEN3ZMY082TXArdk1STFBMT2dTY3RITUxxS21TbEsy?=
 =?utf-8?B?QUxDYmdPaVlCSjN2WUdCQmc2bWZsM295emt1TzgxOE9KQTdFYllXOXhUUzly?=
 =?utf-8?B?T3JDYnViUm9GcGJlTE1CUjFQR0taOXM1SW1IOW1YVzR5V3lQNVR6ckxVR0F4?=
 =?utf-8?B?NXRlZ09DUCtmaVl2WVJ2V1dCSUF0em9BeEd0ek5aNTJQd0l0eEpKNUhMbHhN?=
 =?utf-8?B?c3hNQzNoelkvZlNBdEl2a0JORnRuZHVpUmQzRUlaekNGUll1Z0o4MjlwTWdJ?=
 =?utf-8?B?eU9YalNjcG56UHA3VHM0a0h3ZVR1MzJXZUhkQXU3VEprKy9hVlJ6MWlCOEJv?=
 =?utf-8?B?K0RpRERRNEpYNC9TclgybkhoaE5YRGMwMWgrbDB6N1JCdGZtOVoxUHo2Z0dl?=
 =?utf-8?B?TEhFUW0yM3VCRHVFMjd3K05ZeEx0bytyRVdNS1B1WmdYU1lERE40bU5lLzc2?=
 =?utf-8?B?NlVFcGJxdHhybHJzVzQrK3AwQWhvcXJybG1pNndGMUZkL3MwQTJDM2xZU0ZS?=
 =?utf-8?B?RnowT3VHNG5CdTZhQ1hKZE9vUVFiZzNpYjRtVGVJWUFQVTZDM0hoaXpCZXhL?=
 =?utf-8?B?SjJ4UlNuNDFRZ1VSc0lxNHMvMURDTUlMK3BUUzcvdzludHgwOW9wS0NzQVlE?=
 =?utf-8?B?ck9WMlRPNVBCaVZON0FOcDIxdjNZZ3g3TmpTQkozWC9JU1RIbUdpVHFLbTdN?=
 =?utf-8?B?dEY2Z1BnS2RGZzc3Y1BhTGo5Q0xQVThjNnhhR09LREsxbjJWWW5YVktOR3dC?=
 =?utf-8?B?bGoxTmdHaFJicW0ybUIyYWk4VWF1OXM5dnZSUHo5akhuOVpnWHFFOXdmQUtM?=
 =?utf-8?B?MmpnbWpsZ0dXbUdqcHEzcDFnZkY0V0V3ZnU3SFZ0N2xiaUZodmJHYW83NVpG?=
 =?utf-8?B?STVNdkxJQXhlYk40SHFDbjRzeGF6aUFaRzZVWHhOdzFPTXZKcVBhU2YzRk9G?=
 =?utf-8?B?YlJsbU1yRmdZUDkveVNNSXk5SDVmTWNjRUZwY1NpUjRXN3N1ZTNzM1VsUldp?=
 =?utf-8?B?RUMyT05qNDdDQVJlSVY5NFlQZU5sekROV08rRWpjZFhOOTFPUFVRU3daMThN?=
 =?utf-8?B?Z09DN3NXbHFnQkdaanRzZnpZa1NKeXZacWpiTCsvb09FTlQxZjQvMlQyQUds?=
 =?utf-8?B?ZExqSEVUcUNHYmo4cGxHTXgrWXltbGVBZlpjbGsvWU5GenZwSU9EbFYvMUtn?=
 =?utf-8?B?R1hVL2lBLzNOVjVESjNoVkk3dzRyWmJoZ1pFaFVRM3BEbmhvaHlqRTJVQkxD?=
 =?utf-8?B?UnpybHA5Y2xSa2tJdUhCVVJsNGRzdjRiK1p6ODdBbEozTFppNm9FVXRGOVdX?=
 =?utf-8?B?RWM0Y2J6K2NrTzFIdW0xQThJdnp0MjlCNEFlZi9MU1NyQnMwcU5pTzBsUUda?=
 =?utf-8?B?RStWUVdwdnpBVXlKWGJoRXFPWjRLMXFlVDR3NTV0WGdyU3VWbSswaC9XcXpS?=
 =?utf-8?B?YjdYdzlFaUQ1cnR1TW8yTzB3VFFzVWxGUlROanRDNW0rS2wzZHBld0ZtbGNT?=
 =?utf-8?Q?aFlA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF2C91ABEF98B244BA244CF9A557C71B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9rRo+BOsA625jJHl/qOkiFLesTlmQdzJg8gN2DRgaeNixYH7pmZfl0LQat+cfkt3+Vu7SYW3qqkBv/hFxXBNcJlgdt9c9mhU8+G+5nvyBW+ZCgRCPbQbYWzb1pbTxfw7HTKbwZjTtqsf97Atf4hBBc4xv5Zwyho6tLtuYSjZrvqJuUwPaWcNrMkceJtGQfNMQ1nXPfz0XT8W85mx7yQjBrXHKh1LQBxOHvHK5KN2tE1UFB75vPIelJVYrXYo19S9dfkrKilFXiLfHi0jB1m8/ehhb9L8rtn3sYwZKDzoE0DSaDx2OdQiYkUQHTb4D44qNiFlv0AtWtF8HGZsxzCPdP43Ac9xJHRgrtelAvWJNZrJWCZcSlW8i2K/sdgx1iIym6wMVgoMV+9MiE3Yl9CES9UktY5TyeU1Idw/ToaLamctXieJLJUe3V8DiF7fK/cVYe9+qQ06mUSk1BHG5OIsLIi54i3rBorIaceujEZDbLy8Z6Ig7VQydfp5PtEn40Fhb1AxdV7xVLIK76XR7oBMKOljOTSSb66KHvOXnYiQmcPXwHjwRB+pGVOqecNfNcM1IdFCendmExK+4VsRML1PmARBDJReDldAT9E35O+flssdGjQiG7/4jQ17JeM3NYHinE9qR6n2ndvArSPJnUzYeioR0HjFi5s6dJuQcbErbQuFTpNth04WZTdMMyr2AIL2iS6kc2sgVvMDvGDEtD3RxyOMCK3p2vm2sBgrXHOnKerHf8IcJvTE/2uBrRygz+dH91udB1fqyBe5ZqWrI2UzJz85+p4KeimH2v77F38kbTHI6KYFjK+i3hrIqohfVhWl/Td/TI0u/qiSZNUM9NkMpzbAJWjEnkAKCxDxU5lB1Xjyp+sKdZgGueoj8wmqc84ywVvCcgKvAupXbozYbTwzrQ==
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912a82c0-d02d-41a8-8945-08db23cabbab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 13:56:24.1848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWFRbsvA3HLHI55PTJaaEzousHF0khsRjMkmrEX0BIiVxBZ9ylPbH3q3hWCP1lFU+VG+UHNuewb3XoiAbGd/ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4435
X-Proofpoint-GUID: N8y7ZO80NaT9RYlQ4w-9iIijCZ8WHhnC
X-Proofpoint-ORIG-GUID: N8y7ZO80NaT9RYlQ4w-9iIijCZ8WHhnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_06,2023-03-13_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDIvMjAyMyAxMjozOCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiAqRXh0ZXJuYWwg
TWVzc2FnZSogLSBVc2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50
cw0KPiANCj4gT24gVHVlLCBKYW4gMzEsIDIwMjMgYXQgMDE6NDk6MzhQTSArMDAwMCwgTmlhbGwg
TGVvbmFyZCB3cm90ZToNCj4+IEFkZCBuZXcgZmxhZyBCR1BJT0ZfTk9fSU5QVVQgdG8gaGVhZGVy
IGZpbGUuDQo+PiBVc2UgdGhlIGV4aXN0aW5nIHNoYWRvdyBkYXRhIHJlZ2lzdGVyICdiZ3Bpb19k
YXRhJyB0byBhbGxvdw0KPj4gdGhlIGxhc3Qgd3JpdHRlbiB2YWx1ZSB0byBiZSByZXR1cm5lZCBi
eSB0aGUgcmVhZCBvcGVyYXRpb24NCj4+IHdoZW4gQkdQSU9GX05PX0lOUFVUIGZsYWcgaXMgc2V0
Lg0KPj4gRW5zdXJlIHRoaXMgY2hhbmdlIG9ubHkgYXBwbGllcyB0byB0aGUgc3BlY2lmaWMgYmlu
ZGluZyAid2QsbWJsLWdwaW8iLg0KPiANCj4gSSdtIHdvbmRlcmluZyB3aHkgZG8gd2UgbmVlZCB0
aGF0Lg0KPiANCj4gSSBtZWFuIHRoZSByZWFkaW5nIGJhY2sgdGhlIChwb3NzaWJsZSBjYWNoZWQp
IG91dHB1dCB2YWx1ZSBpcyB0aGUgcmlnaHQgdGhpbmcNCj4gdG8gZG8gYnkgZGVmYXVsdCBmb3Ig
R1BJTyAoaW4gb3V0cHV0IG1vZGUpIG9yIEdQTy4gU28sIGluc3RlYWQgeW91IGNhbiBzaW1wbHkN
Cj4gY2hlY2sgdGhlIGN1cnJlbnQgZGlyZWN0aW9uIG9mIHRoZSBwaW4gYW5kIHJldHVybiAoY2Fj
aGVkKSB2YWx1ZS4NCj4gDQo+IE9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nPw0KPiANCk15IHRoaW5r
aW5nIGhlcmUgd2FzIHRoYXQgSSBkb24ndCB3YW50IHRvIGJyZWFrIGFueSBleGlzdGluZyBjb2Rl
IHdoaWNoIA0KcmVsaWVzIG9uIHRoZSByZWFkIGFsd2F5cyByZWFkaW5nIHRoZSBwaHlzaWNhbCBw
b3J0Lg0KSSdtIGdvaW5nIHRvIHJldGhpbmsgbXkgYXBwcm9hY2ggaGVyZSBhcyBJJ20gc3RhcnRp
bmcgdG8gdGhpbmsgdGhlIA0KYmV0dGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRvIG1vZGlmeSB0aGUg
Z3Bpby03NHh4LW1taW8uYyBkcml2ZXIgdG8gY2F0ZXIgDQpmb3IgdGhpcyBoYXJkd2FyZS4NCg0K
UmVnYXJkcywNCk5pYWxsLg0K
