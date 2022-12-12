Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079B64AB97
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiLLXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiLLXdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:33:21 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2A1839C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:33:20 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id r15so9282911qvm.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fga4qUrgOLw2yQYkt0IWHNCALPR+bSFXVXGNvrtam+g=;
        b=T89ajwxpcbXcHjR4PtXDmD5i/UX6zN5Mci2FNmYP6Ijn1+KckGeEdjUWpRMxmZeOLI
         hD36lMGIXsQ3E93rqbcuvZYuI6IKua/cwG0SEix+oUGyQH7q+OzRmdqXKprP483jb0Na
         FTbS4RbkuQ/R9SYqhH2ac8MWZfGA8NiE5Lk0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fga4qUrgOLw2yQYkt0IWHNCALPR+bSFXVXGNvrtam+g=;
        b=UtXTrlKBB46Hc+XfAiQLrbKTxItFXo67FTmoeOXzHou3hqTeBM3HBaetESX8MlGGE8
         DsXE5i+MiTXOcsWRI9xfAcootYVCUsP3XZyv5ZGQ5Dhv5DFBuAaZhmRVW0X3E5CKrNB0
         aMMeerGd02z3wvyJf0DAN7HaxsnXMw+IqOxBJbZPdnolkH5Dc+wCNYJxkPO3umE+mX0E
         f3PbtwVIxM/DgD4Pxo0jPHARyYtyJn98iY3ocPeHmMs29idWrW8vmcileJqvR1q1y/8+
         Trs2CmKivdHzKTp4Y6ZIlLXK2cp452qz9rQmlx75VEFHrNza2f0k5NWAU2WfxHs7gkfU
         QFBQ==
X-Gm-Message-State: ANoB5pnC9uc3jyMCzW2TaLGfeiEPSQs89u1TSTm3JxI2OglqGf2lA8bv
        gBWQGeWScgNl/A2Agg7PvMYBwZd8k7CqHz+7
X-Google-Smtp-Source: AA0mqf7pvk7LYiKJ4TDgrAZhkS3jB6xT2H49o4j0vEJ8aPaJ73ccGGU9cas7L74e0YL58m4eD8QckA==
X-Received: by 2002:a05:6214:590d:b0:4e2:e61e:4862 with SMTP id lp13-20020a056214590d00b004e2e61e4862mr4515487qvb.4.1670887999092;
        Mon, 12 Dec 2022 15:33:19 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a291000b006feb0007217sm6884472qkp.65.2022.12.12.15.33.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 15:33:18 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id i12so9299664qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:33:18 -0800 (PST)
X-Received: by 2002:a0c:c790:0:b0:4c6:608c:6b2c with SMTP id
 k16-20020a0cc790000000b004c6608c6b2cmr68762628qvj.130.1670887997972; Mon, 12
 Dec 2022 15:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20221212134425.b20b80955e5e8a4a36ce1b9a@linux-foundation.org>
 <Y5eoS/UfBhovR70j@zx2c4.com> <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
In-Reply-To: <20221212142754.5f699c4ff515fd9d42768fb2@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 15:33:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisHBccs=VyL5DBUOmd2pge4OM6An9T600B4rmgnX5mNg@mail.gmail.com>
Message-ID: <CAHk-=wisHBccs=VyL5DBUOmd2pge4OM6An9T600B4rmgnX5mNg@mail.gmail.com>
Subject: Re: [GIT PULL] non-MM commits for 6.2-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 2:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Is there some way of telling git to complain about identical changes
> when doing a trial merge?

No, the merge functionality of git literally doesn't care about
individual commits.

(git does walk the commit chain as part of finding the common
ancestor, but apart from that, very fundamentally merging in git is
*not* about merging individual commits at any point. None of the darcs
"patch algebra" nonsense).

But as Vlastimil pointed out, git does have various log-based models
for finding identical patches based on the patch ID.

Those are intentionally not used for merging, but for the various
"move patches around" models (cherry-picking and rebasing).

           Linus
