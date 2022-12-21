Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D886534EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiLURST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiLURRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:17:48 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BC1573F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:16:54 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id i20so14141784qtw.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kB6hFtCRIfVThHjkWb+E2PQntic6R9fKZViI8BQpJ9Y=;
        b=Myc8ct4l9mrmgL8s4mKOi8PHj3FPFp4bmh5udjz/p40a5SnqSGiuluLOsVJnMth318
         cuTvtq4VKpNYGjRKVj++VXwKigBw12y8RDQl2ufFxjDDeT7rLFrbTeGRVzpwSPes2UBz
         KcRFG8NPmM+XShEskb5Qa8XCC72wt5dpJXORM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kB6hFtCRIfVThHjkWb+E2PQntic6R9fKZViI8BQpJ9Y=;
        b=QvMcJcDPoZnzRhJ8mM9+w+Itr2l8Bws6or8qiSDOHf2SikqSps8Wa1sWEcm6kJ7efB
         jmHE6JEMeR8x2vyJinV6bHwK1g+GLhmyRim8KXiJJ64MWiKo1+jBydKRRN67+uhf+Hl8
         h9WvCzdx3r00jp9F5wK5BZ0+yuDU3eEjAOwHmKbLwIecsIAbMw17C5D4Cfmjd2kAGGtw
         c/Fj1EdlbJjD0qISUrbArE0VCNrc0QXo71eHkUcXmDKBf9CXqq6zTi2SA+Tg29veyrjo
         63jQ71hfSUy8jvN2pUwqpYEors4YkqjwziDYXPaNrvl0Qdwpfm7KMkQrK5Fcu7qVLFef
         iVaQ==
X-Gm-Message-State: AFqh2kraPt1phpRxSX3lVF2y5iS4HL2bLOeZGkuDtJKSP+nnrBIldZ5A
        YQIhgwo7XmP/CBdZK9sbmN0xmIE6Gif0PDjT
X-Google-Smtp-Source: AMrXdXuTGt9rztlxL6+RfZYtNUN1/P/jAtcqxBZXEcr2md1hcz5XpHwxIvKvAfJr7JEitQAJ0ZNcbg==
X-Received: by 2002:a05:622a:1927:b0:3a7:ec54:cfa2 with SMTP id w39-20020a05622a192700b003a7ec54cfa2mr2771720qtc.56.1671643013297;
        Wed, 21 Dec 2022 09:16:53 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id fb24-20020a05622a481800b003a6a4744432sm9477923qtb.87.2022.12.21.09.16.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 09:16:52 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id k2so7083831qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:16:51 -0800 (PST)
X-Received: by 2002:a37:a93:0:b0:6ff:812e:a82f with SMTP id
 141-20020a370a93000000b006ff812ea82fmr83224qkk.336.1671643011317; Wed, 21 Dec
 2022 09:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20221220203022.1084532-1-kuba@kernel.org>
In-Reply-To: <20221220203022.1084532-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Dec 2022 09:16:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-W+0gh-XeUrN409RvdOO=VpcWiiPUNm2=Jru5bKWRDQ@mail.gmail.com>
Message-ID: <CAHk-=wg-W+0gh-XeUrN409RvdOO=VpcWiiPUNm2=Jru5bKWRDQ@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.2-rc1
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
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

On Tue, Dec 20, 2022 at 12:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Traffic is winding down significantly so let us pass our fixes to you
> earlier than the usual Thu schedule.
>
> We have a fix for the BPF issue we were looking at before 6.1 final,
> no surprises there. RxRPC fixes were merged relatively late so there's
> an outpour of follow ups. Last one worth mentioning is the tree-wide
> fix for network file systems / in-tree socket users, to prevent nested
> networking calls from corrupting socket memory allocator.

The  biggest changes seem to be to the intel 2.5Gb driver ("igc"), but
they weren't mentioned...

Also, maybe more people should look at this one:

   https://lore.kernel.org/all/6b971a4e-c7d8-411e-1f92-fda29b5b2fb9@kernel.org/

which seems to be a regression in 6.1 (and still present, afaik).

                Linus
