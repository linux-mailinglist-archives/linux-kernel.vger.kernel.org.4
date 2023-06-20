Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B87374D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFTTA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFTTA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:00:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D510FB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:00:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98934f000a5so129308566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687287653; x=1689879653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bdyV9dLq2Mdij79/U8UvPIgVPaaCjQd3mFspTqiTiFo=;
        b=dbCzpzWvqbq7pFQGqasieuRvpG/rA0UJ+2Y0VFJN26UilFZKWI9Z5nXP8Y7rDSAtqF
         Lzt56q3epeOyZWxy8kzMNHM3siWOvLLcowfuDax3AabmkBYUk1W39MbPwpQUb3KwmuEL
         KVDtz12BmuIjcrmbg2/OzxgiOfQiWNcEnLLsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287653; x=1689879653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdyV9dLq2Mdij79/U8UvPIgVPaaCjQd3mFspTqiTiFo=;
        b=hfW973SvqyQWfkdq1NAwzzJCpdIf7yMZDpz4QhFNgC41i85h0L5T3EsUtSxHcswf3a
         F9rAmRKFk3wwGOfujxxQeMNm6KHYq1Eu0hQC/uXabs3cKxLAYUSqgnhfJvHPglopyYi9
         Jy/rxY8t3U5mI3LjzWuIatfeqGM1/UlPBWHA5H5RYFuwg4Q33N5CWZy0ZxIS8WN/g0Y9
         BgIdxRXndz9O5Qa21Db9rS96VZFPz8hndKePHKrIe0n1c0delHsKxJHBHAh5U/dFOrj7
         y4NFgGuspKRdhIvqpZ+Px3vewopEcpZG5/BUiFh0ETUdyLMwIHcfWX4WtYIcIs9uC41h
         aTYQ==
X-Gm-Message-State: AC+VfDx84bHMmX7YTVViyevG2K61trIjJSC0WseZ6a+g85MXUPwrJVoZ
        2CtjA6zOGzwxlxCnxrQ3SGSdtvOdfw6HQ6CcQDYDaA==
X-Google-Smtp-Source: ACHHUZ62S9xIJCOlTHSmqVNDCs7rG57sT9JA40TSIOgamwB/BtDFi6GjhWV5skdmfd7/hQz3SvSYNA==
X-Received: by 2002:a17:907:72c3:b0:988:cb57:f741 with SMTP id du3-20020a17090772c300b00988cb57f741mr4331395ejc.54.1687287653218;
        Tue, 20 Jun 2023 12:00:53 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906279800b00986d8722e46sm1903439ejc.17.2023.06.20.12.00.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 12:00:52 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-985b04c46caso752354166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:00:52 -0700 (PDT)
X-Received: by 2002:a17:907:2d2a:b0:988:d3e9:e61b with SMTP id
 gs42-20020a1709072d2a00b00988d3e9e61bmr5116880ejc.73.1687287652336; Tue, 20
 Jun 2023 12:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687283675.git.dsterba@suse.com>
In-Reply-To: <cover.1687283675.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Jun 2023 12:00:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH1oW+bFGxbWOdfkB930fZMm7maKywgvpKXkWXmQi2zQ@mail.gmail.com>
Message-ID: <CAHk-=whH1oW+bFGxbWOdfkB930fZMm7maKywgvpKXkWXmQi2zQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fix for 6.4-rc8
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 20 Jun 2023 at 11:30, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-6.4-rc7-tag

I think you forgot to push the tag.

I see 'refs/heads/for-6.4-rc7' in your repo that contains the commit
you mention, but no corresponding signed tag.

                Linus
