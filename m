Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02566839CB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAaW5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjAaW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:57:47 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143F564AD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:57:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlJDmLWmMJ73Yr9J22mFXWRmCYu8oMowrk/vnlEw45uKL3PJG3hHgNb0g3aMz+KmQ9eO4zQzunwB9D5Vj8X0dO4l90kYhlCylk+dwhHEGZvYjhcUvolrdtGiQtFqXzgSrNzTNyJg+P+RI8Nq49F2hABMbrqhVEFgDAfkTTz00LU3+5+Ajdd/tiGPkdyRSXNWNr/FCzRiXkosbMEVNg+87uSNhSsl3K7yQrgya+BCnYxZiUjY0o3csOjFHIsgkEgl9vkCeQpcpSy6CNQwdSQW85htBKOmhcg4SurMOzJaHaCwrCCHeUBzmw+TOPU30gNzJynDrKPNntvO08mF8QTB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ/Fz+pB5FNzGkhpKsEBwxZeiZfT7AQyj7Nfk+pM47I=;
 b=MP/D5EvCsiZGpUdgVx9MsowTn7csmmT/H9yRag2CVcgZrKanQ7iaNRZQu7J92FpNnvhv7I9os42a16Wp8cJwhiQlKvhouPjuEW45eJ78cHRhFi3ETR1Q4ENSZgGQ8fiQSErBphkI1GI+tLWh7ezuW19PUS2g98aAV3RDPX6JolpvwcJIy5B/F15OvlaKcUDW6bSLgDYrlTN/Z10yMJf8TLL0GwmjRKITfx/j2ekkNhTN693otqe0yu0q+5ICVu6m7zi7FDxcESvrbfzMVLiVUjDa0OpgOG04iZ56Wj8eOrLRPVHrNLJVWS810y8Snpn3KhV/IyhKbik6klRC4nopHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ/Fz+pB5FNzGkhpKsEBwxZeiZfT7AQyj7Nfk+pM47I=;
 b=Byfvzv+qmZpOzJvSjAFsxULofBtJDP8OOcjfByEqbXf4EzlRCWFikVic90EcxXtEpq5PXZk0MCAbCwK2qZ8DU4q3tfUjMOeLc7WV4y/PqEdtG1B1Ldb0uTK+nfiXjFoWMH4GsAl8zP1O5nD778YaXZMbS8YGE7Xu1n3uicAsdjs=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 22:57:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 22:57:40 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Katragadda, Mastan" <Mastan.Katragadda@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
Subject: RE: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Thread-Topic: [PATCH 01/19] ASoC: amd: ps: create platform devices based on
 acp config
Thread-Index: AQHZJZstq26EUzIW10CX6vPwn/rLT66ZNzkAgAMUywCAAEzVAIAEHdAAgBfosYCAAC/UAIAAc5XQ
Date:   Tue, 31 Jan 2023 22:57:40 +0000
Message-ID: <MN0PR12MB6101DBF0419C2C565F7F6840E2D09@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
 <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
 <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
 <fa4cdd91-b430-eb1b-a151-d144f62e827d@linux.intel.com>
In-Reply-To: <fa4cdd91-b430-eb1b-a151-d144f62e827d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-31T22:57:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4ba5dc4c-06aa-40ae-b85c-6a5f9a744d54;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-31T22:57:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c1e42b23-a45c-44c2-869e-05833104e7c3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH3PR12MB8076:EE_
x-ms-office365-filtering-correlation-id: 2d0514c4-6ba5-4561-3e27-08db03de8e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcIeFJRk+G74UsaUbPRE7PmXamuCY8aKyD9lh+4eWhVKJdAMyCctd/UG8rSghUpVml+KtLyPJYznOPzCdk+DO6PTXOc0nTMgEatXO3ZlbQWXXI4kBCLtlibiBeWzIatSTqgRd2cjng3rHEhnZoSUsKLQiUgbf/ZMk6k5vn5AVSQ3TTOcf6dd9GOqbVhJnL9bWFifrr/v/pTyAWx4mzP8gq7xQmaygaiXPwDugNmb50Ni8t+Ee0x/94zdjsHt5tRKtJigyzyNUygoGAb3HdMrQOYF3oOkQZGxarJ3b3ET8GKOqOSW/vM2bSyi0Abco/b/Zu+5hlteE9UUTKruDRrrsd3me0O+JRZ3na1WMH0OUotsVzZ8yP0fjVbq4KlNbpI0s0QzDIARTFRJ1+Ii4G0GV1wWlZZbiqxObQzR31v7UcFnxQLlUTuk4P1ALtxL6SqQ4ZpIpI+7P6skuLTVZUGK/cwHf8Yc+FsPpSmjYWBT+dShL/8yjx9p1utUl6e25oUFeFmqezrIbSd36vVQ4Olq6vTE1BBqVT1eaunTK+bD7af27hY+bBb9mAoaZqww41Dh8AMKZv0reJtk9bXO4SZA26NZYfhxgEYcRYBWd5ASXX+iQKU0S/R5y3KY2SNiJL9TS4AT8V2tpMxqkq/K3WRLGxP69PCOwgXznoyWq/2Mcx8ZjTBTNaJyFn5muoeylP4tYfXqoyFpV/zinwWOc2GbDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(2906002)(33656002)(66899018)(54906003)(186003)(478600001)(9686003)(38070700005)(316002)(110136005)(55016003)(41300700001)(122000001)(86362001)(38100700002)(76116006)(4326008)(64756008)(66946007)(66446008)(8936002)(53546011)(7416002)(66476007)(66556008)(8676002)(7696005)(71200400001)(52536014)(83380400001)(5660300002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHg3R1QvQ1lOelYvZlBEd0dueElTb2J1Y0NJaGlPaHYvUEJzUWYwVm15dEt1?=
 =?utf-8?B?WW1HcWNSZzBMTGh0VUMzL0dBV1VVMXdMeFh4cU8ySHQwQ05paFFkZXR2bGFX?=
 =?utf-8?B?T1gxYnhPemY5cllQYXZHenZEVjNPQXFoTjArWkFRcmZ4bExSa0E5aWR3Vy9K?=
 =?utf-8?B?Y2Jkb01FU09XSDhxRmFGL0FrUDdMVVdmY29XOVBQRjVZR3lEYzh0QXVJTDNy?=
 =?utf-8?B?K0hYR3Y5VE9RVTlkTHZzT29sK2tXTmgraVhtWno3Sk95U2NJdFMvOGo2NTJQ?=
 =?utf-8?B?Zi9YRDUrdGgzbHZQdXVsWDd4VFczQmNIUHEycVIwV2xHMnJrd0V1NS9CT3dW?=
 =?utf-8?B?N1pIRTBBc2tJaThIakJlYUs2NDYwaitNT2lGMjRqbUhZRG9ZZlZ4bm1Tb3pD?=
 =?utf-8?B?dTloUlhHWVB0ZCttOE1xYXJCK0F4SnhTRTl3aVBGU0dVNDVUcTZWd2JaYkpn?=
 =?utf-8?B?disvbGRyTGFReWd6YXBrZDBuMzB0a2ExbGV2TWszbkU2SVptNGo4ZVI4WW01?=
 =?utf-8?B?UUVwRngxUWN0bEE4dmZwVlFiWjBZajZXd0R1U011dUE0TUtGNFF2eklnb0Rq?=
 =?utf-8?B?Vk9ZbVJDM3IvNHhiUE9EY0tZcy9peTFoTVlWWnhpSXQzWmFUbzBWNUltK1ZT?=
 =?utf-8?B?ZFRGZ3BXMFNSbFRJdE1xaCtWeXZ3TDhnUjMyL2FFOEQ0dVR5NXlLZldOMWhJ?=
 =?utf-8?B?TzB0Wm1vUHNyeSsxMW5Cc1FNQXFkVkNhd055OGd3ZnV4WnllMWJzVFQyRWE5?=
 =?utf-8?B?SXJqMzNlNG9JQXBHOWRyTk5XVlYvdmZjbDhVTjBNVllXdkxzbFZXYjZ4c3ln?=
 =?utf-8?B?b3VMdFNMMDZFY0Y5R1ZaenRuMHVDcVI2QnJKNDhYZU1jTkVrSHRCZEJ5WEcz?=
 =?utf-8?B?b2tqMEMzaTVLemVwOE9xQm9VMlhnazNuSUo0ZW9RaTIvQjVjQVB2NWdBcmFU?=
 =?utf-8?B?K2dqMThFRHAwUXM2a1didUdUNUk2UU5iTHRkbzkzQ3RjZlE1bmlvQ1dzM0M4?=
 =?utf-8?B?Z1FGS0JKUnBDVkpvTWdOSzZaTlFab1lxSVNpRFJ0S1krak9ldWRvT3BhSDQ4?=
 =?utf-8?B?bmhGZ2NhNVZ0bjByY0JtSXNOSWJvQm9pcFZZZ1pUaTEwUW1RSWZxTXY2M3F5?=
 =?utf-8?B?RU9waHE3L25jU3FKUU5UWUcyQkIyVUxUZ0JlKy9uUk9zSWFKY1RHYzdlLzdZ?=
 =?utf-8?B?UkVZaDdycXlwWk8raVJ3T3V6MkNUSWxKTjNsZGVVNTVHV0ZvY1FhZlVLSWRy?=
 =?utf-8?B?ajc1UXdPR2pjVkhnSkFCYVRwdzl5dmVWWCtvcXA5KzFHaTBsUGFKR2NLYlRR?=
 =?utf-8?B?MmFJdVRNQUxCOFZJNEhkbUxFS1dzbzhzRmZqeGhDU0JqbENNblJCM2tQVW12?=
 =?utf-8?B?VlMvMk9BQTVMZ1lia3NrdUUzdHJLOGx0NDU2VVpFbnpodVpTT20wWnVacEVj?=
 =?utf-8?B?OVlERWlzMTZCYk93Y2hMUy94blkycGdkQ2wra1FJbW5uS0IvengraXZuRjcx?=
 =?utf-8?B?cGhWeDVWVWR5UlAzeEpCc2Z2VENIOGlFalRoeThiKzR1VWJFd29zd2M4Z3VU?=
 =?utf-8?B?RWhTKy80eDd4WnhXT0dBYTVWRTRJclJCdUFOVU96anNFRVRaRzNTNU80RkZh?=
 =?utf-8?B?Uk1vY01LZlVWSnJHZVdRV3AxOUwvRS82U1NzNTdNNmV2WDdOTU5iNEl1bFdj?=
 =?utf-8?B?cHRhaDJ4a1hMY2pKOGhQajVZSjU2NWpKc2ViSnJLY0xLelFLLzZyaFpVWUo3?=
 =?utf-8?B?ckI0YktoRzJGZjN5SGU3TVY1d0NQNDRtMkJVWUpUY3cxV2JFYUxXZnVPUW5a?=
 =?utf-8?B?Q3ZmZTlKVFNwdlVtcDllUlcvTVl4bitWUmNFQVVQS3RXeWZxd0g3dFB2UFdT?=
 =?utf-8?B?K3g5RE9GeEFnVHE0WE10R2M3OWlhekFuVWk1amF5Q29JdFI2cTdIcW1jWjd0?=
 =?utf-8?B?cjdmdk5MMFQyZ05PZjZNcDB4NVEzNURVT3lNSG9kcTNudXRhZ0s3UElUNTRm?=
 =?utf-8?B?bHQ4UW1VSmg5dERNaERxeXlQaWw2aHdGZUduMTZFajVmUVFsOGplS2dPdU5F?=
 =?utf-8?B?OG14WHVoWGszemVJWTJIT09qazFFY3NUMXZzbEFFNWFGQVNZcVNGdUZWUWhy?=
 =?utf-8?B?bHN6dXNXSmxjNDAzSEpLRXNMWmtoZHd0SlQ5ZXZ0RVYwZEVmSXF2MHJMUEw5?=
 =?utf-8?Q?OvEZFipfl1cl0wnOcDgeXJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0514c4-6ba5-4561-3e27-08db03de8e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 22:57:40.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPKuiZOIA12dqhJ32UfdXLwsM15acmG3Nm6HFdUDxHnBRfbsIQhxKVdBPYeouKplUhpMJzXEHeF3xkbJR/wDcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGll
cnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAzMSwgMjAyMyAxMDowMQ0KPiBUbzogTXVrdW5kYSwg
VmlqZW5kYXIgPFZpamVuZGFyLk11a3VuZGFAYW1kLmNvbT47DQo+IGJyb29uaWVAa2VybmVsLm9y
ZzsgdmtvdWxAa2VybmVsLm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnDQo+IENjOiBL
YXRyYWdhZGRhLCBNYXN0YW4gPE1hc3Rhbi5LYXRyYWdhZGRhQGFtZC5jb20+OyBEb21tYXRpLCBT
dW5pbC0NCj4ga3VtYXIgPFN1bmlsLWt1bWFyLkRvbW1hdGlAYW1kLmNvbT47IG9wZW4gbGlzdCA8
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBIaXJlZ291ZGFyLCBCYXNhdmFyYWoN
Cj4gPEJhc2F2YXJhai5IaXJlZ291ZGFyQGFtZC5jb20+OyBUYWthc2hpIEl3YWkgPHRpd2FpQHN1
c2UuY29tPjsgTGlhbQ0KPiBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE5hdGhhbiBD
aGFuY2VsbG9yDQo+IDxuYXRoYW5Aa2VybmVsLm9yZz47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFy
aW8uTGltb25jaWVsbG9AYW1kLmNvbT47DQo+IGtvbmRhdmVldGksIEFydW5nb3BhbCA8QXJ1bmdv
cGFsLmtvbmRhdmVldGlAYW1kLmNvbT47IFNhbnlvZyBLYWxlDQo+IDxzYW55b2cuci5rYWxlQGlu
dGVsLmNvbT47IEJhcmQgTGlhbyA8eXVuZy1jaHVhbi5saWFvQGxpbnV4LmludGVsLmNvbT47DQo+
IFNhYmEgS2FyZWVtLCBTeWVkIDxTeWVkLlNhYmFLYXJlZW1AYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwMS8xOV0gQVNvQzogYW1kOiBwczogY3JlYXRlIHBsYXRmb3JtIGRldmljZXMg
YmFzZWQgb24NCj4gYWNwIGNvbmZpZw0KPiANCj4gDQo+IA0KPiBPbiAxLzMxLzIzIDA3OjA5LCBN
dWt1bmRhLFZpamVuZGFyIHdyb3RlOg0KPiA+IE9uIDE2LzAxLzIzIDEzOjMyLCBNdWt1bmRhLFZp
amVuZGFyIHdyb3RlOg0KPiA+PiBPbiAxMy8wMS8yMyAyMjo0MSwgUGllcnJlLUxvdWlzIEJvc3Nh
cnQgd3JvdGU6DQo+ID4+Pj4+PiArCQlpZiAoaXNfZG1pY19kZXYgJiYgaXNfc2R3X2Rldikgew0K
PiA+Pj4+Pj4gKwkJCXN3aXRjaCAoYWNwX2RhdGEtPnNkd19tYXN0ZXJfY291bnQpIHsNCj4gPj4+
Pj4+ICsJCQljYXNlIDE6DQo+ID4+Pj4+PiArCQkJCWFjcF9kYXRhLT5wZGV2X21hc2sgPQ0KPiBB
Q1A2M19TRFdfUERNX0RFVl9NQVNLOw0KPiA+Pj4+Pj4gKwkJCQlhY3BfZGF0YS0+cGRldl9jb3Vu
dCA9DQo+IEFDUDYzX1NEVzBfUERNX01PREVfREVWUzsNCj4gPj4+Pj4+ICsJCQkJYnJlYWs7DQo+
ID4+Pj4+PiArCQkJY2FzZSAyOg0KPiA+Pj4+Pj4gKwkJCQlhY3BfZGF0YS0+cGRldl9tYXNrID0N
Cj4gQUNQNjNfU0RXX1BETV9ERVZfTUFTSzsNCj4gPj4+Pj4+ICsJCQkJYWNwX2RhdGEtPnBkZXZf
Y291bnQgPQ0KPiBBQ1A2M19TRFcwX1NEVzFfUERNX01PREVfREVWUzsNCj4gPj4+Pj4+ICsJCQkJ
YnJlYWs7DQo+ID4+Pj4+IHNvIHRoZSBjb3ZlciBsZXR0ZXIgaXMgaW5kZWVkIHdyb25nIGFuZCBj
b25mdXNlcyB0d28gY29udHJvbGxlcnMgZm9yDQo+IHR3bw0KPiA+Pj4+PiBtYW5hZ2Vycy4NCj4g
Pj4+PiBBQ1AgSVAgaGFzIHR3byBpbmRlcGVuZGVudCBtYW5hZ2VyIGluc3RhbmNlcyBkcml2ZW4g
Ynkgc2VwYXJhdGUNCj4gY29udHJvbGxlcg0KPiA+Pj4+IGVhY2ggd2hpY2ggYXJlIGNvbm5lY3Rl
ZCBpbiBkaWZmZXJlbnQgcG93ZXIgZG9tYWlucy4NCj4gPj4+Pg0KPiA+Pj4+IHdlIHNob3VsZCBj
cmVhdGUgdHdvIHNlcGFyYXRlIEFDUEkgY29tcGFuaW9uIGRldmljZXMgZm9yIHNlcGFyYXRlDQo+
ID4+Pj4gbWFuYWdlciBpbnN0YW5jZS7CoCBDdXJyZW50bHkgd2UgaGF2ZSBsaW1pdGF0aW9ucyB3
aXRoIEJJT1MuDQo+ID4+Pj4gd2UgYXJlIGdvaW5nIHdpdGggc2luZ2xlIEFDUEkgY29tcGFuaW9u
IGRldmljZS4NCj4gPj4+PiBXZSB3aWxsIHVwZGF0ZSB0aGUgY2hhbmdlcyBsYXRlci4NCj4gPj4+
IEh1bW0sIHRoaXMgaXMgdHJpY2t5LiBUaGUgQklPUyBpbnRlcmZhY2UgaXNuJ3Qgc29tZXRoaW5n
IHRoYXQgY2FuIGJlDQo+ID4+PiBjaGFuZ2VkIGF0IHdpbGwgb24gdGhlIGtlcm5lbCBzaWRlLCB5
b3UnZCBoYXZlIHRvIG1haW50YWluIHR3byBzb2x1dGlvbnMNCj4gPj4+IHdpdGggYSBtZWFucyB0
byBkZXRlY3Qgd2hpY2ggb25lIHRvIHVzZS4NCj4gPj4+DQo+ID4+PiBPciBpcyB0aGlzIGlzIGEg
dGVtcG9yYXJ5IGlzc3VlIG9uIGRldmVsb3BtZW50IGRldmljZXMsIHRoZW4gdGhhdCBwYXJ0DQo+
ID4+PiBzaG91bGQgcHJvYmFibHkgbm90IGJlIHVwc3RyZWFtZWQuDQo+ID4+IEl0J3MgYSB0ZW1w
b3JhcnkgaXNzdWUgb24gZGV2ZWxvcG1lbnQgZGV2aWNlcy4NCj4gPj4gV2UgaGFkIGRpc2N1c3Np
b24gd2l0aCBXaW5kb3dzIGRldiB0ZWFtIGFuZCBCSU9TIHRlYW0uDQo+ID4+IFRoZXkgaGF2ZSBh
Z3JlZWQgdG8gbW9kaWZ5IEFDUEkgY29tcGFuaW9uIGRldmljZSBsb2dpYy4NCj4gPj4gV2Ugd2ls
bCB1cGRhdGUgdGhlIHR3byBjb21wYW5pb24gZGV2aWNlcyBsb2dpYyBmb3IgdHdvIG1hbmFnZXIN
Cj4gPj4gaW5zdGFuY2VzIGluIFYyIHZlcnNpb24uDQo+ID4gQWZ0ZXIgZXhwZXJpbWVudGluZywg
dHdvIEFDUEkgY29tcGFuaW9uIGRldmljZXMgYXBwcm9hY2gsDQo+ID4gd2UgZ290IGFuIHVwZGF0
ZSBmcm9tIFdpbmRvd3MgdGVhbSwgdGhlcmUgaXMgYSBsaW1pdGF0aW9uDQo+ID4gb24gd2luZG93
cyBzdGFjay4gRm9yIGN1cnJlbnQgcGxhdGZvcm0sIHdlIGNhbid0IHByb2NlZWQNCj4gPiB3aXRo
IHR3byBBQ1BJIGNvbXBhbmlvbiBkZXZpY2VzLg0KPiANCj4gc28gaG93IHdvdWxkIHRoZSB0d28g
Y29udHJvbGxlcnMgYmUgZGVjbGFyZWQgdGhlbiBpbiB0aGUgRFNEVCB1c2VkIGJ5DQo+IFdpbmRv
d3M/IFRoZXJlJ3MgYSBjb250cmFkaWN0aW9uIGJldHdlZW4gaGF2aW5nIGEgc2luZ2xlIGNvbXBh
bmlvbg0KPiBkZXZpY2UgYW5kIHRoZSBhYmlsaXR5IHRvIHNldCB0aGUgJ21hbmFnZXItbnVtYmVy
JyB0byBvbmUuDQo+IA0KPiBZb3UgcHJvYmFibHkgd2FudCB0byBnaXZlIGFuIGV4YW1wbGUgb2Yg
d2hhdCB5b3UgaGF2ZSwgb3RoZXJ3aXNlIHdlDQo+IHByb2JhYmx5IHdpbGwgdGFsayBwYXN0IGVh
Y2ggb3RoZXIuDQo+ID4NCj4gPiBFdmVuIG9uIExpbnV4IHNpZGUsIGlmIHdlIGNyZWF0ZSB0d28g
QUNQSSBjb21wYW5pb24gZGV2aWNlcw0KPiA+IGZvbGxvd2VkIGJ5IGNyZWF0aW5nIGEgc2luZ2xl
IHNvdW5kd2lyZSBtYW5hZ2VyIGluc3RhbmNlIHBlcg0KPiA+IFNvdW5kd2lyZSBjb250cm9sbGVy
LCB3ZSBoYXZlIG9ic2VydmVkIGFuIGlzc3VlIGluIGEgc2NlbmFyaW8sDQo+ID4gd2hlcmUgc2lt
aWxhciBjb2RlYyBwYXJ0cyhVSUQgYXJlIGFsc28gc2FtZSkgYXJlIGNvbm5lY3RlZCBvbg0KPiA+
IGJvdGggc291bmR3aXJlIG1hbmFnZXIgaW5zdGFuY2VzLg0KPiANCj4gV2UndmUgYmVlbiBoYW5k
bGluZyB0aGlzIGNhc2Ugb2YgdHdvIGlkZW50aWNhbCBhbXBsaWZpZXJzIG9uIHR3bw0KPiBkaWZm
ZXJlbnQgbGlua3MgZm9yIHRoZSBsYXN0IDMgeWVhcnMuIEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGNv
dWxkIGJlIGENCj4gcHJvYmxlbSwgdGhlIGNvZGVjcyBhcmUgZGVjbGFyZWQgaW4gdGhlIHNjb3Bl
IG9mIHRoZSBjb21wYW5pb24gZGV2aWNlDQo+IGFuZCB0aGUgX0FEUiBkZWZpbmVzIGluIGJpdHMg
WzUxLi40OF0gd2hpY2ggbGluayB0aGUgY29kZWMgaXMgY29ubmVjdGVkIHRvLg0KPiANCg0KVGhl
IHByb2JsZW0gaXMgdGhhdCB0aGVyZSBhcmUgdHdvIG1hbmFnZXJzIGluIHRoZSBzcGVjaWZpZWQg
QU1EIGRlc2lnbiwgYW5kDQp0aGUgY29kZWNzIGFyZSBib3RoIG9uICJMaW5rIDAiIGZvciBlYWNo
IG1hbmFnZXIuDQoNClNvIHRoZSBfQURSIHJlYWxseSBpcyBpZGVudGljYWwgZm9yIGJvdGguDQoN
Cj4gc2VlIGV4YW1wbGUgYmVsb3cgZnJvbSBhIFRpZ2VyTGFrZSBkZXZpY2Ugd2l0aCB0d28gaWRl
bnRpY2FsIGFtc3Agb24NCj4gbGluayAxIGFuZCAyLg0KPiANCj4gICAgU2NvcGUgKF9TQi5QQzAw
LkhEQVMuU05EVykNCj4gICAgIHsNCj4gICAgICAgIERldmljZSAoU1dEMSkNCj4gICAgICAgICB7
DQo+ICAgICAgICAgICAgIE5hbWUgKF9BRFIsIDB4MDAwMTMxMDI1RDEzMTYwMSkgIC8vIF9BRFI6
IEFkZHJlc3MNCj4gDQo+IAlEZXZpY2UgKFNXRDIpDQo+ICAgICAgICAgew0KPiAgICAgICAgICAg
ICBOYW1lIChfQURSLCAweDAwMDIzMDAyNUQxMzE2MDEpICAvLyBfQURSOiBBZGRyZXNzDQo+IA0K
PiA+IEFzIHBlciBNSVBJIERpc2NvIHNwZWMsIGZvciBzaW5nbGUgbGluayBjb250cm9sbGVycyBM
aW5rIElEIHNob3VsZA0KPiA+IGJlIHNldCB0byB6ZXJvLg0KPiA+IElmIHdlIHVzZSBMaW5rIElE
IGFzIHplcm8sIGZvciB0aGUgc291bmR3aXJlIG1hbmFnZXIgd2hpY2ggaXMgb24NCj4gPiB0aGUg
c2Vjb25kIHNvdW5kd2lyZSBjb250cm9sbGVyIEFDUEkgZGV2aWNlIHNjb3BlLCB0aGVuIHNvdW5k
d2lyZQ0KPiA+IGZyYW1ld29yayBpcyBub3QgYWxsb3dpbmcgdG8gY3JlYXRlIHBlcmlwaGVyYWwg
ZGV2aWNlIG5vZGUgYXMgaXRzDQo+ID4gZHVwbGljYXRlIG9uZS4NCj4gDQo+IEkgc3RpbGwgZG9u
J3Qgc2VlIGhvdyBpdCdzIHBvc3NpYmxlLiBUaGVyZSBpcyBhbiBJREEgdXNlZCBpbiB0aGUgYnVz
DQo+IGFsbG9jYXRpb24NCj4gDQo+IHN0YXRpYyBpbnQgc2R3X2dldF9pZChzdHJ1Y3Qgc2R3X2J1
cyAqYnVzKQ0KPiB7DQo+IAlpbnQgcmMgPSBpZGFfYWxsb2MoJnNkd19idXNfaWRhLCBHRlBfS0VS
TkVMKTsNCj4gDQo+IAlpZiAocmMgPCAwKQ0KPiAJCXJldHVybiByYzsNCj4gDQo+IAlidXMtPmlk
ID0gcmM7DQo+IAlyZXR1cm4gMDsNCj4gfQ0KPiANCj4gYW5kIHRoYXQncyB1c2VkIGZvciBkZWJ1
Z2ZzDQo+IA0KPiAJLyogY3JlYXRlIHRoZSBkZWJ1Z2ZzIG1hc3Rlci1OICovDQo+IAlzbnByaW50
ZihuYW1lLCBzaXplb2YobmFtZSksICJtYXN0ZXItJWQtJWQiLCBidXMtPmlkLCBidXMtDQo+ID5s
aW5rX2lkKTsNCj4gDQo+IGFzIHdlbGwgYXMgaW4gc2R3X21hc3Rlcl9kZXZpY2VfYWRkKCk6DQo+
IAlkZXZfc2V0X25hbWUoJm1kLT5kZXYsICJzZHctbWFzdGVyLSVkIiwgYnVzLT5pZCk7DQo+IA0K
PiBjYW4geW91IGNsYXJpZnkgd2hhdCBwYXJ0IG9mIHRoZSAnU291bmRXaXJlIGZyYW1ld29yaycg
aXMgcHJvYmxlbWF0aWM/IEkNCj4gZ3Vlc3MgdGhlIHByb2JsZW0gaXMgdGhhdCB5b3UgaGF2ZSBp
ZGVudGljYWwgZGV2aWNlcyB3aXRoIHRoZSBzYW1lIF9BRFINCj4gdW5kZXIgdGhlIHNhbWUgbWFu
YWdlciwgd2hpY2ggaXMgcHJvYmxlbWF0aWMgaW5kZWVkLCBidXQgdGhhdCdzIG5vdCBhDQo+IFNv
dW5kV2lyZSBmcmFtZXdvcmsgaXNzdWUsIGp1c3Qgbm90IGEgc3VwcG9ydGVkIGNvbmZpZ3VyYXRp
b24uDQo+IA0KPiA+IElmIHdlIHdhbnQgdG8gc3VwcG9ydCB0d28gQUNQSSBjb21wYW5pb24gZGV2
aWNlIGFwcHJvYWNoDQo+ID4gb24gb3VyIGZ1dHVyZSBwbGF0Zm9ybXMsIGhvdyB0byBwcm9jZWVk
Pw0KPiANCj4gV2VsbCBob3cgYWJvdXQgZGVhbGluZyB3aXRoIGEgc2luZ2xlIGNvbXBhbmlvbiBk
ZXZpY2UgZmlyc3QsIGNhdXNlDQo+IHRoYXQncyB3aGF0IHlvdSBoYXZlIG5vdyBhbmQgdGhhdCdz
IGFscmVhZHkgcHJvYmxlbWF0aWMuDQo=
