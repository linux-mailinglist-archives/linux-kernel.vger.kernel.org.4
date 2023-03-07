Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422BE6AD889
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCGHyD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 02:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCGHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:54:00 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B53CE3D;
        Mon,  6 Mar 2023 23:53:53 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id l18so13523732qtp.1;
        Mon, 06 Mar 2023 23:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678175632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6v56biJISo0k1NX6M3k2oB4vNanTMqcuoG+TH0gcNY=;
        b=c/8yjuFspe4GjYgtNgkSMrDGwQTHRZ+nc6Mt1xleBwfGRs8Rdj68XerPyJhTZvorK2
         47ZDHzdUfgvdNnlthz5fD7M/bajzIltqd2FPky/c25By/k5+0+YUI1/4z8H84URQmqV3
         G/RhEVqhZqh7mk9aZqmC6MbodAZF0DaKSguh+vRN4givUlAoSjjCCvXXDqU/tz/B5bqm
         57MOPHtGuBCp277GAKbCYx53d70Xc6o4XFsIdVgo4ukfGIug7qSc+XGeGeZoWcimz2oC
         wuLXIytGVCx4ZfC1O4dKeKfTnR+Q8nmpv1mKcAtC4DGsz/RRJWogl7mTJcxrvdiQJZaB
         YHMw==
X-Gm-Message-State: AO0yUKUyRzQdq/2LEzuEyNr7DnwT85XmYy25WZ9alIQDipcTa8nxo7oh
        P036SUeRVXzOcQd6UID6UP1hmNXA5kLeeg==
X-Google-Smtp-Source: AK7set+TVCks7/4gD4tAAgJSTUEXz/p9U+wHelySvFvLuM+avD0iNsMbAm5KXXYd2wSw1RwWB8iFJg==
X-Received: by 2002:ac8:7d84:0:b0:3b9:fb0e:adba with SMTP id c4-20020ac87d84000000b003b9fb0eadbamr22957757qtd.25.1678175632688;
        Mon, 06 Mar 2023 23:53:52 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id s4-20020a372c04000000b0074283b87a4esm8979351qkh.90.2023.03.06.23.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 23:53:51 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536b7ffdd34so230419417b3.6;
        Mon, 06 Mar 2023 23:53:50 -0800 (PST)
X-Received: by 2002:a81:b61d:0:b0:52e:f66d:b70f with SMTP id
 u29-20020a81b61d000000b0052ef66db70fmr8277658ywh.5.1678175630175; Mon, 06 Mar
 2023 23:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20230306160016.4459-1-tzimmermann@suse.de>
In-Reply-To: <20230306160016.4459-1-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Mar 2023 08:53:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5AwE0pK=ppip4J81ByEye+jmvff1s8saeEuWZWZiqPw@mail.gmail.com>
Message-ID: <CAMuHMdU5AwE0pK=ppip4J81ByEye+jmvff1s8saeEuWZWZiqPw@mail.gmail.com>
Subject: Re: [PATCH 00/99] fbdev: Fix memory leak in option parsing
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@hansenpartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        corbet@lwn.net, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Mar 6, 2023 at 5:00 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Introduce struct option_iter and helpers to parse command-line
> options with comma-separated key-value pairs. Then convert fbdev
> drivers to the new interface. Fixes a memory leak in the parsing of
> the video= option.
>
> Before commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
> caller; clarify ownership"), a call to fb_get_options() either
> returned an internal string or a duplicated string; hence ownership of
> the string's memory buffer was not well defined, but depended on how
> users specified the video= option on the kernel command line. For
> global settings, the caller owned the returned memory and for per-driver
> settings, fb_get_options() owned the memory. As calling drivers were
> unable to detect the case, the memory was leaked.
>
> Commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller;
> clarify ownership") changed sematics to caller-owned strings. Drivers
> still leaked the memory, but at least ownership was clear.
>
> This patchset fixes the memory leak and changes string ownership back
> to fb_get_options(). Patch 1 introduces struct option_iter and a few
> helpers. The interface takes an option string, such as video=, in the
> common form value1,key2:value2,value3 etc and returns the individial
> comma-separated pairs. Various modules use this pattern, so the code
> is located under lib/.
>
> Patches 2 to 98 go through fbdev drivers and convert them to the new
> interface. This often requires a number of cleanups. A driver would
> typically refer to the option string's video mode. Such strings are now
> copied to driver-allocated memory so that drivers don't refer directly
> to the option string's memory. The option iterator then replaces manual
> parsing loops based on strsep(",").

Thanks for your series!

Unfortunately I cannot say I'm thrilled about this: you are replacing
a single small dynamic memory leak by 36 larger static memory leaks.
Am I missing something?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
