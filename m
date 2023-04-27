Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09B36EFE86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbjD0A1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242821AbjD0A1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:27:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FB30CD;
        Wed, 26 Apr 2023 17:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9h4qyusjM/MHvi8CSwF19t8N7fhbau+B6ed2MjrbUDQl6PS2hjGFUTEsPrlnqnlHgKPiRpHlfZMD5K/DP634QiPaBzjMKz5QrrmJugk66EPkiYha0MAeoG0frR8K+StCuC3natVzeXnVdPWS/JA7cKtIkZ1Bw+Tvvhi39guyFjLADw+ujr33m5c/RKUa659/W/BeDLdS2eCTlwFfWh85VEozibp6qwuJzC1Vg6PtupaotShsAa0bu7Iu6oEfZ0kL/wm1z5p+YGJMBjE0DZTYdRJNm2N0btO0H+kwCipMa6g4+OgDop9O8kRreEInikxtVrUlbfXv2ibVN3PtXmPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbe5Fv1Ltpa0z8vwDOHdrIu+6/sOd3G8y/emkNIJoF4=;
 b=NeJdxVT4NWrdGJh2rbmeHC1OaYSe2TyXC/N9z74Q68xgVqJrAavzU6oHkLdO2uUIrjGB1KVI3IwMsqISriWfF11VTWFhXpyegZPqMhzulbF1AoqQeJ2nULcC669qm4G8rKCXF6HiZBJyeZ7sI/2rFUEro/VM54y+YjTgAQ20qjg77I1dfGg8QyzUeUN+udUKx3HCIoTwxKWoV4uqKWfiY/ufmuokvpDMFsODzCoqyX1MZ8mc6o4R7lWgPfe8MFC0S1hMzZcFjpJfzdyPzAwZ7VjVdGH1RItGmXnKqkA6ysYAV7yGU3MuALwOzBOfhVGLspEoZUFOKg7vyTDS1rKGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbe5Fv1Ltpa0z8vwDOHdrIu+6/sOd3G8y/emkNIJoF4=;
 b=QNG5jQ/IMuNW5+4F8xgT+6SzWz1MHbkr/giWdt4u5JQqBilJxb0XPxqDPPl27+Sj0HbVu8hhtJAOGClagGYAyUE3srLiBnv651l+Sj43yvjOVRgwftEVoLNt8uAN+dt95T+91MqYa4r3cUfbYC4RfG1N2toS3TJog5YoxrLHSds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com (2603:10b6:4:7c::37)
 by PH0PR08MB8274.namprd08.prod.outlook.com (2603:10b6:510:16c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 00:27:22 +0000
Received: from DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc]) by DM5PR0801MB3767.namprd08.prod.outlook.com
 ([fe80::20b4:97da:18df:16dc%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 00:27:22 +0000
Date:   Wed, 26 Apr 2023 19:27:18 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZEnBZs9VYxriT1Or@nixie71>
References: <20230425130054.591007-1-tomas.mudrunka@gmail.com>
 <ZEf0RYdD5jhE9JEk@nixie71>
 <ZEmwsViIjUVPZ4Cd@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmwsViIjUVPZ4Cd@google.com>
X-ClientProxiedBy: SA0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:806:130::14) To DM5PR0801MB3767.namprd08.prod.outlook.com
 (2603:10b6:4:7c::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0801MB3767:EE_|PH0PR08MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e1187f-b5da-473b-585c-08db46b62ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnfBoAvpKgB43voXAM3bZBUfZDoeWSL96Hf4lV3+z9pi/pmvdxoObee/cI0zix81OJdCn/PVyZ9NMR5O8baqS9QHxC3MGVjqD9GCdPY8zOJ9ON+1NRLjcBWgfDA4JhAXhkP6kAp9q3hpIqmTpmNtOpDaMLDo82uDthPCc0wHZjrYrw/xfiiRv8o5zyeHByyCtEBmobYCf9SsAS8T6dPlRDiLSRIJUf2vhKmjUrHtjMxiPkPWMBciYk9B4cnFHFZQTrrglUiDbpTs3wbTO3I3vIh6FtrBNAPuWtWOi3gM10ZJrR4E9Q3Jwevf/bo65Pztso4zbzDyqFBbZzUL4fVyk35xXP4sNT46buFiX4J44PlybH9h6S2wHuXRfPxld/K2nvsZPvGKrIl76fXtS2JKjzgcUbNayE8GUXpfCAzfvCQvd2Z4ICgdH+ad3lmT/EimQX2vB40FFo+6InDUShrEqBE8QiL41iXPFFgvL/aO2sVs4Xm+6LBYoVQAX5jiNOgXg0Av/T/qJYJ1kNdRXAlOThqHnMVRI5jdvZ08sqctCGOL+WjgBoDhoV7vaYLb8Am+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0801MB3767.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(366004)(136003)(346002)(376002)(396003)(451199021)(41300700001)(66556008)(6916009)(66476007)(478600001)(66946007)(8936002)(4326008)(8676002)(316002)(38100700002)(5660300002)(186003)(83380400001)(6666004)(6486002)(26005)(9686003)(6512007)(6506007)(33716001)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xkW0GQJMgJzZfVSYp+thbmzaRD7PZxg8ISkEcLsSvnvQpvdwhxqxCsd110SG?=
 =?us-ascii?Q?sfu4IwYtWRUWucPbJi3kzXVu4Gkdl+CIjBtgCDT2PI6OgHm3vrllI9eVY5pz?=
 =?us-ascii?Q?2rSXnpIgcv02ea/mdr2JLVa7c/tPfjYR6Cv6YdE4/CqPPNCVhq3aaZbx2UFs?=
 =?us-ascii?Q?mfm7Ut8CrAvkuG7D6zmvui3UvGRMkuW8A0E3gpMJJ3mNKPf6h217jBIkunHn?=
 =?us-ascii?Q?6OUU1TiJb2Jn1hIcVoJ7ugFPItVvfWIUXwhQ9/TIlY03h4oAgXTZst6lo+ut?=
 =?us-ascii?Q?RVSml63FioCSbICSsp9GJSZA8Nn5VeR4/x7o1CSXpcy1SgXefdWj6AWZ0Uqa?=
 =?us-ascii?Q?r6qYIJzpXOCgDvFgpyggswCHaphYFw2hlNF5WNfjD/ltbqo0Zf/J5DdCe0Ys?=
 =?us-ascii?Q?CZMCwWl0FjaduIUaFg4krLdQn9dt9MGDsuX1M887q2yNYy6Kj0O1CkGCl2W+?=
 =?us-ascii?Q?yZOBmup78951jWPE1WlnL2KzzwdM4jAw/XN5+0LIEFDWg52nVwvISCGZ5kao?=
 =?us-ascii?Q?XeHVH/jO+S8eyJNpk4+JUUrMSHn9lSVXICj7zJ6Yk+IKcEU+DVRdYnpBZJEr?=
 =?us-ascii?Q?OWXWoG0n339QPJ7tBI6I4D5eyaKCnvSTHgAxOvkq1/LC8gHDnlmTb12XcDAY?=
 =?us-ascii?Q?ERI77nVSVqtEmUeMxmqkC27FQCl8m0k9qGqPH35e3uFuDXd4O62nPA+c/RBl?=
 =?us-ascii?Q?AgMtcW6mI5vJLEM4ui7goa3ySLAPipE5N/kT3WbXbe6DXeWMCbrHyGpQHCdX?=
 =?us-ascii?Q?Vsz0n7Jv+3zjCE8/V/uMTUmGjSIfFYK+a6Xe7lJHmRStmtQEnKc+I/VMAOJL?=
 =?us-ascii?Q?Oz8F6KpWcK/7hEbSIDyxP3CCrJFbAkDueB5+gLuAdXmDsLB6lUypoA0qcWLb?=
 =?us-ascii?Q?xEKDMyGiaAr3MTPP48xhMgfJoXGoQEaMOuEl8m9Q0s2YJOL+D9jA08usLu56?=
 =?us-ascii?Q?5bmMDDroWYSiV3JbxhnNzJf5aHJjMlDwm7dYjxyYJhdR6rUOCC4hFJ8MD1hd?=
 =?us-ascii?Q?RaWwWRO3ZOhP1eKUvEjC9kk78LJVduOK0fe/JbvDwnypV0md5bi8WdMA4ocl?=
 =?us-ascii?Q?PeCYik1QIB5m9c+mBaf78+/wempHiuvuFls9ieD4CQNAs0+0YtHlh0bfjHM1?=
 =?us-ascii?Q?Q7ZqMxZkvPk/OXEe0ti9SSrA110hfSkWJAwX6YRkY4iFIF5c7R3G2pvigGPG?=
 =?us-ascii?Q?N6SVH24wa9M/FD59q6Mbyw99vvpDQ5VgZZwh43VgLd1ltlH0V3Q+lhUkqFZd?=
 =?us-ascii?Q?5XEECeDYRsMyz9/vqjONZs51uNiGMsc+sSb3P6nZakEhW8uC8TjgrR76uiGO?=
 =?us-ascii?Q?AgFpLE9hBYRomWb8qLa+NDNxpQIAB/H/1X8Lt/FXoxcFghdaYoWBL7f5CNO3?=
 =?us-ascii?Q?m3SVikDlOELu/Z8KQMUzuWTATW1Nj7O9BS6jGHKn+cTVQ9xpJbSy3kVY96b9?=
 =?us-ascii?Q?xo50dtaOv0MzW5lFvTblr6/drvEcoU34JmW9gZwT+af/y7wIAFNTmTy64mIq?=
 =?us-ascii?Q?dEH9mnY2HDhnt0Kf0Ivu98wicqbru+LmCTOzDpZBiT43VcRC1ArbwH4Sv0JK?=
 =?us-ascii?Q?ir8yKtmKWiQdthojyIqC671y5XCdtXiQ5DKVcXsU?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e1187f-b5da-473b-585c-08db46b62ad2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0801MB3767.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 00:27:22.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThjBGyWe2v4jX4+ATKxubooDqXLQ22XgOscAY6s4IcqZss727w20/dqUjH2rM4W3M75+JyM2tu3oJNmFCBMkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB8274
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Apr 26, 2023 at 04:16:01PM -0700, Dmitry Torokhov wrote:
> Hi Jeff, Tomas,
> 
> On Tue, Apr 25, 2023 at 10:39:49AM -0500, Jeff LaBundy wrote:
> > Hi Tomas,
> > 
> > On Tue, Apr 25, 2023 at 03:00:53PM +0200, Tomas Mudrunka wrote:
> > > LM8333 uses gpio interrupt line which is active-low.
> > > When interrupt is set to FALLING edge and button is pressed
> > > before driver loads, driver will miss the edge and never respond.
> > > To fix this we handle ONESHOT LOW interrupt rather than edge.
> > > 
> > > Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> > > ---
> > >  drivers/input/keyboard/lm8333.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> > > index 7457c3220..c5770ebb2 100644
> > > --- a/drivers/input/keyboard/lm8333.c
> > > +++ b/drivers/input/keyboard/lm8333.c
> > > @@ -179,7 +179,7 @@ static int lm8333_probe(struct i2c_client *client)
> > >  	}
> > >  
> > >  	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
> > > -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > > +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > >  				   "lm8333", lm8333);
> > >  	if (err)
> > >  		goto free_mem;
> > 
> > Thanks for the patch, but this is a NAK in my opinion.
> > 
> > First of all, we should not be hard-coding interrupt polarity in the
> > first place; that is an existing piece of technical debt in this driver.
> 
> Yes, I wonder if the original hardware was limited to the edge
> interrupts.
> 
> > 
> > Second, changing from edge-triggered to level-triggered interrupts runs
> > the risk of creating an interrupt storm depending on the time it takes
> > the device to deassert the irq following the I2C read and the point at
> > which the threaded handler returns. Have you measured this?
> 
> IRQF_ONESHOT ensures that the level interrupt is unmasked only when the
> threaded handler returns.

Yes that's correct; what I mean to say is that depending on the nature of
the read-to-clear mechanism in the part, there is a chance that the IRQ
has not been deasserted by the time the threaded handler returns. On some
devices for example, the IRQ is not deasserted until some time after the
read's stop condition.

For these cases, I consider it best practice to measure the I2C and IRQ
lines on a scope and if necessary, add a small delay before the interrupt
handler returns. This is especially true for open-drain interrupts that
may need a few hundred extra us for the pin to rise.

> 
> > 
> > Can we not simply read the interrupt status registers once at start-up
> > to clear any pending status? This is essentially what your change does
> > anyway, albeit indirectly.
> > 
> 
> Thanks.
> 
> -- 
> Dmitry

Kind regards,
Jeff LaBundy
