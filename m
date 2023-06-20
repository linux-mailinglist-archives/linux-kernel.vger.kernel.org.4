Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5E7376D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjFTVzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjFTVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:55:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5321994
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:55:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b51780bed0so41946215ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687298112; x=1689890112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GP+1yPJGQXBVbH4/DlMCMad/0nWk3P8mFgF5T5xNOw4=;
        b=XVoVwjlSvjl+SBgNleXARK8FxQbDv3tAtT6FguRxcYoNvP+FHyUWw0Bl5/D4s/uIx/
         OynC8mjSU1y6OjlZbH1bh5pMhGkUUOxL0XuB/0i5KuATUZYXcqemuMSv64aBR1LmvyV8
         50b9TUwSyW2Sxz+z6OKZ5R5i80aqnlsKeHkX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687298112; x=1689890112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP+1yPJGQXBVbH4/DlMCMad/0nWk3P8mFgF5T5xNOw4=;
        b=NlGU2pGLpjy5AfMb2q83x3G7ZGuOKUd0+myh8lgIzAS/KsUXReolPxd5YSOZSGyp8V
         4cBVLnexuwaBOXWs8+Ut+NMULa3aFkCWmI8fgfhuzGbe1BHcSToQUUyhr0+i2jAOZUCK
         9AVttmaDeJp7bu/6gfBg3ybC+9toShRsApK0mRhVNajReuAVPryXG7ViuINwOFz0Pfj5
         tr6cvArDceol4ga2JlYQGwpdNKV+yRNWHxSC7WxffcDKR81YxB01BKk5jl4cuZK9AM5P
         5b4RD1CU6ij//LE3YmKnLrtQeZ6blPd2qYAmscKR+sdjurMpyWFsCKdtRzoCz69lS7wA
         lo+Q==
X-Gm-Message-State: AC+VfDwxQQC8FBGh8nB80k3hLaxrLtc1wRU97wuzLXl/wYQma3x+1hHj
        9V6GcnLWm+NkqzA0AkCnChg2H5fnscWa4m/W3es=
X-Google-Smtp-Source: ACHHUZ6n5o+b1RB8UIA3P6uwWhu1Pn/NZESuSUHrFzr5zm6ymvxmUqCPR18s8KoGSOu6Y0+UNIZkMw==
X-Received: by 2002:a17:902:ef8c:b0:1b0:378e:2768 with SMTP id iz12-20020a170902ef8c00b001b0378e2768mr12959877plb.7.1687298111990;
        Tue, 20 Jun 2023 14:55:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001b01fc7337csm2033424plb.247.2023.06.20.14.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:55:11 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:55:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] x86/fineibt: Poison ENDBR at +0
Message-ID: <202306201454.0A2E875F@keescook>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.194131053@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615193722.194131053@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:35:48PM +0200, Peter Zijlstra wrote:
> Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
> booting on IBT enabled hardware obtain FineIBT, the indirect functions
> look like:
> 
>   __cfi_foo:
> 	endbr64
> 	subl	$hash, %r10d
> 	jz	1f
> 	ud2
> 	nop
>   1:
>   foo:
> 	endbr64
> 
> This is because clang currently does not supress ENDBR emission for
> functions it provides a __cfi prologue symbol for.

Should this be considered a bug in Clang?

> 
> Having this second ENDBR however makes it possible to elide the CFI
> check. Therefore, we should poison this second ENDBR (if present) when
> switching to FineIBT mode.
> 
> Fixes: 931ab63664f0 ("x86/ibt: Implement FineIBT")
> Reported-by: "Milburn, Alyssa" <alyssa.milburn@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks like a good work-around.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
