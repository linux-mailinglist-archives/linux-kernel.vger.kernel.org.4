Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370DE6F0EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbjD0XHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjD0XHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:07:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B322D55;
        Thu, 27 Apr 2023 16:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzCI2N6wmddx4ndRNtu2w+jTg3IBqloylaST+HaFOvjZsxWCWZSvwa3gnfvd3lLOXGpaDnjF107tzz/ulyY5/iop4On9M6dfwbAa+Pyz1Ngvrm7bCEcH2tDRpvNtUfIwrWyKFri9MJpkMJXAe9g4L1Kgu8AbO2uYgFTL4+FA9AvVovZHOG6IcrCswqUGEg8BjSqKJK+JokfwLwJVWMiiiIa12pL3matSYo78JT0yi39QGZTi477n4HEp38EJhfecv/y234Hpi18heLIE830P4oMsdi2dAooCprIWUMYuqmREpHQbBDSsDOoTK2nObi+5x7IwtsyCv4lx70XQBKmiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KytkZceLG+Lfdl9ATgUzLC+fWNHYsX07LOThyxNafVE=;
 b=QUMT2JRxAmvflI4SpfugCQHTd9pPmPzqn7xTX36CCaBL1Rn4rc86Q/YbzJ93NdEhrjpvTPRbzYgKnXjwZuTli/QwuLQRlsICK1/+YyQML8cr+69a749oR7LorP0sFwmscS3iiHuOlT+71mmuNo3Il7b3ep2T2tqxFMc6pNJTZh8XrssNp1fSsmnv1j80oE7pAi/ZJTfmgVFUKbuGkSCuFsxfculH+GB62EQP0RKlK/eo/3pm2o13Yzf8FFnVfsuHI/BS9xou0NnNFIAPkm9U3UgzZPiHYLJkTvzU+7RkvFKZUaZ78e7i/aXxXU6pHFG4BJWsgJuorfa5KkXcdJ71nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KytkZceLG+Lfdl9ATgUzLC+fWNHYsX07LOThyxNafVE=;
 b=l+DqZmmm/QbK06PM9lpmDQ0y/F846U2x3Al9BTu2r2La7oGVteHH0JXW7qBwDxHgkcKbsASY3BoiY2+kFuk5t2TysopP2qCJUMjpb4UCMgmeLChH9P4YDiAn/iUOspFeCVKSz0m+4pteJc0YuF35gyphwMJWB2Cqhc9RfYUil2vPSkMtKSolCpo8TD10UXxBDlvNEphuWPnoZj7JCF5YyVejx6mEYDGbFOJI3SEFrJcO7zgXZw3XQ5sd5VSlfLqtdVtjd2SKSQLcP32aLpMQJ7/1r6QUcSV9az7cgSALo7F5c8fU2bovem4blrybawmyMoTYgHTUkeC0ebuRQBwZQg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Thu, 27 Apr 2023 23:07:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 23:07:43 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Topic: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Index: AQHZeUEoV9vRcEcRDUeYawN1RnJsFq8/xVEAgAAAdQCAAAHcgA==
Date:   Thu, 27 Apr 2023 23:07:43 +0000
Message-ID: <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
In-Reply-To: <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6559:EE_
x-ms-office365-filtering-correlation-id: cee75ae4-ec56-4644-cd8f-08db47743521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yM4mUul1RkSAlP4H85iffAKzOcTiLveFPxbFsvdrb8FWybQ6vOdyK/91luFmuGj+oNWO8MinQxJbrxx0avHZrkaWGSgn23fL8/Toqxs1ye2iBmQBmJ10/zN0D6ex7ey9O+R5giIqZehmHiUZn9kRP3b3EA2HBBNks4qnevM8UlZnRGC2YLf6ymIDfV7XTDjaZkvPrTbaZYs7c4445P3gFSBW8T8LUzDUfTEP6E2CB3fnyxgaNxi9Yl7ZWFXgDuiaueWEzjb1kJwsM2ZNAayBO+ScpbqGAfIPR3CO2eA66PQ9X4ADL9mPJO5ka4tGh2I1NBLixU6cedgh1AJfpxInzyuj2FVFXwPcEQt3aT72cxJ46cEIpUfuvG9I73THMtQbJB4MMSfNjbyXvOtDvD/9v/Z0PNkOES/WI+y/PgvnFYqlZY3XqWpTqsua16qi4NXzNT6KxvqDGnYio1KpgePbRNhCexyDPzMsh2+A3p81n2cV/S0NUYTIVrSINHqw05KrnNRxXS8kGq93Mu5iU2B+KqgMjRSahVzY7vxoqEs3QJxClx8gvqpKoHKaVfLtF79hOcTlAkmTqzbo3y5e0EAVhniKy0aeNZFDHNbcudfS5fjMysMpZMovKGKvDPlt+XFwXlEEvVGtcZYlKQffrmG9mZZF9UvmlS9IWAgZMGHPhA3c+nrdJLNV76PR6TmSX+Oy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(53546011)(86362001)(6506007)(31696002)(64756008)(316002)(4744005)(66446008)(2906002)(66476007)(66946007)(66556008)(38070700005)(6512007)(8936002)(41300700001)(122000001)(8676002)(38100700002)(5660300002)(186003)(110136005)(54906003)(4326008)(91956017)(2616005)(36756003)(76116006)(31686004)(71200400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3dYVVczQjd4T3k1NlVyeUNLbEJoM1Y0dEZOYlR6Uy9TY2JiVGNXaEVWRC9C?=
 =?utf-8?B?Q0R0ektYWWlBVUpBRXRKSzFDMnc2WmdrZjVaTG80Vld6b0Fsa2R6akRtd0hO?=
 =?utf-8?B?V1dDMHdXRVUxbVpTOUdnL3ZWQnl5NXdWcExuOVNCaFNPanZQQWJRY2RxdUg5?=
 =?utf-8?B?VlBVMU9rZXBFUHJGekdjTFpMMzFaMDZqODNVaGVKSFF3UGh3WmFib0JOUDNB?=
 =?utf-8?B?NWJwLzI2OStKRSsyZ3BKUHdKdnRsK0NUV3Q2a3NwbHUrWmVra0lIM0ZhOFNs?=
 =?utf-8?B?Nnd3c0ROYnZkbis3cUpLMTQ5cXFyWXcwOVlLSzZLNEdCYXBkR21mbjlYWVI4?=
 =?utf-8?B?QmVwNkFCN0g2UUEvNTJBSDVaTzZIYXluV1BaQ1A4QStkMzlVMjRtSE82Rjg3?=
 =?utf-8?B?WWZ5dEVncmpaOW5EOXF1ZndhUG1UT0ZDNGZnRGJ0MnhoN3E1ZU1NVnhEMjF5?=
 =?utf-8?B?YjFKTm1ndkJoNUNvd0VJWFNRbUZBc2J1azdBbXVTQ05EWSt3T3FlRWNVZEFa?=
 =?utf-8?B?RzBhZFBWTjR5K0cwN0Q0TGpkZHZwWTRjVi93cXBXa25KMTZoaFJ2c0s5TzJv?=
 =?utf-8?B?NnNoOHA0RE45SG5LcmQzVXFESXNFclNac0xGV0JqekFranVmclBLTkJBeWdh?=
 =?utf-8?B?QVlBVjIwc0tGeDI1bWgzcldRMnZFbmZDTW1VbTFlRklmZ3QvRzd5WStPYWFp?=
 =?utf-8?B?SGVZVmc0Qm5yZWNSZEJ2RnpValcyWi9rdjVCRFBNU0Y1WGJrWVVoL29rN2Yw?=
 =?utf-8?B?bUgvUlBxaEFpRTZxNStoaHJoQktTeVhqOFJWcStXMzNnVFkvc2JkTE9FYTNu?=
 =?utf-8?B?aHF5TFhTTTNIcnFVZFExdWxLd1NKMG8xaE04WjNBVGxQTEtjbFhGWDh6L0px?=
 =?utf-8?B?dkZYQklhTXFYQktVS3dzS21GbkNnZWFMR1h4TWkxNk1INEk1ZFZIaXQvT3NQ?=
 =?utf-8?B?czVva2JpYnVHQzd2bDNXNGlJNVhwaVo4enRXeU8zczVwKzcybng1U1RNK2Yr?=
 =?utf-8?B?bmJ3R1luNnBXdWtTeVExRlZreDZFYW0yYVdlc2tpMkhhZGpNVVJrQkFMaW0w?=
 =?utf-8?B?MGNFRENLODdhdjJBVmV5NVl3djZzZGVhT0JRcVpNZktuTGdEWGlWVURKWW9L?=
 =?utf-8?B?SkhuYmNpbnRDL29SQ1J1N3VIS0NVc0QrbXQ2RVUyNkZ4UE1uTFdHTitZOW56?=
 =?utf-8?B?RzJhR2FneGtCMHpiTEZmY29XaEFhd3lvZlhsUEhWVE9WYUx6S3dSayt1RDQ4?=
 =?utf-8?B?dkFQSkErSloxWGVZN1NmZmZTSDBJMzdjck4vVm9LaytyUnZjc1JjVUt6WnNs?=
 =?utf-8?B?amdka3UvNTdhK1V2VnJsNkRXMVVQRGNGTGlMM3RVVmVGSDU3Y09wUFlYdjN4?=
 =?utf-8?B?N3BCcnZjSDVaSXozL3YvVC9qS2lQdlovUXBGY1R4S1Avalh1ZXNiUHgreU5m?=
 =?utf-8?B?TWRZbjh6bk9pZWQyTHpYNXZVNUVVVjcwL0svSFlYazlCcXR4T1RBaEJXc2ll?=
 =?utf-8?B?MndxM3FFaVJSUUc5cHNTUUpZTWpQWnkxZlNNME5PUjFsMTB5NWZFNmxJa01X?=
 =?utf-8?B?OUpCeUVjTlg2aTRKUm9uNjRpdERUT1h0Q3NDRCt6SUZ5UVU0MjFyUDVYWTc4?=
 =?utf-8?B?aWtVVVgvUFJOMHdwWWgzNEdqT1JtcG12aWN3bGxCU0lTdEVzWWtPZ1dQZEJk?=
 =?utf-8?B?YlErNUpJZHJ0WjIwajlzZWFtRlBMU01HYWdkc2xNOFFRRTF2L0toOEtySkxw?=
 =?utf-8?B?VTBmRWNnUmN3c0JaUjl2M2V2WHAvWlVEaGZTNTlaczkrVUFvQk9hNW03RmNk?=
 =?utf-8?B?MUVaVDhlRE1mVGtkVmxSVGRkcG9kcmhKTjB5Wm8xL0dYaDBvd1RjQWg5Zy9h?=
 =?utf-8?B?L0g3bXVZWFphUWVMTXZ3M0NZVzJ0TGpyZTNpMHQrTC9Pd3NzSTIwbjZuNE0z?=
 =?utf-8?B?cVBFT0pmV2N4ZEIyVndHdG5iMHFSYUlBZEEzYWd0N3p4bTlmWUNWNjBwNCtW?=
 =?utf-8?B?Z2V1WDhDUkl6LzJVWThLNUNhWHhCVHRVTFU4TG5LbmNCK0pFdm1ybVErMWt1?=
 =?utf-8?B?a0FaWmFrNWwrV2JaQlZGb1QrWXJkSHJic3dENjFqMnFleUlIUnRkdUxOM0Qy?=
 =?utf-8?B?akFBeVN0bTQ2bklPMmI1TERRWGUzeEhzUHVhODZaa2hqQ2srZXNFaW05ajl0?=
 =?utf-8?Q?V66t3MXv5liBDwAWiKm/ilGOfUTN+QMrBv24CsIEMhdi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1E845470A56D14CAE6F44E166513129@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee75ae4-ec56-4644-cd8f-08db47743521
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 23:07:43.5890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /q4Zd0qDmnjv9c26Ze/RuCHlu+2IotEVC7TJj19zceQ8RaC3vB/ysjWX225t0V1TBjLOMgdnnFmP5ea37b6UjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNy8yMyAxNjowMSwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gNC8yNy8yMyA0OjU5P1BN
LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiA0LzI3LzIzIDEyOjQ3LCBDaHJpc3Rv
cGhlIEpBSUxMRVQgd3JvdGU6DQo+Pj4gR3JvdXAgc29tZSB2YXJpYWJsZXMgYmFzZWQgb24gdGhl
aXIgc2l6ZXMgdG8gcmVkdWNlIGhvbGVzLg0KPj4+IE9uIHg4Nl82NCwgdGhpcyBzaHJpbmtzIHRo
ZSBzaXplIG9mICdzdHJ1Y3QgbnZtZXRfbnMnIGZyb20gNTIwIHRvIDUxMg0KPj4+IGJ5dGVzLg0K
Pj4+DQo+PiBBbHRob3VnaCB0aGlzIGxvb2tzIGdvb2QsIHdlIGF0IGxlYXN0IG5lZWQgdG8gZG9j
dW1lbnQgd2hhdA0KPj4gaGFwcGVucyBvbiBvdGhlciBhcmNoKHMpIHdoaWNoIGFyZSBub3QgbWVu
dGlvbmVkIGluIHRoZQ0KPj4gY29tbWl0IGxvZyA/IGlzIHRoZXJlIGEgcG9zc2liaWxpdHkgdGhh
dCBzb21lb25lIG1pZ2h0IGNvbWUNCj4+IHVwIHdpdGggdGhlIGNvbnRyYWRpY3RvcnkgZGF0YSBp
biBmdXR1cmUgZm9yIHRoZSBhcmNoKHMpIHdoaWNoDQo+PiBhcmNoIHRoYXQgYXJlIG5vdCBtZW50
aW9uZWQgaGVyZSA/DQo+IFRoZSBjaGFuZ2UgaXMgY2VydGFpbmx5IG5vdCBnb2luZyB0byBtYWtl
IHRoaW5ncyBfd29yc2VfIGZvciBhbnkgYXJjaCwNCj4gc28gSSB0aGluayB0aGF0J3Mgc29tZXdo
YXQgb2YgYSBwb2ludGxlc3MgZXhlcmNpc2UgYW5kIGFuIHVucmVhc29uYWJsZQ0KPiBhc2sgZm9y
IHNvbWV0aGluZyB0aGF0IG1ha2VzIHNlbnNlIG9uIDY0LWJpdCBhcm0veDg2IGFuZCBzYXZlcyBo
YWxmIHRoZQ0KPiBzcGFjZS4NCj4NCg0KZGlzcmVnYXJkIG15IGNvbW1lbnQsIGxvb2tzIGdvb2Qu
Li4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCg==
