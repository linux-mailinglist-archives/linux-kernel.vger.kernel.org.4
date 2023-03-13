Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505876B7089
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCMH4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCMHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:55:23 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A5EA132FE;
        Mon, 13 Mar 2023 00:54:05 -0700 (PDT)
Received: from [192.168.1.3] (gsystem.sk [85.248.217.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 10ADE7A0258;
        Mon, 13 Mar 2023 08:53:25 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] pata_parport: fix possible memory leak
Date:   Mon, 13 Mar 2023 08:53:21 +0100
User-Agent: KMail/1.9.10
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202303112239.21234.linux@zary.sk> <202303122224.29035.linux@zary.sk> <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
In-Reply-To: <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303130853.21446.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2023, Damien Le Moal wrote:
> On 3/13/23 06:24, Ondrej Zary wrote:
> > On Sunday 12 March 2023 01:56:25 Damien Le Moal wrote:
> >> On 3/12/23 06:44, Ondrej Zary wrote:
> >>> When ida_alloc() fails, "pi" is not freed although the misleading
> >>> comment says otherwise.
> >>> Move the ida_alloc() call up so we really don't have to free it.
> >>
> >> Certainly you meant: "so we really do free it in case of error.", no ?
> > 
> > I meant "so we don't have to free pi in case of ida_alloc failure".
> 
> That is better. Please rephrase the commit message to this.
> 
> >>>  	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
> >>>  	pi->dev.parent = &pata_parport_bus;
> >>>  	pi->dev.bus = &pata_parport_bus_type;
> >>>  	pi->dev.driver = &pr->driver;
> >>>  	pi->dev.release = pata_parport_dev_release;
> >>> -	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> >>> -	if (id < 0)
> >>> -		return NULL; /* pata_parport_dev_release will do kfree(pi) */
> >>>  	pi->dev.id = id;
> >>>  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
> >>>  	if (device_register(&pi->dev)) {
> >>> @@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
> >>>  out_unreg_dev:
> >>>  	device_unregister(&pi->dev);
> >>
> >> Same comment as Sergey: isn't this going to do the ida free ? So shouldn't you
> >> return here ?
> > 
> > No. device_unregister() calls pata_parport_dev_release() which does only kfree(pi), not ida_free(). But it probably should do ida_free() too.
> 
> Yes, it should, otherwise you are leaking the ida with the normal (no errors)
> case. Care to send a fix for that too ?

Yes, I'll send it as soon as I fix a problem that I noticed during testing. The ida is never freed with this fix. And neither "pi" because pata_parport_dev_release is never called (confirmed by adding printk).

-- 
Ondrej Zary
