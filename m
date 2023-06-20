Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71797361FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFTDHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTDHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:07:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD3E42;
        Mon, 19 Jun 2023 20:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArlAwTe/lVALxGTb6NyJrWXPFjOWUeyy0hIGTnqm03U8ajeRchOjULtb7k0wOLnEZovQo/NW8JzvTJG9VeRgWUATWzwhy10sx/XdMW2g5r3MHFtGphCe9aCzuxvXvNib63sTP17n429b1iqwl/uBV9KRDgGzDch5mVCwmKRxxXT+IdKpiZjlAeT2y5EUE66laISdDMqnRqQsAiCDkdHfkW17/zTIhfIYoViXrCdZbb1zTuBNPb7ELNkLkMM7EK+BT0JZVFBXw46m3KKuG+3rs6M8NKhwQ6x11NGqaNw8Z0t4Jwmv7N7o3IUTQdrTHWUbsTjqwbrFsHkRMGSOkm/y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwZ9UozItZ4ymu4j7SSJS7dviSIRqee/0IptJ+5DhG8=;
 b=SZ+yJEEKOviYEfsHXsscoTyLwl5nKj5Flo0YuRgIXHOPaRJ/7uiwC9ZHE8v3y2kSnIyz30Zep5rIEfH2YWUZe5P3lLMzydKmSUmyGBUHYSQvI18yGVx+6Shst5U6iSVzeq3lDHZ6mF2opYqKqAVnNdj5KMwlvkd0EASBJObt0uaA/5ZiqmKLDHuHZo96jvCjDCmsJnZ2p7j2FXQ9Scx9FjzyDaqyCdmwIiA0UGkyes/nT6WufhZwOKsc4cVr2f0BfdSgCS7H7raQeaI3NUJTOZvCkattJsY1LGlAbOF1GetoRs/lZyAM8nP/5EOg9MTufieV5GPU+nLqQzCZzZHVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwZ9UozItZ4ymu4j7SSJS7dviSIRqee/0IptJ+5DhG8=;
 b=itl8wgEbL3reV5K/hpESn6gbgFVN8QJD7kMPfTK6hH1ZI1CotZ6YjG08LFQ0G5NAN6HGyDSFsQb7nFVIU/BTNSDYRgI02EI8JEb/8F3z8cv7kYpi/ZQUCVAAQrgoQVrRE1GAcJ6hyiecHzIAVEJyvjMqVy8eeg5QsQ21FcSyGS8=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 03:07:31 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:07:30 +0000
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
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH v3 5/5] cpupower: Add turbo-boost support in cpupower
Thread-Topic: [PATCH v3 5/5] cpupower: Add turbo-boost support in cpupower
Thread-Index: AQHZouFRjOy6xTecCkO9qiVWJ8xGJ6+TAj+w
Date:   Tue, 20 Jun 2023 03:07:30 +0000
Message-ID: <CYYPR12MB865590E3567FC552308B75549C5CA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-6-wyes.karny@amd.com>
In-Reply-To: <20230619190503.4061-6-wyes.karny@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=db1e38d3-52f3-4411-9c99-d8c774e0910c;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-20T03:05:01Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB7742:EE_
x-ms-office365-filtering-correlation-id: 6f6d1113-4c2f-4c89-51c7-08db713b7c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfNPAl5ZgqLggFN7tocy9Pn3LwByshUa16E9qMBf9ud2iuTgYd5GF7eg0+Sv9uuNBlACWnDmbxe9LMdvQoAU/qPd13KpeXjQicVie8MoHGQK2KJRfm20oH1MUzfFzn/achqOxoz9F5XBq+/BwGySqGtV1txnjcz6bXGFPtKPLNykkMie3w7n1CjaMBu2B6ndp+QPXmY+Du6MQ5iZIx1KEATPkiK859RH2cvW9/yDn3/qbLVNJxYZoZZYk4mXIvXPaQxolV3GeqhDGLTKB/MLX/xE+NFlhBLDW3Jdq5u7sf29EEgZNCZIhZgldPFBLbM3QxZSRO0QMHdgo5dTLz3o4NDJMnwlUEFc1XWk0zc+vuWIoL8UBLfnNODRoMVvhZr56g6yTWCHosQE5UJWeBuVHAo0gRc7G9vpv/aewL6+IP/Ch3GVbxXy6xsxvqIZQD2jcC3IJIZ64scY8Mc7sWiJDHTpuTcaMVx7/xp/MVQXLMHWxuB3d6aRTpF8QDCALr1PC3yZcPH8D4HBGHSib1DYDJdpWFt+ZUj12J/d98IoWq0B88Picz7JJO/X2JoRRPBQhiBraQD94R3XtI/A6f7hmKdE32qsP+7xtf652pD1jIuDPNjxDOYx6Lup/C3evmCs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(8936002)(41300700001)(8676002)(478600001)(38100700002)(122000001)(71200400001)(83380400001)(26005)(9686003)(186003)(6506007)(53546011)(7696005)(55016003)(54906003)(110136005)(38070700005)(86362001)(316002)(4326008)(76116006)(66946007)(33656002)(66446008)(66476007)(66556008)(64756008)(5660300002)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W3RAoc4P+ExsFLr794TIfQXSutJPs0OkVJor75twue+Qbft5U0Zn+WlVyiVc?=
 =?us-ascii?Q?hkA7vSc+dlMESWcPFMfYgwp/Kcg44bqIDH210hZswwK7j04QU40zObT0g647?=
 =?us-ascii?Q?A5q/zI5glZwifqEG6nWMFHQlU0tlu5c7mjNLgv835BIzUxjOIzw0bTnKzdLY?=
 =?us-ascii?Q?IXDVXbKePzp4E6wS1A90Kp6xQoNm3t3DJ/nmCDnSePQA6Yf6+gY/QTfh3p4T?=
 =?us-ascii?Q?Lg+e7CsYGwRcchZwz1BsLytkGN9XRVJoxtIg3QvJpYYWL7u6EMLNnQt52Iuy?=
 =?us-ascii?Q?+bGAl3myz6dZv/L3xDSzCJWUyvrzWRTFMWCq9fD+PP4hov5rey+NC1yRxrd6?=
 =?us-ascii?Q?rQHUtwpxWAWUqGNQXKowa2nHcxPnWYh6rqiD2qWIp8SReck9vMhaO129PMS8?=
 =?us-ascii?Q?5XfJ64M2dgoFf4yWBlN5k2ynQ/ymjbKPnqMvKf8PcspoTKliJmJhAGGgw2mW?=
 =?us-ascii?Q?u8Csa0PXb9FdT6ZpDURKrvkNxN2A5sywmzuFR1PPXwyZBFCFgSVgdwKrgmtS?=
 =?us-ascii?Q?XE7af/qSZaeREwKicjujZwqu9AmQnzFbiRuvjYTl0BmmrXvX640YKJhlimDF?=
 =?us-ascii?Q?Xb5gO7W5MrD0vZWgtLTU2ZIlJ4CHSA4LblNDy4+QlWePtNGYIEi24lMdQ740?=
 =?us-ascii?Q?adilQA4bbPJzUHJ3Sm4JOGOlZBFdtu8xFBkxC4aeMm2/xA6DQzo0UFKqSOOh?=
 =?us-ascii?Q?jK8kR/4FjcIF4Vl1jL+blxojzFdQMO5bNCnVYmYBUePn8qxAaXxheQXFHXVa?=
 =?us-ascii?Q?P80S2s/ui7jnz0hBRB2apcXdk11qQlOgrPy0DQuYWHooz8F2nF92qIgHEme6?=
 =?us-ascii?Q?DVM3DvuLVjq0wk5HKMFokGp7vGVhDiagVO6nxq+ZZM4CxQnLr3NflMpiYS1D?=
 =?us-ascii?Q?kP/FGKb3S+hRJa2iTIaNFbmY9lHr5mv/koGfryhd5rETEeg/WEDHQlBLiwia?=
 =?us-ascii?Q?SaF9DfeR8SutdVF1OSfq7P5bofkFmDSTY0mJnwvNkpll6u24rmeH5KIpoNVF?=
 =?us-ascii?Q?yVx2310B7UgvxrRGbksBCH1sMeolGbQXfd10GtDr+22bkU8SIN5X35p5bAXi?=
 =?us-ascii?Q?jkLN/0UvJy/o44kJLIJY6lUaO2Z8RNKSJZG8NReKa32nXGKbC8woI3e8/xNN?=
 =?us-ascii?Q?942tveqL31vhnt01QdwkqIgmenFgq/Mn4RJGsMkGzqs0jzdFJg7T2f3t2F+h?=
 =?us-ascii?Q?4F2gkPvMLZezLza9qc3Ksvhdi1Yx9yK4F0MQBWzmlSmjz36nbiCS1NEnHPTF?=
 =?us-ascii?Q?BSZYxQUj33S5Ca9faBSeJp3oXtGVaLADbuWRghtzTbSYQRIjTKITNmHNCH8M?=
 =?us-ascii?Q?Uuj/V9gOOzq8OZT25Fssh/uzOx07Q2ogEsVfMDu2FfewbNnQnZj3Plnhc06q?=
 =?us-ascii?Q?P1rti5osCbqOiL0WrTyaPeWvLbCqV78yS9pXQxuqz0yfrptwKpieifu8dMOY?=
 =?us-ascii?Q?Bfjw5bta2SeZAUXfui6RXnwSp2638WDseJ6zFyQBryuJyBlsMkbrK1lD2cQq?=
 =?us-ascii?Q?GyUuMPAuaKD32jwkdk7Enb43787BPGmxws8Idym7w2tNWq4pn1NpHN3/JIBd?=
 =?us-ascii?Q?G/VqPev17UPxI7u6oE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6d1113-4c2f-4c89-51c7-08db713b7c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 03:07:30.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcDMcxC/4SX5ZNl3Hj0rom/uC7eNbysQg2Wl3gurPn+8bBT/hNtUuWT0r+jL1ULQpnPX0qTqsb5MioqW2MdfYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
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

 Hi Wyes.

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
> Subject: [PATCH v3 5/5] cpupower: Add turbo-boost support in cpupower
>
> If boost sysfs (/sys/devices/system/cpu/cpufreq/boost) file is present tu=
rbo-
> boost is feature is supported in the hardware. By default this feature sh=
ould be
> enabled. But to disable/enable it write to the sysfs file. Use the same t=
o control
> this feature via cpupower.
>
> To enable:
> cpupower set --turbo-boost 1
>
> To disable:
> cpupower set --turbo-boost 0
>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  tools/power/cpupower/utils/cpupower-set.c    | 22 +++++++++++++++++++-
>  tools/power/cpupower/utils/helpers/helpers.h |  3 +++
>  tools/power/cpupower/utils/helpers/misc.c    | 18 ++++++++++++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/cpupower/utils/cpupower-set.c
> b/tools/power/cpupower/utils/cpupower-set.c
> index c2ba69b7ea54..0677b58374ab 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -20,6 +20,7 @@ static struct option set_opts[] =3D {
>       {"perf-bias", required_argument, NULL, 'b'},
>       {"epp", required_argument, NULL, 'e'},
>       {"amd-pstate-mode", required_argument, NULL, 'm'},
> +     {"turbo-boost", required_argument, NULL, 't'},
>       { },
>  };
>
> @@ -41,10 +42,11 @@ int cmd_set(int argc, char **argv)
>                       int perf_bias:1;
>                       int epp:1;
>                       int mode:1;
> +                     int turbo_boost:1;
>               };
>               int params;
>       } params;
> -     int perf_bias =3D 0;
> +     int perf_bias =3D 0, turbo_boost =3D 1;
>       int ret =3D 0;
>       char epp[30], mode[20];
>
> @@ -94,6 +96,18 @@ int cmd_set(int argc, char **argv)
>                       }
>                       params.mode =3D 1;
>                       break;
> +             case 't':
> +                     if (params.turbo_boost)
> +                             print_wrong_arg_exit();
> +                     turbo_boost =3D atoi(optarg);
> +                     if (turbo_boost < 0 || turbo_boost > 1) {
> +                             printf("--turbo-boost param out of range [0=
-
> 1]\n");
> +                             print_wrong_arg_exit();
> +                     }
> +                     params.turbo_boost =3D 1;
> +                     break;
> +
> +
>               default:
>                       print_wrong_arg_exit();
>               }
> @@ -108,6 +122,12 @@ int cmd_set(int argc, char **argv)
>                       fprintf(stderr, "Error setting mode\n");
>       }
>
> +     if (params.turbo_boost) {
> +             ret =3D cpupower_set_turbo_boost(turbo_boost);
> +             if (ret)
> +                     fprintf(stderr, "Error setting turbo-boost\n");
> +     }
> +
>       /* Default is: set all CPUs */
>       if (bitmask_isallclear(cpus_chosen))
>               bitmask_setall(cpus_chosen);
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h
> b/tools/power/cpupower/utils/helpers/helpers.h
> index d35596631eef..95749b8ee475 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -118,6 +118,7 @@ extern unsigned long long
> msr_intel_get_turbo_ratio(unsigned int cpu);
>
>  extern int cpupower_set_epp(unsigned int cpu, char *epp);  extern int
> cpupower_set_amd_pstate_mode(char *mode);
> +extern int cpupower_set_turbo_boost(int turbo_boost);
>
>  /* Read/Write msr ****************************/
>
> @@ -180,6 +181,8 @@ static inline int cpupower_set_epp(unsigned int cpu,
> char *epp)  { return -1; };  static inline int
> cpupower_set_amd_pstate_mode(char *mode)  { return -1; };
> +static inline int cpupower_set_turbo_boost(int turbo_boost) { return
> +-1; };
>
>  /* Read/Write msr ****************************/
>
> diff --git a/tools/power/cpupower/utils/helpers/misc.c
> b/tools/power/cpupower/utils/helpers/misc.c
> index 075c136a100c..76e461ff4f74 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -124,6 +124,24 @@ int cpupower_set_amd_pstate_mode(char *mode)
>       return 0;
>  }
>
> +int cpupower_set_turbo_boost(int turbo_boost) {
> +     char path[SYSFS_PATH_MAX];
> +     char linebuf[2] =3D {};
> +
> +     snprintf(path, sizeof(path), PATH_TO_CPU "cpufreq/boost");
> +
> +     if (!is_valid_path(path))
> +             return -1;
> +
> +     snprintf(linebuf, sizeof(linebuf), "%d", turbo_boost);
> +
> +     if (cpupower_write_sysfs(path, linebuf, 2) <=3D 0)
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

Thanks for the  new commands for pstate driver

Tested-by: Perry Yuan <Perry.Yuan@amd.com>
