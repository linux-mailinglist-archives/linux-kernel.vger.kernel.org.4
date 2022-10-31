Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CF4612ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJaCDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaCDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:03:51 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D67495AE;
        Sun, 30 Oct 2022 19:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUFsOeiiQkOxZ5Xdm1FJqeQ54QnvqYfo3Nazy4bT1IuFqUbmKVkcHzety9I7lVGeyAv7aq0nyypWwUV3RD0uHd4hLGcKbgK94sZ8/l5lGAeyy2/nFIsotab1Stv6U8ydLCsqhTxQupOSDdd98vb35RvGpKITurBsGyVvZYB3pLQKwCgkzYHdGhjwk81uD7xC5qrCEriylJCpTdT87sIlk2pLTbOdIAyWqmH0qqVC9k6dErygewXmGsgYU1sXxzhExiTCfNR70zs8nhvMnilTK3cpsxn6nrf7sjcwppnZNm2Tzx353pu2/nV/Z22w6zEP2Vfz0znd/s2sABG85mscTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49244cc/DruHsoViB+/wJN95HtQlSmimuN3MePLOqfM=;
 b=XfNx6K6ZLOGw1QpThdUAR2bCGVXvuIhIHAuROZIXNYUveukAnOL5kTMs9rwnn6BfpgzrbrSQ6AhGaSputYm7jewL1TjymzFBUfKPftJmt0fCjrU4qe4CqXURuV9Bic2XoQKMZqQvFe+6cwjMvKEGrNMh8pP3mdvcb7ZOLo+okc6FN/d5lFn4EZ6SrNZK38yvxag4SNaIxP8hCQogEf7TPW9ywREn25btWJEk5qJiDy/WEfu9U8wDBVPbQN2AkhBweL/gLoXuuqKykhZYzyGb4igM9P1f8Gvj6hwsy+WlnKyuoisLBdRXK2p4I0Wv/OYhyXiTvoXzWdnNubFcezvMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49244cc/DruHsoViB+/wJN95HtQlSmimuN3MePLOqfM=;
 b=kETIDfZAf4+zfOuj+E9setcUhQl5/7Ty90J14CHyhWBYAfwC+oNPJJFGulGGoT/NKqscSKJIrako4AfSYijSG7muSFuUw/aJbEG8DiGujyaxvHbwkEc9fLIuDDA+8lMuc2LNmMguLeM6VCqiIIAary/QdVsdIelvDI8cRqp4kKbvtPIyERhmHr1sj5bwJXQrNkR4xLRfh1FNFeAGV1TPUCPGCtAzf+sflvQWqIVIinuyxT0KX+eUsqAfycHu9g0+AutCVE9UFmSBUigpsVTgVDWc95QHY40KhLOW3OgyQWoHotu7kN4fjvrGGf/jPhPQsL3LGI4DqLde01AtmaszuA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 02:03:48 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::5d3f:ebda:53e5:8ac8]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::5d3f:ebda:53e5:8ac8%5]) with mapi id 15.20.5769.018; Mon, 31 Oct 2022
 02:03:48 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Dawei Li <set_pte_at@outlook.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] block: simplify blksize_bits() implementation
Thread-Topic: [PATCH v3] block: simplify blksize_bits() implementation
Thread-Index: AQHY7B9bUDUAxpiRp02m2deylVEJzq4nwcmA
Date:   Mon, 31 Oct 2022 02:03:48 +0000
Message-ID: <a3c2674b-c2fd-9128-4ea0-0264c0fc1156@nvidia.com>
References: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB23238842958D7C083D6B67CECA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|SJ0PR12MB6829:EE_
x-ms-office365-filtering-correlation-id: 673f75c3-0fa7-4e0c-fd6f-08dabae4263f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tnjm4QrnfFTcjkpbStgH9o9IRP3CuNdw2vj9YygZOxmtDEHzTVw4eM0ix93Uwr1yv7MXUFLC0Zhgwl1W+e1PL/i3jOm72WddW7zLE2mbOKUzK6cp5cn3zVTgRPo+NjFhk7gl9iEuoQ1aFag9RL7HqVVNHi+Uys971cF6ggTVCFqp2CoBVGlT8vv2r4XqS1jYY/7KvtPEZX8ZhUg6w2MOxtRoySYsdzIDvcRxfLtZwWJjiXX5sPfGqfXiICXayOEqcpa1Is1NP+/nmLK04BeNHyiYs+TRX99tNiN/G2kNwmAq5KsFrw9Fo1bjR+a3+aZcY1JIyUVQkfOYprrX6SgS+qr7PjpuzKEGMYS8n7XirQcq+Ic/V6yBcfacCAK3Ik/DrWZHInCRzs8MCc0sENMMMQGL3X5Xz7d+Nv6JPaRQ98IHBMiDKOu1FtA63hCmxCBwDm5vGc/6S+EZ84/Mm34uHDeX/cJWsDqY6mJHygnexcO9FVb+eaqXa3tQ4aPtygkTbbJLD4yK2Ewh+3M0vMFrJ/QbyCFHnGKwwT3FcHFhkfNiOfwPwvWoS2BpiZXV3bMIh+d6J0+4kOycBQicrcA6gfawUlWL6ATRty64D6z0GT0WiRvsFvxhSBQLai8dgs5Noi9LZkWfYWSfVASilutIqk1AAGCzoE58cBgX9yHv4xDSvb8ucCKt843wxYuvF18QaOCdI0bYYqC4qaoMcyL/jDSitqm6izohVpuXdGgQVczxzIjhzVz0+RbVC9Or8We+0RgdQd2myqkp4+JLLpGoxNmXzHdkRaDBlSv4DLGF4PFTv8ey8czL9ddAPwSeVCW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(8936002)(4744005)(5660300002)(2616005)(86362001)(6512007)(2906002)(31696002)(6506007)(53546011)(478600001)(83380400001)(71200400001)(36756003)(6486002)(186003)(91956017)(31686004)(38100700002)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700005)(54906003)(122000001)(316002)(41300700001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0k4dXVacm5hVHUvZGdMSGdCbkxLUytUTnMrR2x4S0lwV2NIYTl6R3I2aUJH?=
 =?utf-8?B?WXR6ZG84YlVVSkJlOTBXNFRGMjd2aWh0OW9nbDhodnUzdmY0Z081T0pnZkRt?=
 =?utf-8?B?SHUyS1RiL0ZNVE9xVW5SVTlpRUtjamc1dEt1cjF0UjJYaVdrS2dGU1NqVTNO?=
 =?utf-8?B?VUErS2R4bHJocWNzcjBoZ1c5YktCQ0F6bWxRWWRXdExrc0htU3V4RXpkZ3pG?=
 =?utf-8?B?Q3Z4Z0ZSb1dlRjVkVjlkQ0FsR1hLQlhsR0luSHV1dnZSd0NjMFlzSzgwaklR?=
 =?utf-8?B?VW0vTFJZNThGSTNNMnVJUHlyaGkxZTh3THRTbjFzUXNJRWNUTUlHN01oZ1VG?=
 =?utf-8?B?YTh1VEQyWTMwNUFhcTRMbVB3aGNMS2NXSGlMYUdoMk5LY3FGRlBDbTBzN0Jv?=
 =?utf-8?B?NTJmSGdvTUh0WVZoZ24rT3hHSmt1Wm1BSTQxckFiNW9rOXlxNHhybm5CWHBi?=
 =?utf-8?B?ZnhBVm4rWkFMSERsdzMxYVZoUzBZTCttdi9iRXFwOEJna1RwT01tQW1iRE0w?=
 =?utf-8?B?MTloUktOL09GdEZnbE9jUlZWLzQwczRoN2FzUmR5U2gwZGRsMW1xZjVndmJw?=
 =?utf-8?B?VVNwbzJqanJWamdjaDE3V3pHWnlsRXpLdTBPaVBUUjBZck1rNmxibkQ0WE9i?=
 =?utf-8?B?Q2NDSFVZQVhLdWJrM1hnazZ0bk0rRHcrZGNNUmNTejE2U3UzNDdCTVpSL2lK?=
 =?utf-8?B?YjhXV1NxUndMZFdzaWFUcyt5WDQvNEsxblVTY1Vpc0xNdDhQSUU5T1AzT0NV?=
 =?utf-8?B?MGJocWNlcngrWXNwUnBkdnB1SHh1d0lKVkZEbW5ENVdTUmxNeDlrV3A3dmg4?=
 =?utf-8?B?N010T1YydGl5alJFVFNOSzJrcytRNjg4TldaS1M3T29wbit0QUlHcDJDUmFl?=
 =?utf-8?B?cURiTTVoUW9CZTRzSmdhL04xZWNmakFieUc1VTZJUlJLRmd3a0dPQmVzUThK?=
 =?utf-8?B?d0FyZjJQSjdDQk1URk83d3RYSHluam8wREx5eFRnVHVZbU1DU2tZOFlRQ09U?=
 =?utf-8?B?NmUxS0hRbWtRMEpkYU5oSFhvV3hMNWVMUCs5cjN3WGdWRkVWM25zNnN4UHhP?=
 =?utf-8?B?dTFGUnBMclFrN3ZsSytnelhtWkJYTFptYkIvdXVYZkRWUDZ1dHB3UkxIVjh6?=
 =?utf-8?B?M1o3elVHOU9aSS9waFZDV3Arb3d2YlNBUzJyckZiaDhGU0EvTnZJcFM1OXhh?=
 =?utf-8?B?UVVDeS9qYUxJdThXWlJPTDVxVU53U0lPSnZrZHVrcEtyZUpTa1U1eFRSVVV0?=
 =?utf-8?B?MitKUExYT0V3SytsUUhXUVB6SDR4dzlvSUM2aTdnZjRLajI0ZldHaEwwdXBn?=
 =?utf-8?B?M1U1Qyt1bEFiMm9pQW13K2VPV0pUVkVzcEQ5SVY1MEZYdGlqK2ZLV3hEZnJ3?=
 =?utf-8?B?WktnaG9qQStHZ2doRkxVZ1ZVVFNZT3FubWdCYkFwYlMwME1ic1JiM3B5a0ZH?=
 =?utf-8?B?L3VkSmg3SGVXL3N0cmMvM0NRSVJQN25Bc1hiMkszWS9hUnczV3FBTmh6R1Bj?=
 =?utf-8?B?NEdKVjB6SEpkNEVQTmxrcFVqaVBWc0ZhTWFtbDByQmxZYW5BVGZONWg2QUJr?=
 =?utf-8?B?eTlNdjl4clJ0dklETFdNQU81VExpSS9mY0xlMHVuTnJSZHlPQklsREpJdEhw?=
 =?utf-8?B?dGhXMVZmQ0lRNzZZbXJMdFhKdXRUU2c1YlcrU3Y5NmVQTTd1a21POWN3YWVh?=
 =?utf-8?B?TFZlMkhZVUVmREgrY09KS3ZBcnY3L0dyT3dRTTNtZktodWRhMzI1Ym02RmZY?=
 =?utf-8?B?VFRJUGU4N2Vlcyt1cm1CNHlUcW9INndlQ0FuV1NiZ09lMUdGajVMTTNUMjJM?=
 =?utf-8?B?Q0FjOGdoN3NhSnk1eE01VmF1U2lmcHJOTDdZdmovLy81N3J0VFpBKzA0bjVS?=
 =?utf-8?B?elJJc3pIaDI0UG13T2tuakNLUGk2aFBqNzFDdEhOcEtiNVVPN1hUOWlLczVq?=
 =?utf-8?B?R0NhY2ZHY0p1Q3VZcmtMa3FxQ09meGZGOEhUVy81c2luVmNFWE1VU3k0dWp3?=
 =?utf-8?B?MGJnZGNwUWM3VXNSOVY0ZCtqbEFQNXlWOEFSQmQ4RGx1NU9pQk1aMmNtWTJM?=
 =?utf-8?B?WGZPUUdvM2VycDA5NjRYT012VHo3VElhNFZlb2llMFQ3STVNczF1Smw1Qi9q?=
 =?utf-8?B?eHI4bDB5N24rSENIZExZbnpydjAyTEJsc0tCSUFxNjNBTVpBakRWa2doSysr?=
 =?utf-8?Q?cdk4I6pXvyUpU4G6HJyQYy7/JzQEo3qq0opcPzRB//ZK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA5F7A91D90E647B148E35965DA23CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673f75c3-0fa7-4e0c-fd6f-08dabae4263f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 02:03:48.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7HUCSExTR7D3n646PaNWXL4ITEBO0yFYjqgJRy+lIeG9Qc7+b839yZB2HPbnzRb8G2fSJzd0IHiakt/MtGZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjkvMjAyMiAxMDoyMCBQTSwgRGF3ZWkgTGkgd3JvdGU6DQo+IENvbnZlcnQgY3VycmVu
dCBsb29waW5nLWJhc2VkIGltcGxlbWVudGF0aW9uIGludG8gYml0IG9wZXJhdGlvbiwNCj4gd2hp
Y2ggY2FuIGJyaW5nIGltcHJvdmVtZW50IGZvcjoNCj4gDQo+IDEpIGJpdG9wcyBpcyBtb3JlIGVm
ZmljaWVudCBmb3IgaXRzIGFyY2gtbGV2ZWwgb3B0aW1pemF0aW9uLg0KPiANCg0KZG8geW91IGhh
dmUgYSBxdWFudGl0YXRpdmUgZGF0ZSB0byBwcm92ZSB0aGF0ID8NCkFsc28gd2hpY2ggYXJjaCBi
ZW5lZml0cyB0aGUgbW9zdCA/IGlzIGl0IHRydWUgZm9yIGFsbCA/DQoNCj4gMikgR2l2ZW4gdGhh
dCBibGtzaXplX2JpdHMoKSBpcyBpbmxpbmUsIF9pZl8gQHNpemUgaXMgY29tcGlsZS10aW1lDQo+
IGNvbnN0YW50LCBpdCdzIHBvc3NpYmxlIHRoYXQgb3JkZXJfYmFzZV8yKCkgX21heV8gbWFrZSBv
dXRwdXQNCj4gY29tcGlsZS10aW1lIGV2YWx1YXRlZCwgZGVwZW5kaW5nIG9uIGNvZGUgY29udGV4
dCBhbmQgY29tcGlsZXIgYmVoYXZpb3IuDQo+IA0KDQpwYXRjaGVzIGxpa2UgdGhpcyBuZWVkcyB0
byBiZSBzdXBwb3J0ZWQgYnkgdGhlIHF1YW50aXRhdGl2ZQ0KZGF0YSwgZWxzZSBJJ3ZlIHNlZW4g
cmV2aWV3ZXJzIHRha2luZyBhbiBvYmplY3Rpb24gLi4uDQoNCmVpdGhlciB3YXkgOi0NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==
