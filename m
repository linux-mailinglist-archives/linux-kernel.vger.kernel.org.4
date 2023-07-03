Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3778B7454FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjGCFlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGCFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:41:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2477190
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:41:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e6541c98so3377866b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688362864; x=1690954864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5YO6Ck0avaxlgoQTzwmS6APCgybwM/8bSmxK2BRsU8=;
        b=hbyHmCwQyB89pon+WWxjj/vT+r/R3zUpG/L7IhF+lUSaC1UG9rTVqCJ4incBlo/z6/
         422GpQ4BS0HYv30T5khhnGR8vIQIlpCbobRwvU2CWHsv2VTUe6MzlVcfCMCBH1UfsxWu
         sbuVlffG8yucQksQHcjuSDgVqdwj/IhHv4F40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688362864; x=1690954864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5YO6Ck0avaxlgoQTzwmS6APCgybwM/8bSmxK2BRsU8=;
        b=ERQwPIuQZIDhRxJV6w1ZcrYeDQJMmbSNco4+p6sVv5gxI/J+HF4V2Ki8LSlCcRNRt9
         xAysw0qiRkXE9FzyltWEViWek3eznVe8yRj8JSuKO0JCn1lfy5Q3Cm8Ihuq3OGX0VQ95
         wPL4y40j+NH2tk8DQY0Qgyq05+JxTQeWnaIDVsAVlEJf53yDgHixSuctdXpHaZe4I3E5
         45BAi31iUKUbLBNR/Lpn15FLPmdQdmC0mhepCN10ug4KxuXtHRSjpZzsC+k/h68CnZYC
         oOzifv/3/FZb8tfpACLI/0eH9VC2IS/lABLWOCmdFA2twH6/X//1FINTekG7R9RLvC/K
         qUqA==
X-Gm-Message-State: ABy/qLYycPt5jA3uLaDcGcDUXNCsD+jk2TvZKPi1gojaVn1TXvj5PAte
        SgyY0vjTiAdMZVq+LG3lNmoxHQ==
X-Google-Smtp-Source: APBJJlGsAfma8O5fhZ3rSb77hZAwgd6bujawZfFtLy1rOCe8BrJOqcJXw8ve3ZDAglKI5V1NURktQw==
X-Received: by 2002:a05:6a00:1352:b0:668:83b6:bfe8 with SMTP id k18-20020a056a00135200b0066883b6bfe8mr12601574pfu.9.1688362864652;
        Sun, 02 Jul 2023 22:41:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0066a4e561beesm2983232pfo.173.2023.07.02.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 22:41:03 -0700 (PDT)
Date:   Sun, 2 Jul 2023 22:41:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
Message-ID: <202307022230.6121D6896@keescook>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me>
 <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
 <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 07:18:57AM +0200, Mirsad Goran Todorovac wrote:
> I apologise for confusion. In fact, I have cloned the Torvalds tree after
> 6.4.1 was released, but I actually cloned the Torvalds tree, not the 6.4.1
> from the stable branch as the Subject line might have misled.

Thanks, no worries! I got myself confused too. :)

The config you sent looks like I'd expect now too. Questions for you, if
you have time to diagnose further:

- Are you able to catch the very beginning of the crash, where the Oops
  starts?

- Does pstore work for you to catch the crash?

- Can you try booting with this patch applied?
  https://lore.kernel.org/lkml/20230629190900.never.787-kees@kernel.org/

I'll try to see if I can figure out anything more from the images you
posted.

-Kees

-- 
Kees Cook
