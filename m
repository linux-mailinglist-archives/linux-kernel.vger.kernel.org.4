Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29D36AB948
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCFJID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCFJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:07:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910822DCF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:07:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so35557206eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678093662;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QOo+TQsiEWoJ/GqhB51kIfy6Mh7x0FFj/TSz1DnawY=;
        b=IOgie4aED1NrYa3+IOHHvQXvIafGEl4R8feVPNlNmYkZ+U5U+FJBtuhY0EvMFuo7vL
         8PGaNufrx8qkOGRSi4otl/v6FZUYJUuh7bUVSGREMkqq5BuHKwsdzyyiminh4DgXMzA6
         oB5BSkLi9oC7j8KoCo9pmD1MrQ3UVSW/aICyFVfP4JljYypPtV5VkYBsow32kIw6upnY
         SDoOyJ70ZloC+eFbKwY6NznBYDjZgPQJ5pZIYmCVuHSpe4qZRry+FcMjCsF299wVxtr0
         DviZm23Yzc+VM38MQaY2QIx7+k5umvVustGP62spvrUIk2Pc8Uvha9DJBjG0WFjWckXe
         g7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093662;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QOo+TQsiEWoJ/GqhB51kIfy6Mh7x0FFj/TSz1DnawY=;
        b=PFWtBg4J1gIqEPik5I2NfBsd4wINEbuII63ZNf5BTpeoYFCyBuA/aesaYay63tlwrz
         useJKrhIh8Tuu/UBitbMVowA7B/lLaQBW0/tNM+DXO7pEbWQJawsMs/tZftQiLUfoNeM
         VjzGgL/CKJB6RSCJUg9I0j/fUoQFYOnujJHdmgH66QXUxofO4zZYpnKDa+ktyroxOLh8
         ctoC/8CZYKaqFl8zUF17ttQLtd6+piZw2k7lhtw24ZNYy8Amo2bVKACAf6/3brrgGoYU
         k27Tzny5FRtKDcKJSNErEJpvieWvK1US+Y1uAhdVnE1HkIiP0URqkuyStre12b3nTc1H
         w8EA==
X-Gm-Message-State: AO0yUKUN335opXn//Nvkb/w2SPNDFB3LgdXju/3YtvzrG7lHDKuq2ugg
        WXDl9qxpUVFbxxaPWWZrEOs+fjyympU3Mg==
X-Google-Smtp-Source: AK7set8rLHJ2MONYnSI5rQ8GjmVmyTt0oaZgLIn0ANI9toSNd2BzT3eR3O6xJSLk3LrGcYUn7m4EvA==
X-Received: by 2002:aa7:da49:0:b0:4bf:3cdb:fb42 with SMTP id w9-20020aa7da49000000b004bf3cdbfb42mr8833735eds.6.1678093662526;
        Mon, 06 Mar 2023 01:07:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q10-20020a50c34a000000b004bda465da32sm4829047edb.1.2023.03.06.01.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:07:42 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:07:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 06/18] printk: nobkl: Add acquire/release logic
Message-ID: <0a7e5230-3a8d-496a-a42b-bda2dc82ea9a@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/kdb-do-not-assume-write-callback-available/20230303-040039
base:   10d639febe5629687dac17c4a7500a96537ce11a
patch link:    https://lore.kernel.org/r/20230302195618.156940-7-john.ogness%40linutronix.de
patch subject: [PATCH printk v1 06/18] printk: nobkl: Add acquire/release logic
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230305/202303051319.m55kZE3v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303051319.m55kZE3v-lkp@intel.com/

smatch warnings:
kernel/printk/printk_nobkl.c:391 cons_try_acquire_spin() warn: signedness bug returning '(-16)'

vim +391 kernel/printk/printk_nobkl.c

d444c8549ebdf3 Thomas Gleixner 2023-03-02  284  /**
d444c8549ebdf3 Thomas Gleixner 2023-03-02  285   * cons_try_acquire_spin - Complete the spinwait attempt
d444c8549ebdf3 Thomas Gleixner 2023-03-02  286   * @ctxt:	Pointer to an acquire context that contains
d444c8549ebdf3 Thomas Gleixner 2023-03-02  287   *		all information about the acquire mode
d444c8549ebdf3 Thomas Gleixner 2023-03-02  288   *
d444c8549ebdf3 Thomas Gleixner 2023-03-02  289   * @ctxt->hov_state contains the handover state that was set in
d444c8549ebdf3 Thomas Gleixner 2023-03-02  290   * state[REQ]
d444c8549ebdf3 Thomas Gleixner 2023-03-02  291   * @ctxt->req_state contains the request state that was set in
d444c8549ebdf3 Thomas Gleixner 2023-03-02  292   * state[CUR]
d444c8549ebdf3 Thomas Gleixner 2023-03-02  293   *
d444c8549ebdf3 Thomas Gleixner 2023-03-02  294   * Returns: 0 if successfully locked. -EBUSY on timeout. -EAGAIN on
d444c8549ebdf3 Thomas Gleixner 2023-03-02  295   * unexpected state values.

Out of date comments.

d444c8549ebdf3 Thomas Gleixner 2023-03-02  296   *
d444c8549ebdf3 Thomas Gleixner 2023-03-02  297   * On success @ctxt->state contains the new state that was set in
d444c8549ebdf3 Thomas Gleixner 2023-03-02  298   * state[CUR]
d444c8549ebdf3 Thomas Gleixner 2023-03-02  299   *
d444c8549ebdf3 Thomas Gleixner 2023-03-02  300   * On -EBUSY failure this context timed out. This context should either
d444c8549ebdf3 Thomas Gleixner 2023-03-02  301   * give up or attempt a hostile takeover.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  302   *
d444c8549ebdf3 Thomas Gleixner 2023-03-02  303   * On -EAGAIN failure this context encountered unexpected state values.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  304   * This context should retry the full handover request setup process (the
d444c8549ebdf3 Thomas Gleixner 2023-03-02  305   * handover request setup by cons_setup_handover() is now invalidated and
d444c8549ebdf3 Thomas Gleixner 2023-03-02  306   * must be performed again).

Out of date.

d444c8549ebdf3 Thomas Gleixner 2023-03-02  307   */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  308  static bool cons_try_acquire_spin(struct cons_context *ctxt)
                                                       ^^^^
After reviewing the code, it looks the intention was the bool should be
changed to int.

d444c8549ebdf3 Thomas Gleixner 2023-03-02  309  {
d444c8549ebdf3 Thomas Gleixner 2023-03-02  310  	struct console *con = ctxt->console;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  311  	struct cons_state cur;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  312  	struct cons_state new;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  313  	int err = -EAGAIN;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  314  	int timeout;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  315  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  316  	/* Now wait for the other side to hand over */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  317  	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
d444c8549ebdf3 Thomas Gleixner 2023-03-02  318  		/* Timeout immediately if a remote panic is detected. */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  319  		if (cons_check_panic())
d444c8549ebdf3 Thomas Gleixner 2023-03-02  320  			break;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  321  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  322  		cons_state_read(con, CON_STATE_CUR, &cur);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  323  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  324  		/*
d444c8549ebdf3 Thomas Gleixner 2023-03-02  325  		 * If the real state of the console matches the handover state
d444c8549ebdf3 Thomas Gleixner 2023-03-02  326  		 * that this context setup, then the handover was a success
d444c8549ebdf3 Thomas Gleixner 2023-03-02  327  		 * and this context is now the owner.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  328  		 *
d444c8549ebdf3 Thomas Gleixner 2023-03-02  329  		 * Note that this might have raced with a new higher priority
d444c8549ebdf3 Thomas Gleixner 2023-03-02  330  		 * requester coming in after the lock was handed over.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  331  		 * However, that requester will see that the owner changes and
d444c8549ebdf3 Thomas Gleixner 2023-03-02  332  		 * setup a new request for the current owner (this context).
d444c8549ebdf3 Thomas Gleixner 2023-03-02  333  		 */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  334  		if (cons_state_bits_match(cur, ctxt->hov_state))
d444c8549ebdf3 Thomas Gleixner 2023-03-02  335  			goto success;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  336  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  337  		/*
d444c8549ebdf3 Thomas Gleixner 2023-03-02  338  		 * If state changed since the request was made, give up as
d444c8549ebdf3 Thomas Gleixner 2023-03-02  339  		 * it is no longer consistent. This must include
d444c8549ebdf3 Thomas Gleixner 2023-03-02  340  		 * state::req_prio since there could be a higher priority
d444c8549ebdf3 Thomas Gleixner 2023-03-02  341  		 * request available.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  342  		 */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  343  		if (cur.bits != ctxt->req_state.bits)
d444c8549ebdf3 Thomas Gleixner 2023-03-02  344  			goto cleanup;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  345  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  346  		/*
d444c8549ebdf3 Thomas Gleixner 2023-03-02  347  		 * Finally check whether the handover state is still
d444c8549ebdf3 Thomas Gleixner 2023-03-02  348  		 * the same.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  349  		 */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  350  		cons_state_read(con, CON_STATE_REQ, &cur);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  351  		if (cur.atom != ctxt->hov_state.atom)
d444c8549ebdf3 Thomas Gleixner 2023-03-02  352  			goto cleanup;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  353  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  354  		/* Account time */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  355  		if (timeout > 0)
d444c8549ebdf3 Thomas Gleixner 2023-03-02  356  			udelay(1);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  357  	}
d444c8549ebdf3 Thomas Gleixner 2023-03-02  358  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  359  	/*
d444c8549ebdf3 Thomas Gleixner 2023-03-02  360  	 * Timeout. Cleanup the handover state and carefully try to reset
d444c8549ebdf3 Thomas Gleixner 2023-03-02  361  	 * req_prio in the real state. The reset is important to ensure
d444c8549ebdf3 Thomas Gleixner 2023-03-02  362  	 * that the owner does not hand over the lock after this context
d444c8549ebdf3 Thomas Gleixner 2023-03-02  363  	 * has given up waiting.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  364  	 */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  365  	cons_cleanup_handover(ctxt);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  366  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  367  	cons_state_read(con, CON_STATE_CUR, &cur);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  368  	do {
d444c8549ebdf3 Thomas Gleixner 2023-03-02  369  		/*
d444c8549ebdf3 Thomas Gleixner 2023-03-02  370  		 * The timeout might have raced with the owner coming late
d444c8549ebdf3 Thomas Gleixner 2023-03-02  371  		 * and handing it over gracefully.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  372  		 */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  373  		if (cons_state_bits_match(cur, ctxt->hov_state))
d444c8549ebdf3 Thomas Gleixner 2023-03-02  374  			goto success;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  375  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  376  		/*
d444c8549ebdf3 Thomas Gleixner 2023-03-02  377  		 * Validate that the state matches with the state at request
d444c8549ebdf3 Thomas Gleixner 2023-03-02  378  		 * time. If this check fails, there is already a higher
d444c8549ebdf3 Thomas Gleixner 2023-03-02  379  		 * priority context waiting or the owner has changed (either
d444c8549ebdf3 Thomas Gleixner 2023-03-02  380  		 * by higher priority or by hostile takeover). In all fail
d444c8549ebdf3 Thomas Gleixner 2023-03-02  381  		 * cases this context is no longer in line for a handover to
d444c8549ebdf3 Thomas Gleixner 2023-03-02  382  		 * take place, so no reset is necessary.
d444c8549ebdf3 Thomas Gleixner 2023-03-02  383  		 */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  384  		if (cur.bits != ctxt->req_state.bits)
d444c8549ebdf3 Thomas Gleixner 2023-03-02  385  			goto cleanup;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  386  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  387  		copy_full_state(new, cur);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  388  		new.req_prio = 0;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  389  	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &cur, &new));
d444c8549ebdf3 Thomas Gleixner 2023-03-02  390  	/* Reset worked. Report timeout. */
d444c8549ebdf3 Thomas Gleixner 2023-03-02 @391  	return -EBUSY;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  392  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  393  success:
d444c8549ebdf3 Thomas Gleixner 2023-03-02  394  	/* Store the real state */
d444c8549ebdf3 Thomas Gleixner 2023-03-02  395  	copy_full_state(ctxt->state, cur);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  396  	ctxt->hostile = false;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  397  	err = 0;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  398  
d444c8549ebdf3 Thomas Gleixner 2023-03-02  399  cleanup:
d444c8549ebdf3 Thomas Gleixner 2023-03-02  400  	cons_cleanup_handover(ctxt);
d444c8549ebdf3 Thomas Gleixner 2023-03-02  401  	return err;
d444c8549ebdf3 Thomas Gleixner 2023-03-02  402  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

