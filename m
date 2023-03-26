Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A56C989B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCZXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCZXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:05:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0255BC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK0wIaT/nKg/Q2X52nfYAM2iOAm4Qw51AfvdKIpUpJsfenFccKHkKScu4gVfgXx9LMNIBG79TpNhg0XHShgLhMmD0NlOr3lxd3bgH0gSVSNwWU3IyI3TZEVS6/RdGNPyFfIp5oeZyitYajs+Uhn5zm3qtXtB0lQU6/7EcGYefcJJ8rmDjtZyhd2EBwgig/E8s0bzGa6tXAPQMaFNZhJiHG4VYNGvdiOxqgOpVUCBHsN7GUWz5BiPNBicHfB79LSXaygDl/ilBl4FmSwB6xE0D7kK2Vg0jlOrZUu3xZSHr8ktaNGH882XYXrvpbR7GAcLOI6fZX5yL15yrZafYb6JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY7SItHSOebNRrRpnSRVyTn96OIj7qLDbsDf49L8iXQ=;
 b=BXLTVTv+5TbCNoO9/ZFjdxY26cEVh3H/sfjnDoOaNt7R2K4Sbe/+VQBieqnsewdBBZZbvdCRs4/4XMWZmqkdqLBqFrPql9VPRHR2wkBsHcgVQOD4jf65vJURFmFUsd6AqgvPy6UnphNfXSTHLnFTS66WUDd7dD81zC2HSVwPjUrHgWbBCTHKaUh29GfhqPPqMUP8RTprOO+M/lzBIdgI6kCVU7mokSlqqwO3VcQ9+Bs3/P4Bs8A9u1C6YcMAJvgrwQd4mZGZ9EFNTJrAael7hO9r8E3FaAaAwRNddhFMWa09ofP+eXbhHH/JxBEhO1uOAbKHv1qpFAwBLiLuromx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY7SItHSOebNRrRpnSRVyTn96OIj7qLDbsDf49L8iXQ=;
 b=dOy3erhl6n9fR5zLkIcFk1NDDLHks8er6G54uAwke49lMDQVh8azIOAqdBHsHXq5o9iYAqBlKRUESV9SYesKuHtG0txaTCfJkDKjXu8YoQ5GWAVcpHOJKW2MS2ilsGMX/4pDgx9CsjOFH7BTppxsmziZSFqT3+q30P6jX6xjdZIshhHNSFDErYXGzw5ChdP1aXIv793+4aEHy4IlWQp0q4zYeN0Yc9Ft+bN3jmvI0NK5KDDrFMZRWvJSsm+KWKY2dbC2MlcCbQ091eMPMSPP8Nn4OlBQBmMPRmLpCajIYZpSraUed4FCsmSNUtiT/lzjbG/KHSEZ092xGb7WiWvCRw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 23:05:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.041; Sun, 26 Mar 2023
 23:05:36 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Juraj Pecigos <kernel@juraj.dev>, Christoph Hellwig <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN
Thread-Topic: [PATCH] nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN
Thread-Index: AQHZX8XMX2JAYb/Ni0y3RTCpbVOfyK8Nr2WA
Date:   Sun, 26 Mar 2023 23:05:35 +0000
Message-ID: <8ac7e3d7-c96a-26dc-17ef-3ce5d6bc03db@nvidia.com>
References: <20230326092948.147994-1-kernel@juraj.dev>
In-Reply-To: <20230326092948.147994-1-kernel@juraj.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4165:EE_
x-ms-office365-filtering-correlation-id: 869f8072-0275-41ab-f69c-08db2e4e9b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GsdcGtfXOycZhwhdV+M0+o2oj5klMRG7sxumRT1MyJRcI9bTXeQSHMJSX8JtuaYh+Kb26dWd1btlFmGXVwSz1OsCohHdwc7c8YMR0/Gg9BTqbeoexgiGSZZlgvwMZwWkdEwQwfwpAsAK8Gphjcu3+QpyJociu1eR6gKEUlBMxn8adM73dlrx9DNqVfsi4YmMe9I8oxkp28ICBjjjU7dXzoZuzyVwVsjiVqSNoUP7wIz+L7xRtagW5kE9lmcnFLzyX3wzoywgYiwLdQD9fOynmveySv7y2Ljnt/B16+1YgniO8qVk2J1rJMH+vj73zBVP+/c5MOdX0UGVCQOwWmj0ftgxUatbX22/BXZW7RqwgXIMnZFkmrgGWcw6IAkuojfHzvFU80WwF6pnZqwcfwoz9+vPiz9T5Er5zfLygjZVZX0qj7BOqfYpy/rwaV4f2uGDTpZ9LHjLfnwfJDh3duU8RG/sYrabQLcAxTRuvDfP8Z09UDcttZM3w85BX38XgYTOp4WNxV6Qdfl5CteuFO4lMgpbYxnzq5wMnOYtuWvQlSh+0/sNIAvkI9wIXI7qmWOUa1WUGtzqvcc5YQnt+QPIxP7rg6UTBlkDD92tECm3fIdyyrIVOjkkiJZNj5umU6d1ud8Jbeo7ZbP5m0XQmdtsePfj5/8EiBXqOexlWidhdphXu5LcMGMyzEu0C3L2+PV5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(2906002)(86362001)(31696002)(83380400001)(186003)(2616005)(122000001)(38100700002)(38070700005)(36756003)(53546011)(8936002)(5660300002)(4326008)(8676002)(64756008)(66446008)(66476007)(41300700001)(66946007)(76116006)(66556008)(6486002)(6506007)(6512007)(316002)(110136005)(91956017)(71200400001)(478600001)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnFhSGdaWW5QOUtsMGJHWXQzQXBkYzlJbDUxbzFvRU9UTXhZUWFsa0dGbVg1?=
 =?utf-8?B?YmJmRDVzSjVzS1ZvRjYrbm01enAwT2JrYUR1SFVnQmdCL25mVmJyelg2d0FX?=
 =?utf-8?B?VXE1YWdRR3dBdXBacmhjK3VwaTBoYitlTGRTSm03QTFlSysyMkN5VG10SHFS?=
 =?utf-8?B?UkpqeFdEeEpoUzZjSk5PL1g4Uy8rTFdRNi9RcU5FZk5YK0FRU0Y0azl0OFY3?=
 =?utf-8?B?cXFzbXYxOHByUHFWenR6UU9ZTmJHUENDbkUyMlJjbDVMMDVmOGY5cFBGRThJ?=
 =?utf-8?B?VEYybUM5dHVrRzFxYzJhN3VHY2RyTjBYVlJaSHJVeUR4Ukp0UnVjZFVWR0FD?=
 =?utf-8?B?U0tzdW5DaktaNW5FT0hJS2FKeWZrTkQzVSswUjN1dWdBQzhXajVLaTBXVG45?=
 =?utf-8?B?Qm1HWm1kQk8yQm4yQU5wckxNOFpQL2JwTnJySm93eEZPVUNCUHZmUGhXSGxx?=
 =?utf-8?B?QW5TcFZEemZWT0tURjg4aXVXSWp4ODcweHRwK3RQWmUrWHppVHAxVkNkODlX?=
 =?utf-8?B?QzVmanh5VHlVWmNVWHFkUFEwYTdtemU2UWJzcER4d1ZYQk5FR1FscUI4VzRw?=
 =?utf-8?B?bFBvTUVURC9rU2xGLzZNSk1LQVVEV3dJcjc2R0JuUFZtS0dzSGZ0SUJMRHRt?=
 =?utf-8?B?a1RyaGY0RGFLOEhibm1MYlFGTjBaRFFPTTNjVyt3bkoydnYzSG1VVnFVbFJD?=
 =?utf-8?B?eDFIc2dSSWZXVFBxMVR5N294Q1NVU3YvVVJ1dlQ0V1V3dXVsR0RFS2s3MllX?=
 =?utf-8?B?ZlIxZFhhVFN4ZzhXS3dSM2c0aVNCek9UdTg4YWhkeFliV2lRUzZLUC9TajAx?=
 =?utf-8?B?SXpFYndkQXkvbWFNaFk1ZjI3Yy9wejY3ajV5Q08xN2hYT0NySmI5cW5jV1RY?=
 =?utf-8?B?ajVmcFJqWlNkSDkxY0pwMzcxOXU0WXBBVC9qSUdibVVpNEI4cktDeXNmZ0ZN?=
 =?utf-8?B?dTN3Z3E0NHI3L0dUeGdtcm82WTNuMmhnYUFvOTJxMmFJSUdFWDFQdHhjNXNV?=
 =?utf-8?B?NGVubHlBb042VE1kY0xjNUpGdTkwU3F0c0pkcFJiTW8zRk9NLzJHM2prb2Rl?=
 =?utf-8?B?djZ6MVViWVNkdE0vNkllUGlMcE1WRUNXYTBFQTVQeGNQR05GNE00S2JwSzla?=
 =?utf-8?B?cTlGYWViajZ2dTRUS1l1bmNZeU5nOEZMMGZjTkNKbTlCN2wvM2w2WGY4b2p5?=
 =?utf-8?B?eThHK2ZERFZiMEg0V1VHWHc4Wm1id2hVZFBOSzE0NWFNQnh5WG9tOXYwRWNp?=
 =?utf-8?B?Wlp6WUtJRXFrL3ZPT2txVC9oK1doU0NScitIWFhuVWZkZmNBeC94VmxVMWY4?=
 =?utf-8?B?MDlTbXh6NGpVMFJxWkJ4S1J6Y3dIWjh6dUdmTnQ3a3YwdkFiREJYU2ppL2Jy?=
 =?utf-8?B?WFVHaFhYTmlJdlc1M2FrTjJWRzBxSEFQOFZPY2ZmeDg5MG51T0IxNkxaSXIx?=
 =?utf-8?B?bytGRWZBejhpUTVWbitXdWNHTmxoaXBKb2dZZnJtZTBkME9adkVybTFpWGpM?=
 =?utf-8?B?cURUUlJqQXlPOGpkU1Yyak1jS1BVK0t3ZEZLQXpiYkpraUQ2d2p6RVVubTdB?=
 =?utf-8?B?U1dLUmMydFR6UldVa3lDdjR4VkJzRlNCd3NmL3MxWUw1b2JqY05KcHhjNVRB?=
 =?utf-8?B?TWRmUUU5UXRQRnZueFJzekV1Y0lyOHhSS21tdUwyeElKOUt2Uk9OanFKaFFT?=
 =?utf-8?B?VmJnNVcrMlFSM2JFU0xzbjh2OTdqTVlaMGJnc2llbk5HL09TS0pXUVlPNzBk?=
 =?utf-8?B?VmtldlFzT1JpbkRJTHluSTZLR1hjZmgzNEViMHl6b0pLOTRFYnYrd2pxY0hO?=
 =?utf-8?B?QlJWTzJRMVQwNXlMdG9GR3FWNXRDL1FYbXU3bkRsVW5McTEzdEJzdzBXcE04?=
 =?utf-8?B?UWxETGl1aG9rQXpmN0VMM3dMcndhdXlHOGtCYmlmcGNBLzQ1SkIxeEoyZ2No?=
 =?utf-8?B?MlN0NTZ2NG4rTUlLRDY5WGpxdFhHQjRvbTcydXY2RE5aMTVFajJpUXg1cGl3?=
 =?utf-8?B?cEV5WFVobEVBdGVkOHJzcUFrWUtWNHN6R0FrNzZtUU45Q2poc090SGhuL0Vq?=
 =?utf-8?B?d3REa1U3aGZ4R3hrMjZaMkVnOGhRZ21tTDdzMksyelVvSFl6SlhraExQc3Bl?=
 =?utf-8?B?ckZvdk9CNlB5QmFGb3Zvamo5VDkxa1RFWGRqVlBtWVlVbnpJcXZidEJqTmlx?=
 =?utf-8?Q?vWHrOYRf6KeWyqf9A3iuyBTgFbPjlDmgZPZoXtZxLiE2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A5FD77095DA874EBE2236B830B15211@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869f8072-0275-41ab-f69c-08db2e4e9b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 23:05:35.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCBNoAlVUdr1cSBZ5KsdgK/S5P9lkVPTv2k6qQ+5EHijdkMxLSgvehghUfWIMWxVoASdF5AkPGr4D+YJTWxg5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yNi8yMyAwMjoyOSwgSnVyYWogUGVjaWdvcyB3cm90ZToNCj4gQSBzeXN0ZW0gd2l0aCBt
b3JlIHRoYW4gb25lIG9mIHRoZXNlIFNTRHMgd2lsbCBvbmx5IGhhdmUgb25lIHVzYWJsZS4NCj4g
VGhlIGtlcm5lbCBmYWlscyB0byBkZXRlY3QgbW9yZSB0aGFuIG9uZSBudm1lIGRldmljZSBkdWUg
dG8gZHVwbGljYXRlDQo+IGNudGxpZHMuDQo+DQo+IGJlZm9yZToNCj4gWyAgICA5LjM5NTIyOV0g
bnZtZSAwMDAwOjAxOjAwLjA6IHBsYXRmb3JtIHF1aXJrOiBzZXR0aW5nIHNpbXBsZSBzdXNwZW5k
DQo+IFsgICAgOS4zOTUyNjJdIG52bWUgbnZtZTA6IHBjaSBmdW5jdGlvbiAwMDAwOjAxOjAwLjAN
Cj4gWyAgICA5LjM5NTI4Ml0gbnZtZSAwMDAwOjAzOjAwLjA6IHBsYXRmb3JtIHF1aXJrOiBzZXR0
aW5nIHNpbXBsZSBzdXNwZW5kDQo+IFsgICAgOS4zOTUzMDVdIG52bWUgbnZtZTE6IHBjaSBmdW5j
dGlvbiAwMDAwOjAzOjAwLjANCj4gWyAgICA5LjQwOTg3M10gbnZtZSBudm1lMDogRHVwbGljYXRl
IGNudGxpZCAxIHdpdGggbnZtZTEsIHN1YnN5cyBucW4uMjAyMi0wNy5jb20uc2lsaWNvbm1vdGlv
bjpudm0tc3Vic3lzdGVtLXNuLSAgICAgICAgICAgICAgICAgICAgLCByZWplY3RpbmcNCj4gWyAg
ICA5LjQwOTk4Ml0gbnZtZSBudm1lMDogUmVtb3ZpbmcgYWZ0ZXIgcHJvYmUgZmFpbHVyZSBzdGF0
dXM6IC0yMg0KPiBbICAgIDkuNDI3NDg3XSBudm1lIG52bWUxOiBhbGxvY2F0ZWQgNjQgTWlCIGhv
c3QgbWVtb3J5IGJ1ZmZlci4NCj4gWyAgICA5LjQ0NTA4OF0gbnZtZSBudm1lMTogMTYvMC8wIGRl
ZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KPiBbICAgIDkuNDQ5ODk4XSBudm1lIG52bWUxOiBJZ25v
cmluZyBib2d1cyBOYW1lc3BhY2UgSWRlbnRpZmllcnMNCj4NCj4gYWZ0ZXI6DQo+IFsgICAgMS4x
NjE4OTBdIG52bWUgMDAwMDowMTowMC4wOiBwbGF0Zm9ybSBxdWlyazogc2V0dGluZyBzaW1wbGUg
c3VzcGVuZA0KPiBbICAgIDEuMTYyNjYwXSBudm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMDow
MTowMC4wDQo+IFsgICAgMS4xNjI2ODRdIG52bWUgMDAwMDowMzowMC4wOiBwbGF0Zm9ybSBxdWly
azogc2V0dGluZyBzaW1wbGUgc3VzcGVuZA0KPiBbICAgIDEuMTYyNzA3XSBudm1lIG52bWUxOiBw
Y2kgZnVuY3Rpb24gMDAwMDowMzowMC4wDQo+IFsgICAgMS4xOTEzNTRdIG52bWUgbnZtZTA6IGFs
bG9jYXRlZCA2NCBNaUIgaG9zdCBtZW1vcnkgYnVmZmVyLg0KPiBbICAgIDEuMTkzMzc4XSBudm1l
IG52bWUxOiBhbGxvY2F0ZWQgNjQgTWlCIGhvc3QgbWVtb3J5IGJ1ZmZlci4NCj4gWyAgICAxLjIx
MTA0NF0gbnZtZSBudm1lMTogMTYvMC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KPiBbICAg
IDEuMjExMDgwXSBudm1lIG52bWUwOiAxNi8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzDQo+
IFsgICAgMS4yMTYxNDVdIG52bWUgbnZtZTA6IElnbm9yaW5nIGJvZ3VzIE5hbWVzcGFjZSBJZGVu
dGlmaWVycw0KPiBbICAgIDEuMjE2MjYxXSBudm1lIG52bWUxOiBJZ25vcmluZyBib2d1cyBOYW1l
c3BhY2UgSWRlbnRpZmllcnMNCj4NCj4gQWRkaW5nIHRoZSBOVk1FX1FVSVJLX0lHTk9SRV9ERVZf
U1VCTlFOIHF1aXJrIHRvIHJlc29sdmVzIHRoZSBpc3N1ZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
SnVyYWogUGVjaWdvcyA8a2VybmVsQGp1cmFqLmRldj4NCj4gLS0tDQo+DQoNCkp1c3QgbG9va2lu
ZyBhdCB0aGUgbG9nIGluIHRoZSBjb21taXQgbWVzc2FnZSBzZWVtcyBsaWtlDQp0aGlzIGlzIHNv
bHZpbmcgeW91ciBwcm9ibGVtLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
