Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A55736207
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFTDJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjFTDJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:09:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204D6173A;
        Mon, 19 Jun 2023 20:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWpntmGECrBp64lj9UbJguzOrc9Dddh2Hy9NbiKP6sykF+zjazoj6ZzKwrXTP8Tw0LTrbx4hKDeFtcWaWjxu7KWcg3hcpQPtQbeXUvnZgdd8wvUrBEkfT7fZF/V2yyG8OmiQmtHRKxqeEVCBPLpN85b5Xzv1LEgSdifs+RFA29UBNrdUJEoND8bQnJ/hVT078tx61joMNXEXCdl1Vn3e4v01dOZIHlXbVcfvhJ/hoIBZkhuPAoW9pIeeYlEDZYYaDyfFG4xTB0jZ3DroPVwY0DKbMFmQm12wGAVni9fQaJ8CAT0f3nETqW3G9smCLcyjdCrysCtNdj8A0FmqtdlLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jl7l6hAilWdYVCNAgsyy2JzZSGhMxmhq0W0PPyNrooI=;
 b=Cf7mYCiGQIRTBqgWCikDxJbwTjgMhP7GkDpcKnoMiDQFb1cNmJI/8CVeuopVeb/Q4cGFIbNxfj2BHOpOFNVQnbhZvu834ZIDIhQ19eGHKHZ2ncKseUBFhwCGtbhzEU9PQ3BwVFbG/DcWgnLAwNz6j9DRwnXUaXxcrI2alAfULa1iOmRtMuSF9bU40QXhCmO/62PmX+SldLsITn9bmItFJY39M46PWV+gMazgJ87WNWmXn7QJZz4hDtTDKFTzlOwzkqjHgxWnKDwA7cBp6Sh01wMhao43sIq1XLvUSVX6jtby9mbnEQ1SBZUzo4fWUkEmWgIdhuYCyx68VMCbsTbC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jl7l6hAilWdYVCNAgsyy2JzZSGhMxmhq0W0PPyNrooI=;
 b=kEkMyXIRJElFCBrE8Bo2LXXcr1cYh8gFpF17L+vX/jIXnp2mzBWm+/ETOyALav99gXO9+qdalSCr7OIXOHfbC/Vf4XG9fmu0boPg/ZG34koVb6paxRJT8m54XhmIz1K8ycII5l4Hv4Imk9qw2EB1mO4fjTBGuUO1KSErlJZQjm0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 03:09:13 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::8d99:5e7c:3ab:a882%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:09:13 +0000
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
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH v3 2/5] cpupower: Add is_valid_path API
Thread-Topic: [PATCH v3 2/5] cpupower: Add is_valid_path API
Thread-Index: AQHZouEcJFuU0HL3W0alk7cv0Tn/Qq+TAHxQ
Date:   Tue, 20 Jun 2023 03:09:13 +0000
Message-ID: <CYYPR12MB8655908AAFC25C45B9757CFB9C5CA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230619190503.4061-1-wyes.karny@amd.com>
 <20230619190503.4061-3-wyes.karny@amd.com>
In-Reply-To: <20230619190503.4061-3-wyes.karny@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=89a9ac86-11e5-4275-a0e1-8ad36c4ec13a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-20T02:58:42Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB5602:EE_
x-ms-office365-filtering-correlation-id: 27c77ca3-9e46-4813-b947-08db713bb98e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnmgtL6BR0wd9DQB39B4Yts12s9PB0QnhjwIs2FYY6FB2e7DoJDsqQFHzp38eXdb3a1wt+qkWdWrRV9KVOLulhiY2reQZVDeAn/pC0bExB1slqV8IiEHuXCeVp+QyZrISY7hewqVZNUTrxzEOvCj1iQk4of7jl5t27qBSPGelfWyjD+4L0ID4sYB6ReZaIoymmsCmiTcqNZ/RxNTZ3vOHx7JBayEotgxz/UN3QN+5w2X1/yR3Fa3gLSvW9Cey8WWJsLzMXbx2eZLozX3nnZVYY5vZiDtDeWdtfnipuZn1EDTfQUfyaxGJ/7yZavIBDUfX8EqTyOMSsT72klmD/CbO4MR95EvJvwT1ParnERlnWaoPiVhlLR9RYXlnubA+lorBXNwHRV7ev39MDpbwPAoQAG+TMsiFW+ycltYhgH9siq47hzBDGG/kH3ttYZ23WBzfIHodhPx5wZw/Y1jI/OTV6JVYYQn5Gw8+Dke8wqPVYYe0UL+qtZfyN+lvMPuFaJz/e8entokXhKhrjidqGxyN811jOyCX5tSymPKrRZrgVe85k1xdjbHXS4tS1C5shmQ3PbnLt1o8AditPYvJpzq7oPGjJ5BJ2vzIPKTpLUigHHMc5QCAHbW0Hopvh/1a6nM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(478600001)(52536014)(5660300002)(4326008)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(2906002)(54906003)(110136005)(41300700001)(316002)(53546011)(7696005)(71200400001)(8676002)(8936002)(6506007)(186003)(26005)(9686003)(83380400001)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hFkp+a0emnAZqmgO3uSiPlSE44X+cskuD3sVvugdmEtY2UxoHx2jNOkXQZE4?=
 =?us-ascii?Q?PboghEqaQWxHRrnu0S0ZO9k6FxAQhBqiLPMRuyNkts49QresMqA7O2KWnJq3?=
 =?us-ascii?Q?mjgxW1DB+zboqcmVc1LOuCoVeMlA2QcEQoKdSA7VGUDhfttqxvWSbSUmKmXe?=
 =?us-ascii?Q?FPCZV+Gfl3QGTI4MLn6QUta4x92EDhoFv0ITkL3VjGBkbj+B01ZeZEEURPAu?=
 =?us-ascii?Q?Uf5DESI8U2Vv6+8RWpfgmmgvkeVr1i4gBIjtecVJoeFMXmJDjXbbM6DKeEwo?=
 =?us-ascii?Q?4PtNg8CRcBl36hHK6cNtNJBzBPbW4q5eOOZY/vL7Di89bngEsSU37VT2qiXi?=
 =?us-ascii?Q?/mAF1SvH+/fScU9a3bMrgVJoMWZeNk5JAfKieiHsOfWgMYxbeOG7AEcHDMMS?=
 =?us-ascii?Q?AbB9f7URiZdz+nWtXjdTibEVRMHbaCBKTSJghLDNFPt/L2ExxSn1AbRLpPZs?=
 =?us-ascii?Q?hrVSTD7xH8UlizA3QgJR04glgIaodZvic4jBiQ97sC0epddqzxjYY8tvZ7Uj?=
 =?us-ascii?Q?HYxt6fdZB5paaE1qJTjhAfnPlRnXUqpwTx1jT4YVj8Jwx1qZuYzdPiJTjCkJ?=
 =?us-ascii?Q?1yj/c2hzAUarHXCble0QgtaXRHqGpeyain2dKqwBTRcaOSG+UcQd0LsYZhVB?=
 =?us-ascii?Q?+V5dl7fnarVmLgVnwV/4qRj+nCqOS4R+mS8ik+UXE/iJv8h7i/Pz6O8LuGFj?=
 =?us-ascii?Q?zw9mZstBPzoMMiTUSuYDc+4m5F9LNlh+6p90ceZx4O+PZ0+00niTrDXBVook?=
 =?us-ascii?Q?GmNntVSaKLx2TtkHKQclR98wGfpGJH8UGNmM3/BOmLAcOn2mWJ8lmzmwWkmX?=
 =?us-ascii?Q?W2ZI3Ctc2Rv35slMYH9JpsO+lBvXxlC05VWgRq3qwAn6Fupy3itGXO/q98r+?=
 =?us-ascii?Q?44+ESFpiKC9NyknBDSyrGThlAtva85lRpRrDMk9SRBkE7r7A8UZs4/PC1Hy1?=
 =?us-ascii?Q?P4a4fRjdLJlzt154TUMTYGrJ5vH0QIhKqOmlflopLGpBLJoTQZFn3gonLxX3?=
 =?us-ascii?Q?TGgx+sUmHAHPNNdlS8mXiyoj0VbJPC0WJ1uukmIR8xB+rD74dxJFdUXaec3l?=
 =?us-ascii?Q?c4GnSchnQA7EqtS6OwbBVD7GzNf7MhStq0JhxyG+hzjTi8NVE5dvTyna2J5l?=
 =?us-ascii?Q?BWHrGYhxmWxltTGhN45Ofm/sI3vsJdPMQMsqoJs19HCOLh+H5ljIxDuekg5p?=
 =?us-ascii?Q?RdIpsHNd+y86FaiEbhRxrdc5IyMODG4b7BOMaMhtkC4p0pd8qB6GmAqnPFhT?=
 =?us-ascii?Q?wRO117pZ3W7PMVGm6jdX5pPCMo9maoHvEdSzxWtuPOIMD0YdtIj3jLUVYnpP?=
 =?us-ascii?Q?FET5rDIc/dorV86w15MXCArVBnmjJZfcxDagokbC5r4PapMgWlfGplDtnjzi?=
 =?us-ascii?Q?0ygaR+jFglNTkTtST+hK3XjmoANz39RlkqxvZX8tosuNRN/xyA9kYuxt8JCa?=
 =?us-ascii?Q?yY+hxP6K67StFJZDBDryxtsAP0/SrPYVR3nGO6UVDix6LxyNW+f/e2kZgyeC?=
 =?us-ascii?Q?lPGxm1e8ypnVhNHr4Ng5nRYue2DJ+fYMtV/Ypi6T7ZzAkdr/NXtWTdeLfWGt?=
 =?us-ascii?Q?VZjSEX4SBRoEnG92sic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c77ca3-9e46-4813-b947-08db713bb98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 03:09:13.2858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onXmp85Wcc7+P4Mm8ilvuVQYYhQwPYNWcdQjVVo9NkQeG1K6PWSTSFbX3ii9BTo5oOAPIzA/AscRQY2h3//YdA==
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
> Subject: [PATCH v3 2/5] cpupower: Add is_valid_path API
>
> Add is_valid_path API to check whether the sysfs file is present or not.
>
> Suggested-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  tools/power/cpupower/lib/cpupower.c        | 7 +++++++
>  tools/power/cpupower/lib/cpupower_intern.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/tools/power/cpupower/lib/cpupower.c
> b/tools/power/cpupower/lib/cpupower.c
> index 3f7d0c0c5067..7a2ef691b20e 100644
> --- a/tools/power/cpupower/lib/cpupower.c
> +++ b/tools/power/cpupower/lib/cpupower.c
> @@ -14,6 +14,13 @@
>  #include "cpupower.h"
>  #include "cpupower_intern.h"
>
> +int is_valid_path(const char *path)
> +{
> +     if (access(path, F_OK) =3D=3D -1)
> +             return 0;
> +     return 1;
> +}
> +
>  unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buf=
len)  {
>       ssize_t numread;
> diff --git a/tools/power/cpupower/lib/cpupower_intern.h
> b/tools/power/cpupower/lib/cpupower_intern.h
> index ac1112b956ec..5fdb8620d41b 100644
> --- a/tools/power/cpupower/lib/cpupower_intern.h
> +++ b/tools/power/cpupower/lib/cpupower_intern.h
> @@ -7,5 +7,6 @@
>
>  #define SYSFS_PATH_MAX 255
>
> +int is_valid_path(const char *path);
>  unsigned int cpupower_read_sysfs(const char *path, char *buf, size_t buf=
len);
> unsigned int cpupower_write_sysfs(const char *path, char *buf, size_t buf=
len);
> --
> 2.34.1

Tested-by: Perry Yuan <Perry.Yuan@amd.com>
