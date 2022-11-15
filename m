Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD056290E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiKODkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiKODkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:40:06 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D53A19D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:40:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCbyrpXWEilydpGwgxL3a0xC1xpzdn4rHnReZ9A9JyQfeUm0PKQN1OmC1eQz9h7dk/8Nr8VgPKmBhIIdY8XJ507IpAacM27junD/z6R4tZMOdgjvTGp8FkhhDgTWnPFt0+Ntz4x1fG1UnPzL49NmPJA5MoeWIZnK4t72JOYtPT56y+MgO55DnuJQLkljdluJYh/5oEKPn1y9Jx389HXDg4EW8p11dg2vk/9p1TPDpW35rd54YiO1d8Osg8wKpztAYux/TmbHspBBD6rh2wJB6yX07HlAb54ZUMRSQMmUppGGywte00wfyrsPmD9C74aLEPwjuFSnRKg72HwbBa6zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfBR5uwOGfoF9HrhjAem3/BaSxKANm7MNRT04A55fl8=;
 b=HikB20LBVY3HH0kBi7nCAUGeuEV0u5OYa2NXZ5s35vLKr97z3/xPXlqYBIBhR5UC2b1oFPXqTsxLDrcy5S5Gl9BPR9KPiN5IZA+/k19qPjsrqh6N+p/Exa8nf4HlRaeFiZZPgJ5tv/nYTWhXBdmDxCzlPH5ZtTjGFBQX/RxN2STjar69qyIfb8q5Y2ipiSjs0Wtl0eECmwScX4bI+cxtZb2U83zB2THagWgnm3KaVJVTvAAkzHKkzGiUAV76nizc9z8h5AB7EqlmXBfC6sxYlWNqID0ZmqM/19ZEDhmIA80UFI2Ssn0d8ZgO56Vu1G16txjtovwgmtAJxAJPWgRIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfBR5uwOGfoF9HrhjAem3/BaSxKANm7MNRT04A55fl8=;
 b=lFtG5/xLSn+oD89KuKGHsJf5PRJV1RKQnOdlQPAUB4RGcbJq8LJ/JuvyxtCKtC6NVHxrRuwfmiNAevJn8YvkwJglBssIxxas+61dYnt3rfmGhVza/iPGf/7iN43+YUPZ7/z8/fulkOudCWWmM2DTnS9SUK37zmfflB2fGfPPlD8dj1KkUuLa8FR+3jUpRna5XiD4OyVCZT7YlRJxFKFi4OX8EVq2GlfYrznZkP8YA2zVVVdISTozpB+/L1VZUxOkFxTjxM0Qbin/bFV0XY0TEf6vPkjZMb8G+jqDgAbZyTz1/qfcT+eWzu4s2NKFwBnDV9Czuc7EnnDxym/pf4mOeA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SEZPR06MB5197.apcprd06.prod.outlook.com (2603:1096:101:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 03:40:02 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24%7]) with mapi id 15.20.5813.014; Tue, 15 Nov 2022
 03:40:02 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: IRQ affinity problem from virtio_blk 
Thread-Topic: IRQ affinity problem from virtio_blk 
Thread-Index: Adj4GDwuFWHl+dEdQ1up6lA52hDITA==
Date:   Tue, 15 Nov 2022 03:40:02 +0000
Message-ID: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|SEZPR06MB5197:EE_
x-ms-office365-filtering-correlation-id: a262edf2-516f-499a-d3b4-08dac6bb13e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbC6a+9IjOFcHvCxYlnHD4SphzSqdBq8/Hlw3cwiV7eWjOHOHueaegHuMovQ4skCnYkuecbVKDB3plDxM91iZnv5PhY39C4rEHEe9QE4TeXQ/U1GfvxoFWWhXpbyEFjDG8wiJpYG0xSEI4DRKuvejYCZ5Us8rIcyAG60GptJPZLpUbsVPoHqu0KkuxriLGaCWFSTADxJoSX+5Elocit9d7axQ1nqKFKmVaBo9VIr4/wFDChTUEw+luqOOa7Q7Y95fMbd0AIjvAfftJGuDQLGCUm1YwlvAl/RSIbArqJQXiYuy1SOMEqJgriyolwTqBVYUXn/JI6il9xqDgUP5leYll0cy8tjUSbZpwt2a2QQcm206V6WJdvXuC0KKqWBOn5QBrRumMRVxYK+PKVw49ACYvdFf/FdZkUSU31L05ZKmuUGv5fS5qa2UCK0GSDSzueZGIghhA74Tzt6bt9p152usY/CaLQ6T1/PVgXW4TauOF5tH4VWE3YY517xHKJ2OuYKWR5RBNQi7rMGjujyx+JoF85jaW+QlR4NAtXgBWXxofdAlTvS4/QTb6AOMo+YEOkgOsoTJD+Rm8N1+3K7eaZmzcGI4KOVhffEzW3ek0JkIxKQnhUWE/RuIHbjvGyudYAVUiNWPEDT6QLTo27bjf3WWv/a6ZWpGoTcMP4vaSKTBJAVmHKLLw1FGXN8FCB95bxRdxK5lfKWTVKSRsnrlrOd4lDKaDi8khk58skItPi+ErhMADPrYP1sPwlCVlwyOE54uMZIhRg9p9odQsognk4/EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39840400004)(376002)(346002)(366004)(396003)(451199015)(55016003)(86362001)(33656002)(122000001)(38100700002)(38070700005)(316002)(6506007)(54906003)(6916009)(7696005)(71200400001)(44832011)(26005)(8936002)(5660300002)(52536014)(478600001)(186003)(83380400001)(2906002)(4326008)(41300700001)(66556008)(66446008)(9686003)(4743002)(66476007)(64756008)(76116006)(66946007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5mU3N6cGxUMUx4NDQyRHlLa1YvOXJHSThON0djOXg4M3Jxa3hNNW9tSWNi?=
 =?utf-8?B?NnY3Q0tZdUYrSVZadkIwaUdxSDViSVByYnl6Q0NTaGF6UWxqYjROSkM4c0JG?=
 =?utf-8?B?RlgxT2F1dCtlN0tiT0g3UG5HOXJsMDJOY2Z0Mzhka0puOCtwcStBaitHMnBj?=
 =?utf-8?B?bTRoNDR0UElJS2poODZLY2NDZXcxcVlyVzVLTlRjcUtZNHlxQml2R0FhY1ZW?=
 =?utf-8?B?U3RzNmswRzM5Smp5SzFEazJhdnllb1pKeWx1ZzZXN1N2TEUrbHhjaUtRelJJ?=
 =?utf-8?B?ZUl1OGcwOGJvUmVBc0dvV0p2UXVibmhGRUZvWXJzeDVwRnJOMnFhNlVZUmQ4?=
 =?utf-8?B?aEp6cGRtaWF3a014ZEFUN0ZKa2l2bkU3VzRGOWRYYmtKMS9RWWNBcWRaQmJz?=
 =?utf-8?B?NUJkREFYZWluMnVLNnBXRGhGNjNuWGJTbTZvVFgyOVJheVQ0MGZwWGNDSm9Z?=
 =?utf-8?B?NUE5aGE3aEJOTjZoZC9HNzM1cWtTaXJaZDVoZVVYcFoyTE1DMSt4TTNzOW5Q?=
 =?utf-8?B?NHhGdDdkN1NXVUN2N3RENGNveTZlczUzUEZhMjBpRExmRWg1THhPR1FKaUs0?=
 =?utf-8?B?Qk9Wcm92eDFOWGxtcnVpRWpQUG5QeDV3Mk0xb29IMk13cENJTThpdHJLZnR2?=
 =?utf-8?B?MjlvczdYQ2d4NGVnNjBtYzFJeWczMStPWithSHl6Y041S3JUTlhGN1FwN1Vz?=
 =?utf-8?B?bFphSUxQNDcwcmwvZXdlTnIxUnNnNStXdy96R1pPVzRRL2xYN1dpdVk4Y3hl?=
 =?utf-8?B?ZTRJNU9VNnM3TUFTYnErR0hqemgwTkRXSUlNMFNSNGU5KzhjZU9MVmJFVDV2?=
 =?utf-8?B?ZXR3aFlNYTBaaVp0S2dTd2JpRHFOMGNRMXgvS3VKdHlDek0wWDFDWFRIKzJj?=
 =?utf-8?B?OVIzWEFMMi9iN2ZmbVU1S2Exa0V5aDJkZURmMVUyYlVjMEFVeExMRDgwbHR0?=
 =?utf-8?B?Z0N6cFJRRlIvbEQ3ZGgrSkU0TElPUFR1aHRMNmNGQUxSRXN1L2xMVGtUZlV0?=
 =?utf-8?B?bGJZa1U4cUJvYmR4T1ZocmY1ZVBNUmV3TjhVaVVoRTFjUVNvd3o0akY5Y0Zk?=
 =?utf-8?B?aWRia0pIU1BxSjRxUzhaZzV0MURRK3pyU24yRlVTNmQ1VmZCT25BUWcxYVI0?=
 =?utf-8?B?aDZPMTFneDYrb1JsSHZhSVNjUHlnOFJGYjNnNjZRTlJ6RTBrQjMrZUFiQ1F2?=
 =?utf-8?B?WGtFUk90OVRzdFZiRGRSaWsra2F2TG5qc0hXUlhtdDVubFFHMTZ4N1lmTm12?=
 =?utf-8?B?TUlwS0NtMjVXOEcxNlh6dHlQN0hHL3JINVA2Qk1WWk5lZHFGR1hhZzhaRE5q?=
 =?utf-8?B?YmpqcHp6eGxaMWJRN0I1UHVMVEhjcy9qU01KRStVUm9oV2RmRGRIeUlXZ2lx?=
 =?utf-8?B?WXJZWXJHV3pIbkwvaVFEVjBCdGtFV3FkdzdNQnNYblZDQkgvcS8xdHR0aFRU?=
 =?utf-8?B?aXBFWGltaEt6cmp1SjV3MVNyOU1uQUZaOHhhNnFqYTQwQWI2SmZhb1dkU1Jo?=
 =?utf-8?B?TXJsWEswUHA0N3Z2bE9YancxeDhMa21KWlZwTHpEOUlsWjlIOEE1eDZTb0pI?=
 =?utf-8?B?Z1NEZWtOaFNXUEZYdTYxYUpyaVNKWWNMa2FEdHRtVUFsN3A4UlFNdk5EbC92?=
 =?utf-8?B?WHc5UzE5bnBqTHlSQXQzT0kyTWxFVXFVRnVpNkYzMG9rQjkrNnhvN0hpdkhM?=
 =?utf-8?B?R0g2M0Jac0R0YXJaR0ZOV1ZyTnRBZGVncmNhR0Z4WndrUEpOZW9GbWg1dEs4?=
 =?utf-8?B?MjZWY08xMUI3c0h6MnhEUStuaDBqTWlNRzhrayttRjh3NlFxbERSdFVBVTBt?=
 =?utf-8?B?Z2tnZlhVK3hJNUdwelZuQ1ZtaDBpQVNwQytaU1BTTktTcjdSK01IQi80Uk9V?=
 =?utf-8?B?cHpUUGl5cWlFSS8yaWNTWEZDbkQ3amRUcWRlV0IwUlVqelNNMzB6by9mSnNX?=
 =?utf-8?B?c2hDSENOQkdHM1QweS9QRVl5b01qSUJIcW8rVHp0WEpXcFMrZnM3UEthb0Nw?=
 =?utf-8?B?d09KMUwvbmRjY1dsVEJpUGV6c2V0ck9iUU1OZmJNMEdXYmUxWC9XOFJSU3Jz?=
 =?utf-8?B?c2lGTnhpU0ZuczFtY1dRSXRWcm9URlNBRnlHcFAvL3lIYzY0c1JSZmZpakZq?=
 =?utf-8?Q?RXXnQtOD3d3vEI+ow3LcmgSDj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a262edf2-516f-499a-d3b4-08dac6bb13e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:40:02.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mftCEN1cY3JKbcwjJO476INZJ3ytGMIgjo7WjtIKPtlGeMwBWJnsa+lkDrjmI3IuxIfRr4ap4ab6Bi93latHa253yRHRcZfYA0fW8ATNb3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLg0KSSB0ZXN0IHRoZSBsaW51eCA2LjEgYW5kIGZvdW5kIHRoZSB2aXJ0aW9fYmxrIHVz
ZSBpcnFfYWZmaW5pdHkgd2l0aCBJUlFEX0FGRklOSVRZX01BTkFHRUQuDQpUaGUgbWFjaGluZSBo
YXMgODAgY3B1cyB3aXRoIHR3byBudW1hIG5vZGUuDQoNCkJlZm9yZSBwcm9iZSBvbmUgdmlydGlv
X2Jsay4NCmNyYXNoX2N0cz4gcCAqdmVjdG9yX21hdHJpeA0KJDQ0ID0gew0KICBtYXRyaXhfYml0
cyA9IDI1NiwNCiAgYWxsb2Nfc3RhcnQgPSAzMiwNCiAgYWxsb2NfZW5kID0gMjM2LA0KICBhbGxv
Y19zaXplID0gMjA0LA0KICBnbG9iYWxfYXZhaWxhYmxlID0gMTUzNTQsDQogIGdsb2JhbF9yZXNl
cnZlZCA9IDE1NCwNCiAgc3lzdGVtYml0c19pbmFsbG9jID0gMywNCiAgdG90YWxfYWxsb2NhdGVk
ID0gNDExLA0KICBvbmxpbmVfbWFwcyA9IDgwLA0KICBtYXBzID0gMHg0NjEwMCwNCiAgc2NyYXRj
aF9tYXAgPSB7MTE2MDkwODcyMzE5MTgwNywgMCwgMSwgMTg0MzUyMjI0OTc1MjA1MTcxMjB9LA0K
ICBzeXN0ZW1fbWFwID0gezExMjU5MDQ3Mzk3Mjk0MDcsIDAsIDEsIDE4NDM1MjIxMTkxODUwNDU5
MTM2fQ0KfQ0KQWZ0ZXIgcHJvYmUgb25lIHZpcnRpb19ibGsuDQpjcmFzaF9jdHM+IHAgKnZlY3Rv
cl9tYXRyaXgNCiQ0NSA9IHsNCiAgbWF0cml4X2JpdHMgPSAyNTYsDQogIGFsbG9jX3N0YXJ0ID0g
MzIsDQogIGFsbG9jX2VuZCA9IDIzNiwNCiAgYWxsb2Nfc2l6ZSA9IDIwNCwNCiAgZ2xvYmFsX2F2
YWlsYWJsZSA9IDE1MjczLA0KICBnbG9iYWxfcmVzZXJ2ZWQgPSAxNTQsDQogIHN5c3RlbWJpdHNf
aW5hbGxvYyA9IDMsDQogIHRvdGFsX2FsbG9jYXRlZCA9IDQxMywNCiAgb25saW5lX21hcHMgPSA4
MCwNCiAgbWFwcyA9IDB4NDYxMDAsDQogIHNjcmF0Y2hfbWFwID0gezI1NzY5ODAzNzc2LCAwLCAw
LCAxNDY4MDA2NH0sDQogIHN5c3RlbV9tYXAgPSB7MTEyNTkwNDczOTcyOTQwNywgMCwgMSwgMTg0
MzUyMjExOTE4NTA0NTkxMzZ9DQp9DQoNCldlIGNhbiBzZWUgZ2xvYmFsX2F2YWlsYWJsZSBkcm9w
IGZyb20gMTUzNTQgdG8gMTUyNzMsIGlzIDgxLg0KQW5kIHRoZSB0b3RhbF9hbGxvY2F0ZWQgaW5j
cmVhc2UgZnJvbSA0MTEgdG8gNDEzLiBPbmUgY29uZmlnIGlycSxhbmQgb25lIHZxIGlycS4NCg0K
SXQgaXMgZWFzeSB0byBleHBlbmQgdGhlIGlycSByZXNvdXJjZSAsYmVjYXVzZSB2aXJ0aW9fYmxr
IGRldmljZSBjb3VsZCBiZSBtb3JlIHRoYW4gNTEyLg0KQW5kIEkgcmVhZCB0aGUgbWF0cml4IGNv
ZGUgb2YgaXJxLHdpdGggSVJRRF9BRkZJTklUWV9NQU5BR0VEIGJlIHNldCAsaXQgaXMgYSBraW5k
IG9mIGZlYXR1cmUuDQoNCklmIHdlIGNvc3VtZSBpcnEgZXhoYXVzdGVkLGl0IHdpbGwgYnJlYWsg
cGVyX3ZxX3ZlY3RvcnMgLHNvIHRoZSAnIHZpcnRibGtfbWFwX3F1ZXVlcyAnIHdpbGwNCkZhbGwg
YmFjayB0byBibGtfbXFfbWFwX3F1ZXVlcyBmaW5hbGx5Lg0KDQpPciBpZiB3ZSBkb27igJl0IGNv
c3VtZSBpcnEgZXhoYXVzdGVkLHdlIGp1c3QgdXNlIGlycSBiaXRzIG9mIG9uZSBjcHUgbW9yZSB0
aGFuIG90aGVycyBmb3IgZXhhbXBsZSwNCklSUURfQUZGSU5JVFlfTUFOQUdFRCB3aWxsIGZhaWwg
dG9vLGJlY2F1c2UgaXQgbm90IGJhbGFuY2UuDQoNCkknbSBub3QgYSBuYXRpdmUgRW5nbGlzaCBz
cGVha2VyLCBhbnkgc3VnZ2VzdGlvbiB3aWxsIGJlIGFwcHJlY2lhdGVkLg0K
