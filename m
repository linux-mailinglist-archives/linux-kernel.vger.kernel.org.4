Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD752679E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjAXQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAXQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:22:33 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6738474D2;
        Tue, 24 Jan 2023 08:22:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMrAzY2sbfdjyFUv/5DMrL9Ces97SS9UtHMSo5/IQm5xu2DfOGKEHWL3b+rZd1QFZ56DyjZ7Xr285E72LX1+PIMHtkwKZuM4DaCUMqsB5F6PautuqboDob4NI267IhUKZJljFH7Tx9DpEKDHRbgne+08y2HxNyzEIAM/ZBZfEvpAS+j04XQ/KyAe/3GwOyKyUQ3+UuJhtmykz84ewOLZjv4e68ZaD+f912jMV9k7pZcmFmgPHnka52iKTiJQEVYS9anLzsP3dpqtuAbTpdEaQc/TTEN0kM7/0MIt/DHZX8BNHHjkKHJBGD7z9/34o2MDi1uBQumVqVPMkw0wUvZATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=953DdkGokeZ5RhM7PwvVfxnff8c4XIHvlRUj/E7kCjs=;
 b=dWWwWjqSyeQCfhETfwEgOfSd5Fa7RglF1BtkRPiotS4Q4zWNcJv1MIRF8HUzP+lYXnP0Mvo4leHWARzt+UG+gsvuJpYEjo++N0sdrC0VeSicvOMxRhjIoF6buwONwlUXIhoTs/1jZVDVDft4NozcwWFr6otci4+1ooM7oF/dgJGDr2zVMC5Bx/zGJcCBZjHHC9XsSjJlW8hPQU7NrM/UE7TQmUR6bcVqKZ/er0VRlsCAOUx/iHkewK5uG6aC5398poUahFpsPvM0Ab3F1+R2XsqweudV4zaAVTx2/ZBnBlTl6XRbibeNKkKcU81ClmH9xuILjmA50bv0W+qJk6+3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=953DdkGokeZ5RhM7PwvVfxnff8c4XIHvlRUj/E7kCjs=;
 b=KTJJqY1p8ZeExaYvNN4ng3y09en7Ga1uT84Wl4J5L2wUvqHo+CkcirgZc/gTv0nPflLzhiwmSQznGzeyOljGXa8tSX/IlLkABFYAMZSRw8BOYTxW+seoFT6+fav92QlWpP+UEMLaSv5OcXeQoWF/Wf7yHtUht0rvcHLJ3MjgMSc=
Received: from IA1PR07MB9830.namprd07.prod.outlook.com (2603:10b6:208:44b::14)
 by BYAPR07MB4470.namprd07.prod.outlook.com (2603:10b6:a02:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:22:18 +0000
Received: from IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583]) by IA1PR07MB9830.namprd07.prod.outlook.com
 ([fe80::670b:627c:6340:583%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:22:18 +0000
From:   Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>
To:     "efremov@linux.com" <efremov@linux.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: general protection fault in floppy_ready
Thread-Topic: general protection fault in floppy_ready
Thread-Index: AQHZLFSYHuhRMTDDX0y0g0B88WvTjQ==
Date:   Tue, 24 Jan 2023 16:22:18 +0000
Message-ID: <IA1PR07MB9830D79E5B4E60B6CFC8F8FCABC49@IA1PR07MB9830.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Knights.ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR07MB9830:EE_|BYAPR07MB4470:EE_
x-ms-office365-filtering-correlation-id: 9c693ce4-57d0-4717-920b-08dafe2729ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUCWuXbwqJEiR8KPcdmVgIK5/PiUnOsrC4VS3qsFUFCtYFcDgBXwsRJedmawR/mOcnO1WTBCSmT2+5o27zFkcknGdHuXfrFzXnilEa0B/AdwlBV8erB6qtDzgSOc/SoMB4WClid334qdq6RTUmB8ZG12e8AE1AibC3C8Ql7O5bmx6U+L7tU4KlfIIVECxEl8nTarlo5+Vyd0FpHaqZu4BDLrBbURmk3eW2yQvDXRBzIqKsX++GQudZ2myZr1v9j07vGGszM8n905Tw+wQGJ+tLg8ksTq+fF2Md0bb0uD3+kyryXTfxXz+6hQ9OIhiGgjt71+K50AV57iATw1e20cJCcdddHaGbt/1mfCeMh75PV2cIcOGSxu9A83B/o75zdaSMMbJ3lZIKXIBNAOhk2xbzwvDi4/u300u8GuZtl9R5gJtKRKVRkTx9tzFRy4FHs/cnHrW4fjIq6ivX030FNhdlfSWPpekVVpVFEvARVE0CXV42JegaplfpmOUfQhOuvSx647tcFDtx2Ygh1wZOjaBC3fObYldLTEMQwNqHud1HPF5kfb8Qi+brC9cuGAAuiUjrXGy/xZjxI4VGc9bL0oHTbVRJOhL9kEuFz6cmSQ1T8EHviWTMc0zXcyBLS+SsAogNFFNgWTul0IVQqpsDC/gZes2bxzqiQGm2x/wqoiW0CkXPQrFy/dwLIQVKagqwC2qFXV8Y4b9ptcGvYaoUp3DgFj3SQu44ETs0D2WOJeQQaK4Pvl9Ebhu2zypjsFYMzXNphoHpLmUTHHZCeKTX3lRCRPvM3JPxNtqgbizSVahpA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR07MB9830.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(52536014)(83380400001)(122000001)(38100700002)(33656002)(2906002)(86362001)(38070700005)(786003)(44832011)(8936002)(5660300002)(41300700001)(4326008)(186003)(66446008)(55016003)(75432002)(41320700001)(9686003)(8676002)(6506007)(316002)(76116006)(64756008)(66556008)(66476007)(54906003)(66946007)(478600001)(7696005)(110136005)(71200400001)(966005)(45080400002)(91956017)(5930299009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGMyeldGdnJKeXZ2WnhPMjRSTmVtaUNoOC8xZUdOaUVaSUZmdUQwbHVuMDdp?=
 =?utf-8?B?eTUxQ0U2T1Y0UnBhd3dvUnY2dVhGNlY2NGNTSThNdzFQZUxEcFJ2azJiRUpG?=
 =?utf-8?B?T0syRVV1SDJwZ3lhTFljaWRiWVN5WlNkS1g2NFpaV1RZQ1lFTFhuNW1CemxK?=
 =?utf-8?B?SnJ2ZFFUSEFLZUFpZjl0Qlhza2pSQXZXUFZwMHkwbjMzU000K0xVTGtzdFlR?=
 =?utf-8?B?UTBzNmhnbElUc1Vud0I3dHZvYkt1Mlp2R0luMHM3UXZLS21qYTRuNytzcFhC?=
 =?utf-8?B?aXhvM2E0MmczMUlBeDZQYzRESzVoTEQvTldjMGNGcFg5M25tUW5mMVJoUnNS?=
 =?utf-8?B?TXlrUGY3Q3NQUzZ3dVhER1VlOXJTR2ZOTlRtWGozV0lPVWxzYVBFTGFJVXJq?=
 =?utf-8?B?R0RlaEJFRjdlSDBZeEJSdEtoTmxsaUwyZXF3SERHQkpiRzNPTDh2UlVrRjlX?=
 =?utf-8?B?NVJXbFIyU1ZVdlJ3MkFDc2ZIWHcyblZhSUgzV3pBckliRkxaM29ENHZDekpM?=
 =?utf-8?B?R0dUb29xK3ZGbDhqOXdrTms3QnRrVm81Uncyc0c4N3RMUTBpNVRvR1Y1T3p5?=
 =?utf-8?B?MGxXL1lVcVJwTGlkMHdyejFvZjFDbEdyM2FzNExOeVhFOUc1SjBLTEV3SmNp?=
 =?utf-8?B?VU5mVVR3RGFTaC9rVG03bzdoYmFuT0xPZmcrZGJodEN5RHQvOTZOSWZkSUFw?=
 =?utf-8?B?ejBMdlBpbXorZ0t5N0hCSC9xc01JQWs4UUlqcTJrdW5ISVpsK2hPb1N5S2gv?=
 =?utf-8?B?M1llbUlJVmZwOVVOOFErbmRBUTVZMEJ0a2VlLzg3M2pxdVBDWUhxTUZMeGJk?=
 =?utf-8?B?MFdNalRHSGYxTW9ncXFrUzBkNEsvVHF4cWlNamNyV25pL1I4R01obURoaGEw?=
 =?utf-8?B?KytVWXhSbzRuMkNCdWk3UkJ2Z09peU55UUErbUxSRjFOazRjMGkwWlZrZnZr?=
 =?utf-8?B?dmlPQU5RQ2pHcjhleUtIdlF5NFR4WURxUndJT1JJTzhlUkVaWXdDWE5JbllP?=
 =?utf-8?B?SUFIV3FxdTR5OU9nV2ZMTlFQSVFVaUlkWGRGaTY2OEExbkx3RkwzZ3VDUDJl?=
 =?utf-8?B?dnQzY3BIaUszR0VORFJuZldzUzFmdkxpV1hCMElaU2xuT2E2RmFieFJjZkUy?=
 =?utf-8?B?ajdmcmdzcW5ZVGpCMERhSVNQVEx2ck5pWGNlY01wWTlyNW02dmx4SlhoYUpr?=
 =?utf-8?B?UHNReUNtWm9iblZWMEJhc0lScG9yRnltaWNaTWxaZ21DdWJmNFN3NW1jNmxF?=
 =?utf-8?B?ZEx6VzNEVkh1Tzh4L0FIL2FZL2hNNVhPSHIrUStFbHVKaGNlei9XUFEvRVpK?=
 =?utf-8?B?L3F6WEo5dWdCSUN3THlJOWlUNWZSWU42NmRDb1p2aXdldFAzcHF0WkJwQ0dS?=
 =?utf-8?B?bWloSm1zZmcvRlphdW9HSm5kdDEvbERvbUtVbXk0YzNHRUh3eldqZ2ovaWph?=
 =?utf-8?B?Q0pBYThsQ3pZSUo1bGt2OWtHVWVMeGdrTXlpeWdlWFduc3dBbUkrdVdXOTRO?=
 =?utf-8?B?SnJxT3hYY3FIbkxDdnY3cStkOVF4V1NJNnpFSW03RE40UjRFK2I2dkwzVjdC?=
 =?utf-8?B?QzFEUENwMFJBNFpqWnBhanNhcWQ5ZmgzVU1XQU8wNUg0cDZpcC9BOEtPYUlT?=
 =?utf-8?B?dHl3V2FlcWRwREFHNE14R3pYQTJOVzk3VitBNFpxdzJEZlovMGpaaVBSUGg5?=
 =?utf-8?B?STFTZWZKV3V1NkZEeFdtdzFYTG5waGNyTUVlREZWdDNSMC96Vm1vYXpnMGFM?=
 =?utf-8?B?ZDB6dHBVTGxNVCtBZlF4Y1VMSXFmQ1oySXk5d2RVeGFzWVZsWC9IVGI0Q29a?=
 =?utf-8?B?enZWUWExMTlmZDlPK3ZObkVDRDhLZWs1U0tGMlIzajFEY0FqdzJNdjJyVFZs?=
 =?utf-8?B?dHMwNXBRUTZOTjVKWENtWWpka1VhcDdmVDBpNXFxdENUalUySEJJbWNNQWZq?=
 =?utf-8?B?Skdsb2FDa2dBNHVlWW1nQk1LRlRwUjFuLzRKc2JaRVhJRnZKZ1Z4NXBsNVZP?=
 =?utf-8?B?S2hIaEFEdlFuMW1mNzc2K0tON1BWSk5jSGNQZEkxL0d4eVZnREdReDNxUW1K?=
 =?utf-8?B?Q3RRWjJzbjRIKzZweTd2Y2VqbTRuSmMvS0FwSWxhRVl4YXhKdXhUVEVESUp5?=
 =?utf-8?B?K0lwWjF2Q3A2azhFQ3pjMk85Zy9PbTE3TjllRE1iZTFycHAwMjVOS2ZYTVdC?=
 =?utf-8?B?UUl0M2JTUllBZHdoVDVkY3BWblgvS2w0djF0ZkJ5SDhXSlJRSlBWck5JRjlI?=
 =?utf-8?B?bUNyN0FiTnNWalFxZ0Y2VTJSNit3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR07MB9830.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c693ce4-57d0-4717-920b-08dafe2729ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 16:22:18.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1tSNsN0XgmtCXjdUCfJ8/7yy8lOPI8yeFgxxDTIqVamepWvidECOlFYcFMyiH7M+mYXKgYT4n6uLuCghp94DNv+ss2kkwwWdW68yVxbtGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4470
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R29vZCBkYXksIGRlYXIgbWFpbnRhaW5lcnMsCgpXZSBmb3VuZCBhIGJ1ZyB1c2luZyBhIG1vZGlm
aWVkIGtlcm5lbCBjb25maWd1cmF0aW9uIGZpbGUgdXNlZCBieSBzeXpib3QuCgpXZSBlbmhhbmNl
ZCB0aGUgY292ZXJhZ2Ugb2YgdGhlIGNvbmZpZ3VyYXRpb24gZmlsZSB1c2luZyBvdXIgdG9vbCwg
a2xvY2FsaXplci4gCgpLZXJuZWwgQnJhbmNoOsKgNi4yLjAtcmM0LW5leHQtMjAyMzAxMTYKS2Vy
bmVsIGNvbmZpZzrCoGh0dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMWFEdzdfSVhFenI1
YXZxdHAtZmI2bUcxOTluN2drdnktL3ZpZXc/dXNwPXNoYXJpbmcKUmVwcm9kdWNlcjrCoGh0dHBz
Oi8vZHJpdmUuZ29vZ2xlLmNvbS9maWxlL2QvMUpUUEY4TTExMUFrZVBmX0hjZThkbWtBZGhqb1NS
TWMtL3ZpZXc/dXNwPXNoYXJpbmcKClRoYW5rIHlvdSEKCkJlc3QgcmVnYXJkcywKU2FuYW4gSGFz
YW5vdgoKY3VycmVudF9yZXE9MDAwMDAwMDAwMDAwMDAwMCAKY29tbWFuZF9zdGF0dXM9LTEKZmxv
cHB5MDogZmxvcHB5IHRpbWVvdXQgY2FsbGVkCm5vIGNvbnQgaW4gc2h1dGRvd24hCmZsb3BweTA6
IGZsb3BweV9zaHV0ZG93bjogdGltZW91dCBoYW5kbGVyIGRpZWQuIMKgCmdlbmVyYWwgcHJvdGVj
dGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzcyAweGRmZmZmYzAw
MDAwMDAwMDM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBLQVNBTgpLQVNBTjogbnVsbC1wdHItZGVy
ZWYgaW4gcmFuZ2UgWzB4MDAwMDAwMDAwMDAwMDAxOC0weDAwMDAwMDAwMDAwMDAwMWZdCkNQVTog
MyBQSUQ6IDkwIENvbW06IGt3b3JrZXIvdTE2OjUgTm90IHRhaW50ZWQgNi4yLjAtcmM0LW5leHQt
MjAyMzAxMTYgIzEKSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJ
WCwgMTk5NiksIEJJT1MgMS4xNS4wLTEgMDQvMDEvMjAxNApXb3JrcXVldWU6IGZsb3BweSBmbG9w
cHlfd29ya193b3JrZm4KUklQOiAwMDEwOmZsb3BweV9yZWFkeSsweGJjMi8weDE0MDAKQ29kZTog
OGUgZTggMTIgNWEgZjYgZmMgZjAgODAgOGIgMjAgOWUgNDUgOGUgMTAgNDggOGIgMWQgNjMgNTEg
NmYgMDkgNDggYjggMDAgMDAgMDAgMDAgMDAgZmMgZmYgZGYgNDggOGQgN2IgMTggNDggODkgZmEg
NDggYzEgZWEgMDMgPDgwPiAzYyAwMiAwMCAwZiA4NSA5ZSAwNyAwMCAwMCAzMSBmZiBmZiA1MyAx
OCA0OCA4YiAxZCAzOCA1MSA2ZiAwOQpSU1A6IDAwMTg6ZmZmZmM5MDAwMDc2N2NhMCBFRkxBR1M6
IDAwMDEwMjE2ClJBWDogZGZmZmZjMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNY
OiBmZmZmZmZmZjg0ZDYyYWNlClJEWDogMDAwMDAwMDAwMDAwMDAwMyBSU0k6IDAwMDAwMDAwMDAw
MDAwMDggUkRJOiAwMDAwMDAwMDAwMDAwMDE4ClJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAw
MDAwMDAwMDAwMDAwMDEgUjA5OiBmZmZmZmZmZjhlNDU5ZTI3ClIxMDogZmZmZmZiZmZmMWM4YjNj
NCBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiBmZmZmZmZmZjhlNDU5ZTIwClIxMzogMDAwMDAw
MDAwMDAwMDAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwCkZT
OiDCoDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODExYTE4MDAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwCkNTOiDCoDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAw
MDAwMDgwMDUwMDMzCkNSMjogMDAwMDdmZmM5MTlmMTk0MCBDUjM6IDAwMDAwMDAxMTQ4YWYwMDAg
Q1I0OiAwMDAwMDAwMDAwMzUwZWUwCkNhbGwgVHJhY2U6CsKgPFRBU0s+CsKgc2Vla19pbnRlcnJ1
cHQrMHgyOGEvMHgyZTAKwqBwcm9jZXNzX29uZV93b3JrKzB4OWJhLzB4MTc2MArCoHdvcmtlcl90
aHJlYWQrMHg2NjkvMHgxMDkwCsKga3RocmVhZCsweDJlOC8weDNhMArCoHJldF9mcm9tX2Zvcmsr
MHgxZi8weDMwCsKgPC9UQVNLPgpNb2R1bGVzIGxpbmtlZCBpbjoKLS0tWyBlbmQgdHJhY2UgMDAw
MDAwMDAwMDAwMDAwMCBdLS0tClJJUDogMDAxMDpmbG9wcHlfcmVhZHkrMHhiYzIvMHgxNDAwCkNv
ZGU6IDhlIGU4IDEyIDVhIGY2IGZjIGYwIDgwIDhiIDIwIDllIDQ1IDhlIDEwIDQ4IDhiIDFkIDYz
IDUxIDZmIDA5IDQ4IGI4IDAwIDAwIDAwIDAwIDAwIGZjIGZmIGRmIDQ4IDhkIDdiIDE4IDQ4IDg5
IGZhIDQ4IGMxIGVhIDAzIDw4MD4gM2MgMDIgMDAgMGYgODUgOWUgMDcgMDAgMDAgMzEgZmYgZmYg
NTMgMTggNDggOGIgMWQgMzggNTEgNmYgMDkKUlNQOiAwMDE4OmZmZmZjOTAwMDA3NjdjYTAgRUZM
QUdTOiAwMDAxMDIxNgpSQVg6IGRmZmZmYzAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAw
IFJDWDogZmZmZmZmZmY4NGQ2MmFjZQpSRFg6IDAwMDAwMDAwMDAwMDAwMDMgUlNJOiAwMDAwMDAw
MDAwMDAwMDA4IFJESTogMDAwMDAwMDAwMDAwMDAxOApSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4
OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogZmZmZmZmZmY4ZTQ1OWUyNwpSMTA6IGZmZmZmYmZmZjFj
OGIzYzQgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjogZmZmZmZmZmY4ZTQ1OWUyMApSMTM6IDAw
MDAwMDAwMDAwMDAwMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAw
MApGUzogwqAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODgxMWExODAwMDAoMDAwMCkg
a25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzogwqAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDog
MDAwMDAwMDA4MDA1MDAzMwpDUjI6IDAwMDA3ZmZjOTE5ZjE5NDAgQ1IzOiAwMDAwMDAwMTE0OGFm
MDAwIENSNDogMDAwMDAwMDAwMDM1MGVlMAotLS0tLS0tLS0tLS0tLS0tCkNvZGUgZGlzYXNzZW1i
bHkgKGJlc3QgZ3Vlc3MpOgrCoCDCoDA64oCCOGUgZTggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDi
gILigILigIJtb3YgwqAgwqAlZWF4LCVncwrCoCDCoDI64oCCMTIgNWEgZjYgwqAgwqAgwqAgwqAg
wqAgwqAg4oCC4oCC4oCCYWRjIMKgIMKgLTB4YSglcmR4KSwlYmwKwqAgwqA1OuKAgmZjIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIOKAguKAguKAgmNsZArCoCDCoDY64oCCZjAgODAgOGIgMjAg
OWUgNDUgOGUg4oCC4oCC4oCCbG9jayBvcmIgJDB4MTAsLTB4NzFiYTYxZTAoJXJieCkKwqAgwqBk
OuKAgjEwCsKgIMKgZTrigII0OCA4YiAxZCA2MyA1MSA2ZiAwOSDigILigILigIJtb3YgwqAgwqAw
eDk2ZjUxNjMoJXJpcCksJXJieCDCoCDCoCDCoCDCoCMgMHg5NmY1MTc4CsKgIDE1OuKAgjQ4IGI4
IDAwIDAwIDAwIDAwIDAwIOKAguKAguKAgm1vdmFicyAkMHhkZmZmZmMwMDAwMDAwMDAwLCVyYXgK
wqAgMWM64oCCZmMgZmYgZGYKwqAgMWY64oCCNDggOGQgN2IgMTggwqAgwqAgwqAgwqAgwqDigILi
gILigIJsZWEgwqAgwqAweDE4KCVyYngpLCVyZGkKwqAgMjM64oCCNDggODkgZmEgwqAgwqAgwqAg
wqAgwqAgwqAg4oCC4oCC4oCCbW92IMKgIMKgJXJkaSwlcmR4CsKgIDI2OuKAgjQ4IGMxIGVhIDAz
IMKgIMKgIMKgIMKgIMKg4oCC4oCC4oCCc2hyIMKgIMKgJDB4MywlcmR4CiogMmE64oCCODAgM2Mg
MDIgMDAgwqAgwqAgwqAgwqAgwqDigILigILigIJjbXBiIMKgICQweDAsKCVyZHgsJXJheCwxKSA8
LS0gdHJhcHBpbmcgaW5zdHJ1Y3Rpb24KwqAgMmU64oCCMGYgODUgOWUgMDcgMDAgMDAgwqAgwqDi
gILigILigIJqbmUgwqAgwqAweDdkMgrCoCAzNDrigIIzMSBmZiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoOKAguKAguKAgnhvciDCoCDCoCVlZGksJWVkaQrCoCAzNjrigIJmZiA1MyAxOCDCoCDCoCDC
oCDCoCDCoCDCoCDigILigILigIJjYWxsIMKgICoweDE4KCVyYngpCsKgIDM5OuKAgjQ4IDhiIDFk
IDM4IDUxIDZmIDA5IOKAguKAguKAgm1vdiDCoCDCoDB4OTZmNTEzOCglcmlwKSwlcmJ4IMKgIMKg
IMKgIMKgIyAweDk2ZjUxNzgKCg==
