Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDD5F4DAD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJEC1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJEC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:27:39 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679E70E75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:27:39 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso9990528ook.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4CqgMMgGti3nbUch6rY/nGH49ewEwwpbVKsOC5Sx6a4=;
        b=QNeZV766BPRP5CDpCJmRmftc/VK0lHEpkL01dT1PH6tjqT18FqSPvAUc/ZjQ8hogHB
         r0U2kgNDsMO37Vqo6zg+VUt2jZOhG6p8lG3kzI85lCCPNigLMzVuWqiHvTSC0JbdE6q5
         NANw5MljB3T4KlAr3ODez3bZf9Zefodxokelc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4CqgMMgGti3nbUch6rY/nGH49ewEwwpbVKsOC5Sx6a4=;
        b=1UjNTHjQURZgebq7AYyiHiUyFUTjau7IAZS2k7fgEN1x3StBiPl0ax7K+haaHy+8gp
         8MElvbPV5qhPs4C7KLhY2UM7mzT8qLTeslPrZqx02zAUFNU8VuR0H156t2OUwMNA7Upz
         kRIbBzv81h0y7VsESpHkrapxRfWrMmamT5AX5LmjnUcqd5AA3q0CE0M+1yKbaFN8i/Sc
         y77G/cKTMJbyIxeewYFELhcEsmq2dJuUaeRs5XnYHUiBs/fugJRhDSCQtiwI5O69z/um
         zy2T/T4cjRvki3I46ZVu1QgzdQyBis6TPanne/FH2kRW2sGtWlTkkUFlQTNt2c6gl1IR
         xpfQ==
X-Gm-Message-State: ACrzQf17WccoivfdnJzTrsktP+lyP496oLPDHd01EbtfC/yxCBNzhI5h
        c4in6jasfIxm+lSKWR+Z4K338RJ0/nPKiA==
X-Google-Smtp-Source: AMsMyM6XNo+CgNEDuJc/x+agJkvqC+zBVJHppe6kgZo30m86/8HndkjVHIAC8bBa5pisQu3sGLlj4w==
X-Received: by 2002:a9d:61d9:0:b0:660:d6a2:95f with SMTP id h25-20020a9d61d9000000b00660d6a2095fmr1323100otk.239.1664936857899;
        Tue, 04 Oct 2022 19:27:37 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006393ea22c1csm3514335otk.16.2022.10.04.19.27.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 19:27:37 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id w70so2118697oie.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:27:36 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr1234146oif.126.1664936856681; Tue, 04
 Oct 2022 19:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221003124639.E723CC433D6@smtp.kernel.org>
In-Reply-To: <20221003124639.E723CC433D6@smtp.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Oct 2022 19:27:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVAhwNSNtDB7dXhetBoHHDL70FF=Zx4T72yfT7kdYJ+Q@mail.gmail.com>
Message-ID: <CAHk-=wiVAhwNSNtDB7dXhetBoHHDL70FF=Zx4T72yfT7kdYJ+Q@mail.gmail.com>
Subject: Re: [GIT PULL] regmap updates for v6.1
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
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

I've pulled this, but...

On Mon, Oct 3, 2022 at 5:46 AM Mark Brown <broonie@kernel.org> wrote:
>
> Andy Shevchenko (11):
>       swab: Add array operations

I wish people didn't add pointless inline functions to core headers
for things that just aren't that important or common.

Partly because it just makes compiles slower. But partly because I
think the code generation is questionable too. Does inlining really
help or matter? No.

And are these actually ever likely to have more than one or two
odd-ball users in the regmap code? No.

IOW, this would have been better off just being kept in regmap code,
and never hit a generic header file that is included by absolutely
*EVERYTHING*.

Now, if would be one thing if this was some complicated
super-optimized code that might actually matter elsewhere too. But it
*really* isn't. It's a completely trivial (and fairly bad)
implementation that is "good enough" for the one single use it has.

IOW, if we actually cared about something like swab16_array() enough
that we'd want to seriously export it, you'd do it a word at a time
(two 8-bit shifts, and a masked combining bitop).

But we clearly don't care.  And for the same reason we don't care
enough to make a really fancy version of it, I don't think it should
be in a generic header file and make every build slower.

                  Linus
