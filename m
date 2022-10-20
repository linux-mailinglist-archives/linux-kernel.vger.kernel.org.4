Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13AC60583B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJTHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJTHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:17:55 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B441633BD;
        Thu, 20 Oct 2022 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666250255; x=1697786255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L409aVqIIjOz5LInAvu2rqLmdoVNh4s+57awghnb2bc=;
  b=lgujDFDQUSJFvM0KYIa9yz1S7P2BMHA/ADr1XUheCLXJpZ+ap/ZKpHKV
   qwL5TnazrWgKybzq6Xkyma1URv6QdrTETWgpn4HY3tDeiIlOmzFv3qGDF
   eab8wWjktu6d9Gmzbryc/soHIVlpmnoRL04iG8MKNqdD6XBlivo5sQuwI
   P0WftHO40sy9YrwT/WPMZxItR/PPtxQ4w5zRKyjIb7i84nioa+r5JsgRs
   5Klm1CbZs3RrI+61LYlnphXPai1PvOwxrlZh+8neD1oSEFL1t3g1dF/OT
   SWqbbPWun0kI/2o7MSMdpqoX8zZ82lryo2w+nOTwiidUR+SsONS1Rg0dr
   A==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="219460970"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 15:16:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpyO3lU01SOGo5r4uo6QNXPHin5FTdH26iHCyy3tPMhwhJp+fM6+3IN8GpHAHO0KdIP7JVGsC1DRPKqfbvfsXj1apPSwrVz3REKHl2wN21KcYDlnUSVECkkb+g6OCiH04jGQ5L80k6BDF2YET/WHK7Js1fne5uPkrqAqRp7IQoYScwVUOUfasQR1DP/ZZCKsxgf5fNDp1EOKKEnmg8y21dhEIUKjqbbJ3tBkdV0uRlB0fHTrsVao4sgiGh1XJ8p2/UY17r0i9v5UPanu0EoDyBkV0KEO6Fu4EdNjh9yPdyOFlqsMcNRClfP520Tg6VTivfGuGgRgAg/l/CSyKbmBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j0yo/4ijYdiVcTky361V/kjkIpL26Okui7wF6sFpn4=;
 b=X8IgUc9X/U4c0cuxuoCQsOhOqAugCpl1W+szNNcFoNsDH7geGMCQ/Zw5Xk3vsgzi8jxoVkCKyRVCeyKIR2Nxz5NolidbUUFQhmNKI3p+Elb7bISoa8+lpKX7UKwefuCLW4n9s8EmZWQfwyMSnXHi/jxhouGINiKGkcayH5QAQ3Uel2TG1nuEreCXvKe1Lp814KIwZRf7KZACYIKXOmwLoc439NZM9u2zZB9gTb7da5iEHpv1yxCWGMBDNyTilL9raqjRx5ZkFKA4ZVH0jGCYjtoPOBpCmrKbwxoBSFQJZsO8PvGdufiIWls697aVSDx8yD/pG8lUww/pdgUt7EqJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j0yo/4ijYdiVcTky361V/kjkIpL26Okui7wF6sFpn4=;
 b=iEC8yzuFdQboZb0WYirxcQNzvvt+LfQXsr9qbRCQ+KCNJWe4NL3tH+gPSCmDevU1NabOuKDQXi2c4gUFBhWHPxwBzOhHugQZaeg6HQZ8O7LVuNKh1Vzu1meM3P/j7gjD6UJqwQehhIzkV/yJkkYVbX6txGtpZ0v1+Spb5j3fAGI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MWHPR0401MB3532.namprd04.prod.outlook.com (2603:10b6:301:7d::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Thu, 20 Oct
 2022 07:16:38 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 07:16:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     zhe wang <zhewang116@gmail.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "zhe.wang1@unisoc.com" <zhe.wang1@unisoc.com>,
        "zhenxiong.lai@unisoc.com" <zhenxiong.lai@unisoc.com>,
        "yuelin.tang@unisoc.com" <yuelin.tang@unisoc.com>
Subject: RE: [PATCH RESEND] scsi: ufs: core: Let delay value after LPM can be
 modified by vendor
Thread-Topic: [PATCH RESEND] scsi: ufs: core: Let delay value after LPM can be
 modified by vendor
Thread-Index: AQHY5CSgadgCAOz5lkmIozXBkwNuYa4W3Jow
Date:   Thu, 20 Oct 2022 07:16:38 +0000
Message-ID: <DM6PR04MB6575A7FE015D8690F5094957FC2A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221020013535.27843-1-zhewang116@gmail.com>
In-Reply-To: <20221020013535.27843-1-zhewang116@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MWHPR0401MB3532:EE_
x-ms-office365-filtering-correlation-id: 6643a909-8592-4179-7541-08dab26b0793
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAKXAW3N8QarulmLSEDw7f4tfv6qafMQ98eEjC5w0bZWAJxfOxb4eurB8bc9kcNLKmOWIUZIEjTMXTW2eIHODi9PnE/h8Jc+ZdQ1+nRPZRAQD2Xjc7p5NPxgX1T5ZWRAXkjIPDqrse6MeLLjlPC12+pKSW+fi7qdfEG8JAkEESrpAWpr9X/QMx1xAb0xzjw4uFDmyM1Llb7AEzRog5ItOgCvg1/o9CsMLwkyfQ64C92hSjzktOhkCP69CZcZOiZmMw83Ogo8GL7l29HzFlPsclbwsfYYXsHCXkuZizpAokZ+jQBg+C8o0UdPJiKoj1prby2C5M+xFYDPcNuremD+L/tEp1BpD+WftyGGD4qJXyH34p/SZmu1CD0sMZcTHlmcgYhgQ2rlMURgdGZsR+9Ise8xDJ7nCA+hP+gXrfh09/By1BORB2vO7Z4vCBpJpnijLt9teO2GDeh+7oqAkzZtkH+zLOwX32eRr23M01ru8Czwzcbj1KirIRLVkGV0DWK85lEvNPCirpeAB2i/vziUqQ/EdpmxIM9izsYKN5tTviQEvIlvtRw+Z1nRhAjmS/4rkDGG8jqa7kIO0z0/UdjsDRq04teKIJQZGO5oJxhj52aWQoaucaepet4gLoWXknfUL29oa/geQS+EI6cuccWczVxZwTKuXtX7Um3l1t9EenmwNBN4lUK9yXI4HjcGLPYW54TR+LDk0vBhmf5GZ1b5/2m73SZJxNnS6kvh4ONBZmuPGryK6p6CjnsV/xhmMVuoMLyVDcJ0+BpgVvoAZSaXeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(66476007)(66946007)(76116006)(64756008)(4326008)(110136005)(8676002)(66556008)(52536014)(54906003)(316002)(8936002)(71200400001)(33656002)(55016003)(122000001)(38070700005)(82960400001)(38100700002)(66446008)(26005)(6506007)(7696005)(478600001)(86362001)(83380400001)(9686003)(186003)(41300700001)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FjfUVCMqn37w1UerpGY7nNvU79mubPLM5pCK5si3wtXZHRe1XLX3T1YlcSI/?=
 =?us-ascii?Q?cYAO+A6zuOAauOc4hJdRid6vvVsV4WlIPnkiFhYDzIdxGiLK65q/h9eAwDBG?=
 =?us-ascii?Q?njrDsUncRnVotepTHrO4z+VVCoTvpYye8L5qlcTvR/vdwSvzzLfVsRrySX4O?=
 =?us-ascii?Q?g6kSQJcpTqpT/j+aAnQNgmev1HH3FwthKCyOw/snRs4SrSiZYNPsE9xdUZPb?=
 =?us-ascii?Q?F3sBS9Ql7tcJolFNJFZJLeyPNJTT+O2bAe7v2RWDrhR8HG0v5lFlrEOVBSrq?=
 =?us-ascii?Q?YUPuCgNjqGLqI8MWd/L0s2QxHVTnNCs//1QwQurGwsUIgn2h9zbbsl0vuWyC?=
 =?us-ascii?Q?1euqMPGDB3AulFGyWye0WoMSTdc8PlQDC+CdVs/p95ew3CrAhUFrfl63hrYP?=
 =?us-ascii?Q?Wv/P0erkaaR8FhvMxrN3XZNNgclJmV+iGN59zR44ndp1Xru/bUaZwuOA0Ltm?=
 =?us-ascii?Q?bsjoqFlKbd1Pji0Zdz047gWDQ1EsckhxcU90J3fXCr88MpFiX6I1q65M/R+N?=
 =?us-ascii?Q?G722FW5DcrjaAVuMQZDrZFf5xjKJs0ahoaqw7fypDNa5jCchAd+cWc0ASVNP?=
 =?us-ascii?Q?ELi3s/s+r6rgulQjJZ/AEukYwtR/GnOrl6quKuDcgPmVOvGYJkss2unmiJP1?=
 =?us-ascii?Q?7ANv1MzXovA8w6bw22SCzvj3nCezgGnkQw8+3Zt7SJEmmt+/jTFt31DyRwkn?=
 =?us-ascii?Q?At9K/uzX/Glmur8Ow3WUXuiyKf2S1pO1NmsNg26r8ua+lXapUY8hN+OjN4LZ?=
 =?us-ascii?Q?DfziT0pshW/NCFRTsynYguWWYAYk3LNuW3HuqE6pU7FVpEDrkJLbpIGB7xpq?=
 =?us-ascii?Q?Xh8MP1d1YFBpgivttQ8NiqCTmW3sB8PKAhJwtNlCvGQDUgjGEv9NBZdatV59?=
 =?us-ascii?Q?ljKivDsULp2rKkum7nu9cVABZcAhpioEFkoHzi73URsovZKvx6L2ebRXCpcq?=
 =?us-ascii?Q?b5tYhJgUk+aoFpVgIIt0E7lXEIsz7FoDQgZQh3mk+h5H3Db0UDP75aHTftfS?=
 =?us-ascii?Q?DVySk83br1io6SoYDyGPkWhhHHiojRXYl/0Gb0Z+0oYNDutVV0WpvV5923ub?=
 =?us-ascii?Q?e9W5BST0WvZtJj42TaP3lPv1Va3UFzOK2talO47b/50aoWecW5/FU1nWyUL8?=
 =?us-ascii?Q?ZubmluyVIy2nHSzE/ZAmcEgqL02qRYol2NGQR/jiJn/qKResD20oZ9bQWZnY?=
 =?us-ascii?Q?5IwJRgpRtMkw1LOhdmP9f5cnSSOPvZShF0lTxl6sCSsvek1u/kk65Opb0mNU?=
 =?us-ascii?Q?La2Zsa0zg5W5+9qbugxtyBo2w2lFMWl/ysubnw7aS7w9iZu4vBmWi2h/T1Q2?=
 =?us-ascii?Q?DQ1uf9fC2vUO/MKGOWviUdWX2cK/JXdeEe8T3B4LXUCYfHxvsn2/J3QjIj86?=
 =?us-ascii?Q?kOtsEGfmbCG4BHGwOGdu29CLf+A24K4EbV47RSElGgep+jF+HSj5pEbc7zBL?=
 =?us-ascii?Q?R+L1ktcK856DeVG0JbsWAhn4UtTHc9j3wMQTua1lcEd1mt/9p7qOeW9nOJ0w?=
 =?us-ascii?Q?nfcG7FD/5J54Y4n5kjXZwg5qpm6DXbdiasUw818zCXI0ZVGBUWarL9vk64ye?=
 =?us-ascii?Q?9iiFmSAIRUAQAsbWhB2r12IT59cXrkFFJh2dajvu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6643a909-8592-4179-7541-08dab26b0793
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 07:16:38.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p02Za5AH8UchSSyrWowSVWWoD3j1CHieNUlHuw8yj0heTtX8F83nO/lWLUiwF/CfvBMSShtqBnhkpBwRKYVMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3532
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Zhe Wang <zhe.wang1@unisoc.com>
>=20
> Some UFS devices require that the VCC should drop below 0.1V after
> turning off, otherwise device may not resume successfully. And
> because the power-off rate is different on different SOC platforms.
> Therefore, we hope that the delay can be modified by vendor to
> adjust the most appropriate delay value.
>=20
> Signed-off-by: Zhe Wang <zhe.wang1@unisoc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 11 +++++++++--
>  include/ufs/ufshcd.h      |  2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7256e6c43ca6..f6350231da0e 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -89,6 +89,9 @@
>  /* Polling time to wait for fDeviceInit */
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>=20
> +/* Default value of turn off VCC rail: 5000us */
> +#define UFS_VCC_TURNOFF_DELAY_US 5000
> +
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)                           \
>         ({                                                              \
>                 int _ret;                                               \
> @@ -7784,6 +7787,9 @@ static int ufs_get_device_desc(struct ufs_hba
> *hba)
>=20
>         ufs_fixup_device_setup(hba);
>=20
> +       if (hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
> !hba->vcc_turnoff_delay)
> +               hba->vcc_turnoff_delay =3D UFS_VCC_TURNOFF_DELAY_US;
Couldn't find where otherwise you are setting this value?
Also, UFS_DEVICE_QUIRK_DELAY_AFTER_LPM is only set for MTK.
Are you planning at some point adding your own host driver?

> +
>         ufshcd_wb_probe(hba, desc_buf);
>=20
>         ufshcd_temp_notif_probe(hba, desc_buf);
> @@ -8917,8 +8923,9 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba
> *hba)
>          * Some UFS devices require delay after VCC power rail is turned-=
off.
>          */
>         if (vcc_off && hba->vreg_info.vcc &&
> -               hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM)
> -               usleep_range(5000, 5100);
> +               hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
> +               hba->vcc_turnoff_delay)
> +               usleep_range(hba->vcc_turnoff_delay, hba->vcc_turnoff_del=
ay +
> 100);
>  }
>=20
>  #ifdef CONFIG_PM
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 9f28349ebcff..bfde3cb962fb 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -828,6 +828,7 @@ struct ufs_hba_monitor {
>   *     device
>   * @complete_put: whether or not to call ufshcd_rpm_put() from inside
>   *     ufshcd_resume_complete()
> + * @vcc_turnoff_delay: VCC turnoff delay value.
>   */
>  struct ufs_hba {
>         void __iomem *mmio_base;
> @@ -975,6 +976,7 @@ struct ufs_hba {
>  #endif
>         u32 luns_avail;
>         bool complete_put;
> +       u32 vcc_turnoff_delay;
Can this be part of struct ufs_vreg instead?
Also maybe vcc_turnoff_delay_us?

Thanks,
Avri
>  };
>=20
>  /* Returns true if clocks can be gated. Otherwise false */
> --
> 2.17.1

