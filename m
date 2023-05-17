Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C55705EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjEQEjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjEQEip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:38:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0146AE;
        Tue, 16 May 2023 21:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzJIirLF9HAQ9AVtIs3xLfKWHXrSXiDkyPQYtEdR0DxENkrDUfiRI3uQVrY/5YqrU5kIZx3czthDmQ2PmE9drOjIL1Nr0u6ifstzGxtt5MrS7VX18+cjWZrTIWeUZtM5i+X7L63A3LQMnOW8yE60sE36skFA0FHnvixFiUWTXEfUuqHrzzi+fySAtmiUzm9m/ClYK1LsDEKVExdJlUSZVpa52Vx1/zguzqqMEVRBJMW4aLfHrOxtBs3QqnI5Qx7rMuVSLZxKapPajJCjzuobWTT9rmpGDoiGoJVRL6V9TitcmRRwSRiIOfoP2xJ8OMjJiW9dPbtc9hx5ZawwzIc6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqHHElzh86EmLcPnJoFnQ7qrrJXyDibrzcUjDxkwXJs=;
 b=AF1VEpYY/t1c+mZSfCtkWzDPUgbeVjfHbsdxE5HdzDx0DOfpdsap2FfCNQyqZAklkOmeZNP88OdwUXNSQ5sBVtrmxjl3cP46Qjz3At8/Ul/ur5+pgClNibDNVxajDoyvbI7IPAXgrUdgQ0Bw+wlVZFUasVvrItvOrwgVP6un3joTQ6adkAIlKo4pNXOaTpCB0+rquWMqBJWbq/XBKWSqX4iaoim/DnyNK1LvrpEH6GXYyn8FHF7OUbahf+e+pJfJJm1+OS+s+r8cii0+0YMJUiRQam4E9L9alK+QGyUM69DQ8c4PyQrnb+vLIJYyc3o1wLDS35sljK8cR4qo+mtJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqHHElzh86EmLcPnJoFnQ7qrrJXyDibrzcUjDxkwXJs=;
 b=P9v+uoXOWwdBewmYVRKnFdKNa/paLk4WWW2+uot9AR4Jkm0WiXyf9tXfhcNpqNQoYBBqVqmjruH/IrdGIiFBiYACzZ73xgdJwkayRXnt+1AN6OW1nzvq53J5bywOJJeiUwuRUtTVJe0r7BvXal5B8WFVBoqSOVt/OfQKAM0jrlPUAqYhZxi74MyLNXQx41Hrsj9ObuoIpwl0BotvI+ctTXGKBVpRdHUak2DaaBRl1U98RLuz6Owg3kKZ63YJLHYM4ttUeAoCUSu1gz3MIupB4f/5o7yFOKibVyYhtzAAQQw70LeDuT0ZxziEyuROkpuq5XhWYrsdBApblaUD6Jyv0g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:37:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 04:37:45 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 04/11] common/xfs: Limit fio size job to fit
 into xfs fs
Thread-Topic: [PATCH blktests v4 04/11] common/xfs: Limit fio size job to fit
 into xfs fs
Thread-Index: AQHZhBJMN+XMB1950Eue40tjtsj6xK9d6oGA
Date:   Wed, 17 May 2023 04:37:45 +0000
Message-ID: <2dde6c62-bb0e-4b1e-e3d8-fe3aea4d947e@nvidia.com>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-5-dwagner@suse.de>
In-Reply-To: <20230511140953.17609-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB8338:EE_
x-ms-office365-filtering-correlation-id: 04e441f1-50d3-4a22-79d2-08db569075cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BiPNDdns8m4vGb3zrTaFlP958ozOmywDWaVk7L9nBFAZ8LIjdWwB+bVidkaRrioNia9dk4c51WIskfahDiJKRVPkZxHYR10zKexwBgdLwDxRCi5ru9HqDGoWQiC4l7YVrJd7b4N80CELDWXVPdcL+tAQF1waa8hzvd2APGR+qf592RmEcxzJA7yi6e8VJQ7Ywk6QyxzdsTSw+HxQgztG08QyInfScLO0ToEF4e9oBfu7eGpBantvCv6z43OZ6sYz4uwQD/2P1tIMrqiMXCfKykw4Gr0Ezx3MJocu2DEcje1qub3Vy2oKwpuUYJSALv4waDqN+Gv0V+bFirdmLTO4AnrgPMzRCFzRNjzTgHR6IXXdHh1Q6Lw9gs5OJmRfgydsjwIJgEugeHwx2WmEYB2TrMGCQILg7JLV5xv9XP8IbvXdDikBzvdHDrV7n75/FZUcvJ4tHctGSqjoPzadS+WCV/2DJTuI5Gk2AQetVosGW19V8WpYL4ZFF8AXvMpa2k0bK/eSJ6Q6OKjjH5N0HfYXIwJJ+l53DgtJydnsMyKmGhSwBPyt252jmN++9vVXr/4x0ZYVUXrgwWgCjrmsCb3EzKQMUe4/KFuanGLSZULn4ClruX04Nr7oh3Gc7YOuwB8MpjBdtHgQHcw/ttrAP/w0q+SAg28tLDkkAY61lfKgbcxGRWqv2SmJYOo7WKr/5EWG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(31686004)(83380400001)(4326008)(36756003)(38070700005)(2906002)(4744005)(8936002)(31696002)(5660300002)(8676002)(86362001)(316002)(76116006)(66476007)(66556008)(38100700002)(122000001)(64756008)(41300700001)(66946007)(66446008)(91956017)(186003)(53546011)(110136005)(6512007)(6506007)(478600001)(71200400001)(6486002)(54906003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1ZTQ2QvMXRDOUo4Z1QrT2l1a25TaUhoMHRPTlBsZVlnY0dPa2xxVUFVSkg1?=
 =?utf-8?B?MUdhelBqeE8rRldiQTJoaUZpV2lWKzV1WW1qTkI5MGNBbUJrMmRRYUJISkFC?=
 =?utf-8?B?R2VsdzJ0U1FaZlZlTFpkcEUwYXJGVll0KzRQOVNGVVVEM1JFWE1lcG1CbjRC?=
 =?utf-8?B?TEJsSHJsMGFRaWNQWGVGbGlZRHdSeGIwR3RHSVBqVG4ySFQ2UzFGRXpVT2hW?=
 =?utf-8?B?RnV0QVBaVHhTcDUwelI2d1VzdkthblZ2RXdtYUNnZGtnV0dGN0R2dk9scEdo?=
 =?utf-8?B?UGFjaXRiUmlKbC91Nlh5LzJoV0d6dTJrclFudkEwMnhxRElsRVpqZDlzRzZL?=
 =?utf-8?B?ZHRhRjZnOTRWbnJacmVyYXBhbVhDakp1QkdObFJaWkVNWFliOXBmOHorVE9x?=
 =?utf-8?B?QzUzV04xOG14NTYxdzEyYkZ2S0pGL2c0d0pzWnA1WWREWVJWN09CMU9FOW5K?=
 =?utf-8?B?VHRJVndVaElIZ09jYTZwaFZkSm9XSWJ0WjRyYUlacUxWSVpXeVZvb3FHb2gw?=
 =?utf-8?B?SjNJYjB3UkNpSG1qaUtKV1hZL3JzY2tKWXUya3FoT0hzU0lkUTlVQzBpSHgy?=
 =?utf-8?B?N2pJS3RwNTBDREo5WFQwZWR3TFBGQzY4MjlNbjNSc2xmUFhBUXQ4MXJMQWZN?=
 =?utf-8?B?bldRMnphVHBGZllaVFNGaVo3M09vOTUzZkRUYytZc1JvdWRnMnNwRXpUUTVx?=
 =?utf-8?B?L0RCWkdEMGU0N0JsM1VZTE5wd0JEbURaSzUzZ0hhSElTY0ZuTXRmc2hNUE9L?=
 =?utf-8?B?YnEyV1BPREJkbjdNSHcreDh5N2JPVTRldDc0OTE2SnNlWU5MRzFIRnlvN1lp?=
 =?utf-8?B?dW5WelRSMjFYdzdVT2hBRitaWFBDNEhwa2JJZ0tQWklmSDd1SDVKUmZxNVBY?=
 =?utf-8?B?WFhBV1lCb09sV1Exa1cvK2c4TnNBMVRkM2NYaGUrUURCSEJBa1hXM0dHNU9q?=
 =?utf-8?B?TzZxUEdEK3kyNWJvL0NMODNBd21UYjR5RmtRdTBBNDZ1bHEwc0FWazhTRUQ5?=
 =?utf-8?B?K0ZHcXRBeUFmemw2NnRnYU9EdDkzbXl4NmNOeFRmYW5YaUFmdnhZcEFyd0pH?=
 =?utf-8?B?OExjSGV0dk1rRmtyYms2aVRoY3A5TFJJek5XMXltelhvRENZM2p6bTNRb09w?=
 =?utf-8?B?SHNWWEMydDdqU2g2Y1RzUVFub0Iyb3QzTUhQUEVJWlFrNDhCZEl6M3J0MkNS?=
 =?utf-8?B?bUF4cnZaNVJSTUlpZFVCcGE0cXNJbjFEQ0pyejRCQjhrbWFEdUFYenVVUE5h?=
 =?utf-8?B?SWp3UXdEbWJQUEZXRDVqbGhtVmMxMnBDWFpkeHZ0eG1ud2tYb0VDejc3Wmd2?=
 =?utf-8?B?SURxdUdobmxvNHlHMkdGOHJpUnNacU1OSXBEajNEOEE1N1RYOXphdC9CTmRm?=
 =?utf-8?B?M2ZwMXFDWHQ0a2s1d2tYRFZnL1R4a0tva3lXQkdSQS9Kc0UyOUJQc2xNaEFR?=
 =?utf-8?B?UURqeXNHdW02N016VjRmTENKT3NCT3RFZm1zQWNFZUxLdWpocXhSNyt6Zzk5?=
 =?utf-8?B?UG1zS0l6T3h0RlVwVkU2OG1xWWxNeW1Da2QyU085SHdnRmE3aHhUSEZYZDlp?=
 =?utf-8?B?TWpPT05pTVl1cW5FYmI4RTM0d2t1MzJEcXFBZHZBM2JOS3NvQmhHTDRmN0xB?=
 =?utf-8?B?QzJkb3ZrdFJMZ3B3VGtaUkJNS3hOYW80Zm5xRW4rR1I4UDJKRUJHS2FCYkNT?=
 =?utf-8?B?NjdzNzVvck85TzhEYncyL01MbTFKTlpsaFB4UHJ5eElySTVzdWU5UkJSQWlE?=
 =?utf-8?B?dzllcW5NdmVUby9Ub2RSRUNKUzFvSVkwc05jaFZyUXFURG5KRXFDQTZIaXdx?=
 =?utf-8?B?MFdESDdKaTFqTmhmU3pNV3dVNUNOWWVNWWFmbWtXQWdLRk1zcmlnV1pkaFdJ?=
 =?utf-8?B?THlIMzlZeXV1RStHakVWdGwrdWRyN2c3aTZGbHh6YW9NMDgreGVvMVRkVUFp?=
 =?utf-8?B?Z3VKSUVUMXI4WlNzaGF6ZktYMVlnNEFieWpML3dKalVmWFFlWlN5dFdRWEZ4?=
 =?utf-8?B?UGw1VSt5UGlBUUdZVVFaRGk3QnQrNHJ0MU9jckJDYnNEV1c5U2lhMlBWZC9F?=
 =?utf-8?B?NlRhbXA3d0h4ZEc0ZU9rL1hUQnNWNDdtcDlNZEUzMVh0MzU3ZHFGUlZLVUE0?=
 =?utf-8?B?Y2RlSUh2elIvSDJqcFZMUGdEcVB1N3ppemhmVGwzSWtYVzlPRk1KUVhaS3lO?=
 =?utf-8?Q?GXCwuKk1PxDc7vOq4eX6S9jrKVGrpqg0w/xRKoUeyP4P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B1FD1A3D6F27547A5437FDFA475F7D4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e441f1-50d3-4a22-79d2-08db569075cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 04:37:45.4543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NsxPWwiULXLyPfNiuaZkf0FDMJRwsy80zOSHT3w0uOLsPDF6y4+BFIQHopWQEMDcHGCPr9ORYlD9i+n2n5qrZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMS8yMyAwNzowOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVGhlIHVzYWJsZSBjYXBh
Y2l0eSBvZiB0aGUgZmlsZXN5c3RlbSBpcyBsZXNzIHRoYW4gdGhlIHJhdw0KPiBwYXJ0aXRpb24v
ZGV2aWNlIHNpemUgZHVlIHRvIHRoZSBhZGRpdGlvbmFsIG1ldGEvbG9nIGRhdGEuDQo+DQo+IEVu
c3VyZSB0aGF0IHRoZSBqb2Igc2l6ZSBmb3IgZmlvIGlzIG5vdCBleGNlZWRpbmcgdGhlIGxpbWl0
cy4NCj4NCj4gQmVjYXVzZSB3ZSBoYXZlIGhhcmQgY29kZWQgdGhlIHBhdGggd2hlcmUgd2UgbW91
bnQgdGhlIGZpbGVzeXN0ZW0NCj4gYW5kIGRvbid0IHdhbnQgdG8gZXhwb3NlIHRoaXMsIHdlIGp1
c3QgdXBkYXRlIG1heCBzaXplIGluc2lkZQ0KPiBfeGZzX3J1bl9maW9fdmVyaWZ5X2lvKCkuIE5v
IG5lZWQgdG8gbGVhayB0aGlzIGludG8gdGhlIGNhbGxlci4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAtLS0NCj4gICANCg0KbWFrZSBzZW5z
ZSBmb3IgdGhlIHhmcyBmaW8gdmVyaWZ5LCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
