Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D2742C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjF2S6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjF2S6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:58:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3C11B1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:58:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b7fdc66e30so6576535ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688065125; x=1690657125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtoO7wxtO66WKs7HcsIYHnyEK9qS2ptNje4197iQ+WQ=;
        b=FqDckJGHOAILns8g8SssjEEqPgFGcqCyYEpxv0IIM+kBYWw18HQ3wDZvDveym6Iexv
         MuHvgZIebcIjQg0yrloXjPPrh9JqXGUM7vT/pkXe7VZ3HOOu4XClZnKHCXl4HzTZj6XZ
         brONgjMBygrSxQDYjk6T4XM5k4ImQ0xpweSjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065125; x=1690657125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtoO7wxtO66WKs7HcsIYHnyEK9qS2ptNje4197iQ+WQ=;
        b=E0fk7G+TR53/n8J1wnkDcK+ZYDU1imP1MQEw3k1z80qc4imvIjSUYE9MMaCR8Erb6O
         MPhYKvM+1rokVFGPd8t6UsH8Boa4W9HlBO3Nu93VG2qjcc6sj9hny/UzbPjVpoPp4GAh
         3EXfGFteNNhnibuVMou+4ynDtZbrHRSwS0hmT5J8XpIB+Rmk9BdmxnqE6EcuhxmL5JZG
         Fmb8ylxYhIwyH3gdO1puhRxIurENPDa0DOw18FqC+BYRG9meqoHFSJ/ZfLpX/ff7vW7p
         bz+aySMjYDILM4RXWrfTtDtfxQTYOs52AO5/JpM7CQ/D0GXmxQ4/7l9/EIoeIdy8fLrc
         K+UQ==
X-Gm-Message-State: ABy/qLYWSwpDcSmWcJqhVoKbOEv1V6ecBC1OA57O4/WOtSJUHu5dFaiH
        xeyghAqWM4PfYnmrQgn0F1TJPA==
X-Google-Smtp-Source: APBJJlE2bSL3RaiK4vRaauIvsS0try4vm6SYiy+L//V/kX9bwLc2aK/E9ffrCixlwmqbMMkIt+XsuQ==
X-Received: by 2002:a17:902:f544:b0:1b5:2b12:6f50 with SMTP id h4-20020a170902f54400b001b52b126f50mr121980plf.12.1688065125035;
        Thu, 29 Jun 2023 11:58:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709027c0300b001ae5d21f760sm9382247pll.146.2023.06.29.11.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:58:44 -0700 (PDT)
Date:   Thu, 29 Jun 2023 11:58:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-usb@vger.kernel.org
Subject: Re: UBSAN spat in valid xhci code in Linus's current tree (6.4+)
Message-ID: <202306291147.4CE126CE5@keescook>
References: <2023062945-fencing-pebble-0411@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062945-fencing-pebble-0411@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:36:51PM +0200, Greg KH wrote:
> Boris just reported to me a UBSAN splat in the USB xhci driver in
> Linus's tree that wasn't present in 6.4-final, and given that no USB
> changes are merged yet there, I was confused.
> 
> Turns out, I think you all missed a "variable length" structure in the
> xhci driver, which UBSAN is calling out a being an overrun, when really
> it isn't (it's just written that way...)
> 
> The splat is:
> 
> UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31
> index 1 is out of range for type '__le32 [1]'
> CPU: 0 PID: 1556 Comm: kworker/0:2 Not tainted 6.4.0+ #7

This is fixed here, a couple weeks ago, but maybe it missed your tree:
https://lore.kernel.org/lkml/20230614181307.gonna.256-kees@kernel.org/

Would you prefer I carry it?

> So perhaps 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC") should be
> reverted for now?  Or this field fixed up to properly be marked as a
> variable length array of at least one entry?

We've been turning these things on further and further so we can catch
stuff like this (and we did while it lived in -next). FWIW, it shouldn't
cause any problems beyond the splat (i.e. everything should continue
working normally).

-Kees

-- 
Kees Cook
