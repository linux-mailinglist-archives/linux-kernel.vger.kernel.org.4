Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B562E11A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbiKQQHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbiKQQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:07:03 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC8345096;
        Thu, 17 Nov 2022 08:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpS0OI1wYDorKlmSdYC+oowbb7oIcHxyulj50ePCohcwnc7IW3gvFymbPGraRdS0CgEOl5vr70Tpy50QASDXgGkN9uelhEoxZfppEZ0T+zL5KhUFhQICe72c1RDR0yZ+I7gld+1CjDIz8MGVdkfRC0h0FRJCtmVDa66MNL2ljlTnyGUP7omFPpm5qVD5p+wuQoAbvGEewgQft+ex009Ezz7FUGEMT8dzGRZDgS7B76UnzYw/9u+tFmg//bj8CkVzixjYQ/Asw5l1HiwZE/GVsY3756g5Hy1tQqWTiBeQueQlJ0LFFpgG/aMaiF1m4T71GrTL2V20OGNHZMImdOCiuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7hsIK3bh6piFg9uMIB+EUH2ftF7l52xvpsdIbEbZAM=;
 b=bcO26sAmFa1GTRxXPrYLV9LYbvmGdMr/kbxbaSy5MX6QuPrI5nhqspwie2MvYoNr4F5SacOFUe9n/c3tt1l+rwRlAwfVaXx2noJ0umUm4HsyHTPi97sWNdKcvaqnybIg+E1d/EeEYrWkwDPovQnshVfkGNuEkQNZN9ginoJh4RIW1fwKMrYElBN7qLybx7RnX5Y8AovPCqE9T1KhoUaQzLOk6Z4G3Pb2ZCai6pzQfjCJr6cr6XxCASPkyHr2CA9MacX+tCBSkd620gu+JTh+CldbTAp2msk03X2dzb5I34lS6jw2rH6KXLCPY7fhkvs9f91oYMGsZ4e8aMxrF+jamQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7hsIK3bh6piFg9uMIB+EUH2ftF7l52xvpsdIbEbZAM=;
 b=OCRkpPnzCnwGRYeMQ5HoDTDCbZTmqNc9ZHkZuBdhMq1HjaBLA2oyWSOmCgfqoDF69WOOGvIZCBbNl0h21R/bA6rvium6/mXW/g0dJAtRbEfO+BhR6OAJQ8DUEjJwmxYFi/j/54lJjA3ta6n/UgSevYqo5E4YTk7XY22pX1lz8A0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 16:06:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 16:06:59 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
CC:     "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>,
        Raul Rangel <rrangel@chromium.org>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3 issue
 on Cezanne
Thread-Topic: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3
 issue on Cezanne
Thread-Index: AQHY+dI8jRo8UmESPEy1eO99G5ATd65DJ8GAgAAhWCA=
Date:   Thu, 17 Nov 2022 16:06:59 +0000
Message-ID: <MN0PR12MB6101F972282D66202C95C0F2E2069@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221116154341.13382-1-mario.limonciello@amd.com>
 <0d9f8f8c-3b45-dd6a-008b-6d9ffe8ccc93@redhat.com>
In-Reply-To: <0d9f8f8c-3b45-dd6a-008b-6d9ffe8ccc93@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-17T16:05:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=35906623-3703-4606-8e26-37b98241e328;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-11-17T16:07:00Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 32f30798-e0ce-4c6e-b3a2-d5e936904c3d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH8PR12MB7374:EE_
x-ms-office365-filtering-correlation-id: b17d1b31-cc9f-4d34-1884-08dac8b5c1dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MbwgBZuRySpUmsw9A3zhGTqfPOknMhz0tnVID85MCjegmJl9wWlfYTEQaNcc1NcHi5PSV8Gc+CXLa3MRNDc/KEj1zp1tn+ybHRmYr+OOrvGMtPl1/H4qxm0DU9suUCMStfllsTDA9+eT8Jf8vFFDDXRZaccTZxTDjH58H9C8c303nkFIPD22xCIp7EMLvXJgrfEx2RijuSbJPxBP6Y7Gbxqgp9UwiiOrrKeUOtU5laAI3YzB8hk6DiwlRddSI4OA6OevzrE6v56nd8UXRnYdtZNJMa9ExHaJVrQ72kEvXPKhQAdJ1mQ9E9sZxe80Ry3X287rybkEcTzL8zL09UPrSW1NUSJLJmhrtB3BriJkVklMP++UadGlBHfDCuw9DgRdPCUGZbuZuRtCt86f873P5kMU904mrKvEZmNxYyrFxuItxTVIVOirggny63cU7tnIYUk5wdQYkFRoaEvyouqikIroqOFfFSPhhWMygZHkYvPInnijMbIirzQmAgMy9EclaepNlMXW9XuQj1mBdT+cJsVHgGJgASfYdZhNEHGCWwlm0alwPtMTbre8/B89uXZSLB73/DDdyxQFKaF2ybKTEGPoEDhKrrYRfQfzcNNnAxykZb//bZSeleJBJzvOCE1AQ0SGUfe2/BWsYgtnlKlSgIcaUCxL+FQyw87iE25bngQx3BUGLDzl5m+cEkH9bXdVO0ki+VrYhVNcq4O2/uKqrrLVRT/dDDfDMZZ8tzMM8DE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(26005)(8676002)(53546011)(66946007)(41300700001)(9686003)(6636002)(316002)(76116006)(66446008)(52536014)(4326008)(186003)(8936002)(66556008)(64756008)(110136005)(66476007)(54906003)(7696005)(83380400001)(6506007)(86362001)(2906002)(38070700005)(5660300002)(38100700002)(122000001)(33656002)(966005)(478600001)(71200400001)(55016003)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EVcLuJCGUHujRP9C87Dn2hDLt+bcDDJKlvm7SF0sda29/hSXjpEjMuLSyjBp?=
 =?us-ascii?Q?aKkiPDMKNeAZIV2DqNq/mOiZbT+hu3s6VnbMTIJDVPwgO9fTh5nkvl76jiAv?=
 =?us-ascii?Q?jEukVLb9tts2kHT1Z9wneNwC1numIFDCrVpklX1PMsXLP/iI72G1ciqZ/1sY?=
 =?us-ascii?Q?BZ++PKpQ6ibSnmX79+S3tRL2imftKXcHGV6SXF+JRzADjiY6VRunTs1JiCf6?=
 =?us-ascii?Q?y8A01D2ZVNMbRLyqS7Bg5BP3ZDoBKSVrPs8Ddwgq/SbVdXAPCX+27DyuYsF0?=
 =?us-ascii?Q?IewmgvLj9oVTKd8x6ypHBQ17rC8MdNeUwUUjLTl3MvNDpaXjxbGODxApCeA6?=
 =?us-ascii?Q?iT8JEEN9f49ixdZjBUbNFnonVp9WKmUSty3YnFBAzZ87JhIR7BpUrA+1L0gU?=
 =?us-ascii?Q?GX2pvQaVxRO3gdOSN1MY8OWvfVs3WycUHvP0RJkX15XdZzNHPXupX+6UXX5I?=
 =?us-ascii?Q?41W0hfh306kXjLe7HNL3g9mccVv1szQko53p3lJ8bdJDVdgMJPCYKcEVSHi8?=
 =?us-ascii?Q?WqWmK1krAdqe0hoNGMqNewt/7kfbAu/oRvJp+NcHJiykVlXySjls5oiUfh/W?=
 =?us-ascii?Q?gW8/uF62gprg9dOvcAC4FVl3AYrmELPjcMlWqt0v8OZqry+124AYE/8MlnAn?=
 =?us-ascii?Q?iRNfSX2c+x+SEN+es/WPGWgvWA3qMzsf79BXlGWUb2tdpWeF2Ua/lRQMWQfP?=
 =?us-ascii?Q?ohUIYxVi6/ThtZod0c5X6s1No85ACg0mypesdoMD2coXeVR3tYmVYj2OBGQx?=
 =?us-ascii?Q?VoeAF+lE6hHEsfCwa+6E8/uzq/KbFBfJVgp+6OZ3VhOnYUtylkmQcFfMcrY7?=
 =?us-ascii?Q?muQomp1nRl069gohvwN8gBgmteFx011rxVNxa1zYuSlCHWSLpgzSj9HewUqA?=
 =?us-ascii?Q?952pVZtGyFWG5otrsQjxnoAoT95PKnADO5VDfbQraRlHpdVzg0ap9ZB2Dtuk?=
 =?us-ascii?Q?qC5AkAkr794wDsA2XZkp4oaENShTyAzHuoTngG5Jd4K3EumChCKRt5KRq15+?=
 =?us-ascii?Q?X5txc1gUsUBt8YUL4LcLqjOBJ4RTENf0yjRZ5lEx6QQFjtvGP8Keh2wXapie?=
 =?us-ascii?Q?JesZPJtwyf6OVqo6+mPyYYgeoydebPC8pdlL5fQtOxKFXkzq8B6SSXg37cWw?=
 =?us-ascii?Q?RNRmxyHDfExXSrivRQQwvHqmNNeTBxrvo3tPl1wwPmi4kNpIuy9G8A0EajGJ?=
 =?us-ascii?Q?VZbbwK2mzLfB5pgXDf8kmL1y7bbefKL0teDFhAg432EaA8IKbFW2+5aAXa4N?=
 =?us-ascii?Q?sPG07PZc44ShOaLp0MJIE25cL0QS0MWLCOtDhY3yswuK0ikgAJzgingIYiez?=
 =?us-ascii?Q?jjfiX+7Be70m983rEAFX6zpVn4IqxrbY8dtCeowDogFSrPDE5SkJGhUblRRP?=
 =?us-ascii?Q?nHqV3xICcK3fxD8eAmLZywWCSkVjcWo3OhePwpKIxjjEskOEMe8Vcgm+TpXg?=
 =?us-ascii?Q?EgvpFWWjbh63+wd6cIWmQnRJF6kpP3TWIuJhfYV9b1FL8Nyt4U5urOFHsNTJ?=
 =?us-ascii?Q?zyf4aWwMvLS+i9yfW0ObDNHMdmk+EOWxQYIHjy/7CDFl9hRrTHqPOX0ue8Cp?=
 =?us-ascii?Q?wr5sqznmX+0DHdxYcWY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17d1b31-cc9f-4d34-1884-08dac8b5c1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 16:06:59.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txook1ct9LEakZ6sab/aJJgIX4m/+8s2EVHmMfykVTY7xt3QWAdHy0GJWDEqy4ImbK/H+pIOQZ5GNuQXcTdV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Thursday, November 17, 2022 08:06
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
> <Shyam-sundar.S-k@amd.com>
> Cc: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Raul Rangel
> <rrangel@chromium.org>; Mark Gross <markgross@kernel.org>; platform-
> driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3
> issue on Cezanne
>=20
> Hi Mario,
>=20
> On 11/16/22 16:43, Mario Limonciello wrote:
> > Cezanne platforms under the right circumstances have a synchronization
> > problem where attempting to enter s2idle may fail if the x86 cores are
> > put into HLT before hardware resume from the previous attempt has
> > completed.
> >
> > To avoid this issue add a 10-20ms delay before entering s2idle another
> > time. This workaround will only be applied on interrupts that wake the
> > hardware but don't break the s2idle loop.
> >
> > Cc: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
> > Cc: "Raul Rangel" <rrangel@chromium.org>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>=20
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k
> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpdx86%2Fplatform-
> drivers-x86.git%2Flog%2F%3Fh%3Dreview-
> hans&amp;data=3D05%7C01%7Cmario.limonciello%40amd.com%7C674f8bf7a8
> 114f83a3b408dac8a4d941%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
> 0%7C638042907591739047%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&amp;sdata=3DXYwl%2FOvUFy%2Bgz9EY9oa35M%2BkLf%2Bud8PKXynQ
> FlrUdoE%3D&amp;reserved=3D0
>=20
> Please let me know if it important to get this as a fix into 6.1,
> I wasn't really planning on doing any more fixes pull-reqs for 6.1,
> but I can do one if necessary.
>=20

AFAIK it's a corner case.  I think it can wait until 6.2, but I think it sh=
ould probably
be Cc to 6.1 stable (which has the ability to run code in the check()) phas=
e.

> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>=20
> Regards,
>=20
> Hans
>=20
>=20
> > ---
> >  drivers/platform/x86/amd/pmc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/platform/x86/amd/pmc.c
> b/drivers/platform/x86/amd/pmc.c
> > index ef4ae977b8e0..439d282aafd1 100644
> > --- a/drivers/platform/x86/amd/pmc.c
> > +++ b/drivers/platform/x86/amd/pmc.c
> > @@ -739,8 +739,14 @@ static void amd_pmc_s2idle_prepare(void)
> >  static void amd_pmc_s2idle_check(void)
> >  {
> >  	struct amd_pmc_dev *pdev =3D &pmc;
> > +	struct smu_metrics table;
> >  	int rc;
> >
> > +	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed
> */
> > +	if (pdev->cpu_id =3D=3D AMD_CPU_ID_CZN &&
> !get_metrics_table(pdev, &table) &&
> > +	    table.s0i3_last_entry_status)
> > +		usleep_range(10000, 20000);
> > +
> >  	/* Dump the IdleMask before we add to the STB */
> >  	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
> >
