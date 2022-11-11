Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A255662619E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiKKSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiKKSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:43:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0480F2FC12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:43:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 4so4921434pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvPjJomqGpklbO216LKhFVnjX7hUEN+k9QGJRtClI/s=;
        b=CdGJ4NF0tyFFuY5k1pnDeRswa5SfipxLwMMzYimdv0Nmnq5TVUJSUJf58J3xl9U2Xb
         uWoi3Oasgu6BPBhKC94V72JvwALqeG3S0a2c2K6EKOYUzMg202ryeh71fzP0/Lleid7p
         yYSBQn7a+5jNV/RL/odrbZkAqnHQekbyAkr5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvPjJomqGpklbO216LKhFVnjX7hUEN+k9QGJRtClI/s=;
        b=Y6+s5MERM0m0egtGjXAmj3vqhAJLnpMzRM/Lg7y+E3Kxhk/l2ecGh/x8msPi5I56+Y
         5IL660tCs2SsAWm8SOBkiBTNC6F11N/1QVCYuWVU8NJSmk9Zyvcgmo7pOoUIdhrPvkL7
         HZNfmjAT6i7rAemDJQGMeWYozI0JNwKewQzXG5Et5/ZilOKCuJMt+j4rghc+y9XEXbKP
         g6qKGY9+FPU68kdn5EAyPwqMEtcmBac7e8X6EOJ2MKBmlbhWrRSBIr9LybEPQaMuPYBI
         +ICy+FWzfoHtdXgmFqk9+ELBaOZnbXwmGFDpzO9fFANkaHQt+ShwFDueEPVBKs5EUUqE
         BuWQ==
X-Gm-Message-State: ANoB5plfLs3+BLFiVRP/VtQB5I6btaaFMvl466HjPh5wY/LJr+Azkz8x
        l5bsF++/Rv1RXSqcLaJS+I+7Lg==
X-Google-Smtp-Source: AA0mqf4diI87jkKn+R+q104hSjv+rlYENJlYIF5J45JIZbxzHU/ZPZfdCofVKTx5A9ucr0EzCc7ssw==
X-Received: by 2002:a17:902:704a:b0:188:712f:dfa5 with SMTP id h10-20020a170902704a00b00188712fdfa5mr3546538plt.140.1668192198497;
        Fri, 11 Nov 2022 10:43:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 23-20020a621617000000b0056b6a22d6c9sm1885372pfw.212.2022.11.11.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:43:18 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:43:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, dalias@libc.org,
        ebiederm@xmission.com, sam@gentoo.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] fs/binfmt_elf: Fix memsz > filesz handling
Message-ID: <202211111040.A580C73B2F@keescook>
References: <20221108110715.227062-1-pedro.falcato@gmail.com>
 <202211101934.22CACD615@keescook>
 <CAKbZUD2r=zK91J4c6pyHQhDuqqMzmrx+BBgFF4Cso2jK+jjhHA@mail.gmail.com>
 <202211102214.D764FAE21@keescook>
 <CAKbZUD0aGmrb=GtK_sQM54LtajKLfArkKjrV7f7BaVyKGhQwgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbZUD0aGmrb=GtK_sQM54LtajKLfArkKjrV7f7BaVyKGhQwgw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 05:14:47PM +0000, Pedro Falcato wrote:
> On Fri, Nov 11, 2022 at 6:15 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 11, 2022 at 03:59:08AM +0000, Pedro Falcato wrote:
> > > We could of course also just sort the program headers at load time,
> > > but I assume that's unwanted overhead for most well behaved ELF
> > > program headers :)
> >
> > Large refactoring of the ELF loader needs proper unit testing, and we're
> > still a bit away from that existing. In the meantime, we'll need to make
> > very very small changes to fix bugs. I've sent a minimal change which I
> > think should fix the problem (now at v2 since right after sending it I
> > realized I was trading one accidentally correct state for another in the
> > v1):
> > https://lore.kernel.org/linux-hardening/20221111061315.gonna.703-kees@kernel.org/
> Got it. I understand you may be a bit nervous deploying this patch ATM.
> 
> What are we missing for ELF loader kunit testing? How can one help?
> 
> Note that my -v1 is still relatively safe and was already tested, you
> could just apply that.

Even the v1 is a LOT of refactoring. I'd like to avoid any factoring
like this as much as possible given how fragile the code has proven to
be.

As for unit testing, we need two prerequisites:

- mocking:
  https://lore.kernel.org/lkml/20220910212804.670622-1-davidgow@google.com/
- userspace VMA support:
  https://lore.kernel.org/lkml/202211061948.46D3F78@keescook/

-- 
Kees Cook
