Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042B6661F64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjAIHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjAIHnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:43:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0D13D28;
        Sun,  8 Jan 2023 23:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4UNtp4BQzgR23yk1yt5Lj6fe4s+MBepQnjWA/oMUZO1ClAzdlKzknSyWUnBsH15zVQqsMK8TL/wAiSerkXYTXvIbjDzDNYTdWU1PNWhhTHCse6K9GEMR/cj3zvG5eVaxzmRIvhkJiVZ6IYrBwkWv1S8fY4oB/0Mxzy9OiGrWyPuyAjn2O02HSGpQ1xWNgEUYfRhaXm3VVw+HES1e/I4pCIALhdu2vbKZpmifanLOWl78BsOqA0+prD3bJB3tqDk2K1b3Ro15s1AThsaaWFyA6siU11s0oLZOba8DcPvawlYSQRHFASFZtqCeEjnuD4yrPacBWoelz2mXGUk0j7HlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2rmrtG17r4bpY6DTEdCr/yxkAgAIybYyy1meZjvD8c=;
 b=O4fFARjG0HbQuOKyQm/3/+hS+izBzdXH/nuNhBesh1j7N+OyQzjb599Dj70zZSUgZsBZvaBdQT8qNRUja752wi/xJWckcWLhdWr0AjlF7MqyU8YaST5VamLNQsfUF8mwIkb1bZP8ODnE4GQEWgRIcVM7KHdMVjIzVVhqDqFLOHwqfeVRppXG7epxs6YP8nYmqwW81PAeSeKbuOMYiT4jZFsB3Fwzda6JRw8c2ABq++9lZozO66ASBUrR/pFh9/GOoqYZ31VsvWLqWJOmdJhpELXbHwxBtlGue5hgbc1c2YBRcAX5hw8IN1Burx/AwOVfSnHVTiSqOqrUJGRlDOmb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2rmrtG17r4bpY6DTEdCr/yxkAgAIybYyy1meZjvD8c=;
 b=ScwNPaFdnmOgAtT8jHqJ+Tfc/6TGaUMpBd9K9id2gtcAaMdlZ1keIsjXSTAphv9IRd1VQqVuowQRgyzTk4WC+His5d0/SFMJ1XZmsq7qDjTqvSiLISM9pwOdwWO6+2JY6fp+Q12D4uyoFKoDGyfyxsSaAsNNaM97LlSUr+02MHvayFdho5OLrPXlRj2EBgF/riY/8SqmN6elYl176H/2ecYdDgx7Q6WoFt6g9A/6Mr51zErnALz05/SGlxWHKbrBc2PTxOZaatvbj2n9n7fPdartO/b5fgAdTHiwrlMWW7r4EswaYZFtL3+MqAe7J+Pvehq3ao2odMfhEE8mscKzTg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:42:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:42:53 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "kernel@pankajraghav.com" <kernel@pankajraghav.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Thread-Topic: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Thread-Index: AQHZIamn2aj4i0XyhES6jLMlPxx0J66VuKKA
Date:   Mon, 9 Jan 2023 07:42:53 +0000
Message-ID: <5b6d70ab-c04a-2411-7f7c-37bbcb50608a@nvidia.com>
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com>
 <20230106083317.93938-4-p.raghav@samsung.com>
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: 8dd22294-75e0-46ab-b7c6-08daf2151dfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ar4iOVu2LkECF8VMAXCHDCuKPPkb+MFOSaTntG5d/GB3vRh3h6kNS1jRBo08ooXAxwY69fCku7b2QBxM38MepnGtHRVaFY4r5fwK6Gztez+BTh527c8GFeph5bgACnadvO5PtvhZIjcacA2WxB72sPafh036tdACXkDkqZDR7XS1EWqEqabMrHwocynjMWzMnq07r5vSnbcoE4bQvbAI/GcxoW3D8lrAL3C8t/eTgm9d8VhUURnokiQoviLOyeNHkO6BrQ4V22Np8UIya6fvvehdTCFRQ4XCUEZPMqG8US2DaHJHGdAfEmlWCky81BEUN7/gVEOVILoUGoPlcu7bCz6LGO+KbL9Ctk6s0ULWr7cy58L4P/0fcTkVOD3PU50fTMnEqCs1bVdUBfiHN3Ggi838lXxdeNRbn7JnUTymVZDmnQb7DMGPf3qLhzmWHBQKP+HRmhswiPPV7Cqp3iiPQjLt9l2gFHRwNT5CM+ZQPLAcSHVo7ni64WmGilz6gzKCSm3cf2PaL5PvPX0j0IC79mop0IlCmtjvDKOqBLptq5VzZwCrGB7d3z3dsNPvt7E0E593N4VP1w+o29IxKT8rSP+m1MbbN4/POzBIDOJmyBCojyHPXbbmVilYzxthXWQSfWszb4YY8nzoGMiPIRzWNcBn+767Hn6HHYD+OUqUxU+I1FiWvXpEtGcgJ86hb7C9OPiajdaMgUemaKThJdkVwHl6aQBxYRwN48V/3bvESX0+meHYMVmUXKoDDylVGVS1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(38100700002)(122000001)(53546011)(31686004)(2906002)(6486002)(478600001)(2616005)(4744005)(186003)(6512007)(5660300002)(316002)(71200400001)(7416002)(83380400001)(8936002)(36756003)(38070700005)(86362001)(31696002)(41300700001)(110136005)(76116006)(66476007)(8676002)(91956017)(66946007)(64756008)(4326008)(66556008)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEk5NFNKQThUeVg5ckdDeFVzWXhmTURsd2JZczRFeE00VnVMRXFEUzEwVHZX?=
 =?utf-8?B?SEFlRjZYMnhkRm1SMkJ0ZTh0aGhvWkxKZzRDVmVmTEJFbUp5SU1nWW8xS1Yr?=
 =?utf-8?B?UXZYbkU3Q3dPVy9qVEw1azMvSmhYUlZOOTN0cWZJbVJSS2swcnFtcTI3UC9i?=
 =?utf-8?B?VGdkby8yejcxaDFKcmRweTNrbC9DMGVVUGxLcGxQa01pdzdxRHRjeWFlRDQ1?=
 =?utf-8?B?UHRDU3Q0blhFdHFncEZrTGNuamhNTkxGSDROcmJzOEwxWHR6R1Z1VHpFZ0NV?=
 =?utf-8?B?SXNiNXlNU3ovSGpNVGdwT3pSUlYyL053a2l1QW9mbHBSTFhHSFZGRlNIRVVa?=
 =?utf-8?B?WFJXeGdUcGxtM1pjWUJBWFUzR0FRK1NWUkJtTG1VTkRMcjk3YUNHc1pXWExo?=
 =?utf-8?B?Rzh1TU1Obmh1aUtEWnA3VlJuU2k3ZFNtbi9mc1pkcmZZeFJBYTNXSDhBWEVE?=
 =?utf-8?B?SUcxbDVlOVA4Y2NzeXJ2L3pzU2V3aTdQMG9nczhkWlBxOUtjWEx3YUw0emc4?=
 =?utf-8?B?Ykh5TkhybnNnbTgrUDBjNXJGd1l1VnhEMkpTN0RIYW9CUWVzR0poTWpZTW1r?=
 =?utf-8?B?WnhSWFZiL210V1JOVHl0Y3grbUQ5QnM1T3UzY2FhdnQxcGR6TXU3QjFaL3g4?=
 =?utf-8?B?Zk5Qb1d2V0E1RkUxVjRsOEVHd1N4c0dNZ2YreGNKbVM4M0wwdTZkNHpvdDQ1?=
 =?utf-8?B?TGx5N3k0UE96K0RvZVNjSkJrVjJXcGlBbHdFYW1wUDVRL05jSVJRbFUwdTRV?=
 =?utf-8?B?ZWNxMXhKQjg0MVI4YWMwOUdJRitTM1YxTE82SnNaTGhXcnA2aWZ0OGhsSXVi?=
 =?utf-8?B?M2NaaVdCOVNSQWd1dHl4ZXpuUWhCVmVROWhYUDVHRTVLTE5nMUFMZ3VuRUIz?=
 =?utf-8?B?ZnluL29memw1VXZWMitXZVNGUVRpbHAxYW1mK3ZjZThQSDlaVW9acHRoQUph?=
 =?utf-8?B?ZHVqeUNvUXFBbVN5SWR3NERtVWxTeEE2cFBMTzhhQVZlU3ZUM0FmMHVWZmUz?=
 =?utf-8?B?K1dMS2xPdHRkZTBnNUdvNEhzQkdiaUpqT2VXRklaeUp5ZjBhNXBtNEZVWGJj?=
 =?utf-8?B?UkRBcUNoRG9jS0dSaUVPT0taRCtOM05iQkpDM2RzWjFRNWtYbkhRamVZZE9Y?=
 =?utf-8?B?cHd2OSs4NkNNbHhacUMxeE9mamtVV25FdXJEazNWbElRS0dpdXFRallkVG1q?=
 =?utf-8?B?M2JVbTd6V1JONE9UTTF1RE8yWS94SWNHcGxKQStnTmpJSWsvcHA2bkxqZzBo?=
 =?utf-8?B?MDYrdjNkNmZlKytveStOcDIvOWlXcW5wWXhyUlZaRUs3MVNNSDVLdDJjNlVT?=
 =?utf-8?B?TTVtYkNrY2hyRVU0Mys4Mm9pVTFTRmRYS3VXT2U0VTZDUGt1UWk3QzNha2F4?=
 =?utf-8?B?MmhJeVpxZW9Od2p6Q2tFZGZQbUdYdUtMWTdKT1g0bTdvMDFsSm5idDhHT3Vz?=
 =?utf-8?B?b1o2ejEva2xMODlCSy9tdkV1L04xYk03dy9JMmRlTkhXMjhUc2ZUTWtqYkxq?=
 =?utf-8?B?eW5oRXhEQmt0UHZIMm4vOXVyMU9BeFB2Z2JxYUEvT3ZwZUxLZmVwRnFubmI4?=
 =?utf-8?B?WHFCbTZRaW9SaVdKMWx2c2FnNTJuTlR4bExiR1VWMWZDbmtNNFR4T05UbFc5?=
 =?utf-8?B?RmhOOEljbVZXT25CMnUrb1FUUnV1eVBEMHpHdHFiVGI1WjNtK3lFNkhyeEpO?=
 =?utf-8?B?Y0VJM3J5RXZCMEF2NDFLeElMRDJ5VDc2cURJcExJaU91OEUxU0pnWDVoakZx?=
 =?utf-8?B?NWdhbzd2RGI1OERHWjVPcXVFSERrZ3RYRWlhbGwzamI3ekZvZHFNN2Vnampp?=
 =?utf-8?B?aHE3dWRJWG5KNHRuM2xuLzE2ZEdoVGw4Q1h5ME5qc0s4b3FINFp2RDh2Q0VB?=
 =?utf-8?B?QzdLdFJPR1Fua2dmbFcvSHhNTFV4R25JZVAwOHIrKytzNjRoV1N5ZWlmZGoy?=
 =?utf-8?B?MmlYdnBJbU0vWEJXMUx4NTYzYkJIa1VONTEzc0pudlZYVHB3eFo3OGJhQ3Jn?=
 =?utf-8?B?SGJqRU53MTdNeEJRZlZra3g5ZU5mS1pXbUUyMS8wRER3bk9DSEk5a1lKWHd0?=
 =?utf-8?B?MTNlY0lRWEFlSEhIK3BsL2JNTS9TMXAxS3ZMQ0xHNkxxcW1zWkc4NVpzWkRl?=
 =?utf-8?B?c3BsTGlWT0FZNWM2VXRqSS85a05BRFFtL2dpMVBvWlhKakJSL0R1UXdvWUMw?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BE6FBAD7FCE734483E09D35E9ECF185@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd22294-75e0-46ab-b7c6-08daf2151dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:42:53.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZ2BkQ0VwuvZ/ey178tEDMfgRwcM4mAoO+NJKHwUrU9bVB6vrcYuokbpv1O3r2NZ3gVLS2ttP0SbCLVuFw3BLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS82LzIzIDAwOjMzLCBQYW5rYWogUmFnaGF2IHdyb3RlOg0KPiBBIGdlbmVyaWMgYmRldl96
b25lX25vKCkgaGVscGVyIGlzIGFkZGVkIHRvIGNhbGN1bGF0ZSB6b25lIG51bWJlciBmb3IgYQ0K
PiBnaXZlbiBzZWN0b3IgaW4gYSBibG9jayBkZXZpY2UuIFRoaXMgaGVscGVyIGludGVybmFsbHkg
dXNlcyBkaXNrX3pvbmVfbm8oKQ0KPiB0byBmaW5kIHRoZSB6b25lIG51bWJlci4NCj4gDQo+IFVz
ZSB0aGUgaGVscGVyIGJkZXZfem9uZV9ubygpIHRvIGNhbGN1bGF0ZSBuciBvZiB6b25lcy4gVGhp
cyBsZXQncyB1cw0KPiBtYWtlIG1vZGlmaWNhdGlvbnMgdG8gdGhlIG1hdGggaWYgbmVlZGVkIGlu
IG9uZSBwbGFjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBSYWdoYXYgPHAucmFnaGF2
QHNhbXN1bmcuY29tPg0KDQp3aXRoIEJhcnQncyBjb21tZW50cyBmaXhlZC4uLg0KDQpsb29rcyBn
b29kLi4uLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K
