Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E376CB18A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjC0WS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjC0WSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:18:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CE30F6;
        Mon, 27 Mar 2023 15:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3olSdWPVKXkSrAn3n5hRpcxd6Y1w4RcYAiFnZztCKiMu/ybXSvLud6Ty9DZETuRw2XDPquG4oHbz0vjmbEowbREjgJZUyJSYfmN9A9I0dEeSG/OTTTixnba1qrN1dShhAdgBiPm+xRJsF5ZGVnFkZ6LWzkf5KZXlZVq474q5vGNuNEZ33WGjr5jRA/AJZ6qfewqsZS+KbBb93kX5jldXGumavw6h6WIA8pU71xpdVKvFGjknWb4qBd2i8zgCu0arUULOdzJyLCb9DSiKqYjyamJUV8GHCPmpThBpAXq/FtsTmpy0XGy7uclWSchMZ88SEryHejOOV5NtmDDOJSYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNoWzTfhhYTrsn1ZLNUPmTSVSsetZVgkvdXu/wtMqkA=;
 b=UGB/XinLArlc1yvQdTw2P5VI7EXK+rQfeJLXzlg333RsGOHlP2fah3Jcl0ZUvptuv6PgZyj/1J4qykmogAUTlgAV8+ONCFFxBbUYsWZvsl1Rr7HCST05WNRKKlRJsLqVNZkKmWDrIkZ2wevgqNQB/esxllQhGuZZIhN/YsVb3doais9DCtHScdSRr8D74bgY4ZDelaGmuOjaOEaeNqgMG1T02MP7ORdQULyDCpuT2ZXDbG4+N7WsnT8RhQc6MDaD7hnSCYmvpfyRZL+GgXBjcMFdci7jStkc3Z3hqnzNPNjR0VGctSOSeD83c4tyb93RLLLmg3gk8b7lp6YrIGssbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNoWzTfhhYTrsn1ZLNUPmTSVSsetZVgkvdXu/wtMqkA=;
 b=kFY1wvNp5fLIeKmf2qSk2ySMYV68sm/roQ/0Kg9iB3BvdZFcMJLxArptKflegWKB6JsAWHmZbcPfvupkxsEEfwxtB3Y+pGqbryP2x5OvAA+QiAnBI6gt+YFkOzZd4p9oDrW/UhlsqVioj48FQ0PjBRaTAuUd6J5M2VwLxzMe6TWnayZG+7/eoJSqXIwzKS+YMKumrwS1BWYsbGFW625hp5xeaYVILYWBTi0N+wU7f0dw4sWQ7tzXz+ZLZFspbywDKf8GLMlLOfp2GgBxRTu6TbcvMKkgbtpVToOVnQD+xY4g2i8ACr9E8+gVs0MXU1pszoawOXVxxLjLXQzMg/B9AQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Mon, 27 Mar
 2023 22:18:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 22:18:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] block: null_blk: make fault-injection configurable
 via configfs
Thread-Topic: [PATCH 0/2] block: null_blk: make fault-injection configurable
 via configfs
Thread-Index: AQHZYLnANNT5PxXPFU2+UN/FEKery68PMT4AgAABYQA=
Date:   Mon, 27 Mar 2023 22:18:20 +0000
Message-ID: <7c00f4f8-5bdf-4fa6-d9f0-141cf88c9ec9@nvidia.com>
References: <20230327143733.14599-1-akinobu.mita@gmail.com>
 <ZCIVBNjrmLqvcGBi@infradead.org>
In-Reply-To: <ZCIVBNjrmLqvcGBi@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CO6PR12MB5441:EE_
x-ms-office365-filtering-correlation-id: 73955fab-c172-433b-43ea-08db2f112c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1k/t5DHeDUAOh5Apggz6ymvthlQxi7XSS3c10noikPhHJNYXilV5dmaCAh2nzS3gfW1mCv/6efuzJS6Stv5MwTG5Gv4dH+Ut0DsOUFDltEYc+eaQhVUiR4Aj4h0KyWC3wg5DYtkzglbcW4kh3MXmtONyf/WlKr8ETeccqdqzfECYjwyVDXQAebJRgYszSafqNk9Wg19796tOKEh1HRQ94duXibGf7M9a4dUw91Oup/GW7Qr3LYmFkIBusCNXIlod0z1Tq9wBlOH8PCKi6PS06iKBVftGqmBmDOQ6i08TxgH2+Ggvk8hmBvfDGlHG75W/3iDDkq/MLpuRyeL6HuxWExw98qUL+3nI7eu4T3NlndafKmFQQuBbH3HG57EDXGESUXZSzJXAeP5XoMWt9Xm/bKkZc45FoFK2TC6sXl02LBEn0dh8dfdIOICYPNibOIppsLdgaA8g488Td05+Sv6Pp+OiWR1d9XI3YX+VhANMTjlVrhu87dFlusmGEL2tLHTB3yH68rPgu3phIBj5YHwpcUu4dfcu+VprbH4Iu+94vRMF91V7rO7sM1oMu8m7bYPwdI43wNtjBeXdzWNngu9RxBk+9Hr8YSqWW8HSkVZPGQ16IidXPJFfav/795DWPZSVJlv3a/7iKxpefwcmGsXAe5ioCcO0vKU0oyNTMKcR/QlDL+4ToMu/pKhbt1yu8yi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(31686004)(2616005)(91956017)(83380400001)(41300700001)(31696002)(36756003)(86362001)(5660300002)(38100700002)(8936002)(122000001)(6486002)(66446008)(54906003)(478600001)(71200400001)(76116006)(64756008)(8676002)(66946007)(66556008)(4326008)(6916009)(2906002)(66476007)(6512007)(38070700005)(53546011)(4744005)(6506007)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlhETDlGQ2x0b05ES3FpQWkxdkhmc1ppaWlSYzB1SEVZS1RBRnphRGxCVmVK?=
 =?utf-8?B?UFVNekZkRmFCcCtUV2FKS0haVjJtNldJZ0Rpc0V3bG1tVVQ5c2FpZm0ybU54?=
 =?utf-8?B?VDRzanRtRjBjZkVHQnpCUnVQd20xbFFTNGM3U3FqK3FpanNrcFNjYlFueGc1?=
 =?utf-8?B?S2FKclAvU05RLzVQMCtVVE1BNG1aZW5CYmZzTStVeld4RVhIM2kvUUpJZnI2?=
 =?utf-8?B?aHc5Uzl5WjVqKzFCb3lQeDJuWllMOVJmR0g5cjFiR2pzTUdaa2NGUnVxc3JG?=
 =?utf-8?B?enZTOEx4VWdFbEdyYmxyMHo4U1ZsZElReTMzWDJGSldFZEZXek5Zb0tJK2Qv?=
 =?utf-8?B?bkJZTjVKV2JUeWJwdlpKYTRDYWhHeVZSSVF2YTVicDlBODkxSXphSFRHbElV?=
 =?utf-8?B?bEFVSVNaT2lkVk0yeWRRczk3amEwdHlPU05IK0ttOVJHLzVBN05pajNTeUtF?=
 =?utf-8?B?M1RhV1hidXZYVmRxdlBLS0ljY2h0MTc3T3I2U1I1MXV2MitsemtHdFY3NW1P?=
 =?utf-8?B?ZXdSbUlzVlBVYVViTWYzdHdkY0puQi9vaHFZVmxnOXdhMXZOSDcrQ1Z3dm03?=
 =?utf-8?B?VWdyVmZuVmxDREE0K2lwbExjMzY0eUY4T1RQMThkMEhXa0I3Q1RkL1JGUXdv?=
 =?utf-8?B?WmlWVTJDeWFra2xIWFBnT0FwRVVyT1NtL2k0WHN0b09FTkpFOEtMdmM0eElj?=
 =?utf-8?B?NG9qSm04bzBKSCszN3kvUmVSNW56aXVuQnFVQmI3Y1FvNzkrRlhLWlRFcEZI?=
 =?utf-8?B?WU1ZZXE1RnBMN2VqVllFM2xWb2EwNTRKcWNoQXFiMStTQ0FZZWF2V3RLRnIv?=
 =?utf-8?B?eFRTeUF2SEIvWWVDcE02WVVyeVVITDFSN0YwOW0yL3BQaGJ6aGx4QTFJQXRC?=
 =?utf-8?B?R3lEdk9hZmR0NTQxTFA3Z0tFTUYyY1hlZ1JMSWp5NjVSc3FHTFpjeHJHVFAv?=
 =?utf-8?B?eXdUT0hEZkpmVHNacEV6Sk5BTWlpY0NHY0o4L241RXlweUF4TWwzQ3FGOXV1?=
 =?utf-8?B?dkFFNHBOanMwTkVUTm4vaGQ4enkrZzgrUUwwUElaSUlPbHBsRzFaYUsxUlgr?=
 =?utf-8?B?ZUhFdEZqK0tjMnV2MjF6cmlRa21haDNnMzU0aVNVMmNpUE9odFFNZWIyaWpG?=
 =?utf-8?B?Y3FwdmgxZ2FzNTJVdjFOd0xudmlYOGoxRzgvT2dWcXlIend6SDlPM1JHbE0w?=
 =?utf-8?B?R1g4UHJTK1JsWFlJSWFwQ1NkVmljb0NOVHpERGljWHRiVmM2RmMreU13MU03?=
 =?utf-8?B?dG9uZGJyN2tOMFNNdWRDMWpodkx2M0ZVNVNvNzBlUUNuN2ZacGVxcmZxZXBs?=
 =?utf-8?B?R1M3UUlxS0J0TzVZczFTZmNwVmxjRDVsYkNLZEtDeUVMd0J5UWxldWFKbzJX?=
 =?utf-8?B?Zk5adHo4TkRIcVd2T2NWdTdTNG01RjRGQVZSY2MvSlZWZUF2U0R2d1M2ZlNa?=
 =?utf-8?B?d3IzdTg0cHNZWHVtMVV4bE9wNmFmTHkvZjJWSm1HL0tPVURtYm9oRnlsRlRo?=
 =?utf-8?B?VzdaR0I2Q3dhVVlSTkU0cnphTXAvSWVBRFdndUVmc1BwQ210Y0s4TjgxS0hD?=
 =?utf-8?B?b3haTXhqRDdsc3dDdzVkVTZMQlRDR09GcFR1TmdzWEkvYlp2ZG9ld1R5WS9h?=
 =?utf-8?B?Y2lwWDQ2RmZ5QXdONVV5SWVrQlpBcjRreUtLbGlaU2dSY29OdlcyZzM1eVF1?=
 =?utf-8?B?TDMyWXM4YUxlUzJybDZkcmVhQUF2UDUrRG9GUkpER2ttc0IyMXg4cFZkNGxT?=
 =?utf-8?B?K0wwRDZOQXNDZnhPaG5lekZ4ZitxOUJSa2FoQWNrN0k1MTQ2QkZjditXQ1JY?=
 =?utf-8?B?OVdIbk9RY216T0pkUXpSa05aYktuaDhCZFJ5OUtFbklWRFVJdGhzM0Y3NVRB?=
 =?utf-8?B?WGxCdVA3S3NRczlsYWRJSlRDZllzRGRoVWVoenhGZU9uZjZYL1FDc2V6MzlT?=
 =?utf-8?B?aWJUYVdhMHJWVXpOUkw2SDYrOWcxelpJdFNqQlpCYmkzcG9BbENNU0dVaVpE?=
 =?utf-8?B?VTVGVis5cjBaLzAxSVRWUmlNeEhJc2gvb1poUkJhY25vdTRtYzdxWVkzZHhF?=
 =?utf-8?B?ZUhyTjZFYVcvREZVay90WUxHZ3R6M3Z5cHQzZ1QyVERyTGd0a0xMUVZMaTQx?=
 =?utf-8?B?bjZqTldRN3ZQRkVud204TTYyT3dKSmxNVFRKOUNMZVpPYXNqaU1LUTR2SDFM?=
 =?utf-8?Q?0HxOLjnm9Wy/5X9o0TMY04mn52Y1tkigx+REfb5rxBNu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D23213A5F87DD4DA4A19CCD790532C6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73955fab-c172-433b-43ea-08db2f112c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 22:18:20.8412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLSr8d2J8/zeJJJCUY8FiYstgCpHj3bKkbKnNaEHPsO+12nGreWRoySfND4pbTm2tY30WP3W85bRaN00pjSkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yNy8yMyAxNToxMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIE1vbiwgTWFy
IDI3LCAyMDIzIGF0IDExOjM3OjMxUE0gKzA5MDAsIEFraW5vYnUgTWl0YSB3cm90ZToNCj4+IFRo
aXMgcGF0Y2ggc2V0IG1ha2VzIG51bGxfYmxrIGRyaXZlci1zcGVjaWZpYyBmYXVsdC1pbmplY3Rp
b24gZHluYW1pY2FsbHkNCj4+IGNvbmZpZ3VyYWJsZSBwZXIgZGV2aWNlIHZpYSBjb25maWdmcy4N
Cj4+DQo+PiBTaW5jZSB0aGUgbnVsbF9ibGsgZHJpdmVyIHN1cHBvcnRzIGNvbmZpZ3VyYXRpb24g
c3VjaCBhcyBkZXZpY2UgY3JlYXRpb24NCj4+IHZpYSBjb25maWdmcywgaXQgaXMgbmF0dXJhbCB0
byBjb25maWd1cmUgZmF1bHQtaW5qZWN0aW9uIHZpYSBjb25maWdmcyBhcw0KPj4gd2VsbC4NCj4+
DQo+PiBDdXJyZW50bHksIG9ubHkgdGhlIGRlYnVnZnMgaW50ZXJmYWNlIGlzIHByb3ZpZGVkIGZv
ciBkeW5hbWljYWxseQ0KPj4gY29uZmlndXJpbmcgZmF1bHQtaW5qZWN0aW9uLCBzbyB0aGlzIGlu
dHJvZHVjZXMgYSBjb21wYXRpYmxlIGludGVyZmFjZSB2aWENCj4+IGNvbmZpZ2ZzLg0KPiBPaCwg
bmljZS4gIENhbiB5b3UgYWxzbyB1cGRhdGUgYmxrdGVzdHMgdG8gdGFrZSBhZHZhbnRhZ2Ugb2Yg
dGhpcyBhbmQNCj4gbm90IHJlcXVpcmUgYnVpbHQtaW4gbnVsbF9ibGsgZm9yIGZhdWx0IGluamVj
dGlvbiB0ZXN0cz8NCg0KKzEgb24gYmxrdGVzdHMsIHBsZWFzZSBDQyBtZSB3aGVuIHlvdSBkby4N
Cg0KLWNrDQoNCg0K
