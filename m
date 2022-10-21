Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FFF607F31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJUTko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJUTkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:40:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA6198459
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:40:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d13so2713843qko.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8cEcPE5eJxdhlD5IGo/M7P7SxrnCieMphXj8buQz48I=;
        b=T9l49X7m6bFvcPcqrTkzRupPSD0TaxDVlJn97Z7GBec0F5nMJUH2zckYJQilD6S+4I
         v3LjPCvtVo603tLjPTPha5JL3M+0gdgQXKkipkYn/djWgwydEi2FEI1B8X1oN02ql5SO
         3wYl0+PPOXb8PbGPo/JBnAEn7meQ0mzKUgPFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cEcPE5eJxdhlD5IGo/M7P7SxrnCieMphXj8buQz48I=;
        b=7G/MVipTOafjGt92/q7jey1kQ3gFkLymNuqmBeB+fh+x1d1RRBurOAnYCDaSO6ZGD+
         g/Oqt8QzyRMadZqW9RFqmHLyaPc+hWf/1Z8SQb/WFDmggg3eZdljcrCfH4xzf0Cp+xw2
         3zCui2nYsHsg0Cis+deLNSoaXTvZbApkili6WKtMrhVDThJ91VIciz0fal6YWP8HmF5z
         v5aUQGwWOyBnsOnJFBCNTVEG1s8FEtEplv3DqphoUxnLJA17dqy6ZEarRy8Iy44oc8SC
         vw4xX19nTn7SZaOT9+UeLN+lgrAHI/QDm+VHM7R2bePkWvatluQZMuVb1X+RLd+WOsD3
         B21w==
X-Gm-Message-State: ACrzQf2+QwVH5p3IMY7K7GXJqFYtZpFOKUbNPfrvs294Fme1KRwXsT4Y
        hBJop6kMqNPbunfO2iSnGF9859TBzGVerA==
X-Google-Smtp-Source: AMsMyM7IR8hy4It57F42ZdvDhbnNIyim4BNNeNFnJgPiVLHG9Z5d/idB03apMoLVBeQrfx/lcOO4xA==
X-Received: by 2002:a05:620a:2809:b0:6bc:5e42:fef9 with SMTP id f9-20020a05620a280900b006bc5e42fef9mr15034825qkp.278.1666381229895;
        Fri, 21 Oct 2022 12:40:29 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id q1-20020a05620a0d8100b006ec62032d3dsm10254185qkl.30.2022.10.21.12.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 12:40:29 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id r3so4503594yba.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:40:28 -0700 (PDT)
X-Received: by 2002:a25:84cf:0:b0:6b3:c0c3:19d8 with SMTP id
 x15-20020a2584cf000000b006b3c0c319d8mr17385388ybm.349.1666381228574; Fri, 21
 Oct 2022 12:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221020213327.2c284af5925b6a8ed915fe9e@linux-foundation.org>
In-Reply-To: <20221020213327.2c284af5925b6a8ed915fe9e@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 12:40:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgb42XG1c_rtwupJMD9QXbJsE6k_TBKYC4YvZ8bkATcVg@mail.gmail.com>
Message-ID: <CAHk-=wgb42XG1c_rtwupJMD9QXbJsE6k_TBKYC4YvZ8bkATcVg@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.1-rc2
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 9:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Andrew Morton (3):
>       Merge branch 'master' into mm-hotfixes-stable
>       Merge branch 'master' into mm-hotfixes-stable

I've pulled this, but both of these merges look entirely invalid.

First off, one of them is most definitely pointless - there's no
activity between the first and the second merge, so that first merge
shouldn't have been done in the first place.

But the second merge is bad by definition too, in that it doesn't have
any explanation for it.

I've said this before - and I hope that some day I just won't have to
say it again - if you cannot explain a merge, you shouldn't be *doing*
a merge.

It really is that simple. If you have no clear explanation for why you
need to do that merge, then you simply shouldn't have done it.

For example, that first merge clearly CANNOT have a valid reason for
existing. There's simply no valid explanation for doing it,
considering that there was no work on top of it that could possibly be
a cause tor that merge.

So that whole "if you cannot explain why you do a merge, don't do the
merge" rule should have been a hard "NO" on it, and should have made
it obvious that it shouldn't have happened.

Please don't do pointless merges.

            Linus
