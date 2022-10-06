Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B05F5F46
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJFDG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJFDGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:06:20 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37680EB9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:06:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so517160pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KDORDmVJlGAH+2VDPr5/x8Jt3M8M+5CLZ86WDuJmMtQ=;
        b=XRNtI0RKOybw0AZPuMgzHQ6nwXZmdMO+fdjLU0CJID/MEsvN4UN4GSWoQ19kIarRJ0
         OoFyZcjmJ8vff47NqmfklVugFf5abRbNno1bVwJ3LHSCq67q3jKj0ksZNE9mfd1YVbbl
         b6hQzCEvEKfG1yI/i1Ynw1SIWxy/MjuCItrNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KDORDmVJlGAH+2VDPr5/x8Jt3M8M+5CLZ86WDuJmMtQ=;
        b=DCl4o+OXYC2Cy4VsA2wSvhDNHHFDUTAk6NPL/7fD4xCxeMMsp4YNnP00qbk8aTJWxh
         rp7UpEyO13Cl2CC9j5zBOm6TqYN+m4llBnt4h/G9naYcuT5SQMiuDoD+Q+QHVum4elrT
         gp9GXSducfFpCx6Txe6G145JP0ukkQE2Zx4lbANMaZeCwba4JEQrMwJdoinsPjrdkPL1
         1547MkfM5XW+3esHBBUqzu2wcaeMhsro7yaq0fk8DHs+pBKg08wM5xotU1SXLFHy1QYm
         eFNbLIwO5g0QS52lFMJ2bSVxaapObadmDxpVpfXhMiD7ibQB9W0g+Qky2pLR4/NIDXfl
         9tTw==
X-Gm-Message-State: ACrzQf0B0B4ToxihHV0XfZml4FckwJ3mdAi/6mWAr8beJTxsr60KPSWG
        j8jmtLDcTHUvciDTyHTdGYwL9A==
X-Google-Smtp-Source: AMsMyM5pnDxtwM6bse0TAOUDjZ+WVFmurkxinUugzQUbn4YATg0uA0iXtH3Qn1ciOgVXjm8wi4zVNQ==
X-Received: by 2002:a17:902:6bc7:b0:178:8305:392a with SMTP id m7-20020a1709026bc700b001788305392amr2409484plt.39.1665025577628;
        Wed, 05 Oct 2022 20:06:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v126-20020a622f84000000b00550724f8ea0sm11590896pfv.128.2022.10.05.20.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 20:06:16 -0700 (PDT)
Date:   Wed, 5 Oct 2022 20:06:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jorge Merlino <jorge.merlino@canonical.com>,
        David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Message-ID: <202210051950.CAF8CDBF@keescook>
References: <20220910211215.140270-1-jorge.merlino@canonical.com>
 <202209131456.76A13BC5E4@keescook>
 <c9ca551b-070b-dcee-b4b4-b7fbfc33ab5d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ca551b-070b-dcee-b4b4-b7fbfc33ab5d@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 01:09:36PM -0300, Jorge Merlino wrote:
> On 13/9/22 19:03, Kees Cook wrote:
> > I'll want to spend some more time studying this race, but yes, it looks
> > like it should get fixed. I'm curious, though, how did you find this
> > problem? It seems quite unusual to have a high-load heavily threaded
> > process decide to exec.
> 
> I just got a response from our customer regarding the situation where this
> race condition occurs:

Thanks for getting back details!

> Our application is a Rust-based CLI tool that acts as a frontend to
> cloud-based testing infrastructure. In one mode of operation it uploads a
> large number of test artifacts to cloud storage, spawns compute instances,
> and then starts a VPN connection to those instances. The application creates
> the VPN connection by executing another setuid-root tool as a subprocess. We
> see that this subprocess sometimes fails to setuid. The "high-load heavily
> threaded" aspect comes from the fact that we're using the Tokio runtime.
> Each upload to cloud storage is a separate Tokio task (i.e. "green thread")
> and these are scheduled onto "N" OS-level threads, where N = nproc. In a
> large run we may upload a couple thousand artifacts but limit to 50
> concurrent uploads. Once these artifact uploads complete, we typically spawn
> the setuid subprocess within 1-2 seconds.

Interesting. Seems like the execve might be racing all the threads
exiting?

> Have you been able to look at this issue?

I'll continue looking at this.

Dave, this tracks back to commit a6f76f23d297 ("CRED: Make execve() take
advantage of copy-on-write credentials") ... any ideas what's happening
here?

-- 
Kees Cook
