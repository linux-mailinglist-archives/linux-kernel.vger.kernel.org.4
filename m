Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97066A7E7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjANBGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjANBGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:06:12 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA61007D;
        Fri, 13 Jan 2023 17:06:11 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DMKtSc023458;
        Fri, 13 Jan 2023 17:06:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fgIIyfhB+C87exM636Y0OBNawGVIUyLDImcn+myqtz4=;
 b=Zn5bocPLeIS5DQ/4N7q30+cfWqGtaRVTLC2EZ2skvnvGdBVUOfg2KmRJPtd/sDizeJRS
 a+DY9rx04ra9AFfbq5p/Gkxt4tTN4LmDVOURioj0DpCQ/O1BfyyLZaXvAKlZw6YuxkXu
 9rcYmItGLo8IQ/5uXjmPxAII5UopzS7ynC+kj47KjFnML9Jpc2xWd2lteSzy+kltJxRM
 hH/n2EnvTCGX+eR520hedpml/kKFaBBx3fdXoRjeGU5MoA4iyHVuVshMVLJS7REhH6IV
 fHHHlDXfU+ME0nzZ23cbaNxvP9R4qbcpxqjLiZN7VgFXRmSNvRZLTLPQ2fmFU14a+y08 nA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n3946u8c8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 17:06:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNX1GKwTykYJZkNYnQ0ijldnKyauw+E9ofWWVLs/1vzB8rpc7pV5O2Cod8zErEBK0HXkpSQtrTdy8rDhTpuVUFXMeBctdCzmdPJbJw2ovv/CsJvIoQYK6wUm+2M69zu5MgkbdZQQAKJrSvhoGjS7fveMaL/RQBkxcYt+TxhlU0/sluOIid5J3Z44GT7o7AIoC4vMz8qOHKwfG10BLDJ346d+b1qkB18CHIJkSmVhzM+lu7Q+BwnzNCFOkpPab0TxPJu6A9MTv50xoGTYT2Yi6HZ8padK2bq9xfPXRiXjcDWQmZqyxCHvZCC/NPZgWIsUSlagsLns7XIrCzMa06phPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIDcFHfDi3qaid8KorSqcn4szKpsSbSq2tDkWDUI1q8=;
 b=IT+Lws4z9y57zIBhgXmOT5EY1DVeD3eUEkG6Hu6wIuRQ5B9YXCI6bWU8pOShQmSnkqQi6IAksCZAsW8KWnnNEiN/+d/jtSS+SZ7g+cPNpDIyHzgJR1KAtJuYD3X89uqzqsbE+i2xoDg6Yu3OM10Xm3BhusPYAYPCBMu4YF+eJHQZksxDqgq12mqaK3PULy/edcnUsk/w13vH+fJbE16wKRz/jipPyGRQQq4oH5N8Y2dwczVZ7d5k6Tt8Bj92Gm0I2yFyk7/F0nFiM1jCJ+HWaecXw29fk53MVIPg4iswnlp2QSIkCM+9w4Iq75Io8WuQCkjTMcPhYDIzUgueaFlNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by PH7PR15MB5473.namprd15.prod.outlook.com (2603:10b6:510:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sat, 14 Jan
 2023 01:06:07 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::9136:21da:ed88:da96%7]) with mapi id 15.20.6002.013; Sat, 14 Jan 2023
 01:06:07 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Nick Terrell <terrelln@meta.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Thread-Topic: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Thread-Index: AQHZIIJwjTa/eWW290+GMXB1zq6Ba66YUFaAgATSaICAAAT0gA==
Date:   Sat, 14 Jan 2023 01:06:07 +0000
Message-ID: <C3D7D026-AA51-45E3-B871-74D411D3F275@fb.com>
References: <20230104212048.gonna.331-kees@kernel.org>
 <93130521-AF03-4941-8FF1-C97C76027A02@fb.com>
 <202301131643.6D23A4AEA1@keescook>
In-Reply-To: <202301131643.6D23A4AEA1@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|PH7PR15MB5473:EE_
x-ms-office365-filtering-correlation-id: 73dfc22c-ee04-47a7-4f34-08daf5cb8482
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PwGBKROUOtX99oUpYeFhzKG8NiGj05mZYpAPLsWOdWh+yMSLvfKWQE3QhsLyPC+sa5iWzOf1FeEd3zl1MxY/VjcRsZA+nKXTJElhkEGPc4Q1bheSrD6Sgpt1llPU4DeRJV+X48FzOslUyOYpRS8jklOCRBOrIrkr6vifAO9iGs22Ef4WHv7e+2NP/yxyOuLCAm4KfhsnbtJ0uHAjcMvF7uLO9AsaU9RaeWIHC8Eo3uLqd0KdtK0+bnpfTwWLfsVc+K+oaFsILYqLuF2fGKNNHp0TdA0IZyTnCAoaKvuFIpuQiIKeOI3FLyJ2buYeQb9/011ZNBbaugVhPRn//ymDyZuD8lBxMVL+2oNT5YrZ6acw6bLYCq54qAfjkbJ0PRJkeuFiGqhGUkE1y6A+SI7P7m/aLXL3tbXcyL63joEJU2vfMojUp//YkN6ao6XmYBZ4QGo6ZFVVJubs4JK0UXpm9v48tHvW1nZ1UdOOTXBYDv2/YMOaLi5KDQdISUlbXGV8yMUGHqMhynego0tI+TzuMYVDoNCmxhiaiQrz3/cgnJhyDi2I1oiIiUU4ioVfUai5El4pjnA30UY4oyNgsrE9HWRMVl6sSHdUuJBG9Ua8nf7hDfibm/OW282rN2Iukpbx2p4MEyHuIq3olee+B0ukd7XwJBYnIC+slRvcy8YLjWWK5N2ticR52GnwAH70tpQA5RUDB0aJCchqhtglxYKBoz+o08whRPfFQ61SHOHyHAI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(36756003)(6506007)(86362001)(41300700001)(53546011)(122000001)(8676002)(478600001)(6486002)(38070700005)(966005)(5660300002)(6512007)(9686003)(8936002)(38100700002)(186003)(66946007)(66446008)(33656002)(6916009)(76116006)(71200400001)(83380400001)(4326008)(2906002)(66556008)(66476007)(64756008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVBiSGdCWGJLWlJ3WkV2b3VHSytBcnlueDV0ZU8rUk9pM2NmTWoxODk2NzBn?=
 =?utf-8?B?SzlqMCtsT2RsOElsTy9PUG5IbDhNUFRZSjlXeGtnVUM5enJyUWhOd0FPRExR?=
 =?utf-8?B?Qk1ndFM1RktsdHByREVVUE5XbWJUOUxhb3JScnR1U0JsNmM5OGg3ZVBOZCs1?=
 =?utf-8?B?b3NncmdKdHU1cDQ5bWxReUE1aUFjRXNMei93emdvVWZpMDBCRU0rYlh0cmN3?=
 =?utf-8?B?ZjZRYUdRWWRRTFpJa2FlalliYkNWeXZCMUdudVFTdHZZdVMxUnprYUFBUHBI?=
 =?utf-8?B?RTBydEFjZ0pRN0ovU3JWTlZ1TmJkYzJySlJtMC9uUlI1eFRRZzQrUWlPcjd3?=
 =?utf-8?B?dm5URGVNK1FyVGJDL1BlN1QyK0ZvM3FqSlhTak5yZ3BXZTEwSUlaUThvN0k4?=
 =?utf-8?B?MTJVamdqUG85S3lmQU05d2JObDBmZVFGQ2ExeWI1WmplVFoyNTQyL2tjWGgx?=
 =?utf-8?B?NHJSN3MvZ3JXNjg4SkdKVDVRTjQvREFUSG94UVlSQUpyK1ZrZVV0M3VOS2pa?=
 =?utf-8?B?MUJYa2h2ZDgybU1Rcjg3d2QzSVlqY2F4OEFzd2Y0Mkc3enRFQW9VYjZXUVRz?=
 =?utf-8?B?Ky9pY2Jwd2hmVWNLbCt3WmVEbEZpemVIbHlLSG95ZU9WRDJJZmgzbndoV2FS?=
 =?utf-8?B?TjJweFhZeHJOTFRCY0NtVDZVVUphVCttTVcybTRIODloN1BQYlRJODhzdElL?=
 =?utf-8?B?aHI2YjZBWm4zNG12UUs4QWVpV2ZKdEl0SDNTUDN3cityTmJXS3pyVGo2cGk4?=
 =?utf-8?B?cGN5TnNVWUdKcmp6NmQ1eG9YZ3lya1RsUUNjSzVLaFRobWJZS3NMZklNSStx?=
 =?utf-8?B?QmtvbEpaNDVCbUsyRWNsaUVyRno4V3oxNlhwTWN2cjlFaDJOQjc1aTAyRkpK?=
 =?utf-8?B?YkFZYW04UjRON283bnJFV1pmTDU2UnhyVlVkSmJwREczNUVMLzQxWld3UkJk?=
 =?utf-8?B?VGJBM0EvL1I1b0trSHFRaWFoUXk0dzFFcEJXOUN3amxYbzFaTVdvVEs2aUFl?=
 =?utf-8?B?dmdVQjBvcGxPN2RHSEExRGxucklwREFQMzByblozWFlxbUsySExJcG10eW1h?=
 =?utf-8?B?OUFZbXlUZEQza2xsQlBFWWJSM2gvQVhNZkxnVnExdm5DZ2srZHI2ZmF3T29x?=
 =?utf-8?B?YmNlOE1VbS9aRVJvdjVmdFhralV1SHcrVVdoOGZ5Z0IzMVhkTU1EQ0gwbHYz?=
 =?utf-8?B?NVpDbzdWS1VmTnRLb3ZqTEsvOUVpbTY4NVFEaDV1ZHNNczU4ZXFKNitCQjRm?=
 =?utf-8?B?T3Y4NUxaZGlEVGtzODQvWElTRUVlMlVhdDdKYmIyVWFGakJQRCtrYlJKOTBl?=
 =?utf-8?B?T1c4S212aFJoOVkrR1IrNWdPMnVYRXlCU3dIZE5sbmJadXlqY21EOXZnTWox?=
 =?utf-8?B?U2FuTkpaTUFOdzJkNGx1bUxkODgyVnlsNk92ckJhLys5anpla2JqdzNkM0c4?=
 =?utf-8?B?cEpqK25MUnVJSmpCWitjYVIxL0tnSlJaOENvcHJYb0g5MUpLWmY4TEp2dTJU?=
 =?utf-8?B?eDduNURJdFZNODhUbEZwZUhKbDNCU2Fja2JERXQwWCtxREtLUFJyTzJGSVU1?=
 =?utf-8?B?K00rZ05jSGc3c0VxZTJVd1h1Yis2V21QMXkySitCQi9xYzNSNkRhR0tTQUw3?=
 =?utf-8?B?OUxZTlpiUVBkd3EwbWJOaEpMRmk0S1FGN0NFQmExeW9TMk5KQkdlNnZUNE5q?=
 =?utf-8?B?U2ZzZCsra1o4Y3N2aWF5V1RneW0vVkRvNGUrVWt2dnNxZUF4R2NsMmhvS2h5?=
 =?utf-8?B?MWR2R1dJYUkyMDJaOURZcHM0K1pzRjFaRTFsaG5TRU9naVE2aitaK2Q1YlZi?=
 =?utf-8?B?VEttSXYwQTM3eFQzNXNmK2d5ZzB2Z01DS0oxQ2FIOW1FRUg0aGhlVjkwMFpa?=
 =?utf-8?B?OE1jekEzTjY5TDRnUnJiZW9oWkJTV3k3Vnc3eDFJSmsrL2Q3YXRTMGhQODUw?=
 =?utf-8?B?WTN3MG84ZnNJdEdQcStGTFQ3b2lsWTlSMGJDd2hNeVZveW1LMHM4UXZFOFJm?=
 =?utf-8?B?VFUzbHcwdlRkbkphZTY1ckRkZXh0a2ZEa0ZwMENXUjJnVnV0SlN0SlNUWGVM?=
 =?utf-8?B?THlWdi9XOElDVUdSZzFXeWdkUW9hNG9PckZmcEFpbVcwVFdyQVJIZTI4bGN5?=
 =?utf-8?B?YmVqR0MrUjdvdlUxR1FZRWpKN3JSWmdmWi9ZYWtPaXY0RWNYV0NrNFdqQVNy?=
 =?utf-8?Q?tlxVtCk05ZGjTZmFlVY7VNI=3D?=
Content-ID: <4300ECCF43A2E14E9B5FCED4BC465222@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dfc22c-ee04-47a7-4f34-08daf5cb8482
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2023 01:06:07.6020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JMoeeiE+k4BQJ/lTPqB4IEt//u+ND932yBps9fs01E50Xqih9ReqFZ/RCwfuOndMR+mBX1ukhAubr2f5uv2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5473
X-Proofpoint-GUID: VhLx1GWU7VESk4elnMgeKq8whkTWIqtz
X-Proofpoint-ORIG-GUID: VhLx1GWU7VESk4elnMgeKq8whkTWIqtz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_12,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSmFuIDEzLCAyMDIzLCBhdCA0OjQ4IFBNLCBLZWVzIENvb2sgPGtlZXNjb29rQGNo
cm9taXVtLm9yZz4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIFRoaXMgTWVzc2FnZSBJ
cyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBU
dWUsIEphbiAxMCwgMjAyMyBhdCAxMToxMDowOFBNICswMDAwLCBOaWNrIFRlcnJlbGwgd3JvdGU6
DQo+PiANCj4+IA0KPj4+IE9uIEphbiA0LCAyMDIzLCBhdCAxOjIwIFBNLCBLZWVzIENvb2sgPGtl
ZXNjb29rQGNocm9taXVtLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gIS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+Pj4g
VGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQo+Pj4gDQo+Pj4gfC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0hDQo+Pj4gDQo+Pj4gRml4IHRoZSBmb2xsb3dpbmcgLVdzdHJpbmdvcC1vdmVyZmxvdyB3
YXJuaW5nIHdoZW4gYnVpbGRpbmcgd2l0aCBHQ0MgMTErOg0KPj4+IA0KPj4+IGxpYi96c3RkL2Rl
Y29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYzogSW4gZnVuY3Rpb24g4oCYSFVGX3JlYWREVGFibGVY
Ml93a3Nw4oCZOg0KPj4+IGxpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYzo3MDA6
NTogd2FybmluZzog4oCYSFVGX2ZpbGxEVGFibGVYMi5jb25zdHByb3DigJkgYWNjZXNzaW5nIDYy
NCBieXRlcyBpbiBhIHJlZ2lvbiBvZiBzaXplIDUyIFstV3N0cmluZ29wLW92ZXJmbG93PV0NCj4+
PiA3MDAgfCAgICAgSFVGX2ZpbGxEVGFibGVYMihkdCwgbWF4VGFibGVMb2csDQo+Pj4gICAgIHwg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4+IDcwMSB8ICAgICAgICAg
ICAgICAgICAgICB3a3NwLT5zb3J0ZWRTeW1ib2wsIHNpemVPZlNvcnQsDQo+Pj4gICAgIHwgICAg
ICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4+PiA3MDIg
fCAgICAgICAgICAgICAgICAgICAgd2tzcC0+cmFua1N0YXJ0MCwgd2tzcC0+cmFua1ZhbCwgbWF4
VywNCj4+PiAgICAgfCAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4+PiA3MDMgfCAgICAgICAgICAgICAgICAgICAgdGFibGVMb2crMSwN
Cj4+PiAgICAgfCAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn4NCj4+PiA3MDQgfCAgICAg
ICAgICAgICAgICAgICAgd2tzcC0+Y2FsbGVlV2tzcCwgc2l6ZW9mKHdrc3AtPmNhbGxlZVdrc3Ap
IC8gc2l6ZW9mKFUzMikpOw0KPj4+ICAgICB8DQo+Pj4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+Pj4gbGliL3pzdGQvZGVjb21wcmVz
cy9odWZfZGVjb21wcmVzcy5jOjcwMDo1OiBub3RlOiByZWZlcmVuY2luZyBhcmd1bWVudCA2IG9m
IHR5cGUg4oCYVTMyICgqKVsxM13igJkge2FrYSDigJh1bnNpZ25lZCBpbnQgKCopWzEzXeKAmX0N
Cj4+PiBsaWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmM6NTcxOjEzOiBub3RlOiBp
biBhIGNhbGwgdG8gZnVuY3Rpb24g4oCYSFVGX2ZpbGxEVGFibGVYMi5jb25zdHByb3DigJkNCj4+
PiA1NzEgfCBzdGF0aWMgdm9pZCBIVUZfZmlsbERUYWJsZVgyKEhVRl9ERWx0WDIqIERUYWJsZSwg
Y29uc3QgVTMyIHRhcmdldExvZywNCj4+PiAgICAgfCAgICAgICAgICAgICBefn5+fn5+fn5+fn5+
fn5+DQo+Pj4gDQo+Pj4gYnkgdXNpbmcgcG9pbnRlciBub3RhdGlvbiBpbnN0ZWFkIG9mIGFycmF5
IG5vdGF0aW9uLg0KPj4+IA0KPj4+IFRoaXMgaXMgb25lIG9mIHRoZSBsYXN0IHJlbWFpbmluZyB3
YXJuaW5ncyB0byBiZSBmaXhlZCBiZWZvcmUgZ2xvYmFsbHkNCj4+PiBlbmFibGluZyAtV3N0cmlu
Z29wLW92ZXJmbG93Lg0KPj4gDQo+PiBUaGUgcGF0Y2ggbG9va3MgY29ycmVjdCB0byBtZSwgdGhh
bmtzIGZvciByZXZpdmluZyBpdC4gQnV0LCBJIHdhcyBhdHRlbXB0aW5nIHRvIHJlcHJvZHVjZSB0
aGUgaXNzdWUsDQo+PiBzbyBJIGNvdWxkIGJldHRlciB1bmRlcnN0YW5kIHdoYXQncyBnb2luZyBv
biwgYW5kIEkgd2Fzbid0IGFibGUgdG8gcmVwcm9kdWNlIGl0IG15c2VsZi4NCj4+IA0KPj4gVG8g
YXR0ZW1wdCB0byByZXByb2R1Y2UsIEkgYXBwbGllZCB0aGlzIHBhdGNoDQo+PiANCj4+IC0tLQ0K
Pj4gZGlmZiAtLWdpdCBhL2xpYi96c3RkL01ha2VmaWxlIGIvbGliL3pzdGQvTWFrZWZpbGUNCj4+
IGluZGV4IDIwZjA4YzY0NGI3MS4uMTkwZDNkNWFiNGJlIDEwMDY0NA0KPj4gLS0tIGEvbGliL3pz
dGQvTWFrZWZpbGUNCj4+ICsrKyBiL2xpYi96c3RkL01ha2VmaWxlDQo+PiBAQCAtMTIsNiArMTIs
OCBAQCBvYmotJChDT05GSUdfWlNURF9DT01QUkVTUykgKz0genN0ZF9jb21wcmVzcy5vDQo+PiBv
YmotJChDT05GSUdfWlNURF9ERUNPTVBSRVNTKSArPSB6c3RkX2RlY29tcHJlc3Mubw0KPj4gb2Jq
LSQoQ09ORklHX1pTVERfQ09NTU9OKSArPSB6c3RkX2NvbW1vbi5vDQo+PiANCj4+ICtjY2ZsYWdz
LXkgOj0gLVdzdHJpbmdvcC1vdmVyZmxvdz00IC1XZXJyb3INCj4+ICsNCj4+IHpzdGRfY29tcHJl
c3MteSA6PSBcDQo+PiAgICAgICAgICAgICAgICB6c3RkX2NvbXByZXNzX21vZHVsZS5vIFwNCj4+
ICAgICAgICAgICAgICAgIGNvbXByZXNzL2ZzZV9jb21wcmVzcy5vIFwNCj4+IC0tLQ0KPj4gDQo+
PiBUaGVuIGNvbXBpbGVkIG9uIHg4Ni02NCB3aXRoIGdjYyAxMi4yLjAgb24gdGFnIHY2LjItcmMz
LiBJIHNhdyBubyBlcnJvcnMuDQo+PiBJIGFsc28gdHJpZWQgd2l0aCBqdXN0IGAtV3N0cmluZ29w
LW92ZXJmbG93YCwgYW5kIG9uIHVwc3RyZWFtIHpzdGQuIEkgdHJpZWQgdG8NCj4+IG1ha2UgYSBt
aW5pbWFsIHJlcHJvZHVjZXIgb24gZ29kYm9sdCwgc28gSSBjb3VsZCBzZWUgaWYgaXQgd2FzIHRo
ZSBnY2MgdmVyc2lvbiwNCj4+IGJ1dCB3YXNuJ3QgYWJsZSB0byBtYWtlIGl0IGZhaWwgd2l0aCBh
bnkgb2YgdGhlbSBodHRwczovL2djYy5nb2Rib2x0Lm9yZy96L0V4enE5YXJNciAuDQo+PiANCj4+
IENvdWxkIHlvdSBwbGVhc2UgdGVsbCBtZSBob3cgdG8gcmVwcm9kdWNlIHRoaXMgd2FybmluZz8N
Cj4gDQo+IEkgc2F3IGl0IGxpa2Ugc28gd2l0aCBuZXh0LTIwMjMwMTEzIG9uIHg4Nl82NDoNCj4g
DQo+ICQgZ2NjIC0tdmVyc2lvbg0KPiBnY2MgKFVidW50dSAxMi4yLjAtM3VidW50dTEpIDEyLjIu
MA0KPiAuLi4NCj4gJCBtYWtlIEtDRkxBR1M9LVdzdHJpbmdvcC1vdmVyZmxvdyBhbGxtb2Rjb25m
aWcgbGliL3pzdGQvZGVjb21wcmVzcy9odWZfZGVjb21wcmVzcy5vDQoNClRoYW5rcywgSSB3YXMg
YWJsZSB0byByZXBybyBpdCEgSSB3aWxsIG1lcmdlIHRoaXMgcGF0Y2ggaW50byBteSB0cmVlLg0K
DQpJZiB5b3Ugd291bGQgbGlrZSB0byBzdWJtaXQgdGhlIHNhbWUgcGF0Y2ggdXBzdHJlYW0geW91
cnNlbGYsIEkgd2lsbCBhY2NlcHQgdGhlIFBSLCBvdGhlcndpc2UgSSBjYW4gc3VibWl0IGFuIHVw
c3RyZWFtIFBSLg0KDQpKdXN0IHRvIGJlIGNlcnRhaW4sIHRoaXMgcGF0Y2ggaXMgdG8gd29yayBh
cm91bmQgYSBzaG9ydGNvbWluZyBpbiAtV3N0cmluZ29wLW92ZXJmbG93LCBidXQgdGhlIGNvZGUg
d2FzIG90aGVyd2lzZSBjb3JyZWN0Pw0KDQpSZXZpZXdlZC1ieTogTmljayBUZXJyZWxsIDx0ZXJy
ZWxsbkBmYi5jb20gPG1haWx0bzp0ZXJyZWxsbkBmYi5jb20+Pg0KDQpCZXN0LA0KTmljayBUZXJy
ZWxsDQoNCj4gLS0gDQo+IEtlZXMgQ29vaw0KDQoNCg==
