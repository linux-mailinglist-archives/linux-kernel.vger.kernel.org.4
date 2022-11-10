Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0B62451E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiKJPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiKJPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:07:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D17A1E3D5;
        Thu, 10 Nov 2022 07:07:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzGCVwvZEjoQ+T9lTyhlZ8PJdpXwmiPaScAWrDTUO3U9rfPZBEMJfRosTvuYtp3BdHkijI2QX4LNZ5y73OT0qmlz/YDAXU8XvdTt8vqYc9XcmPU9QpLTeKIoWFPiCHPn+48LRF5GtrEiZgyzJuK8nXqPvgS1mN3i0MzR5dxswLjSp9srXtMswdXHojKCImivnj7DszH3tc3//DuIJW/BN/QIsldOEt4gg1BNI/V82vdVfzWM8ttGy29OFRByF6Q2PnAz6JPGzCWythJcJX4gsgtkR/HvX+rvm88HBIdCJHXzFRqr9g85J/0M3kSbRIU5bgXNuU6WUvcqrEd1CYOuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6ofcGd1UazeeHQUFX48w+n7BnKcYlzPBWiEPLRiziE=;
 b=cxnpL3BAMgY5M7fSfG06t03aB0MLiYUtbHPUh4u22ho0JtaN4TCL+c5yzxCuzzoUGiqh3kEq4yZCAIfseePTTKtfpf+tOS/OGgiHbwLJ0o0HhT9lH0JVr99p8K9v2N/uWXlooZJXbl1tvNDEpgTbT6pIStTS46Bs+aX34p+dXrAaJ0Nwdxar0axgYQ9ERGW/kqytt+xCvDAhNZB9T5PRCArZ0eFh/78HJSR69xEoTpWXXOm/jxDXr4M36wCqr7u0ey/BOF8vcSLvtjpg+X8LATxkbzJWejifYKdG2QLhfm3dIoAvupiQJHF1UNDq7om2LUjSFcIOkpwNknSF8fcMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6ofcGd1UazeeHQUFX48w+n7BnKcYlzPBWiEPLRiziE=;
 b=liv6M6FYFOt0cz+DLyQjsUej8zUH+KS6YasYU+/2zJO3QDHL3sDaCXHdpJj80BD1+nPsqRcn6DHHELqwowMypldOgl600/ppdq/VeeBl3+x9aTupzwc9cl5/HqKITBgxZ5wZf27qWYQqH2BEMw0+ueUHu+GlhBeQo+gVJOg5OIk=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 15:07:45 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 15:07:45 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/8] Documentation: amd-pstate: add EPP profiles
 introduction
Thread-Topic: [PATCH v3 2/8] Documentation: amd-pstate: add EPP profiles
 introduction
Thread-Index: AQHY8tJ7SjPRFZXrqECSdAHvOgmzOa44Q/AAgAAAdEA=
Date:   Thu, 10 Nov 2022 15:07:45 +0000
Message-ID: <DM4PR12MB5278AFCD9770103ED783DE3A9C019@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-3-Perry.Yuan@amd.com>
 <CAJZ5v0hfy2RnCfgaXyX629GxwPyn3Nh4WcMg9cxAisVYELqrYA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hfy2RnCfgaXyX629GxwPyn3Nh4WcMg9cxAisVYELqrYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-10T15:07:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=edb67b18-c861-48b6-adb0-b16c450df871;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-10T15:07:42Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: aaefdc78-f2a8-4240-ac45-5cddd2de850e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|PH8PR12MB7136:EE_
x-ms-office365-filtering-correlation-id: f61ec1ee-3aed-4b8a-fe94-08dac32d5271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3L9RXAz0I5NR0Qo5MlWT7BwHiBka7GXm7iCGA9bA1DKkal+h86j4FH+Gqbo5tvVUdE+OYSERoP+1vf9HSakf+i1plwxFICpSEXJh9zfB8Ce48EOvLNUm756tGH0gAO3rKkBsiXLLQrh43B5DEvp0XpW1M9Hmyult/W0vE8FhJ8iEsGCyvDQDdUFqtZSRXV+ooZjuR7oVxEwIiVaEu+l0NFFitsBfbVC0xmd+++Xr2Cq/Q+AuK7h9hBKgGgUuX06LMr73z45E1x84Zy2nP8Fo2attEjqku/1ZOJeiFF+WbqtNRKnyAT0TRE74nHy3SJYbqX4nFzDFwClrZ2E0CjlqxLrVKZOAx2YphfDLXMif1NgjI5250tqcQQlXiZxOMVj/KhZYAyHvxecrvyqMSykNt+HLNp9JvukNFb/14xxiS/3YksqXRjnJpFZguyfBY0yf5HTUpMVdManZT9SJLWAMjgAaVmJ9PG9Px/Hj6fKQPerPVrBbFwFZEU1gAIIxCeSxdm55rVCZX64s4NpFpoMLMmuSQyL0WpzqYeYNShcncII+oMVHRBIvZhlJZcsfMFXu2lxukyvNtgtH5RQIoDn2SVcBEWr+Wv6jhx7xGtwu2O53bdsihgot1yUsK6yA+fC0fF1N/kOzEQD31NNIVl3xv2B3vEcO1NsZKVhUsQS/rHwChuYW1zDnLgavXbrXh+VjQcwXqLzJagtLjfqSly3+xLAM2NQAdij0Qmja3uEVoBzE4UnN4+mh4k8BoUQE70B3bRg/6FvwjdEAsWRiQFWeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199015)(54906003)(8676002)(76116006)(33656002)(83380400001)(38070700005)(71200400001)(66556008)(4326008)(41300700001)(5660300002)(8936002)(2906002)(66946007)(52536014)(9686003)(66446008)(66476007)(316002)(478600001)(26005)(53546011)(6916009)(64756008)(186003)(55016003)(86362001)(122000001)(6506007)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek5GQnBBU0FhS24rTmVmcjhJcENaVHhZSEVlUTNGekt3bDUzeVpTaWdaQ3VV?=
 =?utf-8?B?b0dVWTlpelhjNUNEcVZ1S05OeFZEanJuektqeHhNWTVQc1g1RWY4TitHblpu?=
 =?utf-8?B?M2tTWHlDUXlWL2ZhZzJaYjhwd1F1SUg5TVBjNGxaOTFqeTRkOTZ3MTRtdDIv?=
 =?utf-8?B?MlV5U01MaUw2c3poanlOcHVLbktjVXlSOUNtQzhUelVYOFlPSFEwNllMVi9X?=
 =?utf-8?B?QnBXaGdyYitTZndjNlNSZVRITlI2a2grMGE4QW9acFBsUldyR040aTgzSDM3?=
 =?utf-8?B?OVRhbC81ZDMySFNTMFR0ZVBEMWU2MDNkS2o5OFlOOTg5OEE1NWR5SC9CTHpN?=
 =?utf-8?B?ZlcwS1p1YTlNakozTm83aWZseXVZZnBkb1NBMHQxUHVXSCthOER3YU11WWlH?=
 =?utf-8?B?a0hSWkFJaFhGYjhVK2xhM0J2TmFSLzB6MDJZNVhDWGhMSUF5dW9kZVdQRjJL?=
 =?utf-8?B?UU9hQzJmOVJBenI4UGJGV2pFUmxFWmVYT0FKbnA0dFNtWVM4aitOcW5JNnY3?=
 =?utf-8?B?NG4vaTV1RmU1enpzWGhta081N3BaWXZxZUNCV3JvZ2JmMkwwS2V6Si9KRU5x?=
 =?utf-8?B?czZ3RGUzZThQQUZ1bCtnYmliN0FFeG1RdkU2K0pEekVyVzFKVTBsR2habWRu?=
 =?utf-8?B?YUZTa3BBN2ZMUGJPV1Zxd3o3S2ZLVFBrMFBvV3J1ekJEVkVBWDNDbDJndi9F?=
 =?utf-8?B?SVE2RW5kbzRCeld3YW1uQXVWajdVOU9jSHc5MTFOcFFpQmRTR2pKRlV1aTN6?=
 =?utf-8?B?TEgzRS83L2JQQm9KSWxhOFIrN3pjcFIyUG5nQjh4RG0zS3A2dlk4OEtnMzdI?=
 =?utf-8?B?WHhlNXFDUEd0N3o4UWZvTnpNdFRQcUhKNm5YYUhSZlVRY2dtL1diSkR0cDlY?=
 =?utf-8?B?N2pQaDY3QVNPanphbSswRG93Q2FabFlReDhjT0h2S3lSOTBxQmpoNllpdmNm?=
 =?utf-8?B?TUdFZEh2NU1oNDlkMTVab2R4YWtUUGs2QkdoWEQ0Z2lLK0tQdFVhQitSSnFi?=
 =?utf-8?B?RkZVTEFRWm1TbmE5ZmpLNldCN29vZ0c0YThDMm4zVDZwaHcwRlEzeUNzM1Zm?=
 =?utf-8?B?b0dTM2FUWUdlSjBYVlF6c2VEZjc0TUFremh3b05wTW44aXJ6UXJndHBnVTQx?=
 =?utf-8?B?emRjQW1uT1F3ZGxnSDc3N3Rsa0lNOTB3RTE0bnN2WTJ6Y0JEQ0h6U3JIVFZ6?=
 =?utf-8?B?MmVaSXR0NzJoWkdpeHJzS3ZVN01vcjRtcU04aXdLOHdQOThOV2I5QXZKYnBE?=
 =?utf-8?B?UGsyYWh1b28yb3RrSlcrL2J3ZTRUOXhoVkZ0NjZzTDJiQUZxL0hCUVNOc3ZE?=
 =?utf-8?B?dVZDKzB0UlpubG9rc1l4U01ZY3BXRDBNZkNXck1NOHREUTlBeTZnZElaL3ZO?=
 =?utf-8?B?ejlLSTRMSXJyNE1SZUxYbGxveVhXYlB4SGNuaHNpcTJRUEQrMFlSeC9lbDBj?=
 =?utf-8?B?aCtORDlxdFhPSmhmUkhURGdKcVRNa0xxU01qL0JqeGUwcE5QdTlaaG1jUGlR?=
 =?utf-8?B?Wmo2ejMxRWNGVlpNN1lVN2gremV3NEt1NmtYRVpidHkzRm1LMVFLaTBsTURN?=
 =?utf-8?B?T1BoUlhQd3lXQ25ZRG1RUnFWK0MzZnFndCtRb25jZG5qYUd1T3Y0T2lKakV5?=
 =?utf-8?B?SDNDT0c0YjA0bis2cDBXaFZvRUF6WndNU3NVOXlZRkM4ZHpNcWJTWUc0Zk5W?=
 =?utf-8?B?MVNYNkd3bTNFVWM2SXlqOHZpSU5jbUhvYVc3YnEyWHVuUnRDY3VEQm1INGd5?=
 =?utf-8?B?NjZ4UjRlVzNyMHpYYjErOG9hc2ovWjVjZ3hXelJrWVV0RjE2cmV4cUdMU3B4?=
 =?utf-8?B?UHBnYnhOL00xV1JyK2htZGt1MEVhdy9mVlM0VHhFUytDR1dUanh2S2pBazlV?=
 =?utf-8?B?dnZiK2t6blNqODduL2VzUngxNHd1YlpoZ1J3eDZFV0lvUTl2cTFsYStCVkxw?=
 =?utf-8?B?cDlWYWZOank2STVZcksveGhFQXd1ZnJIb3h1RjFEYmR4dmFvd1grSTh3bFBX?=
 =?utf-8?B?emZNZ1hrZ3BITmdSZkphYkdiMEFkeDlFVys5UGNFcGJqQXRrTHdacFkxRnJ0?=
 =?utf-8?B?U1kvUTdWYnVHUzNsL2EveEZKMCtNalcyY053UjN0UG5nVXoySmlaN0hjcGty?=
 =?utf-8?Q?ZuxVmLb9NNL+1fQG4qtFtL1v0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ec1ee-3aed-4b8a-fe94-08dac32d5271
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 15:07:45.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIDWhK+KDD4W9uDMlF4KtwhOazQHfeLNBhDxK93+uFtFMKZKWfJd3vPV4aIZwImFHJhSmNmV9wksG8mrDWCmsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbC4gDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFl
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTAsIDIwMjIgMTA6NTgg
UE0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+IENjOiByYWZhZWwu
ai53eXNvY2tpQGludGVsLmNvbTsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+Ow0KPiB2
aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFAYW1k
LmNvbT47DQo+IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47
IEZvbnRlbm90LCBOYXRoYW4NCj4gPE5hdGhhbi5Gb250ZW5vdEBhbWQuY29tPjsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXIN
Cj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVAYW1k
LmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4LXBt
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyAyLzhdIERvY3VtZW50YXRpb246IGFtZC1wc3RhdGU6IGFkZCBF
UFAgcHJvZmlsZXMNCj4gaW50cm9kdWN0aW9uDQo+IA0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ug
b3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9u
IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcu
DQo+IA0KPiANCj4gT24gTW9uLCBOb3YgNywgMjAyMiBhdCA3OjAyIFBNIFBlcnJ5IFl1YW4gPFBl
cnJ5Lll1YW5AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgcGF0Y2ggYWRkIEFNRCBwc3Rh
dGUgRVBQIGZlYXR1cmUgaW50cm9kdWN0aW9uIGFuZCB3aGF0IEVQUA0KPiA+IHByZWZlcmVuY2Ug
c3VwcG9ydGVkIGZvciBBTUQgcHJvY2Vzc29ycy4NCj4gPg0KPiA+IFVzZXIgY2FuIGdldCBzdXBw
b3J0ZWQgbGlzdCBmcm9tDQo+ID4gZW5lcmd5X3BlcmZvcm1hbmNlX2F2YWlsYWJsZV9wcmVmZXJl
bmNlcyBhdHRyaWJ1dGUgZmlsZSwgb3IgdXBkYXRlDQo+ID4gY3VycmVudCBwcm9maWxlIHRvIGVu
ZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlIGZpbGUNCj4gPg0KPiA+IDEpIFNlZSBhbGwgRVBQ
IHByb2ZpbGVzDQo+ID4gJCBzdWRvIGNhdA0KPiA+DQo+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1
L2NwdTAvY3B1ZnJlcS9lbmVyZ3lfcGVyZm9ybWFuY2VfYXZhaWxhYmxlX3ByDQo+IGVmDQo+ID4g
ZXJlbmNlcyBkZWZhdWx0IHBlcmZvcm1hbmNlIGJhbGFuY2VfcGVyZm9ybWFuY2UgYmFsYW5jZV9w
b3dlciBwb3dlcg0KPiA+DQo+ID4gMikgQ2hlY2sgY3VycmVudCBFUFAgcHJvZmlsZQ0KPiA+ICQg
c3VkbyBjYXQNCj4gPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWZyZXEvZW5lcmd5
X3BlcmZvcm1hbmNlX3ByZWZlcmVuY2UNCj4gPiBwZXJmb3JtYW5jZQ0KPiA+DQo+ID4gMykgU2V0
IG5ldyBFUFAgcHJvZmlsZQ0KPiA+ICQgc3VkbyBiYXNoIC1jICJlY2hvIHBvd2VyID4NCj4gL3N5
cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVmcmVxL2VuZXJneV9wZXJmb3JtYW5jZV9wcmVm
ZXJlbmNlIg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1w
c3RhdGUucnN0IHwgMTkNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QNCj4gPiBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUvcG0vYW1kLXBzdGF0ZS5yc3QNCj4gPiBpbmRleCA4ZjNkMzBjNWEwZDguLjc4YzY1MjVk
NWE0OSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2FtZC1w
c3RhdGUucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9hbWQtcHN0
YXRlLnJzdA0KPiA+IEBAIC0yNjIsNiArMjYyLDI1IEBAIGxvd2VzdCBub24tbGluZWFyIHBlcmZv
cm1hbmNlIGluIGBBTUQgQ1BQQw0KPiA+IFBlcmZvcm1hbmNlIENhcGFiaWxpdHkNCj4gPiAgPHBl
cmZfY2FwXz5gXy4pDQo+ID4gIFRoaXMgYXR0cmlidXRlIGlzIHJlYWQtb25seS4NCj4gPg0KPiA+
ICtgYGVuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJlZmVyZW5jZXNgYA0KPiA+ICsNCj4g
PiArQWxsIHRoZSBzdXBwb3J0ZWQgRVBQIHByZWZlcmVuY2UgY291bGQgYmUgc2VsZWN0ZWQsIExp
c3Qgb2YgdGhlDQo+ID4gK3N0cmluZ3MgdGhhdCBjYW4gYmUgc2V0IHRvIHRoZSBgYGVuZXJneV9w
ZXJmb3JtYW5jZV9wcmVmZXJlbmNlYGANCj4gPiArYXR0cmlidXRlIHRob3NlIGRpZmZlcmVudCBw
cm9maWxlcyByZXByZXNlbnQgZGlmZmVyZW50IGVuZXJneSB2cw0KPiA+ICtlZmZpY2llbmN5IGhp
bnRzIHByb3ZpZGVkIHRvIGxvdy1sZXZlbCBmaXJtd2FyZSBob3dldmVyLCB0aGUNCj4gPiArYGBk
ZWZhdWx0YGAgcmVwcmVzZW50cyB0aGUgZXBwIHZhbHVlIGlzIHNldCBieSBwbGF0Zm9ybSBmaXJt
d2FyZSBUaGlzDQo+ID4gK2F0dHJpYnV0ZSBpcyByZWFkLW9ubHkuDQo+ID4gKw0KPiA+ICtgYGVu
ZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlYGANCj4gPiArDQo+ID4gK1RoZSBjdXJyZW50IGVu
ZXJneSBwZXJmb3JtYW5jZSBwcmVmZXJlbmNlIGNhbiBiZSByZWFkIGZyb20gdGhpcw0KPiBhdHRy
aWJ1dGUuDQo+ID4gK2FuZCB1c2VyIGNhbiBjaGFuZ2UgY3VycmVudCBwcmVmZXJlbmNlIGFjY29y
ZGluZyB0byBlbmVyZ3kgb3INCj4gPiArcGVyZm9ybWFuY2UgbmVlZHMgUGxlYXNlIGdldCBhbGwg
c3VwcG9ydCBwcm9maWxlcyBsaXN0IGZyb20NCj4gPiArYGBlbmVyZ3lfcGVyZm9ybWFuY2VfYXZh
aWxhYmxlX3ByZWZlcmVuY2VzYGAgYXR0cmlidXRlLCBhbGwgdGhlDQo+ID4gK3Byb2ZpbGVzIGFy
ZSBpbnRlZ2VyIHZhbHVlcyBkZWZpbmVkIGJldHdlZW4gMCB0byAyNTUgd2hlbiBFUFAgZmVhdHVy
ZQ0KPiA+ICtpcyBlbmFibGVkIGJ5IHBsYXRmb3JtIGZpcm13YXJlLCBpZiBFUFAgZmVhdHVyZSBp
cyBkaXNhYmxlZCwgZHJpdmVyDQo+ID4gK3dpbGwgaWdub3JlIHRoZSB3cml0dGVuIHZhbHVlIFRo
aXMgYXR0cmlidXRlIGlzIHJlYWQtd3JpdGUuDQo+ID4gKw0KPiA+ICBPdGhlciBwZXJmb3JtYW5j
ZSBhbmQgZnJlcXVlbmN5IHZhbHVlcyBjYW4gYmUgcmVhZCBiYWNrIGZyb20NCj4gPiBgYC9zeXMv
ZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdVgvYWNwaV9jcHBjL2BgLCBzZWUgOnJlZjpgY3BwY19zeXNm
c2AuDQo+ID4NCj4gPiAtLQ0KPiANCj4gU28gdGhlIGludGVyZmFjZSBpcyB0aGUgc2FtZSBhcyBm
b3IgaW50ZWxfcHN0YXRlIEFGQUlDUywgd2hpY2ggaXMgZ29vZCwNCj4gYmVjYXVzZSBpdCBpcyBh
bGwgY29uc2lzdGVudC4NCj4gDQo+IEhvd2V2ZXIsIHRoZXJlIGlzIHNvbWUgY29kZSBkdXBsaWNh
dGlvbiBpbnRyb2R1Y2VkIGluIHRoZSBzdWJzZXF1ZW50DQo+IHBhdGNoZXMgYW5kIHRoYXQgbWF5
IGJlIGEgcHJvYmxlbSBmcm9tIHRoZSBwZXJzcGVjdGl2ZSBvZiBtYWludGFpbmluZyB0aGF0DQo+
IGNvbnNpc3RlbmN5IGluIHRoZSBmdXR1cmUuDQo+IA0KPiBIYXZlIHlvdSBhdCBsZWFzdCBjb25z
aWRlcmVkIGludHJvZHVjaW5nIGEgY29tbW9uIEVQUCBzdXBwb3J0IGhlYWRlciBmaWxlDQo+IHRo
YXQgY291bGQgYmUgdXNlZCBieSBib3RoIGludGVsX3BzdGF0ZSBhbmQgYW1kX3BzdGF0ZT8NCg0K
SSB3aWxsIHNlbmQgdGhlIFY0IHRvZGF5LCB0aGF0IHdpbGwgY2hhbmdlIHRoZSBlcHAgdmFsdWUg
c2V0IGFuZCBnZXQgaW50ZXJmYWNlIA0KVG8gYmUgY29tcGF0aWJsZSB3aXRoIHRoZSBHbm9tZSBw
b3dlciBwcmVmZXJlbmNlIHNldHRpbmcgc3lzZnMgY2FsbCwgSSB1c2UgdGhlIHNhbWUgcHJvZmls
ZSBuYW1lcy4NCkJ1dCBWNCBwYXRjaCB3aWxsIHRoZXJlIGlzIG5vIHJhd19lcHAgIHN1cHBvcnQg
YXMgdGhlIHN1Z2dlc3RlZCBieSBNYXJpby4gDQpJICB3aWxsIGFsc28gdGhpbmsgYWJvdXQgd2hh
dCBlbHNlIGNhbiBtYWtlIGFzIGNvbW1vbiBjb2RlIGluIHRoZSBkcml2ZXIgc2NhbGUuIA0KVGhh
bmtzIGZvciB5b3VyIHN1Z2dlc3Rpb25zLiANCg0KUGVycnkuIA0K
