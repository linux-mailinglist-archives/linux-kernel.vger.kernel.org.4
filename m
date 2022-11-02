Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9517B615BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKBFqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBFqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:46:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB675F56;
        Tue,  1 Nov 2022 22:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmRI2qPLkFzuxZYSeLcMG5bKHTHQI1bmB78/UfnRtKFsmRHvt/yOfzmpzBxpHIr4QfB/kbVMQ5kOdNFplJxjG742jyJBibzZd9mdIv7/n+Cxw98w9F2xd/e/wtJip4uaVBmQyTEQSDimlXaLjL1hCmLJX+PHwF2dKssseZH5yw/oqUc9e3kvSCi3oIJ7S5+O4r3i/xJz7N1EYPH3CZH7KFS9iIJxe1Y1bznmTVaD9X8zNGvwBAlyYzJhYHZ/6nj+f2e27x72VPAKS9fEx7yKMYEl1C2JGro56sO13GVOVr/LucQCYNFom+tL68MzGOcteAiEqFA/Y9X5e9se+wB0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx1Z18lY5IRz4aZVYlrj2QzPzLStae/n3HlhQAWnUAU=;
 b=Mo4fQkaTbUKjiL3uu1SHjmTuIv41Oay8hED7hgcRcLNZG8yxpZgN84szLqC/mfY2XhsyeX+EjV0q4TEyIib0t56gWak2mqnBjPmffMWKL6BbTs+Bg1D7tjluBjiImKnE1fSeTG0RYzGPfFyP0SLgRn/j8o8uNyN9Fc9QXDfpla1peA63jX2+YckFwnSCG+hcxrds5L8JMuWbGp4qwGKUlpMmMBkfgSDJ3dKfbL3rDTYp02IBMNZVD+aauKL7KC/EBwWukbMx0B7+Zqci7pkXZp6g6xZEQ5o0mQU9NKP+MJvooHp/9pR1LiKmQYJ2b2o98heBqm/0xmueMTIS/iTlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx1Z18lY5IRz4aZVYlrj2QzPzLStae/n3HlhQAWnUAU=;
 b=JtzceV9CeOeRpi0PjMoPC+JHcOj5vZkrAovcHPnmiVyVE0xDV78Sf5i/nioJ894AzIoZ4Fa03L6QOfjesiBUx2k9IEaFgrl1Cx8IsdnNeP0OLxCRO3X+XjFgU87cV0eIhjGCRSpT0rtdvRfi9NQrA/TALs/5tQ8il0jaO0ULsuIyMg6e1G20TOfKDnubXl7lS8QlVkNZUP86SzT4rG1a1L8cYAMHiskjpwwUciKWf4/j9CDBdmU+SfZf5VWYg5GdtPZOP2I2lin/HsnRVV2yrQKQBTNvyREQwEdoePPYYcoxbTbBCcC/HDrhpQxkvi/jRxCidXh0mgxWlETsOMINgA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:46:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:46:03 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jinlong Chen <nickyc975@zju.edu.cn>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] blk-mq: use if-else instead of goto in
 blk_mq_alloc_cached_request()
Thread-Topic: [PATCH v3 2/2] blk-mq: use if-else instead of goto in
 blk_mq_alloc_cached_request()
Thread-Index: AQHY7mgW5/9BBHqafE6unoXpmFgeuq4rH/mA
Date:   Wed, 2 Nov 2022 05:46:03 +0000
Message-ID: <8d3e702e-f12a-56e3-19cf-1048d045e7d3@nvidia.com>
References: <cover.1667358114.git.nickyc975@zju.edu.cn>
 <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667358114.git.nickyc975@zju.edu.cn>
In-Reply-To: <d3306fa4e92dc9cc614edc8f1802686096bafef2.1667358114.git.nickyc975@zju.edu.cn>
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
x-ms-office365-filtering-correlation-id: d1c7da0c-91d0-46fe-b858-08dabc95878e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sb8Psz/sFSoQ+sZ8X7GcZRlkpSBXnxv2EnhheIhKD89l1ddbnv0zZ6cRVCb1OK6ZK/WsOBAz9F+uWs96V/qAu6yhDoKeONkTrillLqyfjMo13n/uCZsIgm0QzNdxc+a5DkePpTWvBq8Mf6GCm/NR7SJvALwaf35ay8/OM+Du8RyWfGG6s2s8e0wFwMPO5QICBZPx++EGGVDyXvmH1ypDp3qORW18dHaUHCCeT8B+8nqMUfxTECoqYkuAqcPxNrtgem3DQASpBV9lo2oa1nXthP6/VdFqDWDcXNSydd+NwcdrMD/RaN3Aj+mJwBjY6u8G3qW5UzFXbInGf8d9uyUKVIRDTB6bSohb4vz+T+zeYlsAmJ2Hbl0fvo43N7hdU9fpp7fKYa1+7xm2quVqvL7/QET0SOa5sZbw9KpVueKJoFiRd7gUyg7MADZ+e/115jzYMfbSjiU3VRlcOacw1KOOGdtFK+0Mj2Ved7M30OlYQpQIuD4BBpa7ixRpvgsff5Ut8oDKSXVQFUdXGWgl3+pgHzO9yzY+PC/QVSpamWRay7aEWVkkBwAVlMj/jpOEQ657MIoaoLmPKQ6okCO+xhy+rW23IdYfpMXN2hMYjFkXy/OSrqX+US+lOF8Rp8aTJmazzdzKQ1OzCWxtURGUPbHenxORsmX1vTYKNMCiT7wkxJdrZGKDB54prIdAaiSQDq/yRdpBGT25r6ZloSk3h6vhUDQvRY/kH2GbMEDc9nAFg77Q0Qk1jO+cztemkcZd7oqHUFJmOY2S8oQg+3mhmLttjU7tQuDvmV1GS0a1P7nMuKi1MD740+zSVA6iHNQy5rIgUFo2DI4+2PgHli+3jTypGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(2616005)(86362001)(36756003)(31696002)(38070700005)(558084003)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWQwZ25sNXcwZml6ZE5nOUN1RkVTSEViN3NDRi9DWDRrb0o3aE4wWFB0RVBz?=
 =?utf-8?B?ajUrYjNYWW9ORExTZkxDdkFVVGVaMlFnK0ZRYXMreVN5T1RTbmZLUC83U0hM?=
 =?utf-8?B?aXpWYU9TQ25KbUpGS1NhaUdPa0l1d3RaOTc0V1RWTjlvckRpYUwyVE8wSlI3?=
 =?utf-8?B?dU9zcUNTdHoxVENvelZmcTlvUjJSR0ZHNDJTcmU4TWhad3F1VVdsVVlKb3BT?=
 =?utf-8?B?eCtwRFNwdEtsaVRZblUwanV6WTBJcVZ2V0ZONUl4S3FvSzlYVm5RbE94ek1T?=
 =?utf-8?B?RHpISHAwbXBKWlJmZXVHS0U4Z2RLKzZ3ME85cXYrbHF6eVVRZHBNV1FhR2wz?=
 =?utf-8?B?YXhnbklZVk1waThhSWVVYnZRYzFkRktxT3RscSthZnQzUC9hLzFrVHo5amVx?=
 =?utf-8?B?RmQ4R3hFVUZ6NHVrUXpwT292WWo0ejRMamVRZ0xIdTNPTFk0RWU3NFlDYlRL?=
 =?utf-8?B?Wks5dGVLSXB5OUxabWxrUXF0YWZIOXE1dnZwb3MvYzQyY3hvdVJ0MDhpN2hu?=
 =?utf-8?B?M1RIUUliYnpoWHNFQlorRDlEZ0JqSklRVjh2MkhQeXUyVHM0dXFFaUhZRU9R?=
 =?utf-8?B?NHorM0kvaHhsQUw1VndIZTJ2SkFsZzhWL1ZzY0FXUzgyZE56WG4vTlM1dWlM?=
 =?utf-8?B?cDNkUEtra2c5d0Vkb1JTQzRxZGZuMGxIZ3hMRzYrY3c4d0FvNWFmelRZYytk?=
 =?utf-8?B?enFKOHpFbVpKdDIrMXY0bWxhbVN2WTV6SkxHbXpBVEVpRDJ6LzJnWEFzQms2?=
 =?utf-8?B?TitBWGdod2dwUUhkUndtTU05VTRlUW1KaWJoTW5PeGUzVmJjVnlISzlndmp1?=
 =?utf-8?B?bnJMdFNRNmxWZ3laR2FmQ0ZlRlZQVk1PSWNyUWVFRm9EQnFUMzVHV0FYOGxN?=
 =?utf-8?B?K1IxREt6ZDdDNDNOUWpWUUxZZzVpSHVUSEFuUnpGdE9ac1FMMXFObHczeTJX?=
 =?utf-8?B?ZG04TE8ra0tuNVJaQVo2eDNqaGpkLyswZGR3a3owU0xZNm1YVlUxRVBHTVFs?=
 =?utf-8?B?blBYV0lWcFFEVFpnNHFEV1g5bHRuN1QyMGFKZWZoQzhOYitFaVppN0gyWVpX?=
 =?utf-8?B?L3ZNMjZJbGpXOG8zdWZhc0tyeEJQekFWNVdwWnVmN1M4N0U2bTBqWmc4UEFW?=
 =?utf-8?B?bHhaMnk2bVgxd3Z4MVVxd00xL2FsWjUyTU1vcUZ0TnYzdUxzZUJFR2xzdGZS?=
 =?utf-8?B?bHVkcGIwbGliSCtOQW9WclNrbzRkaSsxZHVVbDNYcytkYWhHQWUraVc5QzJB?=
 =?utf-8?B?d2p4SHB5RWREdTEwMUw1YU1IalFpcFVtRi9qTlI4NTdCWFIySmlQd0Z2M0s1?=
 =?utf-8?B?WjlPeGhEUE8vNlNuOC9JTTllMStEdjV6YzFKeXBMWllhWlQ2bjBFdG9pZ2xW?=
 =?utf-8?B?V0N5ZzhObHRaSDdLSll0c253OXArUHlCT1BOY2RIQnRUaWpsL0lqT1pEalpS?=
 =?utf-8?B?cExPVzFENmNsQWhvOTQvbHhlSnRHWGcwZ29PR1ZWVHo1d1BqN3pJZHMyeXZ2?=
 =?utf-8?B?M2k4d3ZDOEpwVHFVcFlVOXp5c2JXUmx6M2xHSVA2YWx5YzVnVit4VUxRYXc2?=
 =?utf-8?B?empWY0dKOXY4QW40N1FxUU5LaXF0NzI3N21RelBUZDU0MVJYLy8raW9Rc3Ns?=
 =?utf-8?B?bHVIV2E5Q05rcXlUdjVHS0xNdU96dUc2d3Joa3poQk9mczk4Z2sxYTBjaWZX?=
 =?utf-8?B?RDZCT0g1RWVaWGV4WE5IenpkczhmL3BWQUp2WkVsd0kzbHYyb0xyTXpHaDBm?=
 =?utf-8?B?bmw1Rk1NWWZrTHY1WnhRNUU1UGZVelhmMjNoWU5PN0xrUzFDcnZlRW9ZTG91?=
 =?utf-8?B?c3NPUFhGQjVOYnd5S25HTmVOVkp2RHc0TE96aEVSclJmbWZncHJCbEhrOHIr?=
 =?utf-8?B?T1I5bmtFMHVuVS9TWHZIbHQzWU1IZ2F0MXBlTFQvRDl4Y2srOXkzWnFzd2ZI?=
 =?utf-8?B?Zks1NWpkTkRLTUJ3VWZvOElXb3MvVGpINGJWdzBTSG9EWjdzb2hNcy93ZnBG?=
 =?utf-8?B?a0pHTHYyaWxuaUtRS216c3pBWTAwZDdFdjN2ekoxMTVseVhvdzY3UE1wcGhL?=
 =?utf-8?B?ZGpVN0p6TStrUktvTUFiWnBBVnJPdGVBM2k1dWhaOFc1cWR1U0lCam1SaW5o?=
 =?utf-8?B?aHFQa1RGZS9UbjF4SXQzVVFXVEhFNXFTSmtPUkhFcDF2M2pScHpuQ2MwbW9n?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65BDBA30F9BD68429527DBE1B53E0CE8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c7da0c-91d0-46fe-b858-08dabc95878e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:46:03.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Dj7svnn1VHGgvL3w5COhJPWCv21yRqiqouv19qG7h1xKy+C2bVEFSKto8BR+MhGrpjpxWVdMm2KPciTKqLVtQ==
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

T24gMTEvMS8yMiAyMDowNiwgSmlubG9uZyBDaGVuIHdyb3RlOg0KPiBpZi1lbHNlIGlzIG1vcmUg
cmVhZGFibGUgdGhhbiBnb3RvIGhlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaW5sb25nIENo
ZW4gPG5pY2t5Yzk3NUB6anUuZWR1LmNuPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
