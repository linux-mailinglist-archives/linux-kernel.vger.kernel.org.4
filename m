Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843C600CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJQKqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiJQKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:46:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4926173C;
        Mon, 17 Oct 2022 03:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BokgT5fvYxL3u070ub9K0MLqP0c8g3SMtR9VMnLseYsDPU11QFTI6hMXfhWkLP57pjWLDbEtvioKRJMBMhKel1OZQjHiWWXi0nlarh2bXpO9nfYjqo3QXZxfI2Nkh18EklTeOOieORqQVxUTj2dC1su/M1J9eyKYzoo3Xfk1MqLaDH4tv1ZFWz2yKysFx7yKAgsLex92W7BqVI8XgGCQ/uC/XV2v12eck6oR7PFApZWp1e20nrEeEtZNx4PiToEAVBHUBVVhESxyrEIo2EUlxELAt0yQkWln8/qXkmLTOs1xOwlFdlSXCqZr3DVtS53dhBorhMcxbCuwOiGHKOtKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx37CHIUUCZ8TNF2vg2FrUoCgxIJbQnLjtBxjFPbsyc=;
 b=QOvbhSeB5r2yoBTqVOwNN3+kV+PWvGhzgp+VP/wnKa8bigDU1qzH7pz8pv2/hJOBtNsgQGm3/pI/Y+ePPKl7Ssh2cGHVssKYyD54fIwmArUdsY83bL03HgSXbwaGUQiyoojaIC+GxwY/J6eGq3qSW6yAF3uvgdHpejjwQrDTS8kX2wrtFHLA+guSQguGaa07R1aHwJfHYtTgWfYvSghC0dTEzhKRQ/a3/cBAaDfeod9DRAheT+796pFeU0suzfjzZDSn+fLw4KxqORTl1vVqzPQVXdwjGtNhC8rqwqvoHSedYlv+OqYTP/0IJXKb6DR4kOQEM2OwHZpzSr3Ool9qXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx37CHIUUCZ8TNF2vg2FrUoCgxIJbQnLjtBxjFPbsyc=;
 b=qdeOxMhLfbGkv4bE+5yBA4DMJR6nBZahESqwH8taBO2E5Rpc9egFoUmVprT+cUkQG+otiAXjWMvoXNmIypnKhWMBp0wvS7SqDl0TuOQBzKsEXBPYmWRgnR2qZqN98G5yHDQgUmCNWTklCnDnZjyvgDYCri6ABSXVwdYXRLZQMVSgj1U5JuLV500jBpICZzeUe5/yigICBs6hFZAcscfmTphkkHYddAkSChbqJHFcgU0oqYROCEEbiZ4ccNoMJcxqD+OqzanV3bphUEchHRzHmADL7APOBe9wDVHwGw2zHh+vBe9dq1WyVpZFMZsRpRcS6fJg19RrlAEY9wd8/Wgd/w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 10:46:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 10:46:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Thread-Topic: [PATCH] null_blk: allow teardown on request timeout
Thread-Index: AQHY4R8DFU2LJu/Wy0udZZqXPfzvLK4SUpaAgAABcQCAAAV8AIAAA+wAgAADawCAAAhbgA==
Date:   Mon, 17 Oct 2022 10:46:35 +0000
Message-ID: <b10dd129-76e0-0950-c647-cc0e1236383c@nvidia.com>
References: <20221016052006.11126-1-kch@nvidia.com> <Y00fkc1N+Cif/Kxt@T590>
 <0af3d1a4-8166-ea1e-8710-c51479c587a1@nvidia.com> <Y00lYIhUNv1CxqiK@T590>
 <52913ebc-5f01-bff4-9b2d-2ee9caf4719d@nvidia.com> <Y00riC6UxmLDhI5P@T590>
In-Reply-To: <Y00riC6UxmLDhI5P@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5256:EE_
x-ms-office365-filtering-correlation-id: da1f1d9c-04b2-4a67-fef9-08dab02cdcc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9BAkkOxSjndJlCEYciBTp0TaCV3aeGK+WemmzT3oedZQT7fqp1IUTSpz3dMBJkbIbziUUQo3TUqfUpgvHrSpukXvi73MHAxJjXPbNINGnEumo+WwtortC955dy4kKMu6EwrJt1YT8g1wTed5Md4pO+7QQAyXmjILNIJj29V344Nyb+8ceN6kQVhYFqpSUKAq7quT5hgO/Jx+2a/MCBELb1yVtekChwkhYVbv9uld01Y/eFktQNrEj+eNH9N2tHwTnAQ7SFP9cZlABLvs/+2dULWwd++9Rs4eVuH4xbbHLoCKIobzDolIielzEmEqhCfzF+2UeKfIul1KlDx3t41g1xLJPtIzUaFf3mcLW0faEdCa3p7YfEqTue6lWHYD6rCDPlys03jxI+EFl2gVsXvN/cPvFyPeFcsJhgo4W2fqScRRXjzUoOlQZ3xFI/G4dRw1Rs1Dj4wMGuX8GOdIS3SiNKmLuhZOQUUdvIFx6MeSuV0i9B8JRUScTs1LP23oiBu1rdVSnQ6M1qrVn/T+l/buXMEjMc4pqw3b3Hl86lQ9n7+osBWEko9YCkvoZJmpgdsqIlxa70TTdfIvDgpuUNG7jO7qfu/j95NzcXztt2rl6U3sR+1sD7OhjklpKRD6+lJPkfU4+z9eU1CWjzCTjn7iyIciIvdF/qbkfk/xJbVUK1r5NtSoqIa5Vlm2pyH8ecY/ausvJps0s764X+THmyk3Tli1UUppoSkv5BBEjpOCPNex4k9UtN13Y/7cPh6e4u3oyeS0eTVfv6mybc8YVh6ye/G7s8TDiZCmbdR3uurfk0wIkkDs8DcNdVkJj4MXrBALAPpiFBehDrwHIIOon8BPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(66899015)(186003)(31686004)(2616005)(2906002)(122000001)(6506007)(54906003)(5660300002)(53546011)(316002)(6916009)(6512007)(86362001)(38100700002)(41300700001)(66476007)(66446008)(64756008)(91956017)(8676002)(66556008)(66946007)(76116006)(83380400001)(4326008)(31696002)(7416002)(8936002)(38070700005)(478600001)(36756003)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWg1Z2JLY1J5STBBSnREeVpVN243cDFMMzZyK0t5NFl5QlVJVUVCT2lqK0x0?=
 =?utf-8?B?bTRmYzAzOVNBdlpyZkh0bVJGUXFaSGdnUGFEZ1RTR3JZV08zUUJvYnlBb0NI?=
 =?utf-8?B?cktkSE4rT01idnlBc2wxSFV6cXl2RldMQUd6VkdEc0VGN09jR0wrZittQ2x5?=
 =?utf-8?B?d2g5cTJ0WHlMbG1xVGxLdGQvSlBESmZiUWVuTXBHWnRqLzZiRUhWcGEwNGZ3?=
 =?utf-8?B?U1BQNVVxdjNpMjZldnBUQ0VCQWRoakthV0Nmd2J4SU82ZUd6Sml3Vk9mZWZY?=
 =?utf-8?B?dHQvRDBCMzcrcDZkZUhZY3dlMDh6dGRwVHBxODVKM0w0dVhQcFRwTVREQ2pi?=
 =?utf-8?B?UmZoUlRwMmgyZERYZCtKL3pRMTF0SUEzcWkvbnU4dXVVelp0YStIN05GZXB3?=
 =?utf-8?B?VDhzcXNaWHIyazAzUWV3Nk9lMVFnY2dZemRuYWNPSlVJS3hSQkIvNjZLU01i?=
 =?utf-8?B?ZkhtVnNQWVZqRElEcXFEU1BDYmd1RFR1b29BTTFiUHk2Yms5cStRQ0Q1R0Ux?=
 =?utf-8?B?OVlKMkhEaHZlQis1dUhkYzB4Rm1ka2dIbnV3cENmQUNSNUMyTVV0R1pWelBy?=
 =?utf-8?B?TmZLeG5XMUJZR1g2VkVoOGpweXlUZ0pqR1JWbE1pRVdCSE44dndSUmlrcytw?=
 =?utf-8?B?elVJS1lTVjJLMUt6Ylhjb3hvSkp5Zm5GYS9YMEQzcTBOK2IvRmJTTjFIdjdw?=
 =?utf-8?B?YWlpRVoyMlU2bW83RHhETUxoUS96blZla3VBbktSQmcveGlCRXE2cldXMUR1?=
 =?utf-8?B?bXF6c2ROSmp0LzlpNFlUSzNiRHpBYUw3RlEyaGdPSU9JTTNYeVFoNDY5Kzln?=
 =?utf-8?B?S1lKbVJ3cU1tZE1NOFYzeWZUZzNwVHVtV1hqWUhUQnRYbXRjK1M2K3dQamht?=
 =?utf-8?B?dm9USmhFeTZCNnBNQ29uN3hvdTNBd0xOcVRhOWRaWHBaaVdFWE40M09icnZ3?=
 =?utf-8?B?NDdLRGVEMFRZcE5mMTN3eS9yQlhrT2RhS1ZQV3ZpR2RPWEJEeUxQMjhBZ1Na?=
 =?utf-8?B?RlV5TDFHUUF6OGlWMXA4VVNUV1M2dk92M0ZreUV6K0ZnKzk1Tlk1MlZ6dmNs?=
 =?utf-8?B?VFNzdXJJUVV0cGxJblIrUWhwQmEybFF5VkNNUXQwZTV5REV4T1VrbmYzd2hk?=
 =?utf-8?B?RmtNTXZMdUZQWUo3RUVrcGpiUm4rVXpDVlNYei9JOCs0SGR1VDBSb09nSHBt?=
 =?utf-8?B?UkdITy81K1lPNFFFU01OcEdackZCZlJuNG0zdk9XMXRPbGZ3S0VPdlhmZ2w2?=
 =?utf-8?B?dlZCUlAwaHYxOE1PdnIyNTNBM29xSmJqV0JCdko3bmk1TktPUFJwWE5mNis1?=
 =?utf-8?B?dXVEUXJNcVFZOStMVDlCWGpaVVlkcjlINEtLajZHd0FxU1UxakNXQVdKZXRR?=
 =?utf-8?B?RzQxbVhnbTcrZCt1MnlYWC9kZ1ZUSEhDa1hLUzBFMlZrZjRHMkI1UW55ZXBY?=
 =?utf-8?B?ajFXTFNnaEFjRnFsRm1sdHNmY3UyNE5TdVR1cnJUWmRmNmMxWWtkaDB0RSt3?=
 =?utf-8?B?TVkvUFJoOFdpTmhZWHI4UVNMYjdrcVp3b0QvTGNmZmpNNjZuaXlGeldGVmMv?=
 =?utf-8?B?cCthd2xwMVEwcFkxOUpZWElCbmk3bjN1RzZONTIyL0dxUkY1SzF2Qzd3eHV2?=
 =?utf-8?B?aG5XZjNFNEU2QjVkKys2WWhhbGtmaEczeFBMeWprVjdkQU9CbzdjNVpRbzRN?=
 =?utf-8?B?enkwbnVoaEJnaU8yZDFnSlpyNkM3TzJUakVhQVF4SlgwQld4RjBBbXV3WXhD?=
 =?utf-8?B?WFV5RWh4alVHVCtDMTdxQzdVcjAvbDBvTHhLWC93d0ljT1E3R0FBRWNPZHRY?=
 =?utf-8?B?UG9xN1djYzBRR0NRMkorOHFUNnFDbVd6ZDdsSEprRXpUYzlXV0tTMmsrK1RD?=
 =?utf-8?B?eHFiWDdIUkxxck5yc05ReVZhaXpCOFRMdnBHU0dxNytIQWh1QTlWeVpndDJu?=
 =?utf-8?B?ZFNvYlVVWkdEcEt6bnd3VUtnY2VTaUx0ZzJoaWliZFZ1UGNKY1pVTFR4VW9m?=
 =?utf-8?B?V08yMUU3amx2UmQzOGhmVkl6SGFyVWJmcDZwUDlSM2NCT3V1QU1HR2NaeDBY?=
 =?utf-8?B?bHZLaUlOVkFVREJScWtOTzR2U0U3MXRUbU1rNG9tNTJYcFNpVGx6M04zNTdv?=
 =?utf-8?B?VVM5RWxIc3p6OTUwN0tTYXI3OFFnbkx6YUo0UFdPV3lmUVMvUGtEMCtqQ2pT?=
 =?utf-8?Q?SxwgjgzaKRhLv8TcQyylQ2g6oh8AFcW6Xhdfx4XkAyH6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFA64CD4C23C404DAB67365EAE9676B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1f1d9c-04b2-4a67-fef9-08dab02cdcc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 10:46:35.4825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvmK4F5mbo4qWK31KlrMNF7fx/ZlYcsFgZq7+vNgK1CiEykiWCr/O+APc+BSyTgbduzf4EjyyKKDTWYS0Fu48g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTcvMjIgMDM6MTYsIE1pbmcgTGVpIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAxNywgMjAy
MiBhdCAxMDowNDoyNkFNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBPbiAx
MC8xNy8yMiAwMjo1MCwgTWluZyBMZWkgd3JvdGU6DQo+Pj4gT24gTW9uLCBPY3QgMTcsIDIwMjIg
YXQgMDk6MzA6NDdBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4+Pg0KPj4+
Pj4+ICsJLyoNCj4+Pj4+PiArCSAqIFVuYmxvY2sgYW55IHBlbmRpbmcgZGlzcGF0Y2ggSS9PcyBi
ZWZvcmUgd2UgZGVzdHJveSB0aGUgZGV2aWNlLg0KPj4+Pj4+ICsJICogRnJvbSBudWxsX2Rlc3Ry
b3lfZGV2KCktPmRlbF9nZW5kaXNrKCkgd2lsbCBzZXQgR0RfREVBRCBmbGFnDQo+Pj4+Pj4gKwkg
KiBjYXVzaW5nIGFueSBuZXcgSS9PIGZyb20gX19iaW9fcXVldWVfZW50ZXIoKSB0byBmYWlsIHdp
dGggLUVOT0RFVi4NCj4+Pj4+PiArCSAqLw0KPj4+Pj4+ICsJYmxrX21xX3VucXVpZXNjZV9xdWV1
ZShudWxsYi0+cSk7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsJbnVsbF9kZXN0cm95X2RldihudWxsYik7
DQo+Pj4+Pg0KPj4+Pj4gZGVzdHJveWluZyBkZXZpY2UgaXMgbmV2ZXIgZ29vZCBjbGVhbnVwIGZv
ciBoYW5kbGluZyB0aW1lb3V0L2Fib3J0LCBhbmQgaXQNCj4+Pj4+IHNob3VsZCBoYXZlIGJlZW4g
dGhlIGxhc3Qgc3RyYXcgYW55IHRpbWUuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBUaGF0IGlzIGV4YWN0
bHkgd2h5IEkndmUgYWRkZWQgdGhlIHJxX2Fib3J0X2xpbWl0LCBzbyB1bnRpbCB0aGUgbGltaXQN
Cj4+Pj4gaXMgbm90IHJlYWNoZWQgbnVsbF9hYm9ydF93b3JrKCkgd2lsbCBub3QgZ2V0IHNjaGVk
dWxlZCBhbmQgZGV2aWNlIGlzDQo+Pj4+IG5vdCBkZXN0cm95ZWQuDQo+Pj4NCj4+PiBJIG1lYW50
IGRlc3Ryb3lpbmcgZGV2aWNlIHNob3VsZCBvbmx5IGJlIGRvbmUgaWZmIHRoZSBub3JtYWwgYWJv
cnQgaGFuZGxlcg0KPj4+IGNhbid0IHJlY292ZXIgdGhlIGRldmljZSwgaG93ZXZlciwgeW91ciBw
YXRjaCBzaW1wbHkgZGVzdHJveXMgZGV2aWNlDQo+Pj4gd2l0aG91dCBydW5uaW5nIGFueSBhYm9y
dCBoYW5kbGluZy4NCj4+Pg0KPj4NCj4+IEkgZGlkIG5vdCB1bmRlcnN0YW5kIHlvdXIgY29tbWVu
dCwgY2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIG9uIGV4YWN0bHkNCj4+IHdoZXJlIGFuZCB3aGlj
aCBhYm9ydCBoYW5kbGVycyBuZWVkcyB0byBiZSBjYWxsZWQgaW4gdGhpcyBwYXRjaCBiZWZvcmUN
Cj4+IG51bGxfZGVzdHJveV9udWxsYigpID8NCj4gDQo+IEluIGNhc2Ugb2YgcmVxdWVzdCB0aW1l
b3V0LCB0aGVyZSBtYXkgYmUgc29tZXRoaW5nIHdyb25nIHdoaWNoIG5lZWRzDQo+IHRvIGJlIHJl
Y292ZXJlZC4NCj4gDQoNCkluIGNhc2Ugb2YgbnVsbF9ibGsgdGhlcmUgaXMgbm8gcmVhbCBiYWNr
ZW5kIGNvbnRyb2xsZXIgaGVuY2Ugd2UgZG9uJ3QNCmhhdmUgYW55dGhpbmcgdG8gdHJ5IHRvIHJl
Y292ZXIsIG9ubHkgcmVjb3Zlcnkgc2NlbmFyaW8gaXMgZXhlcmNpc2VkIGJ5DQphbGxvd2luZyBt
dWx0aXBsZSB0aW1lZCBvdXQgcmVxdWVzdCBhbmQgd2FpdGluZyBmb3IgdGhlIHJxX2Fib3J0X2xp
bWl0DQp0byBiZSByZWFjaGVkIGJlZm9yZSB0ZWFyZG93bi4NCg0KPj4NCj4+IHRoZSBvYmplY3Rp
dmUgb2YgdGhpcyBwYXRjaCBpdCB0byBzaW11bGF0ZSB0aGUgdGVhcmRvd24gc2NlbmFyaW8NCj4+
IGZyb20gdGltZW91dCBoYW5kbGVyIHNvIGl0IGNhbiBnZXQgdGVzdGVkIG9uIHJlZ3VsYXIgYmFz
aXMgd2l0aA0KPj4gbnVsbF9ibGsgLi4uDQo+IA0KPiBXaHkgZG9lcyB0ZWFyZG93biBzY2VuYXJp
byBoYXZlIHRvIGJlIHRyaWdnZXJlZCBmb3IgdGltZW91dD8gVGhhdA0KDQpUaGUgaWRlYWwgd2F5
IGlzIHRvIHJlYWQgdGhlIGNvbnRyb2xsZXIgc3RhdHVzIGZyb20gdGltZW91dCBhbmQNCmNoZWNr
IGlmIGl0IGlzIHJlY292ZXJhYmxlLCBpZiBjb250cm9sbGVyIGlzIG5vdCByZWNvdmVyYWJsZSB0
aGVuDQp3ZSBuZWVkIHRvIGdyYWNlZnVsbHkgc2h1dGRvd24gdGhlIGRldmljZSBlbHNlIGNvbnRp
bnVpbmcgdG8gaXNzdWUNCkkvT3MgdG8gdGhlIG5vbi1yZWNvdmVyYWJsZSBkZXZpY2UgY2FuIGNy
ZWF0ZSBtb3JlIGRhbWFnZSB0byB0aGUNCmRldmljZSBhbmQgcG90ZW50aWFsbHkgdG8gdGhlIHN5
c3RlbSwgYW5kIEkndmUgZW5jb3VudGVyZWQgdGhpcw0Kc2NlbmFyaW8gd2hlcmUgU1NEIHdhcyBn
ZXR0aW5nIGhvdCBzaW5jZSBkZXZpY2UgRi9XIGhhZCBhIGJ1ZyByZWdhcmRpbmcNCnRlbXBlcmF0
dXJlIGNvbnRyb2wgcmVwb3J0aW5nIGFuZCBpdCBiZWNhbWUgbm9uLXJlc3BvbnNpdmUtPiB0aW1p
bmcgb3V0DQp0aGUgcmVxdWVzdHMgaW4gdGhlIFNTRCBRdWFsaWZpY2F0aW9uIHByb2Nlc3MgYW5k
IGxhY2sgb2YgdGVhcmRvd24NCm1hZGUgc3lzdGVtIG5vbi1yZXNwb25zaXZlIGFuZCB3ZSBvbmx5
IGZpZ3VyZWQgaXQgb3V0IGJ5IGxvZ2dpbmcgdGhlDQp0ZW1wZXJhdHVyZSB3aXRoIFZlbmRvciB1
bmlxdWUgY29tbWFuZHMuLg0KDQo+IGxvb2tzIHlvdSB0aGluayB0ZWFyZG93biAmIGRlc3Ryb3lp
bmcgZGV2aWNlIGZvciB0aW1lb3V0IGlzIG9uZSBub3JtYWwNCj4gYW5kIGNvbW1vbiB3YXksIGJ1
dCBJIHRoaW5rIGl0IGlzIG5vdCwgdGhlIGRldmljZSBzaG91bGRuJ3QgYmUgcmVtb3ZlZA0KDQpO
byBJIGRvIG5vdCB0aGluayBsaWtlIHRoYXQsIG51bGxfYmxrIGhhcyBubyBiYWNrZW5kIHRvIGNo
ZWNrIGZvciB0aGUNCnN0YXR1cyBvZiB0aGUgZGV2aWNlLiBBcyBleHBsYWluZWQgZWFybGllciB0
aGUgZGVjaXNpb24gdG8gcmVtb3ZlDQp0aGUgZGV2aWNlIG9ubHkgbmVlZHMgdG8gYmUgbWFkZSBh
ZnRlciByZWFkaW5nIGNvbnRyb2xsZXIncyBzdGF0ZSBhbmQNCmNvbmZpcm1pbmcgdGhhdCBpdCBp
cyBpbiBub24tcmVjb3ZlcmFibGUgc3RhdGUsIHdoaWNoIGlzIG5vdCBwb3NzaWJsZSB0bw0KY2hl
Y2sgZm9yIG51bGxfYmxrIHNvIHdlIGNhbm5vdCBjYWxsIGFib3J0IHJvdXRpbmVzIGJlZm9yZSBk
ZXN0cm95aW5nDQp0aGUgZGV2aWNlIC4uDQoNCj4gaWYgaXQgc3RpbGwgY2FuIHdvcmsuIEkgaGF2
ZSBnb3Qgc3VjaCBraW5kIG9mIGNvbXBsYWludHMgb2YgZGlzaw0KDQpvZmNvdXJzZSBpdCBzdGls
bCBjYW4gd29yayBzZWUgYWJvdmUgZXhwbGFuYXRpb24gYnV0IGlmIGRldmljZSBzdGF0dXMgaXMN
Cm5vbi1yZWNvdmVyYWJsZSB0aGVuIGl0IHNob3VsZCBiZSBhbGxvdyB0byBncmFjZWZ1bGx5IHRl
YXJkb3duLWNhbmNlbGluZw0KdGhlIEkvT3MgYW5kIHJlbW92aW5nIGZyb20gdGhlIHN5c3RlbS4u
Lg0KDQo+IGRpc2FwcGVhcmVkIGp1c3QgYnkgcmVxdWVzdCB0aW1lb3V0LCBzdWNoIGFzLCBudm1l
LXBjaS4NCj4gDQoNCkl0IHdpbGwgYmUgZ3JlYXQgaWYgd2UgY2FuIHN0YXJ0IGEgbmV3IHRocmVh
ZCBvbiBsaW51eC1udm1lIGxpc3QNCnRvIGFkZHJlc3MgdGhlIGNvbXBsYWludHMgdGhhdCB5b3Ug
YXJlIHJlY2VpdmVkLCBJJ2xsIGJlIGhhcHB5IHRvIHJldmlldw0KYW5kIHJlcGx5Li4NCg0KLWNr
DQoNCg==
