Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78172607BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJUQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJUQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:10:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8111A3E32
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:10:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i3-20020a17090a3d8300b00212cf2e2af9so2156982pjc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDqnpfZF/Nba9iYmW6afwPV/BMJnF3T8pQZy3ug2lYs=;
        b=VhgDsydIsST92Z8iLWFT8d537teN8JdhwWV9Y5XaFP3t43g8INhBSMM4r2y9VtiyqJ
         KcVTFWIpbQ9V8f1FNT9bkfza/ITvG0mrZmI1U4ngEjEenk8ZvFon0Ny8Qj8gR2aheBFM
         PLhy3siwCWSHxwLVevJILDvYx1txt2fYHVIdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDqnpfZF/Nba9iYmW6afwPV/BMJnF3T8pQZy3ug2lYs=;
        b=oQmQprBvk+pyQTb+SQUdqkcLvH8v1FIGEWIIYI82rQiigfxZp49ElAOd7L85Kx5Ufa
         3/wpMWNnt3KprtNpgi8Tw/Z2ahOgK9V5VxoXLIeTkOG2dzGK1ufNcZtumCFsgHV5EVea
         h2KgRElQFNvWBHODupx9MwMRYlnm8kBYXuwN2NSEoOkGeiF4ec4saihvn8ZR6fL+vVQR
         j1TS9Z0P2NUpb9vLU6pB+hMYmEIj+NcQWWZgmaTjsmI5fkfjSpggX82cOejyB0d3TmYo
         r8UwUN7vsi8rOPADOeQ8+BHBcVNaUnoYsf8h5TeMvHw237fx7W3YlRh6pJUTjwvtohkQ
         EyFw==
X-Gm-Message-State: ACrzQf3GN8tnF/dgXj9z2b49em5Rp9BZ/2sCkuSowORdiExN338I9guD
        Tqbh1PSI761TlVvAgCz9ZnlijA==
X-Google-Smtp-Source: AMsMyM6M95hLAa5MMJ+J4YgUSd5tsutQHFC5gF7615PbGgrbbJFxj0hfKDmnrgng3LBBSLDfIP/MKg==
X-Received: by 2002:a17:902:cf01:b0:186:810c:d994 with SMTP id i1-20020a170902cf0100b00186810cd994mr2366202plg.151.1666368622967;
        Fri, 21 Oct 2022 09:10:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o125-20020a62cd83000000b00561c179e17dsm15345794pfg.76.2022.10.21.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:10:22 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:10:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] skbuff: Proactively round up to kmalloc bucket
 size
Message-ID: <202210210909.76CDB7A2@keescook>
References: <20221018093005.give.246-kees@kernel.org>
 <0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:42:47AM +0200, Paolo Abeni wrote:
> >  	size = SKB_DATA_ALIGN(size);
> >  	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > -	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> > -	if (unlikely(!data))
> > -		goto nodata;
> 
> I'm sorry for not noticing the above in the previous iteration, but I
> think this revision will produce worse code than the V1, as
> kmalloc_reserve() now pollutes an additional register.
> 
> Why did you prefer adding an additional parameter to kmalloc_reserve()?
> I think computing the alloc_size in the caller is even more readable.
> 
> Additionally, as a matter of personal preference, I would not introduce
> an additional variable for alloc_size, just:
> 
> 	// ...
> 	size = kmalloc_size_roundup(size);
> 	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> 
> The rationale is smaller diff, and consistent style with the existing
> code where 'size' is already adjusted multiple times icrementally.

Sure, I can do that. I will respin it. :)

-- 
Kees Cook
