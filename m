Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551F37167F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjE3PwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjE3PvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:51:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3FFE45
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:50:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0kH+yjg03mhSAzGRz3ArZs5LwRfkHxZL9ollKG/X7oKLQgE2s748BZVKDjtfMTN+j2B2yjmP4Zpx8sXaMTuC+7xmsfHjeX7CgmyX8cG6emNAmTJjAUAglWsJev5p7PlGtF6XB7AzB7bpTTEMJdL+MG12ziQg3tBIHk6yUpVqf+at/0FeAn44oUjsdAzcxpbI7rh1riD6Qo0nQ1fEmno3Xa0qJ6sIDE1RZLDqM4l2+4810LXFah4wTJctwdqmndovxZGtX8uIL7veTF5wwZcGxmCexsSZ7f+uEElBe2Q7d/s8g4xv0ooVz7vEY2HM8heVMrNnKOIfEWEerkD6D+UhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4OQKZDErOU1UfFLnXoY/b/zNP8PaDQj496aiwIBcls=;
 b=GL2YCCKv5P3rwgNvJ8r+n7dEgCpOlaDsQCgk7Jl/8mf7UF5iwJHSFIt+s+mljgMOFOeCsLfOjdiz7EfI0t1yH4Ib1RrAnI8huoUWpz/t9szWBUQy/KEejuAfqsGi+EAuVYSg/0FVqUS3KdXgYVn4S+vXK6kDzFGxHLOL4wUxFbqv3wiVhjEwpQMzwNZAF+XJ44yqEuXueXecdG1iZ/OqYjJsQFaE3bhNaVqoI2m2mG5SlcWMuhZpmumh1sFtmbZqOZ+d6Y1e98eEWSrQN0qTyVllGR9nSdJu94pdirDgpSFQSTuBB7KLrKO8l1UN/eIAi0282aUlJGBhSaK4haOS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4OQKZDErOU1UfFLnXoY/b/zNP8PaDQj496aiwIBcls=;
 b=AQyfkJpj8rDNesUgk5bARAl4ay3TiVm5SQ4bhcWlMJR++/lkq54ydKepPoo2+2ubIG0EXvi/5nCnAEbLNvcAiVlE7uhQKJeoSqrnHrlIk2jhCmc97uLFI/twV6eI5K45TW4+KlwQG97EcFt9AqLaKMnjLpj16ikMVqN0NBZSPOE=
Received: from DM6PR12MB3996.namprd12.prod.outlook.com (2603:10b6:5:1c1::31)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 15:50:33 +0000
Received: from DM6PR12MB3996.namprd12.prod.outlook.com
 ([fe80::e436:6d53:7445:88b8]) by DM6PR12MB3996.namprd12.prod.outlook.com
 ([fe80::e436:6d53:7445:88b8%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:50:32 +0000
From:   "Ho, Kenny" <Kenny.Ho@amd.com>
To:     "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>,
        Andrew Davis <afd@ti.com>, Peter Foley <pefoley2@pefoley.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
        "Zhou1, Tao" <Tao.Zhou1@amd.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "Zhu, James" <James.Zhu@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Li, Candice" <Candice.Li@amd.com>,
        "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/amdgpu: introduce DRM_AMDGPU_WERROR
Thread-Topic: [PATCH] drm/amd/amdgpu: introduce DRM_AMDGPU_WERROR
Thread-Index: AQHZjyd9xmQrPkt7AE6NNnI82OsITa9y93aAgAAGaVg=
Date:   Tue, 30 May 2023 15:50:32 +0000
Message-ID: <DM6PR12MB3996064F09E1C2FD782CC944834B9@DM6PR12MB3996.namprd12.prod.outlook.com>
References: <20230525163827.548058-1-hamza.mahfooz@amd.com>
 <85f47623-5ef1-b817-195b-c4ae39564247@amd.com>
In-Reply-To: <85f47623-5ef1-b817-195b-c4ae39564247@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-30T15:50:32.189Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3996:EE_|BY5PR12MB4952:EE_
x-ms-office365-filtering-correlation-id: 74a2f24f-19bd-4a18-0794-08db612599fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJxRxRUWfNhpmp+IxIAFV+XYJfAbWPxW0NXuhDxSlsiTGN9oSBOk7O00JMmFCEaDJFLGcfyt4ZtFeEuUkWLsCLAaOBdSZJt46TyZ6687+YlypDl9Cdy6JFWG+pviqGF6m1UUUr8WDVO5+j2CigY9c7XYmYWfGaewzXiKktHovOV2ul6PjwwXPQhKmauxINr1vWDQL5AnHvnBK7qEaQ4LglGes5sbCEp5CO/RfAzaX6Qxb/yjaGQDPdzSMEm7//lVZg4h75tpZI7NsRTEyIGIa7r1MMTtZTm8XeFPaPQfQhp40kdmWsIDMEn3enXdYL81uriQKD7HynY6T7jE/JtnaBZpf2hl1oZfK73vCyssyVuzB5BxKvseRCJ79+lTLHrbGnXVPt7XJ2UsBI1ui7cjFJsg3VqbbiZ8HY/oPqN1Q14qPXmhaT5euKJwuhyeVcG5x9ESDeo3p9Dv9mrPRsp+98c/yuXHmmJ0sn0yoeQ/aJRXterqOOJ+59QjO0i2zuktbcRblai8XEO1zm4NEU31+zrJR3fchySEbQPCJRK12Cuw8QDf9ZjcsNblMkvVcdQNgh9FoXciShfHBmcETTHNHr97aCMegOJdC5rjTMxv1sbZeufIlhzNDhp8YMDH/Hq7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3996.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(6506007)(9686003)(4744005)(186003)(53546011)(2906002)(110136005)(54906003)(478600001)(26005)(83380400001)(7696005)(8676002)(38100700002)(41300700001)(122000001)(8936002)(55016003)(66446008)(66946007)(66476007)(76116006)(64756008)(66556008)(316002)(5660300002)(86362001)(33656002)(71200400001)(38070700005)(52536014)(91956017)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UaRnuNY7rHL5Y7znw60X2g5DEyQdzK2A4mJacIpcipW8KkX5EZ9toewCes?=
 =?iso-8859-1?Q?m/XxPSKAKC20s3Ga2R5IXTm2IJFPF5ramTWs2vIC8MdyEIfxE+kQ4zOTS9?=
 =?iso-8859-1?Q?mNq2Y0+vEEmCeOiDCB0mXMIe9diU0eAaSHwqAuOWc6dRrGvAqUsqrjxU6q?=
 =?iso-8859-1?Q?h4UJmzC5wyK1zXkGmCJp/3rCF7+EIoDLPPwqMJjIPsm/IdkZJhy1+TlakT?=
 =?iso-8859-1?Q?00YHu5Z6Vj6A8J1I1dY15/Pkud6E1VlrILy39PoBeFU0lESgU/cYIL+2LT?=
 =?iso-8859-1?Q?KHVmMHzynp5JX1V0ebHCT5HQrLC/Oa2gIvUArb09/7g0lx2f2aZjH7DyNG?=
 =?iso-8859-1?Q?8G8WbesIcu1x22quJeEekutLZ7ynFiEhidS6br2x8G/qy89Bqk2YKbfAVW?=
 =?iso-8859-1?Q?lrgcEu1aH/g33O0g0gDqUgbyYQcAIOhtScadR09bmGWuP6t+tQMXVX8CxR?=
 =?iso-8859-1?Q?NYpi7p4p56rGS07VDgXjWtLB/DpZISCaRj7E6VkeWJ3h9CqqmonfY9gUWU?=
 =?iso-8859-1?Q?jxJH6joIemWLCdSndBxt9xvigWC8SfYwis/bwxkc2d2KYxEY0YYhFvovSZ?=
 =?iso-8859-1?Q?aaZVNuMzPRnyEKd0jWc07rLplCMt27qQpWjRj9L5A9eTXaBxdDghbar8GD?=
 =?iso-8859-1?Q?31j5HflrRLDqE1PyRFOFbQBx6hKBcxKYxJBUVrYVHuUfrVDxJFslbm56HE?=
 =?iso-8859-1?Q?qpnoVnSkNSI7xK2grbkBHD2426meI0zITp4S3Ay9OHEvJpSdSy2jIvSUnI?=
 =?iso-8859-1?Q?4gVnh/FyBkTSTV7xQJxQnjJxMzSmtiBuGr+H4XPqbHqcvvAkXZxmWuBfmC?=
 =?iso-8859-1?Q?ezDGsZfu644zCD5AQ4SlIveCjNt6uKJ5eq3gKO3fjqrAuJCw3b5ktyKeQp?=
 =?iso-8859-1?Q?7AWdOohoZoNr++ukZl73gkLNbR6+3CROlPEP5httfhFs76+Fp9vsx52wqy?=
 =?iso-8859-1?Q?LAIwf6N6Y8YzXRqHgJItEobQMdgqeP9uOBWN84K1HIXwvA4oHgKTyxMzLw?=
 =?iso-8859-1?Q?A9Ex7cL96x7T5acnIDunxz8Rrgbqi+rDSXttD7c5Vso0m8t0R9dBM7Fvhk?=
 =?iso-8859-1?Q?ZvX82jVWL4Bsdjjee8nxlN0CI0aRnEoBFFlLZvSN8OEDnCsqq4TuoCyftS?=
 =?iso-8859-1?Q?lvrN3vL8WmjrpI9YD82SibE1lhTVyWQYKOXEluWh8Ydj6qejmteB8MG9Mk?=
 =?iso-8859-1?Q?uTkiRxrHvJksrq35eAPDufuJfoxjy9RdWxveypaLoQd43+3jQgf8IQr797?=
 =?iso-8859-1?Q?uLp6W75RH7dRRlNxjnRS8VI8bp5ymuUa/a5Rxh9qMotLIZ0AbowYPrJ46W?=
 =?iso-8859-1?Q?hiu2IdxAS4Amlq4dyErp+/wqrY2pDD6OOMLy0YMkMhgVj1YeuXZxSMzsRq?=
 =?iso-8859-1?Q?p5Ipz+/FyxRyAOxJFUWppB9bUHNgOhQJf6jZNk0Pz9Xi8e/ZUWTJkoqfbc?=
 =?iso-8859-1?Q?S2DjsIuD87Ll4tZQnQs5QZ1jIiw844ozJFqE5ypZ7E4zMquHnx63x/4fSz?=
 =?iso-8859-1?Q?hZHVd63iYAzlER7ll5PbOkdXVMaLmq2rHCFRahdozNXuxqVn3gJNpsa4ex?=
 =?iso-8859-1?Q?Jt0ZLbWVMATT+tIqTVZ+JzBz7IvXHC04EMg+odjQR9oYBwu40Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3996.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a2f24f-19bd-4a18-0794-08db612599fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 15:50:32.7654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TATSapFDGy/wdc4wUagfZG1tasaEJ8VdtgUm/yxFfPI1FI4lPDTgs8P8/9COgn6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

On 5/30/23 11:24, Hamza Mahfooz wrote:
> I am able to get clean builds with this enabled on GCC 11-13 and Clang
> 15, at least as of commit e786aef0869c ("drm/amd/display: remove unused
> definition") on amd-staging-drm-next.

Did you try intentionally introducing a warning to see if the build indeed =
fail?
