Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CF70ED04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbjEXFYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239326AbjEXFYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:24:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64661A2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZdYz9jMKvkzTOXuJJhCqFydiVSb4xZEiU2Ta4ICfB+f/qPSmo98Ua9L9ap8YV8mx+TvizNteAovM9C/U5NN/BNbQuho/JjflZwmDETO6Civi9TDrGuWJ47Y/v65tO5MjUu3aZMOv0a6+nY21/5Ts+/+jCpJc99rUBSI7jIMEwy4ZGqEG3JgVbAkK/BculASLv28dY7TFufVdgj6rKw45+oabHvu8w6UA62BGTbH1hccP6LY1P/R3ByycgQ75A+l1G5KLcpsAITsNem1il8+HJPecnwJfWWGgD2azxc01kMv6h4dWaNk/f6nvtG8jHg/g2Ru79VHDhTjj+MK65JIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C56qewkxCgQ9Eqo+2215oDXNABbnL8mPnceNveqGew=;
 b=EKyY7IPv6VNsXCkbDCmRREvEHcvu2V9sbuD7W37rYRP5A09C9qyi7Tm/TDMxgfD5AwMzr2DVGPK/t+71YRlH6H/d+gFVIiTCjeK6U0NeASryqHrzr8/rDcVHfqa1+wVeiqF6M+GdKUB3PJdcX7iww/jCWYmS+aeEfAkmXDbEBYwz0jzbktxMsF68tl8YFIFNX+QJb9ZEOFUsZpRN2sYRVIeNcSWcw9Wag6k/A9cjXmNgN1KqJOAHylS6/eD6OKEJef479o8DEc+3X81+EY0jQIGqERdqOXJiphhk2P5HxbFRayFHZJBfA2NO9fDmX2Xv8/KBtUvE99RLerYwIHCD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C56qewkxCgQ9Eqo+2215oDXNABbnL8mPnceNveqGew=;
 b=iX45y/QvXrR900vKZxZnR2x21YfcUXCXUSNZSmYGnxjxHphRa9eF71F9tbCndyVZdW6qmQc7PwZ/ER2KTO492w8TiWszHqQlu/+r1HQFqIZuIVuSTlpgTD5uz5CRQbIez4ZpDf/pvBWPJ3/k9wZobsL4P/Q+w+f+hGYrgZa7V5w=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:23:58 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::6960:852b:6426:8d0d]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::6960:852b:6426:8d0d%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 05:23:58 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        "Kiernan, Derek" <derek.kiernan@amd.com>,
        "Cvetic, Dragan" <dragan.cvetic@amd.com>,
        "Harsha, Harsha" <harsha.harsha@amd.com>
Subject: RE: [PATCH] MAINTAINERS: Switch to @amd.com emails
Thread-Topic: [PATCH] MAINTAINERS: Switch to @amd.com emails
Thread-Index: AQHZh/0yzp8USH1V8UeLF/4cimgp069o765A
Date:   Wed, 24 May 2023 05:23:57 +0000
Message-ID: <BY5PR12MB4902C59544E4F86EDEF55C1E81419@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <f7773fdd002f89578b9e5262692a563fe7be4123.1684244928.git.michal.simek@amd.com>
In-Reply-To: <f7773fdd002f89578b9e5262692a563fe7be4123.1684244928.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fa2e18d8-5725-4454-b938-fb8e084e70ac;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-24T05:23:10Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|SA1PR12MB8918:EE_
x-ms-office365-filtering-correlation-id: 86cf88dd-c4f0-48ad-44d6-08db5c171345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uxuh6nUzbK+yw8P8aQ2Vis0o5+ZaOuv/FcB1N2ZdO+hsmIFH9y6UxYlu8Pwzvot4wI43zguqRE42CDdUyX/OYgNar4srgk4akWpUU1HrXtzsr/pORBWIlZ+eDlwPM1A00Mj8t0eitiWIGFJhdokqM1J9qr9nytjGoVY+cR+rSKBjK/sQIJ7o0lytqBQFfg9pAxHrOgzJUNjf32jxnBV/ysZ+CPE/Pw5Y1FbGV64b92RTFUPfkqtO/sjX7VgGMhORydVZMnDk6QGJO1bdLfajz8c8m01YEe6ufIWD/I8QA81amBIPMwKQv9170mtpN6+Xc6pmGwk+3cA6CskPmfqwwR5gnIE9skfkEIcbXf4hnyokmEnmrj5YxshleV3jStUw4kuuYyqfhkkCUD27kVxi8/PVwV3BtyCL1FT4E7ow1k5bPh2Xhy8mlaKqQmI4rLeK2/f5xXAA66+VrF5C2ynHYv63umoTb1kJ4EUb4oLN8CWl8pH5tgZCsErzBXHkG2jhmwNc/KHms9Bhpj7Sys9/DyzXxnlNtTAjVMAVRxgp7R1SZO7MAfgTZ1GDrBj7Y8jn7CReugqXe3mtIeS/MEQ6buCMQQ00TyLlT7/3U1WXqPWoOOko06kntW5KJiS211XvUsyaWV6FpJZDs2ph3QIzwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(66946007)(66556008)(66476007)(66446008)(64756008)(6636002)(76116006)(7696005)(110136005)(41300700001)(55016003)(71200400001)(316002)(5660300002)(52536014)(8936002)(8676002)(478600001)(38070700005)(86362001)(38100700002)(122000001)(33656002)(26005)(9686003)(6506007)(921005)(186003)(53546011)(83380400001)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eYTpWppt2jxeN3zxqcKYTXAnCoix7zEn2f0IPy4o12mWB3d2l4hykj7Nzf7S?=
 =?us-ascii?Q?IihjCKsKc1l0Pg90ykwn1gBK2N2Okpc86ab1sPIpwHhGKAH6LlNmZ7jnnmeC?=
 =?us-ascii?Q?B6ol5ES7bJVz3i6L1+0vtzBgS/xTaehDU862xxuZSvKrHEUvVtLlr5Zvgud4?=
 =?us-ascii?Q?Q+7BRItcLyjQYQBHpCffLIRAF/iO9dN5WkSQwrDlgRk/MNN0srA7WKmN46nv?=
 =?us-ascii?Q?mkplrFc0rt9nBq5N9CFSPVdUlpBHEVmlanVofWPAgSIMKH2kf/i32Tgn5rlE?=
 =?us-ascii?Q?JuXSQMZmK2OQIOx+sOFK3iwaN0D9ELPgA0VPJmuOh+9s/rDKEE5Jb0id7R8Z?=
 =?us-ascii?Q?t4T7GVe3Gk7to/CLgmqWb7JRCyCMnuzQnDvxOtZWJCjRRhbILCusA7EVlJAE?=
 =?us-ascii?Q?0OKFKAUFhqlyT5Wy4s3e3lZiTk/lHIUtjLX0A4gNaIx0TrubdhJjGVwKbpAQ?=
 =?us-ascii?Q?PPaz9w6d70PX7qjdgA9793jJYzJaIL+VVerZvcf05RCURIFNszEac0UB6bHL?=
 =?us-ascii?Q?8TfmNIQye8xt9VLGArV3QkfAGrq+4g6cLSitSAH64FHj3VnRQ85SsCszob2F?=
 =?us-ascii?Q?yeiqnMCrctiOAQWsW4uNDd9szoHGz5gnnYOlRzCX2a79EmN12FRGjzX0PwPC?=
 =?us-ascii?Q?CjE+2lrwcgy0+xFxQCnyQYKvFYXy2VLT+oNiUK7+eG5EzIcX49XEADVO3w2t?=
 =?us-ascii?Q?rjW/Zo91mfGGmIcmGPhWs3uHdH+Honk/HnK8iFLvlpZBkjJ5rVQ5HtK6ED9l?=
 =?us-ascii?Q?A1st+o7Gg8qEBf6+rz6aE/WrP5MCXces5hRi80NvuVU0oPB8zdTyfLYjIVgH?=
 =?us-ascii?Q?VOl/3/WwfJ+9KvBLv0mqZGHYlxka+AnF1GzL2Mx60+HUOdxAuroAsZqUINyV?=
 =?us-ascii?Q?IMr4Lcl0P9KoY9T7Wmh+A5AlOd7La/RmqLy1iq9lkqTqGNg/mvR9yFTOPcbq?=
 =?us-ascii?Q?Eh1XlEVv1SneScDPAoownAh2Iz8GfifxjCuFoMn3TvjaV8sUlDry3WEjZz13?=
 =?us-ascii?Q?o/hI9nY8SYEwhe1HwnPdkMtYEOApxA0E+32Hy7aET7bL38t4OxRMc7OOiyBF?=
 =?us-ascii?Q?7IDx9FYv3+hCxFeNgg5Ldo0u3wQh4Kt7m0gid5IvxDrF6QYqO+Pi8QvEzW06?=
 =?us-ascii?Q?zwNLeVO1R57Rxco+247AJDJTR6oAEtPzlozONbBoKGcRv2M49wSxPFgVKw80?=
 =?us-ascii?Q?zgbe4cv1yC9xnkXZcG3RL2x0+Hb4Lr7lyWN82qyprk/slOH5t5zLvNNK2DxV?=
 =?us-ascii?Q?DmykGDlMbce1WrHlHLj3KgovJyBJa7pQfl5Qrfo1FRaBxgDCU94z0aWYmVfa?=
 =?us-ascii?Q?lW90nJJcxZ+Gf4HvDC6Z3rkAX14FkS58zyVPn6XCT6X/dyN6ZmBVbkwMHD/v?=
 =?us-ascii?Q?AlcnP/gTUA7sqgoWFuQ+Sm4Pfovm2hS9e0X4x0i/VQExBW5OAZ3XmL5TlLaK?=
 =?us-ascii?Q?DwWlXYjFKpVM+H5jjKCh66LnSxpDfibiPSDh3N4SArcpbre73ytplOwtf/ej?=
 =?us-ascii?Q?t1qxDcxxhKLLY42VPu+/FCF4Ns0BuOMO6o75FPz5G7IaG+yMnl720rSKbxQ2?=
 =?us-ascii?Q?MIlnQ2xuDQdo7W3Cazg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cf88dd-c4f0-48ad-44d6-08db5c171345
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 05:23:58.0120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19bG5rbhpsOJYKIwM53DDqxJur2HwpOCneHNGNmAqvWWSVMIvS4RSoJvGNPbkgH8GIcRWfd//OJaI3DX1unzwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Simek, Michal <michal.simek@amd.com>
> Sent: Tuesday, May 16, 2023 7:19 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Datta,
> Shubhrajyoti <shubhrajyoti.datta@amd.com>; linux-kernel@vger.kernel.org;
> monstr@monstr.eu; michal.simek@xilinx.com; git@xilinx.com; Neeli, Sriniva=
s
> <srinivas.neeli@amd.com>; Kiernan, Derek <derek.kiernan@amd.com>; Cvetic,
> Dragan <dragan.cvetic@amd.com>; Harsha, Harsha
> <harsha.harsha@amd.com>
> Subject: [PATCH] MAINTAINERS: Switch to @amd.com emails
>
> @xilinx.com is still working but better to switch to new amd.com after
> AMD/Xilinx acquisition.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Acked-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

