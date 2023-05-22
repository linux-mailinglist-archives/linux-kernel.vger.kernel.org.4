Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF3470C36C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjEVQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjEVQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:29:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD4A10D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:29:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d3578c25bso3966331b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684772991; x=1687364991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAkKcxK0XGy2Mfzb+3G4ZZig1suIGlcPXW3ZGdiAVSA=;
        b=gKMZ7XX4R2VVh8UsICMu0Rsyke0XrW2c+iRdHHRt3WLWOycJO32Iy04zCNODgFfd4R
         D4saMqcStc+sMP83KAqZHxF2yw/+92d97pUSNL7+DK5dQh/BOcnBAvDWU4hq8cJ8XihR
         OQLsKlHjjTFnvdXZubmLG44LfUVnxjSa3p52hs0BL3K4cwahT81s2Hx9+Bdv0qu7aLbF
         ypDYOKDI/6neL9kriVO66DUnXuCexjPu/JMQ3Be9CuN3HLdNfGmSa68Haud473dFlm6G
         uHkL8p193PWUoqP27x/gjhz+62Sa43tbwWREDY4bohSEJx4mwzjNkV4JO3kgrnBTjdwE
         e0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772991; x=1687364991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAkKcxK0XGy2Mfzb+3G4ZZig1suIGlcPXW3ZGdiAVSA=;
        b=LREexvyxQIm5+05V9pnF75QGG6NQKNtDxZmFVcRsCXOXWnL1ZazUooVKgfv1uKnWtm
         zfYyfjDagzXfYFCFxUaRp4Rc6b4q0gs/B9piSOOzqVszys2kKfHmDnXDSpW0F9DtYBzh
         LhvAAnuQVNW3TDk3HUMFZIoXDGee4ehYuPpJiWfoGRtQbFgJxYVYSy/7FCH3kBTAh3Ap
         JyBGby+P13mncwIaXIEvcjdUgWjoXNMWhmcEE0gtktr33LMtRiF8S6wm47NLGbZVlNS/
         Dy7LfkY1NhUvlH5kqkwcM1w4hCmpkAZtg+78nc8nvaROHq6PoEODd2bMgaNI3FEI8qup
         EHXg==
X-Gm-Message-State: AC+VfDyqae6N+XSm0umPE+bYCfYXhMMP9KJPhquc4pwbSMTyFUOvJbah
        Ux3KxjHrPxLfjsxiVPTRlFuwOA==
X-Google-Smtp-Source: ACHHUZ5GdkVEPhjfb0wo1cG4veSdeV7NVtA9Usryrtr3shd7i6atVl1mHOPkqK3UwqkqrLKZFvovrA==
X-Received: by 2002:a05:6a00:1307:b0:64b:256:204c with SMTP id j7-20020a056a00130700b0064b0256204cmr14436082pfu.20.1684772991208;
        Mon, 22 May 2023 09:29:51 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:f7a6:d766:a921:add2])
        by smtp.gmail.com with ESMTPSA id r14-20020a63514e000000b0050f93a3586fsm4597933pgl.37.2023.05.22.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:29:50 -0700 (PDT)
Date:   Mon, 22 May 2023 09:29:44 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <ZGuYeDA9jDlxzfZN@google.com>
References: <20230522171557.32027acf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522171557.32027acf@canb.auug.org.au>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 05:15:57PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (arm allmodconfig
> clang-17) failed like this:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c:146:54: error: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Werror,-Wformat]
> 
> Caused by commit
> 
>   d020a29b6b58 ("drm/amdgpu: Allocate GART table in RAM for AMD APU")
> 
> Reported by the kernelci.org bot.

Alex,
This is the third report of linux-next being broken for clang due to the
AMDGPU tree.
1. https://lore.kernel.org/lkml/20230522171557.32027acf@canb.auug.org.au/
2. https://lore.kernel.org/lkml/20230522171145.38a8bd4d@canb.auug.org.au/
3. https://lore.kernel.org/lkml/20230522170031.5fb87a64@canb.auug.org.au/

Our CI is red as a result.
https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/5045716034/jobs/9053211936

When will AMD start testing their kernels with Clang?

> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks for reporting these, Stephen.
