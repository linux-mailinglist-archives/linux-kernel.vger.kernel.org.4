Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56D6507EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiLSG4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:56:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FCD627A;
        Sun, 18 Dec 2022 22:56:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbgYUZqxfJJvTykkClc1AEi7L4loSRKiFKbpuSDG9vCz2LyUejb16hMWCBFvsltNt7J76BFpazaw587dJEAp+ytRjQQ07TTeB0pzX2gn2MOHx+MTygp1EMabBdSmlEgglT/ypsgQKFMk8vzYm5Kq9rgrwelSvw7w3VStO1Y1huOoIVH4EAh532vgS8r0Si7yTr+6p1SSSYJslrjtoY+vmqTSzK/fe6X4sYUft+Y3zeBCt2aWsM7INCzyJYD9EIZhvGK3bnRb/f85wa3fPCCQkqdJw9aV3yuRJhywFmujGOuRnOAs1EKFTVG+K8EQm7rRA74lHckzQx2nu2gSPXOMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuRdatzWVvtGcOL7/TvOWaI/B5VvA/QomjDFnNB3eqs=;
 b=O6ETN0zi7UII1an2BLejk7T9/rB8jAOQO/DMHmEPrYNhr+CJwEIgIyo+JIC5vXHK6wfvGXPyvaRp6Claxe3xxqFbz9RZlkD3ArRPP4jTyZR55ESHHNiJXBz6CFyD/yd90VW7hhlD4sFIKnNK1BKsGMN8L5zXJiM4SikojrVOqEvBWa4gHMxJAHWvaESsmxE40GFIsBzRXPApz6H+yGhSoaQsqgzcsbl1zJbbM7riQ+rOPcEGFmXgjw/jEVMTN264i3Zd3KkIk82R+Sw/aqKBb2R3BmLmSiM4qPguTefEGWbQ40RlnhIrXSelA5ivw3iUS3QiIdGXl81gVTLBjBLAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuRdatzWVvtGcOL7/TvOWaI/B5VvA/QomjDFnNB3eqs=;
 b=2Qwc9vntZiwCwHAHPcuoW+FZVndQX+JL8b0FU4n92Im8FdGQHc8KmFdPWsMjkDNb6F+PR1IJ4Q3lbnOuMTNaChPdp8TwqgCj4aEYdufEk3zj+EdUvZFY4pSY+aPG6j8AwScTHsfw3ePUi5tw4rpzsxofebwWZb16s7co08VimGo=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:56:16 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 06:56:16 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Thomas Koch <linrunner@gmx.net>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
Subject: RE: [PATCH v7 08/13] cpufreq: amd-pstate: add frequency dynamic boost
 sysfs control
Thread-Topic: [PATCH v7 08/13] cpufreq: amd-pstate: add frequency dynamic
 boost sysfs control
Thread-Index: AQHZCvcYuxn3xMgAyUuU0alA0/p6DK5zn2sAgAE3P9A=
Date:   Mon, 19 Dec 2022 06:56:16 +0000
Message-ID: <DM4PR12MB527891F1ABD8226CEB424BBD9CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-9-perry.yuan@amd.com>
 <dad11455-94e1-4b8c-d382-7100f08cd896@gmx.net>
In-Reply-To: <dad11455-94e1-4b8c-d382-7100f08cd896@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T06:56:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=328d9d84-2667-4f1f-b58b-e4532a4538f1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T06:56:11Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7ffd354e-48e5-4069-832d-7fe0f7ec8565
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM4PR12MB7550:EE_
x-ms-office365-filtering-correlation-id: ae7cff46-48da-4f59-a854-08dae18e1fcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3TvZd8dGbt/4zbnsCxMIHXV87ynqB9Tamc41hgX4x9Z5uFdSutcNgBo4xkAgvXXrpQGxZqpMczmVusuQCBJOvmPehetRvtXtJQEj2GZ8L6eHJCK+kF9w4IICCGxKotXPyptwoZ43lk1vk6lK7pnM0/bwvpkdpdc6gyjWegV39qWffVyW2rAsxonty+IluCdnbFS3jRmdzny2WPR5VI20mq1m/DqLqvAXQRvId7uq+AWJ93mFNlYDvCJW5mz/jqWANKUFpePjRj656I5vq0I4M5HOPseZcrc2B8icaypfT3VkBH3zzVAXPUuGptYHJ8FIWkmARG1j8a7VxMxtEiEbGQh6mD9TaSy9w3Np/mRwhLOYoiq836mrRlFxo+wZWmJX/ST6VfviGEN8K+ZwQtYDNb8KJUmlHpQVQOvl/wW+9l8Fw8WVUN1U+G9ya3N/86aLhzPyypyRnAWcFG31DmymGvVjzhNyK8MTT034H/grzOS3+ZsZI++PVFfUN7crY8VEIMw7woE2/B7C8jDQ7fHFCsxBnKuzHw+ZytL2BLdi+viWSzgSrlY0yIanBT/DCc8x+KEyO2EpssW3X3NO2ovzKmRsn4MY5QnaQLZUPyLGClz9gS2zimArqCfP3o3/03t2tBhS2FEiFRGGiRb5vTQCsAIhYlMBKusG6/1YG5n9WAS1MPWEv2e9sthJ3Ow4SO0T/Dj0AefC40pISaDOGc9cbRSgtu5a089RFQoI0/xeYao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(5660300002)(45080400002)(316002)(966005)(54906003)(478600001)(71200400001)(83380400001)(6916009)(4326008)(66556008)(186003)(66476007)(66946007)(76116006)(8936002)(7696005)(66446008)(6506007)(64756008)(8676002)(41300700001)(53546011)(52536014)(26005)(9686003)(33656002)(2906002)(86362001)(38070700005)(55016003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5qzebG8qnTBHyf36EMUgibn9AsZEyoPe06aatCzOLbpjexSIr42PYoYgOZ?=
 =?iso-8859-1?Q?uVYvrDjc0GCCIbvH20No72i33QO6LjjEqa1tHeGGhFV4gRPhfZvqFh8YPx?=
 =?iso-8859-1?Q?DX95wEUG2yHxUd2M9WFF1o+nR7eT7tyPrZ5MWI8FLIhI6W0jzWxPGZd3qM?=
 =?iso-8859-1?Q?ksh/83Y6wpmRJNUe0s7FPg5m6ZCuBueKCrC6AJEYoNuWbmUjsO1LsmCRxI?=
 =?iso-8859-1?Q?Wh+DqsGzb7xZYCbxZ65odPJbYrcmsA0/bFIZCbPTDxG7cVZjvULd2YvuVX?=
 =?iso-8859-1?Q?91/DmBphercQazRcbb576WgTc7aThLVaOaQhH+s8DvKsUK6XWEjZIZBZV3?=
 =?iso-8859-1?Q?+Y/Bfha2j9f8ujVVLFp587xT3R/v00RU18JD7LOhXLNKJ2g5Oz4FPVxlPY?=
 =?iso-8859-1?Q?ot/3ctPoIVvc0dDxpwAVGpIP12uKucl4hY23vkCIuf/GUQ58j9eKL0f7+1?=
 =?iso-8859-1?Q?N5GXT1moge0FGPgq022hE+pqkakJdNe/rsuBzw4A1DuzOfabVS5yShgCNy?=
 =?iso-8859-1?Q?b1uPDYLUmKIvivc93FdPynQctzGvGg1HE2TgRmrbdIH1U9/6jiubsSoUkv?=
 =?iso-8859-1?Q?xLW62xkN4rdI26tmG8mFaZ2w65b7DW8g0nerbN8T+ZzRlyUS1Lz5guDi5K?=
 =?iso-8859-1?Q?nR64XI9QzbMc6/QLPJABQgNMfJvJ+JKG8CQ2eCsu7QWfBRZkjB/3YXPBjf?=
 =?iso-8859-1?Q?wEx7PuI8CwgKYo9mcsn3NkTimG665oy3kZxrB08wgFrAcizMTXXqjK1NPH?=
 =?iso-8859-1?Q?SFmM860wC95w2PV6AXhYBTh0Sbn3Wsn8Z+yCICdfVnF0ten1Y7NqlqM0Vt?=
 =?iso-8859-1?Q?9NnQKCQyBXpSN8wil2C3wX4B/IhxAyt3fMbyd2e37gDZ4DAOgL1Dd9CFAs?=
 =?iso-8859-1?Q?I9HJJHSVlxtCkcgMl7m/1b+lUDiyff4yF682cTEIfPB/qiwUIc3OH86OTF?=
 =?iso-8859-1?Q?Istr2iBTSG/P+GvLBjvJBlbfiyjpVhO7t8PUymDNC8yY1h08TQasMbgQk7?=
 =?iso-8859-1?Q?noTSY/U1hiBqKKGpfC2Rho6+qwoSjby5isKHxBCM03XLYWGgktMqAivu9c?=
 =?iso-8859-1?Q?WNvdiMDaW4cr7WvLW2S+TdQ13nQxPPIQjwk09Rz4nbK8BRqS+q2r8FnPJE?=
 =?iso-8859-1?Q?HJAS8/kGC2mGqAylL0a8Laf5339M3xLedjluRbHR9E5fCJHCCUqLC8BuwU?=
 =?iso-8859-1?Q?9uH5noHdZeEF6C0ZLex7gSz8rMdeSnZV//M7VjwKFS2Grhgbw10hqxfpBK?=
 =?iso-8859-1?Q?gVZsBufIe1j47V5AOMjsDjNOsIFuY9OmwI3grMxxLUrJextAKa6KK8sR8I?=
 =?iso-8859-1?Q?uKr6k+PjCaRxtH47bUXPv8WOllZqaC3mF9HhzVy+gTsnoFP7JQ/AwH5/43?=
 =?iso-8859-1?Q?rejP9vWeXGM0pVO8tJlws3BGRSruHhrifljWm+MdccTW12GN2c5vDK93em?=
 =?iso-8859-1?Q?iQBa6ebdaypo2u4DgTOoXHg6oxO1GHPLxRuiihAiA6tYSwsuXyVFEEbZwJ?=
 =?iso-8859-1?Q?M5maO2XWt62mnRT/GT4OzxLYUGW4NwzABLMrRzl21xgtd2+d4NfnfA18RZ?=
 =?iso-8859-1?Q?HozWpy6hcgmTY7FpTuIqsOiddjjrNPAFbJjvv26rMUGJ8SmTsqIQ7/h4/q?=
 =?iso-8859-1?Q?xaV8moxh2PJY86a+n+h/ipZpULECmlJqLc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7cff46-48da-4f59-a854-08dae18e1fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 06:56:16.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEWLHbaLu9KPPrUfKl/KKvtpK0gOIyPmBhuU+wEPQjuMd2ak2D2w01N9blFX/nwxIB+gf1UcU9Gm+ODAhRX+Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Thomas

> -----Original Message-----
> From: Thomas Koch <linrunner@gmx.net>
> Sent: Sunday, December 18, 2022 8:17 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; linux-
> kernel@vger.kernel.org; linux-pm@vger.kernel.org;
> rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> viresh.kumar@linaro.org; Karny, Wyes <Wyes.Karny@amd.com>
> Subject: Re: [PATCH v7 08/13] cpufreq: amd-pstate: add frequency dynamic
> boost sysfs control
>=20
> Hi Perry,
>=20
> in amd_pstate active mode, where is the equivalent to
> /sys/devices/system/cpu/cpufreq/boost?
>=20
> Is it /sys/devices/system/cpu/amd-pstate/cppc_dynamic_boost or
> something else?
>=20
> --
> Freundliche Gr=FC=DFe / Kind regards,
> Thomas Koch

In the EPP driver mode, there is no frequency boost options to control for =
user end currently, the boost is created for the iowait boost feature.
The CPU cores scaling range is controlled by the lowlevel firmware.=20
Next, we will consider adding interface to influence the Min/Max Frequency =
if customers need that.

Perry.

>=20
> Mail : linrunner@gmx.net
> Web  :
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flinru
> nner.de%2Ftlp&data=3D05%7C01%7CPerry.Yuan%40amd.com%7C64eaf9320b
> 05445198af08dae0f1d911%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C638069627013800892%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7
> C%7C%7C&sdata=3DPQNBnIuU%2B95%2BBqwwqoKosGKhhYYvJSxMfI1vRCaS6
> p8%3D&reserved=3D0
