Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB34600AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJQJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJQJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:30:51 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FE3BC5B;
        Mon, 17 Oct 2022 02:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rklqz2q2GFAUNDOcrWThAQcYKrPz7FFX83zmBwbL/Wl4BJhJZ37eejO555Ersqt5jXPTTqMmRZRc99E8DN1gYTPKjDTEicBmBPPJm/s5fi0H6you55Op2BkWO6LoFnMTsx8CMY5Qa+B2022I4JaOH1pvJ9OKnceG13bRorwZdfvsVC3gr8acvwnQvZo4/+mEdO9IYXD0hxnvU6kSNLxdNoPsL+nQUo3UTDguxg8zhEvF5A4hjpKZMNT4VpyE6qWFjT/DbeALwY1xmyFfEcUSH1P7p2G7bnUSasXZF/HPjP8XdvfZGOYmE+04DOQw4ppzp0C3DNfX449ERH4570sCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKbwp4vl449WKRkOdhdTELqRvMWy+X7TJvTqWVp6UN8=;
 b=ltnXS7fAHhA3SOS26Ajbshgcw9FMZ7tJAT+I5oI4O20d4k8JSKi7a4fjTV8iXISODmmaquAzj4PHLksBOCYKyH0YVuu7YGzxHPipHRw8TcPAgL486hAt/9d9hG7szEHGat2L3TJu3Nyl7+FXUMtujYfGeigc3t8jEFNQp2UTYIsfowFnL1HIWuOp85aJfRCJpBQmAsmECkJ+NXN/v8IRGpUsre9eQZYLoM+dgNTmm3VQ/PylS2zn+WcldZckg5WFg0IFNBduhlhNGmKlGAGBK8g/R4Z65L6ErFC0tptThPlowWZV5tQUbRuqMx0HLw0gyA6cU4BG37MfPPv5z++srg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKbwp4vl449WKRkOdhdTELqRvMWy+X7TJvTqWVp6UN8=;
 b=Tx64zM+3MFjpSuzHWLzWRYSkmaB80Du/hZOwdqSxfDRql7pX2Qk5W3MnQjNNKz3MntyoEnOX+b2hiosvr2zqEyXx2j8nwaZMYeu2Zo/Q3fRRo6hF7fGacRszJCUVn+wSi6K29btcfZAWzPdh1mN02eXrRrcdG7XtbvBzjh6NjLrSnxVrzK/U+P+yBdXPtc8CiQQXli8NBIhN52IF6TULRhGSEUOrYBzbM2l7y051JpjqWQT3dWZbdBYJuIGpiNqkolVSCqsrwnUM9ygEe1sQXE58v0gihQKtmAfOKNNoRL2Y0U8JjwOqDiFm2w+ABswPdQQs122s67iG5OG3zLedBA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 09:30:47 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 09:30:47 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Thread-Topic: [PATCH] null_blk: allow teardown on request timeout
Thread-Index: AQHY4R8DFU2LJu/Wy0udZZqXPfzvLK4SUpaAgAABcQA=
Date:   Mon, 17 Oct 2022 09:30:47 +0000
Message-ID: <0af3d1a4-8166-ea1e-8710-c51479c587a1@nvidia.com>
References: <20221016052006.11126-1-kch@nvidia.com> <Y00fkc1N+Cif/Kxt@T590>
In-Reply-To: <Y00fkc1N+Cif/Kxt@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5903:EE_
x-ms-office365-filtering-correlation-id: 97663bb3-3374-4e35-8d81-08dab02245d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OT7qC9ClJjnlqWPJH/JEi+FlYlN3sDrbBWPq7UiQSwpcOPUsf9fDANTc6BQbMc7n5rZhQe3DwN3+hN/+4jj+b0XqiX8w723UPX7BF6OjmrkcQr+oAbLfbgEf8PoxmoZYixvqntyH2SA7vwRpq3coWoVs9//I/xVZKbuwK/qu5tbXfg/cV6scSf0RO9At3B7ZGjp9ixOFpm5uQsYxcVlMbsuYr/XN5zvHGe2pZbhzJ6FIssaiyiFGMZrDiIMQaTkfdpuDv/sDzCLvR976YqLheMSMPuScE6E5/TJ8aaO6vXJYv6wS3TiYNIYebdyuFcRMw9h0ttp5xgoaV8S457g4ua2AuI/fe3XmfSBtiH/bIOYvQ7nLuldiFXnSh2rN4kdqTInawhFQGkDVV5rHuRdPFGXWgZoQyUMgilpKeWfvLr0SSJwe/z1Q95ER93sGlZDNMg1Ng2gnRuyN+6W8duGXE4/bXurX6Crh7LBwqzwqGgM3Hg8R7xpmEz+u07PutLO0GwJiv3feU2c7KOC6boMWf16wCAC7p1YTwfH0XAufUwyzLF1i+UZWshZsZDLTOUUxqaFf+GxmaNktglEwk9u6wiVbMybItG/FXdjFddq5N/BVpB4rYuTR0SkYefqcrjI21PspdBINNBn4DfP4prSsBDcDVlDTJCiC1EmsTqbIGdjEtcHYfDpfFzN1R6PJWHfNMM3knqN9YlER4S7/yV0g216nA1/kjH9qFBIoyeX82Qsfhighyq3+wBLJPx9lagXyCEEXVEArU7pJy0glwSlwJGO+2h8eTqPGxZqo3T0knFuHxpIbQnCM9GPcOoJ3FhigU7Q7GSMtdrwDCz96/gGI8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(6486002)(54906003)(2616005)(186003)(38070700005)(83380400001)(86362001)(31696002)(38100700002)(122000001)(4744005)(7416002)(5660300002)(2906002)(41300700001)(4326008)(64756008)(8676002)(8936002)(478600001)(6512007)(6506007)(316002)(110136005)(66446008)(76116006)(66476007)(66556008)(66946007)(91956017)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3pEVk52dTNIck9GUUxseUdIL0hGYnppSTJtZmtNRmsvOHlSbGhXVnd3ci9E?=
 =?utf-8?B?S21XQ0RHbVlMYlUyd0ROQWMrUkNDaCt2WkFvZDlGTFQ0REFxUkFRTDVnSHM1?=
 =?utf-8?B?YWp3T0lrRThpUVBFekdPb1J5TXpwQnFhRHNSZU9OR0d6a05nWkRuUDVJa1c5?=
 =?utf-8?B?WlJ4SjhlMU80TVZCcVRxREtYRTNzb09jRnNja0l3SnV1NGpCamw1bEZqc3hF?=
 =?utf-8?B?NEs3VUxKVXZwd0wzSkVqNTY0RHgzcktPanRQaTVDTjNnNTRSSnFXcHdSOHhQ?=
 =?utf-8?B?Z0NSZ3lMTXpPTW5GMWtnalVwSk1QUEVJUnFMWXJHZ01nMkdqQ1QrYThXcG4w?=
 =?utf-8?B?TWR5WDNnRjMycmJJR1ZDT2gxWWIrVE5uMTc1SE1pakl3OWY4cDFLZ2ROZERM?=
 =?utf-8?B?UFRsYk9lY3N2R2JiQkw5OHhkOU90aUxUQ3NBVndTTk93WjRaazR6bm83cTdL?=
 =?utf-8?B?QXVFaFExcDg2N0pRaHVTM0oyWVR2NnJHeEFPS2FZRDdYdTFSY3JmVWRyRDVl?=
 =?utf-8?B?c0VjYTBod01xUnlaVllsRlMxN1pEK2V3d1VpVDl0a25RcXFGQkxDZXNnSEVC?=
 =?utf-8?B?c2lEVFpsbjNDL1QxMTlXNnMxNlZNNENXLzhqSGxnNkh4RFZYd1ZscU5iL0U1?=
 =?utf-8?B?bnJNZkhyRzlhVWIyZ0RFbFRDeTgvRnJROUFDa0xBUjdvYUJGVWhIL0xjTWxC?=
 =?utf-8?B?d3RKTVFNd3FqTFBqUlNFR0tPc3VNc3VMNldrUTNxNDZXNlEwMEQrWHdCSklo?=
 =?utf-8?B?R3lBUkRVTDdmN2EyclhIZmUwY2VuTnVPUjhOMTBma1B1WE5RTzFLd1hLSXRw?=
 =?utf-8?B?bkFhTmh6WVhBNW1JOU01a3k1dVlpR3FSQUg2S2E4SitibG5YU0RsRThOYWpo?=
 =?utf-8?B?U3kyRFVCRnBqS3NaaUl3TUNKL1ROWmJBRkhka0lId3N3eFFwT2JHbkszUEts?=
 =?utf-8?B?S0gxSklqQ1UzQkRXS0E1RWljUjViT0hTMTFqVjBlYVV3WkhJRHFOcUhZR0pV?=
 =?utf-8?B?WGlsc0VaRHpMVGRjalhpVENTMWVoYTZJaWYwVk5Ob1U4Y210ZGdPTHhDN0JK?=
 =?utf-8?B?SHZwUWx3TjNuRllBQ08zanJIRGZUVXZJT1hZNldpUENpY3Rvd2s3SWpPT1Bm?=
 =?utf-8?B?Rk5PaVBTWGN4RkVsNjN3SDl3a3c1Z1lYeGFVQlY3Wk9GSkFPWStsWGQrbjNz?=
 =?utf-8?B?RkRacmxLbnNqYXpTTXlkbTlsSUVFZkRkN25BMDlzZTZKZDJuNnY3THdIYWx1?=
 =?utf-8?B?Z2dxKzBGakROYm9pL0ZUS0lDcng5UEZRUFNRV1pqcHpnM0l3YzNUdUxIajZk?=
 =?utf-8?B?MXA2dThQYlVjZ0czQ0VpYm90UzMrKzBmN2NvSGVhOTBYdG93dGJOYzU1em1M?=
 =?utf-8?B?RG8zU3AzVjRCQXV5Q1JNTGhGaENkaXdLcWJEcHVGbHo4V3ovR1hyV3pzek8y?=
 =?utf-8?B?ZkZTelNVODFBUzNmMEpoTXhxUzlpV1JSalQyZkZmYWFsQ1h3WC9sUmlOZUh4?=
 =?utf-8?B?ZktNZTBSdElWZC80bXVRbWpqZjlmMTJML1dOalFnOGFTRjhVSHVxeUJhVkJD?=
 =?utf-8?B?V1poMGRMdWY5dWJtVnNnSzNUdGV1SVJXL2R0bHdWZXlGTlJ4RVIvVWt5YVJO?=
 =?utf-8?B?OFNZWVgzZ2VnQzFHaW0ycjVFL1VLZXFCTG5hSWlFYkdXcEtDS1ExdnBVRGQ4?=
 =?utf-8?B?ZEtKMlhGQ0dUYWtJZ0JPWmE4TFJaSnlVTW45cVhJQWZDUHY3dUMzN0lhbklR?=
 =?utf-8?B?dUhtRkFvNis2ZmdtSGc3V1I5TUtRTmRZc0R6YkpkMU1qTHFZbU1IVlk0a1FJ?=
 =?utf-8?B?K0pGd1puRnRuTWk2Z0FvM1UxelVrMHgwM2k5NEJ4ZFFLMm1nWnRyTGpkeUw1?=
 =?utf-8?B?NE1QbUNiQnE2K2hUZ05rQUhQUmhNTW5CZGpTRE5GWjM0TUJhQTYzWGdEa1hh?=
 =?utf-8?B?OVM4RFBwMXVTU2cxOEhNM0s2SnBneTh1Z3YxVDVXQ3ArMEVtK21KK3ppeWdw?=
 =?utf-8?B?N0RWdHhhaitVZlVGNWV5MlU1S2szM085T005L1RqbUhFUndlRXY2RHF0djVT?=
 =?utf-8?B?Nkg4TnRTOXdRNUFDVkFIZWxpbW0zenlhdUQ4TkpPUjJ4RTNHVWRxN0E0MWhH?=
 =?utf-8?B?dEtkNXM3bzBBajRJenc5MEJKVFZCajcrWkMrZEwrTDNlNXJMbE1rMHh6WTc0?=
 =?utf-8?Q?UdzfdqEg+m/FFf5QqzxIsNPq1h/4lxpPSwlvYKOL89hy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <118A08C22EB362479A4C7952612CF2CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97663bb3-3374-4e35-8d81-08dab02245d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 09:30:47.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k75E+2+/Pn4fddGhYFfxDFBUeAZXCoYVDgdYzAjuf7GgRN7mdM1nmszauGA2HjSGu+QgIEk3OxMtOQ+LVOkSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiArCS8qDQo+PiArCSAqIFVuYmxvY2sgYW55IHBlbmRpbmcgZGlzcGF0Y2ggSS9PcyBiZWZv
cmUgd2UgZGVzdHJveSB0aGUgZGV2aWNlLg0KPj4gKwkgKiBGcm9tIG51bGxfZGVzdHJveV9kZXYo
KS0+ZGVsX2dlbmRpc2soKSB3aWxsIHNldCBHRF9ERUFEIGZsYWcNCj4+ICsJICogY2F1c2luZyBh
bnkgbmV3IEkvTyBmcm9tIF9fYmlvX3F1ZXVlX2VudGVyKCkgdG8gZmFpbCB3aXRoIC1FTk9ERVYu
DQo+PiArCSAqLw0KPj4gKwlibGtfbXFfdW5xdWllc2NlX3F1ZXVlKG51bGxiLT5xKTsNCj4+ICsN
Cj4+ICsJbnVsbF9kZXN0cm95X2RldihudWxsYik7DQo+IA0KPiBkZXN0cm95aW5nIGRldmljZSBp
cyBuZXZlciBnb29kIGNsZWFudXAgZm9yIGhhbmRsaW5nIHRpbWVvdXQvYWJvcnQsIGFuZCBpdA0K
PiBzaG91bGQgaGF2ZSBiZWVuIHRoZSBsYXN0IHN0cmF3IGFueSB0aW1lLg0KPiANCg0KVGhhdCBp
cyBleGFjdGx5IHdoeSBJJ3ZlIGFkZGVkIHRoZSBycV9hYm9ydF9saW1pdCwgc28gdW50aWwgdGhl
IGxpbWl0DQppcyBub3QgcmVhY2hlZCBudWxsX2Fib3J0X3dvcmsoKSB3aWxsIG5vdCBnZXQgc2No
ZWR1bGVkIGFuZCBkZXZpY2UgaXMNCm5vdCBkZXN0cm95ZWQuDQoNCi1jaw0KDQo=
