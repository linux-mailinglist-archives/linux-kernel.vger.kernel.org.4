Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301587466F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGDBsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGDBsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:48:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D1E62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:48:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f875b267d9so7940600e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 18:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688435322; x=1691027322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPcmiNRu5a9AozN6iymhFCjsOvfJRXHmdam3G86CLFE=;
        b=gYU8iHbiaUiJ3KnEAIDXkrff8NCfwaLM71g9tKkGq7oiEjnDW8o0D+Q+fsprX5CsIz
         pVsjw8yo6JCS2lm31MbqVSXm3YZ9uizq6RLj40uTAWUqgkLvVIhPLKDoD5nQ9A93az3g
         JZMAFIWcaVD7I4FFYT0HpC7Gd2BHBdQ+MucdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688435322; x=1691027322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPcmiNRu5a9AozN6iymhFCjsOvfJRXHmdam3G86CLFE=;
        b=IEVm8d1qavyTDkvsCbyqXfve+G/b+0Jy04xS6rLPZeUDnUOdu/Iy8514X2AKlwLlBN
         rUgfKg1zOMQs4y+AoM4Adhpe2Cdq7HNuVxsOmIIDu5iClp0MiAHZ+B1jPIErukXFyyCe
         tr7oJkESTDEEO8DU7kxCTWEFxUUK27XR/KZOPO28JO2Ul0EYFkAgdm5pRvjbWs2JKb6H
         HKQ5cx2K+6T0F7X+YAqu2MA27zJOQ4ZYBFLC75h8U/KGPZ/fbRQv7mdps2lx7aFqbL01
         B5TN1WShua1DeYbV/QL8dmaPbjF5c/C6zqFO75uTm3aGt5Vj0MkYplcF38h8yMe2pakd
         cMGg==
X-Gm-Message-State: ABy/qLZvqRbk8xZQKmHdISpFU7TkMhmQf+OeJF7jIs53TGq00qOb534k
        mxOAPU8Jfvu2KQ6wWB+VG27kCYZYdguQfKHpiMHhCxRr
X-Google-Smtp-Source: APBJJlG9FPEboBNeyVtXNro4ZJPLwPjquInJVpIc1fN8tzk3jPP1G5AL9cuRbUyiWdcszyOA4yfY6Q==
X-Received: by 2002:ac2:5059:0:b0:4fb:7c94:b3e4 with SMTP id a25-20020ac25059000000b004fb7c94b3e4mr7550318lfm.29.1688435322581;
        Mon, 03 Jul 2023 18:48:42 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t4-20020ac24c04000000b004fb7584b7absm4138635lfq.5.2023.07.03.18.48.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 18:48:41 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b6a152a933so78163871fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 18:48:41 -0700 (PDT)
X-Received: by 2002:a2e:98c7:0:b0:2b4:6f0c:4760 with SMTP id
 s7-20020a2e98c7000000b002b46f0c4760mr7442851ljj.11.1688435321141; Mon, 03 Jul
 2023 18:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230704010003.86352-1-sj@kernel.org>
In-Reply-To: <20230704010003.86352-1-sj@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 18:48:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgciVavgh6ZafkYJxOw4aAkCOG=RH5487bOcT3TEKKK+w@mail.gmail.com>
Message-ID: <CAHk-=wgciVavgh6ZafkYJxOw4aAkCOG=RH5487bOcT3TEKKK+w@mail.gmail.com>
Subject: Re: [PATCH] arch/arm64/mm/fault: Fix undeclared variable error in do_page_fault()
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, surenb@google.com,
        Liam.Howlett@oracle.com, catalin.marinas@arm.com, will@kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 18:00, SeongJae Park <sj@kernel.org> wrote:
>
> Commit ae870a68b5d1 ("arm64/mm: Convert to using
> lock_mm_and_find_vma()") made do_page_fault() to use 'vma' even if
> CONFIG_PER_VMA_LOCK is not defined, but the declaration is still in the
> ifdef.

Duh. Thanks. Applied.

              Linus
