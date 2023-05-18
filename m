Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F25707C44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjERIko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjERIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0A51FFA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF8CB648D9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01000C4339B;
        Thu, 18 May 2023 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684399236;
        bh=sNWJdOUYMIQdAU0YAltYL+BBkG+apgAFI6ENGrmKZMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZREIV5OPPkEokDZ+B1UIEmdo1xM5H/2qWbDqoTdkE1+RzbsobFAppIidj3+KEflu
         3SOg2JwSm8o4xxw4m8QTO9gtyXLIkj9Uf2MQTJnbQpMfXn+N4tsZyOvUwtz/w9F+wj
         X6EsciY2F3T++WEiSWNAv27iE+db4SeurCzQg946vNQOElPDFFyR/nwoRHjfuVvdM9
         QINWa2yi/CuR4WNsDtujIYkdR82RCPZtyYlFGDBpUMV6P8QOy5pmafFm2wK/2RAy/F
         6x5JZQ9Esj3tOCznBeI2uBHbNN7PXcjohFIvI2hRsCayFSkFGtiA79tXwxjpFoVDa2
         ZeFhPpJ98b6xg==
Date:   Thu, 18 May 2023 10:40:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
Message-ID: <20230518-pfannen-besichtigen-be3990d2f706@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518-appetit-aufsicht-238e950b97d6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518-appetit-aufsicht-238e950b97d6@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:25:11AM +0200, Christian Brauner wrote:
> On Wed, May 17, 2023 at 07:09:12PM -0500, Mike Christie wrote:
> > This patch allows the vhost and vhost_task code to use CLONE_THREAD,
> > CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
> > normal testing, haven't coverted vsock and vdpa, and I know you guys
> > will not like the first patch. However, I think it better shows what
> 
> Just to summarize the core idea behind my proposal is that no signal
> handling changes are needed unless there's a bug in the current way
> io_uring workers already work. All that should be needed is
> s/PF_IO_WORKER/PF_USER_WORKER/ in signal.c.
> 
> If you follow my proposal than vhost and io_uring workers should almost
> collapse into the same concept. Specifically, io_uring workers and vhost
> workers should behave the same when it comes ot handling signals.
> 
> See 
> https://lore.kernel.org/lkml/20230518-kontakt-geduckt-25bab595f503@brauner
> 
> 
> > we need from the signal code and how we can support signals in the
> > vhost_task layer.
> > 
> > Note that I took the super simple route and kicked off some work to
> > the system workqueue. We can do more invassive approaches:
> > 1. Modify the vhost drivers so they can check for IO completions using
> > a non-blocking interface. We then don't need to run from the system
> > workqueue and can run from the vhost_task.
> > 
> > 2. We could drop patch 1 and just say we are doing a polling type
> > of approach. We then modify the vhost layer similar to #1 where we
> > can check for completions using a non-blocking interface and use
> > the vhost_task task.
> 
> My preference would be to do whatever is the minimal thing now and has
> the least bug potential and is the easiest to review for us non-vhost
> experts. Then you can take all the time to rework and improve the vhost
> infra based on the possibilities that using user workers offers. Plus,
> that can easily happen in the next kernel cycle.
> 
> Remember, that we're trying to fix a regression here. A regression on an
> unreleased kernel but still.

It's a public holiday here today so I'll try to find time to review this
tomorrow.
