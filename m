Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF46C36D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCUQUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCUQUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:20:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F94FF31
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:20:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so11406340wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679415647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4Ra5hFGiWG+UPE75bfuD9gJYCH0sgVcLFGMPcfDw4w=;
        b=FIL2tOs191tYaYzAYYtD+0FgbSA5mgP28x899XLc3H5s/TPBp1nQ0LmUIa3K6nngEI
         d7LD4nuYWRTy85MMVUKhmOlrFmNAEloTj7LllIB/+URzSjNX+lIgtYZgT9DX0r8U0At6
         r2lbXhdusH1gYGfGnQjvtG+tWr9uAbmJFx6vpWEjyissH0/Znq/2Zb+pjQ4BZ4VveI6K
         WIUam2cGjF567ix7O8qOWSWX8zHG2TKGmz5b4GYRbr+/NAKylAeiQnIw+DubdVo657tP
         OoGpgL5eamOBq9OQZb7qrNlgMpYybtsNkbCIppYaG0bbtpLwHznskfFYC8LLgnKKmAfi
         D/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679415647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4Ra5hFGiWG+UPE75bfuD9gJYCH0sgVcLFGMPcfDw4w=;
        b=7aUaiCWvSRkftAuMiJQDeJJKPPmK6PfPvnRyOSfjU1zl5CwPmyOC3F1TKyJ1p9e63P
         tioCQDOZUOn8YFBSHpB0C0QMqmMHyPXCLu/i/JfsVcHsQnfQsWQbTI8tBY1ERh2mk1Rk
         KNDFbur0qbMKFd282445pBocQaugvjcWIPHI/X4eZ+Tt5bQylURjJi0to1EWwvET2SIR
         RaIJTjeqyTexzLfn2Vuqd4dZzxttx/fPsPwJ3w2UT95reDp6CswFnwq7qucwenbNV4iI
         GsVuxnqgfgWjX7/GtOujEf1jG/XgqBMZHDVx6wRw80B/tUfHYh1Dir/0ElKGAY9qZonm
         zk+w==
X-Gm-Message-State: AO0yUKUIXS0wKOFgetSeHwpsfZEFL8E+kqEgOvAxPtXpJfov7/piupMC
        9G2WmWIxuZT8Km2C6H4tpYBybQ==
X-Google-Smtp-Source: AK7set/FK6LztPlEM4J5hp4VTx7XkyNFR8jgKiyMKjuVsloE2RaoRmLVD15X8lU1Nj6IAcUrKt9Jag==
X-Received: by 2002:a05:600c:2114:b0:3ee:97c:58f4 with SMTP id u20-20020a05600c211400b003ee097c58f4mr2949669wml.12.1679415647425;
        Tue, 21 Mar 2023 09:20:47 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id p9-20020a1c5449000000b003dc1d668866sm19972280wmi.10.2023.03.21.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:20:46 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:20:42 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZBnZWhcelEpKXHo8@google.com>
References: <20230317143310.1604700-1-vdonnefort@google.com>
 <20230317143310.1604700-2-vdonnefort@google.com>
 <20230320214516.01c18367@gandalf.local.home>
 <ZBnKe55cvTZybZLF@google.com>
 <20230321114047.3432afbe@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321114047.3432afbe@gandalf.local.home>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 11:40:47AM -0400, Steven Rostedt wrote:
> On Tue, 21 Mar 2023 15:17:15 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > On Mon, Mar 20, 2023 at 09:45:16PM -0400, Steven Rostedt wrote:
> > > On Fri, 17 Mar 2023 14:33:09 +0000
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > >   
> > > > Also, the meta-page being... a single page, this limits at the moment the
> > > > number of pages in the ring-buffer that can be mapped: ~3MB on a 4K pages
> > > > system.  
> > > 
> > > I hate this limitation, so I fixed it ;-)  
> > 
> > Thanks a lot for having a look. Do you mind if I fold this in my patch for a V2?
> 
> Hold off, I found some bugs that I'm fixing ;-)
> 
> > 
> > > 
> > > I added a meta_page_size field to the meta page, and user space can do:
> > > 
> > > 	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
> > > 	if (meta == MAP_FAILED)
> > > 		pdie("mmap");
> > > 
> > > 	map = meta;
> > > 	meta_len = map->meta_page_size;
> > > 
> > > 	if (meta_len > page_size) {
> > > 		munmap(meta, page_size);
> > > 		meta = mmap(NULL, meta_len, PROT_READ, MAP_SHARED, fd, 0);
> > > 		if (meta == MAP_FAILED)
> > > 			pdie("mmap");
> > > 		map = meta;
> > > 	}
> > > 
> > > This appears to work (but I'm still testing it).
> > > 
> > > -- Steve
> > > 
> > > diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> > > index 24bcec754a35..12f3f7ee33d9 100644
> > > --- a/include/uapi/linux/trace_mmap.h
> > > +++ b/include/uapi/linux/trace_mmap.h
> > > @@ -18,6 +18,7 @@ struct ring_buffer_meta_page {
> > >  	__u32	reader_page;
> > >  	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> > >  	__u32	data_page_head;	/* index of data_pages[] */
> > > +	__u32	meta_page_size;	/* size of the meta page */  
> > 
> > Do we want a specific field here? That could be deduced from nr_data_pages()
> > quite easily?
> 
> I rather not have too much implementation detail knowledge in user space.
> It only removes a single entry, and it makes user space easier. In fact,

Ack.

> I'm thinking we should not include "__u32 data_pages[]" but instead add a:
> "__u32 data_start" where user space does:
> 
> 	__u32 *data_pages = (_u32 *)meta_page + meta_page->data_start;
> 
> That way we could extend the data provided by the meta_page in the future.

That'd be nice. Couldn't we keep both to simplify the code for the kernel side?

> 
> -- Steve
> 
