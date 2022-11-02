Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0B615BF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKBFpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:45:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5390D6367;
        Tue,  1 Nov 2022 22:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSnUf9XybFs0+KhQGF0BuzbK9NY2j60wyfxSGpi8WZut9M3YuHstNpz3MnOjeJ+nbailKKyWWCEq9BMz8706SWI+72BqzMTDJJS8BYi+FwaGhNAwsVrISRyflnjPKPN79fKVlYSAAOn/f5c1DTQ6q3jGd9IUj+SbnYshMXBKSDahiSZaEZVEAv07dToTPfYDbAS0BC/SbevCn+Uq9HvKEiGlN1gcKN3TrqwtNLxrhSkDya4MLvT93F7Ye9M6eVZARJCAn3PramFOp6As0mea3gduOzc8dMWRXCDbAaQuReuzfP0ADWdWKsJvVXD+haYOv2g0cta7shcdegCIvgEhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4upA7G7n21uy1E+wqFkqNvwyqmz+EivFRJEbEFdQzo=;
 b=JVlGI4zNQ1PfQSKVMAIXcJlv4n2c/007Z/8hCY5149GhODjcLgeVT488vIX22uVLrdNEl2G+uOZqG3jZJng3DfTavF4A20RMXT6vJTO2hMZXDzJIgJKcvI/wKj7Fu5jPLXUmqYhSMczRkcWcoaFu5qrMIUIfqp6QS+ji+BB7vI+cLenMceXnYp3qQHcR66gVuTpMMSanrXmCV4lFql66Rb27kSsBp7E+UUXOxBe4ASFfQmgsUPDTAOKxouGRzNW3245eocM7Sqv7zvWmlOkg9sBs92DbUUqtxO8fLyNnkdCIXrFIno575YK+5oJ8enHCGPFQtWJY1/U3XeDA7AKQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4upA7G7n21uy1E+wqFkqNvwyqmz+EivFRJEbEFdQzo=;
 b=BS3WxP4UYD9KCqPlaZeGfhNJp06kr1nwFcxJj3QrxtCZfAlD3KegLS3q2GpJWihyMfb+C1KfCbndQEkmZAhA4oWnSd6VOZHahnFncQgPSZfWVNF7oKbDgnLnqTUKza21sOYX+i5gIYIb+7gxArUsmpRjnqw/SEwquI92qkFRBNVA2FOt6tRXAN6ma8C3qJ66EeegR8dVtOh980is5F+IEAJX3l4tH9yqfB5sJ8sIMwiGHrThnlj+KneR+7MHk3yqAyIF41BF1o/XK8eZ4kXXK9UfXXigBJIxzGaQbYkMFjMU+gGitltjBVQWUNnzPaNrXDVx9vIyoLA9nSLI4mBVLQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:45:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:45:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jinlong Chen <nickyc975@zju.edu.cn>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] blk-mq: improve error handling in
 blk_mq_alloc_rq_map()
Thread-Topic: [PATCH v3 1/2] blk-mq: improve error handling in
 blk_mq_alloc_rq_map()
Thread-Index: AQHY7mgWsgQjhOIPhku9C83UUCI/764rH86A
Date:   Wed, 2 Nov 2022 05:45:34 +0000
Message-ID: <ab4991d7-4b84-df91-db45-96f31d19a871@nvidia.com>
References: <cover.1667358114.git.nickyc975@zju.edu.cn>
 <bbbc2d9b17b137798c7fb92042141ca4cbbc58cc.1667358114.git.nickyc975@zju.edu.cn>
In-Reply-To: <bbbc2d9b17b137798c7fb92042141ca4cbbc58cc.1667358114.git.nickyc975@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: adf65c5b-c749-4e6f-ba96-08dabc95760c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o5MsRGiqnzg9WF5HazPvt7KXMKisaBRSSLSpxi94q7GYOXVnDLDzlAlwAYJ1MPl5kQRkkj90kzWpGcalMm8+KcFm0Kdr/zBl65mK3UT32DmEIvGSlCFwyUQs5+PASg6W9JoYA287tSKv2FriiEV6Sa1Eu9heJcIJ7CUAFLiXno8yPglkslIcitioyuFwaigMe5dvziNq/N/5JEA+PathWNCENefSJiizIYR4OoUSgEFWKSBR7iY8K4OKnKCE57WnhhNdEeE8CGIuRvUodWptcJqJrd2uHOnSDwq5kmY+PVAph8Yp96W3JaUT5JO028p3NXnpDs7V69FjuNTnKO8gOnLoY3qXX9tsAMkztk56n1PMgrVxi4+nDgLLeB/rmSFYjpseOUxe2voaol4LSwOdAZBh2B1IdXceZDiPJTUNaKR7KAgHMwPw1lu6WPF+ETR8YPtMsICfDpmman+dcIKdBIGvV2iKU9ucQ4zKCnaqJ4R+f7ER79u3bl7FIITTp/0vtB1MqHyaFzbdH0DDlNkBpc0btB1wc7HuA9PX6Qgdeopw9r4xIlEvrrkXqYkrNwWOjZa+uVG/Hfc6KugKz644GtgCw271jqUPuriWcoIp1Hc1KRdJpX0xvAA4+ZzmQdlvU4x/GPfwyTPLF6c6hA/cH9WiOFNTVYXT01I//4664Kx0DJd6HlN5bTB2GvB5mQ/yCvNhsY3CWSofQiG1naR2Q9uDxOCpTtoSHKEMPijIF/8GelXVoFl8ZfW4FBqZ/tYdULBwZceqDG/Y85JBOQkLxzhey4YQcZ86hmYHR1jLna0yxMvsz6dnhoWb0NTaHxZetsDye0hM3frOI0ZJCKPGFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(2616005)(86362001)(36756003)(31696002)(38070700005)(558084003)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEVqSmdxalRHd1VpcFBBY0hjQVA0WG1Fc0ZsK1dMb3gvNlQweHJvZzZ6akpE?=
 =?utf-8?B?bmY0R1VZaGxZdWxnakwySXc3T1I2c0FVbmZZWXJxQ2tnYk5MUHFzOGZmSS9S?=
 =?utf-8?B?dVJJUHZlVFFYTzJsOHV5M0EveGdDTi9UUlloNjdzOHVnVFdjTER5N2o1eUNM?=
 =?utf-8?B?L25YQ1o5SklkMVhYY3pQaEJLU3prQVRBcVoxVFBhT01SUGgyNkxDc3FOeDdR?=
 =?utf-8?B?eXhINWRnMVVJaFRabU1tRTBwS20xd2ZIMFdScHNTVENLczc4VUR2bDNKYi9u?=
 =?utf-8?B?a3puY1FBWEdOZDdPd01ackg3Q1RXc2NhSTBJakxqeUZuaDhmUVJGVy9CVDNh?=
 =?utf-8?B?MDQvRzIrM2NYQS9BVGdFVGM4cjR6Uk5Ma2JJM29BV29iSm9uU20rc3BRNDZY?=
 =?utf-8?B?Y1ZJUWY4SzNXSzhGYVorbXhpamhHaWpxcmNqcEtUME9Ra21rdGVDYWFoNVd5?=
 =?utf-8?B?N09LeXZzVGhGbXhVUzZGcWRyL1RwY21iZS9ZZml6ZzRzdXp6bDhHUjFiSGVE?=
 =?utf-8?B?dG1mRTNrOTBadkE5VHU2YjNLSktPOHdwZ1pIWVN2TkxId1hsWkF4Yk1RMEdM?=
 =?utf-8?B?dEttRUVlZ3NFT0lMUVhkdUg3M3ROVTA5VENOMHkveGRYZHJvWFFlT3Z0Ukg1?=
 =?utf-8?B?REJ0QVZuODJiVmM5NXBTcTZIZTNORnc3cnBqMG5qYmwyK1M5a2plWERidG9C?=
 =?utf-8?B?aEZTMGZHckZJSUZZYUVONGhYeFlkbnBjSWtxS2Q4anZXNHFUZElwZVNpcFFR?=
 =?utf-8?B?dXo5TVpjaDduenpSWGRmNTRHT1dYNUkyazFkZEVMZ3N0ZEVGNHpMN05pM3o3?=
 =?utf-8?B?ZitzaUZvR1labXU4MXlyQ2FHeGwxZjhsckpJWXZ6Y0o5ODNaMFRrTTdCSG4r?=
 =?utf-8?B?Uy9rRlZCRGs0NzYwcW9WTTU5aUh4TXhWb0ZFR21Sck9adThjNjVDUFZGeVk0?=
 =?utf-8?B?bHFkZzk1NTNMUGtaT01Vb3JobXR3SnE0cktGVHdaL21uRnF1eXU3RWduV2I2?=
 =?utf-8?B?ZUdjd3FqUW45RVhKS016ZFdZVWhoYXkzNithbk14RVppUUpOVEZsRVR0djBu?=
 =?utf-8?B?VEY2Q0ZWcHdycTZtTGJSNVpKak92V0l6SFF3VURLNHJYNXFURGRxSEVNREVI?=
 =?utf-8?B?eUNXNjZsUVN1UmpaTXJYd1BSbVJUMEFzcmNJYnF3dnBHRTJzeTlWVVl0NnpN?=
 =?utf-8?B?NWdsZGlSWFpkSzR0YnduVThVYmhsVzVDTEt0TkQvNUEzMWZVS3dFV2lmQUhi?=
 =?utf-8?B?c2VwWnV3eUxTS3Ixd285YWNmY2pKZ0gvT2d3S0VtR0dibGROYkJhNU5ReHli?=
 =?utf-8?B?L3M2amxFSGVWeWdWUmFHc2luN093bStBUDl3dkFxSEFGcmN6Q3lyNFlFalVo?=
 =?utf-8?B?UzRuVEQzNlNkaURaVnNMRFFkUmZIWVRnYjBVcGpEcG5ESHJVRWwwaXBiUUxW?=
 =?utf-8?B?ZGE1dithY1ljVEFqc3kwTzA1MzhHckh3cHprd0hwdmUwczFhc3N2SlU0cTE0?=
 =?utf-8?B?S0NnMmR1YkZVYmNFaFRoRTV5cEJ5MGlLVDRoSzlydFovL1BPL2I0N0xPeXNS?=
 =?utf-8?B?dUtUQTIvRVZwNzlkeXUxdTBNOGd6N2JhOFZGUTkxbTBWREY0T1MzK2xISWVN?=
 =?utf-8?B?Yk44eUgyRXlLRGE0WEw1UXEweW1mY2hVVHgwWHNReCtTZnp1OGw3WTNoMFFR?=
 =?utf-8?B?Mkh3djVYSDMxelZGV3FSNytCMGQrQXJhc0JLOXJuTk5rdTFmR1JzMXVrbExx?=
 =?utf-8?B?akdmOVBSSFJQMDFiWVhZOC9QN01jaEIvT1dROUx3VHk1NFRMa3RXdmVaWHQz?=
 =?utf-8?B?eDkwQ21uQ3B6OWRrRHY5d0VBZzdvN0tjQStWaTVQblhnVUtyNmFObFJ0Vjhr?=
 =?utf-8?B?UFRJczRIQSswczFMSGRPTGJFTVdhcGlTUC9Yd1hkWnU5bTMrZHZNN0xYMUVP?=
 =?utf-8?B?S0tSbzBGaTRRbE81OVZ2Q0IxTEtqUEtVSms1UWdnNEZnOUJiZk5sMkh4L0wv?=
 =?utf-8?B?UTV2YUNLNThJUkNwZjJiYVYwdGxpQnFvZDM0ZlB3dlk2RmdtU0hTb2RxVWFB?=
 =?utf-8?B?R1k3THNwYkJJaXdMVjQ1NEtaeUdOZms1c1hPbGh3NjFhYithMVBEUHQ5aUhG?=
 =?utf-8?B?dDJMUmw2Q2ZEMFo3NElaRC83cFhzLzQxK09ZeDZMdFZoODRUMW1CSFFjTGFD?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD59E1F10348C048B3A2AD573C71DB78@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf65c5b-c749-4e6f-ba96-08dabc95760c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:45:34.2572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4j4WyrPvaA5Hlqbs0C9ngE7DYlojmbilQjbNZWUaXfbrBVU2ZJgZ/v2kbj3w0er3inGH9vtXsIAQfjzmftLN/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMS8yMiAyMDowNiwgSmlubG9uZyBDaGVuIHdyb3RlOg0KPiBVc2UgZ290by1zdHlsZSBl
cnJvciBoYW5kbGluZyBsaWtlIHdlIGRvIGVsc2V3aGVyZSBpbiB0aGUga2VybmVsLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmlubG9uZyBDaGVuIDxuaWNreWM5NzVAemp1LmVkdS5jbj4NCj4gLS0t
DQoNCnNpbmNlIGFsbCB0byBibGtfbXFfZnJlZV90YWdzIGlzIGR1cGxpY2F0ZWQgaW4gdGhlIGNv
ZGUgdGhpcyBzZWVtcw0KdG8gYmUgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQo=
