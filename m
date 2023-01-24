Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A3D67A409
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjAXUh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjAXUh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:37:56 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31BA4B1B3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:37:54 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z9so14209680qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZljQXUAv1zGBqD9bK2Eq8FCbMFjab23U5zice80vuU=;
        b=X002AKiZUf3hGcCKm5944aKx1gFXf+DZmQLKkow8NxeqbeQinBQkAPxXNfzd9giWWq
         TePtDtrs0p7XlQAKo2pQMD+w5W95gdaCOTzMjQva9NwhVLL7pPqWnJDfCvgtxZ4iqDEV
         wFUNFn3c5X3JOQuGaOe3xp+xT7JmtXqB7s2jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZljQXUAv1zGBqD9bK2Eq8FCbMFjab23U5zice80vuU=;
        b=ERjWvNVnLZw8GUQcgQRWMzlkBzP21AT8vo7WkX8mD79Wu2H0Q9cL2il7QnG5gxSHQv
         DyQ7vvUsk956glG8hgmj/f7NPcANZGtVO2w0IOEZAJAuNx9N6j3NMXzWsyv1ujwkwZKy
         3KDADSXRM7iIBmkte0J+EabK8OE6IPByDteyc9aDAAElxnT4/hqK75EZafdP6tb3qQMy
         BT5i792xXT2yse3VDKvEFUqRpRkQ5vOsAuKhTT6iBesQ7Msq4pWjn8HKlTKCH+Og6ArV
         VTBUQeb2xUk94Vu9PfoSz8OBwee85oFEPQ/2dkFqMcIYGCW3hyJsEFBuw1zGv9d1xK//
         LWKw==
X-Gm-Message-State: AFqh2kosKibwCGCnjPM7O1Q7zLhnG/Lci8ENEF6LiGEfrXLnjfcO0Ybl
        nmWkCCrL1INWbSqtXzgkrjcjqC4SmZbTFmxO
X-Google-Smtp-Source: AMrXdXt2BoCo1Tbrjfg/ImvQ8Uuzr10mIfFlojLor1EYioHsrbn5XIDxGojm8i4TDbyMDJ2aZN5gBw==
X-Received: by 2002:ac8:4914:0:b0:3b1:ad76:eefe with SMTP id e20-20020ac84914000000b003b1ad76eefemr44805177qtq.10.1674592673682;
        Tue, 24 Jan 2023 12:37:53 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a13ef00b006cec8001bf4sm2093675qkl.26.2023.01.24.12.37.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 12:37:53 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id l1so8778168qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:37:52 -0800 (PST)
X-Received: by 2002:a37:6387:0:b0:706:92f4:125 with SMTP id
 x129-20020a376387000000b0070692f40125mr1629012qkb.72.1674592672602; Tue, 24
 Jan 2023 12:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
 <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com> <CAGudoHG22iS3Bt1rh_kEJDEstj3r1Mj4Z305vqRbP8vBjQZ3dg@mail.gmail.com>
In-Reply-To: <CAGudoHG22iS3Bt1rh_kEJDEstj3r1Mj4Z305vqRbP8vBjQZ3dg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 12:37:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjzniFhDkfXzE4r9NDxsneKD3hkxzq7tHvjfbgr2ZdhEg@mail.gmail.com>
Message-ID: <CAHk-=wjzniFhDkfXzE4r9NDxsneKD3hkxzq7tHvjfbgr2ZdhEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On Tue, Jan 24, 2023 at 10:42 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> So how about I simply respin with the comment I mailed earlier,
> repasted here for reference (with a slight tweak):

Ack, that's probably the way to go,

         Linus
