Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDE6E94FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjDTMrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjDTMrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:47:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26D7290;
        Thu, 20 Apr 2023 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1681994813; x=1713530813;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AfHyxydqMUiYTRpLopzWmBZvt8HXuRO7E1HIZNcR+ho=;
  b=Ny9uZa9ZfrxLk6N22O6TcBvuqTsSxAvPXaXd/EMcgyInvbPfLcOde2d8
   ULVUF5tGwxfCCPgeYA0CLUsJgO9ssNghSdWBPuQJIl7A2uFGoQtJWXp0B
   ArmFBQ7nwqVksh0hIu4c4jwVMCjlFiBGoZrd9uA5uNgWMGIf0IfA3xp8Y
   lWN7GqHwAM/zqugz5VCsqBqqdZ8LJn1KAW/1VAdm3XEMBU2B3Fp8bzVac
   sHwoGdC7ey9bCTPW+sykvWZmD1f3HFyRsNcLMSefEltceiP+YT4NeLj9b
   NL/pCAlCR/RS8mWSCcz65UnMfLF8cThYQyc+TNU3RvRZq0RLVCHyE6xoh
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677513600"; 
   d="scan'208";a="227187407"
Received: from mail-dm6nam04lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2023 20:46:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBEnqLTXM7z91jn0BZcyM1OK/T6gTzZC7IOanEFlewDRWwKuYcpvGxw476Vg/of2qPLAC6tVtOJweXZook7Z9RI81CR2C9JCgnbEb+pGGSTClxBxX9qC8SbmmbyA0YAI4YYLohB2X+mS3X78HK4IPFAtKR55K0zZBYv6CENRzwCZ16AwZbQ3dnHMlZRyzBDRzk2Ee8GH8EXiv67YLDzreI/TdXI9GcjFtC0Uh4ddvSgpQ2cJrQVoQYDWtI68rBsZyaigHbTroG42B/5J+8blFcXvqHrDT9D+eYPvyIFneYHgh4l3pW63/1nkSbCJfruRN9db0/RUsbIbEQ0PWf4mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHDiGhZO7MJ6Wn2+tkGNH81W0uuJFV9F2p/5o+m/+4M=;
 b=Mi7f5I7G88B4bF/2TWVXda2zlXVtvV1BpX8nlufnQ7xj7asgbKB2ICQ6sQ9tZPz3WdnJ9OPmx6yKJ51NzZwZhU0B8Ez6ic9NnyvRXGykLtUNKk8byUlzBNBHPT916r9071JqBotSdm7xAZFwot7FcjpMgq8E5/kpRRDx/xdD7gN6fV+G2b19GtF3rEpcAu6KuZbx/A9JpDq2zc8yRJwoO3w5oa72SHikAWbnBFahcYBODRQRuQHKX68GWTj+jWUj9H6aTnHzv8WSF3ZrZS5yXkcffDoQ9Hcja9gmJspziatMfk77uPecfhdhaMA1IjC13gO92ReqobDbDoG6Yq7HAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHDiGhZO7MJ6Wn2+tkGNH81W0uuJFV9F2p/5o+m/+4M=;
 b=pZLR/B7jgfUw/yzpsFR6mZ1ZBoxNgav0sGg5MwzvAutzfXxHem0fAnwPOLrZngqD+rUR5KvCgXQTDafA/An3p6qxErtmNb0JQYcoSD3FjQp+tAaFjOCWaPWlgTHTaNFqOJDwVunp2Jd2kxoWPNbGAeIP0nESQYd43uTnQb7vvao=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7329.namprd04.prod.outlook.com (2603:10b6:303:72::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 12:46:50 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 12:46:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] mmc: block: ioctl: define rpmb reliable flag
Thread-Topic: [PATCH 1/3] mmc: block: ioctl: define rpmb reliable flag
Thread-Index: AdlntW2uE8YL5x37Rg65HliP9l7UwwL0IX/Q
Date:   Thu, 20 Apr 2023 12:46:50 +0000
Message-ID: <DM6PR04MB657590E0F041462A1C24E11EFC639@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <e41fbab65e164b3788818bae83f0061a@hyperstone.com>
In-Reply-To: <e41fbab65e164b3788818bae83f0061a@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7329:EE_
x-ms-office365-filtering-correlation-id: 7a6699f8-9dd6-4a9a-0a87-08db419d4fdf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKmdI6bEuWAnViSQr5zFNim8kDJ3ptZHF2imXVtpg7oMYNfeUo5a4d3LXZOrPEWe6VUS/rEgFUPgVy+9PmNKzCnXUGJ/fgSlFHx8HD/EZjOxQ8wNYcug8mY1L8hEX+Lq3uVvJ8NusMSqyRZTJcH8ntYLqmPPK8zGFe4yhHBVjREMc8BgLt0NYeLPZilq9xNPC9WGFUJq727T6NI7x7XavGp4sPtLtd8r/3yaf3/VIaTVblgScXwF1w8ZTuqJagR/bexAy39fWGx45M8EaFcXwhBwt305pwv+5hdxB/LkLqGYFLZum2a8VlWiAQEJ51UhVZWZnIYcZ1HLa5n33jh/wLsEmgv9c39nD8HZ0vy16A9G2zXnVeHVeDD/FLJ8ZFCEwI6ASB12iTuA85Rl8Dw7vg6UcENJ9n44vi+TPtJjiO/NHMWeg/vBzDv7Qd6FhBOFJIMPUDWt34YVFdPvPMSYn0gtpREgP1kTs9uKTuZCG571ThwFV/BN1O+lzfDVfh+wyHJLJey9bim6B+P12DX+o71fuMcSRMtNrMg+15upRZlFUQiQ/P8Z6hel7M0HRFJ6XXI30AXFK8NYK+qTi8luRzLjQYT4UfGQIo/4jkgRs8YXHiAY5Qo7NlNJn2mTcm+v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(110136005)(86362001)(33656002)(83380400001)(9686003)(6506007)(26005)(478600001)(71200400001)(7696005)(66556008)(66476007)(82960400001)(41300700001)(38070700005)(316002)(38100700002)(122000001)(55016003)(66446008)(76116006)(8676002)(8936002)(66946007)(64756008)(186003)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j4bdOYUhH4MhAR2AgHWsmVVjTqFq9h6LMTdKexcag3tkTZjyOM637aVLp9?=
 =?iso-8859-1?Q?HYxAOR/5MiiRKmLOX6fvLKMiLHK805DeTcBcFzBsOWp2Xve/SRwhjetjn/?=
 =?iso-8859-1?Q?nA46MOF5MVZ4k84SUdttgFoJI9LlQqbuSTbLM48ULoc8UmFvoarC3s0N9a?=
 =?iso-8859-1?Q?11L2ywsO3HW3Q9OMMZvulb43ULGDy7gKoG/AsZT0pjlooTaMrKRKt2XhgU?=
 =?iso-8859-1?Q?cPtA+1Hs18GMhm+vU8kkMCgJWeIkHVqC9TlzjlCkpZ/LNXQ4iYeEV2oxch?=
 =?iso-8859-1?Q?oUi0W/VAsbczCkU1Bwz8e3oFbJ60ZnR9n3AijEl1XCQt6el8yv+0NhQxdX?=
 =?iso-8859-1?Q?dsNBre6SVi/cBzgUk0WnuX11So2FdPSRP9Ps2GyuWPbiJcHZM36ZS73CyZ?=
 =?iso-8859-1?Q?T9QrfdSMfoGyLHKG1QcS9QT+7dQUDXR+7FKi9xa22mFawNm6wKZt/afihe?=
 =?iso-8859-1?Q?cG0vUiuZYBHgGqTSscFYxX7BIW+yyOY8Hep+eD8hI78+Rin+VQUHBSyq3P?=
 =?iso-8859-1?Q?8o6MFZkCD0qth0LP+HeKPT+bsD9y6e26va556gyXmdbt3NQ7jLPKwM0IQ9?=
 =?iso-8859-1?Q?k9Dthtz74lit8LYj4K+dLvL9xZ5+8bzoz2+63+8YwIvPGHHVQdEk7A/rmA?=
 =?iso-8859-1?Q?h1hjdCYZiTF4n0Pnz3r0vWlTTyNif9SGc231A++oV006AlU24KyHZ/JsWN?=
 =?iso-8859-1?Q?Ck6owFIZ9Q4JnvEbspZQk4eLsTtIj84AzY3kaeyL2hQwGoXCl5yBsDU06T?=
 =?iso-8859-1?Q?MsU9yM5kHVbad01owGNEVr/YQ3Lw+rDrI9vKx7fVi5cwJnIr8GQHy6Rxwm?=
 =?iso-8859-1?Q?FPYu7RbfICtJc2jrOjefB0clZ9z729hmoc0ConV/JHcsSLVSfwz8afeNnh?=
 =?iso-8859-1?Q?oCq9THDceaPx6V7yaWonWYRAsWuPa01cpP6Ne3JjYAORa9gvlmwTF0+eMZ?=
 =?iso-8859-1?Q?zMaVRSPSkaIYQHwF050byAe+Ria7irMru5uULa42vsrreNoesil6tQuNRn?=
 =?iso-8859-1?Q?XsiXNTZ4r8TO92YSPftSsM8HTJfuXxOnL4qYM/+MtvAokYYUs0TsazKG6a?=
 =?iso-8859-1?Q?K5mbsqfUJICrRWV328duyMuYt6QPlX8EuPqK3h7N4iTseBfrnHOF9XM8Qt?=
 =?iso-8859-1?Q?gpVU4upYvjG2RyLg2J5o0krRqfzwuPU5XhYlxnS1lzWy5ekKbAetfKGyak?=
 =?iso-8859-1?Q?LRTa4cf4TtKCZkoF7gSSJA5UiaDjqIEZsr8h99frfz6l3TrV/OGFmVBJ0t?=
 =?iso-8859-1?Q?pHsEz80J5M8qFfJ8YE4Xb71dvqJtZUSnEiHR58LsiCLYe0UHHuO4gukQRO?=
 =?iso-8859-1?Q?Ct8Y9nHS9IPJxdEUbeUW6rhMVyyFq79iAsgf/0/GuVDLYIVIgXbqNurE3i?=
 =?iso-8859-1?Q?PFC3FqiTfvS7bnZMAbAK+OJUJUVVVkFUgW3V3kcRa3zjg7Ic3KCZhcuc41?=
 =?iso-8859-1?Q?2shFRev6XRLcrp5+zWaetgmSgsJF17V6rW+PAGzy4fk95N0fxtu0EACfkf?=
 =?iso-8859-1?Q?wRMWthM579BiFAhFAQ2O0L5NWiElk9ZIX1v7fs9uLQKhUWzG/Bqfcp/7Kj?=
 =?iso-8859-1?Q?5t2B71RUhhR0T1VjzVk2ngJvi6V0S+HbCyZ2/TDQpB+barJYqq5Pk7h0d0?=
 =?iso-8859-1?Q?j3pucpqkV925JSeA69BcICFnKeu56Io7sL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f+oix/iGyU66OwU/TJgGiHb++Ethc8xOtVHp2OE+QmZX9m7okN9uFNdxcEHWZyH79gUIpxWAQ53nC7r6LwNxauXxK9YjzzhVZHUDuZwOBapf6mSRxxZ31vvqlXCkfAQvkkpjg4wfpLzhm0NN8VEXScVpGLWwq7d5UBeDCjigfEQDrSwvAOEBevvGwXNOIu1PnRKEFJFTkDMve3xDNc6aTLj5SMOp3Me3pvJSVwFOhkBBVzHbYz8cxVhSj8pCpEAQEBbChgZbFIdqOCQTXM5UrDHZ1mcLDXlz+J/AV9qq3Q89iqqlh5G2bUIPoQHaGne0xd0f0Lj8Xxvhw2x67q2o5Uij1Dv6iwIOi3SVwEEpWGrdKXyKpW7owG0VUQCvgdCq3mwupq5aaWrTlUF4FtaW6PxmhvPYjVtqjjj1dsi6P25fVViYPRM9sWSlo48eQgUjBdRWX69QJjnHJx3Ey52936Op4aeKHyk+Ep/JG9H/Oy0P1MWNS2S8meBDcIn/c3gbrstBtuHJgKjWiMPqn5klTKLBBwsJkGrYn5/gJlKSObgUQqxVYMYkqit3f/JSuWAAslDhWBKbfDcsQ1fOoBvRTT7QdPoy+QPZ+nm/A7gXIvHnS53ridbCVWU2w+9l9lHae8AV/UZHJRZf/XU9b8Wfq6anPqZa1SaMemjhs8ITjgwZDm9w2+6CaCztp3tAH4oVt518dFg8qfn+g2yr73FKC1YjGM3QNIRK/HdeRcWXmiN/soNav7JfcRQOIo+/bhfOMxcxC8/jF9NPg0wYcBDl+IYMyouiS69RftzAvPKi9b5ZSCtXyVGXU+o22Jf6kMWuNOXvriwzr6kKF29ujZ3jXzCSBWnFB9ayIO/1NYoiy4w6e8hSmDyO31i/xDuBdjTA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6699f8-9dd6-4a9a-0a87-08db419d4fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 12:46:50.8396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njOzl8KojfX6ohQrOe7bb3YL74PXpwetkgwTinmZhmHCp2vhIs0juL1VBh5XsJgvT/3bRHVpzJam42kNgTwhGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7329
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> Give a proper name to BIT 31 which is used as reliable write
> for RPMB.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks (see nit below),
Avri

> ---
>  drivers/mmc/core/block.c       | 5 ++++-
>  include/uapi/linux/mmc/ioctl.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672ab90c4b2d..16e262ddc954 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -49,6 +49,8 @@
>=20
>  #include <linux/uaccess.h>
>=20
> +#include <uapi/linux/mmc/ioctl.h>
> +
>  #include "queue.h"
>  #include "block.h"
>  #include "core.h"
> @@ -538,7 +540,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>                  * may be increased by a future standard. We just copy th=
e
>                  * 'Reliable Write' bit here.
>                  */
> -               sbc.arg =3D data.blocks | (idata->ic.write_flag & BIT(31)=
);
> +               sbc.arg =3D data.blocks |
> +                       (idata->ic.write_flag & MMC_RPMB_RELIABLE_WRITE);
>                 sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
>                 mrq.sbc =3D &sbc;
>         }
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioct=
l.h
> index e7401ade6822..b2ff7f5be87b 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -11,6 +11,7 @@ struct mmc_ioc_cmd {
>          * Bit 31 selects 'Reliable Write' for RPMB.
No longer needed.

Thanks,
Avri
>          */
>         int write_flag;
> +#define MMC_RPMB_RELIABLE_WRITE (1 << 31)
>=20
>         /* Application-specific command.  true =3D precede with CMD55 */
>         int is_acmd;
> --
> 2.37.3
>=20
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

