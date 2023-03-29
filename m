Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442C6CD958
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjC2M1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjC2M1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:27:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6D30FF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:27:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso11328493wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680092855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9utD/b0dx3Ld9K9PQeMcjphZnAINU+9inEgYyc+570=;
        b=q9JhWLQtoVBQ8ZY8ontuf+BPWOWLuklLYmdoKdddmdqzR6QAAoE4F82Wp2wt+zVgnF
         ilaHku5vFkl7+gTWWkMK698wnObj1zjh5xGlmgkAesIXx4zrB5zwVM5lagBCsgQWfF2l
         kb+VttJV2uTb1Uies+Zl/nQPpewB1g7gV9LAeTP/o4bLdtCV2nnwB7oBqwRZYRSIIVcv
         coH4cRk19j3QT8+qM3mkMfDpMRAG37VoKRC7rKJyzLYlgUKrsztscyiV5Zly1VoLdo6R
         y+a8m/XxCy0s564Itj4CLwngUTmtAsZ//u+qMdP0QIv9S7+kT3qyZRxfg3kUrTC7BnfX
         WAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680092855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9utD/b0dx3Ld9K9PQeMcjphZnAINU+9inEgYyc+570=;
        b=cPsRGxwW5jCzMl/q7pJ25z7EsUSJhUuxkKY8E/BZawO2je7FFWc97kZHIarjKU9Mi1
         QP97OTYPIWzYUMN46dPQCyNe/OKIrGNUVFhd4UjGi+ZbwAMsJwsoZB0afAYvI3090l1X
         m3yGiU6HnzwHblDWpLNl3sE5Ksy5epiy41s7TOZ1CtmyiuYCJcCSKhsKeLzC3tf5cS1z
         EVTFiVWJnfoJwRcwtxDiReUxqY/zRLu1HQi/e6pzmhHQMqPQlP8qfsnEc3NUUtAolgpr
         Na+gA94kC18ayZw2qDPTFv1WXUik93HoSD31bsJPzGz6Kbk3fpmD8udNN3GuJ1bxXD+S
         RSXw==
X-Gm-Message-State: AO0yUKVRCtO8zXcCCYs9vP+l005H2J3KbwQG6i1NvqVhqQ1UaWHi27GX
        tPfwLSkyFaek6mxh31mIt15Oqg==
X-Google-Smtp-Source: AK7set9HNMY1Yo3GoPuBErduWgXXAzG5IN+i0ixsLBCno+3Nj1yvZIZpxXgqgnQ+u503ICN6qaN82g==
X-Received: by 2002:a7b:cb95:0:b0:3ed:3033:496d with SMTP id m21-20020a7bcb95000000b003ed3033496dmr14569206wmi.0.1680092855006;
        Wed, 29 Mar 2023 05:27:35 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003f0321c22basm640348wms.12.2023.03.29.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:27:34 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:27:30 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCQussSh5h/GSwh6@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <20230329080758.0e730796@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329080758.0e730796@rorschach.local.home>
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

On Wed, Mar 29, 2023 at 08:07:58AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 07:03:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > struct ring_buffer_meta_page_header {
> > #if __BITS_PER_LONG == 64
> > 	__u64	entries;
> > 	__u64	overrun;
> > #else
> > 	__u32	entries;
> > 	__u32	overrun;
> > #endif
> > 	__u32	pages_touched;
> > 	__u32	meta_page_size;
> > 	__u32	reader_page;	/* page ID for the reader page */
> > 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> > };
> > 
> > BTW, shouldn't the nr_data_pages take into account the reader page? As it
> > is part of the array we traverse isn't it?
> 
> Ah, I guess nr_data_pages is the length of the index mapping, not the
> array of pages mapped?

Yes correct, data_pages[nr_data_pages] and the reader_page being excluded...
which might not be the easiest interface, as the size of the buffer to read
depends on if the reader_page has data to be read or not.

> 
> -- Steve
