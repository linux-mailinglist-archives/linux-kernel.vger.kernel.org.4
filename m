Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D726D08AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjC3OtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjC3Os6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:48:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330769ED8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:48:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o32so11088052wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680187733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4OohPlRc6cXjWGAaBe3MyDvgleJXKEjuRcyG613iUs=;
        b=p/TPCRpMTv8kROX09sg6YeUktmFZjYDMcsPXN6YJout4HuGxMo58ztuU++660YaJSc
         Y2O7JDveKuEUcCXMtWmfF1PTzyskoQOgylg2tNPOYBcMJdMcrKvVCT3dfz2xxc07vBcc
         4rETFmDM+8V0bCu6QWETcs+qXQrTYkBFCiBLr5lXTzLdY85KE4L1Xv5/Ym7BBqggda06
         jxAlObFWDE0AZChQ0q0wRxb/r7XUayqb0QrsuoLb10RoWzHelWS3R9wdER0wsEP51KR3
         CGOGNTyzu6z7KbdJDbl5NPTYEVN6H+v/N2Xg7SmIIVMj9zMJnvVlPzv7st4tKjruiIZi
         rwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4OohPlRc6cXjWGAaBe3MyDvgleJXKEjuRcyG613iUs=;
        b=2HpudN5TJo8AhQYxblsNhmmrHY+ytnhhK+/OVzmeoUdR+1ztSSObGaTQZIzXHgczMR
         0ZR3ByMbEI39wNqUtRQ2XHQaFqI7lR6aBFbYlOlIsDsR+bYJcJE5qn0JRO8wtaHLzBwa
         G1PbyMn7sBzB/FAexHBwILrWmBp6P1G/4M5uOUVQLkNsW2P5I3bLc2GPUs7LZjjtSO9O
         Ch8IGpbIDpjevPasUz0cp7pUhOaiWIVSTgXS+QHjFys9KsFtKneaF0Fy6ukbd4LyOqib
         6S9xcFvCj6qwp9eDjDCla06VHs3GaNHYwdXq26R4Vb6Zdqm4EX/P2yMDCydeLhTIMLfD
         bYtQ==
X-Gm-Message-State: AO0yUKWpvMGwDNHWJjcydbqsu7J2qbWhvMEkcF1YwrGx0XJPYuJkyW9F
        haL5j+AYffOgj9gIs5xuvn7X8Q==
X-Google-Smtp-Source: AK7set85l90lpdHO2bV1kTQ/3yTRpajQqMjEe/odNN3gnJgo+sMiHv2GHTm1cQHFVFP/XvyGojEY3A==
X-Received: by 2002:a7b:c38a:0:b0:3ed:5d41:f95c with SMTP id s10-20020a7bc38a000000b003ed5d41f95cmr18193029wmj.11.1680187732905;
        Thu, 30 Mar 2023 07:48:52 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003ede6540190sm6665973wmq.0.2023.03.30.07.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:48:52 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:48:48 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCWhUJkD0cgSjwkW@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <ZCQtpbyWrjliJkdg@google.com>
 <20230329084735.6c4a9229@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329084735.6c4a9229@rorschach.local.home>
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

[...]

> > > struct ring_buffer_meta_page_header {
> > > #if __BITS_PER_LONG == 64
> > > 	__u64	entries;
> > > 	__u64	overrun;
> > > #else
> > > 	__u32	entries;
> > > 	__u32	overrun;
> > > #endif
> > > 	__u32	pages_touched;
> > > 	__u32	meta_page_size;
> > > 	__u32	reader_page;	/* page ID for the reader page */
> > > 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> > > };
> > > 
> > > BTW, shouldn't the nr_data_pages take into account the reader page? As it
> > > is part of the array we traverse isn't it?  
> > 
> > It depends if the reader page has ever been swapped out. If yes, the reader
> > would have to start from reader_page and then switch to the data_pages.
> > Which sounds like a fiddly interface for the userspace.
> > 
> > So yeah, consuming-read only feels like a better start.
> > 
> 
> I agree. I'd like to get something in that can be extended, but simple
> enough that it's not too much of a barrier wrt getting the API correct.
> 
> -- Steve

Something I just realized though. In the event of being able to upstream the
hypervisor tracing based on the ring_buffer_meta_page, without non-consumming
support, we wouldn't have the "trace" file which is used to reset the buffers.

I'd guess we'd have to either create one that is read-only (a bit strange) or
let trace_pipe reset the buffer(s).
