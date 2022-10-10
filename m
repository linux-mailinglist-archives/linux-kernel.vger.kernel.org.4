Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8725FA2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiJJRjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJJRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:39:29 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B305375493
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:39:28 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id h1-20020a4aa741000000b004756c611188so8439584oom.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXqpXa4IyHrDSP2AtB2YWiprFebXlxfr4+UnrmeiBVA=;
        b=KqviEEBaSdVH2q+WuAtppLJiJW/8K6S5Glb5rAQ1xGk2IYY4NmIr7n1xHK2pgCGJ65
         znOSOrK76CINQtx3yf5p2bq5o0lAFX5Fzj3ydTXddzJFvd+3aFgudyg4m7sUtD/0Egr+
         Iy0W1VBbhV+D5CKtpTeWh7wiBEkb52P/V1czk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXqpXa4IyHrDSP2AtB2YWiprFebXlxfr4+UnrmeiBVA=;
        b=2Yb3+R/Uge9M2934ZgP8u4NfonpYxGmL2V2HBWANG8nkkX6BcJjxeSD24iXjI5GrUf
         6rXds///NfY70OvuXmppnf2grRFRkVYJVYe72YC8bh2vikF+GUcsQ7pMaJPkHMwkaYh+
         GeutekTy2rTwdiFRVZzslp04R3fMdjpp7LJljNWoLTd8KHkR26lql23LN+Cmm9T805EA
         8YntVbtFa/yu41hHMuaDR/JQ2P6sDjuzt3X3L25TGcyCm8de4pXufCxNKmxFsFXEPUWy
         ZxBgEP8El2nOTNIPiUiVAEbdIf3nvpjP65+TX/LaN656QcMSM1CwpEcmGsWBltgXUAp/
         RDqw==
X-Gm-Message-State: ACrzQf0N4UOaQMJ+Jtu9eV4C2WH8Qsk/ucMxZcivjkTm+L8wbBiaMSh9
        pj9zVhOGj59gC8GbP0HNT9b815Nx3yQ1Kg==
X-Google-Smtp-Source: AMsMyM5I06xH7jROUSOiDKpG1H6nw2SMPLl3FAGURJkx0bDDcgJ4yzkMYeOJJhIWX/c9O/S9HNPLvw==
X-Received: by 2002:a9d:3e43:0:b0:661:925c:cdfd with SMTP id h3-20020a9d3e43000000b00661925ccdfdmr4565443otg.170.1665423567489;
        Mon, 10 Oct 2022 10:39:27 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id i6-20020a056870c1c600b00136c20b1c59sm34169oad.43.2022.10.10.10.39.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 10:39:23 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1321a1e94b3so13256933fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:39:23 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr10186924oad.126.1665423562950; Mon, 10
 Oct 2022 10:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <d1eaa4f7-6b88-9c14-91d2-84cdbd4b8a31@suse.cz>
In-Reply-To: <d1eaa4f7-6b88-9c14-91d2-84cdbd4b8a31@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 10:39:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUA_3pO2jSsMZauVibx20fSdZV+aan217fy+MuGDJT8A@mail.gmail.com>
Message-ID: <CAHk-=wiUA_3pO2jSsMZauVibx20fSdZV+aan217fy+MuGDJT8A@mail.gmail.com>
Subject: Re: [GIT PULL] slab changes for 6.1-rc1
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Feng Tang <feng.tang@intel.com>
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

On Mon, Oct 3, 2022 at 9:07 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> This time I tried using topic branches much more than previously, hopefully in
> an acceptable way. After rc5-ish I also tried to stabilize their merging into
> for-next (and thus the resulting for-6.1) as well. Hence branches
> slab/for-6.1/trivial and slab/for-6.1/slub_validation_locking appear to be
> merged twice due an extra cleanup and fix, respectivelly, being added and
> merged only last week. In slab/for-6.1/kmalloc_size_roundup I however decided
> for squashing a fix last week [1] to avoid needless build errors while bisecting.

Looks good to me. And thanks to the topic branches, you can actually
see the different series (particularly that "common kmalloc" one
clearly in the history.

Thanks,

                  Linus
