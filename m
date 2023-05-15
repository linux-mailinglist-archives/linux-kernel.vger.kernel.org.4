Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D7702ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbjEOKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbjEOKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:42:06 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F663DF;
        Mon, 15 May 2023 03:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8gZ6HycCZnsabsORxYfQI3rhV/yDIPftqLktKTTzWyYvFzYOy9n8byuWlM8LQhQgJ5CJgMs+fMZdwxvAEjdCOx3EKYzo+Aqynw+saZ9STE572632jCT17XkxiqdNqiHS8d+i+kO9fTmCdyvwNJDCH2jPyDGw2SqVloSqO8DKmYbT2+07/aeWhkr/8ZVMDRTJbrGkhXfD1gb92eQ6WN0sTWdU2vpLVPXs8+DUAxzNi40VptRkcnkNQd2fcb/DlUSopzv7z6dsAaaGCjWDxfJselCj+nGtyimdFlLfd8sl6LREBw+4F/tRQ2m8HKNmhCC18iGtJqkNbFj12Dv0tLLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlczWTaLQrWOr1ylgMCRZEvkSbGlZd5TA4686/QwwcA=;
 b=kBuh75oYjZEnTKFk0TZ9Wl6SxJeeKdRsB93saDznNFOjvg2prxyUhAZK4U7+DwyYq+/TovJfVZ/ebhhFQ0sSey3aDSJZh5LGihZ9hHXsRj9O8uyGZFe8li5/veVi8qQSt/zeigdo+S3iGUE9TD4wCGfu4y4LVKryqc3nDjvcKcZCIv3QrAqyccJ0zkmCeoUTBRRGBRLVaGtX0d42q0ATzMi/4ygpWGT7kKrIOlcyuTb5kUcfmL9a0/htUICK1oIx/d+VyA3BmwMce/lQOzphOenSd979irrCwAY40k88dyo/+LYi1D2jp6iyNqqyhHicoGUoWkSwxcZ/l+4oXSwPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlczWTaLQrWOr1ylgMCRZEvkSbGlZd5TA4686/QwwcA=;
 b=kk1F391OXyY5MnQTQGNDTuXBgiM9zksgHlqa4hZtuMg3X0qduQe1zhmzFQB5E/dOTdyzQL6HQ2Lrue8tQcUisWQvnI6EmBjZAkw9gQgOj3F/20+MNUtcN2RB0MJrrcCvcnklpedl1KSZc+8Hi3nEVpX/Zimn8zAmkc/IHHIjv/nAexedO09oenCSM98kDMGVisoXOx5Hm4GaW6e2xg8TMOTyUHzVuKSo/8ZpHJatkpt6NBott/cae77IXNqou9yUAkX6rLQ5U5KllWA9qY3RH7nYcwQlkW8LU9mP63y7/UFYlIaFTgokycZYswUFTIIqFg6r1pTRbEI8HCPFmUcKlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM7PR10MB3158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:42:01 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aa98:fb34:754f:8958%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:42:01 +0000
Date:   Mon, 15 May 2023 12:41:50 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 3/3] leds: simatic-ipc-leds-gpio: introduce more
 Kconfig switches
Message-ID: <20230515124150.7ffd6c81@md1za8fc.ad001.siemens.net>
In-Reply-To: <bfa3ede3-8cc0-ca6c-8e88-17e374aedcb6@redhat.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-4-henning.schild@siemens.com>
        <a6281345-95e1-3e8d-b6fb-146c1852373f@redhat.com>
        <20230302094728.563c04ce@md1za8fc.ad001.siemens.net>
        <bfa3ede3-8cc0-ca6c-8e88-17e374aedcb6@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:610:59::38) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AM7PR10MB3158:EE_
X-MS-Office365-Filtering-Correlation-Id: baa97d52-96a4-4ec9-9153-08db553103b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWSrf+Tc1iNANfAsPtjXrn9V8KyWUMT8eEAx5yqOqO5cclf6e05bspcBV8lj39AFJjH25Jk6/8xo2RaewrmTs7ae0teoJeDSHjoWo5GIufooJnXbepNuRvTdlkl6FparzG9w0E7SInbER97u7/dRAR3VBLkmkqdc9jI0uwCGPRtx2UUKarR04ck2PEVqS1EhqYvjyqv/fKGewDoh/VvN979fAdJDdmADGT97k8CA44Pgldtvwrf9lt0HTkV0Z3glZqIHiGwfDLcAnIxA/sREUpHEHqPsQyAmjxZy99nixo4F6h+Eqf7wSItTjl5Y8ROD3/+rLkt+vMrslJ76EQnMBjyljare5geG193ABPu5Iq0zt0C/EnmydVsBWQ3+AJsnYfZoyvp4RXj4PACNAobDdk4726To7Uo246hQp7ZahhpfPAZ8ZLG6DrVbm619a/E0UtU0eGoEK/q6Hwv/KcDdW9/4DQCzswlLbUbo6Uj/A39l3hbc/NfyO1I0ThZ9EETWz+ei0Vb0ARGHvnZY00TNRmUyH1W/hAKP4emYD5RM8vGC84ZipH29ou8WiyXO53kO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(86362001)(54906003)(316002)(66556008)(66946007)(66476007)(4326008)(6916009)(478600001)(6486002)(5660300002)(8676002)(8936002)(6666004)(2906002)(44832011)(38100700002)(82960400001)(41300700001)(6512007)(1076003)(186003)(53546011)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VkBB1LhGd4rjulz32+ZScf/ywOwfyI1JTa/76caJHI9+XvbZrPsfavvGrR37?=
 =?us-ascii?Q?7gIC86qZ4VqbcWb0eWhDXbjrikwqa+3LH1xXfL8rm3azp66dU30ulvgHCVtk?=
 =?us-ascii?Q?gR21XdDt0CqqQdE/uuQZdEC8gdQrMBYRu3BO9C/B+cdzr+z9BNUR/25qYQJh?=
 =?us-ascii?Q?sGIefvvwjbxSQcjws22v4Clh9l/2GBW52hN5OeP2IR/whG7DHmjlLi+/bUp4?=
 =?us-ascii?Q?rrb4xR9UaQuXzpCLcv9aA/OhYOBT2HQxLiUqe23Edh5gE4TbBISdeyLQ2P1U?=
 =?us-ascii?Q?lJRudf0uF41wBHACsc6Fl9eZLJC4RMdZLAZphJlnoSUn65wYFy2TvXcNDB5t?=
 =?us-ascii?Q?lISVis5mtSzqacF1xnwpd+qRNULBrMDsVh4J1BhW7aVWb0q04zyoFUytjFdp?=
 =?us-ascii?Q?qbbimLUg4flHdKOq67Eo3gKnMctoH8B+ERupBGOG4o+M5KrqzAimocoI5612?=
 =?us-ascii?Q?1CaPydAClhmr4c+NrG1SH5Bj8pjwMZFcfDUu2JznFk9qpgZN5yKTKsy0NuGp?=
 =?us-ascii?Q?t+wYvk0bhzBRUWDe3jKiy5B9xTqLZl8cPYg93FidRS07qaUyJ1trjjEZ65ub?=
 =?us-ascii?Q?5AkZquqfMNOy535/MGEMKwYirNaIb2NmUxgkFH7LZ/Jjvd4/I2Xuww0wgDQ+?=
 =?us-ascii?Q?ypCuF6KHbMnK5PnpGsFV41K8ql8Zy/bk5xgEYc+PScb3IkJ7NRj9D3DZlqDZ?=
 =?us-ascii?Q?C1KUugvW1ybVddlEP2M8CmNjMWqiSZomKySDd0R7+5uOUSuU1lTkocg3lpZw?=
 =?us-ascii?Q?L1ECFGgkCO1VR3Xg7MUZJJ9LMnHzj8X7SIBXOJFnh/mmA0q3Zdex848RnfOB?=
 =?us-ascii?Q?OyrFXx5ZuVTamnfyN1d0vCoRFU6rO0RXrbmwVHLusvqe7oSIYpUxl+akTKHx?=
 =?us-ascii?Q?iCn6nxXqsS8rOtBzfajeVwNxxzWLMTBGOBK8c5plziUu9MgqPRQ41H8nH5+3?=
 =?us-ascii?Q?dp59aXqrjNVD8TFuQwolkKsogl6nR+5vt2NDtYz6OrsZ7+jpIn0kUkzTlFKh?=
 =?us-ascii?Q?qOKTX28v/sFj6RNL+FaoNn26CfYQyMWJrTz4lA7x3Q0pDb4oQtZse1CAL0Kq?=
 =?us-ascii?Q?pcugVfbWp1YyfyCYTnlsbsyYolEMWl3ZGEY6ZF/9YNEm4ScAvVPDK78InViV?=
 =?us-ascii?Q?7awlt3qeXVtcCXgRi4gr80c5rzyjooljMtn70Yza6exQh8lmTASRLM3N9386?=
 =?us-ascii?Q?6mkDRqleokV/okOQusMHDacKOMV+zFp/WlqBX1OEwIpxi9ovldYzbRixCar+?=
 =?us-ascii?Q?ftG/omrl99KKU3B/ohrtiJBOSkUZF4quYCrGedntBd82AL9TmiR7Qr5u+MdU?=
 =?us-ascii?Q?xama+5i9xtODBrh80S56jY0amYdAVPr9RFFKECkmsZaGtfX8uQHJR/g1LUqM?=
 =?us-ascii?Q?xI6zk3jVsC+GIACcgDF/urX1kTSOpyOFbr2nZgSWPUeyXH91hBD8tKQECsf/?=
 =?us-ascii?Q?Zkm4r9YL77Xr12NqQFSROKUObRbSOQh1uLDcRgg8IOqTkrwZMM2a2nWqowtl?=
 =?us-ascii?Q?0cR81tB9YmXNJvRonAklpCeOcRCDu+6jNLPY/iB8/C6IzMkFbbgIw8dDFieP?=
 =?us-ascii?Q?nA0cFDfrlyzoh46VMKLES4fXlfoWoABqwoLIJR1X/9WoMvJYX0wkITbwMSc6?=
 =?us-ascii?Q?eQNFClMr5sXUuG+zwy6Johe6Y2M2ujmn/ffrXMZCiLGMYWJDD2D6drQhhaUG?=
 =?us-ascii?Q?cSPsAA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa97d52-96a4-4ec9-9153-08db553103b2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 10:42:01.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8x4Ppu9Tfp2v+8cIcMxzzXy0Id8HwNN7nI2yxsZSv22NWGiOfoqqyQOtmlXm3RxTD72tWKDbQuHSIWByW8oxsYVmBK23wgEuu8kwAwqyXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Hi Hans,

> Ack.

was that for that last patch or all three of them? I am preparing a v3
which will include ACKs, i will have to assume p3 only because it came
in reply to that patch.

regards,
Henning

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

