Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE35E866A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiIXACa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiIXAC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:02:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92CDE9CDC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:02:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d82so1514003pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uwWHKTBUfGcFVTaOUVwPmGZghDdGoVP1x2kZ8BP8vOM=;
        b=RKRcCCQOEegIGp9Kp5ycDoiHOP//JJ9+RoMWBBE/tT+ADQ1xSXeFaHdMRAdeeOVdjv
         JNyMNVtYA8GaY/PMBnlrlZfd71KOTONFtaxCaEQylEg7aCR/AM77hxjqr4MyKdW6YFNr
         Xv2o/4YNvWpqI2hO6BJEwWbV0Xm44BemCPUEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uwWHKTBUfGcFVTaOUVwPmGZghDdGoVP1x2kZ8BP8vOM=;
        b=R+H//y3YbqFimECFxMjJLT45Ixo7IM6AlYK/PacprUxTlbSDOQ1FcpKJ1RjDLnfGMj
         rdWSZXtz5JNulvTp5pMmFIZPJzrMrSEgJL5RMAOvy08KZQnbcRrzovE6kbojYu/Yi1nA
         MepsMJu7vrvY5ikz3yIPiPmtn1mrnOLAHGgU0Kp6Cvc2HoFjtFo1jzore8XjL9G0bhcr
         rDXugNf1j24G7fqzpi+FUTffwkKLVO+VARQVuB23AeROiy9OCk6l4pHfemJIZx/+WoCp
         2/BdyET1ylgSbZThq4IXEK6cdo5XNP9/TyTxDXKZTELJUydIPYnqFVV5U/2Ud+aYb3PU
         HUow==
X-Gm-Message-State: ACrzQf3h1PcF5WbUYDsYDQs16/rBDF7xYiuse8lO5zb/dXUhIPUKcBgf
        4Xq9pjpwrFU78XbvC2pffmbS29Foz7Wa4w==
X-Google-Smtp-Source: AMsMyM7eId/9umQhWkkXNHCXUCgFjcCZku4cRPDA9BzG7uU7l0yzvR3cw2z0nS/D0pyoCCRO6H9QCQ==
X-Received: by 2002:a05:6a02:309:b0:434:efcb:ccf4 with SMTP id bn9-20020a056a02030900b00434efcbccf4mr9579548pgb.304.1663977747203;
        Fri, 23 Sep 2022 17:02:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l23-20020a17090a071700b002005fcd2cb4sm2198979pjl.2.2022.09.23.17.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 17:02:26 -0700 (PDT)
Date:   Fri, 23 Sep 2022 17:02:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <202209231656.AD14FB6@keescook>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com>
 <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 03:54:12PM -0700, Andrew Morton wrote:
> On Fri, 23 Sep 2022 17:40:01 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> 
> > Currently the clamp algorithm does:
> > 
> > 	if (val > hi)
> > 		val = hi;
> > 	if (val < lo)
> > 		val = lo;
> > 
> > But since hi > lo by definition, this can be made more efficient with:
> > 
> > 	if (val > hi)
> > 		val = hi;
> > 	else if (val < lo)
> > 		val = lo;
> > 
> > So fix up the clamp and clamp_t functions to do this, adding the same
> > argument checking as for min and min_t.
> > 
> 
> The patch adds 140 bytes of text to mm/memblock.o, for example. 
> Presumably from the additional branch.  Larger text means larger cache
> footprint means slower.

Oh, interesting. I had spot-checked one clamp-using function (update_cfs_group)
and it produced the same output just with some register swapping and other
ordering changes. Hmm.

But yes, text is bigger, but bss is smaller. This are my allmodconfig builds:

   text        data         bss          dec       hex  filename
43779952    59510881    28684428    131975261   7ddc85d vmlinux.before
43781295    59510889    28676236    131968420   7ddada4 vmlinux

> So where's the proof that this change gives us a more efficient kernel?

A reasonable question. :)

-- 
Kees Cook
