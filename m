Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2864ADF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiLMC50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiLMC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:57:18 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6453B13F2C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:57:17 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id i20so4249117qtw.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tX77HP0QHLpr3cKm85qCHM8IpEChV7xCFgi6dZ8AJTc=;
        b=FWwrj6dBz0lP3LMXUBKtg+/REjLgScBPOVyHpMVxzQvBkXgGh3ilhnCzBHZohhHBIf
         N3SkVB2fFbKOw1hjQkeGnSJavm4o4syxXltU73rtEcOVE7jLTkYAhidILigVZloYXY1M
         N51CFmGr6cpPwmHbqgnLaUlepwWfaQe7MyicA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX77HP0QHLpr3cKm85qCHM8IpEChV7xCFgi6dZ8AJTc=;
        b=7P60VSyjnO1NPz4vwAD4zP6cgyP+ZhxFqv3IHDsy8LSDsxpdeESKKHYe9ukb3oIAUf
         S4icafTauikQ0A+zFZPk22aIydKClpFhPVJhLJ6DRTfGWdP8WuACdCYAisjeCk2L7tGj
         Gb58y+Q+H4OGx9KpQ36g4A54ksSrTmPZS7w+oJo6bCbHPeo2eIOBlvACmNHKlTChfFSn
         ZLmMIyQBJQj0lY4gszY6NcLjMVK6UNeT9+ZIOzIdGvML/hpSfGRONYDEDbGdkk2R2Y6y
         4n1JmACXWMRz6FdrZ9Mng+J5axsaKLpBPFnSm3RvnAFvpZGoi94ZcGASk+NcF56e+TFB
         l/9A==
X-Gm-Message-State: ANoB5pmeOKfoMGkycIOKKMuYCSFxa/AnU18eUsWC8fYoWSjhdyquJ92o
        SdajAtAKJ16uCc4UNKgu91D+GIGY3deljePe
X-Google-Smtp-Source: AA0mqf5pmmIQxi5ZtjzFbH48wx6bjrWnsu4TSm+4J3Iih7c7a6H/DG6XOA37OZ8JOPNZ0k8KZ8e0aw==
X-Received: by 2002:ac8:7c94:0:b0:3a7:e514:c7e3 with SMTP id y20-20020ac87c94000000b003a7e514c7e3mr23909481qtv.66.1670900236142;
        Mon, 12 Dec 2022 18:57:16 -0800 (PST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a2a0a00b006fb9bbb071fsm7203009qkp.29.2022.12.12.18.57.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 18:57:15 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id r15so9563615qvm.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:57:15 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr70676848qvp.129.1670900235313; Mon, 12
 Dec 2022 18:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20221212111919.98855-1-brauner@kernel.org>
In-Reply-To: <20221212111919.98855-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 18:56:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=witvjWrYOqbgURdeH7cv7bkVT5O2wd_HcoY6L-3_3yK8A@mail.gmail.com>
Message-ID: <CAHk-=witvjWrYOqbgURdeH7cv7bkVT5O2wd_HcoY6L-3_3yK8A@mail.gmail.com>
Subject: Re: [GIT PULL] acl updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 3:19 AM Christian Brauner <brauner@kernel.org> wrote:
>
>    For a long and detailed
> explanation for just some of the issues [1] provides a good summary.

There is no link [1].

> A few implementation details:
>
> * The series makes sure to retain exactly the same security and integrity module
>   permission checks. See [2] for annotated callchains.

There is no link [2].

This was an extensive changelog for my merge commit, so it's all fine
and I've pulled it, but it does look like some pieces were either
missing, or there was a bit of a cut-and-paste from previous
explanations without the links..

              Linus
