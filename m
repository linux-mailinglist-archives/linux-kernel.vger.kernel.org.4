Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFE36E4C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDQPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjDQPCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:02:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9749B8A47
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32B45624C5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F33C433D2;
        Mon, 17 Apr 2023 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681743737;
        bh=xcwq78tyDgeI0f4Jknw07jt4RTYi2M51ObHm98OuboY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxkyT2sB8cYR3MyQz1PW40+lFB825poZW4xQ2XFF3OKtLPGenlrRv1lI1fYo05SmO
         0v1j4L5FcNQDPXrXZuvc7q5XGTtOpS0E+I2AWLpiHvXhYq6XUaTig7f3FYBWorAMtW
         dcxrFBqCusQcmYJhorC6udZLVuPbvLb2kzi674RusSfo+H0249VmQOkgPuF43tak0C
         eklsavJgo60Z6qzru+RAXWOZSLW6GJ8CXFjrktWwC+wjZcq7Aoug5+TXEtnOxZu5vb
         zqn97A/XN2sa/Dh3aV76PxWIWR/QdCYsAQ9+h/QsSHKJOIgNehQIBu0VY4ZXZwMsso
         MSkJfqaKzzlJA==
Date:   Mon, 17 Apr 2023 17:02:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZD1fdvr1Eh8aAdnU@localhost.localdomain>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfd0yi4g.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Apr 15, 2023 at 11:01:51PM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> Subject: tick/broadcast: Make broadcast device replacement work correctly
> Date: Wed, 12 Apr 2023 08:34:25 +0800
> 
> When a tick broadcast clockevent device is initialized for one shot mode
> then tick_broadcast_setup_oneshot() OR's the periodic broadcast mode
> cpumask into the oneshot broadcast cpumask.
> 
> This is required when switching from periodic broadcast mode to oneshot
> broadcast mode to ensure that CPUs which are waiting for periodic
> broadcast are woken up on the next tick.
> 
> But it is subtly broken, when an active broadcast device is replaced and
> the system is already in oneshot (NOHZ/HIGHRES) mode. Victor observed
> this and debugged the issue.
> 
> Then the OR of the periodic broadcast CPU mask is wrong as the periodic
> cpumask bits are sticky after tick_broadcast_enable() set it for a CPU
> unless explicitly cleared via tick_broadcast_disable().
> 
> That means that this sets all other CPUs which have tick broadcasting
> enabled at that point unconditionally in the oneshot broadcast mask.
> 
> If the affected CPUs were already idle and had their bits set in the
> oneshot broadcast mask then this does no harm. But for non idle CPUs
> which were not set this corrupts their state.
> 
> On their next invocation of tick_broadcast_enable() they observe the bit
> set, which indicates that the broadcast for the CPU is already set up.
> As a consequence they fail to update the broadcast event even if their
> earliest expiring timer is before the actually programmed broadcast
> event.
> 
> If the programmed broadcast event is far in the future, then this can
> cause stalls or trigger the hung task detector.
> 
> Avoid this by telling tick_broadcast_setup_oneshot() explicitly whether
> this is the initial switch over from periodic to oneshot broadcast which
> must take the periodic broadcast mask into account. In the case of
> initialization of a replacement device this prevents that the broadcast
> oneshot mask is modified.
> 
> There is a second problem with broadcast device replacement in this
> function. The broadcast device is only armed when the previous state of
> the device was periodic.

Any chance the patch could be cut in two then?

Thanks.
