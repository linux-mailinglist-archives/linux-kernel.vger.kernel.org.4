Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB26F54D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjECJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjECJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:35:14 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962D4C1E;
        Wed,  3 May 2023 02:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz6Qo3NGVAn5CdH7YQXRoxCT8voHKuUv9iipYsBgNknmSiXjoP12fnyai8QmTyYhBW+ZzBjcBIQ7YbjgGAbzA/qaSC67yVddg6dF0CrRG5YiXS667zpG16ZyfXkR7mnbPGDbP55sSGpBfyyZkmQrXNdA443UTeL7G1Zund7Vm2Ci8U0EgJM5Nx6pUAGJfhAnAHkKvr7fo3JA16EOWddFV+A7G5ptiNu1n6AqEL7eo6Ux66my2kc8k27qUe0XRawKQ8C96wLDDGx6tNBGUpvfKtN5K454C80ZVcDW9+I7ajmDoAjPXFGJekFgb7w2GIZrHoU+jOMPhhB9EDsBzibCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwRKbD9j13BqXxdlo27yaWPuC+AqX+pA14l2v+Y5aYc=;
 b=oa13lFMBZXM06hKzL5ocH3zN52qJAwy3tJdcQtoNiYK6xabnRrtOZ0+Wndr6r0/kyCVbm60hHfFjzfLU40XsSzVoIAHMfGVY5Nc6AiZEFX28awbO7HUyvnXike+NsYBhTNlfRGJj9Mdq1xwKQXloHoZa8W6S3YN1aKE9YPf7RkQ5NaJzQXnVc7qESM5xjE/LdYI8yOAnqUgB0vJ6xTgqbSxaEC18TffIsefIOhSgjf/ZunLDmm5ZLCdqnvXYdSZwzUTjCqIkKFQCJE00xDaS+N47UHMDcOwQOqWP1Wy1wd82NdXO2IX9uiTKRIoC0XP4Y9gltjzFa9rnEGTvWB3gmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwRKbD9j13BqXxdlo27yaWPuC+AqX+pA14l2v+Y5aYc=;
 b=fqDA1rnOkTKGnTkQ2RZoh2lgwxUrq6gzAXVku9l1EfEGPzV7n+/NiDnOHkhAGdlGiUno/EDIGdX2bZQx2fNH7s5o/H71zZVG1/N0VqUegiPw3Y2k4pBVu8Z3aa7pJ4WbDPBl0IhsMLPGc1ZZzGf0vxCGJA29xB4P+CP5H/D6mRXer2CjGkErL06t5ouNVMWydMnhujjXbY8PWjCjNisYNHfnltIrFUaVHEQIYRpjjlAhpnNPL6XY1dxepddFEWxEHo+L394frd4fBsr//UUCQ7sedxoZjPmf83pxVxwneo8O4FNQDcfIfYj8aH9gI6GA66Y1ahhCeCk/rmE/DfIVgg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 09:35:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:35:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 08/12] nvme/rc: Add minimal test image size
 requirement
Thread-Topic: [PATCH blktests v3 08/12] nvme/rc: Add minimal test image size
 requirement
Thread-Index: AQHZfZW3rKHbV14v0UaY2vVO0EPoUq9ISe6A
Date:   Wed, 3 May 2023 09:35:09 +0000
Message-ID: <e75647bd-4985-8919-e97c-fe96e30438ed@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-9-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-9-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7130:EE_
x-ms-office365-filtering-correlation-id: 8662d493-c72f-40ca-7987-08db4bb9b026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePL3MVWzeN27M6taS31HpJYJF8fT/2IunC12WGZ8uDbH9WPGYxV3b3IsZo84VSMFKhfAVPai6tJAcr8RvmdgY2eWmjQgvnkdXI5O/S+XzOd4dMYT0oz/BhZbzHYLSkkKQnLxhONjA1/FDVF49SN2jd6OKE+8wYw64odsQLSukvnJYOvWPObqsPx9XljTpMzZuR0a7+CV5fQAA5wEtMFy23SvfTMxLv7CEwixFV8T5CahuAFySR6P5T+vNRcUK0kWvn+40kk7suP8VkWwxPpihQ6geOcrLqejO83BLz1k4ebO/oMRfyO3WSHY02hQKMUIy9IL0kL+oaxPsK4aP0ae3p27KQDaexys0OqF/K3RQdYIbFaA1+lxsWFozL8avyERyDYd7sC+Ze9FhbKHEhiBv3BQp8XZayFRrlO/1LiWGKpNl222FTK40VNzVCBIgmra4mCNRyXnuwNUel7x9HOYeT65UB7UOGL0PttH0wXja/X5A3Js9t4wGx+pgaNwom1kYlSjPWZemgq4nLboZXojRpdWDGoklFcjITJnZAAFuFQIkl65h8lxUXdsxBV25BRFTjChuT+ONrxPyo7I0FcAc68CH/WoYkWTbFjzoOyy3HGQmm2QIWRTMBu+2InjS992cgGbW3oweueZOdbhLPCqe9Oq9FvGEEGgwYFvMaUSkTdFbPw3iFB4Dw7G0KXZv+Wi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(38100700002)(2616005)(53546011)(6512007)(4326008)(316002)(6506007)(41300700001)(83380400001)(76116006)(54906003)(91956017)(110136005)(478600001)(66446008)(66476007)(71200400001)(6486002)(66946007)(64756008)(4744005)(66556008)(186003)(2906002)(122000001)(36756003)(31696002)(38070700005)(86362001)(8936002)(8676002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEhVSWlpUzBEaHM4Vk81ZXZEY20wVSt6TmR6NU9lZWJoKzNXR00zR1RBdnVT?=
 =?utf-8?B?QzhvQk5qVGtVOWlLRmpSRTVaKzBsUTVyYmFvejE2WmNPekNzRDUveFRkakdk?=
 =?utf-8?B?UGN1WjRhaXg2MkhYZEFHT3k5YS91RVJlKzJ0MEVDaDV2MXFOQlRUaFBKNXE2?=
 =?utf-8?B?bm9UVkhuUGsxWllRdzJQajFRT0ZUS1hYMWw5L3FkTzFsanNJWE9RNnlrMEZQ?=
 =?utf-8?B?Q3lsNDgvaHNhc2h6c2pqOTRwSVpHWTNxZUdoNUtrKzZac1pWTjdCbXBaaUd1?=
 =?utf-8?B?TFl5Tmx2Tm9WRjhpZDB4TDhvdCtqUGloUXcwYi96K2FkK3BVVHNwVXNnTWZE?=
 =?utf-8?B?Zk0rMWZyWUZKaklyWFV1OVJ3ZXBISCtJMmhMNFFPUndKN3U1eUpZVFdBUitN?=
 =?utf-8?B?K3dCTFE4bnUxSW5RTllueVRFeGFvMUNBa0NzT3pEdkloQ0xOOXd4MVhjanFq?=
 =?utf-8?B?cWRWUnpWTkxjakkvK0xsLys4T3FoVmQ5VXFaVk1GT2cvWVJtWTZoTm9oNlZR?=
 =?utf-8?B?WFBIbE4xcGZLcU9UalZ0SkJOSkNab21xbFk4S3hQVVJObTJUVm1MbGd0Qmw1?=
 =?utf-8?B?ekQzUVdqbFdzNnpBZldrTnpidjBIR1FwMHg2RndkVXNjN3cwbUJaNU03ZFVD?=
 =?utf-8?B?RmZPdGpFbkVFZnlaVGx4WGcrSFJ3VVFKTnBGb05ndVdTczRDejRFNTFFb09p?=
 =?utf-8?B?ZXZmZ0NhZ1ZRaXdZSlBCUE1qRkNCVFZUYnVjTUxqa0NBcy9lS0hlMGxUYWU0?=
 =?utf-8?B?aG1paFIvWFVINlpYQW1BUUhxc3l4cVBQUmJhZ3hhRlcxRnNYWm0zOUo5eDdo?=
 =?utf-8?B?MnZlUEl1MS9OTDZtZDNjd29VUmQ3MWdCRUp0ZHVRTnN3NThJQ3VZSTQ0UVNZ?=
 =?utf-8?B?d1RoZzVqeWNKbm9DTGVQVEFtWUEwRDZrVjdQUlphZUxBZGdTVDREQkZER0RH?=
 =?utf-8?B?QVYrNWlJSDlnMHdPZlRrWWRXZElzdzhuNTBGalNLeFdsVExFVHRQRW9lQWky?=
 =?utf-8?B?eHFYYTB2cmE1dEdVZ01Jd2pYV2NpMUp4Vk1UT2hIM2hZa1pUcFB2Z2RRcjd4?=
 =?utf-8?B?RkdDUk56eWdIbFRLbTRRWG1pNUVNdWt4LzF3TU1mWFpoUUxZcFpMWnhvQzh1?=
 =?utf-8?B?anFVNGtYTUlmZUFiYTBVbjdScXBPRTlvQTYrbTNRTDVCQVBrbDNPSCtydzY3?=
 =?utf-8?B?V1hRR0lqelZraldWMHZZVmhzak01Wm51Zmhud2N4R0dJckcyQ2wwOXh4R3JC?=
 =?utf-8?B?NCszbFBLV0hsRGxvWjBJRDRxRzIyTXZXS3pGMFJEaFVxUUtJVEk1YU5XdDNX?=
 =?utf-8?B?S29QQlRyOWJ4dWNaUFpvdThmemZyZzYvU3phajg5Z1VUZ21rZDRTSkI2eURX?=
 =?utf-8?B?WTlPTG1YZHVuNDFQS3RBLzNtQVA3ZTlLd1Nta1FSNzVNOVFlc05ia3V0eFhy?=
 =?utf-8?B?NjlGNmcrY2hkYU1hZTVrMisrWlN4YnNxck4xeGJPRVJIaXRFN3I2UWw5aHQr?=
 =?utf-8?B?R2tMY0UvNWZTZ2NNNnhmRUZFbnpZS250cmIwdUFvMjUrdkdvREhWbzd6ZlJl?=
 =?utf-8?B?WHNUNXNVS3JVb1dhaDJ6cVRnNUFNU3FEWUZyRmV0RXhzdUdVMjk2bVdBck9r?=
 =?utf-8?B?UHh3aFQrN0VDSm5TUzNQR0hUa3d4dWQxZVBjOEFaeG91c2t3REExNjFUeXRs?=
 =?utf-8?B?RDhoMjBRdFBXQjFwbys0MjJueVBpR3ovQW5jYkNwYUVmSzloZ2w0R3NCU2dB?=
 =?utf-8?B?NHJXOWdGaWtwVXhLa3FYRElzM3lRUkZWL1prRGFERDcvTHVUUFFrMm1VQUpF?=
 =?utf-8?B?ZlEvb3MxWmJxUmhPakZSODZNTlZrb2FOd21RSStWR2tzR0pQREdYSkNPcStC?=
 =?utf-8?B?SHV5RWIzY3VpWHFjcjR1YkFFWW1WaGtQbzF6cm9ScTRORXViZzJXZ1FaUCtV?=
 =?utf-8?B?cmFqQnFkMmhScHduMW5YOXAranFoMkhtSkk5WmJFSW96ZC84ZU5PNmMvS0tG?=
 =?utf-8?B?ODFRd1lzNHlqMjFBL3B1RnphZm1lcEk2d0xwbzdoTFI0RURmS21kaVpneFJB?=
 =?utf-8?B?Q3d3TlJQTmRVNlZ6Ny9yeDZwMXdlNVNZODZFQjBPUi8wN0V2STB1ZlBla3R1?=
 =?utf-8?B?MmVTUGlFdUIrS0FKNXpFT1FQbmpYYmxIZE9lMVJQd0hlM0hhTElHeVU2ZFF2?=
 =?utf-8?Q?GSyMROCiSWL4Z+XVX8c89ayyQH4UPKYxkzImsLLIQtOS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CC208912184184B9144493E9CB5B9AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8662d493-c72f-40ca-7987-08db4bb9b026
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:35:09.8844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GHNksUeYsIstseMR6R6l9Bb38NLGP6fndm+JmGiVeZv9qp2/DjnehPfVXXTLamcjC0suB589NecXLdgT0+84Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBTb21lIHRlc3RzIG5lZWQg
YSBtaW5pbWFsIHRlc3QgaW1hZ2Ugc2l6ZSB0byB3b3JrIGNvcnJlY3RseS4gVGh1cyBhZGQgYQ0K
PiBoZWxwZXIgdG8gY2hlY2sgdGhlIHNpemUgYW5kIHVwZGF0ZSB0aGVzZSB0ZXN0cyBhY2NvcmRp
bmdseS4NCj4NCj4gVGhlIGltYWdlIG1pbmltdW0gaXMgNE0gYmVjYXVzZSBzb21lIG9mIHRoZSB0
ZXN0IGhhdmUgaGFyZCBjb2RlZCB2YWx1ZXMuDQo+IEFsbCB0ZXN0cyB3aGljaCB1c2UgdGhlIHhm
cyBmaW8gdmVyaWZpY2F0aW9uIGpvYiBoYXZlIGEgbWluaW11bQ0KPiByZXF1aXJlbWVudCBvZiAz
NTBNIGltcG9zc2VkIGJ5IHRoZSB4ZnMgZmlsZXN5c3RlbS4NCj4NCj4gUmV2aWV3ZWQtYnk6IEhh
bm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2Fn
bmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIHRlc3RzL252bWUvMDEyIHwgIDEgKw0K
Pg0KDQp0aGFua3MgZm9yIGRvY3VtZW50aW5nIG1pbmltdW0gbGltaXQgaW1wb3NlZCBieSBmaW8s
IGxvb2sgZ29vZC4NCg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
