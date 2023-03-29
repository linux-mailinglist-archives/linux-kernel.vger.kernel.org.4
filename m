Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03156CD637
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjC2JUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjC2JTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:19:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD22114
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:19:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i9so14932753wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680081590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+txe30vDhtHgnvrk0zIQebXvUsjaqIREylV0paQJv8=;
        b=olv5m751kNI53Shjk+qk8/TIk/MOzoC9707V8E3KW3pHmRkhyhzvhPgzYELh8qw/Uk
         j2M6qvbFyfrJ3AgdDNIhqhvR8FICsWXQD9uMtPx/c58sr9jDlrnpBe2kAIXHe2r2y7NN
         GFo7LD0tOtrMgLKthGobo9EM4vna1JX6NMj9bJWKwSp2ztdiHd5JYGjF7viDLJiqJvwj
         jfcTD0fCLk5dXtrbHfGeCL/BD9zlUuEuiSjp+gSmTqAWdn+EcWgoI+Dc3nHRF5D2w1qs
         cXzB5JJC/3sfU1RKkX70lkvzrVOYsCa+PYUnfkJPwRgPFJBquFW6PlfO5vl+S8TY/VvH
         2GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680081590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+txe30vDhtHgnvrk0zIQebXvUsjaqIREylV0paQJv8=;
        b=N80+QdyVVOAzDczrw3pnGsxrOE68MpvRfuCrIYtCSBL7CAMi2gWGxiFsSrmlOop+tN
         t3pYefIilswbbtSxzKFaa0fXM+YhKpYrcnh6Rsf13RHMl4rFmRK/2lS/fiQ8qD443gsR
         Ym2/HsIbLblGhf75YXoNb9SI4NJpNosSOHBKEKvVqSXdA8HM5DNImvzAIXCqUfwn4ish
         +jAG2GlkU54TlVEJRr7v8MNLn6iQmoa7uU+uXIwyb40i7q9F2vpEJjN5KQH4/UrlkAqE
         hW5SgO3QRBaO+4gTJJdGuxuds/FKm41+RE7VTKKQ5L+Xjb22VyhWkTymMNh2fUU3c/vm
         aqIQ==
X-Gm-Message-State: AAQBX9cK2udm7M/QNikb7UtydW6LUaZUhhMw50JIkKfQzgmAIP7nuEQS
        4oP1gaU0NwLm8ltf1LrfwFSOQA/dSzAw5RrrRZGM3g==
X-Google-Smtp-Source: AKy350Ytx2O8awWEuN0J4mPmz48BgQXdUBx1c7DIJnIVNOZuk3633OwdBOvyKb/NluORS1V7+qbsMg==
X-Received: by 2002:adf:f651:0:b0:2dc:f7a7:374e with SMTP id x17-20020adff651000000b002dcf7a7374emr15301224wrp.56.1680081590474;
        Wed, 29 Mar 2023 02:19:50 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm29729072wrr.46.2023.03.29.02.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:19:50 -0700 (PDT)
Date:   Wed, 29 Mar 2023 10:19:44 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCQCsD9+nNwBYIyH@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328224411.0d69e272@gandalf.local.home>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:44:11PM -0400, Steven Rostedt wrote:
> On Wed, 22 Mar 2023 10:22:43 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > +#include <linux/types.h>
> > +
> > +struct ring_buffer_meta_page_header {
> > +#if __BITS_PER_LONG == 64
> > +	__u64	entries;
> > +	__u64	overrun;
> > +#else
> > +	__u32	entries;
> > +	__u32	overrun;
> > +#endif
> > +	__u32	pages_touched;
> > +	__u32	meta_page_size;
> > +	__u32	reader_page;	/* page ID for the reader page */
> > +	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> > +	__u32	data_page_head;	/* ring-buffer head as an offset from data_start */
> > +	__u32	data_start;	/* offset within the meta page */
> > +};
> > +
> 
> I've been playing with this a bit, and I'm thinking, do we need the
> data_pages[] array on the meta page?
> 
> I noticed that I'm not even using it.
> 
> Currently, we need to do a ioctl every time we finish with the reader page,
> and that updates the reader_page in the meta data to point to the next page
> to read. When do we need to look at the data_start section?

This is for non-consuming read, to get all the pages in order.

If we remove this section we would lose this ability ... but we'd also simplify
the code by a good order of magnitude (don't need the update ioctl anymore, no
need to keep those pages in order and everything can fit a 0-order meta-page).
And the non-consuming read doesn't bring much to the user over the pipe version.

This will although impact our hypervisor tracing which will only be able to
expose trace_pipe interfaces. But I don't think it is a problem, all userspace
tools only relying on consuming read anyway.

So if you're happy dropping this support, let's get rid of it.

-- 
Vincent
