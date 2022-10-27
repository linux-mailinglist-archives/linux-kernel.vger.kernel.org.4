Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8086360FC99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiJ0QBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiJ0QBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D5E9F77C;
        Thu, 27 Oct 2022 09:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 708ADB826F9;
        Thu, 27 Oct 2022 16:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D446C433D6;
        Thu, 27 Oct 2022 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666886497;
        bh=Baj4V+Mot+1k5z7U2r5M5/8F0M4nNVn8kZp8DYNpR4A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZuPpADKp4sYROuMM1T2Z0x0Am8t+kXlsqx5aGhj5UWua6SRLydfpPV4kiB7G1fi6C
         PTJ2wBMTfygD2KrguGXZOXDt+Nr0qxnOd7NYv8a/k2RzMfaSL4oB5Kcn8pFQwu0JLj
         Q7vI+VcsHTHaz7g2OmU2NCalzTx7q7PLjfefn8ivdAKX5GPwT2TLKMkSittmexJ2bp
         9EF9Km9k8IR5Zvp5GXYRkWm7QytUaX3bgPfhl0m8rZGH6yKmo3Y9Jkv3eg87xdumf2
         K5Jm2x1z+ByoEC5Q5dDKXavCiImD51KKYt4q1nAg7qTyi9rR0e5Io07pW9Do39JyNs
         EmM9DgZtA+kxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A44BC5C0692; Thu, 27 Oct 2022 09:01:36 -0700 (PDT)
Date:   Thu, 27 Oct 2022 09:01:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221027160136.GY5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
 <20221019220537.GA1234896@lothringen>
 <20221020222718.GA5600@paulmck-ThinkPad-P17-Gen-1>
 <87r0z1gy51.fsf@jogness.linutronix.de>
 <20221021184152.GO5600@paulmck-ThinkPad-P17-Gen-1>
 <87y1t5zqzz.fsf@jogness.linutronix.de>
 <20221024134727.GV5600@paulmck-ThinkPad-P17-Gen-1>
 <874jvpehod.fsf@jogness.linutronix.de>
 <20221027141045.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <87sfj9couk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfj9couk.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 04:45:47PM +0206, John Ogness wrote:
> On 2022-10-27, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > The warning is claiming that this srcu_struct was passed to
> > srcu_read_lock() at some point and is now being passed to
> > srcu_read_lock_nmisafe().
> 
> Indeed, I found some code that was not using my wrappers. Thanks. Living
> proof that it was a good idea to add the checks. ;-)

Glad that they helped, and a big "thank you!" to Frederic!

							Thanx, Paul
