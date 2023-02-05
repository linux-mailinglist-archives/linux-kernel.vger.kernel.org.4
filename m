Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC868B18C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBEUWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:22:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9E113DA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 12:22:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u21so9851592edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7AMfEAIeR/+FfczDgCKveqbE3jvjS9AcYcv8gEH+jg=;
        b=AubkqDgfdmEzLss5anQ2QUuOJ23EmV0DleDD4TD4vdfeaSa4JriPsT5cPwkvHRzSAv
         v4dQ6yasKZndh/dM+ittZFX+QZ8d1faFJdhZGC/UZICZo1l1XEG5VJx3Y5Ck2DUfWEgZ
         DbpZxLVWAJSHD8LTivj+KOvEBNMGpvJ1NxwBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7AMfEAIeR/+FfczDgCKveqbE3jvjS9AcYcv8gEH+jg=;
        b=gJ0Gzu2ncCB932AXAqrBeE03GdhnhEvIaCJBhkFSHjqpbrKWn7AnXiCzvzRQp7vl1J
         E/pzlugbRT9vqrwiC9gVj31MBTN+RAl//THyWcBPMwvVclQPfY8AD7lYQJLACfwGPNKX
         FMwEsox6Lf+Basl8ZGeWLDhSnuv7trddrw5KoCwtTdmYX2VREsrjLMUjl4g2u4ofuQhh
         fyN9n3h4GlJEBjX8v9Qo1wZlbBApcRx8AYmnJC8UpEboPoZ9alOArk1cxrhsjtiev+TH
         9vlWd5r5/aaclJKKG1hSaqgJu9/zp4Ph6Cjg3mKrT1i0VD61CHSMo9wnjXcCEQtvUXXK
         WsOw==
X-Gm-Message-State: AO0yUKUE4Xee3xTwrjiuxa7LFhci23iuscnRBQ6M4MHE8N9T/UgZNbDd
        uIMIbG1w2jmeRmOoxAy/4oJKbSeQq9XwTobB+JY=
X-Google-Smtp-Source: AK7set81t2kkW1uy0kvK2vLBUOGLwOswsMIKNAQLFDIO2Z/M0iFlCFlyYQ6aDFIL4aIsfmzxm/kOWQ==
X-Received: by 2002:a50:ab4e:0:b0:4aa:a82b:9711 with SMTP id t14-20020a50ab4e000000b004aaa82b9711mr4114021edc.35.1675628520812;
        Sun, 05 Feb 2023 12:22:00 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a15-20020a50ff0f000000b004a2067d6ba4sm4228632edu.52.2023.02.05.12.21.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 12:22:00 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id qw12so28936144ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 12:21:59 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr4393708eje.78.1675628519644; Sun, 05
 Feb 2023 12:21:59 -0800 (PST)
MIME-Version: 1.0
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de>
 <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info> <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de>
 <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com> <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com> <Y9+tDmLAlqg37TS+@zn.tnic>
In-Reply-To: <Y9+tDmLAlqg37TS+@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Feb 2023 12:21:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
Message-ID: <CAHk-=wgC_MEFnnzUGN4q9pmhxV+eFV1Oo=W2j1J69YhJF5EDtw@mail.gmail.com>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 5, 2023 at 5:20 AM Borislav Petkov <bp@alien8.de> wrote:
>
> @@ -53,7 +53,8 @@ static inline u8 mtrr_type_lookup(u64 addr,
>         /*
>          * Return no-MTRRs:
>          */
> -       return MTRR_TYPE_INVALID;
> +       *uniform = 1;
> +       return MTRR_TYPE_UNCACHABLE;

So this is the one I'd almost leave alone.

Because this is not a "there are no MTRR's" situation, this is a "I
haven't enabled CONFIG_MTRR, so I don't _know_ if there are any MTRR's
or not.

And returning MTRR_TYPE_UNCACHABLE will then disable things like
largepages etc, so this change would effectively mean that if
CONFIG_MTRR is off, it would turn off hugepage support too.

But maybe that was the only thing that cared, and we have:

> @@ -721,8 +721,9 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>         u8 mtrr, uniform;
>
>         mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
> -       if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
> -           (mtrr != MTRR_TYPE_WRBACK))
> +       if (mtrr != MTRR_TYPE_UNCACHABLE &&
> +           mtrr != MTRR_TYPE_WRBACK &&
> +           !uniform)
>                 return 0;

Here you make up for it, but I don't actually understand why these
checks exist at all.

I *think* that what the check should do is just check for uniformity.

Why would the largepage code otherwise care?

Other MTRR types are explicitly fine, and I think things like the X
server might even want to do write-combining with large pages etc.

So I think the hugepage code should only do

     if (!uniform)
          return 0;

or there should be some explanation for why those types are special?

>> @@ -748,8 +749,9 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
>         u8 mtrr, uniform;
>
>         mtrr = mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
> -       if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
> -           (mtrr != MTRR_TYPE_WRBACK)) {
> +       if (mtrr != MTRR_TYPE_UNCACHABLE &&
> +           mtrr != MTRR_TYPE_WRBACK &&
> +           !uniform) {

Same here.

Again, I *think* that the reason it used to do that "check two types"
thing is simply because "uniform" wasn't set correctly.

But I don't know.

                Linus
