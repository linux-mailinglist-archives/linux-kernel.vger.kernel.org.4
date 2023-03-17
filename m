Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A536BF2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCQUg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCQUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:36:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014E343458
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:36:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x13so25048019edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679085377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqjxzeWs79iOMWhYJn3jT4Jg8VZgXU4x4MtnJEvi6pI=;
        b=XWtsaWsJtWw+XxYO1x6tysrs8PjMryT+4I5wAjjJB0h9PCXoQvPFzQxoFQNYiAm3N+
         aEbrOjYHOpFL73gjQmscELsDGjbRrFQYnUu+ehiBn3MjgaRgg4VutlrMOznvZnDpXT9q
         xU+VdNs4hS4VsUxF2nzf2n5Ucc/pcEGJvJIMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqjxzeWs79iOMWhYJn3jT4Jg8VZgXU4x4MtnJEvi6pI=;
        b=3yKvAubIQcVoOIKtKMNz2+HkLMfb6X7LobEYDY2MKuVqlSRkTt8IuhpcxeR9hTWlIv
         L/Wk8aNhSI70lMcNOdCgMmE1pBpesOOFMBJJ9RarFOo3l6JdyZphRYq2LZQ676Ji+D6j
         Nm4sRZAljMLQqJdlMrTXt5az9MsNfPeBi+UmwahzDQ5DmiVGJdy+punHy6OQoCQ6+QRG
         uxgnX27PWy0w4QdxbleuaoW9x67RiFgip7Gam+RbBjGfIfo5JL7ZOvFoGe+0LC2gjysB
         RrF+OBgJ9+i7ZY3V6HnIHqt8dpbe/FPeMFlgaxRYrUM0VsbGrn7la4kVYYUUpegd7Hun
         3i9w==
X-Gm-Message-State: AO0yUKW4CerGs0qjWdLSv7qPaATWsJXTz/Vb4Kj7NmQWsippOJlAbyZS
        hJPFblr5KacCcdsabuF7T5PGb6hS1J2yYfi1CAF+gQ==
X-Google-Smtp-Source: AK7set8viGOM20gkDDKXKzgEuAdFJxwUuZDudl1kyGyQrfo9bdTzJlsf0uo+AufpKAWsl+8jb5ToVg==
X-Received: by 2002:aa7:d782:0:b0:4fd:1cf1:b7b0 with SMTP id s2-20020aa7d782000000b004fd1cf1b7b0mr4310256edq.7.1679085377170;
        Fri, 17 Mar 2023 13:36:17 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id m23-20020a509317000000b004fb95f51f54sm1522193eda.12.2023.03.17.13.36.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 13:36:16 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id x13so25047822edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:36:16 -0700 (PDT)
X-Received: by 2002:a17:906:9615:b0:931:2bcd:ee00 with SMTP id
 s21-20020a170906961500b009312bcdee00mr303770ejx.15.1679085376150; Fri, 17 Mar
 2023 13:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230317202922.2240017-1-kuba@kernel.org>
In-Reply-To: <20230317202922.2240017-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 13:35:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJxtMDPoFzuh8CfzcDbrKwvCYFXrvaEe6=e2syr7TwoQ@mail.gmail.com>
Message-ID: <CAHk-=wjJxtMDPoFzuh8CfzcDbrKwvCYFXrvaEe6=e2syr7TwoQ@mail.gmail.com>
Subject: Re: [PULL v2] Networking for v6.3-rc3
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 1:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Here we go again..

Well, this time you're missing the diffstat and shortlog....

Other than that it looks fine ;)

I've pulled it, because the diffstat I get is within the expected size
(ie "slightly bigger than the v1 diffstat that was missing some
stuff"), and the top commit matches what you claim it should be.

But a bit more care would have been appreciated.

              Linus
