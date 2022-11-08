Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA5622052
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKHX2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKHX2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:28:14 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D5BAD;
        Tue,  8 Nov 2022 15:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVhSohUu6Nu5dK4tS8mWcr2SsVMbnuOdYsSbi3zBLIMjv9So4272shUIG8a2E7112fczdX3lk1PrSzRZgqPTsf+GZdfcJ75SPoi6dEP3l08n4Ev87NEgpYzdxpjrQuvOGjblSIQ0hHYtDJzmKB8lxJqD/QRLhbJ3n2zy59opiupNJRMBggK2zCyzaAoo8QC5Cm5n806p7FibV1aL9CFwPdipPMHoya6h539NyztnLYIGc7D3YKptbHtUZ6qaEUSZp43kAwo0IPU14kN48vYhMmXP9vRsiW1A/+Dz1bYf9ZEaZvPDtGutSXA8ZGMeZRqrIRnsIPmQl6dm1oyRhWVAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOT6sDaNi43wJIZnL2zAeAiTNa9KNB3uIUBILauyHZs=;
 b=h/qRndiE/yPSFTscTGpQF/hY5MlMxZk1qC8pZny4QCcGjJ5FzK2P5WFd7w3GMubLYa3pzCMEMig7otMe4bv1hoCvXE5LeT0Ww9QxcEJmArvdcPLKAtLtsO6gKMMtYSJTgREaal59YG4b2AF7+oXhpsxAlxA47KxrQOZr3SMSuw6Orymhl3O4kwhMyrM27Cm8/xTC5uGRo0thQakdNq1ijnT8tp+G5OKHP+29FGSNN//XVR+ZQF/KTRhizVLI4UZ0rdKG8zNI64+VGU0pLKBs8bda8pCbtrModpKfyREVccA0TokIKbASoFJQbpaZb1+FAq2NMCamv0ejNtPmisYFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOT6sDaNi43wJIZnL2zAeAiTNa9KNB3uIUBILauyHZs=;
 b=Jqp2e9ezE5ezC8/wZqnDmp14+AS0a/Ju1xpJ2+IG59tJU0qG5Pj/KGHqKTlEcQYEjnCwu3gzWG8YDCdhvfExJbiyRafCEc2I00lIyLSF1/TUQK114my73PemmYwx+E+bzC2PvDquS9xaOWzsuihpi5JHEv7Opb30dsNaGcat5OT8CMINGMYk2tSIHqetu4iMEAF55i9pEufxfXduE4bhcQ3Ic2B+WAEjPKZe02RJwGahj1E775n76pZoTEOud0YnxzOdmTb9rfBvyoR8D5du5CzvyI2MdPc8IFIz/dm92AxTAPap654B52kMiy7mNspOZ7IJtAh1N1ln0RhUt54S2Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 23:28:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 23:28:11 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Liu Song <liusong@linux.alibaba.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] sbitmap: Use single per-bitmap counting to wake up queued
 tags
Thread-Topic: [PATCH] sbitmap: Use single per-bitmap counting to wake up
 queued tags
Thread-Index: AQHY8Wvm+CZdxB4ohkivtu7W5Z+5TK41sLCA
Date:   Tue, 8 Nov 2022 23:28:11 +0000
Message-ID: <f2d6dfd6-1234-2545-7955-07db078faa54@nvidia.com>
References: <20221105231055.25953-1-krisman@suse.de>
In-Reply-To: <20221105231055.25953-1-krisman@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB7219:EE_
x-ms-office365-filtering-correlation-id: 251a511e-ca80-4e0e-86d7-08dac1e0e6e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwpxG9NmCd3OLEw2JOluLIz9sC6g6zOIJIBmLCJ2l5GPV4tzC8KEh+3sn4Opg5WMvU1yneBQtHXafqjFBRq0gLbMJ8hoOiVOBs9sB588uHa7RPsRr7s1dyzLQyH5R6IloqjALNybH9oV9rjpWlyqb4618k80B8nJvGZIiBaAVNt4nTRGNIYlDrbWOQ//4h4uXLhBhNvffinNiY/sa7CNbsguP3OSc1k2PG9SoPu6OEmMToRqzz8t/ywBKoFogs9us3PnacR1tUqrDe9+41lUXHniX5ONfK3dUZR9qR2nIad+haOo30zjO3vp8t405U+6qTfgvl2BTVhcNF+WGn1XHPI6YEqmX4NoUTH+0bWXYep2Qt2VFFEDBIU7RXe2zrWjrQtXGTuuOl4bvproscsmbVESpawpq3z+7J7tqjlxUkKi8/xtN9573j1ZiONQU47XLz/qi0WPVz4zaXIw4B36xUBb6QdLX9hq6PUTgbgP3hA0u5aM0tq5OJOvUbQe7gfXGTupKEAlvikwWN4j22VAHSy7D3GO+mlq4GPz3W8IDUjSlXwZ5hmjjyLqAm+AzzaYqVeBRMqxn0bcKZeLI0fWS4WJNwkzCnqoB02mPyfz8t35FYqlp0wMhW2V3tphneNk3Xz7xiuvjRYfwMHeGDqGP/4smsZo2142uBGafD/ybZFN4T0LJ3bvhy8l3Qpna36+lUaOPYUPazcmwmm3Y7sxVPZGMS0lmUj/oO88p93YeHqFObizG9/hFRvAuGbiRG1UR24szASOtj4SovZ82SNWgaArVQkN25s/RB0dZ7PtJjTcG2/VBUBIGh6f0Qkzw7CG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(83380400001)(41300700001)(31696002)(86362001)(6916009)(38070700005)(122000001)(38100700002)(64756008)(66446008)(66556008)(66476007)(8936002)(76116006)(4326008)(316002)(91956017)(2906002)(8676002)(66946007)(5660300002)(6506007)(6512007)(186003)(71200400001)(54906003)(2616005)(478600001)(6486002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3U1WWdla0hIUWZkeEhJRUI0SEp0cW1KZjdUWlUwWVRPRUlOUTRIdGdXSDNL?=
 =?utf-8?B?bjdmVWFuTGw1ZXJvNGJwc1VnOXQyaTFJbCsxUnF4QmRwYlY4cGtGenRMUStl?=
 =?utf-8?B?UGQ2azVPc0ErTXFnQzlab2MvR1pNbVNXU2ErNTl0ZElSQWVIdVUyL1IwYmRr?=
 =?utf-8?B?c0NSdlNLWGZCbXRmNjNhV1ZsYnpRaVMwSDNyN3RCN0VMVXdrSkRhYU9jNFlL?=
 =?utf-8?B?d09YYU9QT3llOEVDUElZNHZOdWluNkZLR2ZpWkhsdElzSXFhUXAwTzduVjJQ?=
 =?utf-8?B?c3E5dHQ1YmZJMVVDaTdDeGRjMlRxL09rZDVLamhObmMzd0huSFBuZmpEcTYy?=
 =?utf-8?B?QlVLMWt0OVJTZm9wenlWSEJ3ZXhFWFJ2Mm1EWktnR2M3bXBJRUl0N3Y0MUJ4?=
 =?utf-8?B?enl2b3VIU293MmVCRERtN09ZTmxIZUI5UVhtL09WZzVwMStyOXhPMCt0TmdN?=
 =?utf-8?B?ZStwNUtTQUNxbE1JNHIzUHIxUWUrRTNOa1JyZFQzd3Q4RmtHWnFkenNldkI4?=
 =?utf-8?B?VXQ1UkZpOUREZkZYZFJ5aUE1WVFyTTlJWVlPdnBpSDkzZzN1bmdKRHJMQUFq?=
 =?utf-8?B?cml6RWtPV0ZRWnBVQ00yM2tqR093azc5Nm9EMVYvWlhoQW12QzRoV1B6WXpx?=
 =?utf-8?B?elJ4OFRDcGgxV3V5VmVyUGlCUVpVSUErMlp1bkFQaitHRUNmajhoendhVndw?=
 =?utf-8?B?OXNwOTlQRVh2Q1lNQnpUaFVrQUxOZkhCQmQ4UE9leVBjV2k2N09VNmc0Y3FR?=
 =?utf-8?B?V09tTzdvZzlDdi9WcFBtbFFjd1RwMDNwTWlZVW1nVzBpQWUzV0xQcDV2YjMr?=
 =?utf-8?B?akF4ZjhoekRldXFHQzB2aHQ2bXBQdCs0RVJhQkkzbjlPMEdFNnlUNG45dW9y?=
 =?utf-8?B?VkZyUHBOREZjR1d3L1E3WlVVTVRxSnBCNWNPeUFaa3EwZ29lYkZXeVVJTFVr?=
 =?utf-8?B?UFVYYkI0OEJwT05xVEF1UGZibHpZMUNMWWEyMUJtRkN3YkhhVVpKZlNaZUVq?=
 =?utf-8?B?R0ZUUkJTNkRsN2VOL244NFFNZzdHbjVIWjlGSVY1VC93R3ZzMm1yNERyQkpH?=
 =?utf-8?B?SnJvQXgwbk9RK3U5L1puOEJ0L3JodXFRMDQ2Wm5GditOQlg3UGZWdVRWQ2Nh?=
 =?utf-8?B?RFFieTF0Y2s5akZoNVpyODA0ZmpMNnhTUEhLdVg1YlNoYXBldlVTTjNXeW9s?=
 =?utf-8?B?aTFGM3RZRktTTFRJcnZoMkI1Z3owSzF0WTZSUytzL2VhSWdZU1E0NE54eTd1?=
 =?utf-8?B?QTJNdzFnTGlQUEFVaTRrNTgrbzFEUnZsaktUbFRJcm44SHllWjR0T2tsdXhu?=
 =?utf-8?B?clIzSzVxa1BWa0t0Vml0UmVLR2JUVG0ydkZHZll2Tnd3dS9XekpTTUV2WjBW?=
 =?utf-8?B?R2pmUWh3ZW5KdmhmcHVNRWxBbnJ3NU9veU5hZ1prZ2wzRTN5RXVaYjdsNHN5?=
 =?utf-8?B?M2xXQ1hJVnJudFdpd2Y1Y0xhYXNZWGhSb2xraVV1cmJKV0pFUk5TamMzSVlZ?=
 =?utf-8?B?NnZJaEViQzRGUk9Jc0hNN1kxWWtTaFAwakpKR3Q1Z2NSNnpkWFZScnRES3pP?=
 =?utf-8?B?amJUcGd2QWt3amNMaUJkREdTR3ZIdjhNZWY3ZHNMNm5YRTNwdXQ1QjRvUHFk?=
 =?utf-8?B?Z1ZqMlNIT0g3by9oVDNYc3NEVWFzNmlieE9qeFViVXhqak9uL0c2bytBeHdR?=
 =?utf-8?B?SFU4WVZaTVp6cGpqVFhzb0UzU084MkFMdUJQMFBOMTgrcWFRZXlKT1U5Skx1?=
 =?utf-8?B?aDhKOEY5S0VTb0YyOVVUU2EvTS8wMUR3SXlOcFlPY2RRNzc1bkF2YVZZbnZF?=
 =?utf-8?B?YW9Zdko0Tm5Jd0NYb3dva0ljQnUrM01TbU9MZlpsajAyYXV2NEhxZjJMZDAy?=
 =?utf-8?B?N25UOEZMVUx4eDJXU2ZraWFSL2tSNjlFUEp4eHhncThleHc4QisxWVZyMW1G?=
 =?utf-8?B?czI5RkNXN1NNelowZEdkNHVGNXRUTnZYdUc1OE1pWmZUMUVRamN4VGtXK2RG?=
 =?utf-8?B?bzN1WmI2aVBoTEVBUW5iazk1czNuVVRwOTJyME5XYklSMlF6UTJFdyt0VVdW?=
 =?utf-8?B?VS9kYW9Xd3RuSHQwQUZaTDVob3ZPOHRsK0hpWGorakxNWTJEeVNtUzhGVVBw?=
 =?utf-8?B?Ykk2SmZvcE5lMXlLMjdNdGtRQzZHd2lpU0l0Q0R5QldGTTBWY3FxcVBWd29B?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD98F6C37BF2414F86188F29657EEFC3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251a511e-ca80-4e0e-86d7-08dac1e0e6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 23:28:11.6620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBW5upuM+mw34DGBCQelqohD9qY8NGMkzA6AdPJ+zyNITydE080bGnxrhfpWdjkhNXPuBaxfVUSxpwadLFLADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZvciBtb3JlIGludGVyZXN0aW5nIGNhc2VzLCB3aGVyZSB0aGVyZSBpcyBxdWV1ZWluZywg
d2UgbmVlZCB0byB0YWtlDQo+IGludG8gYWNjb3VudCB0aGUgY3Jvc3MtY29tbXVuaWNhdGlvbiBv
ZiB0aGUgYXRvbWljIG9wZXJhdGlvbnMuICBJJ3ZlDQo+IGJlZW4gYmVuY2htYXJraW5nIGJ5IHJ1
bm5pbmcgcGFyYWxsZWwgZmlvIGpvYnMgYWdhaW5zdCBhIHNpbmdsZSBoY3R4DQo+IG51bGxiIGlu
IGRpZmZlcmVudCBoYXJkd2FyZSBxdWV1ZSBkZXB0aCBzY2VuYXJpb3MsIGFuZCB2ZXJpZnlpbmcg
Ym90aA0KPiBJT1BTIGFuZCBxdWV1ZWluZy4NCj4gDQo+IEVhY2ggZXhwZXJpbWVudCB3YXMgcmVw
ZWF0ZWQgNSB0aW1lcyBvbiBhIDIwLUNQVSBib3gsIHdpdGggMjAgcGFyYWxsZWwNCj4gam9icy4g
ZmlvIHdhcyBpc3N1aW5nIGZpeGVkLXNpemUgcmFuZHdyaXRlcyB3aXRoIHFkPTY0IGFnYWluc3Qg
bnVsbGIsDQo+IHZhcnlpbmcgb25seSB0aGUgaGFyZHdhcmUgcXVldWUgbGVuZ3RoIHBlciB0ZXN0
Lg0KPiANCj4gcXVldWUgc2l6ZSAyICAgICAgICAgICAgICAgICA0ICAgICAgICAgICAgICAgICA4
ICAgICAgICAgICAgICAgICAxNiAgICAgICAgICAgICAgICAgMzIgICAgICAgICAgICAgICAgIDY0
DQo+IDYuMS1yYzIgICAgMTY4MS4xSyAoMS42SykgICAgMjYzMy4wSyAoMTIuN0spICAgNjk0MC44
SyAoMTYuM0spICAgODE3Mi4zSyAoNjE3LjVLKSAgIDgzOTEuN0sgKDM2Ny4xSykgICA4NjA2LjFL
ICgzNTEuMkspDQo+IHBhdGNoZWQgICAgMTcyMS44SyAoMTUuMUspICAgMzAxNi43SyAoMy44Sykg
ICAgNzU0My4wSyAoODkuNEspICAgODEzMi41SyAoMzAzLjRLKSAgIDgzMjQuMksgKDIzMC42Sykg
ICA4NDAxLjhLICgyODQuN0spDQoNCj4gDQoNClNvIGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkN
ClFEIDIsNCw4IHNob3dzIGNsZWFyIHBlcmZvcm1hbmNlIGJlbmVmaXQgZnJvbSB0aGlzIHBhdGNo
IHdoZXJlYXMNClFEIDE2LCAzMiwgNjQgc2hvd3MgZHJvcCBpbiBwZXJmb3JtYW5jZSBpdCB0aGF0
IGNvcnJlY3QgPw0KDQpJZiBteSBvYnNlcnZhdGlvbiBpcyBjb3JyZWN0IHRoZW4gYXBwbGljYXRp
b25zIHdpdGggaGlnaCBRRCB3aWxsDQpvYnNlcnZlIGRyb3AgaW4gdGhlIHBlcmZvcm1hbmNlID8N
Cg0KQWxzbywgcGxlYXNlIHNoYXJlIGEgdGFibGUgd2l0aCBibG9jayBzaXplL0lPUFMvQlcvQ1BV
IChzeXN0ZW0vdXNlcikNCi9MQVQvU0xBVCB3aXRoICUgaW5jcmVhc2UvZGVjcmVhc2UgYW5kIGRv
Y3VtZW50IHRoZSByYXcgbnVtYmVycyBhdCB0aGUNCmVuZCBvZiB0aGUgY292ZXItbGV0dGVyIGZv
ciBjb21wbGV0ZW5lc3MgYWxvbmcgd2l0aCBmaW8gam9iIHRvIG90aGVycw0KY2FuIHJlcGVhdCB0
aGUgZXhwZXJpbWVudC4uLg0KDQo+IFRoZSBmb2xsb3dpbmcgaXMgYSBzaW1pbGFyIGV4cGVyaW1l
bnQsIHJhbiBhZ2FpbnN0IGEgbnVsbGIgd2l0aCBhIHNpbmdsZQ0KPiBiaXRtYXAgc2hhcmVkIGJ5
IDIwIGhjdHggc3ByZWFkIGFjcm9zcyAyIE5VTUEgbm9kZXMuIFRoaXMgaGFzIDQwDQo+IHBhcmFs
bGVsIGZpbyBqb2JzIG9wZXJhdGluZyBvbiB0aGUgc2FtZSBkZXZpY2UNCj4gDQo+IHF1ZXVlIHNp
emUgMiAJICAgICAgICAgICAgIDQgICAgICAgICAgICAgICAgIDggICAgICAgICAgICAgIAkxNiAg
ICAgICAgICAgICAJICAgIDMyCQkgICAgICAgNjQNCj4gNi4xLXJjMgkgICAxMDgxLjBLICgyLjNL
KSAgICA5NTcuMksgKDEuNUspICAgICAxNjk5LjFLICg1LjdLKSAJNjE3OC4ySyAoMTI0LjZLKSAg
ICAxMjIyNy45SyAoMzcuN0spICAgMTMyODYuNksgKDkyLjlLKQ0KPiBwYXRjaGVkCSAgIDEwODEu
OEsgKDIuOEspICAgIDEzMTYuNUsgKDUuNEspICAgIDIzNjQuNEsgKDEuOEspIAk2MTUxLjRLICAo
MjAuMEspICAgIDExODkzLjZLICgxNy41SykgICAxMjM4NS42SyAoMTguNEspDQo+IA0KDQpzYW1l
IGhlcmUgLi4uDQoNCj4gSXQgaGFzIGFsc28gc3Vydml2ZWQgYmxrdGVzdHMgYW5kIGEgMTJoLXN0
cmVzcyBydW4gYWdhaW5zdCBudWxsYi4gSSBhbHNvDQo+IHJhbiB0aGUgY29kZSBhZ2FpbnN0IG52
bWUgYW5kIGEgc2NzaSBTU0QsIGFuZCBJIGRpZG4ndCBvYnNlcnZlDQo+IHBlcmZvcm1hbmNlIHJl
Z3Jlc3Npb24gaW4gdGhvc2UuIElmIHRoZXJlIGFyZSBvdGhlciB0ZXN0cyB5b3UgdGhpbmsgSQ0K
PiBzaG91bGQgcnVuLCBwbGVhc2UgbGV0IG1lIGtub3cgYW5kIEkgd2lsbCBmb2xsb3cgdXAgd2l0
aCByZXN1bHRzLg0KPiANCi1jaw0KDQo=
