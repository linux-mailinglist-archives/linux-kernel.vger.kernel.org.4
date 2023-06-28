Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DDC741057
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjF1Lrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjF1Lre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:47:34 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBE72D73
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:47:32 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b73741a632so3291217a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687952852; x=1690544852;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqXHGBqKxlgkWmLDRd9GTKbx3UAhvwTpUadWyVXxc+U=;
        b=jF/YUrLEBqH15ntdhAQZbW/4ZWmEtFMkC5wNfTlau4HfB9upEgvLb5aoA91uCrHHYW
         kXBdHXiNPbV+MevEWFjnHi0XekhK9TOrgRhezitVwmnHlS5SrQ0GqJoOY0sNi+Jxp/sp
         TnhhtO185oUB+WxC8divhj7TIiS7MOMU0OwI9PBbp0BQGq/4BkcDQgkprRJeLc127g5i
         FSpjF77N4BxZ8ahh4wmDBrn+jUckkzqyXUFB/SaeKQRCvnBpoXB+2zgnj29EEq9rmGt/
         FBfxzlkprxOFPEN/PZx1KRs1S87laMVlGEcEWyo2wcvVfVvra143d19wvVTl7rLc2lmX
         zWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687952852; x=1690544852;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YqXHGBqKxlgkWmLDRd9GTKbx3UAhvwTpUadWyVXxc+U=;
        b=QNhzuEw/Ps6Hpj7w64sh7i/HpED8vhPKWicRqCRCvw8Gru+lrDVoP5flOwPbM1LLaG
         TqLhxZpBDOfRfK+hMjYIlpzmrjGtr2KCBcMylho6UDJfJfnq0qSnc4a+DAOf63+seUqe
         sjDLiQAz4JKWB4duhz16HJgtlPwV4N/+hrLqlG0Noe1GKqRsnOr6955LSRzILyWSg4NC
         punJOXj23wFkTHRkICB6BxvT4ESD5VHZ8DymLunp61z2cyHCzH7iLgydADC9TzXaeXu+
         m9YBYLoTv8YV0GdmOZRCDPmGvTvugN8t+w3cz3HpmMMt+c3Aq0cAw3Bm5m84Ca1fn7/4
         pQZg==
X-Gm-Message-State: AC+VfDwAIW46oef69dplaAtmS6oqKhxqmwPSeghe6C71jbvJ8LAntd+c
        LujDz4JwjjT89VBFrJ/LoA==
X-Google-Smtp-Source: ACHHUZ6wbZ4nBKIip3Y9SIKMzwvdkhB4f9wjgS9rpDaCP5klHMNLClhSBc/pLTsVW3OHdgjNmij3YQ==
X-Received: by 2002:a9d:4d12:0:b0:6b4:5ed3:8246 with SMTP id n18-20020a9d4d12000000b006b45ed38246mr28019494otf.2.1687952852062;
        Wed, 28 Jun 2023 04:47:32 -0700 (PDT)
Received: from serve.minyard.net ([47.184.186.55])
        by smtp.gmail.com with ESMTPSA id e2-20020a9d63c2000000b006b8850ad193sm55218otl.56.2023.06.28.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:47:31 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:1e76:1406:a469:4f70])
        by serve.minyard.net (Postfix) with ESMTPSA id 06A62180044;
        Wed, 28 Jun 2023 11:47:31 +0000 (UTC)
Date:   Wed, 28 Jun 2023 06:47:29 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: Re: [PATCH] ipmi: fix potential deadlock on &kcs_bmc->lock
Message-ID: <ZJwd0UDKYcK9AvSf@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230627152449.36093-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627152449.36093-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, this looks like an issue.

Andrew, any opinions on this?  The attached patch will work, the other
option would be to disable interrupts when calling
kcs_bmc_handle_event() in the timer handler.  But then you have to worry
about RT.

-corey

On Tue, Jun 27, 2023 at 03:24:49PM +0000, Chengfeng Ye wrote:
> As kcs_bmc_handle_event() is executed inside both a timer and a hardirq,
> it should disable irq before lock acquisition otherwise deadlock could
> happen if the timmer is preemtped by the irq.
> 
> Possible deadlock scenario:
> aspeed_kcs_check_obe() (timer)
>     -> kcs_bmc_handle_event()
>     -> spin_lock(&kcs_bmc->lock)
>         <irq interruption>
>         -> aspeed_kcs_irq()
>         -> kcs_bmc_handle_event()
>         -> spin_lock(&kcs_bmc->lock) (deadlock here)
> 
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
> 
> The tentative patch fix the potential deadlock by spin_lock_irqsave()
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/char/ipmi/kcs_bmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index 03d02a848f3a..8b1161d5194a 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -56,12 +56,13 @@ irqreturn_t kcs_bmc_handle_event(struct kcs_bmc_device *kcs_bmc)
>  {
>  	struct kcs_bmc_client *client;
>  	irqreturn_t rc = IRQ_NONE;
> +	unsigned long flags;
>  
> -	spin_lock(&kcs_bmc->lock);
> +	spin_lock_irqsave(&kcs_bmc->lock, flags);
>  	client = kcs_bmc->client;
>  	if (client)
>  		rc = client->ops->event(client);
> -	spin_unlock(&kcs_bmc->lock);
> +	spin_unlock_irqrestore(&kcs_bmc->lock, flags);
>  
>  	return rc;
>  }
> -- 
> 2.17.1
> 
