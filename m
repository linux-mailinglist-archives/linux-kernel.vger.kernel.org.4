Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6406A7FC0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCBKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:14:38 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1211C30F;
        Thu,  2 Mar 2023 02:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/19bQvLAVzip1RnQ1t19T94i4Q4dB7bOTvjoA0MD0nU/OnJs7+rYzirCCzmB/G0Mk4IqZ3gyWFelEjWIi68vFiqa4HP7hRjPlIr6aPnlMhzMNzefykaj4JPux8NJQZpzyz496BsPLgdwq+/axkpC5qOA293teVBbFEmXMSmGZgnhSy0PNsWnRS4StdxzlaC/fYKxQ/j4kjWepetgJllwh2bTzOVTI9xdpAMi8x2S1qM743xcdnVXmTVhU0P1k+HPaVMVVISAfSAu3XOX/Lpn7ufJtJkoLK95uQ2Jh0ZhuwxZ1a/nEEM6/aRapMbin9kJbWIuGnt4gkV3hDlNbvBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WazplwNN2sLg5ASnaTm14X+2gXab2tNL8GT7Vz/UJCc=;
 b=bcPYrjPq2fj4t18kaArJQxKRpd6A9fu+lDmcHE9bADuW4/H+ks65U2uGcstx4ZEARWlZqnS7grKF1DSZLaze9FvnIA4sKh/KqmgQ/RcWAlB77LS9XNoeON1ZZXzAfPL5ZxFRJ92h/yq7xjXy80xnkt4zyd7VUWf2lFE9gG02FmX1akQerd4ZScr7uc0DVBBVR3RmrTmQc4hcD/l2JitR9garUlCpDj4Bx+gsrUjWwzfJtAbnq3UPXCotJ/RfsMQuvdy86YojjgPjRmPCQgMuM4i8aTvmxjvxpf32Eh7k0tjaSsthQ3/4ELBzbNy2p+wmZA87JWhxAA5OWm0ZgQvWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WazplwNN2sLg5ASnaTm14X+2gXab2tNL8GT7Vz/UJCc=;
 b=l5/NSB8KX5mC2rkTv+3q0p/JomvYE4CtLfYTn0oOibesAbYWHdvxrDZ5KqVlPphA0Mr4cXa5tV4AIOKPWfQSxkbYg2xRFg6FJtC3m+KsoQxRvCoQUC2PWHNee21dXvYw0RTAZVL4fefRssxatpJLSmyUtPZi8ULBPITRRKGZ7iaQXiqak5dSh/WwOSPFN/wotcY6hx/bJseH583BshxVRTuaeNnrjJWIEYtAO/Ro6D0hZ+Md3K/6sCyX4zht38S1dlZb7xzYJEH4n8x0h6Ut67837Jrlx8UemWsh7KtIEfRmkXiZWbzOyYFtCNAyJjCa5uh7fBbetsVso+UGXcxP7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS8PR10MB6602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.6; Thu, 2 Mar
 2023 10:14:32 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 10:14:32 +0000
Date:   Thu, 2 Mar 2023 11:14:27 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/3] leds: simatic-ipc-leds-gpio: introduce more
 Kconfig switches
Message-ID: <20230302111427.47ba9f64@md1za8fc.ad001.siemens.net>
In-Reply-To: <bfa3ede3-8cc0-ca6c-8e88-17e374aedcb6@redhat.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-4-henning.schild@siemens.com>
        <a6281345-95e1-3e8d-b6fb-146c1852373f@redhat.com>
        <20230302094728.563c04ce@md1za8fc.ad001.siemens.net>
        <bfa3ede3-8cc0-ca6c-8e88-17e374aedcb6@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS8PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 621f169b-e5da-4c2e-33b9-08db1b06ea6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuEgZjXYB4ZxQbT4B7GxX2zm0uXZTZzrTwETInaiZWkcmm3FbSoNgaLtfRXUyfrjFshwglnJDn0J+UrfHJWVupWVhZHv5HdUN4GBmN1KGDPlwJU8j0wSht7JY7I8pHo2ipib+QxEOHGOg5Kp/Se9YrmcXgC9zD+0tU3QQK7NtYN8lGS6vsi1kyZ6PmFN46gtAK2MS1Fh0xV6gPwYraN9WJfvHYrgWRh5TcjEL7O4iBG7FqquJb9IfW66B7HP4WXm+r4vRj+TqeT793MlDhVARzJFJhxbQg1FJQs+bv7BYS7dt8+RcuyOxiWluji4kyC+P0UtM8cKej4gHplgNyjZXf774aMKqiW5sr2SSV3d0wWrTc11XxvhlWCxJgnzx5KLqKcROw8vesdH1KnRKD9MBeFDGTH7B2a7LQpHS4dY6aAqP07JCSEar8id04BC+cD6t4gaULRIqRszfKGocN8YR556ZHyxeJVQAvI62EpKalfVGEkyXIdRdcgr+VyInpTtNnzk28I1VgdUMBEn1hlNrVVwvc93x6MyWBmTrM2RSgk0as0pbKRM3BT0Jsc13nbJq6+2eqTfnpNvrUbafShQHpc/Mri/HE4wFwQpdnud1m7t79RAmvltK0FLEy6LKx4p6bZGb7WQ23P7NV+cGDWAlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199018)(5660300002)(4326008)(41300700001)(83380400001)(44832011)(316002)(66556008)(66946007)(2906002)(66476007)(8676002)(8936002)(6916009)(82960400001)(6486002)(38100700002)(1076003)(186003)(26005)(53546011)(6506007)(6512007)(9686003)(6666004)(86362001)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bBALeQX85DKh2W89/KfYVeYdL2lTY1qfMxtiJH0jNKWJLUieOQ1BBAy5kjkc?=
 =?us-ascii?Q?6k2ETK/76t95mqOZYPCpoGskKZcVl5BdwsHRYoe1RSQlZYrIaEfm4QX3PCdI?=
 =?us-ascii?Q?n47WwWJsuGQZNWVZOOdtnqeTf4SP63O7nZVxwaZQzse9Eiw7djb+ozfyjO/O?=
 =?us-ascii?Q?1tdMz7o8aduJSU5+qOU90DDD89ejl3BW+xin6WkylNkSy2PyZ6rY4fc8zB26?=
 =?us-ascii?Q?eW0O/n2UMefipOxl+by3tPZIlVDYpi58R2+QqbI8rSEB22zw+fZj9yORkGvU?=
 =?us-ascii?Q?a1DahpRYA1KJa/NmU+MrtVtn39YGRw+v2E7qjLw3YSDQfQRkXf+E10mhhsjv?=
 =?us-ascii?Q?6X3vPc+kqvr6+e0AP7L4pedJKxmpNxj5kop37qXG+ctEc1M8osU+GjM/Cerv?=
 =?us-ascii?Q?9WiPqejwW4R8Zhl6yjg2XY0xF/ww1eD8wPV4oR+7HD+RAxx0KAkSnBPF1MSp?=
 =?us-ascii?Q?E7tNuzKvP/GO+6DIm2BEw9IA/78qK0zbebx2v1dUy+al9+0sfpZ3cl5mmCE7?=
 =?us-ascii?Q?MoIj8SG4OGqVoBrL7sO3ghS9M7TRNH6rX8I9buyWrMdFdeu/b4L/Yh6eX7qt?=
 =?us-ascii?Q?HP/Jsj7W9HZnD05QtikmOHr5n6iUo26bl7fOrJFmdPAwrf1itCVjCNqc7MQZ?=
 =?us-ascii?Q?c/x7Ldgs59pHzBGSY76uA6adqyChw6OGmY39g7MRUOPWbkCmCH8zpZXiHINv?=
 =?us-ascii?Q?ybv0OUsI1Td++dMB0fuxRMPDAjsV2PnjHiu/z1ZXRi9VyulTlzFrAfPmkdGr?=
 =?us-ascii?Q?paPgLSPPcbegFuyHpAFfWCDbLfDTY7jg8too69JR+PyFFrDsrKAy32CERPFj?=
 =?us-ascii?Q?dX+/abpbdNeC3n+6JrjWYL6YPlTtrryiQAJZwtnYHXXggcITwDytdLrTyC8w?=
 =?us-ascii?Q?ME1dIm4IHmBLcYn9LVZ7qmkzifsMlBagY3L/SHMX49ZoFGnM7Zi3u79ihpqs?=
 =?us-ascii?Q?p1lWeBhj+kSe0dVMPhItV3HG2RSO/7dQzPiLgBeknqy5IlpNK2ss00y3Z2L2?=
 =?us-ascii?Q?3so/5nTuq1CsnWioHCFoHQcTETckZnQibFOiKbYPY7Y7+qHUHPtdj+pCjGNH?=
 =?us-ascii?Q?cLsLa0zj375odCA9M2HbPibNnfn3Qy1UHL/m6Siik7uMLhyqxi4cfB+9jJ3l?=
 =?us-ascii?Q?xU2fM+YSZc5Fpg5P944dBMbwqTn2+AFMV6FYk2P+b4Glx1kPXabR3hT2+Jfo?=
 =?us-ascii?Q?jKqrU+l6cWB0X7vefBjaOYqUYBEVL4N1UIlus2arkNm7iaj4POXEvSXIVY4O?=
 =?us-ascii?Q?QX1nAcHgHoZOooWGxsR05kL2BLlMHIPHEDz0u+igotXnPBvo/JcTjrwjRTBO?=
 =?us-ascii?Q?+mhdZcUbhD5wl/P4SuYAnzAKzjj1YpyML4PE+rd4kkYL/GQkah0HtR8pL5Or?=
 =?us-ascii?Q?pq32f4/+CcomBIg5FzbcIg62Bg/5/VQjKMrh5OF/tK67lEC47zSX3bdMy9/9?=
 =?us-ascii?Q?i+MrzqvzQmj+OCjttdnqFn1PBANDR+7A3XGPSms0ki/nj4UUsEAuv2f+IP77?=
 =?us-ascii?Q?2u+9VemT6pERABue1YLTlPAG2J6e12ko7T5g3TNsJ1ZN43MU4rTncCEfH+xR?=
 =?us-ascii?Q?xV5imTgbL5H6u6YdzSD61skNvWkCy/ggLja2lLPJ2vLPvkjQgiCOJ44dpXYD?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f169b-e5da-4c2e-33b9-08db1b06ea6c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 10:14:32.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snOhtkV6EMpMbAIhU5TT8fHbYi542bXobi+mJ8e2x7wmhppjkd6Oqd9Xi2zLJeBicLAR8szzH1qBy0bltNBwKtgykDXhSW9HZUh7eNIdlBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 2 Mar 2023 10:02:51 +0100
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi,
> 
> On 3/2/23 09:47, Henning Schild wrote:
> > Am Wed, 1 Mar 2023 19:04:01 +0100
> > schrieb Hans de Goede <hdegoede@redhat.com>:
> >   
> >> Hi,
> >>
> >> On 3/1/23 18:02, Henning Schild wrote:  
> >>> To describe the dependency chain better and allow for potential
> >>> fine-grained config tuning, introduce Kconfig switch for the
> >>> individual GPIO based drivers.
> >>>
> >>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> >>> ---
> >>>  drivers/leds/simple/Kconfig  | 31 ++++++++++++++++++++++++++++---
> >>>  drivers/leds/simple/Makefile |  7 +++----
> >>>  2 files changed, 31 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/leds/simple/Kconfig
> >>> b/drivers/leds/simple/Kconfig index fd2b8225d926..44fa0f93cb3b
> >>> 100644 --- a/drivers/leds/simple/Kconfig
> >>> +++ b/drivers/leds/simple/Kconfig
> >>> @@ -1,11 +1,36 @@
> >>>  # SPDX-License-Identifier: GPL-2.0-only
> >>>  config LEDS_SIEMENS_SIMATIC_IPC
> >>>  	tristate "LED driver for Siemens Simatic IPCs"
> >>> -	depends on LEDS_GPIO    
> >>
> >> Since it is simatic-ipc-leds-gpio-core.c which actually registers
> >> the LEDs GPIO platform device, this one should stay IMHO.  
> > 
> > No this one is now only for the port-IO based driver. The GPIO core
> > is built under the two new switches only.  
> 
> You are right, I thought this would enable building
> simatic-ipc-leds-gpio-core.o into its own .ko which would
> then be used by both other gpio LED drivers. But upon a closer
> look at the Makefile changes I see that is not the case.
> 
> Note that with your current solution you are linking that into
> the kernel twice.
> 
> As long this is build into modules that is fine. But if both are
> builtin I *think* you may get linker errors because of duplicate
> symbols?
> 
> I believe this is why Andy asked to try a build with all 3 options
> set to Y.

Thanks. There are no linker errors so i think there is no need for yet
another CONFIG especially for the core. I would try to keep it simple
as the name of the directory suggests, so go with what we have.

Henning

> 
> >>>  	depends on SIEMENS_SIMATIC_IPC
> >>>  	help
> >>>  	  This option enables support for the LEDs of several
> >>> Industrial PCs from Siemens.
> >>>  
> >>> -	  To compile this driver as a module, choose M here: the
> >>> modules
> >>> -	  will be called simatic-ipc-leds and
> >>> simatic-ipc-leds-gpio.
> >>> +	  To compile this driver as a module, choose M here: the
> >>> module
> >>> +	  will be called simatic-ipc-leds.
> >>> +
> >>> +config LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE
> >>> +	tristate "LED driver for Siemens Simatic IPCs based on
> >>> Intel Apollo Lake GPIO"
> >>> +	depends on LEDS_GPIO    
> >>
> >> And then it can be dropped here.
> >>  
> >>> +	depends on PINCTRL_BROXTON    
> >>  
> >>> +	depends on SIEMENS_SIMATIC_IPC    
> >>
> >> This should be "depends on LEDS_SIEMENS_SIMATIC_IPC" since it
> >> actually uses symbol from that module.  
> > 
> > Same as above, the GPIO based drivers do not depend on the port-IO
> > based driver.  
> 
> Ack.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> >>> +	default LEDS_SIEMENS_SIMATIC_IPC
> >>> +	help
> >>> +	  This option enables support for the LEDs of several
> >>> Industrial PCs
> >>> +	  from Siemens based on Apollo Lake GPIO i.e. IPC127E.
> >>> +
> >>> +	  To compile this driver as a module, choose M here: the
> >>> module
> >>> +	  will be called simatic-ipc-leds-gpio-apollolake.
> >>> +
> >>> +config LEDS_SIEMENS_SIMATIC_IPC_F7188X
> >>> +	tristate "LED driver for Siemens Simatic IPCs based on
> >>> Nuvoton GPIO"
> >>> +	depends on LEDS_GPIO    
> >>
> >> Idem.
> >>  
> >>> +	depends on GPIO_F7188X
> >>> +	depends on SIEMENS_SIMATIC_IPC    
> >>
> >> Idem.
> >>  
> >>> +	default LEDS_SIEMENS_SIMATIC_IPC
> >>> +	help
> >>> +	  This option enables support for the LEDs of several
> >>> Industrial PCs
> >>> +	  from Siemens based on Nuvoton GPIO i.e. IPC227G.
> >>> +
> >>> +	  To compile this driver as a module, choose M here: the
> >>> module
> >>> +	  will be called simatic-ipc-leds-gpio-f7188x.
> >>> diff --git a/drivers/leds/simple/Makefile
> >>> b/drivers/leds/simple/Makefile index ed9057f7b6da..e3e840cea275
> >>> 100644 --- a/drivers/leds/simple/Makefile
> >>> +++ b/drivers/leds/simple/Makefile
> >>> @@ -1,5 +1,4 @@
> >>>  # SPDX-License-Identifier: GPL-2.0
> >>> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
> >>> simatic-ipc-leds.o -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)  +=
> >>> simatic-ipc-leds-gpio-core.o
> >>> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
> >>> simatic-ipc-leds-gpio-apollolake.o
> >>> -obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+=
> >>> simatic-ipc-leds-gpio-f7188x.o
> >>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+=
> >>> simatic-ipc-leds.o
> >>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+=
> >>> simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
> >>> +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+=
> >>> simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o    
> >>
> >> Regards,
> >>
> >> Hans
> >>  
> >   
> 

