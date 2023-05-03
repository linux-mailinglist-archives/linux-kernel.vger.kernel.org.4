Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619A6F54CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjECJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjECJc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:32:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D84231;
        Wed,  3 May 2023 02:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAaxSADg6kqQACPbwezlfkhCV4RZNVrY3KHtYRriLnLyZPLgWRokTtZsl48oFghI3xF24bfFlPC7kiogNNcLOnjQFPAT92dtLtFNxOGoWTuf6UXL8v7PP3HAUpzSBnPeNUgzEd+xOEaNWZrGUOt/4JGR9zarScSYodMtHjJHB6gwxjSbZ/1ukP9SHQ8UK3qyLgM3QVUnxJFuQcFwNMX4byTq4NqT88746erkmzZparAfy7UYNRwHWVPpFd4a7NUpUb34yAF3MG5MnCedXCH8UTljmPW06HcGkvOE12hsV8Mz/KRD1RtwDPnKSeuJpF/gxPNA53TEhvRowKmE0c00qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AhvyUWPS9h78D1Vj8ckGu6fWZzm2d8l13hRP/hheHE=;
 b=LLrYmNi7xCXWs0c8YlXNngoH8Rb9KjVCh992UPZXzJyGN+0rmUE7ULXwqhAPbCbSGY7plbBLCXLLMsUpYs9frDp/VBqDXRmkPtjddpyvoI/p9H110dCTUs7DIgO9Auv3TBidw6bj6YWKvyME6zdBxmH1GG9Av3SRMxNJ8YVxw4S/9Fl/uJRSeWF7A05KALiZGPC0tPewgHKyLEr4qtJ6o4XqW5sQ4nAQo876Rj8mvx1GYY9BW7gTs7WJ4kkU5Y/7j2GKYiUh5c2CexY3j8xnG6tkWG2EhDNNJKsJW7h/eUIDcPKCAjBBKFfcBFUeL/wmijdTE7tylTTc/uJ20kBxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AhvyUWPS9h78D1Vj8ckGu6fWZzm2d8l13hRP/hheHE=;
 b=hO7DbXMAHWpww3gvJtLLJPQSRYJw/CdHTuEkg7dSX2uVHYkwoOl3GgcT5TK7EOwCNAmW4WG3RDzfFXeo0lxk221VvHitKOn5xcI/qHt1JkH4nnBK5RaEXDOPCepG6FBnCvfIDcdMdNgk1fbJYDIqr+PTx0gNlKzA4KQkYuHthx64xwcj0mlM533+37dl4ZbofXnRp9il4ADacu5IidXFofsQ1ambgVPn1CDMCjWvMVfsP06yNUx+T72YFZNz4skRfAQ/+rIiKUUqeH1nPo9T5nuPIybzP/JyxOXViJinhS/hAU5ABsONjlUMw0buh25YVSy7ctXsXIewDQAdq/16Eg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 09:32:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:32:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 07/12] nvme: Make test image size configurable
Thread-Topic: [PATCH blktests v3 07/12] nvme: Make test image size
 configurable
Thread-Index: AQHZfZW5xEUcYts9nEKue2V/AxvESa9ISUqA
Date:   Wed, 3 May 2023 09:32:52 +0000
Message-ID: <34a22b7b-a969-3455-ba53-edaeb1f2815d@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-8-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-8-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7130:EE_
x-ms-office365-filtering-correlation-id: e9e0732d-2c84-470a-4248-08db4bb95e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: twoPiI1f1jfYLH4vD9PerDBgtVt8j+ojxhh8Yw7XOiP7xqBJwS6gcRvPuVUuDnVpnCAhkL5NK1WuIzleGNrfaRJt9eE/PL7K3JV09nWuxo/wRk/MqqXfZ7K3Db0akQpa8dEgW3ePX23kiuGv3EbXplAa3SslHdq2MJMEIL0dP3nlK7p2Tv+SbTfKWe+7uHRWVy8nYQPSd4+N9yz+6tamYB2r0SoClZq4xrcclfpLW0RSwSjmTF8faTKkfp/cJ1hL+5C9FhNKAh0EWBGNbsRIjqXg3Ioa5pUfS7ITkEQZB6Jd3EtH5kLaQZAboOwl3a2Z5wVFnaEQg3fpuLaedH1CGnx/cEVf4RPd8rjYWgQjRRHOxwsVVneDzHvIJYe3ivzR7ZMYz/Yw3HcwMnRB0zjTS6Pc2YQcas1PiFWQHxcjwD+rPGAHNzywFmXIA+9s0Co8z90musISeRTu3N0KM+zd88bqvdvaip9nPlKASL3zvYpMsbMhjUy1oq8hVSFxEW6zWVQg+CVZ0Q1pJTLeJbtvZzAxD3vJ8o2gAJAzp7ufsKF4Jf6enbMsKjYEPX2jJ65PWJoqPa9E3jY9HHpYUxDEsU2VUab24AyPCmg6aHVIueXNQhcSN1IfCkVqpO8+/6E/F0+KffVB1l86/XtlVGyKMGythGrkpDm1TbCiPT8LITfzff1mCLpyd9ozQ55Mf95H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(38100700002)(2616005)(53546011)(6512007)(4326008)(316002)(6506007)(41300700001)(83380400001)(76116006)(54906003)(91956017)(110136005)(478600001)(66446008)(66476007)(71200400001)(6486002)(66946007)(64756008)(4744005)(66556008)(186003)(2906002)(122000001)(36756003)(31696002)(38070700005)(86362001)(8936002)(8676002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1lNbHpNaWJucG83RTBxWVRrcm5TN0JxZkF3V1phQlFydDBHc1lWRVk2NFJZ?=
 =?utf-8?B?SGRRVi9jK1lCQy9FbWF0Yk9ZdkVjTklrM1RqbHBVRjhmNjFHVGk0cXdaeUpl?=
 =?utf-8?B?dnRTWStaUnhLWk5YTGVXRlMwa1podXU0ako1NmJsQVV6eFZKeHBJSHd1RVQw?=
 =?utf-8?B?S2VZRnFNR1lqWUVMWFA2NGFDcnJaS2VjTmxlNnJQTFcrNUxlRW9DbWhHMXNl?=
 =?utf-8?B?cVZFNHVncFRkaFpGaC84c3Z4LzdmdlNhMDhJbzRsWHF4TTUxczNSQ3BkVWR6?=
 =?utf-8?B?eStsT2dJVUI5cUNuNXVwVmtXS0orQU5ubzcwOG14MUFiLzhFSTl2U25TeEtY?=
 =?utf-8?B?SWRGN0dGaUwySnZpVnM1bFlGbXNUNWtmVWxGMXJsMm9WWUpNMllUN2F1azB6?=
 =?utf-8?B?U2sxOEYyTUZrWVowcHpKLzZCM1MvT3o5blR3TTVFS1ZHejNwbE5YRUZvSjA4?=
 =?utf-8?B?d3R2dnFvcUgzZHg1Ulh0aHRtMkdnMVV6VmJOREVkcE05OTJDK2JFcHYyY2FB?=
 =?utf-8?B?VW44Q3Zqem5jWXBBK3FyWWdEK0FyRGZubGpGYzdQalhLQll0My9KUFlLNEY2?=
 =?utf-8?B?aUZuei9BT3YvT1lYRFAzd2FwM0hDeDlCK0JWR2pFRE85OGkwcmZhTG5LU2hu?=
 =?utf-8?B?d3dRRkh4c2ZOV0d5bUVBbis0NVJUa0tybS84ckYyR1RtcGkvTERqNHpHK0VP?=
 =?utf-8?B?Y3VNT0xldlJlZkxJYkpVTS9NazlRaG5ZbUtJV0JhLzZoVVFZNW16b3ZmV2Uz?=
 =?utf-8?B?MjQ4TTRUemlEbCtTRjNXQ2o3QWFPeDI1RFJYTzdRSHFFSEdmd093TmlmQ2ZE?=
 =?utf-8?B?RTNYY09RLzAxZkhORktPWkc4c1YwNkNZUUFRRVM3cHdDRzBZQUt2K1BPUjZs?=
 =?utf-8?B?ZUFqOW1JUUR3aDhhcFVvMTVuS2NsZk91cklqZTRxMkhsaGJ5S2ZVdkVESDky?=
 =?utf-8?B?UUpGRHRKTmsvR3JCSEJyR01mbzZpdzlqSlhXVFpKS2w2Szc5YTEvNmhjZVp5?=
 =?utf-8?B?OWNZRUpITVZaeVFIZjRSR3lQbzJ1SXNkbzdqRGgweTRTTFpwclAxZWducFA5?=
 =?utf-8?B?S3EyZmVsNHZWUUFPYzBBU1ZCRXJEZFNHbkRhNldvb2hITlhSdzJVSUhXYTBX?=
 =?utf-8?B?Z3M3NUJLMm1MenlvZWR0M1pvU0xRYU1lMlBzMTBJYmxoQnFWWTFVMUkwWWV3?=
 =?utf-8?B?dCtJSWpWSVVvUDBwZHorMU1zbzAvMFNjNTlZT1ZHMmVpZnZKMm1GbnRabDda?=
 =?utf-8?B?M3J1RkpIdkVTSythUkFDM29iS1NsWFVNQ3RtV1N3Z2RNYUk3MlovWFdNU1l1?=
 =?utf-8?B?bjlpYkMxUVlCeTN1d2Y1bzMxUUNBMks5UlZHc09wVC9hVFVEUy9FWXdWcGx2?=
 =?utf-8?B?L3Z2ejZJdmNBMGFVazE0RjAzWGhYRWdSWVBYa1hSN1pnS3ZTb0F4T2g3U0NT?=
 =?utf-8?B?dzVpclp0WFRZc0hkaXA2MW9uY015ZUVaWmdEUlY4bWo3NXo4ckRsVUtzcEgv?=
 =?utf-8?B?ajlIVmVqNURTcVUxQ0VZMjJRZldrVUpkMk94Mk01ZzZReEIxaVNSQVpaSGV3?=
 =?utf-8?B?QisrUXNiakNnRmpTU0JtOVZ3blRuSVhwakRCSkxBbVloQXJUSlBFQzArQitj?=
 =?utf-8?B?TTdoQ1A2YWpUQXpsK1VjRW8rNExtZ0k3cTZDaThzSUpVakZTS0Q2cVdZOGox?=
 =?utf-8?B?d0NyZG9NeXY4ZXRoem5yOVloZlNsZVRGMCtUR3FiWSs0OWo4Nk1QUm52Vjgy?=
 =?utf-8?B?and4WTdrZUZxakpINDg5UU13anpUeUFha1Q5MkRiWGtqZ3VLa1Z3cWR0b1VD?=
 =?utf-8?B?U01qaWR1SytPNVowVHptUGpFZGQzbVM3MXQ5MkdGbW5udlVIQzl6Q2NmWXJ4?=
 =?utf-8?B?YmNha0pFekY0YlBnU2NxMTVZUkp4d0pYYmMzTFdHS2lMUndhMUZjR3lJQlhi?=
 =?utf-8?B?Y1hpck53WVh2MWFKYUs1MnRVQnBkZjhDYXNSODJwUEcrU1kvcW1yc1Z6T0oy?=
 =?utf-8?B?WS9nY1c1ZFZCdklvbVVRSjZWb0NZK0dsalBNaFFSU3ZpdTJQZzF1QjNla2Fn?=
 =?utf-8?B?Z0JJSkozV3FIdStvUkpVRElUUGl2UFlwcVB0ZTB4eWY3b0hFS3k1eUF2UG9M?=
 =?utf-8?B?UXpRSXMvNnZ3azRTaHhDRklhSSszS3BBZSt6VkhDRmViUEgrdmNScHJxNDNp?=
 =?utf-8?Q?JVCTB/ClZyGCAI7NoMPwRg/G/gmi5WvCURd2FKdGK1SL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <933AD459270CA84094084103E00D5627@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e0732d-2c84-470a-4248-08db4bb95e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:32:52.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwpPhqUaXkMgrzQUAyHxNu96ZZyVS0/yr9Q3KTdwTGA6knu6mDY/LTP5dUSSKVzdIEKUI1YX3iHsYUmC9Yh4Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBUaGUgcmVkdWNlIHRoZSBv
dmVyYWxsIHJ1bnRpbWUgb2YgdGhlIHRlc3RzdWl0ZSBieSBtYWtpbmcgdGhlIGRlZmF1bHQNCj4g
c2l6ZSBvZiB0aGUgdGVzdCBpbWFnZSBzbWFsbC4gRm9yIHZlcmlmaWNhdGlvbiBqb2JzLCB0aGUg
ZGVmYXVsdCBjYW4gYmUNCj4gb3ZlcndyaXRlbiB2aWEgdGhlIG5ld2x5IGludHJvZHVjZWQgbnZt
ZV9pbWdfc2l6ZSBlbnZpcm9ubWVudCB2YXJpYWJsZS4NCj4NCj4gUmV2aWV3ZWQtYnk6IEhhbm5l
cyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVy
IDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIA0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
