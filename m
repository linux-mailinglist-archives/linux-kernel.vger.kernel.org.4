Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65228612F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJaEEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaEEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:04:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F177662
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:04:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b29so9611184pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvB6GEhcvHb8LBDNupJUpWNS+VEp7MFsv/1LrElM5EA=;
        b=e41yXHTbx8iQZaHXMmRxz7gEPbUjUa5mMwbt6Lt+s8zRo2DTPob1zvK/rO4qfOk1pW
         aoWf5DKwhW0jcVw6ABwlGHFlNeV/awFrCYcNaww0RcqWmkYVQSkzJQJGoNcVty1Fg23i
         iJLGAYzqTNmgBddzAKuUjDX0Xg1Ng9nMG5IWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvB6GEhcvHb8LBDNupJUpWNS+VEp7MFsv/1LrElM5EA=;
        b=fud3c5MOjsQzr5dkJfNLKh97Ds1UP6BG+rBqZMYXg+z6dT9svZzN0r/3yiqqi6Nsmb
         dFZ5dG6CJ5R5iCO6seLa3UjqiQFqwZKQuImagS+fh+CPudvZrRxdZb4oIXG677Drq0I0
         XoIfTPf4+lGWXU7Zz5I3OO0xWylmrGnYrHU7mer10uCrPA6oaCF/+hShMBCx+d8ZEi4j
         fvsn2yvVNyisioentYEQbTdNlp818/TvHjDA9C6kTOpDBkgjm0S873/19b2Wa4Rc6ybG
         NK72kEhsh6zP51PR1HqwbQfw6whIK6/jHX3jG5/7bMNnwh048tTpd1cImnt/eyeqH+Ab
         zClw==
X-Gm-Message-State: ACrzQf3OjVE+e/Fn7eAwoP9IUVVUrJT6m0N28wtkVUkGSSlYW1iwJJj+
        +NSbZTw1kZypN5X7eDYfU00GWw==
X-Google-Smtp-Source: AMsMyM70/kA2cwuvuBLIndujVdfAEyx+eWFYmcl6dKIltLN/SQnP54qg+OfNoK1fY+wDPrqFpl+1SQ==
X-Received: by 2002:a62:b40a:0:b0:56c:6c63:fdb2 with SMTP id h10-20020a62b40a000000b0056c6c63fdb2mr12308335pfn.4.1667189059638;
        Sun, 30 Oct 2022 21:04:19 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f624:9e85:ec7a:fa29])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a7f8200b001faafa42a9esm3135266pjl.26.2022.10.30.21.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 21:04:19 -0700 (PDT)
Date:   Mon, 31 Oct 2022 13:04:14 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: apparmor: global buffers spin lock may get contended
Message-ID: <Y19JPtZbDlT4MQRB@google.com>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/30 20:55), John Johansen wrote:
> On 10/30/22 20:52, Sergey Senozhatsky wrote:
> > On (22/10/28 02:34), John Johansen wrote:
> > >  From d026988196fdbda7234fb87bc3e4aea22edcbaf9 Mon Sep 17 00:00:00 2001
> > > From: John Johansen <john.johansen@canonical.com>
> > > Date: Tue, 25 Oct 2022 01:18:41 -0700
> > > Subject: [PATCH] apparmor: cache buffers on percpu list if there is lock
> > >   contention
> > > 
> > > On a heavily loaded machine there can be lock contention on the
> > > global buffers lock. Add a percpu list to cache buffers on when
> > > lock contention is encountered.
> > > 
> > > When allocating buffers attempt to use cached buffers first,
> > > before taking the global buffers lock. When freeing buffers
> > > try to put them back to the global list but if contention is
> > > encountered, put the buffer on the percpu list.
> > > 
> > > The length of time a buffer is held on the percpu list is dynamically
> > > adjusted based on lock contention.  The amount of hold time is rapidly
> > > increased and slow ramped down.
> > > 
> > > Signed-off-by: John Johansen <john.johansen@canonical.com>
> > 
> > Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> yep, thanks for catching that

Thanks for the patch! Unfortunately it'll be a bit difficult to test
it right now; I'll probably have to wait until corp pushes new kernel
(with the patch) to build boxes.
