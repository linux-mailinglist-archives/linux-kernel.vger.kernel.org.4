Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26835F7180
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiJFXCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiJFXBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:01:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BE4FFF99
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 16:01:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so3149012pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5lHHNxEaw1N/qiNsX/rZAMgE4JCMxOihLZEqjiwD3Cw=;
        b=UHQCpECQbmOofvKvJGmZP0kvMdNgl4biR1ihxCVbMojpao1VL+iUW/hxrOsd+Gwm4o
         riePqZBQywLj53+7yV9mye0bOBGYGQCT68w3AAvYjAgcaAbzMvzFPg+7JXk10fX00EYp
         jTBHm7xM+VInwkMHzdrGhODgSo+YDOJGuPUNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5lHHNxEaw1N/qiNsX/rZAMgE4JCMxOihLZEqjiwD3Cw=;
        b=D+wpzl+NFdG/MUfUZzk6JLbWbe6OlI7IgHtqSpWos42KeU2rFpyjv9t6lhR+y7en5J
         pTLtg1inuE6zf9+qaddBSvqmbnHz9FXDBsPKZh/8vch2GxS8325hhYl6yZu64AP6+R76
         VbwOhmNmXCVesvi2iV2tNPxOBPQg+GYrUG54YIaMCDQfBUuVbz5y1dccubSRpUrYhLwt
         RfA7pp2VA5PWsM3Rr4J9ryEZw6O0nwSRzdlxVwLvxfIfmlBl+GPnATWP28paQ1qFK5pn
         hyT6k0gxVd3M694q8jpDokhBEDpzRdzHIkWaXfCoFyTnG0yNtbnr0vQbKywYZ3cA4MT5
         MVMg==
X-Gm-Message-State: ACrzQf3xBtphkYWdqCZIhvcrOlDtuO/fcE9RdVYn6evlTCS0FPxTgXdL
        4A8xM8w8NDwuZjXiJw3xXZ678Q==
X-Google-Smtp-Source: AMsMyM5WbrKYoemcqZEbVaft4QIlTUAzKU/G+QDttz1riQII4W8oSyZcqTd/hNVbxTpH6I1LSXR/lQ==
X-Received: by 2002:a17:90b:1b06:b0:202:cce0:2148 with SMTP id nu6-20020a17090b1b0600b00202cce02148mr13141905pjb.84.1665097301152;
        Thu, 06 Oct 2022 16:01:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79f1d000000b005627d995a36sm162160pfr.44.2022.10.06.16.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:01:40 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:01:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, gustavoars@kernel.org,
        dlatypov@google.com, gwan-gyeong.mun@intel.com, nathan@kernel.org,
        trix@redhat.com, llvm@lists.linux.dev
Subject: Re: [PATCH v2] overflow: disable failing tests for older clang
 versions
Message-ID: <202210061600.84A665DA2B@keescook>
References: <202210061321.xSA91B7C-lkp@intel.com>
 <20221006171751.3444575-1-ndesaulniers@google.com>
 <166509712398.1833114.15283539764161050044.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166509712398.1833114.15283539764161050044.b4-ty@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:58:49PM -0700, Kees Cook wrote:
> On Thu, 6 Oct 2022 10:17:51 -0700, Nick Desaulniers wrote:
> > Building the overflow kunit tests with clang-11 fails with:
> > 
> > $ ./tools/testing/kunit/kunit.py run --arch=arm --make_options LLVM=1 \
> > overflow
> > ...
> > ld.lld: error: undefined symbol: __mulodi4
> > ...
> > 
> > [...]
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] overflow: disable failing tests for older clang versions
>       https://git.kernel.org/kees/c/2d4df670c64c

I sent a follow-up that refactor this -- I realized I actually wanted to
see "skips" instead of just having the test go missing.

-- 
Kees Cook
