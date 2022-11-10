Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E9E62382C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiKJAaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiKJAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:30:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FC13D01
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:30:14 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f5so1164058ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v4yTYtNFCr2DMFGxVYe8BkHHgi9YJBUY78E57QbJ4b4=;
        b=QPh+dXTNNNqvMpbHZ+zyyruTS5AtCQvm6jcqLL2W9v+PwLC7vDe3logqFmZD94dYSP
         j6gODfcUUWJDTpUyk8hmXXMbo328Gv/iEL/11fF5vrLy0rJupS7Hu5DJ6Kbwjs4Fqbwx
         alPJToOLgsVzSGLZWe/LaiY8wv+0RY0qSb1+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4yTYtNFCr2DMFGxVYe8BkHHgi9YJBUY78E57QbJ4b4=;
        b=50Lgu7To15V1JpwOuPPniZhszOXH7xbuf53ZQ8bHgIc9z0PgftlasPvCDQTi3EfWK4
         xr/hkO4wZ7D0W5dvGzrK8JRHR0J5Z1A01ljkTFLJOjreyXkIbhdJUC21Do2v/UhepHJd
         8/UkcP0gxkAfOsUfdXND94CW3Wz3pk7jhoZuksp/n2WD7WwHsxMGQRJPna9690g3IoI6
         vcdxVA4JeBO15rfFDHrXsxqt0jck4sTRas5t8fgCPkxJQpWl9agh6Ncyomd+m+nlCrOM
         UgRH1uqcEDMwjsmT6FQDNDInQrfEZ/la9hEl+BlcvgBiyAPHK0wrWM3WHRDK+QP8qjGP
         lSBg==
X-Gm-Message-State: ACrzQf3zMenKDaTVrCkHHuqk4xpqlwrSRTNVVunZ3W0LUY9xSlkuqL2U
        VPicR6vjygrgwhbaZhCE96mzORvUwT0laQ==
X-Google-Smtp-Source: AMsMyM5eEvNoCM6XXgdOwb2W457vufIz7QSny28y7BQMRMCQtr6JPnp0o7KzKVpONOCR58lrvoc7PA==
X-Received: by 2002:a17:906:fe04:b0:777:b13d:30a6 with SMTP id wy4-20020a170906fe0400b00777b13d30a6mr57486706ejb.248.1668040213263;
        Wed, 09 Nov 2022 16:30:13 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id x6-20020a05640225c600b00463a83ce063sm7636041edb.96.2022.11.09.16.30.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:30:12 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id g12so121582wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:30:12 -0800 (PST)
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id
 d3-20020a5d6dc3000000b0022abcc321c6mr41571850wrz.450.1668040212003; Wed, 09
 Nov 2022 16:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <202211041135.EAC889BA08@keescook>
In-Reply-To: <202211041135.EAC889BA08@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Nov 2022 16:29:35 -0800
X-Gmail-Original-Message-ID: <CAE=gft5Tw-iX8M1zWc419X-mwYTYvxZJiKxR9Q1He9dY7A3C5w@mail.gmail.com>
Message-ID: <CAE=gft5Tw-iX8M1zWc419X-mwYTYvxZJiKxR9Q1He9dY7A3C5w@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] PM: hibernate: Add kernel-based encryption
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 11:38 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:15AM -0700, Evan Green wrote:
> > [...]
> > +config ENCRYPTED_HIBERNATION
> > +     bool "Encryption support for userspace snapshots"
> > +     depends on HIBERNATION_SNAPSHOT_DEV
> > +     depends on CRYPTO_AEAD2=y
> > +     default n
>
> "default n" is the, err, default, so this line can be left out.
>
> If someone more familiar with the crypto pieces can review the rest,
> that would be good. :)

Eric and I emailed briefly about it a couple weeks ago, he said he
would try to take a look when he could. I'm optimistic.

-Evan

>
> --
> Kees Cook
