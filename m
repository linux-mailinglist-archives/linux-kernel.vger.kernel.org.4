Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74D2691816
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjBJFrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjBJFrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:47:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39485FE48
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 21:47:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso8713482pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 21:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AOWh5FIT9l+ytkQEtsn/0BsGE5ItnlbSB8SdkHKfew=;
        b=HEZLiVHM21ej+uZAeh9u3n6lcfIjjxfzBaiacOvUbXd9poXIv4rOXhyGQ7ckucUDPD
         2oUYgMQrBQgL8IUOgWiGIi5iFQLndPomzhyCop7/cGcAmX85i65EAQN/gzcoU35YLmm6
         rJz4q11QfO9fsac2EROUUtVRaWtKht8BnCByM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AOWh5FIT9l+ytkQEtsn/0BsGE5ItnlbSB8SdkHKfew=;
        b=H9tZP+TlkQlrjqE5Ftnlt2IY/0Ql3M7aS4JRx08wW2/OIFNy2vnUw66UHsucnehJqY
         TEzN4Ivx/ULA996d/UqgZ4M3kD9yEB7cN8pVjpO+Ompwg0DmWdLwYIBQvPNGABo9RrNP
         kZpp4Jb3MgI+9jhXqAOja777u+teSkM1JMfbbs8BnxSMg7ax0DjCMFr9Ed3vUBBA+1wf
         lCvujv401LMJ3TATmbM0ZDqA2J5ThLpfjKhPKfZlCjwhHzAcqQczIbLz5quaNG6xdWeo
         ZokiWDDuD4RQsHkIGwQbhNM9S2ve952u/AuVxsNvqyU4gwTBoPlQU8pUkrXYRb2nrI6o
         iO2w==
X-Gm-Message-State: AO0yUKV0RF4LYTDXdgz8piEhnFAcqITODzDCJ9RKOfO7bjXYNsvvale2
        gYeTmZotk/BL1KrEEDyhPDiRwg==
X-Google-Smtp-Source: AK7set/QW7HoJeqcF6Mo9eFz7CrxaMTf6JVRoJWLEPu0Mf1tAc7uZYnwwdWflmo7mKLAmuAgpXL5Fw==
X-Received: by 2002:a17:902:dac9:b0:199:4934:9d31 with SMTP id q9-20020a170902dac900b0019949349d31mr9658586plx.20.1676008065432;
        Thu, 09 Feb 2023 21:47:45 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090331c800b00199023c688esm2491029ple.26.2023.02.09.21.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 21:47:44 -0800 (PST)
Date:   Fri, 10 Feb 2023 14:47:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y+XaffiIOVNZu7w8@google.com>
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org>
 <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com>
 <Y+XG4mWPi4X9/hHZ@google.com>
 <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com>
 <Y+XIR64RyVv0EfTx@google.com>
 <CAJD7tkaLtuNL_=WtcMsZ_orSwRMhN3K7vF8PWcxLRXKc6Z8uGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaLtuNL_=WtcMsZ_orSwRMhN3K7vF8PWcxLRXKc6Z8uGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/09 21:15), Yosry Ahmed wrote:
> > > > I can get rid of static const arrays and pass "begin / end" group IDs to
> > > > functions that iterate fullness lists and pick the first head page, but
> > > > I think that enum values will stay.
> > >
> > > Do they have to stay for a technical reason or just to make reviews simpler?
> >
> > We need to be able to do zs_stat_get(class, CLASS_USAGE_70) or
> > zs_stat_get(class, CLASS_USAGE_10) in zs_stats_size_show() to
> > show class's fullness stats.
> 
> If we use #define FULLNESS_GROUPS 10 for example, we can break down
> struct zs_size_stat from a single array to two arrays, one of the for
> fullness groups and the other one for the rest of the stats (e.g.
> OBJ_USED). We can have different helpers to update each, the former
> taking in a fullness value (0 to FULLNESS_GROUPS-1), and the latter an
> enum. WDYT?

You don't like them enums ;) Yeah, this probably can work. I'll take a
look for v2.
