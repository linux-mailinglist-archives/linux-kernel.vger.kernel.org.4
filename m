Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC76155F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiKAXKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiKAXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:10:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A38205E6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:07:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v28so14651535pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hzrs2JtUwGOjaOengdaNzpSa9PDpmjDB1uY9BKaG18=;
        b=Pi9hwo+vMzQw3RURoG81hI9tUFyAfoPZyhWJnOYk0hLdM5fRYC9zgOqEkTd8D5cL4u
         f7zbsuEZP+MGM9r0Q4etkIAMGAvsOg50uayS16sLaxK4HNCsxCSXmxciwCJ2pBD07Qa2
         aJFCVFiaoaiM78uPOd7qxeHUtUBCBk0yA5Df0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hzrs2JtUwGOjaOengdaNzpSa9PDpmjDB1uY9BKaG18=;
        b=m/pErnVn7Wl6uuWkV1ewcMuYzdFSV5k0xbNf0WGifOylt7HPjK92Ig89Q4SRqLQKgn
         j8PguDSH6GUQKjN1fd3exCWfU1BnaW9avpnl9qx2bKMO7v+t3tZoPBk3PzXqR/XaqWAj
         P30jZ068UjkvArfhGwUGPCb5tCqJqpmP9K8+a/FlZkDa41mcGCAu0+4MQhac2RqGuJg4
         wNmpqGoB5YZZHo/bR0//PKl9V+v+hjsOFW2JabIyAboJslbRS98ktfXDKFdB8CWgF6Ye
         L2tFVqUD4TSujf3Ym2ozGyux7cbB3BMQhFEcBMBFC5DFR8TTuxpWOCN0pTwAh5Y97Oiq
         FpgA==
X-Gm-Message-State: ACrzQf2H1YSNjFZlJCKpOJ74c1oiKqOm9kHT3JJIyFoweyKzm2PU79hy
        DC6ZY8czceGPDY8T3z7VybroKQ==
X-Google-Smtp-Source: AMsMyM7M6H5/TVn9fRrJDxFZE+XrRJk/D7/3VkInJuDFAyQHPIeK+l9/08jMdsvwrIfc4l/i6NudaA==
X-Received: by 2002:a63:5307:0:b0:46f:b6e1:1f15 with SMTP id h7-20020a635307000000b0046fb6e11f15mr11975152pgb.163.1667344076487;
        Tue, 01 Nov 2022 16:07:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l126-20020a622584000000b0056dde9895e2sm1373910pfl.30.2022.11.01.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:07:56 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:07:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        dave.hansen@linux.intel.com, David.Laight@aculab.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, llvm@lists.linux.dev, luto@kernel.org,
        mingo@redhat.com, torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [RESEND PATCH v5] x86, mem: move memmove to out of line assembler
Message-ID: <202211011607.C9814760@keescook>
References: <20221018172155.287409-1-ndesaulniers@google.com>
 <Y08NJohEeoYX2aIf@thelio-3990X>
 <202211011534.C31FC5ED6@keescook>
 <74ab03dd-46c5-a79e-c256-e4e4ea0341e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ab03dd-46c5-a79e-c256-e4e4ea0341e0@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:58:03PM -0700, Dave Hansen wrote:
> On 11/1/22 15:36, Kees Cook wrote:
> >> Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Can an x86 maintainer please pick this up for -tip?
> 
> Queued it here:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/asm

Thanks!

-- 
Kees Cook
