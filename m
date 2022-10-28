Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972446115B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJ1PRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJ1PQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:16:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FB77395;
        Fri, 28 Oct 2022 08:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvowjXMnQGRSxZWKFo1ZWWVd9c3Sd/P4CA04bLgYNgxR7YUtpbjoK8A7WminRrd3jSzig20Hii9h56kHIyzmnx/68c8vlopY+NRk8gs5C5/8BV/cm8DaSvmDTgs7ur/uZht5SmIlqXEpBZiqQ0izD0gR1LGZDPszmTzTklmrVp+thqC349QlNEe20+Xy+ClMqfUdcDtgAuXkwvoUWtoa9QYicdFgi5QkRyHbUIYX93dEogazD7ut2obCPzSdPULYM1EqUObrT8LfvBeWdFamCCYyluq4obLfUCGf1ihbSkbMP+pShqcs5hZilS7ZmLhnON6uPgsRi1FyQsBZ4gqbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCsaGtNF19JW0jSlFHADLx7GKVu3GI0HLL1wRz9ROg0=;
 b=Qu2jTQbhCHL4E/s1E/HGvR96z44xoHzxCoo0DQUwza1afauN49CeFsZYQILSWvK5XeZv1r3kBgB8kpyJ3qYHVEZVjl2Cv0ma7Ad9TfnTgmxmRyGm2W/ms3lA5NjqsZ6ijS3q12ykN8tDCfKHgJUMNtQ0E7opAsBxlpQ1hXp2RpMuboCyulqNiZrwAHQuz7j5T/+Ie+yFb5fgGFDhbKFhfWlC6dkaoneEcp5/n/E8wssS4gCNGqYKcHfHNjLHP4zP8kxJ4ZZP5lU0LWy+xQeQsbka9Sf3P8XCUGY34/1/I1qQV8O1fdFKD0ZJKP+GIvCj48M5WrFlR1auMFVx3gFp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCsaGtNF19JW0jSlFHADLx7GKVu3GI0HLL1wRz9ROg0=;
 b=3mmp5h4YmoylcEZGK2GWOdaA/24edT5C57zBEbvydXatePfnhMn6Yv/VKrDQ428SaMuq7gVAL7aFXmMAIeUXEFxnk8RN88Si6wIwfAdANvUxY12IzdlgZO/8peXB3g7dl1cc6U6BYNH4fj2YvNPun8dxlV3gRK2Mik5PKjmtQw4=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:16:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::2d5:77ac:6d39:e57b%8]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 15:16:34 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH v7 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
Thread-Topic: [PATCH v7 05/12] x86/resctrl: Detect and configure Slow Memory
 Bandwidth allocation
Thread-Index: AQHY4neJ4hTGD4nrcE6Q5i66MnBr0q4f0lQAgAFFMICAABUNAIABQIWAgAA0ZACAAVn00A==
Date:   Fri, 28 Oct 2022 15:16:33 +0000
Message-ID: <MW3PR12MB45530F4E7781F0ED5928C0E895329@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604559954.5345.14619487558472213422.stgit@bmoger-ubuntu>
 <c999a7f8-b083-72a6-ff07-201369339c92@intel.com>
 <ef734fc1-8a51-4c60-f73f-2d71fcc54b30@amd.com>
 <e299ce70-ebca-a05f-a1f1-aed6386c379f@intel.com>
 <fbb32df7-df49-7a51-67d8-a8abfe7e1c3f@amd.com>
 <cd4c5da6-6ada-67b4-44f6-6d5796fae8c9@intel.com>
In-Reply-To: <cd4c5da6-6ada-67b4-44f6-6d5796fae8c9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-28T15:15:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b5ddbbcb-3542-4daa-a5c0-2cd6cc6edde6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-28T15:16:32Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 065d7130-e81a-4d73-a7c4-d062017ff1ff
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CY8PR12MB7339:EE_
x-ms-office365-filtering-correlation-id: 2d4992fa-8689-4762-be1f-08dab8f7665e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TERxVuokvPBuyeynqiRczHguDd6hR1dAeb8RpU1wesMMGMuwjq1ywf3IGusDFBZZfweeVCSqdm5YYF9D3Rz3Xeh40CWaKjkCicQ2PkaSqUWVrA6bX0N/yEe+cgdppjbvVu3FY7AQIvaApTmcg3Vhe78/v81IGVD8fX/EAQNScuaZUwil8Ta3BKTl8+bdUDBEGRfQnZSa9fZG8Bwnvn9k26rQXJYr6vVaPu9YZAH2Ff3TPy+4vFpdXFZJBx1Qb+5ucT23AvTizZmqTBlTU8qBGMDCxHvHd/KglvBDoclLdHiJYrpj7so389J4FplSmUeSXPpysfbXkeFxK96iU/8CeZcnqc0WNY2N8aHW5af3fBr7Tjfk/krJLSuBsebXYlcz6eG/ZCPCPAyoiVyl4SE1VKIYs6Vh9mS641EPS2DVa/QFm19+21QmRJgnqrvqTxQZYmZrXRmoLgcto4N/lrsWu8YtPQEvEV65pVJeUqksGqxFzycyUhgcL93+Ao5cExZD133PFdIkbMd6a0uOWQa3Ic2vMOFYZgq6yj4i4PE6H7KY6IN0wd3JYOCJ5o/GLNknMGOzuU/+mEfx75Acm47Tldta4HIh12PUF5BBqiZWMuemBRz5ZPXZtBnGJ1BHUp/0Z3wHtEZUCNcSIh7geu/ChhSi9zmHEgVp9/PA02C62Bzp5y0WGkvztoH5l3Pet7fxIPgJjGVgM2JSlr7pamJRCKIWH2CPUWYeOzh7/LXp8zx8mcLcMLaQ7vCV4oa08rieczI9SJdWmtH2pu2KBe2GWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(55016003)(83380400001)(71200400001)(86362001)(38100700002)(2906002)(5660300002)(7416002)(38070700005)(33656002)(122000001)(186003)(26005)(53546011)(9686003)(478600001)(316002)(54906003)(110136005)(6506007)(41300700001)(8936002)(52536014)(76116006)(4326008)(8676002)(64756008)(66476007)(66556008)(66946007)(66446008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3pMMDFjQ2IvQ1dUd0FWZ3VocWtPL0xoKzRsWkpMbkZTL0VoY1FheWgyYzNy?=
 =?utf-8?B?QXkyWlVkV3FDVWpvRzB4emQrcDd2bjdsaG5ra0xjVUwzK1IrdTNrdVdaTjAy?=
 =?utf-8?B?Zk1mZlN0cFFyQ0xnb1l4L2NGR0hFNFhSUzEvZ2E0WUhpVENIaC9sVXZSNUx6?=
 =?utf-8?B?MThlUWEvbzZBYlpjK1NiUTBiWEY5cGdkWko5WUhPZ3Mxb09FQmNnamFTN056?=
 =?utf-8?B?MnphbEVWeWZIbUlGT1Ric2RrYTR3c2R2ZFNyY202UkpaOG9lT3ZzUjNWbysv?=
 =?utf-8?B?ZDdHWVVxRi9uZXBBUjI0T010ejZyb2tTZUNkWFJ3SnNIc0o1Tm52QXRlNlZS?=
 =?utf-8?B?am91dlF3SXRaSTM4di9Sb0lsTmZXNi85S2VGd0VBNU1qNnhzTTFKTzZnN0tY?=
 =?utf-8?B?YUlkWkNtQUxlenB6dlBkN0Q3eG0ydWYvSWdFQzVmVXFBMDF1S2dnMkpHNW1x?=
 =?utf-8?B?MlJOS2sxbW5TbmtHQ0VJSlpoYjVPUENkK3lFRG1BRWhrYTZXM1Byb2RIK21W?=
 =?utf-8?B?U1R1Y1ZWNGVyVi95WjU1MXVWUWhiT01zaXJybHlOY3c3L2UvM01meEhzUWZX?=
 =?utf-8?B?UGFobCtGWlJQVEQyZ0dVOFk4ajJiS0M0ekljaHhXa0tEeXpyOUxHSzJ4ZGcw?=
 =?utf-8?B?NnE5cUNiMnVqMERRNERwTEJ5VFhzNnFqcTE4ZnVNNHBlTDlwQkdMTTRSWm9m?=
 =?utf-8?B?Mm9SRlpwanBTSXJMOUVhb2lmRW03cFNEQzdPY3ArVmFNakxaeFIzbWNaL2o5?=
 =?utf-8?B?ZTFWS0xGVWx4NGU4QlJHT2ZVd1R5clFhNTdNU0twT0RPbmZqV2tuLzFHd3cw?=
 =?utf-8?B?TFUzbEVWaEd5YVdySEpSM3poTlEydno0RlZYM2REamZHem84RmV5SGd3UHhB?=
 =?utf-8?B?dTkzMVhqNWJwazRwR3pHWUh0SGg4RVdoalBzV204QWMyclRVWlZ5TDhrMnBN?=
 =?utf-8?B?MkNsQnFDV2p0N2MyV3hFL0Vvb3hpTTVjODlYZTk1SThXWUFIeCtNUHp0bXFW?=
 =?utf-8?B?RWp4SHlVL2R0OEVUcm1aYWJacWs2T1p2WFhyMmg2QlQ5OEl4NEgrWVpqaFZ0?=
 =?utf-8?B?VkF3VThkL3FKZU5RMElTZ0tnTmFuM1hLSmxLVnZHYUx2WkNpVW5MamJjWS9S?=
 =?utf-8?B?cTAvVVpwTG43b0dPdjFyYmZ0N2RmZEtrRDZwOE1BZDdoVmRlbkFiZ3IweW01?=
 =?utf-8?B?WHJiYUtBZ3cvaTdYN3dETWR6NE9UL1MvM1BnTGpWb29YNUNKNjgvam9UZ0E1?=
 =?utf-8?B?eE9XWUI5N3RhSUZHaXNKUzc5dW5UZDk4dlMxUU1MeXdEMk9NZURCampMSkp0?=
 =?utf-8?B?cGpxdzJCYkpGd1VEUEMxNm5YZ0hZSTBiWGVFY2FOVTFDMlZRZitCTWZ2U3JC?=
 =?utf-8?B?UFQ3S1ZDODlNdG5ieExLWVM0TEMrUTU1TTRqZjNseFhZcGhOMUdoTWdIdlFn?=
 =?utf-8?B?dkU5UzBoMWlGdXhxZzd4OXR6OGx2aXl5L21yYVA5WmU4UWlNZm91TVpoQnRE?=
 =?utf-8?B?M3JRQVl6aDIyRzgrcHNxQUE5dTlIQk1oL0tYb2lqdG93WGZueDlieUhRZ2di?=
 =?utf-8?B?ZC90QndIMnd2M08vbzVZQ1JJUEpIOVYvdzhES0RmWmxvV0dDcWVZR2VNbUhZ?=
 =?utf-8?B?c1VZVk5CU3pBSzVBckpDQmlkaEdjYVhWMGxvV0E4RENFejdWTHEvbHJCRE9V?=
 =?utf-8?B?YlNpdUdWUndzK0lobjFHemxQOFFHSlNTWnBJa2dicmhjS0psdC91NDl5R2tt?=
 =?utf-8?B?YTE4ckhEaUdlbHJoZk1lczVBWFRTZjJTVXVZZHNqczFJNzNOTTVLQkJ2NW9L?=
 =?utf-8?B?bkJ2OXM2akhLaWNHZCtvL2FjMHpXa05PRDNua3BBR0ZjVnJMVVdjd3FEVmhX?=
 =?utf-8?B?SXloRUxHN1dPbVVhamk0S1JPU3JzR3ZrbWdaNlh4K2lsdVlmMkNzeUZwRGM3?=
 =?utf-8?B?VUJBN3cvNVpuUmNQMExVSVpCNGxyZEd5YnZhK3RhQnlGdmtJcmhUVVRhR2Z3?=
 =?utf-8?B?M1EwSzdMZVlkRzd3OEYzRE1KamNKZDJQYkNDelZST3V1Z2dxaVgwNVZIMVZX?=
 =?utf-8?B?bzBpQklyUXVuUVJka3Z3dk5ubm40cmhVdE9HcUl6c2hKSW9iOFlpWk9uZmcz?=
 =?utf-8?Q?DPqo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4992fa-8689-4762-be1f-08dab8f7665e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 15:16:33.9952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2+8JN5BC6QLOuvMerbX33FZaIGyDUXZQlH+QIv1sEgcWbneVlAKRWlhdanWcBRS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjcsIDIwMjIg
MTozOCBQTQ0KPiBUbzogTW9nZXIsIEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT47IGNvcmJldEBs
d24ubmV0Ow0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVu
OC5kZQ0KPiBDYzogZmVuZ2h1YS55dUBpbnRlbC5jb207IGRhdmUuaGFuc2VuQGxpbnV4LmludGVs
LmNvbTsgeDg2QGtlcm5lbC5vcmc7DQo+IGhwYUB6eXRvci5jb207IHBhdWxtY2tAa2VybmVsLm9y
ZzsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gcXVpY19uZWVyYWp1QHF1aWNpbmMuY29t
OyByZHVubGFwQGluZnJhZGVhZC5vcmc7DQo+IGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMu
Y29tOyBzb25nbXVjaHVuQGJ5dGVkYW5jZS5jb207DQo+IHBldGVyekBpbmZyYWRlYWQub3JnOyBq
cG9pbWJvZUBrZXJuZWwub3JnOyBwYm9uemluaUByZWRoYXQuY29tOw0KPiBjaGFuZy5zZW9rLmJh
ZUBpbnRlbC5jb207IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gam1hdHRz
b25AZ29vZ2xlLmNvbTsgZGFuaWVsLnNuZWRkb25AbGludXguaW50ZWwuY29tOyBEYXMxLCBTYW5k
aXBhbg0KPiA8U2FuZGlwYW4uRGFzQGFtZC5jb20+OyB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1l
cy5tb3JzZUBhcm0uY29tOw0KPiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiYWdhc2RvdG1lQGdtYWlsLmNvbTsgZXJhbmlhbkBnb29n
bGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDUvMTJdIHg4Ni9yZXNjdHJsOiBEZXRl
Y3QgYW5kIGNvbmZpZ3VyZSBTbG93IE1lbW9yeQ0KPiBCYW5kd2lkdGggYWxsb2NhdGlvbg0KPiAN
Cj4gSGkgQmFidSwNCj4gDQo+IE9uIDEwLzI3LzIwMjIgODozMCBBTSwgTW9nZXIsIEJhYnUgd3Jv
dGU6DQo+ID4gT24gMTAvMjYvMjIgMTU6MjMsIFJlaW5ldHRlIENoYXRyZSB3cm90ZToNCj4gPj4g
T24gMTAvMjYvMjAyMiAxMjowNyBQTSwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+ID4+PiBPbiAxMC8y
NS8yMiAxODo0MywgUmVpbmV0dGUgQ2hhdHJlIHdyb3RlOg0KPiA+Pj4+IE9uIDEwLzE3LzIwMjIg
MzoyNiBQTSwgQmFidSBNb2dlciB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+IC4uLg0KPiA+Pj4+DQo+
ID4+Pj4+IEBAIC0yODQ1LDcgKzI4NDYsOCBAQCBzdGF0aWMgaW50IHJkdGdyb3VwX2luaXRfYWxs
b2Moc3RydWN0DQo+ID4+Pj4+IHJkdGdyb3VwICpyZHRncnApDQo+ID4+Pj4+DQo+ID4+Pj4+ICAJ
bGlzdF9mb3JfZWFjaF9lbnRyeShzLCAmcmVzY3RybF9zY2hlbWFfYWxsLCBsaXN0KSB7DQo+ID4+
Pj4+ICAJCXIgPSBzLT5yZXM7DQo+ID4+Pj4+IC0JCWlmIChyLT5yaWQgPT0gUkRUX1JFU09VUkNF
X01CQSkgew0KPiA+Pj4+PiArCQlpZiAoci0+cmlkID09IFJEVF9SRVNPVVJDRV9NQkEgfHwNCj4g
Pj4+Pj4gKwkJICAgIHItPnJpZCA9PSBSRFRfUkVTT1VSQ0VfU01CQSkgew0KPiA+Pj4+PiAgCQkJ
cmR0Z3JvdXBfaW5pdF9tYmEociwgcmR0Z3JwLT5jbG9zaWQpOw0KPiA+Pj4+PiAgCQkJaWYgKGlz
X21iYV9zYyhyKSkNCj4gPj4+Pj4gIAkJCQljb250aW51ZTsNCj4gPj4+PiBUaGUgYWJvdmUgaHVu
ayBhbmQgdGhlIG9uZXMgdGhhdCBmb2xsb3cgYXJlIHVuZXhwZWN0ZWQuDQo+ID4+PiBJIGFtIHRo
aW5raW5nIHRoZSBhYm92ZSBjaGVjayBpcyByZXF1aXJlZCwgSXQgaXMgdXBkYXRpbmcgdGhlDQo+
ID4+PiBzdGFnZWRfY29uZmlnIHdpdGggZGVmYXVsdCB2YWx1ZXMuIFJpZ2h0IG5vdywgdGhlIGRl
ZmF1bHQgdmFsdWUgZm9yDQo+ID4+PiBTTUJBIGlzIHNhbWUgYXMgTUJBIGRlZmF1bHQgdmFsdWUu
IFNvLCBJIHVzZWQgdGhpcyBjb2RlIHRvIGluaXRpYWxpemUuDQo+ID4+Pg0KPiA+Pj4gRGlkIEkg
bWlzcyBzb21ldGhpbmc/DQo+ID4+IEFzIEkgZGVzY3JpYmVkIGluIHRoZSBmb2xsb3dpbmcgY29t
bWVudHMgbXkgY29uY2VybiBpcyByZWxhdGVkIHRvIGFsbA0KPiA+PiB0aGUgc29mdHdhcmUgY29u
dHJvbGxlciBjb2RlIHN0aWxsIGV4ZWN1dGluZyBmb3IgU01CQS4gWWVzLCBpbiB0aGUNCj4gPj4g
YWJvdmUgaHVuayBTTUJBIHdvdWxkIG5lZWQgKHNvbWUgb2YpIHJkdGdyb3VwX2luaXRfbWJhKCkg
Li4uIGJ1dCBub3RlDQo+ID4+IHRoYXQgaXQgY29udGFpbnMgc29mdHdhcmUgY29udHJvbGxlciBj
aGVja3MgYW5kIGluIHRoZSBhYm92ZSBodW5rIGl0cw0KPiA+PiBjYWxsIGlzIGFsc28gZm9sbG93
ZWQgYnkgYW5vdGhlciBzb2Z0d2FyZSBjb250cm9sbGVyIGNoZWNrLg0KPiA+Pg0KPiA+PiBUaGUg
c29mdHdhcmUgY29udHJvbGxlciBpcyBqdXN0IGFwcGxpY2FibGUgdG8gTUJBIGFuZCB0aGVzZSBj
aGVja3MNCj4gPj4gaGF2ZSBiZWVuIGlzb2xhdGVkIHRvIHRoZSBNQkEgcmVzb3VyY2UuIFVzaW5n
IGl0IGZvciBTTUJBIHRoYXQgZG9lcw0KPiA+PiBub3Qgc3VwcG9ydCBzb2Z0d2FyZSBjb250cm9s
bGVyIGF0IGFsbCBpcyBtYWtpbmcgdGhlIGNvZGUgaGFyZGVyIHRvDQo+ID4+IGZvbGxvdyBhbmQg
c2V0cyB0aGlzIGNvZGUgdXAgZm9yIGZ1dHVyZSBtaXN0YWtlcy4gSSB0aGluayBpdCB3b3VsZA0K
PiA+PiBtYWtlIHRoZSBjb2RlIGVhc2llciB0byB1bmRlcnN0YW5kIGlmIHRoaXMgaXMgbWFkZSB2
ZXJ5IGNsZWFyIHRoYXQNCj4gPj4gc29mdHdhcmUgY29udHJvbGxlciBpcyBub3QgYXBwbGljYWJs
ZSB0byBTTUJBIGF0IGFsbCBpbnN0ZWFkIG9mIHJlcHVycG9zaW5nDQo+IHRoZXNlIGZsb3dzLg0K
PiA+DQo+ID4gWWVzLiBVbmRlcnN0b29kLsKgIEhvdyBhYm91dCB0aGlzPyBJIGZlZWwgdGhpcyBp
cyBtdWNoIG1vcmUgY2xlYW5lci4NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL3JkdGdyb3VwLmMNCj4gPiBpbmRleCBlNWE0OGYwNWU3ODcuLmQ5MWE2YTUxMzY4MSAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gQEAgLTI4
NDUsMTYgKzI4NDUsMTggQEAgc3RhdGljIGludCByZHRncm91cF9pbml0X2FsbG9jKHN0cnVjdCBy
ZHRncm91cA0KPiA+ICpyZHRncnApDQo+ID4NCj4gPiDCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9l
YWNoX2VudHJ5KHMsICZyZXNjdHJsX3NjaGVtYV9hbGwsIGxpc3QpIHsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IHMtPnJlczsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoci0+cmlkID09IFJEVF9SRVNPVVJDRV9NQkEpIHsNCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoci0+cmlkID09IFJEVF9SRVNPVVJDRV9NQkEgfHwN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHItPnJpZCA9PSBSRFRf
UkVTT1VSQ0VfU01CQSkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmR0Z3JvdXBfaW5pdF9tYmEociwgcmR0Z3JwLT5jbG9zaWQpOw0KPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXNfbWJhX3Nj
KHIpKQ0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0gZWxzZSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXQgPSByZHRncm91cF9pbml0X2NhdChzLCByZHRncnAtPmNsb3NpZCk7DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwg
MCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9DQo+ID4NCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXNfbWJh
X3NjKHIpKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb250aW51ZTsNCj4gPiArDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dCA9IHJlc2N0cmxfYXJjaF91cGRhdGVfZG9tYWlucyhyLCByZHRncnAtPmNsb3NpZCk7DQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQgPCAwKSB7DQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZHRfbGFzdF9jbWRfcHV0
cygiRmFpbGVkIHRvIGluaXRpYWxpemUNCj4gPiBhbGxvY2F0aW9uc1xuIik7DQo+ID4NCj4gDQo+
IEkgZG8gbm90IHNlZSBob3cgdGhhdCBtb3ZlIGNoYW5nZXMgd2hhdCBpcyBydW4gaW4gdGhlIFNN
QkEgY2FzZSBhbmQgaXQgaWdub3Jlcw0KPiB0aGUNCj4gaXNfbWJhX3NjKCkgY2FsbCB3aXRoaW4g
cmR0Z3JvdXBfaW5pdF9tYmEoKS4gSG93IGFib3V0IG1ha2luZyBpc19tYmFfc2MoKQ0KPiBtb3Jl
IHJvYnVzdCBpbiBzdXBwb3J0IG9mIHlvdXIgb3JpZ2luYWwgc25pcHBldD8NCj4gDQo+IFNvbWV0
aGluZyBsaWtlOg0KPiANCj4gYm9vbCBpc19tYmFfc2Moc3RydWN0IHJkdF9yZXNvdXJjZSAqcikN
Cj4gew0KPiAJaWYgKCFyKQ0KPiAJCXJldHVybg0KPiByZHRfcmVzb3VyY2VzX2FsbFtSRFRfUkVT
T1VSQ0VfTUJBXS5yX3Jlc2N0cmwubWVtYncubWJhX3NjOw0KPiANCj4gCWlmIChyLT5yaWQgIT0g
UkRUX1JFU09VUkNFX01CQSkNCj4gCQlyZXR1cm4gZmFsc2U7DQo+IA0KPiAJcmV0dXJuIHItPm1l
bWJ3Lm1iYV9zYzsNCj4gfQ0KDQpZZXMuIFN1cmUuIFRoYXQgc2hvdWxkIHdvcmsuDQpUaGFua3MN
CkJhYnUNCg==
