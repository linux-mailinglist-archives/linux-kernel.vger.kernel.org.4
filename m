Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4B6420C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiLEAbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 19:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLEAbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 19:31:00 -0500
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2282411154
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 16:31:00 -0800 (PST)
Received: by mail-pg1-f172.google.com with SMTP id w37so9087984pga.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 16:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKIUaFMZtVQb2ZrexpCPM8972M5z5pGrf8gX4cPJRts=;
        b=0j8uwktwVT1TI6uphZhASUtsZI8AT8aFnWvsueya/D6L0ZeEbxhWab+pBHhrFHlNAj
         ki0m/OdwO0WQIRhdOdHhwmQqwXAKthMxz4ScspYxyPkwYim45kpdCVI1s5wG0uCepo8t
         /o6JRgs+D2NgtMD28kiveWAIrAvFkewIfMBv1SvoQBGw2Vbhlrous2WA1Ce6Ww4fvoN+
         L7sgaY6V7Y9wq9FZ/fhuTSlAXmFOhLntpRXYHgiVDbS/y+0/PBLkcKd0fB4EbjFB5tjN
         6CVsHgpXxmR76j+60uhoNx7z41NcRG37myU1gmzPxuQ4ME/6NWvEbjKzZ40s6+S+90E8
         /TTQ==
X-Gm-Message-State: ANoB5pmsCJAzqB0hWHUJ4XZlOIFEuspAh42fEjB86NNRHqq3+PRz/9US
        NPfHGx0K2QpJ4pFof5KlBWs=
X-Google-Smtp-Source: AA0mqf6atU2USi/6KyHpJKwAfHY/t/b9TTPZAbJf+Bvt392DcA95YAJGJL7GZhM06aGuPDh9HUVXsg==
X-Received: by 2002:a62:be08:0:b0:574:26df:aac2 with SMTP id l8-20020a62be08000000b0057426dfaac2mr59183772pff.46.1670200259383;
        Sun, 04 Dec 2022 16:30:59 -0800 (PST)
Received: from fedora ([2607:f598:b99a:26e1:80d8:4540:2de3:c7d6])
        by smtp.gmail.com with ESMTPSA id 123-20020a620581000000b005747b59fc54sm8843666pff.172.2022.12.04.16.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:30:58 -0800 (PST)
Date:   Sun, 4 Dec 2022 16:30:56 -0800
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>, Wupeng Ma <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/1] percpu: cleanup invalid assignment to err in
 pcpu_alloc
Message-ID: <Y407wDMKq5ibE9sc@fedora>
References: <20221204031430.662169-1-mawupeng1@huawei.com>
 <Y4yOMmnrT772wFSL@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4yOMmnrT772wFSL@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan and Wupeng,

On Sun, Dec 04, 2022 at 08:11:23PM +0800, Baoquan He wrote:
> On 12/04/22 at 11:14am, Wupeng Ma wrote:
> > From: Ma Wupeng <mawupeng1@huawei.com>
> > 
> > Assignment to err if is_atomic is true will never be used since warn
> > message can only be shown if is_atomic is false after label fail. So drop
> > it.
> > 
> > Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> > ---
> >  mm/percpu.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index acd78da0493b..df86d79325b2 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1817,10 +1817,8 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
> >  
> >  	spin_unlock_irqrestore(&pcpu_lock, flags);
> >  
> > -	if (is_atomic) {
> > -		err = "atomic alloc failed, no space left";
> > +	if (is_atomic)
> >  		goto fail;
> > -	}
> 
> This is good catch. But I think Dennis may not like this way because he
> added the message intentionally in commit 11df02bf9bc1 ("percpu: resolve
> err may not be initialized in pcpu_alloc").
> 

You're right Baoquan haha. I agree with Christoph as well we should
surface atomic.

Though I don't think below is quite right either. We should likely have
a separate warn_limit for atomic and I need to think about dump_stack()
if there are any requirements there.

Thanks,
Dennis

> Can we change the conditional checking in fail part as below?
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 27697b2429c2..0ac55500fad9 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1897,7 +1897,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
>  fail:
>  	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
>  
> -	if (!is_atomic && do_warn && warn_limit) {
> +	if (do_warn && warn_limit) {
>  		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
>  			size, align, is_atomic, err);
>  		dump_stack();
> 
