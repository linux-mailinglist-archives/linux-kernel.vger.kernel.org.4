Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F19736201
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjFTDIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTDIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:08:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E356F119;
        Mon, 19 Jun 2023 20:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8jPEs+FkbklQRfx3TkLRwUYlHPbk+3veKuSk5bJjelQeiRYpnCIMHozN63fNBkKoQ9RkHDSwPzgWo5vtyENulhvo2C+jVWnO02h16rDXsSax2l5jUYM8FHJY+ajra1+SDgt2pfSIrZaSwoei7BSff+ZVuP1Fj/59JV89dwP/NQEppYwyFUmxKgqCdEre1MYXkwo6bzY3v/FiiVM9TVC7Bp8W5DtftF5oAuuiBlZWJmGcqWdaORLcpDiGi+9zyo4Ew1kFrUoZpeC6+czqPMWBn8291wiSdLBCzLrcNt6TNNbqf08OeYQFUWdaJ37gH5igbB7mpbx8dkDSmqH4rLH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7NnDq0NMtihY4zKPGN1nDQepvMnjoyKRkdzZ7ULFW0=;
 b=a+ML5/5gM2z/Antrrjs8YMgrK56jwrGwjlUHrGF5RbCwGD5zytYOkM4QvMBcjCRepatO2f7Gp/1G+f0QwyB2mCWp57mx2ir4a+3ONYyuF9Fd3YzEs5HNn/CC7xjFEr0j4rKjuWNVY2M/0XXl2bOBxx94sV627InUt5Wl32fiOk0Jd99uKELulCmsBd6cq79xWDhOJW8Q78i74OOawdLKY9ezjucVADNdUZnu6Gwa4RAhjcjhnvIJ1k4ZfvPg+cwPVE0leo/Khv/Qdq1fxUp0XlJ8treVP8toa/1Y0LbupQL6F4jRtMiRcJiD4+CsV60YpvKTCfc6OoQM7yWQ0UJXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7NnDq0NMtihY4zKPGN1nDQepvMnjoyKRkdzZ7ULFW0=;
 b=KzKyTYBNPr65jxfnFdn1A0ghY20rq51k3EuhdLAxfI7rYUf5dUNklPy/FxW4G0xBLXTD7lb+jGSeaC3gtPjY1OUngsBGB9M/7qANlYIu8fJb7c3fEWdKHVPBCZ2tS2ZTfLeniJMoowXFlYW0ngLKebdG7IrqEeGJFmIQlui3J+g=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 03:08:32 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:08:30 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v3 4/5] cpupower: Add support for amd_pstate mode change
Thread-Topic: [PATCH v3 4/5] cpupower: Add support for amd_pstate mode change
Thread-Index: AQHZouFCg6A3VCNrTEWGGh5MN4qSra+TAyQw
Date:   Tue, 20 Jun 2023 03:08:30 +0000
Message-ID: <CYYPR12MB86552B06E656F3C4F28C05659C5CA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-5-wyes.karny@amd.com>
In-Reply-To: <20230619190503.4061-5-wyes.karny@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=87caa6f3-ab16-4297-82fc-003a00aaa77b;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-20T03:08:13Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 84b4bf74-816e-48f3-8116-08db713b9fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UP0g89JXxPcS9VPLuRBBOuSg6W5nkrOusvfuAhPyHD1l6MnawpTm/bI4Zegh+TjZGSAi2vBXF2XmiDqRLr2P1YCLGkwwfiSmbnZk9BDwTZ+3LUqfIysArktUG9vr405wo/aDfbCi3IuVHks/YR16++GRgngQSlyapbddeYLVfgTy5OGyVms4dWmf8u1rXI7Idystk4+6D4dMDFmEbgRc2yF7YlwljXlbxQX1Ku7xIYLmbizaI3RS0WkXMeEse3KnI5la/RE/5ygP21n0wViXhlGzCm5Z86cafs9ORRhB1cbuKWyPLQZFWa4t7kRHt4NxWCAOFxa7ZgU8ISevSzARsqiLY7ebsj15WvOMusbOvoip45iCeQBFdzLiUEUIGpNjDF/XRDHZV38ioBmHZ3BwUb+9609rKl/WPRYywIO55YB5qY2+AjynQdZCe7d2Z9b2J07MHPoX221d+W2VIY2OQTb9p/1a4ESU9cblzgi/27KPwKKf5824Z7luIDwgmwwoHFjyGs4dX379LCrr/Nb7tg065zAJ/n7H2lAFPlZ6KVUJy5jc7jYgp2QUhqx9IzGGl6W8cVChqszwn7piT354s6XHM9GC+YiIyM4f7gRnufRdHGNMNc6+m5PsARfp52h+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(478600001)(52536014)(5660300002)(4326008)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(2906002)(54906003)(110136005)(41300700001)(316002)(53546011)(7696005)(71200400001)(8676002)(8936002)(6506007)(186003)(26005)(9686003)(83380400001)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DWZEr7TfKXj2g/IyMqJzpdKIFL5XSkq9dmJ4cIkEfUGYPsveSiAFXJEtTLFO?=
 =?us-ascii?Q?gVLSrN8PiWrJEkHRs5ORe5KEGcRreWDDfLqDgFJ/g2FGMwxUF60iceYiPuT3?=
 =?us-ascii?Q?y/A2AGoe+zyZ0XuaQ0AwedpQvqK+NbXG0JAnj7rPn5+6nWuZtxdWK7Ivsyx7?=
 =?us-ascii?Q?v5b9Z6oRu2e2yHW2Y8jHSQBV0RABw8A6WOTq7KokAWxQTFCW652iD7KYYqEE?=
 =?us-ascii?Q?PY37b/pQkkU3V1fLRvuqHAsxlPbmHqw9StF5tDqCYhTLTY6w5Qwh/4hJiNr4?=
 =?us-ascii?Q?+nq8A+b/gDyHjJ7ZVfP6HosyB99jT2sJhGaU7YWvhIQKw3Y0BDx4Dq8Xgp3f?=
 =?us-ascii?Q?VAUTlNpz2r2KAVJ8agzn+kPftkfwuJI7XKQj1rtu5d8AUWq9othnau6uwb7O?=
 =?us-ascii?Q?QdfTA+buUtUB1r0KvZ63aG8vN7vdZRnxxsdMLlG1V2K8kPntteUIwgt2djmj?=
 =?us-ascii?Q?bpqr08PpzA0XzVpT0C4Q/UoeL0U1ucT9oivEE2Xx8sVYJwdZrZ2PkQMRUl+c?=
 =?us-ascii?Q?TTDZx6/MqyyHSliLFh6weJ6L1hFhd5wukonwCigCsqykeQ2bLdyxnkabza3N?=
 =?us-ascii?Q?eAboN1/QhojjUa+qDUYVwiQrfKphoWCunSPbtxaCwj8OBxSGRCQ/HEEvA1fx?=
 =?us-ascii?Q?p4PRn7EFCaBUps9CBZOtWZSusw0BRiZgZp+I4obF3fkvsHg5JjwUB03cESly?=
 =?us-ascii?Q?yyHjr3XxI97MIQnmlVfb9ALRZ+ibsypadjHY7xcAY6HIqgLbmMIWJVk8LVjW?=
 =?us-ascii?Q?1oqQJNc+UYxIQ2qBrmYSTQ/eTj1zIDu0X29TAYIOrhQY81rIfOoaHncCFWWg?=
 =?us-ascii?Q?AaUZofb8KyZHjIvR8m58t55ov7/9AeHalgqtF1xmwzq8q6DpcdHoF+pBqfIz?=
 =?us-ascii?Q?zy+d5gPClh6J227VqDADNB0Rl0PteW59IZ3BM7sx14GBdoPGXou0bEKPE88R?=
 =?us-ascii?Q?ogLfRrqGyhWiYUbGzedorQL34jSBIQ2HflbXCau/xtNJOwFm+phsolNntXG7?=
 =?us-ascii?Q?RLPe2J3Taxl8P+9CeLcHosseYUZTmUyLOJRCKWXJpVgnTlzY6pTQepk0HGdw?=
 =?us-ascii?Q?vZOhaSu0FqNylOgYs9XU/byj4boJsUqyexW789pLk7tXGWxdgWdqe+lECXdi?=
 =?us-ascii?Q?U7z0HFxB8P1VYMDTTeyzxplSKGwOLI9zoqZme+M9t5p57JnhXoHUQP9lOb4G?=
 =?us-ascii?Q?9KtLftut5Vg69K3EVIADjLTyiSSKbnuXRTvnbslq/29Kgv63O25sQdGQtSP1?=
 =?us-ascii?Q?2YI1oUvyl1vGpbV+jpQZ6UGdcENR6xX+VJGXrsl+R8q+ZtDH7ATVGhckXuay?=
 =?us-ascii?Q?Lb4wjTBbwqcPLEmrI5KxftxCGEFtjEpEAvhsjvt/QKvvq3Ys9LOxfhNRQUpX?=
 =?us-ascii?Q?KkgHxBZzZWdgIfYbHuk6qdtZloM3Rz9dGyyG6v76GV3rkQn8me8n6sIrfnE7?=
 =?us-ascii?Q?kHZoKlAxMOwYOw0p8pFD2UyIu5zqOfW4VQYugB5Pv+wlp8pQ3Nwv44EeCks8?=
 =?us-ascii?Q?cg9bycBRGve5rKN5Zee71saOC/2skqFYzDzOGbiGU+Si9gjgFFoJn1FQ8obM?=
 =?us-ascii?Q?7qfHjOPFMya421O3gSI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b4bf74-816e-48f3-8116-08db713b9fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 03:08:30.1465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9f0HBK+65NXjbvgj9d9mQqdwbgp2Qh45iJFehq24qmoWsgck5UVztW4xCMKRGD3ms2CW8IPzTNDQZ4pP1xcNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Karny, Wyes <Wyes.Karny@amd.com>
> Sent: Tuesday, June 20, 2023 3:05 AM
> To: trenn@suse.com; shuah@kernel.org
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel=
.org;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yuan,
> Perry <Perry.Yuan@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>; Huang,
> Ray <Ray.Huang@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v3 4/5] cpupower: Add support for amd_pstate mode change
>
> amd_pstate supports changing of its mode dynamically via `status` sysfs f=
ile.
> Add the same capability in cpupower. To change the mode to active mode us=
e
> below command:
>
> cpupower set --amd-pstate-mode active
>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  tools/power/cpupower/utils/cpupower-set.c    | 24 ++++++++++++++++++--
>  tools/power/cpupower/utils/helpers/helpers.h |  3 +++
>  tools/power/cpupower/utils/helpers/misc.c    | 18 +++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/cpupower/utils/cpupower-set.c
> b/tools/power/cpupower/utils/cpupower-set.c
> index a789b123dbd4..c2ba69b7ea54 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -19,6 +19,7 @@
>  static struct option set_opts[] =3D {
>       {"perf-bias", required_argument, NULL, 'b'},
>       {"epp", required_argument, NULL, 'e'},
> +     {"amd-pstate-mode", required_argument, NULL, 'm'},
>       { },
>  };
>
> @@ -39,12 +40,13 @@ int cmd_set(int argc, char **argv)
>               struct {
>                       int perf_bias:1;
>                       int epp:1;
> +                     int mode:1;
>               };
>               int params;
>       } params;
>       int perf_bias =3D 0;
>       int ret =3D 0;
> -     char epp[30];
> +     char epp[30], mode[20];
>
>       ret =3D uname(&uts);
>       if (!ret && (!strcmp(uts.machine, "ppc64le") || @@ -58,7 +60,7 @@
> int cmd_set(int argc, char **argv)
>
>       params.params =3D 0;
>       /* parameter parsing */
> -     while ((ret =3D getopt_long(argc, argv, "b:e:",
> +     while ((ret =3D getopt_long(argc, argv, "b:e:m:",
>                                               set_opts, NULL)) !=3D -1) {
>               switch (ret) {
>               case 'b':
> @@ -81,6 +83,17 @@ int cmd_set(int argc, char **argv)
>                       }
>                       params.epp =3D 1;
>                       break;
> +             case 'm':
> +                     if (cpupower_cpu_info.vendor !=3D X86_VENDOR_AMD)
> +                             print_wrong_arg_exit();
> +                     if (params.mode)
> +                             print_wrong_arg_exit();
> +                     if (sscanf(optarg, "%19s", mode) !=3D 1) {
> +                             print_wrong_arg_exit();
> +                             return -EINVAL;
> +                     }
> +                     params.mode =3D 1;
> +                     break;
>               default:
>                       print_wrong_arg_exit();
>               }
> @@ -89,6 +102,12 @@ int cmd_set(int argc, char **argv)
>       if (!params.params)
>               print_wrong_arg_exit();
>
> +     if (params.mode) {
> +             ret =3D cpupower_set_amd_pstate_mode(mode);
> +             if (ret)
> +                     fprintf(stderr, "Error setting mode\n");
> +     }
> +
>       /* Default is: set all CPUs */
>       if (bitmask_isallclear(cpus_chosen))
>               bitmask_setall(cpus_chosen);
> @@ -123,6 +142,7 @@ int cmd_set(int argc, char **argv)
>                               break;
>                       }
>               }
> +
>       }
>       return ret;
>  }
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h
> b/tools/power/cpupower/utils/helpers/helpers.h
> index 5d998de2d291..d35596631eef 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -117,6 +117,7 @@ extern int cpupower_intel_get_perf_bias(unsigned int
> cpu);  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int c=
pu);
>
>  extern int cpupower_set_epp(unsigned int cpu, char *epp);
> +extern int cpupower_set_amd_pstate_mode(char *mode);
>
>  /* Read/Write msr ****************************/
>
> @@ -177,6 +178,8 @@ static inline unsigned long long
> msr_intel_get_turbo_ratio(unsigned int cpu)
>
>  static inline int cpupower_set_epp(unsigned int cpu, char *epp)  { retur=
n -1; };
> +static inline int cpupower_set_amd_pstate_mode(char *mode) { return -1;
> +};
>
>  /* Read/Write msr ****************************/
>
> diff --git a/tools/power/cpupower/utils/helpers/misc.c
> b/tools/power/cpupower/utils/helpers/misc.c
> index 583df38ab13c..075c136a100c 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -106,6 +106,24 @@ int cpupower_set_epp(unsigned int cpu, char *epp)
>       return 0;
>  }
>
> +int cpupower_set_amd_pstate_mode(char *mode) {
> +     char path[SYSFS_PATH_MAX];
> +     char linebuf[20] =3D {};
> +
> +     snprintf(path, sizeof(path), PATH_TO_CPU "amd_pstate/status");
> +
> +     if (!is_valid_path(path))
> +             return -1;
> +
> +     snprintf(linebuf, sizeof(linebuf), "%s\n", mode);
> +
> +     if (cpupower_write_sysfs(path, linebuf, 20) <=3D 0)
> +             return -1;
> +
> +     return 0;
> +}
> +
>  bool cpupower_amd_pstate_enabled(void)
>  {
>       char *driver =3D cpufreq_get_driver(0);
> --
> 2.34.1

Tested-by: Perry Yuan <Perry.Yuan@amd.com>
