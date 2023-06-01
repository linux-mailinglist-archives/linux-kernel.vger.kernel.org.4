Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A1719F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjFAOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjFAOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:12:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9365DE44
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:12:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso562936b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685628728; x=1688220728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVj11wNaxw4vQif1E0UxGezkdxt6Cz5/sdjfAByLB+I=;
        b=jQX6KDcyNYsTRFrk0Y3i+f7A56M/zW5olN/OHvIkTe2uDfJSxYbYdjaHEdoQ0F5KWU
         TVnVu4z5wxK3ezO/FgxGzrEW0LooJWdw71a5xUFdaHEzEn3aOOQJ/ucNVGW30IDzX5I4
         xIF2SeogORRwBf/7R1hsQsCGVVybzQ8/OO0JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628728; x=1688220728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVj11wNaxw4vQif1E0UxGezkdxt6Cz5/sdjfAByLB+I=;
        b=AtzsEYR293RpTK6NC77oIGQj1z443GxKauL51oHP7apo72JpfdOCMAr8qwBIuITTND
         AzWNkHK9fI5bBfIMUakHRTrhn+p4cijbWHjyePWqejilN4xpSHts9urjwbmI48/gI1eM
         eboG6Qo3dis8KsWRkfDdgJJooQeo/e2fZ9XveQc6O/v7h2MEAVSLBvOi4RehRxjpdbZP
         D+6DWgXUBlie0VrjrfscUPHT/QCQZ8U3bvcPu+qJrnsT663rUXWHqBiyY5OHDGZ0X5B3
         O0vXzcGCWQnitDFiaFROWx8OcbNE5KZXDtHGBye67IXhY6VFKrOD+YEEXfUql9XdrAVl
         jVbg==
X-Gm-Message-State: AC+VfDy9UOiY0IeM3rAKMexQCLqqg0yuWDMKh5F7cuc7GQCo9Ui+Irg2
        MtBpAF4AFpAQ7CCfuBCRzD4NTw==
X-Google-Smtp-Source: ACHHUZ6nx3nyvrBhvYFmh+7r84kFgtl6QKF0PyzwncHUlXwl+FH/VPaGsDpPkygb7eZ3tK+3ar+zKg==
X-Received: by 2002:a05:6a00:2385:b0:64d:6c6f:84f2 with SMTP id f5-20020a056a00238500b0064d6c6f84f2mr7895315pfc.19.1685628727997;
        Thu, 01 Jun 2023 07:12:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b0062dedfd3d73sm5276293pfu.95.2023.06.01.07.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:12:07 -0700 (PDT)
Date:   Thu, 1 Jun 2023 07:12:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jeff Xu <jeffxu@google.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stuart Foster <smf-linux@virginmedia.com>
Subject: Re: Fwd: Started to get "memfd_create() without MFD_EXEC nor
 MFD_NOEXEC_SEAL"
Message-ID: <202306010710.7F5C39B7A@keescook>
References: <69dad53e-9363-c551-111a-d0051bb0265f@gmail.com>
 <38f847ed-69dc-d5da-5822-bd9da753fc30@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f847ed-69dc-d5da-5822-bd9da753fc30@suse.cz>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:18:47AM +0200, Vlastimil Babka wrote:
> On 6/1/23 04:07, Bagas Sanjaya wrote:
> > Hi,
> > 
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> > 
> >> Recent kernels seem to generate this:
> >> 
> >> "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3976 'Xorg'"
> >> 
> >> Is this a kernel problem or something to do with Xorg ?
> >> 
> >> Seen in Kernels 6.3.4 and 6.4.0-rc4.
> >> 
> >> Thanks
> > 
> > See Bugzilla for the full thread and attached logs (dmesg, xorg, bisection
> > log).
> > 
> > Anyway, I'm adding it to regzbot:
> > 
> > #regzbot introduced: 105ff5339f498a https://bugzilla.kernel.org/show_bug.cgi?id=217508
> > #regzbot title: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL on Xorg
> 
> Hm indeed it seems to have introduced 2 new flags and immediately warn if
> any process doesn't use them. Maybe it would make sense for some of the
> non-default values of vm.memfd_noexec, but it's too early to warn
> unconditionally everywhere, no?

This is pretty standard for getting new options like this noticed by
userspace -- there is no regression in _behavior_. It's just a reminder
to fix userspace code.

-Kees

> > 
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217508
> > 
> 

-- 
Kees Cook
