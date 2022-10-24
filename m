Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90560BD71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiJXWdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJXWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:33:04 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B6F184998
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:54:19 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id 189so7802504vsi.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G03O7nkbOw/imrCRBctbDfwXE89sOi9G3x2TRrvXC0Y=;
        b=R4dVPEZ9Y3nrZb/ASmBd8LmQ7bbbjg70MAHMGV54ly0w4psIqNkDZQ9CXzZdshZl7U
         4gtVMctjjKpTcDp14y8lCRF5utSbNiOku5YgFV9Tjz2QEFfBF4pwgIq5Vq9qTbR1sqx1
         vzNXIYzbFphq8qLnkDenpl5+vGyXN0+OaMrCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G03O7nkbOw/imrCRBctbDfwXE89sOi9G3x2TRrvXC0Y=;
        b=uYrCURtC0QyCbttC04dxysW+IgCxtanQdO1LpN+7tzXLy/sCTD3j7vb/kEGVhVTozW
         PaKEm9tkhERrXRzScDuGDzuaebzN+QVuYqw1FGoaQz5i3uRJeLDXWxDoCnryxc3WLad8
         aW5eMj8C/gEgRWbdQdwmtD1KSmWzbtjv+jVUgqDSRzymIcfZasWJUaad47vH6vORgFfj
         op+9wDgmCR67/IsZkMa49ENSsRvGnRql/+rXax/gSXYImjgz7XYOwF0sl9ywVCbBJZ9l
         N9/kxe6diwCkgOGyJnSPm7V5efGSVrZ2IoxzUjPDnZOU9fkR36hOco7EbIJaq0H1K1cq
         FzCA==
X-Gm-Message-State: ACrzQf3z/ufaC6EeUEByDPsZe7wmuSb6kKQWmZ7sMWJeILOlWHkK9DBV
        McMwX03MUcys/pDQY5gyHqUObs19YHfezg==
X-Google-Smtp-Source: AMsMyM73ksvnSVfa7WblNR/fA44CMuKMTcX1jX7UgNIGWaAgy6M82p6Xm+sfrJHbKgooCRBAM0ambA==
X-Received: by 2002:ad4:5d61:0:b0:4b4:4f2:3099 with SMTP id fn1-20020ad45d61000000b004b404f23099mr29980101qvb.77.1666641130903;
        Mon, 24 Oct 2022 12:52:10 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b006eeae49537bsm502612qki.98.2022.10.24.12.52.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:52:10 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-36d2188004bso34059767b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:52:09 -0700 (PDT)
X-Received: by 2002:a0d:e252:0:b0:369:36b0:b9de with SMTP id
 l79-20020a0de252000000b0036936b0b9demr18936281ywe.235.1666641129653; Mon, 24
 Oct 2022 12:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221024181835.475631-1-kuba@kernel.org>
In-Reply-To: <20221024181835.475631-1-kuba@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 12:51:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBvN6Qztvdx3ROOaNsHHif8fFz4926DCw+1P9wo26L4A@mail.gmail.com>
Message-ID: <CAHk-=wjBvN6Qztvdx3ROOaNsHHif8fFz4926DCw+1P9wo26L4A@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.1-rc3 (part 1)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 11:18 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> I give up on the GCC 8 / objtool warning, Alexei says is a known compiler
> bug. I haven't seen anyone else complaining, either.

Yeah, the only mention of it that I have seen is in your pull requests.

We have a few other objtool warnings for other odd situations, and as
long as they don't get so verbose that it hides real issues, I haven't
tried to get all hung up about them. Some of the objtool warnings are
about objtool getting things wrong, and some of them are about
compilers doing odd things that don't actually matter in real life.

                Linus
