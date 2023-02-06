Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191468C836
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBFVEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBFVEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:04:32 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E173EE1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:03:44 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id cr22so14458026qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSuSGckE2C1EffkcYLU7uPOxByUCgrfnKkzD4m2tvZc=;
        b=nIOWrtRMvVYqqqOSDHtvIFchNczkpLaImb56IBUrY/gKj1A6sbrAGbnqTvbTMXvbl0
         Ng6tAmM8GzdDc2ozAJpSE4YTO3EyemRgkFocPcXz5n52q3NxhXz4uKVRDa8IwfvQBb7i
         r15hZKEQCtwgq1KEfqOhK4fxFCGHd9JHw79MfOrpHnkgDubWLd1hqgIxhSVZavwkHFwg
         5dmuU1v5JjtRlcUt8paieq5CuVJbsEJ0mAwkmhFNwJzFfCPLulXLKviCXGVpNV2oWs1Y
         IvqDi1m2M2ZtEm1KV7J/4WLs0LzIBQyfgyCTVU6nK3wW73bspQUqEV+Luv8j8DsAQzFH
         E/kA==
X-Gm-Message-State: AO0yUKW936W1BiFQzbtPDTMwozOK7NGAC+PY8HxqdWGX0x6TNVlFVGGS
        YVxZ7bcKwuEOPpfMQ8JOvaXm
X-Google-Smtp-Source: AK7set9ltDyUBg0Yk4tQF6bp/5fec5LHU/n8GtM/kmq1jFzcUrHIUm5pIjwwd/JRrTdvWA45P4H5Yw==
X-Received: by 2002:ac8:5bd6:0:b0:3b8:2eca:e6a5 with SMTP id b22-20020ac85bd6000000b003b82ecae6a5mr1368152qtb.29.1675717424083;
        Mon, 06 Feb 2023 13:03:44 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id f3-20020ac84703000000b003b2d890752dsm7929401qtp.88.2023.02.06.13.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:03:43 -0800 (PST)
Date:   Mon, 6 Feb 2023 16:03:42 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        lvc-patches@linuxtesting.org, linux-kernel@vger.kernel.org
Subject: Re: md: dm-ioctl: drop always-false condition
Message-ID: <Y+FrLt8gt/Pff/zZ@redhat.com>
References: <c8c9df45-1d59-3195-7631-51b3a58148ee@omp.ru>
 <alpine.LRH.2.21.2301180658250.13031@file01.intranet.prod.int.rdu2.redhat.com>
 <b8269463-9f7e-4c28-2bfe-44663f3764c1@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8269463-9f7e-4c28-2bfe-44663f3764c1@omp.ru>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2023 at  3:58P -0500,
Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> On 1/18/23 2:59 PM, Mikulas Patocka wrote:
> 
> [...]
> 
> >> The expression 'indata[3] > ULONG_MAX' always evaluates to false since
> >> indata[] is declared as an array of *unsigned long* elements and #define
> >> ULONG_MAX represents the max value of that exact type...
> >>
> >> Note that gcc seems to be able to detect the dead code here and eliminate
> >> this check anyway...
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> >> analysis tool.
> >>
> >> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > 
> > Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
> 
>    Thank you!
> 
> >> ---
> >> This patch is atop of the 'for-next' branch of the device-mapper repo...
> >>
> >>  drivers/md/dm-ioctl.c |    3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> Index: linux-dm/drivers/md/dm-ioctl.c
> >> ===================================================================
> >> --- linux-dm.orig/drivers/md/dm-ioctl.c
> >> +++ linux-dm/drivers/md/dm-ioctl.c
> >> @@ -1073,8 +1073,7 @@ static int dev_set_geometry(struct file
> 
>    Returning to this patch, I think I should've added the name of the function
> in question in both the subject and and commit msg... I'll recast...

Not a big deal, I've already staged it so please don't resend.

See:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.3&id=151d812251202aa0dce1fdeabd64794292d40b75
