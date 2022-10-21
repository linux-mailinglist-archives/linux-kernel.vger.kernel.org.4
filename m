Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225960824B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJUXzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJUXz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:55:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38AF15A8C9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:55:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso4195995pjc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NauDNm3jBWiCgXR4IN02JsXfx81Choxl2/vrkb1uETY=;
        b=WsmOiKZBCb3yyWq4RW+IngA9rQ/VWhpKZ9ltvVEj+XiT4noUaEI5sAYeiod8RVFlFM
         iSuXHRg8B8Ioq2h7Yt023FLU5h8DXBcBrsx+VW6c6WUf7JrssNkaRPmIoPzfHLANpLmf
         0R+ItH4Y8TaHwhsh+7F3cu7HQ1sy7iMqHODJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NauDNm3jBWiCgXR4IN02JsXfx81Choxl2/vrkb1uETY=;
        b=E+7iB9qHLd1oMnFbt8SnNg1fwZdJLxmhk1wmFnUBF8X0aKikufddZYFRSiMdzSEftt
         AwvAiQERMJuelLADkqfiB1oy58k6knCh1LPnxv7gg436wJCMJ2gzHE+B1aXJBUWKhu/L
         xpW8GXHSUyx/M6EjEW6MgoFdWpd9m+BQH+xOK2mk7QWKihXLk6rPHM34l4qStLGAkU4o
         fpefM61PIz3KqfI5x/lJNl1033RdlPQbHk7l0scHxHVShaHsO7Zw+4R5l0q6WImhO2xh
         H0ouFa/TarueIcbeNeIgrlg2z8qt0Orz3182vZgUaVlTrf6bmsZunLKr+uQibi0RVqhQ
         ctfQ==
X-Gm-Message-State: ACrzQf2M/bg+SCdbWM5lPf3GBgd5iMefGAt3DtU7oWoOxQU8gJkUGlM5
        XaRum6AgyWOzjEtnuz0eZYQlRA==
X-Google-Smtp-Source: AMsMyM5ArtR9zfMxnhjI2vfQ2NYqyPDaFNP2nvimb+Eodo+HCXJnMeWDtEYpslyX3E/O7fCPxsBu7w==
X-Received: by 2002:a17:90a:a415:b0:20a:f813:83a3 with SMTP id y21-20020a17090aa41500b0020af81383a3mr25423100pjp.238.1666396525632;
        Fri, 21 Oct 2022 16:55:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u14-20020a63d34e000000b0046b1dabf9a8sm13942760pgi.70.2022.10.21.16.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 16:55:25 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:55:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH 1/2] x86: Separate out x86_regset for 32 and 64 bit
Message-ID: <202210211655.65734A3F@keescook>
References: <20221021221803.10910-1-rick.p.edgecombe@intel.com>
 <20221021221803.10910-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021221803.10910-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 03:18:02PM -0700, Rick Edgecombe wrote:
> In fill_thread_core_info() the ptrace accessible registers are collected
> for a core file to be written out as notes. The note array is allocated
> from a size calculated by iterating the user regset view, and counting the
> regsets that have a non-zero core_note_type. However, this only allows for
> there to be non-zero core_note_type at the end of the regset view. If
> there are any in the middle, fill_thread_core_info() will overflow the
> note allocation, as it iterates over the size of the view and the
> allocation would be smaller than that.
> 
> To apparently avoid this problem, x86_32_regsets and x86_64_regsets need
> to be constructed in a special way. They both draw their indices from a
> shared enum x86_regset, but 32 bit and 64 bit don't all support the same
> regsets and can be compiled in at the same time in the case of
> IA32_EMULATION. So this enum has to be laid out in a special way such that
> there are no gaps for both x86_32_regsets and x86_64_regsets. This
> involves ordering them just right by creating aliases for enum’s that
> are only in one view or the other, or creating multiple versions like
> REGSET32_IOPERM/REGSET64_IOPERM.
> 
> So the collection of the registers tries to minimize the size of the
> allocation, but it doesn’t quite work. Then the x86 ptrace side works
> around it by constructing the enum just right to avoid a problem. In the
> end there is no functional problem, but it is somewhat strange and
> fragile.
> 
> It could also be improved like this [1], by better utilizing the smaller
> array, but this still wastes space in the regset array’s if they are not
> carefully crafted to avoid gaps. Instead, just fully separate out the
> enums and give them separate 32 and 64 enum names. Add some bitsize-free
> defines for REGSET_GENERAL and REGSET_FP since they are the only two
> referred to in bitsize generic code.
> 
> While introducing a bunch of new 32/64 enums, change the pattern of the
> name from REGSET_FOO32 to REGSET32_FOO to better indicate that the 32 is
> in reference to the CPU mode and not the register size, as suggested by
> Eric Biederman.
> 
> This should have no functional change and is only changing how constants
> are generated and referred to.
> 
> [1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
