Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB7693955
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBLSTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBLSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 13:19:33 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1232D1025E;
        Sun, 12 Feb 2023 10:19:31 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 4AB937A037B;
        Sun, 12 Feb 2023 19:19:29 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 02/12] pata_parport: Introduce module_pata_parport_driver macro
Date:   Sun, 12 Feb 2023 19:19:26 +0100
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211144232.15138-1-linux@zary.sk> <20230211144232.15138-3-linux@zary.sk> <2e8b5e5b-6e7d-471c-74aa-1c7debebef0f@omp.ru>
In-Reply-To: <2e8b5e5b-6e7d-471c-74aa-1c7debebef0f@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202302121919.26401.linux@zary.sk>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 February 2023 13:19:28 Sergey Shtylyov wrote:
> On 2/11/23 5:42 PM, Ondrej Zary wrote:
> 
> > Introduce module_pata_parport_driver macro and use it in protocol
> > drivers to reduce boilerplate code. Remove paride_(un)register
> > compatibility defines.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> [...]
> 
> > diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
> > index d897e2a28efe..3c358e66db25 100644
> > --- a/drivers/ata/pata_parport/bpck6.c
> > +++ b/drivers/ata/pata_parport/bpck6.c
> > @@ -245,23 +245,8 @@ static struct pi_protocol bpck6 = {
> >  	.release_proto	= bpck6_release_proto,
> >  };
> >  
> > -static int __init bpck6_init(void)
> > -{
> > -	printk(KERN_INFO "bpck6: BACKPACK Protocol Driver V"BACKPACK_VERSION"\n");
> > -	printk(KERN_INFO "bpck6: Copyright 2001 by Micro Solutions, Inc., DeKalb IL. USA\n");
> > -	if(verbose)
> > -		printk(KERN_DEBUG "bpck6: verbose debug enabled.\n");
> 
>    Hm, perhaps should've been removed in a separate patch?
> 
> [...]
> > diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
> > index 6ce2dee7657f..eb72bcd0c8da 100644
> > --- a/drivers/ata/pata_parport/epat.c
> > +++ b/drivers/ata/pata_parport/epat.c
> > @@ -327,12 +327,12 @@ static int __init epat_init(void)
> >  #ifdef CONFIG_PARIDE_EPATC8
> 
>    Hm, this is now called PATA_PARPORT_EPATC8, no?

Yes, it's a bug. This compile-time option should go away completely.

> >  	epatc8 = 1;
> 
>    Seems like a dead code?
> 
> >  #endif
> [...]
> 
> MBR, Sergey
> 


-- 
Ondrej Zary
