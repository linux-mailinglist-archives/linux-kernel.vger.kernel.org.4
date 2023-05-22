Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5487770BFED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjEVNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEVNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:43:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF669E6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:43:17 -0700 (PDT)
Date:   Mon, 22 May 2023 15:43:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684762996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aq6fD3/irWVPTcpNULmsL/LAX0+fUqh707lcImUEfs=;
        b=QabgB87SEZmmhMTnvs/jTdCYiEzcvSSukVkNeFU2Do2MyfWO0llGHqoXxqh1ZHwoFAiVWv
        xIJIH2Uh4aMeZNf5w6ZHOzPB0LnsMKICV4zS5PQt+zqjexYHUBwcRfi9DA0YrHwsET1FHd
        zIb1GOBsfBKRzE+vbb9OWK2umlsSZN2FIi4ivLRCmZzN9OFkXnWFs5/+bLm1lccBLL7wUf
        RDd8nC4T52XWixYg7I7NtmJzv73jsLx8u0uB6lzAOsBJIeIEi/dPOyPvFIvdCV7fCkpyUZ
        58wj7lZ+K/JS7DP5tlnSB6LdxNAgcGAC6TCa0UJd0hd61RbMJMBPOW4nCL+hyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684762996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aq6fD3/irWVPTcpNULmsL/LAX0+fUqh707lcImUEfs=;
        b=sf1kFy72Jq7Ey5hyzXu001CCVXZxphh2faw1xNpZ0nvT6nPxf4xciDbInFSEkXx+ypWHGq
        t7V352a+IQahoaAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
Message-ID: <20230522134315.oBK0Ll7f@linutronix.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
 <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
 <20230522080604.MgUGcyeU@linutronix.de>
 <d7fa9ffe0e6cd546b8ff3826379c2cf78e5342b6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7fa9ffe0e6cd546b8ff3826379c2cf78e5342b6.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 12:41:21 [+0200], Mike Galbraith wrote:
> > I've been looking at the r8169 the other day and it seemed all good
> > since it was only scheduling workqueues and NAPI. But now I see this
> > mac_ocp_lock + config25_lock which are acquire in hardirq context but
> > can't. This needs to be taken care.
> 
> I did a patch converting the locks, but didn't post it hoping maybe
> those locks weren't really really needed.  It doesn't matter for my
> box, as it doesn't do anything but give RT chances to trip over bugs.

I missed that part. Do you still see those 160us if you keep the locks
as-it as drop the no-threads flag? I'm trying to figure out if this is
due to hwirq context or just blocked PCI-bus due ASPM.

> 	-Mike

Sebastian
