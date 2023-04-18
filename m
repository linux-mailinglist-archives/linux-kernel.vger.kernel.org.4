Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F76E57F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDRD6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDRD6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:58:36 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6DC421B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOYhbw7p0ro+3Oq4sYze8mv+bwmODKvrwKFSQKwecp6Y+lGIgh4tbpfC1mo4XNw1/2/pRktV1ofUbnBBmns7xxHaMB5zJHpFPYa5eqJf/7zSAp+Ry9fUfoDaGQH9JM+YGyNL/xArTmfOGgno2hWAG8NKpf1+Aiz29H6wg8zZG8v2f5FXykecApdN7AY2jylAVrQ5XYAfRf7tPS3Rr8ZCmc5ui/2Jz0v9vO26RzE3P7ApT8HjoTwyX785k8lLqoWyo+qW/lTbiLb5HosHIxyW0Wwwt3XAzEgTYmTdlPtx7qyY1d1e/mUoQ4x+QfUc7mgr1dg+dZWVlvNBBHJfPAbT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyH4g2JHMN0xzfktkb4Kvo86XbdpfRlFmWrSFYlXT9g=;
 b=UeGviZhbqX8A4DbuDbxSjSnXHv6bIERy3re2+DFSlwAeboX0J7BY7gEHBPcl2Xbdt23OYFUrMOQvfvUByUSAmcTn2JPkvPkWL9OrYxI3V9fjQPJ1us+ae2GAkk6OmvAv0ScH4mwwv6StQjsA8U3/9pzgkHYR2nTm1MQOb612kyR8iz0QFpA/fuuFewcaVrjZunwILpf6GYVOHop0McZi6ayzNYvtZGW7lZT8/96mrBIajORsOq1VYCSKNPrqevcyN27rCQ/IpIT2THrPjlvtGFvC/SWoZZkHKjaGVLgkFqibzbHNRqnJZmTy6OKPvJZh0Wp4JZ3fq9vEpSW6UDaa/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyH4g2JHMN0xzfktkb4Kvo86XbdpfRlFmWrSFYlXT9g=;
 b=uU9vFo6q2lc5yTKNNgjGyut8rp5ah4FuOIzolRzxzLsR672NW5Bj7QO/lGDJTHy6Yz9kWa4g2FVMKErgRtzFmX4VgssYYRd/XiX/LB6u+LtU2THzBfo7yxo82Zj3o+lU2Rur61+PgWWQUJX60bvtyVW5fRRei0EoyoTel2tnUZLLlG6Iwy7syknnmVEtZvByxGmQDwAOgpDVAtHIehRi8gIyY0NKK7o8+kGKOYWc1t8dIb7xh9yMxt3OEJAWoHWenFJ3g0NTWpBEBrJA7NgBDe9Potczi4bvluuHXVQSb6LjDzJPY/6W/pq93ByRm2d09yDTP/wJjgLVbRMEcGGCbw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 03:58:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 03:58:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Li Feng <fengli@smartx.com>
CC:     "lifeng1519@gmail.com" <lifeng1519@gmail.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Thread-Topic: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Thread-Index: AQHZbdIYiEf+rfXpp0OyEn0ELC3m2K8viiOAgADuTQA=
Date:   Tue, 18 Apr 2023 03:58:32 +0000
Message-ID: <8310edb2-84cf-6211-f37d-d8f3df1e2320@nvidia.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
In-Reply-To: <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH0PR12MB8029:EE_
x-ms-office365-filtering-correlation-id: 1766e8cc-9bc5-4784-c937-08db3fc12da5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IV+sUZwJFYGHO3LwvxiNb7lUpj6ZxagT4PcqGb+/bi38CdOQ+TqVokqld1Ie2t5YNbdweNEgDjdYtAzywyoY16VLPlzjB4vRJPBWcu5U/Uuq451P198xGYcpxL6nR9iHKWL/To3H9Rd1gCTNGXmO04SXz5fAv+0mKEYZF+pU5jAspKJROZq14gXY2MbvxGcxrggO5UA98v3XYvZWfZUyg9hwYbUQSVLL2r9hXGA8+e81V4iEkuQEVMbTwX2z1GEKRdOU87bp3y2rsUCrojqNmuN51JskSAJeSz7Cx4odbPs7Wyh1VKz/NhywZYyNTAuoolcaaHht5F9bhr2Ic/ry//RDTGvO+Zb3uUX4hJG+yseBfb8ZHI2JBVVFjDDLIM90WbZZbHdKgUQxyHIBzigIdxUWsjs++g2IG13wNJElrjhr2llxRoc8vPXnL6ZD/jKJLAgm6azxrgJmmDNBZN247e+bkrYZ0hyyv7CdWu/L4zjpWEKALbDTuGf61HQM3JtFyMC75uqJVKA+HfkW/ZrpExywEFlOKUYHqeO+Y2WQGXQxP0inTAUkQQyji9Lp8CeHJpBPbbdThVSmCsy28N53Mq6RKXuSwf+QkC8ULYFc7Ey1qGci+Y5WSsX6DE1n1V+8n4L42E+ML8d7tCaFu/10Y3C8F2Xqs/h+M7gg1dNqOpACPFb6sr6V6T16MqXON87e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(6486002)(71200400001)(110136005)(54906003)(2906002)(38100700002)(122000001)(478600001)(186003)(2616005)(6506007)(6512007)(36756003)(558084003)(4326008)(76116006)(5660300002)(316002)(66556008)(64756008)(66476007)(66946007)(66446008)(91956017)(86362001)(31686004)(41300700001)(38070700005)(31696002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmhxMEVZcnhTRTVzRGtVRzZuZFJVUGI2ZmRmSGt2cmNqMndXZEg1UEV1TGRH?=
 =?utf-8?B?YUowaXh2VHdJaDF1S2NseUlwcnZ0Z0psbm1PbWp3cEJ5Vmo3UGwzSWQxOHBL?=
 =?utf-8?B?bkVCaFJGN3JEeHlIQXBEYzJwYTVNa0hYVm8yaFJEQzZVNU1GdzdOUW5FaEVz?=
 =?utf-8?B?K3ZPQ3NUWVo4VEZZY0czcUlaVjNTMXcvZDlDZW1rNkdaZWVZY2VpZWZwQXU4?=
 =?utf-8?B?TWQ5Y2xLTDlQblZtOWtiemxXVTJxSzBhcmpNcytvTHp4NUdHaElkb00rZVRX?=
 =?utf-8?B?bWU3bitzMzdjbVQyWWF3eFFVemwvejQxOWY5OHhaV3RaOG1ZcDdUTmd3a3Zl?=
 =?utf-8?B?SUFKWDArSFJqTUpmVEs0Q1F3OFNhNElzSERnNFRyWVkwTDRPTjhIaHM4ckVB?=
 =?utf-8?B?a1diZTJ1bitGVVFITzdiejY1OWdSbUFmdFdYd3dkMTNiZnZqdXdPV2NJNDF5?=
 =?utf-8?B?OGtUMDRHcjdnQWRWZVd6NkgwS3hhdG9FbXlnTEFaVmdyL0p1QmE1VmxtZ0JF?=
 =?utf-8?B?Yk1sOW1IRTJ1YzlOblF3OG5rck5ILzlsSWduNGtuMDBjcWZHVmZpZ2VFQmd4?=
 =?utf-8?B?ZUxFZEE4Q2NxKzhvVTJRTGx2TURqSVo2WnVjSW93dm5NdkVMR1pFMlRPcGdR?=
 =?utf-8?B?bXJHOVVBVkRmU052VVhOWmxnbmNETE9uS0l0RVpEbC9OdFVvYmdsU3pMRjRI?=
 =?utf-8?B?WEk5WEJhczlHOE8xYXBodjJnSzJSdEREblRISldNSlZ1NTBNQVBUL0s0cXEx?=
 =?utf-8?B?TlBZTFhESW1LcFhPVWdtR2Q2aFVwKzc1bkRhSTJMdEdLU3A3RHBNSE5aRTNZ?=
 =?utf-8?B?czM0azh4N3NNY1pIZ2ovTjFYYTVhWE5iVlVuRUQ5WDkwRit3RHlzN0xhZXIy?=
 =?utf-8?B?N1k1eEw1ZWVSY204UmlaUkRvdHdDUzFFWTlpdjMvWURWT1BrVmExaHZNV1B0?=
 =?utf-8?B?YjlZWWZjV043Vm9jYktYZ3hxTU84UDZWc1ZSVS9PcHNaUkljRFZvN3NHNWEr?=
 =?utf-8?B?V3E3QWhGdDhBR29nQmliMkhiaFJmdmJGMGNROW9hM0tnajh6elNiWEwyNFdu?=
 =?utf-8?B?TXVnUmJRVEZFV1lBTE4yallneDhmT2YweGEzdnhYZjNwQkV1Y2VqdzM5Qldk?=
 =?utf-8?B?SUV4dGVlRzVZc2s3bnNyK3ZaVTN2dTlWUUdIaGdqS0MzZEsvTmQxWGoxTEt4?=
 =?utf-8?B?T3YrN2tVRVhEbTVyU2t6bkZnYkNZTjNCUkRUdzRMQ2JXaE1yV1RWbnBMSENW?=
 =?utf-8?B?U05jbDZFSXAvaSswZGF4QVFKdUltdUM1R0FjODN4U1RsWnZiYVlkRXRlQUlD?=
 =?utf-8?B?M2p4dENoSlJ4RWJvTno2VlozSFpUdDVOUzJ0bXp4M2k1eFdyYXNKNHZTeVBv?=
 =?utf-8?B?aXFLRGxlam1uS3JMeFBPVkJ3cGo2algzM2RjME1XbmdObENpOUNyT0NiYmlH?=
 =?utf-8?B?MFVQZ0RabDh1N3Fkcmt5RUkxeEo4UVlrak5xMXhYc09UaDE2MkFvVW45djZ6?=
 =?utf-8?B?OFVVT1IwbW1hUVY1QnVEbmIzU25meVJhc1pYOThCdndIN3orS0R0QWtJVnla?=
 =?utf-8?B?Zk9XczZQdytrR3pxWWNHNlpiaUNDLzhXV1c1V3ltRFZsemdHUURUSU83Mitq?=
 =?utf-8?B?bTlTdmJHOXZ4ZjlRMWJ2VEdxY21DQk44d0xXak1xc01HcDZIenVaY3BnQVV4?=
 =?utf-8?B?L0tBY1l4by8yTFZQY1F4TGFwZk1EaytvOFZxdkNDYng0VnlJb29seWR2L3hj?=
 =?utf-8?B?QUYvamU0eDhZMFFSc2FaOWhyOUIrMm8xZlhzQ0RDRXY2ZVltd29zWmtkSmhL?=
 =?utf-8?B?SlY3cTBrc245dHIyekk3NTJxOC9Db3QvaHY2V2kyNHEvYjV6MzNySER5TEpM?=
 =?utf-8?B?OVFycURHcnZobVBjcllSODF6SXl3OFRUM2tHV01ZYy9nd2NEa1U3WjBHci95?=
 =?utf-8?B?N3hEN3dDWjhGMGdwQXlJK0h0MEplNFp5RnEwdEJxbWplY0p5b2ZXcm1qRHp5?=
 =?utf-8?B?ODdXU2VmM2JxNG04cW91NzZkOGlSYlVlZG9STVN3Wmd5ZlUzL01uaGtHMW1j?=
 =?utf-8?B?cjhvT2o2Y1FwazBwSm94RE1GQTBJNjlEZ0pLOXo3Vzl2YWUzWmtrblpxUXQ4?=
 =?utf-8?B?eTk1WWpQUmEyc2I4OFBQdTg3emtxY29pSE5nbWU4NlhBbDJHRlltWkxvSmdo?=
 =?utf-8?Q?pJHhBCmDSEzN2xLyNM3QzKyYDJREbDWq6QeCdF5LLrbi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83574CF28A5D6C4AB786054EC4288CB8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1766e8cc-9bc5-4784-c937-08db3fc12da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 03:58:32.9522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZZlAQPoVACXzLVDcXoreysOD+hD60BJUdbU6hZTXBThu79wCLBmiJzVbeczIUnsno17yqKY2Qhs1fCZb58V8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0gSXQgaXMgbm90IGJhY2tlZCBieSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMsIGJ1dCBt
b3JlIGltcG9ydGFudGx5DQo+IGRvZXMgbm90IGNvdmVyIGFueSBwb3RlbnRpYWwgcmVncmVzc2lv
bnMgaW4ga2V5IG1ldHJpY3MgKGJ3L2lvcHMvbGF0KQ0KPiBvciBsYWNrIHRoZXJlIG9mLg0KPg0K
DQpJJ3ZlIGFscmVhZHkgYXNrZWQgZm9yIHRoaXMsIHdpdGhvdXQgc2VlaW5nIHBlcmZvcm1hbmNl
IG51bWJlcnMNCmFuZCBhbnkgcmVncmVzc2lvbiBmb3IgZ2VuZXJhbCB1c2VjYXNlIGl0IGlzIGhh
cmQgdG8ganVzdGlmeSB0aGlzLg0KDQotY2sNCg0KDQoNCg==
