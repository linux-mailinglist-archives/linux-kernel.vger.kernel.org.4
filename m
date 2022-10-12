Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B345FBF35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJLCha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLChZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:37:25 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B277A536
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:37:24 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-134072c15c1so14868345fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A6rbmNQmTqlEb0g71qKCokeuemYJn9koB7D9gwM6zMk=;
        b=HsfQiljxAaAxmJchFy5Lx2LkP5bTRv1wSdGqEjJAyWIfLkddE2P0cg4DTMjRjm51P0
         enCaHJQ0elou5nOK/OxG4U2MhVmbdbC4Px/D1FF3Lmf8AYNkEtrVGNGkymM/skEd6fux
         CRd7gP25XNWI43u8jc0y9swN+GDmDQHI5tJ5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6rbmNQmTqlEb0g71qKCokeuemYJn9koB7D9gwM6zMk=;
        b=z8LYLFhAd7DGfkXG+2zq8qaB4igBW0wWbYUinDfqGV6ABUjjEYVP590bNf6rWXWFhq
         XubraOGkvE2MfJz77N7QFanmbPqk5E38hDmZvbwdqI50kEOZ7Tcft1jci3ZISuTNLTO3
         la6xMLfu00ELrBtHp2t/s+0AdLgiHeDDdYGASFMoUYzOvTON/rRwAag07j7+8ZOOqfed
         P/Enpw1i+tSD8pnbi1dXtfSOWyaN/Tn0xJ81Z3bR9LUOzndMmMFjhtpMJfpvnn18uoFE
         cSOG3G1oeulOS9emBcF6NrjGxGZkDmQ4UQf9zSS/4124ToaD2Iyh/RwA17KtQPGT2JAB
         x6Jw==
X-Gm-Message-State: ACrzQf3rr4X5uMbpIdg0ZQeFEFTV+kAIBC/ENv6nAfQ8oi+WXGl4em40
        8g+PREYadujLx0Ru7hfTOqXj4ExxKi6qPw==
X-Google-Smtp-Source: AMsMyM5iJMTzxP937wjLCBP4LS694uyuuNrRMl/co5R8VBbC1z4//DAlnr5R3A2qcbrP+gtQKiKpzw==
X-Received: by 2002:a05:6870:a78f:b0:133:12e5:a869 with SMTP id x15-20020a056870a78f00b0013312e5a869mr1197851oao.283.1665542243183;
        Tue, 11 Oct 2022 19:37:23 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id y63-20020acae142000000b003357568e39fsm6144167oig.57.2022.10.11.19.37.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 19:37:22 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id x188so8890537oig.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:37:22 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr1061470oif.126.1665542241713; Tue, 11
 Oct 2022 19:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <Y0VHfYkFUqYwVAru@kernel.org>
In-Reply-To: <Y0VHfYkFUqYwVAru@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 19:37:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjogDKrppyQ+NxMn-oBuHfB1qsbbJPLKTxB+2JvXN3L3w@mail.gmail.com>
Message-ID: <CAHk-=wjogDKrppyQ+NxMn-oBuHfB1qsbbJPLKTxB+2JvXN3L3w@mail.gmail.com>
Subject: Re: [GIT PULL] memblock updates for v6.1
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 11, 2022 at 3:38 AM Mike Rapoport <rppt@kernel.org> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock for-next

Hmm. This doesn't look right.

Did you mean for me to pull the tag, not that "for-next" branch?

                 Linus
