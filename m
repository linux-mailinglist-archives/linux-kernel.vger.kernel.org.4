Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E46B2F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCIU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCIU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:58:59 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65CD6F2C34;
        Thu,  9 Mar 2023 12:58:57 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id D14637A0158;
        Thu,  9 Mar 2023 21:58:55 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 04/32] pata_parport-bpck6: pass around struct pi_adapter *
Date:   Thu, 9 Mar 2023 21:58:49 +0100
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307224627.28011-1-linux@zary.sk> <20230307224627.28011-5-linux@zary.sk> <6040658f-990f-8cca-eabb-09e97e09c547@omp.ru>
In-Reply-To: <6040658f-990f-8cca-eabb-09e97e09c547@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303092158.50217.linux@zary.sk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2023 21:33:59 Sergey Shtylyov wrote:
> On 3/8/23 1:45 AM, Ondrej Zary wrote:
> 
> > Remove Interface typedef, pass around struct pi_adapter * down to all
> > functions instead. Remove PPCSTRUCT define.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
>    I had some nit tho -- see below...
> 
> [...]
> 
> > diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
> > index fa1f7d4fe3cb..bc128a2c444e 100644
> > --- a/drivers/ata/pata_parport/bpck6.c
> > +++ b/drivers/ata/pata_parport/bpck6.c
> [...]
> >  static void bpck6_connect(struct pi_adapter *pi)
> >  {
> > +	struct ppc_storage *ppc = (void *)(pi->private);
> 
>    Parens around pi->private are unnecessary here and elsewhere...
> 
> [...]
> > diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
> > index 5e5521d3b1dd..f12bb019fc61 100644
> > --- a/drivers/ata/pata_parport/ppc6lnx.c
> > +++ b/drivers/ata/pata_parport/ppc6lnx.c
> [...]
> > @@ -101,26 +101,27 @@ typedef struct ppc_storage {
> [...]
> >  //***************************************************************************
> >  
> > -static int ppc6_select(Interface *ppc)
> > +static int ppc6_select(struct pi_adapter *pi)
> >  {
> > +	struct ppc_storage *ppc = (void *)(pi->private);
> 
>    Parens around pi->private are unnecessary here and elsewhere...

Yes, missed that. But it's "fixed" in patch 9 by removing this code :)

-- 
Ondrej Zary
