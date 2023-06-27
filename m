Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7573F340
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjF0ETq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0ETo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:19:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02827CC;
        Mon, 26 Jun 2023 21:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vaz0OpMDDPy7OvoBGq3yCbU/k/kKKSsVRHS3rKkci2EduTcfeznwp8Fi8szYRqnl6pFRXi1ckMT+dmOgNB+a3Xhi4wcKc7df5uf+9eCxPRauT/dNG25paEE4FvZ0E7npdeRA5v5NULro3DzHaSTqbtqG0qYFUsVdoYtnhs36Ez/fCAi+4HwuEdXMwvkfJHkgjtzbn+qAoQOxjVk3cZdABAhsyLv9itrwltDspH/VIopRfBhCLj9MxUb7BwDM9G4b5sxdpdFlSHRWggCw9clRTzEc6Mvw0RVJh84A5soUM7QTRu7Xj9IwAqPU7xe52e5Ht1wgCQcu70+UZfZsDftRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsVNa8sYP2wmEVaMv9b5HZrg4OtLWuEWc5TDK+fkGO8=;
 b=W9U1eoF6pLh0CHL8e1zJn2/4x6kCZeUfhVYC1zr2dMbLWb/ZM1jB4c+Iz2wmKzPEimuvQD36J56CbGJDAZeZ0PddveVgXATvpT6e3DKN+HPl4WNoCarvExYKTrnq816YmFbiG8vQA+AJJoT41FXy4s30uEa/Ol5v7IJdOhOaPOb7wm688FfKo6MqEiu1idee2p+s+kOE+BAzLptc3zSZedOkZTrZ4MFp2AtyZcSb4juLWs7SJlxmfFIpWM8/cbRCWMbyhPBKa/keTarfJ3mKPdinFJvKn4p/5v90NiUHYcSDPIJZpSGu8LNV+a48IjUKsmPBatc5b50CNUhALPJ8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsVNa8sYP2wmEVaMv9b5HZrg4OtLWuEWc5TDK+fkGO8=;
 b=kpxjZBnadNTGBnRNCpQesSTytl+r0X8gU6xNubCGfBX9bBe37rsJMiWF2QjS8PPJCy3vygLgd/nQL/UdH1RPuGwM1+gDkb81l4a2LqjyT+qVllHpgQW7MJeYUNRzIZPoFYfn8WI31PB6qJYZAu7xyTDHbLkg3QIGzZ4YW5NY0vytSX4FL+1DtuyN94bz/9tP1NwVjng0K1Q8OYtwn4bOM+eYpJ0yncpZ7wq8xhpFbcSHxaMT1JlDmsKBIeoWmA7t0R6dqRs1Z5zkGGTwgGrAczuDVDgCEHfr6dOD9OGGPMQ0uG4B1B1gIt6TACbpsK/KehstgL9jZCBhUb9RvkCL7A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 04:19:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 04:19:41 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Min Li <min15.li@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "willy@infradead.org" <willy@infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Thread-Topic: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Thread-Index: AQHZqKcpte38flBIGkCEyHq6I+olK6+eC+IA
Date:   Tue, 27 Jun 2023 04:19:41 +0000
Message-ID: <f7a3329f-b66e-1de0-a455-faa29eb214c5@nvidia.com>
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com>
 <20230627110918.7608-1-min15.li@samsung.com>
In-Reply-To: <20230627110918.7608-1-min15.li@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB8610:EE_
x-ms-office365-filtering-correlation-id: 0440c20e-c623-462f-0b46-08db76c5ba66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hfI4tNUy+YmqUOs0P/lUL5eu9r+cdgGASQQ43aKiQ6/6HfHO8l3bMqdN9VKLdynNzyh8+8V6cCb7xRbI3KCs6Vd9+eJb/paUAr0+LZkcRhYFAONCcpzWNpE4eqFX+le/ZQxcbq4dap0DiikG2IF3Hh6B/yynDttKXRHgmAdMI0ilNusf68zqpxQYBx0lwavocbAFYkaexPV/NYIrCqaNsy5voGkpiEVJNRGdPWRC0D7PuUaCDZPFVuzqk3M0FlFVPxv3cPcuHEPVWGs+4ZhZ8reZhJUnOrl+6de2bESFo2l33574ECGbxg6B+CMB+hAi7R955j26kPdz5unsHLkpmGnYfRIYydtxUIjemc4aL3IDtqpGOeVycdM0ua8bj3CnuYJVE3FM5DOMALkcdy2lHvZjuh0uHo4HmBvhnzsB2b8lxHpnM2reKRQIt1WJ2RgRUQhMrW1EqttXgePEwYWKtFvjQvWFHjla3FtDKDR/0ZvaOiQvkWMSEiLKllAQPqruZTwTdt/egBJy69wWBDm5QNPFFsf9bo8PmCuwisrCQEjWsi8ZA4dKFx4WmywNnuJPRMpw+Pb1iZqEQNhh2XbEYZFchygsmdIuIxb629T1iJYezl9cxHeePtRAV11eAtezN7QOp86wldwNRGv8T88cW7ZPkHwzKNYAh4kS83W0TqaD1oBvYp4PZPZhUXgC2k8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(31686004)(66556008)(66476007)(38070700005)(122000001)(5660300002)(86362001)(8936002)(41300700001)(4326008)(8676002)(316002)(66946007)(76116006)(91956017)(64756008)(38100700002)(36756003)(31696002)(478600001)(6506007)(53546011)(66446008)(6512007)(2906002)(4744005)(186003)(71200400001)(54906003)(83380400001)(6486002)(2616005)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTd3R3VXTmc4blMxRmNVaFpSd21nbjRycXhwTEJxUHVMRDQ5ZFpxZ2tiZ0dk?=
 =?utf-8?B?OFkvdGFqYzBBWWRoQVBSWVgxMDFGZTd5WE1kQm9vSjh3VkM4NnVZckR2Nk1M?=
 =?utf-8?B?WStHSjVCZDdsM0RYUkVqU3BlSzdWdVJ4K0R6bmRoeWIvSkxtK1VOMDg0QnhG?=
 =?utf-8?B?YjdvcFpiVjZ1UlgwVnpsVUE4cXRBaGxrd3dhL0FveXpwUkJhUVl2Wk5qMG8v?=
 =?utf-8?B?aUorYlBBdlZuMUtUenpOcmdkVVVsenZXQXFWTHNKYlZLZVNaWUhzdlAwZTBx?=
 =?utf-8?B?cDBORmR2YU1xOVpDYmhLMi9OMGJrV1F1OThJOXB6VCtIbnlHbE5waW5MRXNk?=
 =?utf-8?B?bk5mVURycXhCSlRpSjZub3NiUVdKTDRaQkl5SWlhQkx1STF6NE8xQ0d3WGk2?=
 =?utf-8?B?bEVQUGpENVJsTmhpVm9Kd3hUcFVhSlA5eCsrUzNacUVmcUd4MU5xYTM3T1VW?=
 =?utf-8?B?R2FkcExianNpeVRwM2t3bkxSdzRFZ0hSSDlnUE40d1JYTElFS0d2NkVSU0pE?=
 =?utf-8?B?eU5ONGFHdmdRTmRIRGdid3NpM2Jwd1JTdmIyb3pZbk8yaWJmTC9sdUhTQzFT?=
 =?utf-8?B?OXpMRHBwZmN0Lzh0V1JvOFg4TUVQVFhyMGdiaThCQjNmT2NLelNXWXdYRWJl?=
 =?utf-8?B?b0ExNFlVa01la1JOMllzclpLQ21RS09zU1BaWlhuTEg4Y1NxV2V6RFdHbE1K?=
 =?utf-8?B?dCs4S3ZXUWZzdHZUNG8wY240SUdjcjNhQVBNWngrYVFtWElwK0ZROHc0VlN1?=
 =?utf-8?B?N3c0a2dkeVlhWjJja0hkSW1rWHRhOTBVenI5aFFZR2YzWXRDeHdCTDFIQjFR?=
 =?utf-8?B?QzRiTVJ2TmNYQzhCNGNIUDZhZFVNYkdnQU0xVlFRbEM4Qys1bk53U0ZrWDdG?=
 =?utf-8?B?SXRMSk5SbkhBY2xZR0VOelBSb0pkQSttKzdoaUpDME15Y0RyM05Cd05yMUNz?=
 =?utf-8?B?Q09EdjJmNUpENTBZUWR6TWN2NHpNU0FmMUpvWlEyTWtnUGt5MXVCZWlLdEkw?=
 =?utf-8?B?dlV6N0JIdExFSTRqc0ZqTjZITGVuWDNrV29jQUI1MnRNQmRnNUZ3YWxueVVV?=
 =?utf-8?B?eUhqbzh0QzNsMnhvT1JlTjR2NXp2bEZOWldxTlhGNHl6TGhweU9jS1pRUkpX?=
 =?utf-8?B?UXNRVFNaZGhiakhTOXRta3R3Z1FvcXNMTzN1Ny9jS2RoUGtOSTd0SjFFem8x?=
 =?utf-8?B?UTd5aXZ6dFlRenZkQkFRY2ZSYzdnWW9RQXA3OC9RK0NHTno2eHQ1VVZVUHFi?=
 =?utf-8?B?VWFwKzVSREJvSC9wV2V3TnB5U2R6Zm1ob0k0UXNQak85MnVtdTU1eU10Zzgw?=
 =?utf-8?B?NFYycmpNWnpZbVFNMHdRMWR0UCtQYzZSeGNEVHdxQmVyaERtZWRxU0ZEZERi?=
 =?utf-8?B?ajB4SnpYeFNzZ0gyYUFEMHk5aWJLUVhsZ1NCbzlrVGtEbjkrdTlXUE5SbE9G?=
 =?utf-8?B?YXNEUGYwTTl0TmlDdlQzOExYV2RIYlZZZExTUFp6Y3B3aEE4MWJiS0piVXNC?=
 =?utf-8?B?V1lxS3NocEZQQWtXRHhIQkF6TXBsK3FvL1JpQVlQajV5VEVuWDdnYTM3eS9i?=
 =?utf-8?B?RVBMeWQxQXJVUkVuQmIzMm01aHM5dGx5bHo5NUZHbmh4WU9kbEdpaHZPczMv?=
 =?utf-8?B?ME1OV0JXTXJlZ0tkbWVSd291ekpaak5YRFBvQmc2bVZKTHVaTDQ5K2ZTdGdW?=
 =?utf-8?B?RFFSNnovMFprdXVlYjRMS01OZjAyUlpLYTRWOGpLWmh0dWpmbS9FV3paT1Ns?=
 =?utf-8?B?dVR6M3BGMTBVb0JsalBwUHRUSXRxQ09BUVRIRXEzYzVHSko2dzU1d1RGN2gv?=
 =?utf-8?B?Wm9Hc0ZIQ1BxY0RLZkUxQjhVb2RyUGJHVmdsSDlJcWJOcWVwNkFMck5uMGpS?=
 =?utf-8?B?eDEzNm5Nd0lReTZGdEoySGViQmJhSGlQWUtKZG5UWTMwNzdxeWR1VnArWEVD?=
 =?utf-8?B?QW5kV2M1OWJKWU1pTkZNY0NyeGMvS2t1RlhKMjBhdWFvUnVQZmVFZ253bW1o?=
 =?utf-8?B?UFY2L2xybVdrTFR6bW4yaTJKYjdUNUgwVDZ4ZnIrM2RPYlRNNFpIUTNUeENZ?=
 =?utf-8?B?N1NKRE5YL1dRWnU0YitGRlEzaThqYUR3MDBaOGx3UW11NGZxcTRJSHJ4OTI4?=
 =?utf-8?B?ZndCVVkwZFo4KzRGQkVEZFBqcTZsNnZzc1l4cUZVRlFwbWJnY1VFZHlaYnZ4?=
 =?utf-8?Q?qFbCnA6ss4S+cMoClI0nYR7fngsvUZ3HoCbrSPRIn9JM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <114B60E140F17545A4087C39E8A8400C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0440c20e-c623-462f-0b46-08db76c5ba66
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 04:19:41.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1aVhKOYNmKB+spHcG9bDyKIghndPX+HxFnihAtQuNHq6z2DFugyXHbgi5+IjqEAWXRYWI5l8AIojDORr8NWkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yNy8yMDIzIDQ6MDkgQU0sIE1pbiBMaSB3cm90ZToNCj4gQmVmb3JlIGNhbGxpbmcgYWRk
IHBhcnRpdGlvbiBvciByZXNpemUgcGFydGl0aW9uLCB0aGVyZSBpcyBubyBjaGVjaw0KPiBvbiB3
aGV0aGVyIHRoZSBsZW5ndGggaXMgYWxpZ25lZCB3aXRoIHRoZSBsb2dpY2FsIGJsb2NrIHNpemUu
DQo+IElmIHRoZSBsb2dpY2FsIGJsb2NrIHNpemUgb2YgdGhlIGRpc2sgaXMgbGFyZ2VyIHRoYW4g
NTEyIGJ5dGVzLA0KPiB0aGVuIHRoZSBwYXJ0aXRpb24gc2l6ZSBtYXliZSBub3QgdGhlIG11bHRp
cGxlIG9mIHRoZSBsb2dpY2FsIGJsb2NrIHNpemUsDQo+IGFuZCB3aGVuIHRoZSBsYXN0IHNlY3Rv
ciBpcyByZWFkLCBiaW9fdHJ1bmNhdGUoKSB3aWxsIGFkanVzdCB0aGUgYmlvIHNpemUsDQo+IHJl
c3VsdGluZyBpbiBhbiBJTyBlcnJvciBpZiB0aGUgc2l6ZSBvZiB0aGUgcmVhZCBjb21tYW5kIGlz
IHNtYWxsZXIgdGhhbg0KPiB0aGUgbG9naWNhbCBibG9jayBzaXplLklmIGludGVncml0eSBkYXRh
IGlzIHN1cHBvcnRlZCwgdGhpcyB3aWxsIGFsc28NCj4gcmVzdWx0IGluIGEgbnVsbCBwb2ludGVy
IGRlcmVmZXJlbmNlIHdoZW4gY2FsbGluZyBiaW9faW50ZWdyaXR5X2ZyZWUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNaW4gTGkgPG1pbjE1LmxpQHNhbXN1bmcuY29tPg0KPiANCj4gLS0tDQo+IENo
YW5nZXMgZnJvbSB2MToNCj4gDQo+IC0gQWRkIGEgc3BhY2UgYWZ0ZXIgLyogYW5kIGJlZm9yZSAq
Ly4NCj4gLSBNb3ZlIGxlbmd0aCBhbGlnbm1lbnQgY2hlY2sgYmVmb3JlIHRoZSAic3RhcnQgPSBw
LnN0YXJ0ID4+IFNFQ1RPUl9TSElGVCINCj4gLSBNb3ZlIGNoZWNrIGZvciBwLnN0YXJ0IGJlaW5n
IGFsaWduZWQgdG9nZXRoZXIgd2l0aCB0aGlzIGxlbmd0aCBhbGlnbm1lbnQgY2hlY2suDQo+IC0t
LQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQo=
