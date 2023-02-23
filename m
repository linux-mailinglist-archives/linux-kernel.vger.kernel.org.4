Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591D36A0332
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjBWHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBWHKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:10:04 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DFE20D32;
        Wed, 22 Feb 2023 23:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUs9chhs89nLiOSeipVpCazJWgd0iyobrFXrdH7MZOIwZam5Y+2UW/bmyn1q3/WTeZXRjRrh8cX2vmW4x6vsxuiuFF3ueIrQct2Ih3ttAZkKQGBc2+4QJO3DiBNBlH7g92G4udRDmehc10jBKYygyhRAr2heh/dZ7tPjY0QKgYNrp6WuNXk5Q6Juwe8wzluihzOp8QhWN/AacNmoM3odHcYz4iio/Bvwv8qeerMjQCx5F1PySXX4PEtBaNiRaFGSEC60kZ5vxIseVQZ6FE2CAx42YeBOVg2d7Bpe05JGb3/vjZCYuF68Z337HJawhWrtpKDzxIPHfVAUA9r/Y1c9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TtZxxq+zd0GBXY9jeF3E5yoj8SvoyP/gC6PptZeg+c=;
 b=ZoJFS836Np+lFMAy/DZneoLa+S88II5ggwjpIH8VPoS3zbJ1Y3/bxx5NhQhMxFvv4du4xBAR2f+ypVY55pq97u51jS76t6BXWYsrHj5d+Hh80PaUbcgqzHpLj3l2qKdWbRSDNe6bO9jy1sV8WVfoIaAmxdtMentpYwimsoogj5OhcW0aDniKHqIeBAtmA8mjkNmddHvm1WUatPQY8HSd2HKK7BHGHKXzooEn67EBOfmeOy4jEe0GIK8AkTjshMX3riAbzi6YYdt5PlRqnkOvbBuuRNbsjKHZaEIUhmGeUNeH3AQsriLrd1ntJ4PDIcTG3v6JmN5+zWeaxVO9Uoph9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TtZxxq+zd0GBXY9jeF3E5yoj8SvoyP/gC6PptZeg+c=;
 b=EMwrFOR3WKWaNcMrIsCYbhjCKmLtn9CXkrGHWkD+1HjPUW5gwwGCMU7hihrJ0AfacyehvlYNcBHUhhZvV80m5JezYn+9Sy7XZ5UHydfdChCBU1+9USKpdHk0ACLe1RJu9TX7Lus7W1RL6DtPjJFiw5/OCqJ3UnC/b5bCsXGzzP0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 07:10:00 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::21db:f27a:291b:c35d]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::21db:f27a:291b:c35d%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 07:10:00 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is
 disabled
Thread-Topic: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is
 disabled
Thread-Index: AQHZR1UVixwoC/iNGkSQ6E9mO/3C167cHFeg
Date:   Thu, 23 Feb 2023 07:10:00 +0000
Message-ID: <DM4PR12MB527834BFE80456BF1F3907559CAB9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-23T07:09:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fcaeb415-6637-4e51-896e-271bef3f8e93;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-23T07:09:57Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d4af6f84-8e80-4b0a-b46e-68f9267c996f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA0PR12MB7532:EE_
x-ms-office365-filtering-correlation-id: c0ae1195-38ce-4084-a838-08db156cfa56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SW5OKLHKUEgwhQpbiedMSVc5GRPzAC9H49/n3x5DicKPCFcZR9ZilfxxIv//ZJczlWiwRGuLrnWglbREpVjtkh9BX47P19OEHkXxUS4c50Iv4JmE0Qxjq4WgAYgpyI2DOghcnwBhwtWIUvwno1HlPVd/XDaR9ERwrrCDhlxpPvIflZQq5AYzvsjGFq9Y09oOLwbB2gnRXjoS+0ep4bxNmWgoxS2bmhJjfQqJjeytmaTtyWZN7H15H2X6Ez6U0eBB1wm0TWROrK5lq9ItiFI9q7CFaLQPX3ugR63hmo4sFAzszh5wOAXrXkTO61AkaKhnBZVwAL1MvU/Wf/b7SGs2Jm7AGZxcfTBqJKYNVb44sbZuBv3CV42X02xHknhq7b8wmXoMsaDe1Ib1AXnYNoAXVAoUP2+ZjQj2rQ0mRFye+AmcZhs02Cj0sNIBkXK9N87rnJPtKQN5zJQjW9Wiur1biqUHX/d+sL9qzK04TwShYRC7CBRfDfLhqzpLB+rR0h8yeFCoH88IxcNeqLTSYzZoM0iDmO29f1xKspy4SFiDmx+8XUi4QJPAW4ZJxlL4mPHXWdHP3fXbpxNovWXWcUNy7rag/alQK1w4gTfQWSVJY8gTfK+pIiArfusp30FNJsLShiZbWhX50yLi1ZZvXufz8jiW0i7mcvwYf5CnU4SyxZKxFuzBk42FLWpoXnDkMVnm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199018)(110136005)(83380400001)(71200400001)(2906002)(5660300002)(9686003)(6636002)(41300700001)(478600001)(966005)(86362001)(52536014)(8936002)(7696005)(33656002)(55016003)(53546011)(122000001)(38100700002)(26005)(186003)(38070700005)(54906003)(6506007)(66946007)(64756008)(66476007)(316002)(66446008)(8676002)(66556008)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bjQVn5Yqdb2IEOR8fXFha0DoBq4ljribe7qdQEnpqbqMMLy6zZkjXbBWNwbr?=
 =?us-ascii?Q?upDU2D+CKrGRNuI/NxGSN7ncTi78EdRmORr9XWNzbenVUKRNwW4vE8g4G12x?=
 =?us-ascii?Q?IvTvvFgSPcLttvHnx1kPcF6GP+bxOnVOhgmzkoDY2X+OKQOyfoYAgQSGkxRC?=
 =?us-ascii?Q?nebniBhpGjq0xcm5vzaZTjJZP77d8oD3YgALJwajtotdiN0hdPeLSay8uuEx?=
 =?us-ascii?Q?zpcpEzQpLu9YVLwz033QRQvQ7uuFja3WBQjzFeS+L/i5oI8rThIHxzcvfv00?=
 =?us-ascii?Q?swKsl+V/YXyEck32XGCaBG8hdGPbEBQEI/R5ZzvzhgaVj9x2tRMuoQiG51ou?=
 =?us-ascii?Q?zOcXU5qIYq+goakQ37ypkWNMybhmmY8GRdNQPO299J6Mp1HAdjlbByEokr0z?=
 =?us-ascii?Q?7IYPFs6HvBiP6apLMaZ3xu8dJmC0cEUkRFvU2PvuFShxrmmST/+efj5WSeDc?=
 =?us-ascii?Q?xT0K58PybTYBfvIkzdumLSNYYrpr/A3mWB0SZizV9VW9I4TvA4pX51yF0sYR?=
 =?us-ascii?Q?8+Vwo8WwP/X5FgN3Dxss7WgZ5bG47bQQ4njRSvQ+LlPNHrXGKWzLFit8KD+x?=
 =?us-ascii?Q?PX/51P1NVOevlFaDBsYl806Va1LtWTnyRCNfiBUgCHvv2/EQkUPwKwjL8GS6?=
 =?us-ascii?Q?mdviMURqj9L7SH7I0S1iyVdXhkSvzRS+1fv3Qj2zJZAWQFzQK924FUtnbANN?=
 =?us-ascii?Q?3G8g+O53TaMxA9Bl6QjRfVLrn/1pp/iBIwkfU6iZZCRng376mGbKuJ6eQN02?=
 =?us-ascii?Q?rZvW2y0uf+PJRQXktDlXk7LPQh+Y1gwmgL+UNwUUbwCIfm/6/AAamTA11Yqh?=
 =?us-ascii?Q?OObMw7CiG91sbqQaaUg0yCb5kh4NQL3loMiewnE6BQcfrcO8C6jxLbLMfXN2?=
 =?us-ascii?Q?uCMosuJLQH7GWBo1YW92Rz/4z97PO4GlQU/qWercbU5sDGp2gWu6VizZ0m8u?=
 =?us-ascii?Q?GC+dHsyrpxyeZ6NU11/R0WmW5Obwr6GD6VSFNoTv+nR0XaDaeLxfLFv4tmvV?=
 =?us-ascii?Q?00amHKzWdLGgCphWvcgtUFibDamBMbtxPmOFVVDtkO9UkCIdFmrRYvoe7m9s?=
 =?us-ascii?Q?6zNyqpMAAgBRkjyRyOGZGnbgfLuYOMPRMAohTNFwpA9MhuiK5vyt4qiq0/Xk?=
 =?us-ascii?Q?DNh6rnBKRBAdOb6xXz2qLhZ9HBeq5ICA457dkuBsQj23BJkMGKI8ihafbZf4?=
 =?us-ascii?Q?Bs+qP3vYybtC/ix08cbMSt9plOvp9vWchGMSmOoC9ST54F7L3LOc+o03S1uy?=
 =?us-ascii?Q?gkteQtTUiM7apn2Hp47ZCda1OYtNseQTSRFP7WEa0M/KMNLNeRj3GNC2uglB?=
 =?us-ascii?Q?ViM4OIymoZG/r4zkR+LqgSCbEuU0cH+44tJuCE0nP69rWkNCde0+M+xQr1Zp?=
 =?us-ascii?Q?98bNGEMxdqLLbEjazUh1aiLwJkilynGOWO82pKhIaewc8B0vusCiQ4DV8IIY?=
 =?us-ascii?Q?S2sVjM0YuWHQMxKruR1asPY/0I/SryXjZmwvj9vl6+AkZkGt4A2qI7eawuwE?=
 =?us-ascii?Q?i3g2cXjVyANoXEHEoaJTENbWdzpwf7W30i4wDxIq141MK2geK3FYb/+ohx8e?=
 =?us-ascii?Q?EysouNl58baTdOwnrJ31ObhdIcYhCrEmkzsNb3sQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ae1195-38ce-4084-a838-08db156cfa56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 07:10:00.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0b3SEGh/OZhTNuiaCFtM53VxoTs88Z4KawrIPHFFJHmyUqV0DFX868BmUWCP2r8xKQo7ZufzI6d8emqUFMUnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]


> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Thursday, February 23, 2023 3:03 PM
> To: Huang, Ray <Ray.Huang@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; Rafael J. Wysocki <rafael@kernel.org>; Vir=
esh
> Kumar <viresh.kumar@linaro.org>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is disa=
bled
>=20
> Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver paramete=
r
> for mode selection") changed the driver to be disabled by default, and th=
is can
> surprise users.
>=20
> Let users know what happened so they can decide what to do next.
>=20
> Link: https://bugs.launchpad.net/bugs/2006942
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Remove redundancy in pr_info().
>  - Fix spelling and URL tag.
>=20
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c =
index
> 45c88894fd8e..f965f54f7ae7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
>  	 * with amd_pstate=3Dpassive or other modes in kernel command line
>  	 */
>  	if (cppc_state =3D=3D AMD_PSTATE_DISABLE) {
> -		pr_debug("driver load is disabled, boot with specific mode to
> enable this\n");
> +		pr_info("driver load is disabled, boot with specific mode to
> enable
> +this\n");
>  		return -ENODEV;
>  	}
>=20
> --
> 2.34.1
Thanks for the change.=20

Reviewed-by : Yuan Perry <Perry.Yuan@amd.com>
=20
