Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAA5B8E16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiINRUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiINRT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:19:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBDDF593;
        Wed, 14 Sep 2022 10:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTCDArs4gljErhipydvvAbnK8LCyGMjEaL4y0RFhgY08wL7UpIZThOmm/uvdPp7DHxRBO3E/Sa5bHwxB/W1w3aPRypn/Z6PC6hUup7c0sPcCCpLOR67xmEd6vUG31RkSd5y492xPoM7UA3y4Vw7B8njUUvICGbr6hvR5zv/inYqDNwKwbzli9RndfjjGfcuKXNCBxscSWmChjvIkg7lx6AN8l72ubzhWKhdFYp4u8XCN8eV3TN3OAK/5hDyQAGtYlkEq4I+gE8+NWxB1dTU3HlojCqC162Mfz20ZSboWZN3KFOGxBYlRgdoSPBA1vwGxgO7xdpBf3PH6tjDOKFz1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBKWCwvkFHorVMr/7W/fM4MWWlNmVkogrQw+RhytNT8=;
 b=bMWQjVwzJUlhJ5PvcvOt7Mff4UDDxoai7aVX5b4W/kmbtnKJEsWfsOAUDXVThiff1fy9OWqVBP09OvIHgKwQjTiC763qaTlOecEHbeNjVN9XjfDl4icmEAuK8gd/DDNJBg0DUmua6YQgAdwK152ZsdKQFjuM4fWrZl3wEmC+bi8u3cj9tbLFHevlE1m48biuvZQvTpCqnxBskWosLDqc5O1+mb9gNdZhTAxusBnNiiMusEI0ccZg0YJ2kHWOEayU2v5ONcagAlb8uzscYjOrXgKfkWu5Idwr+SjHmxZOq4hCG+6bia6ib0MQfolqIJYZ4XbMJP7UWv5T6p05cjpruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBKWCwvkFHorVMr/7W/fM4MWWlNmVkogrQw+RhytNT8=;
 b=m/G19pP5wKrq6qmWSLQRFENCF1/DNjMq43Sgfy//Wq09juDjeN5KKxq3tnXFFywnJ/RTgBx1Qt1e3gHG2iKRBC+M2qXwr8UC1R5wCyj67tVh1NSr4MlpruI4y6smno+O7zTjP30ke9UDPmt7s1Z8iVF7sQed2be9wzixukb7oOSgq5PR/R8WIhOqODc/h46JC9B+F1ApiUFBZJEPpUO+8DcXpvDZe94lca8oUrMs62WAkpN4CfkGuGlXr3xXOjoR31EhdX/TXJulnqHck+JOLqv4U2zCR8Q0xxl/zpeSkczpiaxTR1MKcUwU0CRWNk9WQ/7bRUUdLrnUZdxF7nEVhg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:19:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:19:54 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH v13 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Thread-Topic: [PATCH v13 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Thread-Index: AQHYxoDltGm3Bk/AC0G7Pq3p/7Aq5a3fL2cA
Date:   Wed, 14 Sep 2022 17:19:54 +0000
Message-ID: <0daefc87-86d5-e893-19d7-7c018b5e4c51@nvidia.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082206eucas1p25336d07279850f7009be6b5d1fccf558@eucas1p2.samsung.com>
 <20220912082204.51189-2-p.raghav@samsung.com>
In-Reply-To: <20220912082204.51189-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|LV2PR12MB5728:EE_
x-ms-office365-filtering-correlation-id: 66245184-e193-42d5-34bf-08da96755750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ombUhyGnsgPIhLJtiQq+/9OIOXqHMiSr1BRF2+ba8qyazwLtbT5Khod4ZeEPadzSm5Q1Wt1w/I93ZtmFCCGpMYjApi3321YZN4qtONq/dXth8stJsyBQuNXORd+K36UHlP7T0Mw7K5MlrZwrxy67yuRO/PW9fyVu49lSIeIx96GOOTKZ5nz66pdLJzzzM2+wz/DZUP8nzfMtZzINIJkTkvCsTdi/NXhZdYla7OC7kDT10QnGO6SHsK83Dhuo209vGo0ntXM+RZIDmJEkN797FXAUCi6Hbh/aiHqgKuFicSaAJcnEH4uEvfysA0htI1NN5U9uviVzflG6nJAv7VMV/UXdpBkcUwkaerasldCMnCK53Oy+ixkDb7GzuMjJPWyxSWH3sOYu1SreiQs3sETB/f7LJ3jsvDOyDxj3ll60lfmyYMZ3SC7Nxz1jNUbof13MQw9JHgKqzXelosr00NI1slb/Wguu3HYYbjy98+zGCKabeQ+1cgbpUc/yUOhWtDTdcC/LQnhUl0fgMwtZru5vhCGxvkFEteNc6Ojab6wOkBB1WNMAdkvFifMlnd4AVqBsIuAzCGIPDbAbl3tt7CiQangcJ9AXhnfIimCyaXP6w9tNO6pcKAYyerAIImb1DdZSU1NgcgO3CMNJSCoXCmE7YYQ0vHGyO1B0dyCtUhA954llw1xlNUBYdOWT8Z/957QMztLGznYc7+14jU1rT1xlu8456rNLM0vJxXiOlFzVfVogeb41OQY+wvb0WCjooWW3+46CIkaNnim4dvV/ApUj5bxaNlugBTEfoVfWtvMbcjXRszLMvt1OqT7Nw6f9YfH56zCK4Sx0AKsJoFyV+vx4lr08g23Uckar6c4CIpG74I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(66556008)(66476007)(2906002)(64756008)(66446008)(122000001)(66946007)(7416002)(26005)(31686004)(36756003)(6512007)(38100700002)(2616005)(6486002)(4326008)(91956017)(316002)(76116006)(186003)(41300700001)(6506007)(4744005)(53546011)(31696002)(86362001)(54906003)(8936002)(8676002)(110136005)(71200400001)(38070700005)(478600001)(5660300002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmtjUlFySTl0N1NKZkl0VFQ5Z3EvYWxJQTlaWnBPU2xQbzVIZkhwQjl5a2lk?=
 =?utf-8?B?Q05waUY0Z3oyNUZvMXN1UHpnZk1Rbm96R2RZbTl4a3hSbSt3b3JmVm9vNVhr?=
 =?utf-8?B?YWpTMWl4M1hvYnJDK0RzZURxRHVwdzhQWTcwYTdPYk16Y3h5ZG41eWRzMm5m?=
 =?utf-8?B?RTBrZzFMb0RCSGM0Z1lWN2dPT05oNVZ6aEdPY09BejRicGNhbnhOL2lkQUlE?=
 =?utf-8?B?cWZZQVcwUGtRa2h4QTNUWEhGYmg1QVdCVDVDejluVm9BVTIzS2FteElTM0kx?=
 =?utf-8?B?RWpXb2ZKcVdWcVA5RSsrbDZKYjBOMERvd3N3OW9LK2xvdjlyOHphWkF3ZU9v?=
 =?utf-8?B?anBaMXdXeisyWFhXaXRUUEVzdXhiQ0szTTg0U2JvZzhHOCthRHZaQ1MwV2ZK?=
 =?utf-8?B?OFpJc2k5dEJ0dzVJTS8vL2ZoN2dHNVdsTmFFTHZqQzJxUlB1MGlPTmZkd2NV?=
 =?utf-8?B?bVBTYk8zcFZuL2RwdTFOcHZtS1dnMGNMclZKNFJlYU82V0FWaExUVnBEcGZ6?=
 =?utf-8?B?TlF1TStqK2piQXg5SHNUempPdFJFMVlGSXB0dlZFZFZWN2tGN1ZwVElsM1VG?=
 =?utf-8?B?U3I3RS9pQnBmWEdzT0wwZVFMcG5kTmladmZ3SkljVW9KZFlRU3lQUDcyL0Uv?=
 =?utf-8?B?ZmxiVVA1RDBaRzdscUFyQkQvbmNFNzNtY0dPVzI0Ny9nN3dWbFdwSXI4VVRh?=
 =?utf-8?B?eFVhcUJCQjdpcmtveTBVSlhhM3Rad24yR0tJcDFUMlVVZVdKTDVoSTM3UlpG?=
 =?utf-8?B?MjM3bjliZmN1c3A4bk5xVHp3Ny9vNmlPQ01SbU43cFlSbmpDdyszT05XSTlp?=
 =?utf-8?B?d1VpL1ZPTWhSbWl0STBNcER2MkZxeTdEelE5TC8yVmx2RWZKSC80TU11Y09n?=
 =?utf-8?B?WXNyK1kyWkZ6cUZEWGJKTHF1VDF5WWFBWVhpb1BBVjhVbXBCWnJyMUxBL3RT?=
 =?utf-8?B?bEprWTRaaXB3WXNVRUFJSzJ2NDdRUlZxaUUxNUFOWU5BSnRTb2tXcjg1bGZ5?=
 =?utf-8?B?cndEQWwxNE9kd21WN2xiZUo0QmxwZnNOdE9yaSs3UnlNN2tlWlExcXgxMGFq?=
 =?utf-8?B?TW0rb2lBeEVlWmpXWGZaY25EaFF4cU9TUG9MLzNlQTAyN1BpNEhUZDRXY2h0?=
 =?utf-8?B?S25Fa3o2eDJsbkUyL0toSFFhR1UzZnJXeHZBSlVCUE1uQVdOdUkwTytldTZa?=
 =?utf-8?B?dUF0Y3VXVDZQcEpjanU5MTZ4T092ZUluWEkzbnFhMGdKeGk4b0NKM2VleEFW?=
 =?utf-8?B?U3FNYU5qU3F3WWxUdXRlYkxxckgyUDFmd3hjdS9ZOFpLNjc1dHFSclJDc1Vx?=
 =?utf-8?B?TkswUkhCNlV4L0d4a0pGdEpYcUdZN09jMUx5cnE0UUs5M2VDQWIzQTM5akNO?=
 =?utf-8?B?Y2xxdHM0Z0JPRnAwV1doMXUrd3psNXdzUW9LV0RISHlHTGtVRXIyR1g5QWwy?=
 =?utf-8?B?cS83SDBndXJzM0hockkzWWdhcG9vWmx4Nzg0SGU1azkyeGNPWFdlQ2F6UDNp?=
 =?utf-8?B?cVJMYk8rSzRkeHhqSmpON1FsR1l0SmpOSis2OVgzRFZrRGpHQUNCTmRhZUtP?=
 =?utf-8?B?U0R4RlRuSWdja0Nvd2d2UisvTUtzTmJxbW1Qbzg2c1FVc29NbHdXZDlUOHM5?=
 =?utf-8?B?Y1RZU3YrS1haSXptbkM3eFFyYnZLQnRKV1FGNHBzSFZ2Z3RMWHZzQm1yTDAy?=
 =?utf-8?B?R0srZS9wV1BPczI3Q1hJU0ozWDlSS0o4TXpKNG9oT2FwaWZyOFQveWtsa216?=
 =?utf-8?B?aC9BSzhiRGJEcXJ1bUJhNTJoVmhQK21nUjJxVjJzSW5DYmI3MFoxSGV3bnBK?=
 =?utf-8?B?bm1BNmhBZTFYVENBRnFjWFJSUnRTRVN0VWRyNkZORVZaTGNUQTlHUTVzc05U?=
 =?utf-8?B?TnpzT1NRTTlGWTFGa0JNdE80WnVXV29CVFJTRGVIbFphL1paMTA4dE03Tk5V?=
 =?utf-8?B?U0JrM2VzdUFSUEdydDNnc1FvbVMvbDV0cWJUM0N3NTRVb0RZWjFEejYrRjJo?=
 =?utf-8?B?SHNqQ0JzbkpWOGxVLzkyTHhjWitKUm9qSSs5UnFEZytZR21sNXpicCtVRmRw?=
 =?utf-8?B?VUhnY1JuWi91V25mSEdDL1EwV3ZYM0RkTU51Q2tPbzR3UTFNZ0NaVVpLaTAr?=
 =?utf-8?Q?FoMLkVzZJiYgwotmDrUoQkIrR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <852EA681CB50A14DAE7CA5E7B122AFA5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66245184-e193-42d5-34bf-08da96755750
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 17:19:54.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnkFkWb4odVcQISsF6g9eXkDGvCma2mG275A8g4ypNlBktP1NB2kHT5fOVyd2PGk1hcTiQhatPtqmscgE2QYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMi8yMDIyIDE6MjEgQU0sIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IEFkYXB0IGJkZXZf
bnJfem9uZXMgYW5kIGRpc2tfem9uZV9ubyBmdW5jdGlvbnMgc28gdGhhdCB0aGV5IGNhbg0KPiBh
bHNvIHdvcmsgZm9yIG5vbi1wb3dlci1vZi0yIHpvbmUgc2l6ZXMuDQo+IA0KPiBBcyB0aGUgZXhp
c3RpbmcgZGVwbG95bWVudHMgYXNzdW1lIHRoYXQgYSBkZXZpY2Ugem9uZSBzaXplIGlzIGEgcG93
ZXIgb2YNCj4gMiBudW1iZXIgb2Ygc2VjdG9ycywgcG93ZXItb2YtMiBvcHRpbWl6ZWQgY2FsY3Vs
YXRpb24gaXMgdXNlZCBmb3IgdGhvc2UNCj4gZGV2aWNlcy4NCj4gDQo+IFRoZXJlIGFyZSBubyBk
aXJlY3QgaG90IHBhdGhzIG1vZGlmaWVkIGFuZCB0aGUgY2hhbmdlcyBqdXN0DQo+IGludHJvZHVj
ZSBvbmUgbmV3IGJyYW5jaCBwZXIgY2FsbC4NCj4gDQo+IFJldmlld2VkLWJ5OiBMdWlzIENoYW1i
ZXJsYWluIDxtY2dyb2ZAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEFkYW0gTWFuemFuYXJl
cyA8YS5tYW56YW5hcmVzQHNhbXN1bmcuY29tPg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFBhbmthaiBSYWdoYXYgPHAucmFn
aGF2QHNhbXN1bmcuY29tPg0KPiBSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNz
Y2hlQGFjbS5vcmc+DQo+IC0tLQ0KDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
