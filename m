Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76A73BB54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjFWPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjFWPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:12:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA61BCC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws0+p/+ilpsV6zkqOpsps0s5jeuYVBiP/T8QVKamV8JKGu0Gr1mAZI4if2OEJ1Mj1KOXBAhuSaGeB00m9JRTCyjtltvr+Ubq81EcjvGcLyc0e77aYxiuPvfyTpQKYekle6/ua1oaJMZI51URFNZloAyjlQi8JceMlas8UuvLAjhaR46cv1wG0GO5/gapl3+SUjvF/N4weo6TLJONKJWMD9aIxCNsqZmN5JPSRJjpCn61oq6WTa7N5uF0qEjTzJnmO0wH3F6s1GKB02wgIZxeyU3o3XEVENKoNOoMNzgoqzl5Fq+4Gamg8V6GvrLO+6m9+z2kTm0uh4Ql9fz6JIJ5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX53D9zMMaP0K8RmRcEXTkY2d+mTEJdJ3Y4bclsZJzE=;
 b=j0z304feCJlTgnxIcalydVjHcf0rTl5t0CV1FT0lKrbAfx0PJ2Zu6jlVjJkumr/5j9cFLY6szXf6qBPaW3rYnX+cVVlVeW9HjcUzPjH7d1Lwrjl4QCeDKOKWGpSjytbzTVJ63F0lsqt+14lcYyjL3YptH0lUakx/CxwthC/4zukZZsad1ZM/HceCN0K5ml2R2mw+vQgJThbn3o0Lf5Hd+H/ezP9oV2zf9FcadWwC6RRJQlQrMehAhRqp/7Ng8SUjYzTp//ofr8TZBXOwhHXiLOY7YphfxyUUoeHzNsQJLBUOJhkq2X9xvGB8vTdSOETX7RMwBrxD5Zjohds6rBy4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX53D9zMMaP0K8RmRcEXTkY2d+mTEJdJ3Y4bclsZJzE=;
 b=ll5HQ9EKLAe2vr9aiyqhHhhv9rfDx33OF8MslJ4PTDdtUqXi+J6YeeF15M9/ZaC3eKQSLBrdsUeFTzKmzM6QrLm3N9ZgU1Dd2kk924EkZwQ3dSEoKV9a7s+wHp137Qe03G/3NjquFvYjYx7n+fuaiYkVkTMTmnCzZltvcpmUiMA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 15:11:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 15:11:16 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: amd: update pm_runtime enable sequence
Thread-Topic: [PATCH v2] ASoC: amd: update pm_runtime enable sequence
Thread-Index: AQHZpbZV+3A8lHLph0m1cBJU2YTubq+YZQ6AgAAZGwCAAABFAA==
Date:   Fri, 23 Jun 2023 15:11:16 +0000
Message-ID: <MN0PR12MB610144E1DF21167019ACE802E223A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
 <80e86035-f6e5-3059-6cf9-7f6cd93fa2ee@amd.com>
 <ZJW1zjWMUYXP1XpH@finisterre.sirena.org.uk>
In-Reply-To: <ZJW1zjWMUYXP1XpH@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=99887854-a523-48e4-99c5-3d8e94e24153;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-23T15:11:04Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA0PR12MB7532:EE_
x-ms-office365-filtering-correlation-id: 2f68dc2b-1ed0-446e-55da-08db73fc1756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysAOEd46Aja1j4nPYNEORmTgdKQGP5TXkV0VpAo913OYIyIbqQ0FIDP/JHkyu1YWbX24sC7Dl+FW0Hmb4AmcGQGK1UTHts05YPCX1p/lGL7tZOQw5caGTr/G3+mUEhEj9kp0PE872v7wYwcmtNl+THKeL1SfkYTtgwrglZa83ENPJWI/wkc0sOb4HTzyrQI/oPV27ewCYaOT2KXovPIFzxQoyJncmDLMdyJsJlC94qEwbeoTgJxxQUhziUUxRirZ0Wsn09G14GBhfmdXJC1CCkCc1M6iHqX5R7Hqspd8itQNpB3BWV7WDX87ePxql5zWJHdEWIUiDpV7inJU7/WKzoNBAKeoaP3I8Fukj4ljqHX5Jy5Ev1HuCPTggZ0203ld/dUkXHBRCk5Dxe8sp3+Z+eiWUkGe8Qwbjzsw4mXZulJ3auy7H+DCEvtD82PqYCXkEAmnGbbvR6sb6KN3WAtYnK4MAXhHKKetQhDntaMwz6iyXdKACQEiqE1F6T6vqCFOx4Ax1NIM7zi9NPm2QP04zBJrzsK9au9gJsU0V415fKdD9CHygQnLTKpmNNtXfWDXaiuPv+yZLrsbOSr38mVn3qSSWEu5QieXXi2uJ/ifuT3pGqZJVOcdXpLsm9FjjsHU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(38070700005)(122000001)(38100700002)(55016003)(86362001)(316002)(8936002)(66476007)(66556008)(6916009)(66446008)(64756008)(8676002)(41300700001)(4326008)(76116006)(66946007)(4744005)(33656002)(7696005)(53546011)(6506007)(5660300002)(52536014)(71200400001)(478600001)(54906003)(186003)(9686003)(2906002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WZqV8Kak+PMwR/zai60iB5T/xh/RWWmJphLgj8DTsAqJWDSTbj5UU5crfd?=
 =?iso-8859-1?Q?+hLpd434Az1BZ3SCE2RBkm4Dv0T8TnbTG3sCki2rkaVzjEL7oXFOEd4pl9?=
 =?iso-8859-1?Q?obDQIUHBX/y1B9lQGdc0m6T/cHDBiMdqtyKmn5IDxzYNsfOJa+V8sxcJ9X?=
 =?iso-8859-1?Q?xIP+yrvFzUoDwymMfSwE3Uk6BEC89lciLD1VNRRaMMqRJjJ1nRungxN1fY?=
 =?iso-8859-1?Q?lkYQDtNGyHYWPx7h9Wfvdl9DyxaumrEiRA3x6n5k3tcQjFmV7ORMFF4MO1?=
 =?iso-8859-1?Q?xjltAzF7X6BwMr4yLTEakNRN//LsUPjBWG0+PpeuShlXBOsqp9IlmvgURG?=
 =?iso-8859-1?Q?Zpo1T7reclHJZUwYm+S1XLyQxVniggHuqMR3yjsNnSXIJn5p6kCMnuQvg1?=
 =?iso-8859-1?Q?xSDZkN/daT2OKg1gPIwmEDT51ttmeBC1gB7BiKn0K3Vy4MNXQGMTWcRjV2?=
 =?iso-8859-1?Q?/OdBkH5yYduO34BXQabWSXGX1YZUKGHDk5d1RynQegUPgc1jAvvi+3Ggy+?=
 =?iso-8859-1?Q?636T/DPp3BE/FNYTYtmMFCbRJrHDsTn2cclS/4Bo4Vs9sYWjkLOlU7XLTO?=
 =?iso-8859-1?Q?GZduokYTboc1olZwY8x0D4/3wkvPLMdnd/ikUecNa9JpksNs1n+96vX/kU?=
 =?iso-8859-1?Q?EFtaHJH0CjkOKX5RRxJb8bjmUzexKbdi1cKA0BWPeDey12cuZGoBMHc7BO?=
 =?iso-8859-1?Q?+Y9WQpn+J7dOsXu1aoKZnrxWJ0J5JlHuLvfJCgPfywWsz6jk5AfBvJ49II?=
 =?iso-8859-1?Q?9R0+9jFLMIGxl0Dklh9xGavZf8NGL4B56MTyoxyHSzO4UPnCe84r7y/705?=
 =?iso-8859-1?Q?gN1Jlv+U9qhPxCsHLkNcWTs1UC3u2lBzzm+rAiXdNlsDGTIC5xi7yXFSCK?=
 =?iso-8859-1?Q?8+paeiSPO5QRoXdn6bOJ+3kmGmeY0NGOS6tGEF0APbu3s08inSyiEwVpH1?=
 =?iso-8859-1?Q?36vtjpSOZRyAsL3lcqC2JuRkzge7WxxtgofKzaF2D7JxD6msiTfGW0SH0g?=
 =?iso-8859-1?Q?Pz7MwwMAqn6+A/+CvJnrQlVKe1tECvYpeBLXjmhaNGR0DdGi22cE+YpLWY?=
 =?iso-8859-1?Q?rEtS/tjoPGcbrSjx1zOlPfYmF0Wdy5tybaAZVMxLPtWAFQvsQXoakc/qcr?=
 =?iso-8859-1?Q?wSH4XJjPjLc7H9LPIZfpUM8IpGaFhHcIoSFD1Tr8CWrY0GhAhiVJj7aRiV?=
 =?iso-8859-1?Q?XUBoxyVjyc8TrIfKRbSY/GCrW3dU3B5Z3HiVc2+mPbbIFMryGMt/81RJNU?=
 =?iso-8859-1?Q?AKKZxX9jJdot9s0gDJoO1jjD8AciCJa7eCFueA3wE5cR+VBq8kHsbP1OfT?=
 =?iso-8859-1?Q?8ik90N3XkpI80yDg9xsLm92NYszhWYvoWSgcZfDMrhkHYkoqIU0pd2uded?=
 =?iso-8859-1?Q?XNA/U28aFUq6LImjPU09eLfcflzlHbctAEWap/TH4dOXcUZfQU9sCd5b8I?=
 =?iso-8859-1?Q?AZFprsrgrKTKRKfYQ13hm6OX1tunujHZ1TYWlf2uOMh2XWtVMArdzjqzqU?=
 =?iso-8859-1?Q?ff/1F7ncoVtFoFum/bDYCTHphZPQbfFx1oPdzVdZw5C+e2/39GVQJDEJBV?=
 =?iso-8859-1?Q?k5MVs07EnDBwVvfBk/WwihfBk9UhEsB6kUZJKkfQcfmcenzLs2Vum/sznM?=
 =?iso-8859-1?Q?UtH+5JcDxksp8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f68dc2b-1ed0-446e-55da-08db73fc1756
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:11:16.3465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GoSyyqt+hPMGte4lkhQvrdEdEwNaHTE8NvJdAbN/+p9npdWmfbn+9G361t7qeoyz5w4cvbN6ErYaY7zK3M/e2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
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

[AMD Official Use Only - General]

> On Fri, Jun 23, 2023 at 08:40:15AM -0500, Limonciello, Mario wrote:
> > On 6/23/2023 4:41 PM, Arun Gopal Kondaveeti wrote:
> > > pm_runtime_allow() is not needed for ACP child platform devices.
> > > Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
> > > & pm_runtime_set_active() in pm_runtime enable sequence for
> > > ACP child platform drivers.
>
> > Can you explain what prompted this?
>
> > Does this fix a particular bug, or is it just to correct
> > things?  If it fixes a particular bug; I think it should be
> > split up across 5 patches (one for each APU) and then
> > appropriate Fixes tags applied for each on the code they're
> > fixing.
>
> I had already gone ahead and applied this before your mail - it seemed
> better to get it into 6.5 than leave it waiting longer.  If there's a
> need for backports that can be handled through the stable process.

Sounds good, thanks!
