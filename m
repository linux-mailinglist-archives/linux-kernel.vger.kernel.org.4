Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71B705EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjEQElX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjEQEkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:40:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70870A4;
        Tue, 16 May 2023 21:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frDybsNZqscahJ5h4X2o/oO2c0HxW4a3tM3iV8qY0xw2TzVSZYzw3slds7pyoTtj+Mu6D9wamxopS7X5YTirY9UN/F5Zvgm3IB0g0at1KeUCeUnO6Z6ZVzrlFHDrCEGmM6BWeqAnILCmhS4WahRDmLoWqRxb6z+RnV9BvP0TVAmx+hneVf258rPQF1u5yEUpE4OyhrA5s6jwuwkoKEQJMZihB40KJ6uwt8aeWimmPRpGtxhc7w6lpgvu/hAcXqDlFI4wWcBM4kgo+i8XTlIG7PAArr7uC5UpWHU9yufw2BFPHcsJ1zWt2oY/pUB37WJ9iGNjProHKpDD54IlV8Rzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sh8BaEQPWKTIV3uzxTAzmf7982N7d6mdYB/Lfvjq5I=;
 b=CrD9GO4Gtcft2WFzxEPmthL3H/615lMky6IrT5zQwY5KBFgrNi0MzurVKTQWIHkltYPclTsNRBJpEJOe4c0WXWPe4mAz/Q+pEtyxoV5n7tjHHETAB2AmCVmK8f4BSvZUDo1p6GRXFquTEymjSBkaXABA7tdusF0DdpeM2c5T4vaauxLFG11bXX/QdwomIyvG0/nRZy1z9mUnEwJizk8+e6eJ7UAK9Egh3CuvUWwFrMp1qsykRXs8ICfIcfv0paaySrOQbm5i1DWHRKT/03GfYrm3ZU3X5vn82hP/yNRfcUe6oko7i4UQ/5u3GyvbOoh3fFFNyro9Slh5Z52WTA5SLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sh8BaEQPWKTIV3uzxTAzmf7982N7d6mdYB/Lfvjq5I=;
 b=pkY+XPW1pkkenlJNGzNex+tgLZk4XtQ5SAP5gVpB7SLzS3kYjnyOWOOyZ3SdFVoGWzhYoiz/oG53iEuma8Z1UJXTAtKwzX2CplmsBZxiQxlyDCJ06xeUBc44nvQI04D3+uvmiYIhG+uzSc59Nh5jW+KdA/vgdj6oCnCXqulAa0vitQRhb76P4fuBdzFyJEKg9Cel6GUg8VA6k/1DnIQQXgLijlmOZMmRXBbjDSM+YdPvqkhFFnG7nGGYZaAfzurJltcod3hSg41DuiZlSGlmJyNFEM9aGsHit6uOVJQ9lJtDtIM5hVtBcfKZB8LknDrzZTFhjzOo2hPOB9xPbRGKaQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:40:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 04:40:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 05/11] nvme{032,040}: Use runtime fio
 background jobs
Thread-Topic: [PATCH blktests v4 05/11] nvme{032,040}: Use runtime fio
 background jobs
Thread-Index: AQHZhBJOfsVlFwYj/UCDMPw6Hsnvj69d62AA
Date:   Wed, 17 May 2023 04:40:52 +0000
Message-ID: <50c50cda-23f5-b55d-a902-ce34de8498e1@nvidia.com>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-6-dwagner@suse.de>
In-Reply-To: <20230511140953.17609-6-dwagner@suse.de>
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
x-ms-office365-filtering-correlation-id: db2f7fde-6be3-4ce0-6e15-08db5690e531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7j1WCjiHWF/8x3/elzPe57PeD6rvePkXGxF/WUC8O3G2459quZ3ahArScpsXLHn+OWgek/s1ofzgspaGk6BTAAU5yTHRGjqsxo7zYU3cWlTlNL/+zBZFFzSY5UzFnpFaS7ZSWMo3Nnx6knvYyqvKaZ0EHEIvh0OGQjC1RCUQV/+lTGmvMwN43tRMxZYaQoOZ51u50GdE/YGJiM+2Hdorp1vxw5HgW9nUbt9YBn4RT/wMrUz2sXPnvc9ZsY/VTr8B4Rx8mOAp/gdK2OsKBLIrq5wmnsrzG3WEA9bqa4IHLDfCd0eBHCD8+7HYA4W1GCNgxgUR8m/OdI8NJ/D0uIPA/FpdB19DtnI201BFGhALF1UWDi/cFFqD8WdFaTG/rbAgk6oTFk9cwp9bqCAfghx8pAk1OZLnH5MQanKtWUkXOkP3cg2ZyRAvAA01xNOY3jNQF0IHmIQ1oCRFn8Dm31EudA9+Xt9OR7sdNNOz1osUEjFhLf0Uo0TUsLxH05VJv3Mtuyuo8L3ONcS9TiP6i9Y2IeEx/MhcNIKLNdWcR/8OgP/2eXtdowH4SfGyrDkyqFrRa3gOwzJm4g6zeQ25EwFtqpRnuYxArfXe+oeOBQ+YpJNoYFt/Wku4E93Lxh2UMJGxuah6mKbxEau27oY+xCCVV22eAYvE7if3giNFfYa1L82l2lI0zuukqxJQblTrZckk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(31686004)(4326008)(36756003)(38070700005)(2906002)(8936002)(31696002)(5660300002)(8676002)(86362001)(316002)(76116006)(66476007)(66556008)(38100700002)(122000001)(64756008)(41300700001)(66946007)(66446008)(91956017)(186003)(53546011)(110136005)(6512007)(558084003)(6506007)(478600001)(71200400001)(6486002)(54906003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU9BSi9PMTgva3VjUHRhYW5tNzc4SThXeUNkMzJFVy95M0NqQW9GckJqNllr?=
 =?utf-8?B?LzlRdVRBS3BSNVlpR0greGdTR1NEL2k0WHZUZHkyeHBJNmpGTnlxc0hLZHdz?=
 =?utf-8?B?c3orVFl3ZzRERG52bzdCLzFOQXFoMG10TE8wbDU3YWdVTUcxdmphS3NCUGQ2?=
 =?utf-8?B?cXR0ZEp2ZjZ6WGJKWWNiellsS29lQ01NV3pXd3hXZ0lKTEUxcFUrcHh5UVVR?=
 =?utf-8?B?WThyeFBrMFhjeXB5akxCd1RBcC9maS9jMTBEdDBkaXZ5Y0xTZUpvWDZBK21W?=
 =?utf-8?B?VExndDZ6MDBPOXFpUkVJWXVrNWk4eUVpbHlCQ1hDZmRUODJjYU1YTDJXc1JU?=
 =?utf-8?B?ejQybEsyQW5PRFFReUJybWhtRk9NOWFnTzlwVmRCYmdPZE91b1VPVzlsdHdL?=
 =?utf-8?B?WnhuNXJOY1NhY3FPQ3haTGlWakV1SmNLZG9XbkxDVXliK1NMTXVBUVc3Ny8y?=
 =?utf-8?B?ZTdiMVd2UWxOZEh1aURCSmMzeFhCRFovYmNMeGlNQ3BYUEhrSkpVZzBOM21P?=
 =?utf-8?B?eHJNZ2drM21kNHRuZ1JZb04yZ1hxbkE5bThOeDhKbGxmeGVqZXJxRVd2Rm0y?=
 =?utf-8?B?OHVoT0ZablQwM0hjbTBUcm1mUmVjd2IxM0M1RkdlcmViWm90L09pb2hnVlpr?=
 =?utf-8?B?M25PNHpWbFRib010eVg0SGpaeUkrcFdBYTNsQXhScjR3TGZ3WmhFV3ZUQlpL?=
 =?utf-8?B?cjhUMWphZk1KOHBmdUQ1bHN5TGFuUlpIMUh5SUFzVjIzbyt1THAzVEZtVXlz?=
 =?utf-8?B?MFhkRkNzNkhEU3BGR1lQOC9EUDM2c0hzMFBBZVNJUjlhUVNFL3ZBaWFCVmRG?=
 =?utf-8?B?c1BkckVQZllETG5FeXo4RFpzVC91N0svMmd6UUZ5YmVQd1Zkd3V5ek1BWmFN?=
 =?utf-8?B?TG1NR3dlOTdkRlpMSDdhT0pyaDdDYzM5SHVPdkZEYnBadTIxZjloZHpBbE1q?=
 =?utf-8?B?MlNmUTB2K3pycFZSamNJaHBMUFdvT3FxbS85VGVtckpWU1Y2cjA3VEhsU3Bq?=
 =?utf-8?B?ZEw3czZBc1dLU0UrMTg1MkJ0T1JvZFh6djE3Q1Q1WlFQRW9HWDloc0xveUFo?=
 =?utf-8?B?YWZaM1ZiSkRUVm52QjVZMFMzdk5UL1FGd05OVEpRYlB3TGdkQUdrTXNZeXZs?=
 =?utf-8?B?b2lWdHcrUVc2dCt1a3pERzdXdTZZc2w5Nnl1M2xzNmRJQmRjbDVhdkV2ZEQy?=
 =?utf-8?B?MHk5cmpVNVhoemUrYy95TldpUVNQNGZPV0VKVjRSNTBnTDRQYjZJNW5nbW5k?=
 =?utf-8?B?VnBuSVpVUWpVTTBDZG1aejZnWUtiNnExemtPS1k5eTh6VVlUbGFTVjBQNVAx?=
 =?utf-8?B?RWRiWklVRW13ZGZQTE0wb3UrN1ZhVC9lTUxudmFVRk9BSUhxOUdRYml6Um51?=
 =?utf-8?B?SkJuZzViK05JeFl3ZXhpY2RqSEFzWmJ2SjU5bmZhNHhuYmNNSGhIcmtnM01I?=
 =?utf-8?B?ckd0ZThvSlBlR3pUM01HeWQ2SUVyTmJkdUZlQ3BmYWFQbCtUckRaRFNtVEVF?=
 =?utf-8?B?RmJhMGNXWFJzMGtSZ0szMldPZTQ4aTV5aTVxTlcrcmoxd1pHNVl4RzhtYU5m?=
 =?utf-8?B?a3g0dE1PaHhuQlBDWEhrREtHRGJxUDZROGtsRnpTUElWWGRaY1QxUkVZeFhk?=
 =?utf-8?B?dS92Rkg3cXFveFptOHZTMzVDb1BNcUpvdDJ5RlZrbW5yTGxZWE9RclVrRGZz?=
 =?utf-8?B?cG5ZRnFkT0hmOEhEZjlzMmxxRDFkQnJEUXpRMEJxcUtYbGE2T1llMG1BMVpR?=
 =?utf-8?B?MG41Q2QwR0lEb1FibjlRankvSDF0d1NvR0JDVHZSbnpzNTFMaHY2ZU04a2hL?=
 =?utf-8?B?amhsTHVhUWtmUW9zNHluRi8vL2YxcVBkMk1OTVJjYTVsd0xUbVdlektuODNX?=
 =?utf-8?B?SFpyRnVUd2ZZMERPUFpLOEFOY0J0b3U1ZjBVTlJjalpHZzRsTnZPNG95V3Ri?=
 =?utf-8?B?Y1U3bGVselBtK1VmRnk5dXpNNHZjWEk2OTRDQkdxVmY4L3p4NnhxUVJqYXcv?=
 =?utf-8?B?UFkzUGpxdWNWbXBPYzd0dVU4TU54NWw1NXJ4cmdpOWlqVXFreTJIMXNMVnpF?=
 =?utf-8?B?SHhObjFubTJYblNIUi9IQ0JOZ1ZWOUFvVU9LT2picXN6WkUramRmL2NPMVVH?=
 =?utf-8?B?SUtMalVRbWtkZm01VGFIMW9CMk5lcE9kUXB4anJCbC9XOWd0cVdFL0Q2VkNK?=
 =?utf-8?Q?2fjtpPVZ0eOC6UPsH4XhW7KgRQnDVgAXJdxNzXBk6q/q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F71F81496C59046861C870B2EE0A5AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2f7fde-6be3-4ce0-6e15-08db5690e531
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 04:40:52.3238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpiTKzVKc5bCUME0L3FsrQqhyqA7a1KfCJQgXxDrJnJb+bgcW8PPnbtyLt1u32QrBOyvdVoESG0/21fDEfAofg==
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

T24gNS8xMS8yMyAwNzowOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVGhlIGZpbyBqb2JzIGFy
ZSBzdXBwb3NlZCB0byBydW4gbG9uZyBpbiBiYWNrZ3JvdW5kIGR1cmluZyB0aGUgdGVzdC4NCj4g
SW5zdGVhZCByZWx5aW5nIG9uIGEgam9iIHNpemUgdXNlIGV4cGxpY2l0IHJ1bnRpbWUgZm9yIHRo
aXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4N
Cg0KSXMgdGhlcmUgYW55IGlzc3VlIHdpdGggdGhlIGV4aXRpbmcgYXBwcm9hY2ggZm9yIHRoaXMg
Y2hhbmdlID8NCg0KLWNrDQoNCg0KDQo=
