Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30306A272D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 04:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBYD7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 22:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBYD7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:59:36 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50EC241E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:59:34 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id cf14so1529722qtb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KGOc5or6Ka+ESMal/wrzgvuxlQ0lWrzt9TN0+d/2L8=;
        b=m1vFxWmAwknXSn96wT8rK9yQBS6V7K7sFznFq1iMSpOJEYS4QvDz7dNzhS6escHNpT
         3hUcx2h4Biq35IZZ2OYZzUHfEn+j55dlQgp6fAdSmIDkK8jvFfm7zC7nydqZ/4nU7Jqk
         eGkJz5JWvYUaflMxABTx4oKNHEYjj4UzZHDyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KGOc5or6Ka+ESMal/wrzgvuxlQ0lWrzt9TN0+d/2L8=;
        b=ESyc3Fk1s2rNO2Ys2MK6hwcCqIfBnK5FiL632rrTby9eqD4Q4mckX6PfoPeRfWZ3Br
         Hiv4D5l5fNSWVpbtYLa9wLlai7p8E7U0USej0qzM7iXCsndMx7Z5ggUPVONZoOoj8u1E
         drqSCLP/Cn+qTo5Wz6Jk8B/vQ8bzppl7gVNebn0rifYBzdKReiUbGWi7Y7++de8piv4Q
         ySJFcBTjjn1zH+7xDuW3msxYumXgi01Rv9zzWHxMdQKUS+yYVscCTmrPZje1hGSNs2Kp
         NHtg53Sc6ncnhNAL1DwvRVH8nabGCGKuZcpKlAHHkZL6ya1huCg37vlIU/HdYyfYpkCB
         WRLQ==
X-Gm-Message-State: AO0yUKU4enwMQY6phvkFFXHOBcj0h5Ln0iOVLA62OS1oDb8YjwsnuNm0
        x3duHrcy6yRwWSZUyysV51PL/FRiL912P+5O
X-Google-Smtp-Source: AK7set88BR+bJWsRY8dBKrohwtqStv5nAqAG+W/WznqlyO3MNLzS/zFarS7W3ZaDHHwscl+PqzLwpQ==
X-Received: by 2002:a05:622a:1b9f:b0:3b9:bc8c:c1fe with SMTP id bp31-20020a05622a1b9f00b003b9bc8cc1femr3541331qtb.9.1677297573926;
        Fri, 24 Feb 2023 19:59:33 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id a12-20020ae9e80c000000b007423843d879sm551824qkg.93.2023.02.24.19.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 19:59:33 -0800 (PST)
Date:   Sat, 25 Feb 2023 03:59:32 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH RFC] rcu: Add a minimum time for marking boot as completed
Message-ID: <Y/mHpOrr1C8NkMWm@google.com>
References: <20230225032716.3320124-1-joel@joelfernandes.org>
 <ea03e810-95f0-abd8-2a83-f83174a99dbf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea03e810-95f0-abd8-2a83-f83174a99dbf@infradead.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 07:32:22PM -0800, Randy Dunlap wrote:
[..] 
> > +
> > +	  Accept the default if unsure.
> > +
> >  config RCU_EXP_KTHREAD
> >  	bool "Perform RCU expedited work in a real-time kthread"
> >  	depends on RCU_BOOST && RCU_EXPERT
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 19bf6fa3ee6a..5b73341d9b89 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -62,6 +62,10 @@ module_param(rcu_normal_after_boot, int, 0444);
> >  #endif
> >  #endif /* #ifndef CONFIG_TINY_RCU */
> >  
> > +/* Minimum time until RCU considers boot as completed. */
> > +static int boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
> > +module_param(boot_end_delay, int, 0444);
> > +
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >  /**
> >   * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
> > @@ -225,12 +229,29 @@ void rcu_unexpedite_gp(void)
> >  EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
> >  
> >  static bool rcu_boot_ended __read_mostly;
> > -
> >  /*
> > - * Inform RCU of the end of the in-kernel boot sequence.
> > + * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
> > + * not be marked ended until at least boot_end_delay milliseconds have passed.
> >   */
> > +void rcu_end_inkernel_boot(void);
> > +static void boot_rcu_work_fn(struct work_struct *work)
> > +{
> > +	rcu_end_inkernel_boot();
> > +}
> > +static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_work_fn);
> > +
> >  void rcu_end_inkernel_boot(void)
> >  {
> > +	if (boot_end_delay) {
> > +		u64 boot_ms = ktime_get_boot_fast_ns() / 1000000UL;
> 
> Is that division OK on 32-bit?  Might have to use a helper macro. (I dunno.)

I believe the below should work on 32-bit, but I will test it more. It does
on 64-bit.

Thanks!

---8<-----------------------

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index cbdad7b46841..2f539c18b310 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -243,7 +243,7 @@ static DECLARE_DELAYED_WORK(boot_rcu_work, boot_rcu_work_fn);
 void rcu_end_inkernel_boot(void)
 {
 	if (boot_end_delay) {
-		u64 boot_ms = ktime_get_boot_fast_ns() / 1000000UL;
+		u64 boot_ms = div_u64(ktime_get_boot_fast_ns(), 1000000UL);
 
 		if (boot_ms < boot_end_delay) {
 			schedule_delayed_work(&boot_rcu_work,
-- 
2.39.2.637.g21b0678d19-goog

