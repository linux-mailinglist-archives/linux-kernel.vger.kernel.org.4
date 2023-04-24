Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938B6ED7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjDXWWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjDXWWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:22:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A018A52;
        Mon, 24 Apr 2023 15:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUPDicNsXzBGdtz+aWj/jgcgIXfTage9I1f91lrW1h1fVjlbiu54tub3yAGgcw6KmHl/ix4XcGDMFvr+7n+0UZoBZk2Jk0TlBF87+CF72b3zaMujuU2cS/5NtsQJByqCrGLzR8gt52or2qwm4uxls6s4dDt8M7S6RWxY3YJYxkV9QWy7H4jz1ndt2gDRloYZ+1cL60y5Ic+Z39m8m9FgOne9FNnWmd4GuJCa2CF5EQu1/pAcNkUNT+jxg2liATv5tzsPH+26169aFbezYqxvcCDXH89RGs9mTJpK0Q6sk+paiH/W4fkCsHjHuc8ljnxV0Ubpz4dNqeJOZ46Kecjijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YCe1Pj30ZeKCZjrRD9vjEMfJaPHvI80z2YJBguI3Xw=;
 b=bOgUSSO81UcBh/5jwBZQztewdmBicBxC2Mf/F2DhPPItK6EuXA7gSfStzNLWJLAwbYjhY4Uzk1Ec4k3RI6QrU2szNYiHnfaV/2AsFDtNRrjyOyRwM+5s2pGIqKtdoT/gq/dIHnh/arP0MLft6rSxBi+Iy5BYvWcrl/vWLdmnruOvAAQ6HgwRmr91dBTXHv+6Py/F8MspdNTO0+BXhqZsAUvHr4sRRecEzDuOwfw8Rhj0zAxqo69nl2uNX915W+7A4K9mGKsAocBPsYQlBey7LI2ONhNqeO+GFokj+eWFehHes6ILBuw7TqHzOZxZC0pEXcJuMCCpzrIw63OL7JQjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YCe1Pj30ZeKCZjrRD9vjEMfJaPHvI80z2YJBguI3Xw=;
 b=pMlnj4DoMyAUiDoxsT9JSWTBAGzQre8douIVHQ6tfJZdBoEmANFKTBkqqrVVJTyMpN88EjUPLi5QOCJ/jk73EtOsUYTv8hCNzXrVv9xpsSPZVYH11fXJtzYYX37HbQMkyGi5h48/wXXfQa353IucucnSJ6Bc5+ZRFI/l2oG3Tb8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Mon, 24 Apr
 2023 22:22:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 22:22:31 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     kernel test robot <lkp@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function calls
Thread-Topic: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function
 calls
Thread-Index: AQHZc6KDV/qdlRinCE2dJSdPDELtT686l3SAgAB21eA=
Date:   Mon, 24 Apr 2023 22:22:31 +0000
Message-ID: <MN0PR12MB6101E25CEADCC5C8F1A0CC57E2679@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230420160923.14127-1-mario.limonciello@amd.com>
 <202304242231.68KXGyif-lkp@intel.com>
In-Reply-To: <202304242231.68KXGyif-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-24T22:22:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7bfcaf11-6e5f-4dd0-a49e-54d949240977;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-24T22:22:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7b29efd6-ca2d-475e-ac47-699362caef99
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ0PR12MB7474:EE_
x-ms-office365-filtering-correlation-id: 911c9e91-4a95-4ed9-698e-08db4512651f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6yRnCtNiBL40la9ZDY4WO/ak4DzaAbqss7PyZb32kGDCpVhefMyPq3zPsW1zr3Tg4PZlZAVCHNslomU79USjG4ZZS0+08I0vunlo+J4hTarsubcWN3WwZdfA2cv+Gk0DusUzybR3xYVG68AwIBKyIpciDmMTgrhQiaTh6DYBB+eUGBhGuO0+4vRHwN6Q4CgzH9h6ALmJ4tILmlT3zuCPHIKo9tmjYbbPTWcu7l7bbxDtDvGiNfQdVlBsAFPAnMwx2HGW0Bp+cM25CNZBlGHAeWKm5MJPpRe1Eibm73GKUIxBhdGBB8ic0ZhOwQsz9iDR1/gD1Lya13Z+kVTqW8cARnCKum2SXLTZnDt9O2U/6Dja3N83XgOXQkX5KvsQSgi31oUIowv2hQ7dRwYx0nTDSAlF3pe04UiKKiHwA7X8LzGlX+Y7wEbvrY/+kVUIgbT59vTHCCMCvxv8YB11DX8N0vgMRlXToVhE7+pshmXG3gtA87EAOHJbZChS50Px1cP9PoejRNSMnOnjGFt28xwJdW2K+HZjO+CcCSyYdLA+7ULf9wbucpmFk3UaMDOb0gVG2pqeO7Y9k8d+aNSpUhz8eKwDpk4ZHbLqhqXrKp1EpmCqZScRrJFkSCJrPzgubqGQ13F0P2t1Rnjsk2M6V6GroA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(47530400004)(451199021)(8676002)(55016003)(19627235002)(316002)(66446008)(76116006)(41300700001)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(64756008)(8936002)(54906003)(52536014)(38100700002)(122000001)(186003)(83380400001)(52230400001)(53546011)(7696005)(71200400001)(5660300002)(45080400002)(9686003)(6506007)(966005)(86362001)(38070700005)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?433unnd23cwQfnRZjFHh0kvNyrLFlbNdJLiPoHpCo7gB+F7dhbptVVAp8EbG?=
 =?us-ascii?Q?ZCVE7N6qD3Tf+ZdWjI7ftkqrID9mv+ZTPHOtce3P3SvJoPQy28Vk03S+nzUv?=
 =?us-ascii?Q?LaHNRdv9wl7wlUZx557kk04iIBtEj6fipfvINHotMEmmR/rk1zqx1n4F/9rL?=
 =?us-ascii?Q?FjpaT9vj3fMzSn3D2eRmOrL3mv0uyAPdbkmRJuAbbmIZkiTeoSwDLsgYvgm4?=
 =?us-ascii?Q?6phtFfEvV934Onk+Xa/gZFmvB72n6zS/o8igiYzC5Bjmfc9v7Bv0EglS1LB1?=
 =?us-ascii?Q?KiHpMjhKkqTKA1kd2fclQSkaK+Oo28mYBNyilWqngOxC9dpA2GbQDKx4hA3T?=
 =?us-ascii?Q?1d6JZQ6q0kIDk8VYVuTN7FBJSxb0pN/D/fhpMSEgPJvH3YdwWUFukNR66i/d?=
 =?us-ascii?Q?VoF7P+0HR+CZqnwQNdr6YL4n8yD+ktLVNuZ8dKQ+5odKF9j08ZMdIRfKTOwo?=
 =?us-ascii?Q?qcI3T1Dmu7PdgoFMMKPGSMw3YWtQs4BtyKU6T0vR2ewRIno1gR1luqbfJBe6?=
 =?us-ascii?Q?G4TmPX0so/SGqN8Z8mGvLSEwRBue65rCH08jP4f8Qtc1k1xrLMA7FtwU7r0q?=
 =?us-ascii?Q?3kPd1z4BwsMqShQCtqy6lY+Yv4U5nUx8ubIUzECrwL02kUFbB2xu42gr73Pk?=
 =?us-ascii?Q?Hm/UWaDE5Dge+11M3MM3MVy+1BtN3NTnfZejUIRvsfzi949ehLIK6iNTIvK0?=
 =?us-ascii?Q?9v79amIfMUseImBrNQ7j80gvkHVNv47tGz/YoQFGh0KmxtdaY4c3lvT3UVed?=
 =?us-ascii?Q?dgAE5TpZgAliqDhpOdkddvYi2ZF/OFmXAOMy1L7jdIVTTQU7ph/xepLxJlse?=
 =?us-ascii?Q?Gzyof6KCkR/K+4sxZLhWne8ZXkYlOIt4t1F6AdoVTM02go2tOZpoa3mw47+0?=
 =?us-ascii?Q?krZTRXusKdNOIY3HGDnCK9hm1cyT07W2vVfzBW8EKZGJZpg8nhjK3zKZmdcD?=
 =?us-ascii?Q?CuZbsSVtXksu5TJULObw7TTLqSBmuPeRoN4H9tSVkWhTditBcKlp8tH0il9K?=
 =?us-ascii?Q?5hicGmwvdndeg0jU1j8wiSyhKiTxde9QflRzZ/9AqLCjq2mJGqmWi9IxlVLN?=
 =?us-ascii?Q?u7g+1VFwKB6SJLeCtHoTO//y8AcbeWEpHkYWux9LiOBWuuAqzSb0lzinj21p?=
 =?us-ascii?Q?DOvZSCEjTpNJ5XItUSrcWaDVN9nZd29D5d2yaxea++mxmVvSa7+asqiiMZx7?=
 =?us-ascii?Q?mGkkyTmTKVlbCrrsH+sTGoa3EypBtRmLsRVT6epzLKgQXGWCCHUZn73ZDnH+?=
 =?us-ascii?Q?Jq+0s+ZOS7HZpHG1xniM1XJPyR+DiA+Q3JAwSkX+tppBHw/C2U6fLxnP44Km?=
 =?us-ascii?Q?MuQoRiZwkBp7aShCfJCQGSJUs8Upak4BjkOwFgPgqEs8ldJdPh2LjClzfrwQ?=
 =?us-ascii?Q?dSt/vsgYAzSMRfm5UYZDoIqF28nyPlGOv73z3rWp24gRjFHIbHPECNnK9Lvt?=
 =?us-ascii?Q?vejR8Qnd5/8KByGcdMIvXr4q6zet60xoVdK030EKnKPAOpG9lzCy4ZaYrUJe?=
 =?us-ascii?Q?L1IfnxXx6nLrCPux+c+Jd4k93YppGz15TXgAZUZOeEEtGmu2Fx1cfhz9rDwF?=
 =?us-ascii?Q?Hjase2y0QmFuAcXaVdCWf9AR/jmsjk/7sK0axQ1s0VieS0iw6+o4d5dhpUyy?=
 =?us-ascii?Q?BZgyQJsgIbzU7Qi2letXB9c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911c9e91-4a95-4ed9-698e-08db4512651f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 22:22:31.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyP119m2H6a2VSmG/2D7XM+o2Tut+9cIZinoQQoPUKY0gxeMllqv/0tMyZWbXVlkfLssTa5QqgztSxy82pdNDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Monday, April 24, 2023 10:14
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; rafael@kernel.org;
> linux-kernel@vger.kernel.org
> Cc: oe-kbuild-all@lists.linux.dev; linux-pm@vger.kernel.org; S-k, Shyam-s=
undar
> <Shyam-sundar.S-k@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Len Brown <lenb@kernel.org>; linux-
> acpi@vger.kernel.org
> Subject: Re: [PATCH] ACPI: x86: Separate out the Microsoft _DSM function =
calls
>=20
> Hi Mario,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 7124d7671af0facf115d70f9d1fadde0d768d325]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/=
ACPI-
> x86-Separate-out-the-Microsoft-_DSM-function-calls/20230421-001547
> base:   7124d7671af0facf115d70f9d1fadde0d768d325
> patch link:    https://lore.kernel.org/r/20230420160923.14127-1-
> mario.limonciello%40amd.com
> patch subject: [PATCH] ACPI: x86: Separate out the Microsoft _DSM functio=
n
> calls
> config: i386-randconfig-s003 (https://download.01.org/0day-
> ci/archive/20230424/202304242231.68KXGyif-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://github.com/intel-lab-
> lkp/linux/commit/e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Mario-Limonciello/ACPI-x86-Separ=
ate-out-
> the-Microsoft-_DSM-function-calls/20230421-001547
>         git checkout e4ea0d2f15f2d0486bc3b4f59cbf9cea6c63fda1
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=
=3Dbuild_dir
> ARCH=3Di386 olddefconfig
>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=
=3Dbuild_dir
> ARCH=3Di386 SHELL=3D/bin/bash drivers/acpi/
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304242231.68KXGyif-
> lkp@intel.com/
>=20
> sparse warnings: (new ones prefixed by >>)
>    drivers/acpi/x86/s2idle.c:479:13: sparse: sparse: restricted suspend_s=
tate_t
> degrades to integer
>    drivers/acpi/x86/s2idle.c:479:33: sparse: sparse: restricted suspend_s=
tate_t
> degrades to integer
> >> drivers/acpi/x86/s2idle.c:552:6: sparse: sparse: symbol 'lps0_s2idle_w=
ake'
> was not declared. Should it be static?
>=20

Besides the problem caught by the robot I was looking at a BIOS debug log f=
or Windows
recently and noticed the events come in a different order.

I re-reviewed the Microsoft spec and it makes it clear we've been doing it =
wrong in Linux too.

On the way down it should be
3->7->5
On the way back up it should be:
6->8->4

I need to redo all of my testing with this new assumption before I'm confid=
ent on such a change.
I'll include an assertion of confidence from that testing to help decide if=
 this should actually wait
for 6.5.
