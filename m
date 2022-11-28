Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8663B245
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiK1Tan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiK1Tak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:30:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3152CC92;
        Mon, 28 Nov 2022 11:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kenSg4xtynATy+7nCx48nrR3BtTPCRaTLcsFsbmPOCtWIvzTOf/KS/KxCT/8K4Wz5FiHplHXBSPlXigAC2nKKDJsO82O0TJyrfx4GDiwm532t09RrD6NnkUio5VrwTHmcCggtL7gowBI0p5Un2uVDdKdOY3xcmi0hAMJorU1dAF3XVm5FJzfziwZu3wQOAsNwBDn4xB6PSYb2rrs0YQaFNxx0SYLnISC0Okv0MNQ8I08EQAYFRFayCPR41qb116w/1aKWmV9PmWy+NVJuC5KeLq2RFWgLstzqNioqfZ/iH0ttjfPpq2MkFJsK8LBRjM+zbF9r8rL0nzihsqOXpcPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7xTwR+tLudXnOyCnur7jkqhiUlGqKKlfwpmGxWoUBo=;
 b=miIYfxKT2YNZVD9QNvdCh5nECsVRrBho+Umz00UtA/cj05PJepEGGkrtH6h1wIzhccX6gPv6iC1iSg+/oG3VCXTAEOZoo9Jr+pcBepBzdIfWlXMe1w3cAJ9qlKNubqTptCjc8oqO1HHGtOn8NljSmJr2V7VweQJtBYqU/EiXWkx54+adqMAfoo2kzQlabiJU9Gwl2GnirmllrU0EyRFrNr6BAN8VmsCPHXl9bTKTru//JWdASW+WIgyuqCBAWs1OdGFCMY56bJNf2ZHdb5oTwZtoFxoRDZTdHGHikg7DUmpzuRn0eukClBJek2kYGG6SUWeXR9fRoy0urojoWwBhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7xTwR+tLudXnOyCnur7jkqhiUlGqKKlfwpmGxWoUBo=;
 b=LFU1YJKQfN8NXmwLT0aChCstQd1F8/rU2/MPhqd6OejA1rBQ1fWj95AZFIfVumcTVGEKaHxVaiWxLSXsZqHzXv85qnkN1cZP6pvehuER/2mze9Od/iicQfjPnJXsuncZFpsH6gfS14/Cdc2+zjN+oNjwmkhDO/5Y3eo6VubUC+x6HB3A4T6k2WklkjMUYZBTLYZPJOzkkJWEX0s71K26CynLSyrfZUU57JS3EaWrABYqmrWyhzlphDRHn9cKUGODwTHvJUH8ZhdrMF3M+YDQtHJwJ/SGhO0AXCsSZbVpQvgfEiuk0ZYNzyxKIg99asqRHj/dZi0uuX9aE9brqEBn1w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 19:30:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f02:bf13:2f64:43bc%7]) with mapi id 15.20.5834.015; Mon, 28 Nov 2022
 19:30:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     KaiLong Wang <wangkailong@jari.cn>,
        "mikecyr@linux.ibm.com" <mikecyr@linux.ibm.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: convert sysfs snprintf to sysfs_emit
Thread-Topic: [PATCH] scsi: ibmvscsi_tgt: convert sysfs snprintf to sysfs_emit
Thread-Index: AQHZAl3+3bbnBGp/Bkic3dxZb6o/sq5UuwyA
Date:   Mon, 28 Nov 2022 19:30:38 +0000
Message-ID: <b32f761f-9fb8-40ec-174e-011ee5f69625@nvidia.com>
References: <483482fb.1d3.184b91dde72.Coremail.wangkailong@jari.cn>
In-Reply-To: <483482fb.1d3.184b91dde72.Coremail.wangkailong@jari.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH0PR12MB7960:EE_
x-ms-office365-filtering-correlation-id: d8519d75-9b9b-43aa-4f42-08dad1770771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tzWlqGzWT6gHILXvlsdvHTHgzU/Y4LqTVVXLEOFRR3PXqN+rS45Sn9vNB/Fj8V7OH39MfiphzLh9N6jRYEEnSofODO/j4U7+lheqXJkb9BwbfyhRVpgPQZcqzOUdIKxpPLXqYACWPogdpYpx8ksRfaof6nGyFmRs7ynmzdSq+sU7AEJu8WvwXXNCdkQwaxVMixK72S5v0Wm0zq2xN5go6vjKtcO1rXaW+azJ+oQ/6HdtwGIY0RyRgT1V6Qk1vjsklJj6yVF9IamsgtiicCCSiiPGYrFR8mJz1oV55S8RBwPftN8JU76TxRbyxW/Sx2zPxBu5lq1m9PUpnZugq9E6SGFhepu1p3R3yAKQ8jZCR1p2s9DjgKc6vcb7MrglRe5rhf6B91Ang0mh86ld6vr7C02zlwArksGM4LzCj+c97ilTs5uNxSNQWRmlArevvcMO7YUeBlxXYs3Gy3HTveX8UJ4lNl1cISrEy0OUGrxD5if+3Xz+OOPARY9NauChXAi6Sjv7Piqd0BzAav9FIu5IqzuCPaFJyoc7THv0NbPN4r8v9mKMTubgzJbe/m5wJF+OyDL9uo5tEUWWNtZYynoZu2XOnoiD+5YCw8LwZSOmlojrcOGYYf8xr9l0qfPRTd7qKMoZmLUb9+FVIzQP5HaRYQswZuyHmFLxH5U4SUFzFMKw3Lj1faP0I1XhLjOFyfGBu1WpPU+j+uVUlkDB5xPTapy9L1l1K3XipUFGlDKqNzOmtl62yJOQWA/Tla9P385gSWw/HHmTEkzlnKy/1ylNaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(31686004)(2906002)(4744005)(91956017)(316002)(41300700001)(36756003)(5660300002)(66476007)(66556008)(66946007)(76116006)(54906003)(71200400001)(66446008)(8676002)(8936002)(4326008)(64756008)(110136005)(6512007)(86362001)(478600001)(6486002)(31696002)(6506007)(2616005)(53546011)(186003)(38100700002)(83380400001)(122000001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTlQdjhMUk9mK1R1NWV6ZTNPWkExWkpEbzFNdUpxZ3REaC9XRmNMNXpYK05w?=
 =?utf-8?B?c2JYbHlFU296eXJhK21wc1pHKzE3MWZTUlFRNG9SNGEvQVRpUTFMakl5azg1?=
 =?utf-8?B?ZlVVeFpwelhIQk1oN0Zhc3VRWi9VNWZWK1pMM3RranZYTG5QaFFKUitkYm9U?=
 =?utf-8?B?TEw3dUU2c0JaZU9GemdCR0dpTm9aZWYxS0xDNGVYU3JybkZqempzVXNjVEtv?=
 =?utf-8?B?anl4WUd4WHhHSXZQV1d5Y2g3NUlVa0FJdEJFR0NlRDM1ajdId0ZZZ1p4WTVJ?=
 =?utf-8?B?SmRpYUMrdjJnVm1UREVvVHBpRkZDYmxoMXM3TlJselp1bWRHaDdDZmtwSis2?=
 =?utf-8?B?cjlaVkJ2NDgwdG9KOXJDU2lWbUpOSmFxZnZQTkhXWHhoZ3lKc1M4UHRLaUxJ?=
 =?utf-8?B?MXJBSUU1Wm84SXV5Z3BIaFNrcjlIMXg1ajNmMDlmZ3VEM3M3UmhvbkJ5VFl1?=
 =?utf-8?B?aldsVlRpVTZkNEFQQjJSakRoUDNPU2JCQUY2SW93Wmh5TnpGYjlYTFhvYW9E?=
 =?utf-8?B?S2hhaldiTU5XMFd4eGdzSEZnVFBtTUZFWG5iZG9UMUpWYnhqcEltTkt6ZEZX?=
 =?utf-8?B?M2RiQ3B2bmtnUWNySDE1VTVSQjRFTGlSRCtLVmNTNmRWMGNtZXBjNHMva1Q3?=
 =?utf-8?B?dGdWYjljS1lXVEhwZmlsUUR2cVJBM0NXTXltOFNTK0dqL2dZOGZrMHAyZmFY?=
 =?utf-8?B?TnFCUkVVMjRGZHVadHV0NFpERUFlQXU3V2R3TXRFcmRDbUJZY3FiSGdVcFlX?=
 =?utf-8?B?YmhBb0hFZWEzUUlHK295ZXQvaFdhOENQYSthQ2R5RXpGK01FN1RzV0M2bU1a?=
 =?utf-8?B?M0Q3UTVNYW1aN1MzQS82Z0M2S2ZrOWZwbFc2OStMaU9kMzljWTFPbkpGRmdy?=
 =?utf-8?B?MFhBZlQxNWlsLzhXd3phOUN0eXhWMjBNWHpOUDZQK0V1Qy9PcFJuT2x1MDlY?=
 =?utf-8?B?TFFmaHl2cjRERzRGYW5RaE1YeWNFeWdNS0JMeVJzV2xTRUp3N1FCV2EwRDhG?=
 =?utf-8?B?QnZRaStRbU1LRXUyMkN6cWdRRVE5d0c1MEFOT2oweExuUXN4WTBhSm1sQ3VZ?=
 =?utf-8?B?ZDJJLzd1cGFkdmNBSVNzRUx0ejBWMXVzNmN5RVkyT2VqSS9XU1hEYjMzaUlT?=
 =?utf-8?B?UTZYbkt3djltVGNvOHlmZkN1dUhnRGVWV3Vsa1JFNGJUcmRRSkJsS1hPU2hj?=
 =?utf-8?B?VzNkcGUzRVZxQUlUNmhYZ2wwdnlBUkF4dHZQcUVkZ3pDUUcxT1E0T080Tkxl?=
 =?utf-8?B?QWVsSnMxbTljSUdOOCtHM3RzR2l6dTljYjJSNnN1V2kyYk4xcXZjSGsvNFpP?=
 =?utf-8?B?dlNXUUcxR1o0SjlncU5RcGF3Qko1YlpoSW96UStpdFhjWk1qOU44S294R1Bu?=
 =?utf-8?B?R0dIMWt5N1FPempGMWdqSnVleTdaTHFpYnFNd3Z1bzQzVVQvMnhmVFFLUDBW?=
 =?utf-8?B?aVR3NVRpdVlYTlIyd29ZZkpRVGdBOEkyUE8za214Mit0cU1KOWlqRy9IYlE0?=
 =?utf-8?B?YkNwRjVBOEUycmZJMnQ3SFdFeVFyQ3RYdEQrYWg5R0doRkNMREw2RjhNdXlr?=
 =?utf-8?B?L2wyL1k2bDBmSlJlOW9WYlFKMXVVbDZMVGVwRFI4NkJMMkFpeVVsa1hNVEY0?=
 =?utf-8?B?TUdoVXF6clp5WTdOdEN6QjA1V0pobWIxenRmdXUxbFRYTncrVTArTldGY2sx?=
 =?utf-8?B?dEkvYVcxaTBFSk1TbSs2OG5COTc4NHgxTFZuaGdpRlNZTmUvM3BSN1FXczJu?=
 =?utf-8?B?YVpsZjMzcFBFK1grUmhHdFVPWjZjV3Awbi9ZMGx3SmY4a0oxbzEwTDUxWjRv?=
 =?utf-8?B?N29vdjJGNUNsVnpad25CT2xmTW9lT3FkR3JvbCt4R1NpTnFkb1NramQySlhj?=
 =?utf-8?B?Sk5TQmF1TVgreGc5MUVDd2tHY3hjU2dOQ1RvaUFSZkxCQUFBNVJyejRsVXhO?=
 =?utf-8?B?OTNuOFZiTnJyWTZlRFZhb0ZrUWxUZmFWR3MxS3dzOWh2NGlORTBKdUJlUnQx?=
 =?utf-8?B?eCtrMUpYTXdpdzNKaHplckh6YW5VL3RwU2lrRlBCQjVFckZ6K0NLNHV2K2h0?=
 =?utf-8?B?SWh4S2JCa3g1MEFlMnprSUNPMDlmMTNYNDZSRVVWcCtCTGM2TmMrcDFJYkZ2?=
 =?utf-8?B?cjBmK0JNOTd6K0R3NlAzeVNOS0VIUmUvRDYva2ZNVHdmRWU2VU44ZjFxUjVs?=
 =?utf-8?Q?pMceEcabChIYI44Ss6aEZOz42TmVXOXHj4eFoMLAewOB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32F812B3A35C984CBF59086028501C7D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8519d75-9b9b-43aa-4f42-08dad1770771
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 19:30:38.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21EJySiKokdBUC7o6ohoXYyn1Nbu9CFlzZDMGeyG0tKdJZ1sBMe8snIzRoQQzT3R+BJDzW+/h7YlFFqqs+GM6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjcvMjIgMDQ6NDQsIEthaUxvbmcgV2FuZyB3cm90ZToNCj4gRml4IHRoZSBmb2xsb3dp
bmcgY29jY2ljaGVjayB3YXJuaW5nOg0KPiANCj4gZHJpdmVycy9zY3NpL2libXZzY3NpX3RndC9p
Ym12c2NzaV90Z3QuYzozNjI1OjgtMTY6IFdBUk5JTkc6IHVzZQ0KPiBzY25wcmludGYgb3Igc3By
aW50Zg0KPiBkcml2ZXJzL3Njc2kvaWJtdnNjc2lfdGd0L2libXZzY3NpX3RndC5jOjM2MTk6OC0x
NjogV0FSTklORzogdXNlDQo+IHNjbnByaW50ZiBvciBzcHJpbnRmDQo+IGRyaXZlcnMvc2NzaS9p
Ym12c2NzaV90Z3QvaWJtdnNjc2lfdGd0LmM6MzYzMzo4LTE2OiBXQVJOSU5HOiB1c2UNCj4gc2Nu
cHJpbnRmIG9yIHNwcmludGYNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2Fu
Z2thaWxvbmdAamFyaS5jbj4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
