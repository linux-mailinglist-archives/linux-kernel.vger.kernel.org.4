Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3ED712A83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjEZQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjEZQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:21:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006CD9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:21:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d24136663so850590b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685118073; x=1687710073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mX5+bjBBZlaoKw7taDUef0eZ0B/7aaJbLLfQ646in4U=;
        b=dEjqUnr4j4gcR0Vx5ZawmCnVcL1lGxH3zJtPCZiuDv+vUCTSZi4+fTGf+Snya2As5j
         E1B9A3kXDH5vKZDyHZkz2ycBza3FewyuJM9IfbCvHg8mGReom4T4ydBUpT68aAHMB+36
         5JwVjDBMWVZQbIi5QwdVaSBHTffYQeIQmaOrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685118073; x=1687710073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX5+bjBBZlaoKw7taDUef0eZ0B/7aaJbLLfQ646in4U=;
        b=My+3co9SxJj84rty6r1PRtryGELx5D6hMHB+IhVAxBrvHbGZ8wRpcXRdovp1iJalWb
         uXf3KdR/82txWD7YMODKR7x2tiQtoJTR8VuqVsk6eLZtT8z48djahrpsawMKprr0HgMy
         ugu1RQGaBlBfFgYVLDyEJUaGk5/ahO6Ofwde3u0wReHyK+b7ArwZCzeSsvdmBkdG2N7s
         XOmrrntz7FjY4S27goZDV/MszQpPUPh9BGuVIH4d4wfoQOsxJ5C0hvCvSdMmxk+f4ThE
         3PebFxVcZYJYrZ6n/AVuwj9657ckiB6FH9fQ9rx3u142q5vj63glMTqf5XZoZzUryk8p
         5DOQ==
X-Gm-Message-State: AC+VfDwnBpxzw0rQWRtBWTSas88VSJR+cUX1lGUYdqATk7AB7NvsMrMl
        NN405CfoyuQmdSMCL+HETRE3BA==
X-Google-Smtp-Source: ACHHUZ6SThSNDpsJaexFEwJQGQKuvbaxx80fqRKRO38s56UC7FukaoFZxBvofbaE4WeyWP+gyL/mUA==
X-Received: by 2002:a05:6a20:9146:b0:10c:9773:5e6 with SMTP id x6-20020a056a20914600b0010c977305e6mr3121676pzc.47.1685118072839;
        Fri, 26 May 2023 09:21:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b0064d4d11b8bfsm2916467pfi.59.2023.05.26.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:21:12 -0700 (PDT)
Date:   Fri, 26 May 2023 09:21:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     cai@lca.pw, mcgrof@kernel.org, thunder.leizhen@huawei.com,
        vincenzopalazzodev@gmail.com, wedsonaf@google.com,
        pmladek@suse.com, ojeda@kernel.org, peterz@infradead.org,
        alan.maguire@oracle.com, stephen.s.brennan@oracle.com,
        samitolvanen@google.com, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, v.narang@samsung.com
Subject: Re: [PATCH 1/1] kallsyms: remove unsed API lookup_symbol_attrs
Message-ID: <202305260920.BE175FAD@keescook>
References: <CGME20230526072134epcas5p12d0971c15890541639b4d2d85db84b43@epcas5p1.samsung.com>
 <20230526072123.807160-1-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526072123.807160-1-maninder1.s@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:51:23PM +0530, Maninder Singh wrote:
> with commit '7878c231dae0 ("slab: remove /proc/slab_allocators")'
> lookup_symbol_attrs usage is removed.
> 
> Thus removing redundant API.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Yeah, looks like this is unused now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
