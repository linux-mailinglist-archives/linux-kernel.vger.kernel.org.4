Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9915BC571
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiISJeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiISJeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB88140A2;
        Mon, 19 Sep 2022 02:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0853060EA5;
        Mon, 19 Sep 2022 09:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18ED7C433D7;
        Mon, 19 Sep 2022 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663580054;
        bh=coTuegtVwFPcWNsRoJFQYYyv6RIEflMGPozkrdi2Bts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcf8du5mZqjfkQTxrHHWgWmuTfJeADmi0Wl4JIdhBReCcSV+gdQryt+nKpwDRZCqF
         8Burd8q6+izkMUoDE0iz9dO7AA9xtjcHQkGtFh9Bi7Szykz7gkZdkYikpkqhShKF9s
         le+K8jlhyUE1ETJPIuqq475TUaYV/u3hQeYie3HyEj3A6c02SpPD/Mb+BrKerhJqCQ
         jCHdYaQSPjHdS6kLgM9qjA8BNWPp8KurAv+y8desg0liBEARsPuQeYpsRm48C8Zncj
         R+wmvQgdwaF7mI73CERcnriaD4edRiH+F5lg0v/c+WqLe4yIHXj1QPh1DcLYWJk+Bf
         1tnPge1g/OyPQ==
Date:   Mon, 19 Sep 2022 11:34:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, neeraj.iitr10@gmail.com, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [RFC] rcu/nocb: Fix possible bugs in rcu_barrier()
Message-ID: <20220919093411.GB56640@lothringen>
References: <20220918221231.79143-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918221231.79143-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 10:12:31PM +0000, Joel Fernandes (Google) wrote:
> When going through the lazy-rcu work, I noticed that
> rcu_barrier_entrain() does not really wake up the rcuog GP thread in any
> path after entraining. This means it is possible the GP thread is not
> awakened soon (say there were no CBs in the cblist after entraining
> time).

Right.

> 
> Further, nothing appears to be calling the rcu_barrier callback
> directly in the case the ->cblist was empty which means if the IPI gets
> delayed enough to make the ->cblist empty and it turns out to be the last
> CPU holding, then nothing calls completes rcu_state.barrier_completion.

No need for that, if the cblist is empty there is no need for a callback
to enqueue.

Thanks.
