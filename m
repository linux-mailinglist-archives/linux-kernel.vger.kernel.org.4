Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F085F88C7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJICF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJICF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:05:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A324BEF;
        Sat,  8 Oct 2022 19:05:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 195so7736349pga.1;
        Sat, 08 Oct 2022 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWAbvwh1HFGHbYSh/eye53qfdD4MoObQPY6foCBLVQs=;
        b=d9KSNVJFDFg/IzGxnJ4Ft/SYyCY0WvNSCxPjvf+Wb4S8nYNs1+Y1KnNX1MAia8R2/M
         sthtFicwQcvYY875BrJF1dQhR9hKPDLyNergJYZOMp1XxssXTHK61gKSZtTftCbycXnO
         maYQKGuGAdLBBl1vgd22Za+Vlb3cIzGOffAXV5heBd394lLFl7KHo8fc3zcLGEECPlnf
         w1069p5PLAZIsCvfkCMOEsZpwM+SbnJDTF2YcjT2SLvmAIrc4tBwPZ08Mu374Duv60YW
         AS4lRD4uzmwLSnoyxR+ESg7Y2xctVFiB7rxCoC5aZPv3PXySHh+mZ9k0o0q99z8vkue8
         Z3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWAbvwh1HFGHbYSh/eye53qfdD4MoObQPY6foCBLVQs=;
        b=8Hwm52kh9Bpc990vQquas9ammUeUmrt52XfncFmLqdkTDhh4z0IIi/Qv6D0zqFU5Tz
         YC/1TGCAgvQ06c6hkrM0svsj/Ig97OLiPgGv8klZ0fR6whib9+u7WrBXhs4wjFRBATf9
         K8VJuvaPlBuA3xPoUfyxSQlKzyOYCDSYe+u6B209IxGbuldcE19hYQChj8XqBTSl9wUa
         NEXyi2RuJ7LaHo2WxTmjz2TLXR3VMI9WPs6qOWKggEHPd0GJ8UiEJOemVpg1pFvmgGDt
         5RWYgUlMPjygKhv0UIBtGwnFPrg20FOpq+08VnY5EqK9SNmPZboRjhcpy65yIxvtM6Zt
         uqmg==
X-Gm-Message-State: ACrzQf12scd6S3+cmj+f7gTAduBYAPY3kWf7XwtarQJOdmkhNpT/JLcR
        6UgAARnJKtQoVfNt0Kqflw9GkMiNLJc5Wg==
X-Google-Smtp-Source: AMsMyM6FzhF+xPf2zKqWMjX+/Hqbe+3OMMa4hx4Pb6Fq6dnCz9xw4pY6AS/0jmR05SWLExWyjdhkng==
X-Received: by 2002:a05:6a00:1343:b0:562:ea5e:57e5 with SMTP id k3-20020a056a00134300b00562ea5e57e5mr6159132pfu.45.1665281123314;
        Sat, 08 Oct 2022 19:05:23 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id x24-20020aa79418000000b00537f16e25d3sm4160405pfo.75.2022.10.08.19.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 19:05:22 -0700 (PDT)
Date:   Sun, 9 Oct 2022 15:05:17 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] dlm: Replace one-element array with
 flexible-array member
Message-ID: <Y0IsXXYnS4DnWkMW@mail.google.com>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
 <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 05:18:35PM -0700, Kees Cook wrote:
> >$ diff <(objdump -M intel -j .text -D dlm.old) <(objdump -M intel -j
> >.text -D dlm.new)
> 
> I'd suggest different options here, this is harder to map back to the source line.
> See https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/
> for lots of details. :)
> 

Just read the blog entry, it's really interesting. I will be using it
from now onwards :)

> >
> >13778c13778
> ><     c693:	49 8d bc 24 c0 08 00 	lea    rdi,[r12+0x8c0]
> >---
> >>     c693:	49 8d bc 24 c1 08 00 	lea    rdi,[r12+0x8c1]
> 
> This implies something unexpected changed.
> 

I will add more details about this line at the other point you made
below to avoid repeating myself. But to cut a long story, short.. this
[reg + displacement + 1] difference is caused because I deliberately add
the NUL-terminator space to the kzalloc() call.

> This has trailing padding, so the struct size didn't actually change.
> 
> >-	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> >+	ls = kzalloc(sizeof(struct dlm_ls) + namelen + 1, GFP_NOFS);
> 
> This is allocating 1 more byte than before, since the struct size didn't change. But this has always allocated too much space, due to the struct padding. For a "no binary changes" patch, the above "+ 1" needs to be left off.

That's true. I agree that leaving "+ 1" would work and produce a
no-binary-changes patch due to the existing padding that the structure
has. OTOH, I thought that relying on that space could bite us in the
future if anyone tweaks the struct again...so my reaction was to ensure 
that the NUL-terminator space was always guaranteed to be there.
Hence, the change on c693 (objdump above).

What do you think? Should we keep or leave the above
"+ 1" after the rationale above?

> 
> I would expect the correct allocation size to be:
> offsetof(typeof(*ls), ls_name) + namelen

Fair point, I will make this change.

> 
> Question, though: is ls_name _expected_ to be %NUL terminated

Yes, it is. I tracked down ls_name's utilisations and it is passed down to 
a bunch of routines that expects it to be NUL-terminated such as
snprintf and vsnprintf.

>, and was the prior 3 bytes of extra allocation accidentally required?
> 

I am assuming that you are refering to ls_namelen in the struct dlm_ls
(please correct me if this isn't what you meant).

ls_namelen member is only used within the routine which kzalloc
the space for the struct (fs/dlm/lockspace.c:new_lockspace). 

There are no external references to this member outside of that method in the
kernel. One could say that ls_namelen can be removed without side effects but 
I wouldn't suggest doing it in this patch, that's why I didn't touch it :)

Paulo A.

