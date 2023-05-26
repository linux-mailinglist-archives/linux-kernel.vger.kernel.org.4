Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B0712DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjEZTni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242168AbjEZTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:43:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31976B6;
        Fri, 26 May 2023 12:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJSYOOnVslcrCsIkazG4j4yLAJH+iARZEUzUfANklYaYR/+El5t3lpSum9ib+gfBJKB2H972aAE1hrECBpwSXg0L1gwgOybsokcU/68yiLivkkLBf7n1LM7Duv48qy3kkS3X7riaDvS14VQogiA8Vsa9ZBr5vrRsuDM2XBAvn8dg9GyBkvzM0yQkPmTqXfHqIDuZLJXzgNJAsRI0IfYYy5UxDb4B+LHUWZovTcskxo6OULnSm49shMzRjO96YTbdI53I43CbrKtmUwt76rgzntjaFr0fTbmJArvfi8FFgvsbukcm/lJ+DkrWVZZzhKfIyQ6fM3fIQ9u1SiLuRfUcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ8BzTqz+Kg06g6+Sbhlc8+QknYN0niJHjRI/7bG/VI=;
 b=KTJg5q87l2ltjQmVikWozSJnR/T9iDt6MffvWD6KK7UQofYXC/M2H6SIyBnmA828hM9GIaPJ3Cyvc67HfOxEoxa+Jh5YsWjm6kmFw38EsiNOnDPFpaXafb37wz4lFL1FOm14HiwXXzDaHB3NlyRAH3I1uVt8Ju/q1BTNKMW8IYYT5ykoj7MBUZ8SD+0WciWY/Dh2qrzAhjz9LkoruDDrayWUzEWpMskMWdvM4HSRltbfKbSZ0Pp9/fBQRXnh3gpdBr95RqEpZhST3CY0m4hDqyFlXyHtYqx9BQkU0fqUFJkHspsZo/qxWVEC65lK2dPfKjD+e9fkqdZyIkGm1bt1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ8BzTqz+Kg06g6+Sbhlc8+QknYN0niJHjRI/7bG/VI=;
 b=ahISvgeJEBthjuU/Rbcm/cGsiQkckXAkH0QDngIDQ+MT31xH04fW/M7xVBtNgtIeSGPSVghcnekA+2qHr0h91fBeR3NWb6PMElFytIO3bSyECp0hTF2cflsHAGApd20583rXz8mCXBLzYk63VpDmkFCM8ett2PGg0ujM16RG7VY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB8182.namprd08.prod.outlook.com
 (2603:10b6:a03:431::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 26 May
 2023 19:43:31 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::c696:d0df:10ac:8071]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::c696:d0df:10ac:8071%3]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 19:43:31 +0000
Date:   Fri, 26 May 2023 14:43:27 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Fred Treven <fred.treven@cirrus.com>
Cc:     Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org
Subject: Re: [PATCH RFC 5/5] mfd: cs40l26: Add CODEC driver component
Message-ID: <ZHEL30a/YEia7kjr@nixie71>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
 <1685059471-9598-5-git-send-email-fred.treven@cirrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685059471-9598-5-git-send-email-fred.treven@cirrus.com>
X-ClientProxiedBy: SA9PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:806:28::27) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: f009a13f-1b85-4821-1afe-08db5e217c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFsjUzQ02YUVJYGY2+sQdLwtpoToVaCZN0kTeofGam32za7yFmiRAntoahuNvkOk+F/iIO+AcgYN0Zzuu6fvUBZJmdBjaXB8rQ03dHFnsX0zw6xb1Rlk5V75NERm/i/cDPWXBxKXZlysxhXsqiwtuRYOuLKeoqkSSfRG6xnpkn/y+hEFTs/vBwx10rjxZO0ytbPLIfqrttILOu5q8OUOdTCNDvl5KunKudkJK/lzWGdY4127Q1INF2kUst0U6oTv1ou27JOe5V3u9vZw8qcJSqFrSwOvTFHp2Hv/aYtBFjGjEvhHXEfRyEKgyWs6JvCgUZis1bFzrVa8DK5Ivy6EELSzqz11wgSSqEy/9ATjDEL48Nf9mnC584VTiPlWYyC314WcQZYABKeQtCtf6iM5uNYpB1aUMskwj8xd8PIzyauxCMKa+t7QZyyhjViPD6DzqJ53A6gXJKZV/X+QOq4RNZhHF67tDpBCdQ8xMwOkQSbfmrAIeMuEFv9HVRM+y1ABn6ng6fkqeMwUFnJHisM55Xl2y5yyId7V9AQEK9HbsFazclfWkfCGLg1S1rpkfs0i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39830400003)(366004)(396003)(346002)(376002)(451199021)(8936002)(5660300002)(8676002)(7416002)(2906002)(186003)(83380400001)(86362001)(33716001)(38100700002)(26005)(6506007)(9686003)(6666004)(54906003)(478600001)(316002)(6512007)(66946007)(4326008)(66556008)(6916009)(66476007)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7fvpPgiMAdI17RYw+n3Duo8lmtNyXnJw20YxGTRldm3oXg9GWb8iwN5OV75?=
 =?us-ascii?Q?qjRaP6OlBEGorEeY7LfbMYmrlCunk5kg0L84AFpo9C33k4wJWfSNs5LgQ6lE?=
 =?us-ascii?Q?rPh5McfOoiMpTlOmUMoa9QpFgfxlAJZJ8HV+sbjhWkCXxG/bsp1mHeA7gC9I?=
 =?us-ascii?Q?Dioz3GwilSVH9CPAxMX5DjYqY857nm9Z1rsb7yHGMv8rJQRqm4h+MeZkepko?=
 =?us-ascii?Q?LFyvdkeDwkJ2LfW8JevUkpq0ErWWHR+1bANCcgM9JLv++/BJjbUGNUrUWOQP?=
 =?us-ascii?Q?4ZJlrke7msXcmRymdm7tfJ+55BemHO5M+oQVZr2g8RkHuL5ReMt5Z1Sk+r/r?=
 =?us-ascii?Q?2xbXfyeuViCq6H7euPkNgMR0iC5VMZIIAujKOkeY/hBjcHsuTRhM/DrTWxx2?=
 =?us-ascii?Q?qmQGzT+kIrAFhrrRGzyq5jNRqYgpnVN3Zf1khVBMKw6zK6n6UP4vS6738CqL?=
 =?us-ascii?Q?jPQuD3s+jztWLIUMX/qjAEs7Jmy/CGcfVElUwJ2ffhvMJMLlbG02gqOL01bX?=
 =?us-ascii?Q?vAKaS0f9vVmYq1YbJ1LAE/5LUlIDV04sj4UPhOOLZxkBu4U26L5XULccoQLK?=
 =?us-ascii?Q?wW/dpJ4VA8s8RhdTCHyRZ1m2Xlh1YhXGDUQ4wQR1G9ERCXZe/bwCzNo8A3UF?=
 =?us-ascii?Q?plWpqt+RnwfjFhKeWb66fJZTNTdytqz8BHNCTq15swOcDAUiMgb0dWWqpp2A?=
 =?us-ascii?Q?KUOw4TRJ8vBcQLhiYiIHitXMVfe291a3Ofg5n8+VRvqPK23Sc+an8TnGKl+D?=
 =?us-ascii?Q?7TcA3wSz8U9rK+IfadDL2c2K3dqFdhEt97v7PObvOqlz6vsL6RShuKkaSxJ0?=
 =?us-ascii?Q?Zr60L0asv8WEdp/82WH22Mjjr1A27h/kDBUHayq3bKDjCq7L1esgBfihm3W0?=
 =?us-ascii?Q?zmoVHiLpqHZCuOrvSXQ9V32mkLRg3omsRZZyJNoIxkpK1hbCCzdgprrMKNY8?=
 =?us-ascii?Q?Hho24Aw/sOxyB3p+foAR2X6gRoVtZdOOBZZVQJ8HCPVbjCIiiM8xToMfCyTC?=
 =?us-ascii?Q?eRxfvCUk/ZRCgRpYbnX6tebc2RmbUiZ+56WWSUeUVhL3HzEU8SYzl3IG3HcW?=
 =?us-ascii?Q?mJ/oLUaoT0X09vjh+XYPUj1uqsJBPFtjWrxBV/KWDlcBGBX4HfH+QIXB+JB7?=
 =?us-ascii?Q?xU3lSfQBq2RGRJ8Yea3LfUvq2ic8VNT4039oOkBqOE+Xh7KjEriusKOPtO2D?=
 =?us-ascii?Q?YxQBURD2WiNk1A29r/fzJbbNNI/4O5+1Uu5z/ycAEqmKFtv/gT+fT1jZj0C4?=
 =?us-ascii?Q?7ktRw1913cDsoPEOZKqPTgb68cQ9nTWFmjE3y4ybIpwUmyN9cEmS0BB24BPc?=
 =?us-ascii?Q?CkufTldcGxMOsPR7b7HdAzuZIdIA2jiH4DDV571w6TmEThyLwQD/bt7srEmd?=
 =?us-ascii?Q?9Wp8+VE3NVc1LkaCMnf0bAY6+txQ5wRvwaUkVDPHObSMKh+3/THBJOA8Pzkz?=
 =?us-ascii?Q?xN5jwDAkLyvZMFDHG9IxIh8pNyVPH1id4tToudTWKIQOnxf1JN+4okpRrlEu?=
 =?us-ascii?Q?jywz2fyeWXAblfiQLWxKqb4sOnlwGAhrVOUEzucsOW8uVQWkAD9Tcp4hHb5E?=
 =?us-ascii?Q?knef6fRYeFgH0MFfDx1tT2Ex5RPMM9q0N2X0v2q2?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f009a13f-1b85-4821-1afe-08db5e217c25
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 19:43:31.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98/uA/Jaw+C6dqRitYlq6m3Q4rdFzD0tLRFH1V4TcNJzTfpmQeFddaCBenZTohDrHE5CrFN+MZ8x2fRxGTfMuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB8182
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fred,

On Thu, May 25, 2023 at 07:04:31PM -0500, Fred Treven wrote:
> Use MFD interface to load the CODEC driver along
> with the Input FF driver.
> 
> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> ---

Did you mean to include a thin codec driver as part of this series to
support the audio-to-haptics use-case? I don't see one.

As Lee correctly points out, this isn't an MFD despite the title of the
commit message, and is sort of an abuse of the API.

What you seem to actually want is a true MFD driver responsible for
initializing common resources such as regmap, an IRQ chip, etc. That
driver then adds input and codec drivers as children.

At the moment, you're more or less treating the input driver as the
MFD with one child, but that is not the correct pattern.

>  drivers/input/misc/cs40l26.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/misc/cs40l26.c b/drivers/input/misc/cs40l26.c
> index 12c29cbd4ff0..35d15a6c2230 100644
> --- a/drivers/input/misc/cs40l26.c
> +++ b/drivers/input/misc/cs40l26.c
> @@ -13,6 +13,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/core.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/string.h>
>  #include <linux/firmware/cirrus/wmfw.h>
> @@ -2136,6 +2137,10 @@ static inline int cs40l26_worker_init(struct cs40l26_private *cs40l26)
>  	return 0;
>  }
>  
> +static const struct mfd_cell cs40l26_devs[] = {
> +	{ .name = "cs40l26-codec" },
> +};
> +
>  static struct regulator_bulk_data cs40l26_supplies[] = {
>  	{ .supply = "VP" },
>  	{ .supply = "VA" },
> @@ -2275,6 +2280,12 @@ int cs40l26_probe(struct cs40l26_private *cs40l26)
>  	if (error)
>  		goto err;
>  
> +	error = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cs40l26_devs, 1, NULL, 0, NULL);
> +	if (error) {
> +		dev_err(dev, "Failed to MFD add device %s: %d\n", cs40l26_devs[0].name, error);
> +		goto err;
> +	}
> +
>  	return 0;
>  err:
>  	cs40l26_remove(cs40l26);
> -- 
> 2.7.4
> 

Kind regards,
Jeff LaBundy
