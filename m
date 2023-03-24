Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2086C884A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjCXWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCXWY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:24:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DFEF742
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679696640; x=1711232640;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZA9sDyXCMsewS1bcf9UHckodqWiIWxn4wZGneRZEo1k=;
  b=UCpk+AzuU7a7PqrYO93pmKXBDO485ZuUNRh2d/CdY7YLkxvr1Pc5ZLnQ
   pIKUwj7s6PsJzMTHB1w6AEg7o8MeZXEdvRYIWLcid/ZMyAM7c/eDF5qRV
   +ot92/NNtT4zka2qioFUL762KFTVK0HGuGqj3dU+mSp2qrzAUzqAXiuCC
   ZzCHjX+KAVhF1WuwRSELN1RNR7sjyn5ttk6Qgxggfu2XNbrecymQrN9DF
   8MhuoWjE0XHwnFahO5tOgOPZ94GKNCMqJd1XlnJKPIV8JZeJO8KR1S5dj
   2/8HVFSw9B1+bcpyfQzWpXi6vDGbX1f/hnkSDJMd24D3WrVr01hDAmFDJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341467703"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="341467703"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:23:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="857029816"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="857029816"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2023 15:23:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 15:23:59 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 15:23:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 15:23:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 15:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Him244OODyq5WIFxGi5KBFLnOxXMvwjRc6sdjVSNb7HJoLdv7vtqOGcbUXTm1MRw1SZdRiGZVYa98/dqMQZ3jPimn7s++/zrBhTYjykvFdhPQMVLemCQRMReedjVhfDGPtoXpQRUydiGO3W9fZQJ2fPQ+xFHg41tgvT5akibvdfKjVItOPCfFZrzkHr2YwqtRU3MVKumeMtuI2KdWW7RBqGd4r8K6IuMpBw04BG9YPRZ6UJERHjUVFL6Gn/5qZ3MTRAeDvhhmep7zMO3mch1dDjN2CySqy4qTKoyu0Tjy3h7bK1KgS+MKZS50iCrRgywARm9JQ3ZVnRcurjtgNzfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYZQ2GuiDIjr8Y7tPqcDv6SiesnSjxzY3fbmWwcp47E=;
 b=gVXv5OMchh/5T+tz0e1UUNAk9FAOdujBfcrV6exwrDPvse51A7Ikx8StjWUzDMGXF6HyiZe2rgD8p1vMoyPpnKQlu5AEIBxpyEuOCctV06olN6k79wfhHESkiEH1HI2yfWEqP96evvczVdeA0E+Z40IEezhz7ORxlSzB9Hj7fEnIWKXlqf9KeKflUnoc2cvYhqQh8eoea4+mqswiPcDWolIS9nbAoHnc7nnDwrRBSi0cIs0ED4wKxj2HA4I64xfGeuSePo2c6iRNHqCPV8SAgKbW1vAY2Ty1TgaX26Xm+0a2jTYSvEV+qeKYkyJG1AZ2O+yI0ykF6aMKZdUaktMXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7390.namprd11.prod.outlook.com (2603:10b6:610:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 22:23:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 22:23:57 +0000
Date:   Fri, 24 Mar 2023 15:23:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        <outreachy@lists.linux.dev>
CC:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        "Christian Gromm" <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: most: fix line ending with '(' in video/
Message-ID: <641e22f97f91b_325e1f29438@iweiny-mobl.notmuch>
References: <ZBytWDocM7XbXkRx@khadija-virtual-machine>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBytWDocM7XbXkRx@khadija-virtual-machine>
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f411cf-692e-4f24-c3e3-08db2cb67543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HS3fV5Aog1IrzR+txi6x3ebzRn561fDHoa4FqmUkohEvcQLjah44ZuU5iyajD6UWg3OxTRGuxgmm4T3PD5P4ciECxCRKnKRInej0z5OwahhQJ/CmsY/etlAuJQSVAp+9Nrbpvg0vF7xBukx33yWbEbrbvMrvsKHz39qpN5v8UyNaTBLUC+frn2bUaScIQ0j+IRKP8r7hs0WWzX8LiTjdAqzSKA3ehTV5AQNiyECyLqdjlj4GrKpdSoWr3ilRdxYREiLXHh31NE6hM5t/TRlTP9qyxiveiJFdyHJ2WFIDUIINQNiw9W+ZH5f/5O1YgH+X3NLhlWZs6yCQD3zPVKwLlBKpQ0sMXvjzq7ZEABPqkYKKNxBTdkhibJpZlBmQeDWu3Dq+jgFkUfbUs1F9F48HUafgFl/9jU0w4zjzGreF78Ir0WpPfICUIWCqyttAeEw7bxMy/nRIKc1nNyWe88NsT2zy112d4xVy2m9qBngZ7N7wkVZz69KeUhckiyXHEb4dcNZD3vRI3ze/SkbmTFlIaU9j6QSQBVFXIgjFPVUlqeUPW8MCd0Bwv09g6WhrIC6I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(478600001)(83380400001)(2906002)(6506007)(6486002)(8936002)(26005)(316002)(6512007)(6666004)(9686003)(186003)(86362001)(8676002)(5660300002)(4326008)(66556008)(38100700002)(66946007)(41300700001)(82960400001)(66476007)(44832011)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?40rYWuL7ZvcT5omywPR11EztsXlNZV72cs9/mdAmP2LkolcWO1jtPIr5Hx0V?=
 =?us-ascii?Q?hg0F4zCHSU64kq7wreT7ypm8QAIT4Q6ssnn6+qZ+VcVS5YHdPYvvaKFIHfr9?=
 =?us-ascii?Q?795uckNTFSaD6GuWpSxFtP+BAkL+oOfslhCe63oRgbIlpgNyg3AGJ2UAZkr9?=
 =?us-ascii?Q?0/U+yyKw5H0/U4YugMB126gZ+s0nBub/IT3HUv8ef+PGYM+UDI0kAeuDoLoB?=
 =?us-ascii?Q?OwX3x7gVxo8vUJonDlegoVypATptMoYqvdmNZXYQgzGvzXaMQU6rCgi8rDyK?=
 =?us-ascii?Q?LK6hl2aoXC9cfWtOGkcASbLgzf/iXptGBfrQIzrFMX0ByfLUqZ40uN1+DBQn?=
 =?us-ascii?Q?w0R0l1ndTBIqaeQ7nC1S39dU0p/DWb+GZOevh68Ns7TGdvhoPe0BojdZDRa/?=
 =?us-ascii?Q?D5e86JKIOznZIcNLOrA+kT6hWjsqzwaMRaIKqpqaYpGURMHSjYDaUEy0ZAZo?=
 =?us-ascii?Q?tMcGeFcbgB8/Vs8a1vNLZzqcRzf1LkAEaM2NlV7SWBFebttq/J3WtRTFS1DS?=
 =?us-ascii?Q?9vgTyZne0EEFm7t1gCv3f6/xkcsvCwTABODVBdNC+/ObuowcuWDvImDBN1EF?=
 =?us-ascii?Q?4GUmsL27rnpl/e+EG3hCBz+HnWXDXihqHSW4MClZmpoT/jEv1KSgdPYSyC0b?=
 =?us-ascii?Q?3xPBCutcoFpezj5jr4daEN6yABLB8mkaa5BiWX3iTS+BWhqsalZX4EPBviEl?=
 =?us-ascii?Q?O0y8TiNBAnXpWfUhjh245mC2EX8RnkrPJXJhuEDdwSZHbHCQ5vYOTPYjKD7n?=
 =?us-ascii?Q?KVPWTls9q18wloyvSFeeVPVIDlLdJSy1lHoLMkhvaZaJiE4bPylpdhJ5ewFI?=
 =?us-ascii?Q?ffdzdkh0YJV6es6eoivdc6A72NBywk7LFI9gi98+MQ4qjC9cPhyV3VIxaMj5?=
 =?us-ascii?Q?Nx/NJTRojiXNx8giLEvUSU1sner/Fsj0OlEw7sfgtOHlBAht6TSO5M1pNJBm?=
 =?us-ascii?Q?m8M1hJgYQvJni47/25Da0gCFS+cP524I+/glzYaTv9uBdK4sZ9ld+6ZOKQrI?=
 =?us-ascii?Q?lUq7I3HSPec3iQmvbj7GD8FnW3/h9xYnrQoCXvRNVz8AOspBKUphz5xIW3Lo?=
 =?us-ascii?Q?2hWU1Vl1dOX9oI3K3SHoay9gM7tuJTu5zl37BV05WZb0qG56dwaNi+54qwWL?=
 =?us-ascii?Q?tO21Lj6xfKDHwkhA4a8eS12iTwrzMBFQaphU3aG1Y6GrvJsJFzpWN4cfHAKc?=
 =?us-ascii?Q?HjKRwLZRFXIkmXlqsk1wmamhMIDXy91yfjZd3n4D33ZqkyBnOWOv32ACVGHI?=
 =?us-ascii?Q?nr69YzBeMyaw5Jp2oSudIYxfQNhQ4DsUNshZ+2AlRMiYCIpXkwbPp/4Ej/SX?=
 =?us-ascii?Q?3oJmj+czs9bL9zbAWrlHYmrsKBd50hEWzJrUBAk5kvMQj4ucVWs6ddjMf6vx?=
 =?us-ascii?Q?xjNhzT3cuq6U0HZ3XWDj21PD0rvY1YLApkwlSm+EnCI4ITPJNU1+3m94s2z6?=
 =?us-ascii?Q?Z4w4/20ZWBHoSUnh94t4Ctd3y1dIjnlVz/+Cx5OJBaXmOJUBXObdp9HUUnto?=
 =?us-ascii?Q?41/N0FKlbAaSEtvARjzWKciBW1ktP/de6hTXnD8soSjzx4QHuZzSdkmVDG+Z?=
 =?us-ascii?Q?cFMwljOO0/BgmLqmhABoY9jQ2kTgMR8ygW6GX9tI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f411cf-692e-4f24-c3e3-08db2cb67543
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:23:56.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frjyVG6ItFzjBa3C614sCP1Kkg77CrWvX0Gt4sv5HQ2rgq7j7p4q3fCgh0latcgJZYJ/V4ZrgFJcbX74ltSjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7390
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl
> 
> Move the function parameters right after the '(' in the function call
> line.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> 
> Changes in v2:
>  - Changed the subject name because there was another patch for most/
>    with the same name. This was causing confusion.
> 
>  drivers/staging/most/video/video.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index ffa97ef21ea5..6254a5df2502 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -365,8 +365,7 @@ static const struct video_device comp_videodev_template = {
>  
>  /**************************************************************************/
>  
> -static struct most_video_dev *get_comp_dev(
> -	struct most_interface *iface, int channel_idx)
> +static struct most_video_dev *get_comp_dev(struct most_interface *iface, int channel_idx)

Same comment as the previous version I saw.

Ira

>  {
>  	struct most_video_dev *mdev;
>  	unsigned long flags;
> -- 
> 2.34.1
> 
> 


