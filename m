Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33BF6CDB45
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjC2Nzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjC2Nzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:55:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AAD55A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:55:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r29so15791626wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680098146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5sS6hIligRwcqX+HuHvn8/2GDNoX51QaujOMWxpe7AU=;
        b=K+GzJ6RftPrZ4TkI16zgUoNNvNFNN/06XSZ5iNL9LM6locQs2jVJuWBEdCXqRsDUvT
         p+XyRmfr4y8KRdIp8JmnF7yCBFV2z2XecAAS+20E99Tpyq2pMqbPD+QZ6vqTVCN+MAuP
         QHhnTH4jPiVo9O1do7/Nk253dXDogkwAEf1padyjhMVIrZdAl4a1gryD6YBbIVsRwiL9
         09QCPQxUMeoOXnEMQC8XsmINdrK++6USOnWLiJwbgfsvq7foYbQztkNT2c1BCRG0IhST
         SiAzYsJ3JzsRNW/OrIPgN4xncR/g07Fo3bN0o1+cBfnNsAsLtDwr2naK2Qk0JS3dbbVR
         Oa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sS6hIligRwcqX+HuHvn8/2GDNoX51QaujOMWxpe7AU=;
        b=U27/cEMIBs2qOBuiXfedIsDqPTrF6rmBKLT64tWUMH4fAYRod3EhkMMv4RSZ9HfEhv
         NQw7XC+ue5aBbvHxCMbukY1ZvdzjILSZOLqCw7WPRdZ2CDIJzjD/wSYCXTqnA/F4iN5U
         mHtQzSFkvpMDJx/tnRQYTSJg5ItvTuIOvlMBRjke8ZlSYUcpDImxLDrNW7h6qB+tEAjY
         6mKL/z8gtIhOgkneg72DvTUs5BWVRkAzfc8pzjb3t82b3QJIv+jGJXnKBqQHIITKYRAa
         pBZfaaERniAbzH9IA4X/Kw1QIZy8/KS1cugFZvul7dwGQk2JeFON7mTQWhB0r+YiW2A+
         w2Cw==
X-Gm-Message-State: AAQBX9eRArityKhNlt2Iuk81/jccc+qI/GtgS1YphfA3jPurq/XYas3d
        f0Oz4gqa7E1uqAgHzDD9WoBlEQ==
X-Google-Smtp-Source: AKy350aYJvtp0isKT/2+hPCG2ua2MDGKgrQyfUY3RcE1WM0rLAGmvOhlTzSEadT8Wb7SJyyJ2jvbJA==
X-Received: by 2002:adf:f3cf:0:b0:2ce:abff:7156 with SMTP id g15-20020adff3cf000000b002ceabff7156mr17425341wrp.48.1680098145675;
        Wed, 29 Mar 2023 06:55:45 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id l12-20020adfe9cc000000b002cea8e3bd54sm30372427wrn.53.2023.03.29.06.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:55:45 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:55:41 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCRDXaTVfNwxdRJZ@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <20230329085106.046a8991@rorschach.local.home>
 <ZCQ2jW5Jl/cWCG7s@google.com>
 <20230329091107.408d63a8@rorschach.local.home>
 <ZCQ9m5K34Qa9ZkUd@google.com>
 <20230329093602.2b3243f0@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329093602.2b3243f0@rorschach.local.home>
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

On Wed, Mar 29, 2023 at 09:36:46AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 14:31:07 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > We can say we update cpu_buffer->reader_page->read on the get_reader_page ioctl,
> > to the most recent value possible, which will have the consequence of actually
> > "flushing" those events?
> 
> Yes. It should be no different than doing a normal read of the
> trace_pipe_raw file, which does the same.
> 
> > 
> > If the reader decides to read events past this value then it just can't expect
> > them to not be duplicated?
> > 
> > I suppose it'd be down the reader to store meta->read somehwere?
> > 
> >    prev_read = meta->read
> >    ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE)
> >    /* read events from prev_read to meta->read */
> 
> Yes, in fact it shouldn't need to call the ioctl until after it read it.
> 
> Maybe, we should have the ioctl take a parameter of how much was read?
> To prevent races?

Races would only be with other consuming readers. In that case we'd probably
have many other problems anyway as I suppose nothing would prevent another one
of swapping the page while our userspace reader is still processing it?

I don't know if this is worth splitting the ABI between the meta-page and the
ioctl parameters for this?

Or maybe we should say the meta-page contains things modified by the writer and
parameters modified by the reader are passed by the get_reader_page ioctl i.e.
the reader page ID and cpu_buffer->reader_page->read? (for the hyp tracing, we
have up to 4 registers for the HVC which would replace in our case the ioctl)

> 
> That is, it should pass in the page->commit that it used to to read the
> pages.
> 
> -- Steve
