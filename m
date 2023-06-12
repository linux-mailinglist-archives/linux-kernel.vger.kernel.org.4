Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277172B578
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 04:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjFLCnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 22:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFLCnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 22:43:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4AB19D;
        Sun, 11 Jun 2023 19:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoPkFeN+OT19QVpGES6JtefsZGSQqIYsKQWNf/GQQ38FroqTuoTLJ03PiYtzARKcU/xqfvjJIqF7prdhjvMjYA0YKoI4AS0hLQH1lUQBeu0DNKYtX7WLDkUyy74NeWBBX9Bx/iqBlAEivEKLXrTGRFqAAHR5MIEOTIaE7PrtiQpkJ3557EKetNjzT3SgSTX1eTjxSekzZ1ickl4bVmE9JFSpQLoACNPk5UfJdwm3CpqSpNv2uMKo94MmlMaOuQYG1iY6rThypbpIPcJYCVoc3cX2hW6zfiOi6m23l5riZmqHwHDB1THoOJ/nL+bAY1M3p69gt0XIhYKFIXroJ7Iu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ljPPaPdC7jA2waa3neNPt+wSr7pwlt4qpS4nMPJoYA=;
 b=fOQM4mnG2uPpr3FJ+ePi3A0P1WF2c9DNPLLf4fDbjM5gvBVN5NGRVuDJ6An3BdqVDcSWNTETK38s9q7dQHuhTKo1GDQ8DO/O6sKaOZsK7tx0npGHmfEOZYU7RhQ1VrA4l3todjf8StZo50drHpmPkhf3ekmfak5iIizpaYIeqp4zog2X0Vh+3u6zUU3Gb4hhHTD/TszXj69clZi2HlAKi6SeARPMp0BV0AWlkvCihjsHj+4KSvphHnqiSv6+wVz/2feS9F4OwHKwuXQ+J9AadKLVT8KJkBpJTAkIIc0gN7RXfxTOnL1BdVwh317GZX/Q6szrrxyXEylS3Q/6aGE3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ljPPaPdC7jA2waa3neNPt+wSr7pwlt4qpS4nMPJoYA=;
 b=d/ovz4dbX7YL5M32dndMlTQFB1pmJ/We2pVryvmdG17c9RZUxIVNG32zCgShyzUMYWXPpwbDPaEA4SadUVGc4qvwAbXtpb9piuhLrm7nNLMDcm/w8mmz1Tdl+sNANPaeIfiitTVzUNNfhUOhgpNjOJr6R9K7dhCvUuduYgeXD6k=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 02:43:10 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 02:43:10 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: RE: [PATCH] cpufreq: amd-pstate: Set default governor to schedutil
Thread-Topic: [PATCH] cpufreq: amd-pstate: Set default governor to schedutil
Thread-Index: AQHZmjJOJn/13kYQ+U+3kLDcLmW6G6+D35cAgAKamCA=
Date:   Mon, 12 Jun 2023 02:43:10 +0000
Message-ID: <CYYPR12MB86556DCB85E82E4664D4FD7D9C54A@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230608095358.30548-1-mario.limonciello@amd.com>
 <ZIRWgJ/XW0VzKD6J@amd.com>
In-Reply-To: <ZIRWgJ/XW0VzKD6J@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c13e834a-0f81-4163-a569-b6dd23bc08f8;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T02:40:46Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH0PR12MB7077:EE_
x-ms-office365-filtering-correlation-id: dd32064a-3b26-4fa7-e8d8-08db6aeec281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27PxtOnPO/QVCYaZuCFp291VNW3R+qBn/N5uApGgXqfz9rBg4kLmOZLhQ+R5GwlECsrAM+r45pbbEOCJVn6Sa5MArnS/+B2wluWmNEM1fXI0VsshfB3yk+or9CdqLyX/DP984srlWzIUKOs5GXCm2aH71zQ5uL/nEmMAi/eldwEqC46W6JCuT7uLvHUdviMrKrkDpjGWPdOpgqZqkKsNiaeFZvru5WW/jwtMiaS1ApEujEMQku77r7U5c2f8E4C9IOPh82RBWT6LreHdfEDiTietLIcERNZ50JDd9Z1vuRc6hYmfchqmpHtwwXfjB3BOVJm38Pu3kJi15yam3e6IUeHJ7MkIa3Ja+w76JArCFPri4i3uyg/l1ClypDlmwpq+2hLwl15VqGe6aKnJA0v7uJlC/Xt4JgkCkWmRxy/jvabYZQJvfmnbWt+aGkicCcVpkHPZsDjhV8mrXf069ziAuW61upNHJGVJ+5s47sKcjurOigzXDLY7QZ5KUXNoOzK7GLstjYFX5qzJw+fOucUaaKJhM7EjXjABtk8NGpQGpSw3NHNVVgGbQjsJNXxZE1WDnr5ilzqssoK8n0w6c3mTPKXcUJGRHJijB113ON0fHCdr+iUrxkd+SZWZHriCfHMM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(86362001)(7696005)(316002)(8676002)(41300700001)(83380400001)(5660300002)(26005)(55016003)(38100700002)(9686003)(53546011)(6506007)(52536014)(33656002)(71200400001)(122000001)(8936002)(38070700005)(66446008)(66476007)(66556008)(64756008)(4326008)(76116006)(66946007)(478600001)(6636002)(186003)(2906002)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xtPpKyyH3+YWzpDzMQcGEYoB0NXGGG1dol85L4uFBrF4HojnLWXhdg5WE1AY?=
 =?us-ascii?Q?yd0xj7Z4FsWwg0BRmy54/O0rwp/7Q6dnpEg02LqfhmzJHNXAxbwJUFrjaqgf?=
 =?us-ascii?Q?WmwsyfmO4Jq6j0qdPsHViIErfTp/WIKYpZtE2wXFKsk+p5s4JMphp05K0r9T?=
 =?us-ascii?Q?G7eksWY8Ng2EWVpJ+uZk+XHjDIffVxEs5aPDzp51iSyNIgwUSD6KM4iLVWGr?=
 =?us-ascii?Q?usW52dgBoYyPdAsGTog3ropafxkX1mQTFExucJd+lM8oPqtC6aN9I2Mzq2pb?=
 =?us-ascii?Q?C9pwxX9sqcOnLcTZf7Z3uK1jAQhGl+paCY3bBuQAgW546GLPmfM30TJM3FNx?=
 =?us-ascii?Q?L0TA3FEf5EjV/IIGfBaayU2qBbEOZv0D63kDH00zZMRMPhI+736dneFQqQ/J?=
 =?us-ascii?Q?qj3YZsf4c5zT6vzIOBSr7JVz6F9H+/Pg86g2IUQXk5JYtXZo57Fu7b9MQ9oC?=
 =?us-ascii?Q?yQ2n18GJmN8zGXiFmCNPCWoQkb+xpC/FKtSrz2ulf0MKbacdt1TjKc3FexLg?=
 =?us-ascii?Q?rOOgiodxYqXg6W9esiXSjcnsAO6J0kfwuxg6JgvS7+n5S/2XMbnjEckxkPi1?=
 =?us-ascii?Q?9LzvsppYkBqeo44MNPJinC2g4rnyHIoab9KQWbYtmoDL9sAF8rE+zPvvmavI?=
 =?us-ascii?Q?2ByEbU0te+ftSKWt2ZyB9+1xfrxyyBXc9+wFNknAGzvNh5YpFh3+CgdXJls5?=
 =?us-ascii?Q?sVt57KQpTjdytsjgFZ5/cSd28Ukhdu8OBNsYwbvYWnZJ8KqZQqA3xhA0rsac?=
 =?us-ascii?Q?VauBLTfeOw7j/eOxgqEU5Qv3/cCO3WAX0crCEALgQTWebDVPGbSWrcQoC5wd?=
 =?us-ascii?Q?nZXvDTTvFVAl6j9qj1h52E5K54ek8fL4wR8ttIzreDDnLAiHWXir0g1PRKRu?=
 =?us-ascii?Q?y7vj6i5VW/7ItaCSTGmztwfyn/LBk2r3rXJNbCxA3IwfTNPYJfO05wcmNTwU?=
 =?us-ascii?Q?ok9TLFxaxGYTxLk2mHax95a5/zU9rj1HGKxRXc77NmY2wFL21cSKwV+ek3m2?=
 =?us-ascii?Q?+AOeaOdAhULUR5E0dur3Jz/ChNyhdpgkbWToWtdT4nUhhAeeKoIiPG5Zi1fK?=
 =?us-ascii?Q?y6msgK1ki+g2hMC3OQ45bwxmqaDoFGyiJiPcPbR46xxxKbwHAUqgJ0OVFGPk?=
 =?us-ascii?Q?kxCsC+5NJIUVg/1Vd/P4Ovzw2dzArijGgEeTBDDrwxmk2r1XrIJ99fkibcfb?=
 =?us-ascii?Q?XHd/5oVPe3BbA3QO71hEGY/wRgL6Hj1SYzb9fDIuYqqBgSdMIqeFpA/Xp5rU?=
 =?us-ascii?Q?odNXgSOKvIBvlUBKBv740Tx7FG/o8Obq+jyHXMQ0KMGavU8UliXa9KA5pFRA?=
 =?us-ascii?Q?H5+FYZbqo2DUVRpHqaN60u7AEGSsdcnwVbeXrh+4Jx7MeDaNND4Kr/Tnb7Lu?=
 =?us-ascii?Q?NN5GLwn+j77bYDT1svN/nScHIBqB+oa0yp2NhzIBz8rHHu0D7GIDGtAg7l9k?=
 =?us-ascii?Q?XMTMtuCQP5zNWZDBK3dGOHMy8dMtZx8A7+pzW5m3+FcDUCcXjh4q4H9CzFrM?=
 =?us-ascii?Q?XHKqsIj4Ju5GeHo1nZUFPhcGlh8VHZ98GGKaY4zOQfDmv46gCWSbWh/RIBjA?=
 =?us-ascii?Q?8wbIbgmXMleBC9I59zU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd32064a-3b26-4fa7-e8d8-08db6aeec281
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 02:43:10.0927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxcWNwhmWGEqfpEquto7hTcg5zENFQADZDrMmgfeKkiVYHPKQnaTtfmXMlfhjU3i2aigEF7KEj8E+8L0U45Tfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077
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
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Saturday, June 10, 2023 6:55 PM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: rafael@kernel.org; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Yuan, Perry <Perry.Yuan@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> Subject: Re: [PATCH] cpufreq: amd-pstate: Set default governor to schedut=
il
>
> On Thu, Jun 08, 2023 at 05:53:58PM +0800, Limonciello, Mario wrote:
> > The Kconfig currently defaults the governor to schedutil on x86_64
> > only when intel-pstate and SMP have been selected.
> >
> > If the kernel is built only with amd-pstate, the default governor
> > should also be schedutil.
> >
> > Cc: Sun Peng (Leo) Li <sunpeng.li@amd.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Acked-by: Huang Rui <ray.huang@amd.com>
>
> > ---
> >  drivers/cpufreq/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig index
> > 2c839bd2b051..a1c51abddbc5 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -38,7 +38,7 @@ choice
> >     prompt "Default CPUFreq governor"
> >     default CPU_FREQ_DEFAULT_GOV_USERSPACE if
> ARM_SA1110_CPUFREQ
> >     default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> > -   default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE
> && SMP
> > +   default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if
> (X86_INTEL_PSTATE ||
> > +X86_AMD_PSTATE) && SMP
> >     default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> >     help
> >       This option sets which CPUFreq governor shall be loaded at
> > --
> > 2.34.1
> >


Tested-by: Perry Yuan <Perry.Yuan@amd.com>

Regards.
Perry Yuan
