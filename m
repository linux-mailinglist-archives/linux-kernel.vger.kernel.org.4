Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7816B736203
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFTDI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFTDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:08:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09210DE;
        Mon, 19 Jun 2023 20:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1Dk0imOlwPmTQ9x8tHrqkd5WeGjZdNEHvllthi0UUMYMvx0/ez2OO+ELLayJeANKtI9xzqwtN1UrwnCFCqWCsfjgPYQoKaq54e6GZxXz425dVpktQy4VjtCBDaHBimxpPd/Vmy0PhFdNEd50CuoT09cWeNstsSMO62Na+E9IvtX/dr4YSrmotuYZ02zH26yVdAWVYQpLbdKP1c/lk1/8ORZ1Q0Tr0TZbOGQAp6m8SkMcysCtt+KqQAJo/SvOECX+0HpWEHt0jRg3mMEGyM6DH0lYmGpxhh45VVMsPlardU/S3QFX33mvAyS592dXKRRF1JgkLUnqC24t5GVVtAXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ4zBGlH5RAlAis/64qKpqeJ7jtj5j8qLhLDzh+1Cq8=;
 b=hBD+aecTnXZhQWgRYZv+03+RcHMCqYbrx9xPjh5Pmwh2u7nEiKbST0JdXcv4vgVLvmnoNMYlq/r1hEflO7bFo7EFdsep4UvCTmoOhm92xae/uSN96Jivgl7Ur9QjjuqB6BepJOnF69RhgeLxIRsLOujCZydsQ6rmxxzHC12bQGB7atceWtIFnxpZWm5xrTp1ulnc+/M0fmTKSN7DqXxEPhrlJLY2jymPc8ZFePiTqSx7gSQhsZtiy7E50XErfPhT1Yyd7lXZkX0UTEfRMvWiQb/YII/agu5LqV8CBW7adySp7fV4Hus1JCjnxdKdcP0bDFc/bZpQ/dIMZpp6Z2TFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ4zBGlH5RAlAis/64qKpqeJ7jtj5j8qLhLDzh+1Cq8=;
 b=FOmmR3qWLHyXE1M5VWvuisWei9k0l9a7VqfgRZOc1LNEgSxnnW1pfPm3TgcuTBCkvBlKuTrHKir2hhzt1YMDre8WP43R1Cw4B5m6y3EYtLllqSGqDFvMLbcB7vJSukipXGw278y2nbcmi+JDuwNRirHX2RbZXUHnUwGJAViwkyY=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 03:08:46 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:08:46 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v3 3/5] cpupower: Add EPP value change support
Thread-Topic: [PATCH v3 3/5] cpupower: Add EPP value change support
Thread-Index: AQHZouEpejSmnvk2gU2S4EecrlCkia+TAzuQ
Date:   Tue, 20 Jun 2023 03:08:46 +0000
Message-ID: <CYYPR12MB8655B6B2D4D8DDDF137F80569C5CA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-4-wyes.karny@amd.com>
In-Reply-To: <20230619190503.4061-4-wyes.karny@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=62f39bed-cb7c-4551-a994-aff3fc66c8cc;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-20T03:08:32Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: c29e2f73-9bf7-4964-d838-08db713ba99e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zD+HQSmq6a4VzAPUhUEBAxBWpYGk7z4x5EM8Ib+ISpp/g3ECIa9GXCFsHERv1+/4Smix5pUAo3HZNfVbaMLfEXvp9tCyvsY3TzNBRdnYEz9ieI/LYiXjWq8uUpjlZ3BVpQqR4uskc7x07mEhU5E4YS0Bt2hsuTv4uaX/USG6E7+mvxtNybvsalJ5vP3w3t9AH8cyXyxU7QnOZzOEe3YMLMlTBGVbOFBdWAhsmWA4O1FrD77NzhBAu5gPKDga7PiH0LB5P5oMgTUM6Ol72YNdgKr2z0283ONW+6ielqlgVmK9EwqP/qPEX5sIP2Bn0M1A0xFaFU8CfbDba7YOBXk2t190LnC+WRVZfrTMhrpwkRbGjUSvC+0zOhegZrUA92hmz9HDRlNZgl3kS0SHbgS8yDI8n/oiCTcairEII3ixBI7HwNW9fpTD+CH/MttgwZIRNHZJmWYGqEp7/sZbk1dwHkCPibT1TjK7HoPUzEKsUtetYppDj3Hp9Vp79m7uPjJHQBigf+Zy9BF3MkIsznt8vK9jyLj6GtkIdqaxaKhG+0wzfMLrTRcevJWNUSZp9eS0l5s8VuEJaKkjDE0wEjryx6Ayd41+/wXQxe/mn7UC6D5gD9DzMpPLeEUkkgUUsbuW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(478600001)(52536014)(5660300002)(4326008)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(2906002)(54906003)(110136005)(41300700001)(316002)(53546011)(7696005)(71200400001)(8676002)(8936002)(6506007)(186003)(26005)(9686003)(83380400001)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZnNgt2OjYPuMneqVXGjuWN3ZuivNNmn00PUsuu/l0+IA0xmUg6cMsgM1p8wy?=
 =?us-ascii?Q?TfCw5F7sn7UhD8isN0eAz9B8YN2YvTnZAMrD8knTklOI8pxI9Fna9qePbkn2?=
 =?us-ascii?Q?qTZ9ZjyOTj7LrB1A6V6nvtgRU9eKIxPR6xgpx8KjpmUydI3KQpS7OF1SNm1W?=
 =?us-ascii?Q?kd2eUPZiuyKg5NZlFO32Inr1BvYVDCL/fHBj7H+2NLYC2sZuRQ+Es4/rXp/M?=
 =?us-ascii?Q?Vl+Gi1gHMe3JvW0BfmFVW3SlFyDe7ayXy7FAESjaIooMIWZzVaaxDONXwMPt?=
 =?us-ascii?Q?/ALfA7V+M4zHFXpv/Pv+M9eyaYvBeGCqm8xKKgmKA8D8DwFoZvqijIn1in0i?=
 =?us-ascii?Q?raKKoJ3r0VwouUIV1Y7WzbgZx5fBflU43v3KZJ9X4lGa/rEKQDtSCjA9USEm?=
 =?us-ascii?Q?uMgMvlHdThkgVuKNpHiQmm4LqvbwAb42wN2V9AGfh+JkztujGKVnJJEqAWMO?=
 =?us-ascii?Q?PKt40WDKNbdNwUvvfLtbO/N651YeJqyUIh5uNN5DIajdfue34fX7xumLvzx6?=
 =?us-ascii?Q?YJQqOx07wZIYezKz8grGfU2cSBcZAO8vtbk9oyiQLHzhwJ5cCm1wE8VTDWcr?=
 =?us-ascii?Q?/Uj9XBYTqiW3OcxmfAJEX504lgICZ94iwuR//IL6odk/+qbV2jt7DJSbBMzs?=
 =?us-ascii?Q?z7pspyheh8E4szEWrM52FtdVGrYk2wsLqXTe/7JjFTICzMOi5cFXmOGFZ3QX?=
 =?us-ascii?Q?7O82Zo+r5YTitRfwvOHyULmJUGuhtl1Swyqy+zMdVbdpRG5Ozwi3hMQXj+G+?=
 =?us-ascii?Q?pfFj20ZdrWLlPWewG6xbojP9K3MnqOY70yR0loU6nrhAFffRz/f7CXAiP+We?=
 =?us-ascii?Q?8u3ntTmB56ibRiQ9cc/vA+/CqrE6OEuOKyLXZlxP9Z6BN4AcVgMmahO1U409?=
 =?us-ascii?Q?IczINOT2xE7Hu08Me2TT5pWAtp6luU/gdJx98nC3KXMb6kOqQKliaZM/ho0e?=
 =?us-ascii?Q?lQOYeBTJOLoHkBgGULMS7qCtRUYIF7qbvKgNBcnRoUGst5LiAEzRe6bfOThT?=
 =?us-ascii?Q?GqbFuztVUGp2AeXDVqslUcooCOwH9fIHk0JsUD9QtNKjBwpOZTED+uLIKhvJ?=
 =?us-ascii?Q?6RcQIYZLE17qLDn9J9YpA4K3MidVLshmyxXjEB41aOQGAZVlS8vekXaaeVG5?=
 =?us-ascii?Q?UcDEUZggeKQ2UVOauBCHacGdF7fGlLQHLsqZem2kVezBhIMOqjqhv+moYoCq?=
 =?us-ascii?Q?CXdMFJ2nODYO1paPzyH3H1h0wjCd/EdOhl4Ukgv9vX0/RY0JbvIxYkB4nQFn?=
 =?us-ascii?Q?4c8xvbPiyW1l9iGTit7v9rpF6x95+Mp27xXoAGm8ConaHNi+uTo4XsFNDT3J?=
 =?us-ascii?Q?rL0LtEwtJ3n8g71KrqrENxGVwwlSfhfqBzsqtJUcjxTPu4kF1VEJBPmKQN5k?=
 =?us-ascii?Q?X4QTVtFzGnv7BuqohSGh/Z0LUhhXjQTW87u/+0WurgLVYftwGI7iJjae0vWT?=
 =?us-ascii?Q?Z6V8Hok3UE+CHGrrEPB3CuAu0IIrpzR8GYlEQj+5jSR9LX+np/ftpeViLAvM?=
 =?us-ascii?Q?gpKlQOkACwNtfihUe+thTSEAMDMjHY3tx8mhOvlD2Qy4esQy4cib1RPX5omx?=
 =?us-ascii?Q?8aSwjmgzTKrbdqy9YUM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e2f73-9bf7-4964-d838-08db713ba99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 03:08:46.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikuRp2qj6mv9Lo/Dwp5TJwWbd+LpRSvCa9YELxH9GXtmfVr3x8dZno6+ZWVm6N/7pLdPPlptY7XY1t4h+ogENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
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

> -----Original Message-----
> From: Karny, Wyes <Wyes.Karny@amd.com>
> Sent: Tuesday, June 20, 2023 3:05 AM
> To: trenn@suse.com; shuah@kernel.org
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel=
.org;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yuan,
> Perry <Perry.Yuan@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH v3 3/5] cpupower: Add EPP value change support
>
> amd_pstate and intel_pstate active mode drivers support energy performanc=
e
> preference feature. Through this user can convey it's energy/performance
> preference to platform. Add this value change capability to cpupower.
>
> To change the EPP value use below command:
> cpupower set --epp performance
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  tools/power/cpupower/utils/cpupower-set.c    | 23 +++++++++++++++++++-
>  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
>  tools/power/cpupower/utils/helpers/misc.c    | 19 ++++++++++++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/cpupower/utils/cpupower-set.c
> b/tools/power/cpupower/utils/cpupower-set.c
> index 180d5ba877e6..a789b123dbd4 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -18,6 +18,7 @@
>
>  static struct option set_opts[] =3D {
>       {"perf-bias", required_argument, NULL, 'b'},
> +     {"epp", required_argument, NULL, 'e'},
>       { },
>  };
>
> @@ -37,11 +38,13 @@ int cmd_set(int argc, char **argv)
>       union {
>               struct {
>                       int perf_bias:1;
> +                     int epp:1;
>               };
>               int params;
>       } params;
>       int perf_bias =3D 0;
>       int ret =3D 0;
> +     char epp[30];
>
>       ret =3D uname(&uts);
>       if (!ret && (!strcmp(uts.machine, "ppc64le") || @@ -55,7 +58,7 @@
> int cmd_set(int argc, char **argv)
>
>       params.params =3D 0;
>       /* parameter parsing */
> -     while ((ret =3D getopt_long(argc, argv, "b:",
> +     while ((ret =3D getopt_long(argc, argv, "b:e:",
>                                               set_opts, NULL)) !=3D -1) {
>               switch (ret) {
>               case 'b':
> @@ -69,6 +72,15 @@ int cmd_set(int argc, char **argv)
>                       }
>                       params.perf_bias =3D 1;
>                       break;
> +             case 'e':
> +                     if (params.epp)
> +                             print_wrong_arg_exit();
> +                     if (sscanf(optarg, "%29s", epp) !=3D 1) {
> +                             print_wrong_arg_exit();
> +                             return -EINVAL;
> +                     }
> +                     params.epp =3D 1;
> +                     break;
>               default:
>                       print_wrong_arg_exit();
>               }
> @@ -102,6 +114,15 @@ int cmd_set(int argc, char **argv)
>                               break;
>                       }
>               }
> +
> +             if (params.epp) {
> +                     ret =3D cpupower_set_epp(cpu, epp);
> +                     if (ret) {
> +                             fprintf(stderr,
> +                                     "Error setting epp value on
> CPU %d\n", cpu);
> +                             break;
> +                     }
> +             }
>       }
>       return ret;
>  }
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h
> b/tools/power/cpupower/utils/helpers/helpers.h
> index 96e4bede078b..5d998de2d291 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -116,6 +116,8 @@ extern int cpupower_intel_set_perf_bias(unsigned int
> cpu, unsigned int val);  extern int cpupower_intel_get_perf_bias(unsigned=
 int
> cpu);  extern unsigned long long msr_intel_get_turbo_ratio(unsigned int c=
pu);
>
> +extern int cpupower_set_epp(unsigned int cpu, char *epp);
> +
>  /* Read/Write msr ****************************/
>
>  /* PCI stuff ****************************/ @@ -173,6 +175,9 @@ static
> inline int cpupower_intel_get_perf_bias(unsigned int cpu)  static inline
> unsigned long long msr_intel_get_turbo_ratio(unsigned int cpu)  { return =
0; };
>
> +static inline int cpupower_set_epp(unsigned int cpu, char *epp) {
> +return -1; };
> +
>  /* Read/Write msr ****************************/
>
>  static inline int cpufreq_has_boost_support(unsigned int cpu, int *suppo=
rt, diff
> --git a/tools/power/cpupower/utils/helpers/misc.c
> b/tools/power/cpupower/utils/helpers/misc.c
> index 0c56fc77f93b..583df38ab13c 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -87,6 +87,25 @@ int cpupower_intel_set_perf_bias(unsigned int cpu,
> unsigned int val)
>       return 0;
>  }
>
> +int cpupower_set_epp(unsigned int cpu, char *epp) {
> +     char path[SYSFS_PATH_MAX];
> +     char linebuf[30] =3D {};
> +
> +     snprintf(path, sizeof(path),
> +             PATH_TO_CPU
> "cpu%u/cpufreq/energy_performance_preference", cpu);
> +
> +     if (!is_valid_path(path))
> +             return -1;
> +
> +     snprintf(linebuf, sizeof(linebuf), "%s", epp);
> +
> +     if (cpupower_write_sysfs(path, linebuf, 30) <=3D 0)
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
