Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFB55E6983
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiIVRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiIVRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:20:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC47FE5F;
        Thu, 22 Sep 2022 10:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpUdcwX0+JTI7+NVJtz99+TuiaFkcYtR6KEmsR9hdH4l97KToWtYCiI/8vp91wFLGC9gRzIZhGcGNZNbd5l/gvGBv8jvimz6JLQ3XSSjvwaJ4EjZ48U6E0QHWrBhJzo6duCZjdwEmDKK1QpmFP5ygn/HU4ffBwAVCOc7iO6GDnCeAD+C4RHm6HZX0juAQeVOauoQ48wbavAjkk/JbFA6ulsWoBb/TsdRSJAijt3yKi1UUHEmG0MKpWiJ6OfYBgioh8rolGK9XifqSlUF361OWTsFg0OP9vJIX7NUMg6sMJ2midwXprZb+0YD9I5KQ+PtuFn00ZLbR1ccszvYInyLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsz3hPgSRbQm5yitV+e0UVqtVHNnyb2jH/raRqfF9CU=;
 b=GLF/Eu3R+hJBZNiZK9nJhnv/tqHb0lAA/Ils4Exnq7rPdaWL5oMaNS1z+s8WUaoDV/qaCGdJLCCI/yogTddlRELZDC3WzwYxUYDEJL3MeuVFeK47zv3UYzZ7VTpjmJc+hOS04p7m+4F0aPNUCuKHjv4LA/ATViI29Qbz3l08hng9ajKEUPaWYzlvfFRGzFjJly5uIE5rt3TbgBljRCnrvSECHDZ+3VfzeN3NCtVEMOBAls5TCMMc1sGgml9rxWvye9u7nUcvFqjllux6RlW8Kns4S9lcdifYkwqL4chiCQ1mQeam58kVXpTfWyLctLrNYL2bpmuU0eNFV0c8zDAlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsz3hPgSRbQm5yitV+e0UVqtVHNnyb2jH/raRqfF9CU=;
 b=hkLdLDMr/wdybEz8pZlNhTOHZs6lljKX7Wi8/qwVmlCJ7zYawyoTRojIiP3vEBHSmHUfaE4oHwDlcH45uU3uI0kdEAuU1wgdI2sYwGjmy3IFH8njgGhONOTLRQK2+5scsW3Ld3a2o5TEFep1Y+5GcLZskEoA2OagWCCiRVgLlUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA2PR08MB6603.namprd08.prod.outlook.com
 (2603:10b6:806:11d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:20:09 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e9de:97f:447d:1cee]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e9de:97f:447d:1cee%6]) with mapi id 15.20.5632.021; Thu, 22 Sep 2022
 17:20:08 +0000
Date:   Thu, 22 Sep 2022 12:20:06 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 1/3] Input: add `SW_BOOT_ALT`
Message-ID: <YyyZRt5j180KzGqc@nixie71>
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-2-foss+kernel@0leil.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922101211.3215888-2-foss+kernel@0leil.net>
X-ClientProxiedBy: SN4PR0501CA0010.namprd05.prod.outlook.com
 (2603:10b6:803:40::23) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA2PR08MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbd1e57-4511-4054-0caf-08da9cbeb300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmaBGR1LpUE8Fy4n7Qcl7SBSyaS4IQVly7hcG88yXxoWERkUmv2SYMLc7WLhjeiKBGB4eLkReStFbIJ8cL1roRJR/h57onIRzGZFGO6JaDbGaHs6CrGZtKxPUEkhlfRLrgyicFmWSslC8OGtwXSs8WcUnqigQp1pkqQezUsRZbOCIUa5hPvub4NaotH2xRtMKjwfJRntbbDRowuWxxVO4F2UdSKfb7zaETWukuXj4YashaGACF9KkPwsVXBAms5EYA77aQeHEtV8yTk37w0xzgxmcEUCDx8gsUfSJcM2ftOcLZIe3szCBLfmOCBOEsdHNAqoaV/83GROarUgKL+xpzmb90COIqgrNw6vLxBwKLvI2aKsbM8jIfdlf7KzRYIG5F9uWubxcg16npM2xRlndcEqmLBJykrU9UGs4G044hNMPJDJ/cV/Tz6tktEgy5MMlxTTu3znk6b8yxalerQgLS6Topp2mEAnq3b7lK6E3DgnAopKfsIomtCOKV09U4/V6Z7fyRzDWOO39o+FBwCri5dFJVQK7sdEFox7vyUHZ2OwVd1XKnq/pM471/GljbyHUv3gbaEvaaAdCvdhgYGbgJ8W3hDLc6m8SKOWt1IwqKG44ZklZqWQCnECjrFe0FnSaci8oomMQpxyXifPgquiILsTtVol1iWQdJ+/9FW3gwwiffv0sc9B0xhTzYVp3KZhnnLCXGZ7YDacmRmHDOr8l2fFE+unsRMBzZjkSNLQyms4F4nxtVTljIjQXLGkWY1I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(39830400003)(366004)(136003)(346002)(451199015)(38100700002)(2906002)(9686003)(26005)(6512007)(478600001)(83380400001)(186003)(7416002)(8936002)(6506007)(5660300002)(86362001)(8676002)(6486002)(316002)(41300700001)(4326008)(66476007)(66556008)(66946007)(33716001)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bVY8WjxRKM2dST6jE40AQ974j5JUVSYFn2HjA2wIXrDM0wCg8P44pJcdBbF1?=
 =?us-ascii?Q?dYinTunXa4OeVON0bU9nBx1MYIo+D/hqL4Lpq+0ZWAG7bJoF0Wrkq5ScNVSC?=
 =?us-ascii?Q?YffNXh0vnR6hXng1bRX+sddhmJhjnqy7brDtk4Ca2Bn6jNx1RzlIw6lW7bg0?=
 =?us-ascii?Q?e7//Q7HqjArAiq72O2agdrRhG5nWEZGhsjdI621XLJvUTB1lf6izrdIppEbI?=
 =?us-ascii?Q?fe3pU4ilCy5e3d+uay4SnnWPS3KrGsnzoU8bhpJWhF+YgMlWkjpuXDjWGy2h?=
 =?us-ascii?Q?hZrjKYJUKA4SXRxUb1rWrgat//LUzdc2uIwBoQ5iqVaLab3/KzsoEa1vHMin?=
 =?us-ascii?Q?sMaKq9Qj0/PywMpV5UiJY6s4bX7hcTNaBscgkR9cN5NATMAFVkA29tqb3hLI?=
 =?us-ascii?Q?qIMLqEOtOlL1DK5i9Ckivv2O/grwpntO5lEWtUb/j3mwn5eWaeUr7SQPsF84?=
 =?us-ascii?Q?jd2MnD5s4sjZs4kUTpzDryf6QArTJyDx3gWcNo7FdgdaCbzo8nAIBsvQhd9x?=
 =?us-ascii?Q?HzSNdQLXh/cWRGjbhIr98jWB4ns/KTPkUCV3pv2yMvAcfK4IMNo6lCb6rWq1?=
 =?us-ascii?Q?UeyR+o5heW/06UM9TVwQ7X+ttGIA053OrFq4eGx2ls5oZ4mflvNHXX1yDMZk?=
 =?us-ascii?Q?0hxRTMby9Funs62jNCO/q5YKjtc8dOnYIHWMsVNVhr626mTQk921sIRMViaG?=
 =?us-ascii?Q?UeueBGtU07gMHPMl2m4r4HkUQ2llwbpYOGONm6oEAlQLTnFyvA4k5t7srBTV?=
 =?us-ascii?Q?3ZwRyvcoiMIZzYuJSueDemdAN2cCJiTDDUm2yUzJgDoS441s2EmfJ7hEbMoO?=
 =?us-ascii?Q?x7EmqVVYPmoUFL51W+iMA5rwOCUgXOKb07+tZbgX/exPZ9IwTd2C23HHScDe?=
 =?us-ascii?Q?dUukmRNE8pHYyBm47ZMSXNIOUFiQ90UVDP0TDz1ILtVCXUJnvbBSyrHqmNfi?=
 =?us-ascii?Q?TXABTRWfHQs0EUtnH1TVdHzg4zc+Z03KQiVgQLINdfkrROzHpX/EIuD5HO9p?=
 =?us-ascii?Q?iVkeEx8PT5x62wCjTk8NucEsak22ye+/hvlE028p6CHSx0e9xkVNbFNt22fc?=
 =?us-ascii?Q?QHkIaW9QRCTcmrPr1+CqXbb9/+yWrXhLXbHgVBZtIN6MEwbAWZXwkatDtS5Q?=
 =?us-ascii?Q?pQbsHjpjuT9OsRST527nm/XOwb0DwWIJX6MqinnNkUX6XLv6UmPVyv9Trxj0?=
 =?us-ascii?Q?KarKmFaIncllvzfd/EO94DfSBW9kIqr+5n6CyXPzPg1DWlZGgvnIYXgLRrE9?=
 =?us-ascii?Q?GXNCpYrwH93UxvgO0wsMXjNwYXIinL0yAYg1Kic7g9XZJRV24r8O+vX5W8Fv?=
 =?us-ascii?Q?z1x2Cr/ViwUKTtJ08WCMsBiWhbjzcLsJoPrmuEnOgAWdXWiwokf1A12wOuGR?=
 =?us-ascii?Q?RjyrjJrXeSrKF2WGWwyMagCev6ctWqukjICB+k/bIKWPpLTUpvsEQonXvHXd?=
 =?us-ascii?Q?2ZyA1hchYFwx+3TBUtGe+w6WmK/e2KxsaLEcWA8ehRsounN/4TqZj0AvOYfQ?=
 =?us-ascii?Q?YoIBN+4ck41CpT+kHhz8c86m2L5hr6NlL3DiInpv+iO6HjxEgCtt/vPpcQjT?=
 =?us-ascii?Q?OW1KNHNfyAvw4pkhTatQl7qiOUAs926WAHE375F7?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbd1e57-4511-4054-0caf-08da9cbeb300
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:20:08.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI/wjyRMxD+/OS6sLUti5fIB/B3a49Se+ws3W0cVsJUfOU37OTvoF+SVQPN+5Z+a1KGBUxWP9d4HOaDf4+7Eew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6603
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Thu, Sep 22, 2022 at 12:12:09PM +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This event code represents the firmware source to use at boot.
> Value 0 means using "standard" firmware source, value 1 means using
> "alternative" firmware source.
> 
> For example, some hardware has the ability to force the BOOTROM to load
> the bootloader from a secondary firmware source (say SD card) instead of
> trying with the standard first and then the secondary. This event allows
> the userspace to know which firmware source was requested *in hardware*.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This does not seem like the right approach, especially since the switch
can easily be flipped after the state is already latched.

If the bootloader needs to pass information to the kernel (boot source or
otherwise), a safer and more flexible approach is to share some variables
in eMMC, or pass information using the kernel cmdline.

> ---
>  include/linux/mod_devicetable.h        | 2 +-
>  include/uapi/linux/input-event-codes.h | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 549590e9c644..009e71376a61 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -326,7 +326,7 @@ struct pcmcia_device_id {
>  #define INPUT_DEVICE_ID_LED_MAX		0x0f
>  #define INPUT_DEVICE_ID_SND_MAX		0x07
>  #define INPUT_DEVICE_ID_FF_MAX		0x7f
> -#define INPUT_DEVICE_ID_SW_MAX		0x10
> +#define INPUT_DEVICE_ID_SW_MAX		0x11
>  #define INPUT_DEVICE_ID_PROP_MAX	0x1f
>  
>  #define INPUT_DEVICE_ID_MATCH_BUS	1
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index dff8e7f17074..8cd2b58c81d7 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -917,7 +917,8 @@
>  #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
>  #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
>  #define SW_MACHINE_COVER	0x10  /* set = cover closed */
> -#define SW_MAX			0x10
> +#define SW_BOOT_ALT		0x11  /* set = alternative boot firmware source */
> +#define SW_MAX			0x11
>  #define SW_CNT			(SW_MAX+1)
>  
>  /*
> -- 
> 2.37.3
> 

Kind regards,
Jeff LaBundy
