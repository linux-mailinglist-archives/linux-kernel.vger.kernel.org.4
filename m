Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DEB5FA1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJJQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJJQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:16:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE8117E04;
        Mon, 10 Oct 2022 09:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49562CE1300;
        Mon, 10 Oct 2022 16:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D20FC433B5;
        Mon, 10 Oct 2022 16:16:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WFRemyA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665418578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=An7SxgPJME6TRH3eE7R/BWGywdOawFEUlLC5A6+4ELg=;
        b=WFRemyA7W+cllJ9sEiVWidp03OANuZ1+x/HOPET7yswqUgQob1hYglK/U/t+crkhnv5knc
        9XwpM/3lxxTBIuypdqgRNtEbje3Mqg0Ex2mHZbO5HclQkEGL1VV8D5SJJVZpGtrxVI+5Xe
        qft4ju5Ib5bMdEYqC55z987Ak+MoKMw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 80c18cd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 16:16:17 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id l127so11740702vsc.3;
        Mon, 10 Oct 2022 09:16:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf2iJXpzW6aipef77AZA6whw6rcr4iyFFBGUp9kFREw46MzxJFVR
        dgnZufqSBSzEcawt8hQNWHf2au5RhAwxiYAA49s=
X-Google-Smtp-Source: AMsMyM7svWfaQu7wb8PyYpdklzz8Js1WuE1s5ndZYDCcjHFKl6TMfUwV3CN2MNetHHeOPcZ+pNbn+U80k7UxwbxXUvA=
X-Received: by 2002:a67:c297:0:b0:3a7:5f0c:54c4 with SMTP id
 k23-20020a67c297000000b003a75f0c54c4mr6907769vsj.76.1665418576377; Mon, 10
 Oct 2022 09:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrff==O4pbJc+OjnrLz3so1D6spp_YvOkSiu-cFp3z8ZbHQ@mail.gmail.com>
In-Reply-To: <CAO4mrff==O4pbJc+OjnrLz3so1D6spp_YvOkSiu-cFp3z8ZbHQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 10 Oct 2022 10:16:05 -0600
X-Gmail-Original-Message-ID: <CAHmME9rX9rtfvHreQFmNbp1RZmm0+VfU7LVPPVVYmk1-ME6sqg@mail.gmail.com>
Message-ID: <CAHmME9rX9rtfvHreQFmNbp1RZmm0+VfU7LVPPVVYmk1-ME6sqg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in hwrng_fillfn
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au,
        linux@dominikbrodowski.net, ebiggers@google.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting that you're seeing this on a 5.18-rc6 kernel. That means
it's *not* caused by the recent changes. (And the virtio hwrng driver
has quality=1000 anyway.)
