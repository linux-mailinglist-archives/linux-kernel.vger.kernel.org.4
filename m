Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B76780EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjAWQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjAWQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:07:10 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686C298E2;
        Mon, 23 Jan 2023 08:07:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUxxYxopCCU3EP5KPL69NIhuj95a0bS28n17s5sGGz+fgWxmsLyhsrtW9jDbX4M7qPLTAZiu9jRvBMrIOkx655DkHtmgc6nqpZ2lFK5w2v8CUD1Of58GXV6SCKBhe2W19JFrfSCrh0cIi559r0Kellvi9JKtEx6FPAPxq+KFWHbG2evggNpuGFSwWomiNF2naU3/d8PWvRxI5cnBta9j/vJ4ldIwsfJRz6uknKkT2ZW5xJ5JThGsuYKkKx7Zc6cAz9glz/b67fmLdd5fsDj5JbJimeS5F+NagEO8c1vkZBW3DgQHiuEwbcILT3ngWICpjCG2AM3ZmF+CDzQNWC+Pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h56UxykM32HSe95EPqIlxqlMt6elAgkyBE6MCFzcBs=;
 b=d4MPmxOs5T9IKfZHOOx1HlE3yT/fhkbijATsycUAcTx7/4rpvpt7rw49Sl4ZBWSis9XQ3fAtot3HzykDLJhAzVzrmJH5m1m6tGg/73JmRT0qaZE7BZ6d7ufE6dqJvec1qdAPCGjWNaSgD+5QBChWAEqkNIiGSts89Q+A5WMXNQ75Qj1Rpv3dcXn8aUEBhUUfOAxLOhf50ODi+Qxzdz3HdkmZECk7N9bckl2RqoDaSrculbY5Z06pQ0dhoF4ZsuzdBx2yaQAuMdVtkdijVoSM7wmHjnK9BNiXvee/rlbXThcxbfzUN1NuOeAlWyOuXiLfHOgiBn7QDWLRWYc7PUG1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h56UxykM32HSe95EPqIlxqlMt6elAgkyBE6MCFzcBs=;
 b=N38r20ZHAVqLwI1VKWue1eog3m319bLRpIcxSgsX8qMulHgtAsQz5kvsb8N6H8oXLhBxGjZeq0MY6+GbVdLjrfNpM5YE8E2wfkf/Y6RUgYwEBPG983+M+fowc+wZ3pQU+kOml0UM1OYWkVjSGDTiz9mnUFfHkI/bBpHLaO8GOvQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 16:07:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:07:00 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Raul Rangel <rrangel@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Hasemeyer <markhas@chromium.org>
Subject: RE: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
Thread-Topic: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
Thread-Index: AQHZLZ79XIQSJZDlw025ZYd0Y5VB1a6sHFKAgAAOiwCAAALZcA==
Date:   Mon, 23 Jan 2023 16:06:59 +0000
Message-ID: <MN0PR12MB61017872AB3769624CE2A49CE2C89@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com>
 <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
 <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
In-Reply-To: <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-23T16:06:58Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=dbb594a2-b83c-4393-b594-8b123d9b6ae0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-23T16:06:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5ff7d3b5-4cfa-4ac3-9174-63fcf88e8812
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA0PR12MB7508:EE_
x-ms-office365-filtering-correlation-id: c5b6b831-9b83-402e-ef46-08dafd5bdbfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMBhn//GIfxZvoreIZGvWMFU/QykqHnSsvuxdD0uSC6KzbJn0XCHRq9v1HycNnxFQ1K+sLMfSYELLeTDO0AykgbEbESPHWqa1bSjTC33lUCQhLhPvd7QcPbq71k3DaqdPmjL1toYIdCYClKi1MpZDprnpBAqG4cJYZ69BbwfnqODlIvVIWUiGPaBPWMBBUvDu0cakzUuvjWrfuW1BtEo9v8Ucmsgo2v8/oOLSgrdUW0sfhNXSupheGBL26zRBUs1sUQh1HAvqQAEb94BxPvxOD9ogyT84OFPRQUDP8v8VN4ZdsMDapDwWfJC0nzUX0HOpw2d6O36IsdotnVb9hzBkyYvEmwLVfBHvt6UVr4Ayv+K8dVo13cnCoFOYPc2NxVVaq8NKb/oHo82N7zjUw9FEFTdPXKdDi6jLtaQZ5aR88+da6XB7ucLPiKVQwRf3M17VqkI6zKBngU6kwN3DuDsknRm1V4FklUK0mZmLj12Cz6rhFYxMvmfJK7DcI8z04XEJ0UY9cx+IRqcyN2Gs6URmCg9S2cyZmWnmpDIKL/PpGOqQrWx4zgTf9PEz4TQlV2EYrSHiDcCg1uhLthNFKt7mcPx7ecupaV27tg7sxBEfZhSQhh91AO2wEyjPPMLYK5dAXVDTzIUy/2LPUsPp6yYrzuuuTEambLbU/rfdfeNNUpe8s/CB91mZCh2DSfo1rAgwP8OXdwqifJ/4AWHT3LU7ayPVid9SQta3m7AKl8zHq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(71200400001)(7696005)(76116006)(66556008)(8676002)(66946007)(4326008)(110136005)(66476007)(66446008)(64756008)(966005)(53546011)(186003)(41300700001)(83380400001)(26005)(8936002)(52536014)(7416002)(9686003)(5660300002)(2906002)(6506007)(38100700002)(33656002)(122000001)(38070700005)(316002)(478600001)(54906003)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUZnSDR3MFJ0eGVjaXBRNUFOa1pZUS9ybnVNTzhrY0UzYXVBMDVkVEovSU5n?=
 =?utf-8?B?TXNUL2dJY2Z5dzNvWjhPSlg2K1RIaGcvNkg5UHIzQUFPRDYrY3B3VUM0MThw?=
 =?utf-8?B?QWJQZEZ2RUhUUXZsZDRWTEpoTTdLZ3hMbXlPcTBmYkJhV2FQMW5oNUNyNTNx?=
 =?utf-8?B?L09qRnYyaDRZRVYxZDhlbVIzdWRheDJ1cUZQdUhPN3dTb3RyUmNrbjV2ZDdD?=
 =?utf-8?B?SmlINTdHTE13eVlJUVVhd29xbkVHV1lhOEZIY3MycGR0TkpaUFBhM0tBNGRs?=
 =?utf-8?B?UW5iNm4wY2tWMW12WDBmK0lNRmlHL0lpcXNacklCZTBLZmhDVm9rUkM3cXlU?=
 =?utf-8?B?SXdlSFFyMTc2ejdtTm5UWG9xaEpwUmZQdjVaRENCeTlPelRtbVhSdzMrWXlM?=
 =?utf-8?B?SWgzWEJsUHNQbHRoaVU5YlphTHllaHI2Z2p4REtoQ24zOWJ3WXdDRHhYTVBk?=
 =?utf-8?B?MTR3aU01M0JMTlh2U3lwQTJCZjl3cWkrd1dUYTdLdGppSUV6dkpWbWRFTDB6?=
 =?utf-8?B?T0NhMTZydlBJV0xqcVNPQVpHR3I5L2NwYXpJdzV5eXpBZU44WDVXeFJIUVg4?=
 =?utf-8?B?aXRxZmJxVGtVN0swa2Vnb2pLaldmdy9TUjArbTBaNmN3cjkwVk1KckFvaTRT?=
 =?utf-8?B?WEZrYzVHa3o0R205Z2lTVzVoQUlTWThER1B5YkxTV3NMd2JvWkszcUN0TWV6?=
 =?utf-8?B?cHFESExmMnNzTGxnWUpRK0RyK0M0b0ZvYVMwY1JFbHVKVFh6NVVlajRRQTJH?=
 =?utf-8?B?Sk5wbnRXZlgxNzY0V3g4UHVBbno4L0srQnR3QTRUanhDc0gzMEl0YmNWYVMw?=
 =?utf-8?B?dzR4ZG52WE1KTm0wcFVvMHZXM3hoaTZ2TGNnRDYxUVhEVklhYWJ5dTZMbjNp?=
 =?utf-8?B?bmw4MUxTTHZTcFU3RDU0eFZiQ0tSR0VEcnVKMEJiRk9uSkJHR243ZjRTVjla?=
 =?utf-8?B?Q1phY2dTekhVVGxCSlBJQkRrQVgvcnVmYnorQUhUdzU0VW5HYXBPQm9ocW9j?=
 =?utf-8?B?cktOT0RVMFJETm5PT1BkVFlaeTdZcXBrT0MxYUpueXM1MlUvbDVvTUhPNW82?=
 =?utf-8?B?dVZYOFQ2T0FZT095SEFOV0RhUTYzQnN6NTRONFIzUG91T0NZUjR0c2o2VzU1?=
 =?utf-8?B?cjdLaEMzdVh0ZlBFUEpvRXpCQ0Q2YVREY2RtM3QrS2V4cTFwRW1OVVV5Ynll?=
 =?utf-8?B?Y2gyZGxwL0J5TlNIUm9JQWg4Y3I0Z1haeUQybDdVa1NFc2xxQ2U5bVBnL1pC?=
 =?utf-8?B?dWRzcXhzZ2JQbUdDTlcyUE1QMTU0VXZDWnIxL2NMVUdYQldIeTAyWWRsV3Bw?=
 =?utf-8?B?TENacTd6L09YeFFBQVp5KzlBbjdnTlpjakg1Z0V6czMyeEo2a1lwV041NHVD?=
 =?utf-8?B?VGJ2VUNZdTk3TzhCcFprK1VKWVZCL3JkdkdReitpUm81ZTNEZzB3N1IzSCtx?=
 =?utf-8?B?S2Jud1I5NlpzWm54Y3dlUDcxN0VDaEtnWHltZHp4ZWovWVdDQWZPN3JyYmph?=
 =?utf-8?B?L0dZRURnYVdlYjVWRXVQNkVJanNXc3hUeGpLV2kxdzRlUTJaMUswT21FMzBG?=
 =?utf-8?B?M2ZLeG4yTUVuK0FmYkkwd3FyRUd5QW9Nb1UrbDBnb2lDUHpFbmxTb0IwYVRY?=
 =?utf-8?B?TWg1Z0dpS2xZVFEvbmxZcDFhUkRqQ2ZhbWhrVmhMSUorTHAzZ2pTOUtQQmJa?=
 =?utf-8?B?U0prc0hCY01zY2Zxc2l0eHhFOThsRncvVkNBYkJ3Nk1QR2xzYjcrRHAzcHc0?=
 =?utf-8?B?anFXTklXTFRTZ1BVRjBLVHNLckJkTUp6VFluNkVZR2I1Y2pwekVzVThZZjFZ?=
 =?utf-8?B?VFhPdTZwelY0b0FBMlNhb0NqdlVKZEdsWjZsMjArMGp4RnV0SlVabXdBVWhm?=
 =?utf-8?B?ME96eWxQQUJ6M3haUjFIUDZ2WUJrN2Q3bDVxYUx3bkM1Z0JJUGp0cTh3ZXRt?=
 =?utf-8?B?MnViR29jaCtNTEpGVGJsekpUQzluS0t0SHlLWmh4U2ZJbWRBYUhveEtCSkdv?=
 =?utf-8?B?M2pnMTNMZk40MVpZN0EreEFiM2VjTVNSTGhOMlFGRnBoQTl5Y3FhWnRYR3M4?=
 =?utf-8?B?Nm1MQW00NENsNDF1b3NmeXJtNWs0L2E5SjRaV3YydHVsb0p2N0hCdWY4Q3JQ?=
 =?utf-8?Q?lw0I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b6b831-9b83-402e-ef46-08dafd5bdbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 16:07:00.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7Os0Soj8/sLXHqBJYcxuET80Yco3CsA0pMF8BNkIo9xGVbLTrHgWtka/0p9g3oPeCHINtuyfJX9uP5Nj1Sh2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmF1
bCBSYW5nZWwgPHJyYW5nZWxAY2hyb21pdW0ub3JnPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkg
MjMsIDIwMjMgMDk6NTUNCj4gVG86IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJyZ2xAYmdkZXYucGw+
DQo+IENjOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBN
aWthIFdlc3RlcmJlcmcNCj4gPG1pa2Eud2VzdGVyYmVyZ0BsaW51eC5pbnRlbC5jb20+OyBBbmR5
IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IExpbnVz
IFdhbGxlaWoNCj4gPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IERtaXRyeSBUb3Jva2hvdiA8
ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT47DQo+IEJlbmphbWluIFRpc3NvaXJlcyA8YmVuamFt
aW4udGlzc29pcmVzQHJlZGhhdC5jb20+OyBXb2xmcmFtIFNhbmcNCj4gPHdzYUBrZXJuZWwub3Jn
PjsgUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgTmF0aGFu
DQo+IFNteXRoZSA8bmNzbXl0aGVAc2NydWJvYWsub3JnPjsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTWFyayBIYXNlbWV5ZXINCj4gPG1hcmtoYXNAY2hyb21pdW0ub3JnPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZ3Bpb2xpYi1hY3BpOiBEb24ndCBzZXQgR1BJT3MgZm9y
IHdha2V1cCBpbiBTMyBtb2RlDQo+IA0KPiBPbiBNb24sIEphbiAyMywgMjAyMyBhdCA4OjAzIEFN
IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJyZ2xAYmdkZXYucGw+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
T24gU2F0LCBKYW4gMjEsIDIwMjMgYXQgMjo0OCBQTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA+IDxt
YXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBjb21taXQgMTc5
NmY4MDhlNGJiICgiSElEOiBpMmMtaGlkOiBhY3BpOiBTdG9wIHNldHRpbmcgd2FrZXVwX2NhcGFi
bGUiKQ0KPiA+ID4gYWRqdXN0ZWQgdGhlIHBvbGljeSB0byBlbmFibGUgd2FrZXVwIGJ5IGRlZmF1
bHQgaWYgdGhlIEFDUEkgdGFibGVzDQo+ID4gPiBpbmRpY2F0ZWQgdGhhdCBhIGRldmljZSB3YXMg
d2FrZSBjYXBhYmxlLg0KPiA+ID4NCj4gPiA+IEl0IHdhcyByZXBvcnRlZCBob3dldmVyIHRoYXQg
dGhpcyBicm9rZSBzdXNwZW5kIG9uIGF0IGxlYXN0IHR3bw0KPiBTeXN0ZW03Ng0KPiA+ID4gc3lz
dGVtcyBpbiBTMyBtb2RlIGFuZCB0d28gTGVub3ZvIEdlbjJhIHN5c3RlbXMsIGJ1dCBvbmx5IHdp
dGggUzMuDQo+ID4gPiBXaGVuIHRoZSBtYWNoaW5lcyBhcmUgc2V0IHRvIHMyaWRsZSwgd2FrZXVw
IGJlaGF2ZXMgcHJvcGVybHkuDQo+ID4gPg0KPiA+ID4gQ29uZmlndXJpbmcgdGhlIEdQSU9zIGZv
ciB3YWtldXAgd2l0aCBTMyBkb2Vzbid0IHdvcmsgcHJvcGVybHksIHNvIG9ubHkNCj4gPiA+IHNl
dCBpdCB3aGVuIHRoZSBzeXN0ZW0gc3VwcG9ydHMgbG93IHBvd2VyIGlkbGUuDQo+ID4gPg0KPiA+
ID4gRml4ZXM6IDE3OTZmODA4ZTRiYiAoIkhJRDogaTJjLWhpZDogYWNwaTogU3RvcCBzZXR0aW5n
IHdha2V1cF9jYXBhYmxlIikNCj4gPiA+IEZpeGVzOiBiMzhmMmQ1ZDk2MTVjICgiaTJjOiBhY3Bp
OiBVc2UgQUNQSSB3YWtlIGNhcGFiaWxpdHkgYml0IHRvIHNldA0KPiB3YWtlX2lycSIpDQo+ID4g
PiBMaW5rOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8y
MzU3DQo+ID4gPiBMaW5rOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dp
P2lkPTIxNjIwMTMNCj4gPiA+IFJlcG9ydGVkLWJ5OiBOYXRoYW4gU215dGhlIDxuY3NteXRoZUBz
Y3J1Ym9hay5vcmc+DQo+ID4gPiBUZXN0ZWQtYnk6IE5hdGhhbiBTbXl0aGUgPG5jc215dGhlQHNj
cnVib2FrLm9yZz4NCj4gPiA+IFN1Z2dlc3RlZC1ieTogUmF1bCBSYW5nZWwgPHJyYW5nZWxAY2hy
b21pdW0ub3JnPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlv
LmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwaW8vZ3Bp
b2xpYi1hY3BpLmMgfCAzICsrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlv
L2dwaW9saWItYWNwaS5jIGIvZHJpdmVycy9ncGlvL2dwaW9saWItYWNwaS5jDQo+ID4gPiBpbmRl
eCA5ZWYwZjU2NDFiNTIxLi4xN2M1M2Y0ODQyODBmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9ncGlvL2dwaW9saWItYWNwaS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1h
Y3BpLmMNCj4gPiA+IEBAIC0xMTA0LDcgKzExMDQsOCBAQCBpbnQgYWNwaV9kZXZfZ3Bpb19pcnFf
d2FrZV9nZXRfYnkoc3RydWN0DQo+IGFjcGlfZGV2aWNlICphZGV2LCBjb25zdCBjaGFyICpuYW1l
LCBpbg0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJnKCZhZGV2
LT5kZXYsICJJUlEgJWQgYWxyZWFkeSBpbiB1c2VcbiIsIGlycSk7DQo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHdha2VfY2FwYWJsZSkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qIGF2b2lkIHN1
c3BlbmQgaXNzdWVzIHdpdGggR1BJT3Mgd2hlbiBzeXN0ZW1zIGFyZSB1c2luZw0KPiBTMyAqLw0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHdha2VfY2FwYWJsZSAmJiBhY3BpX2di
bF9GQURULmZsYWdzICYNCj4gQUNQSV9GQURUX0xPV19QT1dFUl9TMCkNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKndha2VfY2FwYWJsZSA9IGluZm8ud2FrZV9jYXBhYmxl
Ow0KPiA+ID4NCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBpcnE7DQo+ID4g
PiAtLQ0KPiA+ID4gMi4zNC4xDQo+ID4gPg0KPiA+DQo+ID4gQXBwbGllZCwgdGhhbmtzIQ0KPiA+
DQo+ID4gQmFydA0KPiANCj4gDQo+IFdlIHN0aWxsIG5lZWQgdG8gZmlndXJlIG91dCBhIHByb3Bl
ciBmaXggZm9yIHRoaXMuIElmIHlvdSByZWFkIG15IHBvc3QNCj4gaGVyZTogaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjM1NyNub3RlXzE3MzIzNzINCj4g
SSB0aGluayB3ZSBtaXNpbnRlcnByZXRlZCB3aGF0IHRoZSBTaGFyZWRBbmRXYWtlIGJpdCBpcyB1
c2VkIGZvci4gVG8NCj4gbWUgaXQgc291bmRzIGxpa2UgaXQncyBvbmx5IHZhbGlkIGZvciBIVyBS
ZWR1Y2VkIEFDUEkgcGxhdGZvcm1zLCBhbmQNCj4gUzBpeC4gTXkgY2hhbmdlcyBtYWRlIGl0IHNv
IHdlIGNhbGwgYGRldl9wbV9zZXRfd2FrZV9pcnFgIHdoZW4gdGhlDQo+IFdha2UgYml0IGlzIHNl
dC4gRG9lcyBhbnlvbmUgaGF2ZSBhbnkgYWRkaXRpb25hbCBjb250ZXh0IG9uIHRoZSBXYWtlDQo+
IGJpdD8gSSB0aGluayB3ZSBlaXRoZXIgbmVlZCB0byBtYWtlIGBkZXZfcG1fc2V0X3dha2VfaXJx
YCAob3IgYQ0KPiB2YXJpYW50KSBvbmx5IGVuYWJsZSB0aGUgd2FrZSBvbiBTMGkzLCBvciB3ZSBj
YW4gdGVhY2ggdGhlIEFDUEkNCj4gc3Vic3lzdGVtIHRvIG1hbmFnZSBhcm1pbmcgdGhlIElSUSdz
IHdha2UgYml0LiBLaW5kIG9mIGxpa2Ugd2UgYWxyZWFkeQ0KPiBtYW5hZ2UgdGhlIEdQRSBldmVu
dHMgZm9yIHRoZSBkZXZpY2UuDQoNClRoZXJlIGlzIGFuIEZBRFQgZmxhZyBmb3IgSFcgcmVkdWNl
ZCAoQUNQSV9GQURUX0hXX1JFRFVDRUQpLiAgU28NCm1heWJlIHNvbWV0aGluZyBvbiB0b3Agb2Yg
bXkgY2hhbmdlIHRvIGxvb2sgYXQgdGhhdCB0b28/DQoNCklFOg0KaWYgKHdha2VfY2FwYWJsZSAm
JiAoYWNwaV9nYmxfRkFEVC5mbGFncyAmIChBQ1BJX0ZBRFRfTE9XX1BPV0VSX1MwIHwgQUNQSV9G
QURUX0hXX1JFRFVDRUQpDQo=
