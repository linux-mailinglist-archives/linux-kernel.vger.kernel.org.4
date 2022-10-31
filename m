Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A3613E69
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJaTje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJaTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:39:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915E12D30;
        Mon, 31 Oct 2022 12:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjMrC6iMUlG4DPnF+6UbbWSGB2oy8E/QGJyFgyyyjadS+jvbo0XSB3Cpx4axWazrV5OjVN5gxAQGP80JU7ySK4G06Gq2r6PmxxIkxAWRkMZMXt1W2grMMwXY51VkWyQXxC/uFoMFltIn3WMeFo4c/oFxfsvJGC1SLGR9a72dxq4LAXeB7F7Lzg/AeiPESw/ssT9vJHJv+yM1Jgl32tEdjKRE+aqmw9hHkMu118enDlRo6mP7L5OIkj/To1qYH0wZgvfQ8waZhPDEE4v9+iNnBXrPoBaLFJ+s9TwWMO2+VuEhaJ7IlliRHpfcSpxFhrsAoU655kNn73AKo/0lt5vrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MykHFNqFSSaX+CQ9wS5Xxc27wZku7A5gI0ODXnSd+2s=;
 b=Ty00hS2adhuP/cP9XxVSLXiUQUzPoNrfgHSc2bGTRQb7QIkFOQSux1LOyy6wrCX52UVcZ/tq7lv/k2X7jB90t4L8q1c1qgd2qOCVgvU4l3r5f4DcdzR7FgxwedEb6hjkGFrCCjehQwlpXUQKf99eYUmHpaU/hhBqagS+XMU7de0BNBtsMeQW+h4Hs5zljNUqjG0tydAF1Fa0kTRZzXRZOxwYGLi/kECn0/KrNS6ggSk6IwDTrTuQnkeSKAQCQg6EhaX//EMuoV6xiBWmHRBmUR1dlERru3qWge8yQKSCbvf9z6SEru6+GB16B4hKLoAbM9R3GhW7zNPxQ6XlBz0uPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MykHFNqFSSaX+CQ9wS5Xxc27wZku7A5gI0ODXnSd+2s=;
 b=nKl+3KgBV3oDHvo9iNSdf/N4C4TODWSGwFes0Ds67QYuNiTQ57ZGC5owMiiOZuWj9y/++g6xMejzxYOWSY+Viw46wa7DTIfDhNlT752kEAPe/YmBFdVDUWgT+PcCXPEV1I/72G7g28ftvV/dcjzhNRTL65P977OQQOx8BxJyeC0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 31 Oct
 2022 19:39:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Mon, 31 Oct 2022
 19:39:29 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: RE: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
Thread-Topic: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
Thread-Index: AQHY6hfBjWF6tgClnky1tqSxunvCJa4iYLoAgAAAdbCAAAKFgIAAAwEAgAJeKQCABCXIIA==
Date:   Mon, 31 Oct 2022 19:39:29 +0000
Message-ID: <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com>
 <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
In-Reply-To: <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-31T19:31:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6a86d194-6f40-4756-a5db-5525795618c1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-31T19:39:27Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 32d98418-f007-4cc7-b1b8-a81897669145
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS0PR12MB7533:EE_
x-ms-office365-filtering-correlation-id: cd8b82f9-b96e-4595-05fa-08dabb77a067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvqr3LNdP3bUd7a5FqytG0QsDVGHLGLlpN2HF6s+xlk3ZI5ksTOjScyi2Ui7sO0TrvCgdI67JRhk2hZH/PnfaoFnELhJyoQwaUVE4XxtS0jP3umhoTkSPbPvYabWhcEBJeLHwjwV/5VVRxUrkFds0LbEdOl1inQHMiwXb35+GLxECjHi3yfcbetAyPqVIEG9VAUV9aFwONIcZRy0NV3DBOPkIIblH0jkqJOuD/BaKAHQCsBmuU39LxsMv+0v+1RKq8JbBhjm32tM0NdXqYDhs2syzrVlB6XWYNQVpg5iuNImnNCRrzXcbMiN0Lsnk8VQO5GMaNsMjEi30DoEiNXYLaFoFzztdI3+wQwjBtP6uCFCHOtkQSajEINX9SHJrU/FXxmOkeQvQVgwsPugcCTu2W14sO3gB33UVaojQs+HHjxVvQlc95FCNXQXr5h0fA7MrAKS0IGRV2GW/d1nNlKBXmmAaJ0tJA5YHjwiFfdu4xabWTiUCivWhc866T/j86k3hA/wKpfDRWd0cLr/zRSSnvuhqkZHWx0o76RT1C86kD3DqY9wMABN+FBb37zBV+SaXT19iTpIhtWOkVmCp85IkfOUd63M7+R819mrGJFi2Zty+5wtw1sO7KIWaW1OEgGpHdtlAz8VLKhTs0e1o2VCI3biRXG11Fm3Ko/QlFD0J7xeTNOaGK/CQxzAY4ckzQ8/h4kmbGlDbmuVVt9hHdHU5045omj+qGZKPZrqLmjoo8/HrNQX8Oq+QAO6KNKuqpx4Mwc7hNFX8gBN/1l+J+WAC/6nH1N89aq7Yc3+ekv6XMQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199015)(86362001)(38100700002)(316002)(53546011)(7416002)(4326008)(38070700005)(122000001)(71200400001)(66946007)(8936002)(8676002)(2906002)(64756008)(5660300002)(478600001)(110136005)(66556008)(66446008)(52536014)(76116006)(54906003)(83380400001)(186003)(6506007)(7696005)(41300700001)(66476007)(9686003)(55016003)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFVidEhVSHB1Q0tSZkp2bDgxS0oydUlNdGdDb24waTQyNi9QNG92VklWbkdo?=
 =?utf-8?B?MGRTcmJDTWl5Ykw4ZjdoWmFUZlN1U2VITit3ZG1TR0UveDJ3eUg1UFpLN04z?=
 =?utf-8?B?ckZRZWVHcXAySjg4WkFiZStWTjlsOWNnZUN1cnVqZ2Y2RzBtQjRSanplQytM?=
 =?utf-8?B?MUtvN2tqRXJlVFBYb09saTNhamJkdnpGZkpET1cxZ05SZU1aZGtHSjRFdklJ?=
 =?utf-8?B?TSsrRXovbURTM2NvdXl0ZDNDWHJsV25IZFViK1VmSjZ5dG55bkt4dVFXVDR6?=
 =?utf-8?B?RlRKVzFIYlF2SDJRcTVGaVZzMi81elhMenQ5amVZSnN3dXVUcy9GSlh2OGRp?=
 =?utf-8?B?T0ZzZXdVYm93YVdza2I2c3orcHQwbEFiOU5YWm9NLzRjaGV2RHZxdHZpcFlU?=
 =?utf-8?B?dXN3a3htL3lUTHdqSkJMaXNEL3pmL2VlSzUvK0pGOUdndG52L0VHL21kQTd0?=
 =?utf-8?B?cnRrYmN1ZnZKUnJMNG9ZMENiMkFKVzhZZTQvdXFPQkxhQjBrNjJJWENMTmIz?=
 =?utf-8?B?OG9uU0VUK3FKZVk1MjlETG1jeGQ2Q2FGU1QybXg0aE8yc1YraGFIM0RjcE5s?=
 =?utf-8?B?MmQ4cmhhbkxYQmhGUnNzRFg0Z2JkNHd5eHUxRFl2aDY1ZDluenAxcUVMZmRF?=
 =?utf-8?B?N0l3Mkl0MSs5RDhoUEFpRGlyNnpGZmZvbFVqWFFPOGhHUmNTYUxuMzhUWTFE?=
 =?utf-8?B?cStxdDN4NG1LMFQvTUJsYmsweWp3OWZGSVdVTGUrcStXazkrYVJQREorUHla?=
 =?utf-8?B?czlhWTR5QmFmVitVY1Rjb00vSXdla1l2UndaQ1c5MEZPRzJZUFhYRy9OZCs3?=
 =?utf-8?B?ZmJYQmZiM1IzbGZNV1ZybTJuVkI0TW80UFRLTTYrMXVWaGhob0VKRVpkZUx1?=
 =?utf-8?B?SHA4ZWdiWHNxd0pwd3QrWTZUalQvR2ZuanRBejFrUEtGdVJYTFpaVGxMeHpn?=
 =?utf-8?B?OW1UcUF3akxua29xWlMySTI3OGRZK0NWMXZ2cm5vM0tqWEljOGw0UXp0ZjZx?=
 =?utf-8?B?d1BPbm9kMWZ2QUx0enNqc21NdHkrSzRreERZNEJVazIvTk9lVUlIeE9NNjFw?=
 =?utf-8?B?VWFWWk13dDMzQnExQ3RZVi9HcTVrQS8wVXh0TDF5amFLQlNGTDJNK1NvbWdq?=
 =?utf-8?B?UUNsUEJlTWxZaUJxcFlYRElsTnlIYkFyZytYMkIxbm9ocnRNS2dpVXA1a0Uv?=
 =?utf-8?B?N0lHMFphSklhNWsvVjdUTzQxTTBKWitmYUVkM0ZBNFJ1U0FCY1UyOU4rUWF0?=
 =?utf-8?B?RGZYZmJiUzhZekZUS3U1N3BJWXdnL3I3c0tKUml1ZmJ2Wll1b1o5ZVBQMnlm?=
 =?utf-8?B?L2oxcjR1MkRwL3orUzZKMWRNb2lpTnA0UExZQmkxZVJQMlgxZ0o4TVFaS29R?=
 =?utf-8?B?SVZhTGtjaFNYS3c3dlltVTRTZnJTemRiYTBuWlU3YjZKQkFkbUtuQmVrV2pQ?=
 =?utf-8?B?M2NPRk43Z2QwRVlVa05xb3hlbEt5TnZpWmtyTUltUndLYURlTUpEQVEvbncx?=
 =?utf-8?B?L1hrVTRtUUd1Vm41RWZlU2x1Z1RCeG84YTNRUUcvSjNPVURoYmVhZkE0L0NT?=
 =?utf-8?B?WUY0UUxZdHJZL3lXV0VuZmJTUHROS2dwWStSMHhMZUxBSkZQMXZaM3BFU2xV?=
 =?utf-8?B?c2t2TW02bVF1S1h1WnkvWWFnMGJXWFRTekZETm9adnpvcTcrVVU2U245T2Uy?=
 =?utf-8?B?Skk3Z2JnQ2daSFNHWFE0YXZZbzJmOFRZSU5ScmV1SWFFY0RQRDBJcEdzbG9q?=
 =?utf-8?B?N2M1MkV6c1p5dkpyQkNjVW1CL1YyTTdBR1NnWDBhYjdVVmc4cWdYZmc3MHZW?=
 =?utf-8?B?RENtaGNzaXloajRhQ2VGclkvQm9KekRTQ0FsR3RtTzAvekErZnV2WXJvRElo?=
 =?utf-8?B?WnpvUlpJcjFFdzAyRU44YVliaWlrakg2M0NydVFQcWYvL3QrcERKY1NWaGFV?=
 =?utf-8?B?TWNnREI5bEIyc2hGOHZtanE2ZnphYmRtRXRuTWFxY0tReld6RStRRlpSYm9j?=
 =?utf-8?B?aWZFd2grZ1R3VnV5OEduQ1NUZ1NRcFZSZUhsbEVMMWkvVDU2NXVmdWFLbmhE?=
 =?utf-8?B?d1FqMHhvK3NWS0VyV04zSnB3bGhUcENqRlRnMG1MOVdGa0QvSDlSNTd6bXFD?=
 =?utf-8?B?NnN1UFFRbDVQZ2Q2SDdDWDdXazkwN2V2ajF2VEZNMm5JSmIxTUVyaW1XY2Ro?=
 =?utf-8?Q?swymDLEnWmcdHTxvmkSzajs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8b82f9-b96e-4595-05fa-08dabb77a067
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 19:39:29.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+nUNl3LGnKuUQHlSH4Xt7Tg2vOAHIdd678VlMK7SYXMshgNTbKIVovrztzbUQ8xb29R2br/71Gg8TWpUjhnmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,THIS_AD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdmVuIHZh
biBBc2hicm9vayA8c3ZlbnZhQGNocm9taXVtLm9yZz4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVy
IDI4LCAyMDIyIDIzOjEyDQo+IFRvOiBSYWpuZWVzaCBCaGFyZHdhaiA8aXJlbmljLnJham5lZXNo
QGdtYWlsLmNvbT47IEhhbnMgZGUgR29lZGUNCj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+IENj
OiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBMS01MIDxs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IFMtaywgU2h5YW0tc3VuZGFyIDxTaHlh
bS1zdW5kYXIuUy0NCj4ga0BhbWQuY29tPjsgcnJhbmdlbEBjaHJvbWl1bS5vcmc7IHBsYXRmb3Jt
LWRyaXZlci0NCj4geDg2QHZnZXIua2VybmVsLm9yZzsgUmFqbmVlc2ggQmhhcmR3YWogPHJham5l
ZXNoLmJoYXJkd2FqQGludGVsLmNvbT47DQo+IFJhZmFlbCBKIFd5c29ja2kgPHJqd0Byand5c29j
a2kubmV0PjsgUmFqYXQgSmFpbiA8cmFqYXRqYUBnb29nbGUuY29tPjsNCj4gRGF2aWQgRSBCb3gg
PGRhdmlkLmUuYm94QGludGVsLmNvbT47IE1hcmsgR3Jvc3MgPG1hcmtncm9zc0BrZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBwbGF0Zm9ybS94ODY6IGludGVsX3BtY19jb3Jl
OiBwcm9tb3RlIFMwaXggZmFpbHVyZQ0KPiB3YXJuKCkgdG8gV0FSTigpDQo+IA0KPiBPbiBUaHUs
IE9jdCAyNywgMjAyMiBhdCAxMjowMiBQTSBSYWpuZWVzaCBCaGFyZHdhag0KPiA8aXJlbmljLnJh
am5lZXNoQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gSSdkIGFkdmlzZSBhZ2FpbnN0IHRoaXMgcHJv
bW90aW9uIGJhc2VkIG9uIG15IGV4cGVyaWVuY2Ugd2l0aCBTMGl4IGVudHJ5DQo+IGZhaWx1cmVz
Lg0KPiANCj4gT24gVGh1LCBPY3QgMjcsIDIwMjIgYXQgMTE6NDAgQU0gSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4gSSdtIG5vdCBhIGZhbiBvZiB0aGUg
Y2hhbmdlIHlvdSBhcmUgc3VnZ2VzdGluZyBoZXJlLg0KPiANCj4gVGhhbmtzIGV2ZXJ5b25lIGZv
ciB0aGUgZmVlZGJhY2suIExvb2tzIGxpa2UgdGhlcmUgaXMgY29uc2Vuc3VzIHRoYXQgaXQncw0K
PiBub3QgYWR2aXNhYmxlIHRvIHByb21vdGUgdGhlIHdhcm5pbmcuIFdlIHdpbGwgbW92ZSBmb3J3
YXJkIHdpdGggY2hhbmdlcyB0bw0KPiBvdXIgbW9uaXRvcmluZyBpbmZyYXN0cnVjdHVyZSBpbnN0
ZWFkLg0KDQpEaWQgeW91IHNlZSB0aGUgaWRlYSBwcm9wb3NlZCBieSBEYXZpZCBCb3ggdG8gaW50
cm9kdWNlIHNvbWUgaW5mcmFzdHJ1Y3R1cmUgaW4NCnRoZSBrZXJuZWwgZm9yIHRoaXM/DQoNCkp1
c3QgdGhpbmtpbmcgYWJvdXQgaXQgYSBsaXR0bGUgYml0IG1vcmUsIGl0IGNvdWxkIGJlIGEgbG90
IG5pY2VyIHRvIGhhdmUgc29tZXRoaW5nIGxpa2U6DQoNCi9zeXMvcG93ZXIvc3VzcGVuZF9zdGF0
cy9sYXN0X2h3X2RlZXBlc3Rfc3RhdGUNCg0KRHVyaW5nIHRoZSByZXN1bWUgcHJvY2VzcyBkcml2
ZXJzIHN1Y2ggYXMgYW1kX3BtYyBhbmQgaW50ZWxfcG1jX2NvcmUgY291bGQNCnJlYWQgdGhlIGFw
cHJvcHJpYXRlIHZhbHVlcyBmb3IgdGhlIGhhcmR3YXJlIGFuZCBjYWxsIGEgZnVuY3Rpb24gdGhh
dCB3b3VsZA0KcG9wdWxhdGUgaXQgd2l0aCBlaXRoZXIgYSAiMCIgb3IgIjEiIG9yIG1heWJlIGV2
ZW4gdGhlIGFtb3VudCBvZiB0aW1lIHNwZW50IGluDQp0aGF0IHN0YXRlLg0KDQpXZSBjb3VsZCB0
aGVuIHJldGlyZSB0aGUgZGVidWdnaW5nIG1lc3NhZ2VzIGZyb20gYm90aCBkcml2ZXJzIGFuZCBp
bnN0ZWFkIG9mDQp5b3VyIGluZnJhc3RydWN0dXJlIHJlbHlpbmcgdXBvbiBzY2FubmluZyBsb2dz
LCB1c2Vyc3BhY2UgY291bGQgcmVhZCB0aGF0IHN5c2ZzDQpmaWxlIGFmdGVyIGV2ZXJ5IHN1c3Bl
bmQgYW5kIHJhaXNlIHRoZSBhbGFybXMgd2hlbiBpdCdzIDAgKG9yIGlmIGl0J3MgcG9wdWxhdGVk
IHdpdGgNCnRpbWUgc21hbGxlciB0aGFuIFglIG9mIHRoZSB0b3RhbCBzdXNwZW5kIHRpbWUpLg0K
