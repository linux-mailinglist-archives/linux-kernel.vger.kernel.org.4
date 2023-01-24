Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC2679D53
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjAXPXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjAXPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:23:08 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2043.outbound.protection.outlook.com [40.92.98.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388497DAF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:23:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpqqXl2UHVQ0P4oKRWQutwiLS0aRA19EybNTqqVuMCIiGVJKsKqvq3ZGCYJg5XF4S6ejIZ1zAl00pSbJ0YL1hVZ382+QbkQix5A9J9pF+yA0WIIfCYokLusjMuUKF8H9JD5dBdYlb3KjexczdGR63aO41SiOiby+Tc993hAKM5Un4QzjG/5AaSAAeTDftIIBcyeAxd97hFA26Zm1sl8abZRJS4LVldQKneXeHJq+MenZA6PM4+iUpLqTii6+j9VrpkDDOO+zKG6hBk7KqIgSWhWBsU2PxyXh0hdkUI4inFiCYX31JxEY8Jbgy8ti4iscTHSpK37bivJj0qaeMmZ9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBIGsKHEX2bRKOKcbKQhN2AK25vY+z5pF+liKPuE6yQ=;
 b=JM4og65Sz6zJJ79wg2WowP2+LqLpwvIdFjArAIQdHeZNSNrOzNal0DZJB2OG1K4h4khg+N8Ly2lw5T4vv+46biovAfcOOrXhDBYKDAKCe8k70EYX1w5Wtm4D4uSkGi0gkE1nnPGzkmhPXdlL8maz5qm930m8AWa0K/Gj1asftJ7hadV/j7umPnoBCsN/HjzMA0g6wdhwewFTCywHiI+ndo54DDRO61kyQ3YkLF7qttNnD42tu+WD+jKYgn3tJJbwHdZnkk3K3v20uEL8vvLp0sc89ZBwJre+0YZ7afN/OZO0vJSZXDkpgWCYRct5xhM480nCm9ZZGmjY8gLAFNbOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBIGsKHEX2bRKOKcbKQhN2AK25vY+z5pF+liKPuE6yQ=;
 b=GpaNXu8puosVI+d5EpvKhd6p1Db8FJaWuZLlQLAN57Bm9Yzh+6ukbei+TVr/whvXb4Wi7dawib42VOhUCO8Uwe9Xmdw4DNE6NpISvqP+4OzdyBeObI01rxGq5+wYw5CU3CKaL/K5iVxxZQpHCNSBS2hU4sVKMgaLzeqKCpqBfon64q6kgDDy5LLiaz4euWRpQE8VoBPeCwUv8Wwr+aF+PRKcSoPhPiCbxg87s/8LCrAm1vVhn0HZJn7T0LR69hk8OkERH1MExNwImAHeBaA/5EH5EC1pyT3arQf+ZiaTSvlVVeGIfa7MfdsUxzb5cLDIgnrQxwdOCZy9/iC4Cm1CdQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TY3P286MB2753.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:23:04 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:23:04 +0000
Date:   Tue, 24 Jan 2023 23:23:00 +0800
From:   Dawei Li <set_pte_at@outlook.com>
To:     johannes@sipsolutions.net, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: aoa: make remove callback of soundbus driver
 void returned
Message-ID: <TYCP286MB2323EC6EFF71A5FCE0CC04AFCAC99@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB23234FED40A3AE6797DEBAB7CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB23234FED40A3AE6797DEBAB7CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-TMN:  [/c8Epj8+MSnxmSETjww37obnUlRwDpz4]
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230124152300.GB2227@wendao-VirtualBox>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TY3P286MB2753:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d56bb6-19e2-41e2-e8c9-08dafe1ee35e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwGHSz2flWtKb2W6Zm975ppvM3NMLADJRV560MhzRjXzeswJnBxbL22+yxj4727YiOQsi38jIqClXGOXIwGU2UOdUOqRi2+P7Oz0Fo47oXKzZYFJtqSFLqiktbGz2Vc0UxtH3Vgx8uEgtXAvE5I3PP5+RIaGRhksaUcYSR5C/ampd1m36bKnYeI7E79CqVmV/g4p36Y2/Aws7kHTUhVHVJhQ1Jkf1ZzYH6QDkud5amaW+EvY6cGKMQ8prg3d8NygJFSqJPG8FAWhQAoWFy5UXMB27eqTZVj47NVqGxkwkz87tubywBsnIvGPit3hL9j3Tc/hsl/joc8E0wTIC1A/t9DsgRP9rpY1UXzqQSqoeG3aZLPV4MceCMuiXUNCYfrXApsodEjcNj8zvN8yD4PRpERVQTCXC/34OFDWwLwV1cb6hSg8li6qIUKuMlZOgGlxpLRAiwKCjapPw4so8xGcZ9M0oI1XuAv162BFvk/d5ekqjA5nOzhiz3HvHaHuv7oW6/RNvKVl1Ge4mS7HUI/uulJdg2HXhTCkzp2BgkgI5QEym4UnS4bC3SJTMExe7VVfLjw+gzqoLDxlMqSlVOMm6BPs3TWZU2aehtbaagz40VYXrgahq50iXPnru52W2SkgPzPdLfLrS9Z32h7PCju7ew==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfDNX0nQbS9nrpEyWfqFh9U4FLVo1uBP5FtZKfbpteM/dF1TuYX5VSXOHaLy?=
 =?us-ascii?Q?dweCRPi+hQltiS5Gx+Sfn+syApUkt1ZgUcEoAqgA+/MHFq3QmRcP1oi+Ufsw?=
 =?us-ascii?Q?gkvR732YtBAYSVL3XKra7Zmue/siMjYXBiqV8hs0l+aQXoMCdGC3F3iqKjE3?=
 =?us-ascii?Q?jyMnWb71mjI7qXn6flWnpwWfMEWwRzCraB+Ga2aQo34+KFwx91uE5xrM5Rqx?=
 =?us-ascii?Q?/HwkKudcK5b4AMEk1HWzqruq1gmsEefSIXwpkxa/khqYMNruk+vY9SdUn36G?=
 =?us-ascii?Q?KWEmOpsH85TTnmslIVCGP7DcfeV9ASAt7NsKF/5F+kABgHSuoAC9n6sPuDRW?=
 =?us-ascii?Q?48bZvaRzP/kuRP1O2Y3mEHo3yOcy7dIKVLCxTpm6uxkmwnVFuCVr7nw1b/WJ?=
 =?us-ascii?Q?RbR4wj0B3ZtfadA2rnHR32rPdBAc0HA+9Kf/bLeYYyK8NTZ+mv/SiqnxGzRD?=
 =?us-ascii?Q?/wZUFScy85UKJ4oTPLnIYFxIImsejxrKLwgyNJueDHSczCAwihHKyKlbnbBG?=
 =?us-ascii?Q?UQSgQ+BedKq1GnB3IZh2B5ddOLTMraZohenERt8/HGy4HiKbAVE+MeZx94kH?=
 =?us-ascii?Q?plBPaf4ABzDpuPId5ED9pGzqEgTzMBSJwUjz/Fywe8PX+V+BEGtUKVMti95Z?=
 =?us-ascii?Q?jlIdR+RC6XKisbH4SdCJuyB6rR/QychvTctwclorpGND2fY0PZQIfQmA3ZSw?=
 =?us-ascii?Q?1pjA7IVGqyWoATTTAK9uLm4JXMFbvbwVSYpY5zSiY35Z2wp6LbQk8GW3u4VP?=
 =?us-ascii?Q?eWTHBbi+AmucvKjWoZUUR3u17O0lhylUHIp3nQmhk6+iIfGpLpRPpgbpFqBU?=
 =?us-ascii?Q?z2k/oJ3iCs3bPvd3xii2DBiCslkDCybBGkaTjz1s1S3dvd6C/7ZqNmqQLM5K?=
 =?us-ascii?Q?KQ8DJXqW44yzdO2wMZ8pqpIwpV+Pm5m5ld24JER+5jxKH2lJDU7XyZDnsROl?=
 =?us-ascii?Q?4KB1mj1rrDxg8TBF8vhOxg7tlZe4hQjTm4WMDASEva5Vv7yBsdpQjlL5KTRL?=
 =?us-ascii?Q?31BA/Zv76yw7yWgxYFcU2nIQMelLvnw8t3RuMCerSxBDUojXUCi1UIQspDoj?=
 =?us-ascii?Q?Lwxccz1i0mcxs/LGwONMlf3wVA7bKjekvWD/EL3qiJJOUXaSFeV3XxW1yViA?=
 =?us-ascii?Q?aYRkUOCG4DrwxetTDrrArpWdnK9A4tkXs/+c1/WoMN2SfR2JFpgri5GhLaQF?=
 =?us-ascii?Q?4yvrBfPW7VPJX7j9M2ewE7JusvcNB4bvc6fNtU91+o3tzmIJdMGtksSZJRo3?=
 =?us-ascii?Q?6KUzGLoMQLJpnqOxDXPcKTVQP7Vv+gbST7z5lavycw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d56bb6-19e2-41e2-e8c9-08dafe1ee35e
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:23:04.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 11:17:46PM +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return void")
> forces bus_type::remove be void-returned, it doesn't make much sense
> for any bus based driver implementing remove callbalk to return
> non-void to its caller.
> 
> As such, change the remove function for soundbus based drivers to
> return void.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Gentle ping

> ---
> v1 -> v2
> - Update commit message.
> - Rebased to latest sound/for-next.
> 
> v1
> - https://lore.kernel.org/all/TYCP286MB2323BBFCE929111043E60D3BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> ---
>  sound/aoa/fabrics/layout.c    | 3 +--
>  sound/aoa/soundbus/soundbus.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
> index ec4ef18555bc..850dc8c53e9b 100644
> --- a/sound/aoa/fabrics/layout.c
> +++ b/sound/aoa/fabrics/layout.c
> @@ -1094,7 +1094,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
>  	return -ENODEV;
>  }
>  
> -static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
> +static void aoa_fabric_layout_remove(struct soundbus_dev *sdev)
>  {
>  	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
>  	int i;
> @@ -1123,7 +1123,6 @@ static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
>  	kfree(ldev);
>  	sdev->pcmid = -1;
>  	sdev->pcmname = NULL;
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/sound/aoa/soundbus/soundbus.h b/sound/aoa/soundbus/soundbus.h
> index 3a99c1f1a3ca..db40f9d042b4 100644
> --- a/sound/aoa/soundbus/soundbus.h
> +++ b/sound/aoa/soundbus/soundbus.h
> @@ -185,7 +185,7 @@ struct soundbus_driver {
>  	/* we don't implement any matching at all */
>  
>  	int	(*probe)(struct soundbus_dev* dev);
> -	int	(*remove)(struct soundbus_dev* dev);
> +	void	(*remove)(struct soundbus_dev *dev);
>  
>  	int	(*shutdown)(struct soundbus_dev* dev);
>  
> -- 
> 2.25.1
> 
