Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1146C2475
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCTWRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCTWRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:17:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37AE3646E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so52668181ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679350627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPrDTO6iMVUmjsFudsdQ6YBX68bwKPdUhbwstJv4XRI=;
        b=Np6qEHO9voE7U22P996b3r7yR776TvxEhHp76fMnrlk6RVjxDJJ7c00Tg/LRky+UFp
         aHD51lSKBYo/vUXG/Y02MD7FfkKaxZbqbMoQoSZhrnMAXrosZ+csacZqdCFfExV4P+Yd
         pDnftu0zAKQr8fbspXKRMvEqn0TelHl28lrEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPrDTO6iMVUmjsFudsdQ6YBX68bwKPdUhbwstJv4XRI=;
        b=PzVGgyE/E0KId1B8zOi1YiCf/CioMBKX09CyCfjOJmmo8wpVzDC8EpW/G0O4GMb2XS
         5F/sfd53jKuHLIWvYQOOcXQ6bmfxZbbie/Uxu1v7xktw58CB3wUvLphHUVbdbNFlvP6g
         nS3dl5WQEgmwqWpO+l/xyjriZUzp3BANr9EE0F8Spd8Goh7dixqDsuoazZy6KIfsEA5a
         +BchCMg6O4GCsVzFTpSr2bJ21xBBLoaWM+he4sy2hV7ZFoH6T6qD+DoraqMXiX3Ed8f+
         1BDwqbd5AEr6XggHizfkFqKvr6QUwa9rJuYPXnrj4hc5hZfRNqZSdOSJgkktvAi/Cp6/
         PK2g==
X-Gm-Message-State: AO0yUKXh/89/3eLkreU+vrFhYtutnn1/CdvE7HywviQYEawNyWicqpeT
        pN4gNa8Q5tZhGFy1GKAOCejXD6PeZqgDVzMJPSQCUqeQ
X-Google-Smtp-Source: AK7set8DqT+gwJN/IIbQ3PNOoCnPNInZFnYUmfOPBRH7hN5IISPzBMLvV7asSRNFsi9KriU5qt8zwQ==
X-Received: by 2002:a17:906:b087:b0:926:8992:4310 with SMTP id x7-20020a170906b08700b0092689924310mr632899ejy.38.1679350626952;
        Mon, 20 Mar 2023 15:17:06 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090635cf00b009307ddcd13esm4903866ejb.119.2023.03.20.15.17.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 15:17:05 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id b20so19750522edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:17:05 -0700 (PDT)
X-Received: by 2002:a50:9546:0:b0:4fb:2593:844 with SMTP id
 v6-20020a509546000000b004fb25930844mr582214eda.2.1679350625492; Mon, 20 Mar
 2023 15:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205617.GA1434@sol.localdomain>
In-Reply-To: <20230320205617.GA1434@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 15:16:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
Message-ID: <CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com>
Subject: Re: [GIT PULL] fscrypt fix for v6.3-rc4
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 1:56=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
>       fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref=
()

Side note: please just use WARN_ON_ONCE() for things like this, not WARN_ON=
.

If it's triggerable, it should be triggered only once rather than
flood the logs and possibly cause a DoS.

And if it's not triggerable, the "ONCE" doesn't matter.

I note that fscypt in general seems to be *way* too happy with
WARN_ON() as some kind of debugging aid.

It's not good in general (printf for debugging is wonderful, but
shouldn't be left in the sources to rot for all eternity), but it's
particularly not good in that form.

              Linus
