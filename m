Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE3D71762F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjEaFaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjEaFaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:30:18 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D8EE;
        Tue, 30 May 2023 22:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685511017; x=1717047017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FedinG0eTcGUoxUZDJZwGwIc//26JaSCMQqyygaxVAE=;
  b=hXT4+nEbxFTcZmCCYhMgmrID9uNv/dxDPo6rTy4zLTp/54UvmLb/kB94
   UxhsMAIZb4CYCimXJ2mTFoakACcYN4Gdp8Jg0zNYMFKKNxan6NSb2uEMF
   4NcyLxcZ++DSljBch6mziOJkR8So3rlFD3io4dGsDyCw0pjzWAh0sMJ8m
   3R+8OG1o2HTrjUu3uUr/OWKdx6YufQdG7nQwVDQQbzFmiL3gxBVTPn/q8
   feR99UI3PKdnM261xD3wFXGO43VDl3gHQLcrPzLZDna3xZs2BjZWQ98MX
   fUusvXdi3b7CiQbr8s8O4gJK4vUIY7SXTxd3JI9TY44iL+fehIxxGBlc/
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681142400"; 
   d="scan'208";a="230183336"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 13:30:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDisboJ/14eRQlrO3r5/f5mlJVOIzdKuizoN3lT4F5BRqTOFIK/57eYa3tSVDNTWSpTfvYvB6zvsBYQVLnX1ybFuMcEAnwRr/QFBfBBFZY5gsejB4Yy+VYB377vlGY7BhLs5xmkhWcOUWwlbfma1oBKC24m8mAYssVnFui/lG6ntVqv6LWVEJVgdbwd121iMYgB4V3avTxJE/jv6CZcRuwM0aOlTQlUVc7IXYFVNcS3H3KLswiFov46B151i92dEFOFrfCKRW+KtpjezJNhtrAM0euG9UVolVuyh3StW0INareQkyEwP6lgEZuQNt7NcHm/LIRj8vn8z95m7G9bmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q80Z80zICcN8AIfd3cUw0BBtvS3mhJ0DMf7z+LrDdzc=;
 b=KZUZGfNIiRVWquFgtebFbPTqCkvtcOh1oxbJG01yLl7m3ZOtqy9LSGtm/U2mwwr+jbBAj5wTXfZ4HhJuicW4WDIJlcNoCBvljFTXi+cOsefHSg71PjbLQEU7bHTCUX8LB9QOrxQZcKjjCEOPPck/uLAbiqyGTTS7AWjM4tahm/6LV7ddsRzah+vpY9tOKcPwCSRhsJcykNkrTMvPDZq9vA5BBcm/Au4ZTssJpnP1r/X2FCMEWjSlilHkD68HyzdkYIK8KqnF9ommmgnhrMtCm8idj1o6BWkJoFSpF9aewbspWt6EJJcloPJCMqTpGG4Ap1m6zdsfcjllDRSq/o+bVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q80Z80zICcN8AIfd3cUw0BBtvS3mhJ0DMf7z+LrDdzc=;
 b=pULW7Uwpr9axTsbupjZTfrcwLRR7l0ZqfBDDAuMW2ruG2EhFaX6noQ31ABPHiqYNCcLwVcmAM8VUzguIMgMEam6MRsv0RH+qe/shuAptGPb/0WP4awWQXTW1yDkPqcUX7HlltZR6lJQyIC0RZ068p139+8V9JKw9HrdbAK3vyhc=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by PH0PR04MB7654.namprd04.prod.outlook.com (2603:10b6:510:59::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 05:30:13 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::dc4e:29e0:7689:e1ce]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::dc4e:29e0:7689:e1ce%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 05:30:13 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Robert Marko <robimarko@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "windhl@126.com" <windhl@126.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: RE: [PATCH] mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
Thread-Topic: [PATCH] mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
Thread-Index: AQHZkz5U0a7Ihk4C+0u28HyQz3jNIK9z2y2Q
Date:   Wed, 31 May 2023 05:30:12 +0000
Message-ID: <BL0PR04MB6564BC43385D546E4F488542FC489@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20230530213259.1776512-1-robimarko@gmail.com>
In-Reply-To: <20230530213259.1776512-1-robimarko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|PH0PR04MB7654:EE_
x-ms-office365-filtering-correlation-id: 679698bb-4861-4d07-2ba2-08db61981b75
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSzaC2Msk5MUakUCMxvsELungl8dvLLMb/Z3AHY9KoZEwpvwY9zBxvvemoCqi973a3t/q4RgH7OPmnfd+TUg9+WpfhVs+otvbWix/EUZH3rgPSTm9mn36eVAzR33WOuV9DSv1OwGVWB4wUQzTv0oa4wWcXptP28QtwB32tguiRdtbrQCUWco92/RB9SV1/VhehF4qz2wagYvP8LzOjpiSShonxL7xKXMFVnWZCXLIHUXV2fKly6zCqH7BdPNtYUmuF/uLwfT3Kkwxd9J/Rb1cgi6P4biLPZqxuU/dJFPdTHEraAzzYFYd7pL3ttmfpjoq+PokET2zT+y31qwpoJcHw0TPytvp+34iDt6ZGZDA2ZvVp2QsjdQa7lIWVGBdF6/7ViqDDOnyf/YDC5BUJXE1eNGXiMtRhdSQoTn1rxVY/7bIxkGllQMbIloqRg4+NjEXvPFZxaXu2L3SeOaWVBZzXFxGkuPE6fnBocTR76/bQaP/AUXJU0s2jPQxYJH3fnlAjo39P3aIFJS/GEjjgXNCpMPJtQMc6x+aCJTwu1NjFWLwqGzu6RS4mi9QHYipirrxwcrRpwRQ609pPIQEV2ABKTY+8CxtQDy97dDu1co88z/JwCtF0fM/t+M8ikFT5iYLtqxhVE4L1eR0e4suz6KYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(33656002)(86362001)(66446008)(110136005)(478600001)(7696005)(4326008)(316002)(38070700005)(64756008)(76116006)(66946007)(66556008)(66476007)(71200400001)(5660300002)(55016003)(8676002)(8936002)(2906002)(52536014)(82960400001)(41300700001)(38100700002)(122000001)(26005)(186003)(9686003)(6506007)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6cE38r+qjsGoDuXlrBKXbgHDlawJLb2Ezk2oFUDWgHfZQHWl/JPPWwWpY7Ei?=
 =?us-ascii?Q?HO8L/ij/e+V4vsfvlux3YHqFTyGIoI4sT8+WBiWKuxYd3IU7M3yHPISPBc3y?=
 =?us-ascii?Q?96MDlwMACi9tFuOLJU4hncEP9LrptkbYyjKmN5hc2eW6kWFaWuvoH4DhFYzG?=
 =?us-ascii?Q?sy/gO24qr6LJgRNLsbS2sv8liKZpzFBk3B9L0CKVP6t836qqvQ+CeiGQuIAl?=
 =?us-ascii?Q?NZsYNNSnW3ciO+7SWpg9dU2Th/RpSf9Glg+aRscs8YuSfdn6Rop2qrugrMnn?=
 =?us-ascii?Q?zH7Q9Tr2DJPJBKtA2e7TznxBb0ZHbAiWeNtuwDjDdH1tULy7pDDvqmUw4S+e?=
 =?us-ascii?Q?ILk4GP4tttBWnrcnqj49yVawk6ucnnFClL37gPUFF8P7rqISipLKi637hKtu?=
 =?us-ascii?Q?VeyB+uRexiWNgXktipXIqt4cb1G3FGvdYf5GoSQlAJzMCJF5OlhbWofSw2pQ?=
 =?us-ascii?Q?zcNQEXEgDwLGYVXoAJOIMmQu28tsS3dDzsimbCfofxblJGvjW2VN8GcmA6zf?=
 =?us-ascii?Q?0/iCqfOPFw4t+tYBjfReiX/Vq09gzm0WpMNUixw7/WF6ZN8g19zfRNWNnLP/?=
 =?us-ascii?Q?Eel/UWT2eraabqvPEmZ1CWbRkXbezMU+sJ2Ffyrn1vbVyRsXqd2Nhy9hEJEC?=
 =?us-ascii?Q?BhInTyk9MBvgkxBUQyiaeFKq6RSG1GaYgIkmWgYZgFL0XfpoZu5MI5rrp4tn?=
 =?us-ascii?Q?1u/ZTs9bvU5tSQ+LJXfeeq9tq20NwCcpU4APVUvNbJh9piAsNsZTZ2L6MoJX?=
 =?us-ascii?Q?4BEcne0AwkXFZXAnzj9litRgpyabU0gB4W+Uc7gOnrGyoBtf/ksRz/QYmaGI?=
 =?us-ascii?Q?Gn9k2iD6klhavIhogB6u2UU7cAM5RN+4E3O5w/ZsRArYM8iaAIY6OnaZCXBm?=
 =?us-ascii?Q?qAvC8nhcvwWWpGJqsT6TwuCGpzLGrqeV8f9pxsuohtU7bAPvJgHY8+7RnUEK?=
 =?us-ascii?Q?sHcFfmrABkdRs5ll+rkqnpvVlFT3bJDzxinBQEM/PIPYIbIXEwu+PsVCKxi9?=
 =?us-ascii?Q?qQYwye+QJSJ0HCCqd4mGGPvmPILdDzOlVM3I4ifg3m9TAL3xKmsWS0GI2oxy?=
 =?us-ascii?Q?mUV5wWI8s4M1tFUjCu3mXGMq7AwcB5Dc8cdyKZcDtNYQAfeo59P3+Z+U7dvf?=
 =?us-ascii?Q?TQPgaMfrgIN3ivFVervWss8uScqUyXH56erE8d5vSNVrJ4lUyJVyU1ONbSXq?=
 =?us-ascii?Q?FZjL/BZYAvzuq6deHQvDIQ//Jdul9k3LDDsyrpgziXj0/gvHHu1rjnl4K3Ek?=
 =?us-ascii?Q?FBjRamyArmRxhD5x8B9gicLyD3ybWrVffDGVEfzvkJgJn5pmX9+3BSDd30dD?=
 =?us-ascii?Q?DWq1ei4CD5Lu7jG1iHO3L5wTnw7hjg51Fni0W7pYHJuKpW18mxLUOCQXsOTB?=
 =?us-ascii?Q?QfZl6zRxvieI6SYtIJV1Ig3zj1lm7rNtW1pb58LfHQBsptZR7n6tCLuXCQUj?=
 =?us-ascii?Q?7tCD5v5C8uTFegPBvGa7PKyJE/vol8s12d9J+5vXOFdEkNTIpjarrpquDDlv?=
 =?us-ascii?Q?4dO8pzFy2v/ulF/dulOphDUSd5ugwqVVIFgGCrEN5ItSYJhFN5j5iJShO4lc?=
 =?us-ascii?Q?BuG0xLA+G3I0+FS0U6glGFR5HQopLzwBcoS2Foj1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vkyveeJdDlyEQuzokaaOg0FX8pzOuUSkT+DAVkZEmFxFQLoXyCsyVEcVZHYhFOAUdm33In6FztURXOlwv8h85hQelzBakVTcYMRfx/Esyo+NXKvuMG3Np+hY4RQjtnkMTQWsO8+OobMApw9gEPBvCZobs7G9IrATt2nSJSX+Ko9su3g/hTYP5+kJ878Eiy667aTd5GGCK6igMK6hTTsd0l61GrhbQNtOBJ9KsG2EgUogVPTXEUSNfEG+HYyoASD17CYfraAsHI/agJ77nKUnB9M2yY9b7SmLL0g07BZT5GGQfRJSmnNfYfycHsZ9pnlw/xy8mN6FmhCziCxZrrrCbiom0tZH6kAgCfr3oYWXHXhfwnATJO5lmCsqjlk6Uybyhh3Bj7JryB091mMq+aH9GpLP3Nz46gteAhoLR3ZrRPaeUn/4keo0qOENvWuUWyYV/yjuOAYW3zb+Cw7P349mpJK1etdRrpNs8QFWVQrv7pfiapyFibxYo756zJ3gpzOS8d+VMxE5kFoD1re1Dr3P/+JG71IBgyaDQEumnQ4pFdql3wHTaPsz3mYxXqPoDgLeXJxkpkoB0WDEITsB4pMffwVV3/HK7UxWTgH++hRTLHsINI2WJoRNLJ05WvVCdgundCeQx4K6hljyGrsOtoIsN0nEQ3x73Pr0MM5Q3Bzn2NHCfyKRBl8CRjv+T8MetxojTWwrxcPrjVP89tpNIc/BUn40ITkL1/9dPPNnqBY4hJ1rrs9wgu/oS1IoP88cR8omVw1lx6//HY/G0ploQ3TafapFth07b/bM3yyezFNV0lBaTa2Jh/JzL0Np1oHqfJkMhLautBHrFI6C5rxvmIdPK9JmRnB+b8laTCSEaNkEJ6twFBYr7cRoN4TlgxDv7Pzb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679698bb-4861-4d07-2ba2-08db61981b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 05:30:12.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoX9dOOE6vcZyHERfpv1VZpuBB6byd99DHbOIQOSwsTNN/mEMZ+H0kD+tqWfMLsLaIKHXuGRPs7Km8MKdhCmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7654
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Bean

Thanks,
Avri

> It seems that Micron MTFC4GACAJCN-1M despite advertising TRIM support
> does not work when the core is trying to use REQ_OP_WRITE_ZEROES.
>=20
> We are seeing the following errors in OpenWrt under 6.1 on Qnap Qhora
> 301W that we did not previously have and tracked it down to
> REQ_OP_WRITE_ZEROES:
> [   18.085950] I/O error, dev loop0, sector 596 op 0x9:(WRITE_ZEROES) fla=
gs
> 0x800 phys_seg 0 prio class 2
>=20
> Disabling TRIM makes the error go away, so lets add a quirk for this eMMC=
 to
> disable TRIM.
>=20
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/mmc/core/quirks.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h index
> 29b9497936df..77caa0c903f8 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -100,6 +100,13 @@ static const struct mmc_fixup __maybe_unused
> mmc_blk_fixups[] =3D {
>         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY,
> add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>=20
> +       /*
> +        * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems t=
o
> +        * support being used to offload WRITE_ZEROES.
> +        */
> +       MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> +                 MMC_QUIRK_TRIM_BROKEN),
> +
>         /*
>          * Some SD cards reports discard support while they don't
>          */
> --
> 2.40.1

