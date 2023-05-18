Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D87084AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjERPJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjERPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED39106
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24CA464FBD
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8136BC433D2;
        Thu, 18 May 2023 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684422557;
        bh=K/icPAo+rTpBT6kDoqfe9ZZ+3w7CthvJJutgxZaRnu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6C47hM/hIWfl//J4vv69OMrNfzUIbVMKkAIXaMZ8AerXxuQikVVRPWYPQE5nBSJg
         EDQcEaDGamPxeNI5XRdESjG067MBx7of7xF1J4hyG3q+uy3PoTU7jPPuCwsAG5HH8q
         Zpsppx2xq8eBKuBD7YsQdI2B9ZUUh2FuVbJeRP92KWlSo7nrLtdevViyvQbZlMWxpE
         7cLd/nFPa2Gp5/5FRPrjI6qrae/faaGfgoe2nEyYUzfhVl/D2MnqPcAM9nYDTL5UBG
         OJpwHAfPv5BXNEsX9CipLTFqPtcpSmlFjJE5NZSGKsBflZi60JhnvzXnWbZRCGONhv
         qH1DmEwbxwTPg==
Date:   Thu, 18 May 2023 17:09:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 5/8] vhost: Add callback that stops new work and
 waits on running ones
Message-ID: <20230518-tacker-ahnen-8eb944bed795@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-6-michael.christie@oracle.com>
 <20230518-lokomotive-aufziehen-dbc432136b76@brauner>
 <81e1a94d-531a-2e43-baee-da4b35644e87@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81e1a94d-531a-2e43-baee-da4b35644e87@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:03:32AM -0500, Mike Christie wrote:
> On 5/18/23 9:18 AM, Christian Brauner wrote:
> >> @@ -352,12 +353,13 @@ static int vhost_worker(void *data)
> >>  		if (!node) {
> >>  			schedule();
> >>  			/*
> >> -			 * When we get a SIGKILL our release function will
> >> -			 * be called. That will stop new IOs from being queued
> >> -			 * and check for outstanding cmd responses. It will then
> >> -			 * call vhost_task_stop to exit us.
> >> +			 * When we get a SIGKILL we kick off a work to
> >> +			 * run the driver's helper to stop new work and
> >> +			 * handle completions. When they are done they will
> >> +			 * call vhost_task_stop to tell us to exit.
> >>  			 */
> >> -			vhost_task_get_signal();
> >> +			if (vhost_task_get_signal())
> >> +				schedule_work(&dev->destroy_worker);
> >>  		}
> > 
> > I'm pretty sure you still need to actually call exit here. Basically
> > mirror what's done in io_worker_exit() minus the io specific bits.
> 
> We do call do_exit(). Once destory_worker has flushed the device and
> all outstanding IO has completed it call vhost_task_stop(). vhost_worker()
> above then breaks out of the loop and returns and vhost_task_fn() does
> do_exit().

Ah, that callchain wasn't obvious. Thanks.
