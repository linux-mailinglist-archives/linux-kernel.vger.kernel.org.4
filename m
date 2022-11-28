Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC963A321
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiK1Icx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiK1Icv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:32:51 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A15F71;
        Mon, 28 Nov 2022 00:32:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jn7so9442366plb.13;
        Mon, 28 Nov 2022 00:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yY7Oi7Q+vFyDBFAWCb+IcfZ6FtGwdbwGt/6v7B5GYzU=;
        b=hcWoRfS2gOudUnbXgGWIzl+xV+YgDfqm6PZSSRcmuzYy3aI2BehE0rvpF+sUJtYJ4x
         YuZ+5KUigkzHwWui9UzgYMBprEk2/1CQtCtURqIsJMVVKvnGnGXvq4dQakmI4upqJXGW
         mLjaRkOsSTMm5p0DveLQ2PgKDgXUoF01rgywFtQAoX/5o6qq0bYSUwcaPa8KETQeFKeZ
         eZH34oApT/dU4MRum/LC+I1KWiv6yB+2HyoEt5SRqfRMqrpc5bXfYadeeUuZ5TF0BMZa
         p0yxexAbKksA+J5bsgZmYy1GOi/Hm8E0t4Ptvsn3tejn+Q3HZVC+Cmpp+TpVh9RiRLkf
         om8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY7Oi7Q+vFyDBFAWCb+IcfZ6FtGwdbwGt/6v7B5GYzU=;
        b=vi4tSN8GkBKVI3y8zTrXJXfoKAvoqy+GSXq/owqEgSJBJ4Ba2VGJjgn7bHeCgdy49i
         zyutMrUzxDGOfggNcW/1N/j9Ay5+SlPIgM7XC1GpTF8WL2ipmX4vEKyLcifRp4Uuli4z
         eVfhFsJjzNUeV5UBdUqZidWEG/AiRNSZVhyAfeu7CsnDFjTduawBNjxR3KjhHY2cwoCN
         FujodOE/T3o4O13skDUgITwuavsvnN3I0MMve0+hutJz7e7YzHq2UiBbUAnBPiF7WWbn
         kQ6LprpxLfTr2n5SvguDwnABri1I8S5bwOyhQR7+jUaxJWHL36qsSHrktbqTEno8mdFX
         lgSw==
X-Gm-Message-State: ANoB5plkri6VFpFdSf+QVoZBIA2/8mZMn/GFO8ZJfjnzBYuonaefdtCJ
        ElTnl/W2tJVVN8F/43Biop8J8pspAR3p
X-Google-Smtp-Source: AA0mqf5eFCjmFHq1U5v/UF4eA09aSYVlkhiiH3WexuWhItHiwFlIKD6zBohFnRhWYuxWCiW5Ls3fYg==
X-Received: by 2002:a17:902:c7d1:b0:189:1a24:2865 with SMTP id r17-20020a170902c7d100b001891a242865mr32847709pla.18.1669624370332;
        Mon, 28 Nov 2022 00:32:50 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090ad99600b002036006d65bsm7052905pjv.39.2022.11.28.00.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 00:32:49 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:32:43 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, paulmck@kernel.org,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Message-ID: <Y4RyK4D25IFwWK3P@piliu.users.ipa.redhat.com>
References: <20221117112050.3942407-1-qiang1.zhang@intel.com>
 <20221117142025.GE839309@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117142025.GE839309@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:20:25PM +0100, Frederic Weisbecker wrote:
> On Thu, Nov 17, 2022 at 07:20:50PM +0800, Zqiang wrote:
> > Before SRCU_SIZE_WAIT_CALL srcu_size_state is reached, the srcu
> > callback only insert to boot-CPU srcu_data structure's->srcu_cblist
> > and other CPU srcu_data structure's->srcu_cblist is always empty. so
> > before SRCU_SIZE_WAIT_CALL is reached, need to correctly check boot-CPU
> > pend cbs in srcu_might_be_idle().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/srcutree.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 6af031200580..6d9af9901765 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1098,8 +1098,11 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> >  	unsigned long tlast;
> >  
> >  	check_init_srcu_struct(ssp);
> > -	/* If the local srcu_data structure has callbacks, not idle.  */
> > -	sdp = raw_cpu_ptr(ssp->sda);
> > +	/* If the boot CPU or local srcu_data structure has callbacks, not idle.  */
> > +	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
> > +		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> > +	else
> > +		sdp = raw_cpu_ptr(ssp->sda);
> 
> While at it if someone is interested in documenting/commenting on the meaning of
> all these SRCU_SIZE_* things, it would be much appreciated!
> 

Due to a conflict understanding to the code, once hesitate to jump in.
But anyway, just bold to move ahead.

I have send a series "[PATCH 0/3] srcu: shrink the num of
srcu_size_state", which opens the discussion. (Have Cced you and Zqiang)

Please have a look.

Thanks,

	Pingfan

> Thanks.
> 
> >  	spin_lock_irqsave_rcu_node(sdp, flags);
> >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> >  		spin_unlock_irqrestore_rcu_node(sdp, flags);
> > -- 
> > 2.25.1
> > 
