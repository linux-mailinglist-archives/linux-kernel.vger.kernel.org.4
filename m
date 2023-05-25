Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE67109FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbjEYKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjEYKWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:22:34 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013000.outbound.protection.outlook.com [52.101.64.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA612E;
        Thu, 25 May 2023 03:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abTv3ZndeaPxUvtZcHXjVKSEyVMWg8WNKLJbhSZTCjxjNxuSBXW4Awmgc0FFXk5nHAbDxz/LLBUZGDj8MQSzyqrHSCbLgw6OTWCiUiSLQwEDjJWz/0w9nNX6AKhUmnMnDqS6HRI4lA49di2HQbE15xuSDSkyIISDKhxj4+SvINVX65c2ZuHjXtaJvrOA5dw8rgjkoFiIduWYyqIR9FjtFwzTRfKHMdp40ICGCF/IQfnZijSejpQdmpXzlE7cZblj+i6aMdlNdcqursE5JztsP6AL5Iil9B0GLdsxxEBfH97tyYxUfUslfU9YQwo/lLsc/yn4akKlsVZYyouASN+/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgTpXbRw1aexKijbWSBCLxoL+HEEYHvMAycWvlsPfY4=;
 b=NtMJ2B1AOlbq8Ay++VHVpKr6JO46gUrbDNslDcJC5Jlmk31V+7+/kSB0B9gRj2WllGMLylt0IsDcCn8DKQ0Jz8/u4+Tc+zmYcpYFc7Codzg/nmKf460fBJrEGyj0u/+eJ/i4xXFhbZXMopeIY1bnyC6zBSFdQ17JLGgMmJvuv+JyBM41O9WXVIgYGzIVVOY0+bHUnXEUyy1lMyZB5/Y7y0botdwApg9V1bg1VRZwOoUFisjkKJnDn4iQhmH7qiNDPsqYKbJqq/LvJEsd/5k6jO8Z5PC1JXppbGwI/tefV9NCyZAWDF2Fpv27RHrPwbrjquslmfk1D29a7MG0HLOX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgTpXbRw1aexKijbWSBCLxoL+HEEYHvMAycWvlsPfY4=;
 b=ns+kSGAtlFXFv2m3tRm923xDV4ohMrCGG9F5YJun4D2CIEd5BMQtA/+fdxpbDi4kNNmBR8keNAmtuTbdK5EjM9rKA1jPon/NiVtHVrwp4C9JYRUeDDP86rkO2e0f99LyiN4I06U5QYHrlQPzaxmnNTjQb8To0WA2Nd/25Ce7c/I=
Received: from BYAPR05MB4469.namprd05.prod.outlook.com (2603:10b6:a02:f4::21)
 by CH3PR05MB9505.namprd05.prod.outlook.com (2603:10b6:610:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 10:21:15 +0000
Received: from BYAPR05MB4469.namprd05.prod.outlook.com
 ([fe80::4389:dd0e:c4c0:eaad]) by BYAPR05MB4469.namprd05.prod.outlook.com
 ([fe80::4389:dd0e:c4c0:eaad%7]) with mapi id 15.20.6411.027; Thu, 25 May 2023
 10:21:15 +0000
From:   Keerthana Kalyanasundaram <keerthanak@vmware.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Makhalov <amakhalov@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: PROBLEM: Using Randomize structure layout GCC plugin doesn't generate
 proper debuginfo 
Thread-Topic: PROBLEM: Using Randomize structure layout GCC plugin doesn't
 generate proper debuginfo 
Thread-Index: AQHZjvKinGBIPkMZHk24RxGLcx7vjg==
Date:   Thu, 25 May 2023 10:21:15 +0000
Message-ID: <DF6066B2-35AE-40BE-A217-D3C48DBF6751@vmware.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB4469:EE_|CH3PR05MB9505:EE_
x-ms-office365-filtering-correlation-id: 7306f866-9631-498d-df79-08db5d09c577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaVlzDnMeC1UFAIf7n3/esI+vVdbGjcFKc7Deg7bwoo7Z14sgdUxMmmt2Jo0vqaoqrItXtEo64ZSlhoIa9hgM8/6KZlHIjzx5XXangBt672m8AbjnGqjub3SPtPrR7S9KYj1DC6CDnpkdk955iIJPCATbhpac0fw2RgdKWx3y7TgZFZNmga7t1SKCS73SRqrT6HS2rYKc8aJuCs13gsAAC2hJgZyOd1QYUFdoQGx+RglkgAGu0mX5o9TrvkAKx+BJUwAmz1fLU+wjMoBvDnBm/cxvTbhFJaTW6ep2T4lfA3t+CtHkkLrMszwlV9oMLDhohx7OT2xOoNrnR3pwj/mBB8AmqxXfvuJRbCqhn9jidL8JqlkSs1nrld6yn3grMloXecJcZjdF2bFYcxAaTFOIjmklThZ2dy8B5YckMSN6F3NdI/a4Hm8nj3M5IdxpAmsgu+8+W1BZIyeM8xOWSUmyCAQ4/DKrnic/A3wBJzZe+zOymDWwK8wxBeUQwEiYGqqqPl+nM+liL6K2xUfWiLoKMZWGOzq1YwMewrgkU58IBx6UAZQwI2AvthLljwhdW+Pj2w/RKZiwja8n7QmNOJJUUGmytPwlhqscQBnjQSWXE1XYWjIjfCEYQmseFcNT4+mFUwvEjsHb56Orc0MRUEQH3z2qzxlkTuM/Ba4tEaJ8ojocPXLeGgLLW3365fBJ48V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4469.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(966005)(91956017)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(478600001)(4326008)(110136005)(316002)(54906003)(33656002)(38070700005)(86362001)(36756003)(83380400001)(6512007)(6506007)(26005)(107886003)(4743002)(186003)(2616005)(5660300002)(41300700001)(8936002)(8676002)(4744005)(2906002)(6486002)(71200400001)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHB1dS92RXFBNktiRmJWSHVqZ2hDejJhNUlpSXUvVGR3ZWpka2pPeUZGRlpq?=
 =?utf-8?B?cGFaby84MkRmZ21HdVFpSjJnZ2FvTkROSWl6UmVKdHdrUnNqaUJTZ01OZi9t?=
 =?utf-8?B?MTUwMVFyVk45aVZQM28wemtWWFJqcFRkenpIYlY5VkM3ek5TcWVNSW1lbGZk?=
 =?utf-8?B?dHd0QUNrV1lEVmVVa1ZaYXhlbzJlSVpYT1RTN1hMeHBZU3ZFbVJ0WWhTbUVQ?=
 =?utf-8?B?WDdBejJlTEY2Q1c1Sm1oWGtMTDdzRnE4UVVucytqTXBCSVhKazh5cWFDQTRq?=
 =?utf-8?B?eFZqUjQvR1lsWVV3d2pPeFhZRjZLZzBUVUc3bzFPUmFXWUpTMVZoQ0FQZkcz?=
 =?utf-8?B?Z1p3TzFyYXQzV3EvZXhHWnJUWDY0SlVXRUIrMWFOMFA0K25Mclg2YTBQMFdo?=
 =?utf-8?B?NXhPWFMyd2Zjb0dXZE9SMjBhVEV1a1FYcmlXMUc5UDVqM1k2RkZ5YWFIcFB2?=
 =?utf-8?B?MGsyNVcyODBwVVVIS2pLOHhrdWNveEoxbFArL3FJaGFqNE4zYzRpaFkxU0hM?=
 =?utf-8?B?blNpVTIxaU1MUWxWRDVVdjZlNUdCeTNWZFlNeXZieW55SEpyNjdpQXRtQkJT?=
 =?utf-8?B?Nmd4U2o0emxVR2NPRUFGZ2wyVk95RkIvbmVhM25WZkZBWW04b05qZ1ZLL05H?=
 =?utf-8?B?QU02R1ZDQkpOWUp2VmZFLzNIWmphWWZaRWZ0alBUeVR3VzNreU42bHc1ZFM5?=
 =?utf-8?B?YUhXd21CUU1FalJzd0kwWEdiWWM4dXVVbXU1U1BHT1R1Kzg4cDdsNzJXek1l?=
 =?utf-8?B?cTlRcHpmMWhIK0NKRHpycFdpWVYyTFBEY3ZwTi9CNnM2UGIrd1dsVURKa0Ju?=
 =?utf-8?B?dGprbU5lcTRuQ2VoUmt5NmVad2p1aktPSjJzaVU4alA0ZlgzaHIwa3VZcUdt?=
 =?utf-8?B?Q1N1UHJvN0pDRTlKL1RQell6S3loMWViNUlkQXFkYU52cFhMcHA2SlNQY0w3?=
 =?utf-8?B?N3oySnVqUmZudkkyeTliSVMraFVSM1RQVWhOL1lLZytCVXBYQmFGRng1YW5T?=
 =?utf-8?B?NnNvT2F3SnVUcWtBcWlWUTUyajJUZUQ3aldvVlEzZTRlaWFtVGZPdHlLdHBo?=
 =?utf-8?B?bHo4QWJ1bGVpMHQ2bVZld3p3NkNCWk1rTVVDelp6QStxVU1BcU1rWDNWQ3NK?=
 =?utf-8?B?TnZyV3FTbFU0c3dXTWtueVlwVDlCZHJSOVF5VXFVeGNtYXp1U1RBQXBZRDQw?=
 =?utf-8?B?NFJnZVJWcjdvNTRDUk0yRDdaREdUTjZ4alAxcjB4TGEyYnh1RHFwUlZZZ0g5?=
 =?utf-8?B?Z3JHbnhVN0ZUUzdsSUpmOFRmQVpyMThPVEk4bUlqRVFleWhESVo2NXJpcXBZ?=
 =?utf-8?B?WVMyOTFqUnVMZjNqcXlkNDYzdWtQR2ZyS3ZZblNOa2JPQU84blhkL0RuYWFZ?=
 =?utf-8?B?T1M1ckE2a292MHFYdGMyOE9GZCtteGkvbGRoUE1KbFlEK0hOMHg1Z09lQm1L?=
 =?utf-8?B?L050TkQvUlM5R00rR1dtb3NmZWhCUHQyV0RxUDBOQUZvWU9XUzhjUThGWVE4?=
 =?utf-8?B?eVJtd1Zqcjk4aHArWkxZbklZVjMrVFdMd0JnQ0VLZkowZ0xQVGM2SWRXVnVT?=
 =?utf-8?B?RUtPMXFQQ0hnc1dod2hoTXkrYjBvUEUreWFXdnpRTWpuYVViUndVNXhGZWIr?=
 =?utf-8?B?SkllNU1VVTBvVHdQODN2c0JTYXYvbjlGSHBpVVMzQ1dNMWJyYm0yUzhaSHph?=
 =?utf-8?B?b0JOY1ZQdWMveFdVTzRQVGdrZTBBMTR0cUJrQ1lQTGJrN1Zya01sQ1lOdVlj?=
 =?utf-8?B?dithMnpuaTMxS2RvbjdhZHFIaUpJN3UxZGJVaVd6RjBiSmJzM3U0M2Vadk1Y?=
 =?utf-8?B?NVJHSTJ2WFNkN2VlSWlmYWl5dnFqQWtYUTZjME1JZGY1QVprR3gzU0pSMjNE?=
 =?utf-8?B?YSttOTlSYk1DYUhPQWtiZmtWM0hOOXNpdFZ5NTRzUGZLZkJVOWFzSWFLOHpu?=
 =?utf-8?B?MU15OXVIdDQ4RzNuaFhKOThxb2c1U2R6a2krTWFmNEdUYXl4NjQwUnJWQ1R6?=
 =?utf-8?B?WkZldjNNOWIrRFJqODhxV1dMNmgxdGZXUkZkejc5eW9lMm43S0tGTUxrTmhv?=
 =?utf-8?B?NlRLRmZYWDJGZEpXVDlIUFBkSkFqL0hFdTlucE0xcElXcWpvakpGTWVZaHM2?=
 =?utf-8?B?NWRZbGcwMUlZenBSOGNTbmVPTDVnckdJVmFkY1NBZGQzTWxmZVpFbDR2U3d2?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CFB84B21940BE4086D4C5A513BF582B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4469.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7306f866-9631-498d-df79-08db5d09c577
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 10:21:15.1637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2NkylgpjuB1qtJrJ107ADg+z94FdSWg/t+DqKwNyBL98ogLqzqKjmVmknrXfcNyWkPz3OLHFQb9pG26JQ7ViQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB9505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCknigJltIHJlcG9ydGluZyB0aGlzIGJ1ZyBpbiByYW5kb21pemUgc3RyY3R1cmUg
bGF5b3V0IHBsdWdpbiBpbiBHQ0MgcGx1Z2lucyBjb2RlIG9mIGxpbnV4IGtlcm5lbCB0cmVlLg0K
V2hlbiBJIGNvbXBpbGUgdGhlIGtlcm5lbCB3aXRoIHJhbmRvbWl6ZSBzdHJ1Y3R1cmUgbGF5b3V0
IEdDQyBwbHVnaW4sIHRoZSByZXN1bHRpbmcgZGVidWdpbmZvIGRvZXMgbm90IGhhdmUgdGhlIHJh
bmRvbWlzZWQgc3RydWN0dXJlcy4NCg0KVG8gcmVwcm9kdWNlIHRoaXMsIEkgaGF2ZSBhIEMgc2Ft
cGxlIHByb2dyYW0gYW5kIGEgc2NyaXB0IHRvIGNvbXBpbGUgdGhlIHByb2dyYW0gd2l0aCBhbmQg
d2l0aG91dCByYW5kb21pemVfbGF5b3V0X3BsdWdpbg0KZnJvbSBsaW51eCBrZXJuZWwsIHRoZSBy
ZXN1bHRlZCBkZWJ1Z2luZm8gaW4gYm90aCBjYXNlcyBhcmUgc2FtZS4gVGhvdWdoIHRoZSBwbHVn
aW4gc2h1ZmZsZXMgdGhlIHN0cnVjdHVyZSBtZW1iZXJzLCB0aGUgcmVzdWx0aW5nIGRlYnVnaW5m
byANCmhhcyB1bnNodWZmbGVkIHN0cnVjdHVyZS4NCg0KSSBoYXZlIGZvdW5kIGFuIG9sZCBidWcg
aW4gR0NDIHJlcG9ydGluZyB0aGUgc2FtZSBodHRwczovL2djYy5nbnUub3JnL2J1Z3ppbGxhL3No
b3dfYnVnLmNnaT9pZD04NDA1MiBUaGlzIGJ1ZyBoYXMgYmVlbiBjbG9zZWQgYXMgaW52YWxpZCB0
aG91Z2ggdGhlcmUgd2FzIGEgY29udmVyc2F0aW9uIGJldHdlZW4gUGFYIG1haW50YWluZXJzIGFu
ZCBHQ0MgZGV2cy4NCg0KSSBhc3N1bWUgdGhpcyBpc3N1ZSBoYXMgYmVlbiB0aGVyZSBzaW5jZSB0
aGUgcmFuZG9taXplX2xheW91dF9wbHVnaW4gaGFzIGJlZW4gYWRkZWQgaW4ga2VybmVsLiBQbGVh
c2UgY29ycmVjdCBtZSBpZiBJ4oCZbSB3cm9uZy4NCg0KUGxlYXNlIGxldCBtZSBrbm93LCBpZiB5
b3UgbmVlZCBtb3JlIGluZm9ybWF0aW9uLiBJIGhvcGUgeW91IGFyZSBhYmxlIHRvIGZpeCB0aGlz
IGlzc3VlLg0KDQpUaGFua3MNCktlZXJ0aGFuYQ==
