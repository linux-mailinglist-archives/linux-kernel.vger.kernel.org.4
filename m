Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F876B6BC3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjCLVYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 17:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjCLVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 17:24:39 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E993D2D164;
        Sun, 12 Mar 2023 14:24:37 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 152047A0158;
        Sun, 12 Mar 2023 22:24:36 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] pata_parport: fix possible memory leak
Date:   Sun, 12 Mar 2023 22:24:28 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202303112239.21234.linux@zary.sk> <20230311214447.7359-1-linux@zary.sk> <8b0eb4d0-ca10-35a5-a74c-fd0f7d11713c@opensource.wdc.com>
In-Reply-To: <8b0eb4d0-ca10-35a5-a74c-fd0f7d11713c@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 3837
X-UID:  12
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <202303122224.29035.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 March 2023 01:56:25 Damien Le Moal wrote:
> On 3/12/23 06:44, Ondrej Zary wrote:
> > When ida_alloc() fails, "pi" is not freed although the misleading
> > comment says otherwise.
> > Move the ida_alloc() call up so we really don't have to free it.
> 
> Certainly you meant: "so we really do free it in case of error.", no ?

I meant "so we don't have to free pi in case of ida_alloc failure".
 
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> > ---
> >  drivers/ata/pata_parport/pata_parport.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> > index 6165ee9aa7da..a9eff6003098 100644
> > --- a/drivers/ata/pata_parport/pata_parport.c
> > +++ b/drivers/ata/pata_parport/pata_parport.c
> > @@ -503,18 +503,19 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
> >  	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
> >  		return NULL;
> >  
> > +	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> > +	if (id < 0)
> > +		return NULL;
> > +
> >  	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
> >  	if (!pi)
> > -		return NULL;
> > +		goto out_ida_free;
> >  
> >  	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
> >  	pi->dev.parent = &pata_parport_bus;
> >  	pi->dev.bus = &pata_parport_bus_type;
> >  	pi->dev.driver = &pr->driver;
> >  	pi->dev.release = pata_parport_dev_release;
> > -	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> > -	if (id < 0)
> > -		return NULL; /* pata_parport_dev_release will do kfree(pi) */
> >  	pi->dev.id = id;
> >  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
> >  	if (device_register(&pi->dev)) {
> > @@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
> >  out_unreg_dev:
> >  	device_unregister(&pi->dev);
> 
> Same comment as Sergey: isn't this going to do the ida free ? So shouldn't you
> return here ?

No. device_unregister() calls pata_parport_dev_release() which does only kfree(pi), not ida_free(). But it probably should do ida_free() too.

> 
> >  out_ida_free:
> > -	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
> > +	ida_free(&pata_parport_bus_dev_ids, id);
> >  	return NULL;
> >  }
> >  
> 


-- 
Ondrej Zary
