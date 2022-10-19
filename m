Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFF603949
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJSFhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJSFhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:37:12 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383344E19B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:37:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q1so15263265pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaB7r0jtcqd2LLd1zpImUKzyF4vb0y3pjRPBPmzYZ4Y=;
        b=A50nB2myoBrpOIvb3e4Ap+0R9BCF2YinNE2QnvkCYhYLCUUM7DBKYMS6gk092eZU3O
         B2/fZxbo7disNyN568ZmLcCeHRhHlCeI8yn2kVzs5e32APmmUAzE0roYLmvwX7uXrWTK
         sK9lV4oZrZg6wGNBET8UFhqJe7sBndgRlCUaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaB7r0jtcqd2LLd1zpImUKzyF4vb0y3pjRPBPmzYZ4Y=;
        b=BG8REZ+lXQjrxxh423YdsVIwDC/bWc7WJ3FTJuqQjCNgB1aRbOyGNVVZNpLd60SHkA
         Y3hU/oaoiy7K0TgM+AEELJcBDbVjk6NLl5IxWq0EA+HiI87uXqeKvrSnNfgI6CXad220
         fDZ3kn8SLN3u0rADWsOSQnoOhycb5Zm8hTGcMEp2LjgAYb745MOlQJAjdJM8eyk/GLXY
         fEw10L0bkV9yMCUZjSe2RQX6D8O/zR1P/gw8ZPngx7HhdeAAGyE2pWeVuZITLIzDyieS
         IoaiNVcKaRgzvLRmJzZDvuVLzBKs2bY0I6zURTAUIdL1Tz4gxQrNd5Q1nNu85DfEts7e
         UwqQ==
X-Gm-Message-State: ACrzQf3PIqO6GjmuxE5+S7DQUMVsF0wpePOCOmPmFGQlbad9WfNMqtzT
        P5IZYJNRJbYKFtY1RRvsyHc94Q==
X-Google-Smtp-Source: AMsMyM7fiBtyRBbHFGloOmwtzRNGHuoxgWogV6EAP5VJPWG6EE61GeFExwx/EPTvx0a3W+O4+gXIog==
X-Received: by 2002:a63:ed0a:0:b0:442:2514:95f5 with SMTP id d10-20020a63ed0a000000b00442251495f5mr5867397pgi.402.1666157829640;
        Tue, 18 Oct 2022 22:37:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b0017f7b6e970esm9799332plg.146.2022.10.18.22.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:37:08 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:37:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mempool: Use kmalloc_size_roundup() to match ksize()
 usage
Message-ID: <202210182235.3B19DFCB28@keescook>
References: <20221018090323.never.897-kees@kernel.org>
 <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:51:37PM -0700, Andrew Morton wrote:
> On Tue, 18 Oct 2022 02:03:29 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > Round up allocations with kmalloc_size_roundup() so that mempool's use
> > of ksize() is always accurate and no special handling of the memory is
> > needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
> 
> Confused.  If the special handling is not needed, why doesn't the patch
> removed the no longer needed special handling?

The special handling is in the ksize() implementation, so it can't be
removed[1] until all the ksize()-affected users are updated to see their
true allocation sizes first.

[1] https://lore.kernel.org/lkml/20220923202822.2667581-16-keescook@chromium.org/

-- 
Kees Cook
