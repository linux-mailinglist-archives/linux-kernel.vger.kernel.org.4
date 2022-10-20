Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36316055C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJTDH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJTDHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:07:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D81BBEFC;
        Wed, 19 Oct 2022 20:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS+TXJoxDKVjEJ6KRvvMN72V/oyZVrr9WoyKZfLHUkZsMJaKM2TrowTwZafCwbuQ7kboduaByMGIphXtbX5gZQAyCkptD4LHbeyN/2QkAYbDQwL2mrXUaG5LrcJPlILiN/6MtES18HEx2EZ4QEF1kAxFZzRPrTw2pENWqFjNG1dYTpmdRSZQ177pDbEy3iLPEv0zY35AW90WLzmUV1w9i0m3F/33lhNocD8qfZnSaTs4xDrpBHZPbjndRMtsfzhYtUwEzVZLzEdnMT5+48U5T2FyWO//q+DMQnq4nS4mla0+YYQOsT4qlHujpCTcoO7Fhuj1Cu0qoiTjt61OvUL8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enrcx9HbAYHNIyRAEcWaOdLf1z2oy1IttrDKXgKsRLo=;
 b=Wh4UslBfTtW6TwTNK7nSkMncu8nxOlXc6r7LQZctpSQjwtSuz2RgbulDyHbEQrA/qQQ7bv1TdTldvjn9F7uJ4mGyyk3+KtOWfFu128jeoENmDLYdAeIl6RVQjkep6AyjoInUzFgNI0r7/lF4T0cEqJee8/vWmpKfX+dMBWyWDhr/URq3aPFV+jFMaSX7pTpl2xeM2FoXU6HjzHgvf+5lNvm5UNvdRQuGwVX17eGf6967ayo0soL2xUE3DtgmsKzSwYpb7HUMedg2MS8pzE0dAjEga9h0PDDvP50hXfvrkPorOVP8unljip/uvg0zaT0bAyAdD2hrMubQwdqbCxbO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enrcx9HbAYHNIyRAEcWaOdLf1z2oy1IttrDKXgKsRLo=;
 b=dhJiMbIODjg5VnetXDwRomqjASninblvIF/YDxEnjZbO+tUq8+NBUI7rMiElTZPuIoJ3WIoZ/PMgN7s1jSSlaxHbJznTEz8DDJpXbR9NlANHi3jyReH9z8nsPzwm+x4jZZPBbjoGr0qlleZrmnPEJB3a8reRGE+1fOg460BhZBAFLRKU9Hgff1gApuQhwbugRmF+kXZbyA5RLVKI+ABnJIzSekW5Qd6v+07TQwQvc6di4iforWwEJTRrzm7+QrXS6t+KJ6Cz0VT5qIB7I/HHNT5yDMI9Ki+GiqlYHCplqyvJjBqJNFSwabtg4ZgfNzrQfhpcZwQHtBjYmLvWCOmIUg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 03:07:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 03:07:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "michael@allwinnertech.com" <michael@allwinnertech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "megoo.tang@gmail.com" <megoo.tang@gmail.com>,
        "lzx.stg@gmail.com" <lzx.stg@gmail.com>
Subject: Re: [PATCH] mmc: block: Support Host to control FUA.
Thread-Topic: [PATCH] mmc: block: Support Host to control FUA.
Thread-Index: AQHY5C4R+Pr0dLPpxEm18CnIRRxcXK4WmcKA
Date:   Thu, 20 Oct 2022 03:07:17 +0000
Message-ID: <b9ca56af-cb06-4fb1-d5d8-7426629dfe2b@nvidia.com>
References: <20221020024529.25227-1-wenchao.chen666@gmail.com>
In-Reply-To: <20221020024529.25227-1-wenchao.chen666@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6352:EE_
x-ms-office365-filtering-correlation-id: 95572e1c-3811-4a4c-9866-08dab2483255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmnRACJvb9ohN8p9fXu0tczp99RzJLHzKgQPfN6qgDXaK88iN08faitzUjxzBwjFIj9XqUtwsQgzQAJtOr/N738lxIkFqsoEwk/NHcWJC3ec9fTkwq+UkazhOapa2FaQ1J8Raece73+M53T3xTsR8n5JsLvqWHeyJSHf+M+eSLxTXQ/bP6syL4yywsSjNB1LmXvBP9rvVj9zxfJpcO1RNXAJK+pF5OniEvKiPImv2Sw37jU2t6xEdNycHsOe9JU0n5UAnNxFeWThW9Kum9ScQGyG+Caamy2SrUA4LYx9BnOf/GuNx5inNxgUDyUtXjDw6gc3f2Y2vAz1f1+wZoDRjrIQHo9AFK9yuDaHU5kiFH4wWSRwIgn+6t6jlHaujmCA3GRYzOzx7jAcOHaMmkYnZR4/yW+t0JtqNEB23aPH4UBBnXOsaA8q6yMvf8uMEt6kkWdzFDHpXvNTQIquxWRsDtC3+nla9traR4WkfXyFJPFA158sjWZZb5AB7Cu1PI5FBjDyj8uH8Hb+v8SFTGr03wRCRkZkEqRMfdDIvTPKbcaRaWufM1ZonfX65aB9JMiaw2Lyw7FmvzrN3yTPH73iLI6OPZmNQ0NmUE2oCCMmaVpRiWsqDfB7Zwxb0B1ztGH63700wAIxUnh8hIso0eIegjDSp4hwDRSw8MjaMeI0NgQl7jizIZdClkL7Tcp5zcrxs28NVLOi3aeSa2LVyrMFY2u394RqJLVbfDVfOxgaqIdPsk3BQEm6I0mtpTau0ce0dldG0f9zj1h0H1UDyINOVVGGItatX3FPFTuVoj3BsHKo7myjt56jitlN0PiDhzFIKbCUgCE2iFQG/tLpI2p81A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36756003)(31696002)(86362001)(31686004)(38070700005)(122000001)(38100700002)(2906002)(83380400001)(7416002)(5660300002)(6512007)(186003)(53546011)(2616005)(6506007)(54906003)(478600001)(6486002)(316002)(110136005)(4326008)(76116006)(66946007)(91956017)(66556008)(66476007)(66446008)(64756008)(8676002)(41300700001)(8936002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHF6eGcwQldiaGdMSWFBY2tNZUc0NzZxaTM0UjNDSERrbmhCZi8zeU53dWxZ?=
 =?utf-8?B?aG5aVUtnOXEybmpETzV0T3VVZmU3VjJJcDNRYjhZcmpjK2dwRFc2R3d4R1o5?=
 =?utf-8?B?RWlnT2N4U1JDZmpGOTBjLzFFN2tBcVEzRVJhZEJ5U2IrVkhyVmE1KzZPditV?=
 =?utf-8?B?TkpaMVh0cXB3eUdOQXhnUlppVkN2M1Rtc3ZxNnpYT1hjTFZ3UHFSR3A0ekY3?=
 =?utf-8?B?bnRqaEIvWmlJZHdueTVQY1FVeEc4dml6aGxlMTA5Z1RlN0s4QlRzVHMvRjFZ?=
 =?utf-8?B?cWZxbFFYYWNUSDM4NWlYWnhlekRFTFkzUmFmb2tSbVZQcjQxMU5pSFNpNnhv?=
 =?utf-8?B?aisrNTB0bVJBcXBIZFU3U1U0VloxL2tVSlVZWjFIaDVhYzM3aHVoR1A0N1V1?=
 =?utf-8?B?bys5SXpMRXhDYTdXSWpkNi9BbWs0QllZOHUyc0NJSHNGaHU3MzVuUWt4dGZQ?=
 =?utf-8?B?eDF5dE9ubmlsSG5LZkpSTEhpZ3VMSlU3TWFkWm9mQk5UR2cwZEdTTzhSYU92?=
 =?utf-8?B?WWJab0x1b1J4ZUNnbjhOTjBKdEthUFkvSEVlbStsV3lqMlJYTmVGaFdVZHhS?=
 =?utf-8?B?VXU3NHI2UFhGeXIxREh1Vmg0enF2am9ndzRpL2ZXN01LQzZocU11bVdGcWN2?=
 =?utf-8?B?czhIbitZODR2M0hSNFVmYVZ0TUh4WDRRZTdFOUVLNGJpUkhXbktxdjdhMGlB?=
 =?utf-8?B?UnBHdHpKRFNLR0prTVZNMnUxVWpELzlPaUsxWXo0RVJMN2hJR1NIRnhSb1RD?=
 =?utf-8?B?ZHM5VHdycm1XMGtLZiszQVY2VnRmTzFrbWhXeitHVzdzZDJtMU1VVTY4azR0?=
 =?utf-8?B?WWxPV0Y3Y3RQUVcxYTVUNFlYSmJDNU5uc0c5eUN4S1FjL1VLZUdYOTZlZHlO?=
 =?utf-8?B?czhIT2daL3BZY3JDQ0NyMFRiMmd4bnE4cUVzZ1VPczIwVXdxYkVjbXd3cHV3?=
 =?utf-8?B?UDB4ZlFtR0xkKzVOaVFZcS8rK3IzOHRBM0ZxR3V5L2FlZWdtU3FDZ0JGRWhy?=
 =?utf-8?B?QnZQdzJ1YVFwMmN2dCtnaklaTGJ5Q2JvT2poZzFHRTN6MkVzZHFDTnV3VC80?=
 =?utf-8?B?Wm50VS9JQUozOEcvS2lFWlRCVU4wMHZFNUIwcXptRnc0MHFaREdBSXRNTzND?=
 =?utf-8?B?aEFWdVErS0tacXRibXd1UDU5bWlmVUlGclVIVXhhclh6OHpVS3lIYVh2MjNG?=
 =?utf-8?B?bWEzSG9HaDJzdFJqZWg3YTdtckhIQ2x5ZEc0d0ZoRzZSSzlQa1p1TkxHZkho?=
 =?utf-8?B?OURTdWpQWXNuQS9XazN4NmswNW5yZHVXTXRiMk13dzZpV0VkWDF4d1FLUXIy?=
 =?utf-8?B?M1g4QXJ1ZERIdjgvZmJ1RUpEQk1rOGJGa2ZTQjNrUHNpRjRkWmRPZUJnSFJN?=
 =?utf-8?B?djl1dFFyajhsUU1HbGFySDhNQnVFSnZhenMwYXFlRG9BK1ZaeUY4ZHo0VHBI?=
 =?utf-8?B?VjZYMTdiMkFzOVMxM2JCMklkRVI0UDFEU2xSb0E5ek1GVUI4YVVTUWpuZVd6?=
 =?utf-8?B?TzI5L2szR0ZpeGk4RFY1VS9mYmJlQW8yZlZsU2pXcjh4YU9mdWlVTGhydXBo?=
 =?utf-8?B?bFhRSit6WHpkdFFIRTlGaGQvd2lDdXhkd3p0RHlkZ3p0R0Rxak81T1JXK2dV?=
 =?utf-8?B?a29DUG01MTJoWEllRUVObnMwTW1QR2V0MlNZSE5ZdmllN05ONHUwSjJManVF?=
 =?utf-8?B?MERHNFN2RzllR3ErcStxdmdzbDg2Zklac2h4QURJRnQ4TTFoeGlBQWhYWFE0?=
 =?utf-8?B?RnJJR0RKRlFXMEJaR3VuUlBQWmhNVGErN3BuR2dTNldTenJObEpST3QzMFNK?=
 =?utf-8?B?WmxHeFMzci8vSE94WEFFQWc4dlM2Qi9BaDNPdUlCK3NEUUdzZ3ZIczRnZ0VK?=
 =?utf-8?B?em16cWpKL0VPaElTZytIcTRHQWdIeFRDNkt5a2FCY3FHUVJsczhIZzFBYzQv?=
 =?utf-8?B?TkpVck1pK3JWeEs1aVBiZmZBbSs1ZkFMWXJDSXZLcGxVY3hrZzljcm9MTXhB?=
 =?utf-8?B?a1JFZythcnJqNzI2KzhxMGg5NDFIQTljRXZ2SGxoNEIzY3ZLWXdJTmZnbEZY?=
 =?utf-8?B?OFh2VVl1ZkNLUHV2TFBONHNPNkVKejFPMFJINzh1aVZ1SlhNN0M1VkNteno3?=
 =?utf-8?B?TTBRbGJobHNWdEtEaWtSY24vSzF5dzBVdTNoMGRlaGV0SmJTcmhCWnpRL1dJ?=
 =?utf-8?Q?NkxEcKnJBzVvn+bCLQveztsX+iyttFbGNJ3pDQrWtQbH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2EA9DE94B61D34A8C9BF2DE1FA4D8DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95572e1c-3811-4a4c-9866-08dab2483255
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 03:07:17.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /q1M+KbUOeC8jR8AFjw9UCBkX5vVjgYDgo/5TF4eMDNbELl6h0sanX6tyfMbv+X0reOH05FH3mJGTFhi+M17Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTkvMjIgMTk6NDUsIFdlbmNoYW8gQ2hlbiB3cm90ZToNCj4gRnJvbTogV2VuY2hhbyBD
aGVuIDx3ZW5jaGFvLmNoZW5AdW5pc29jLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggaW50cm9kdWNl
cyBob3N0LT5mdWFfZGlzYWJsZSBmb3IgTU1DIGhvc3QgY29udHJvbGxlci4NCj4gVGhlIGhvc3Qg
Y2FuIHR1cm4gb2ZmIEZVQSB0byBpbXByb3ZlIHBlcmZvcm1hbmNlLg0KPiANCj4gMS4gZnVhX2Rp
c2FibGUgPSAxDQo+IC9zeXMvYmxvY2svbW1jYmxrMC9xdWV1ZSAjIGNhdCBmdWEgMA0KPiBJIHRl
c3RlZCA1IHRpbWVzIGZvciBlYWNoIGNhc2UgYW5kIG91dHB1dCBhIGF2ZXJhZ2Ugc3BlZWQuDQo+
IA0KPiAxKSBTZXF1ZW50aWFsIHJlYWQ6DQo+IFNwZWVkOiAyNjYuOE1pQi9zLCAyNjUuMU1pQi9z
LCAyNjIuOU1pQi9zLCAyNjguN01pQi9zLCAyNjUuMk1pQi9zDQo+IEF2ZXJhZ2Ugc3BlZWQ6IDI2
NS43NE1pQi9zDQo+IA0KPiAyKSBSYW5kb20gcmVhZDoNCj4gU3BlZWQ6IDk4Ljc1TWlCL3MsIDk4
LjdNaUIvcywgOTguNU1pQi9zLCA5OS40TWlCL3MsIDk4LjdNaUIvcw0KPiBBdmVyYWdlIHNwZWVk
OiA5OC44MU1pQi9zDQo+IA0KPiAzKSBTZXF1ZW50aWFsIHdyaXRlOg0KPiBTcGVlZDogMTk5Ljk0
TWlCL3MsIDE5OS4xTWlCL3MsIDIwNS41TWlCL3MsIDIwNi41TWlCL3MsIDE5MS41TWlCL3MNCj4g
QXZlcmFnZSBzcGVlZDogMjAwLjVNaUIvcw0KPiANCj4gNCkgUmFuZG9tIHdyaXRlOg0KPiBTcGVl
ZDogNjguNk1pQi9zLCA3MS44TWlCL3MsIDc3LjFNaUIvcywgNjQuOE1pQi9zLCA2OS4zTWlCL3MN
Cj4gQXZlcmFnZSBzcGVlZDogNzAuMzJNaUIvcw0KPiANCj4gMi4gZnVhX2Rpc2FibGUgPSAwIChk
ZWZhdWx0IDApDQo+IC9zeXMvYmxvY2svbW1jYmxrMC9xdWV1ZSAjIGNhdCBmdWEgMQ0KPiBJIHRl
c3RlZCA1IHRpbWVzIGZvciBlYWNoIGNhc2UgYW5kIG91dHB1dCBhIGF2ZXJhZ2Ugc3BlZWQuDQo+
IA0KPiAxKSBTZXF1ZW50aWFsIHJlYWQ6DQo+IFNwZWVkOiAyNTkuM01pQi9zLCAyNTguOE1pQi9z
LCAyNTguMk1pQi9zLCAyNTkuNU1pQi9zLCAyNTMuNU1pQi9zDQo+IEF2ZXJhZ2Ugc3BlZWQ6IDI1
Ny44Nk1pQi9zDQo+IA0KPiAyKSBSYW5kb20gcmVhZDoNCj4gU3BlZWQ6IDk4LjlNaUIvcywgMTAx
TWlCL3MsIDEwMU1pQi9zLCA5OU1pQi9zLCAxMDEuMU1pQi9zDQo+IEF2ZXJhZ2Ugc3BlZWQ6IDEw
MC4yTWlCL3MNCj4gDQo+IDMpIFNlcXVlbnRpYWwgd3JpdGU6DQo+IFNwZWVkOiAxNTMuN01pQi9z
LCAxNDYuMk1pQi9zLCAxNTEuMk1pQi9zLCAxNDguOE1pQi9zLCAxNDcuNU1pQi9zDQo+IEF2ZXJh
Z2Ugc3BlZWQ6IDE0OS40OE1pQi9zDQo+IA0KPiA0KSBSYW5kb20gd3JpdGU6DQo+IFNwZWVkOiAx
Mi45TWlCL3MsIDEyLjNNaUIvcywgMTIuNk1pQi9zLCAxMi44TWlCL3MsIDEyLjhNaUIvcw0KPiBB
dmVyYWdlIHNwZWVkOiAxMi42OE1pQi9zDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGFib3ZlIGRh
dGEsIGRpc2FibGUgRlVBIChmdWFfZGlzYWJsZSA9IDEpIGltcHJvdmVzIHRoZQ0KPiBwZXJmb3Jt
YW5jZS4gVGhlcmVmb3JlLCBpdCBpcyByZWNvbW1lbmRlZCB0byBzdXBwb3J0IHRoZSBob3N0IHRv
IGNvbnRyb2wNCj4gRlVBLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VuY2hhbyBDaGVuIDx3ZW5j
aGFvLmNoZW5AdW5pc29jLmNvbT4NCg0KQmFzZWQgb24gdGhlIGRhdGEgcHJvdmlkZWQgc2VlbXMg
aXQgZG9lcyBpbmNyZWFzZSB0aGUgcGVyZm9ybWFuY2UuDQpQZXJoYXBzIGl0IGlzIHdvcnRoIG1l
bnRpb25pbmcgdGhlIHJlYXNvbiBiZWhpbmQgdGhlIHBlcmZvcm1hbmNlDQppbmNyZWFzZSBhbmQg
b3RoZXIgc2lkZSBlZmZlY3RzIG9mIGRvaW5nIHNvID8NCg0KQWxzbywgaXQgaXMgdXN1YWxseSBo
ZWxwZnVsIHRvIG1lbnRpb24gcGVyZm9ybWFuY2UgaW5jcmVhc2UgaW4gdGhlDQolIGluIHRoZSBj
b21taXQgbG9nIHNvIHlvdSBjYW4gbW92ZSB2ZXJib3NlIGxvZyAobGlrZSBhYm92ZSkgaW50bw0K
dGhlIGNvdmVyLWxldHRlciBmb3IgZG9jdW1lbnRhdGlvbiBwdXJwb3NlLCB0aGlzIGlzIGJhc2Vk
IG9uDQp0aGUgZmVlZGJhY2sgSSBnb3QsIHVubGVzcyBtYWludGFpbmVyKHMpIHByZWZlcnMgaXMg
dGhpcyB3YXkgOikuDQoNCi1jaw0KDQo=
