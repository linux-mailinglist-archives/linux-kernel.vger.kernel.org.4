Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB86491A3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 02:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLKBPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 20:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKBP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 20:15:29 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0A13D1D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 17:15:27 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so5840511qvq.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8wxfaikdFYvVtdWG+RjLvFSxS3wMPNKgsWLeD6RevA=;
        b=PnRfvDH2GYJEcZVZ7MuoIVohSMSURlQA5ojSh/eZy9+le5NfiH7p47dDLE+nTmTif3
         A3A3nWJAkwjNYD1MedUAGzaA0jICqz4q+LZslug0aUKQj+spGveC6L6B+nfCrZie5sJM
         yCsPek51vqZssxsmyJaSiQW4mkRjcmJyi8vP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8wxfaikdFYvVtdWG+RjLvFSxS3wMPNKgsWLeD6RevA=;
        b=tJa4Z+rr/KpEH3gYbVdJnSz/W5F7h8osDPwYz90EP1g8FPBFv3U2ZoZJRP/0jAOF17
         DNRhVyzVhppbm3pbEw8ODF6MS6IAQurLKRjHoyWQ36YhfvicdBf+PkrU2wj4tC20Wvj1
         rmyBtjd74ibz9PjfonIoHiPj3xzyTCVTvKwG/uE0fqrpVM8vVV6eKC1tVYq+YC5BjvQA
         SCS1Zds211HDYpHp1hoNqzf99A2AVERKDo/mOKGEzy14n1xl5ZNR4yy++MtjlIeNLSsb
         ZiPm61npWegwhjYwtX43Vx0Z1QcRqxSf/ZnWt1tbkaI2Yit45MoRmDzksud0iakZG2Jx
         Beew==
X-Gm-Message-State: ANoB5pmxYhyviBL0GHPnZpcM2PrB6wiNL4OTaVRImma1WH3DobmJlFe4
        8EXIW9/2bxAJWkqS0TCyYPTbpytFDXRFjDua
X-Google-Smtp-Source: AA0mqf6eOfQev9tqFUXKKUxmRckziLd4VvnafP1RSQiINsGa68dxGQzpkhmeFhHEffU562c+yvIu7Q==
X-Received: by 2002:a05:6214:2402:b0:4b4:a3d5:8ce8 with SMTP id fv2-20020a056214240200b004b4a3d58ce8mr23956008qvb.10.1670721325844;
        Sat, 10 Dec 2022 17:15:25 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006feea093006sm3117666qko.124.2022.12.10.17.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 17:15:25 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id c15so6488393qtw.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 17:15:25 -0800 (PST)
X-Received: by 2002:ac8:688:0:b0:3a5:122:fb79 with SMTP id f8-20020ac80688000000b003a50122fb79mr76107362qth.452.1670721324812;
 Sat, 10 Dec 2022 17:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20221210170317.130e7dbfc0e78de6067c4012@linux-foundation.org>
In-Reply-To: <20221210170317.130e7dbfc0e78de6067c4012@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 17:15:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrapQ=pf0Btr9_0bso99E5Mq6FgANKLbN0mkdohfB4qQ@mail.gmail.com>
Message-ID: <CAHk-=wgrapQ=pf0Btr9_0bso99E5Mq6FgANKLbN0mkdohfB4qQ@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.1 final
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
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

On Sat, Dec 10, 2022 at 5:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Tejun Heo (1):
>       memcg: fix possible use-after-free in memcg_write_event_control()

Heh. Apparently your scripts to notice that some patch already made it
upstream didn't notice that I took this one directly already when it
was posted, so now it's duplicated.

Not a big deal.

           Linus
