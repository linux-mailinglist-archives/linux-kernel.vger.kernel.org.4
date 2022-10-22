Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE49B608EE2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJVR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:59:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC1EEA84
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:59:10 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d13so3938943qko.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kR2lCTGWgMz214b8GhdMkfWykvXGjxW4l/uIri5q9eM=;
        b=BujJmMDP9ZReOG8zY3PgE6e6S/Hhw5l0z5I52WDJ6i6xJptA66E8g639Mk5ekrks2J
         2aN20iNRWvbrfcRDDw9sbN6olaV6Wk4UZAHCESJb1ipxl8Kzkt5F07QVdM7xlxdHEuJ9
         TiQ33g53l8YKIJ7qB+JvQVGhJFeZdQT2e5rnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR2lCTGWgMz214b8GhdMkfWykvXGjxW4l/uIri5q9eM=;
        b=OPSvWtmvWolqziJhjX8kccHH4enwLUiNn91Y8ZcvW0KqIrv2a7OUDt2LHPTvVzkszv
         2peBoGFBSult8oarITl+tgq8azihKJCLBJJTHZRSacWJnINjfeUdb3jShCUjcl1R7WL2
         s8xZsLR35RfgEtcN5SMJY7puoIkW/TQEcpaUhzn3hYz1+bzgBI6lUR1T+HsI7HWousqY
         w/skfFqsLJ5tql+rYl1zvOw+cVGg/ADiQG5uN/fbz4Y3uJku7uMuTo62cFQPka6c6Ib3
         yn5OG8mby5uqxWmPuj30bGb2EyIyrQz3YW44dBZG3psP1zHGCcS6P3WcKxHbtQ++iZSU
         COIg==
X-Gm-Message-State: ACrzQf0MeUZQj8RD7JiMDNHs+fjXE8/nLm1U03SXydlBDXT406aYlfzA
        wWCDZrIKaw3i6qgIiGc91NZ1TdVvrUnHJg==
X-Google-Smtp-Source: AMsMyM62And5Tx9hPBVVvDky8y3wdywtQl9mbAadnVwlGdfVRE1719wGRsJXGc1EtnU3A8Ljd2Faog==
X-Received: by 2002:a37:8981:0:b0:6f1:1560:ac7d with SMTP id l123-20020a378981000000b006f11560ac7dmr4128667qkd.659.1666461481675;
        Sat, 22 Oct 2022 10:58:01 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006bb366779a4sm11519394qko.6.2022.10.22.10.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 10:58:00 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id r3so6804341yba.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:58:00 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr23340212ybu.310.1666461480005; Sat, 22
 Oct 2022 10:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org>
In-Reply-To: <20221022111403.531902164@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Oct 2022 10:57:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBOOY6ph_NByY0Xiuf-fQ2QdAWdE=9Lni81BEUgxeWQA@mail.gmail.com>
Message-ID: <CAHk-=wjBOOY6ph_NByY0Xiuf-fQ2QdAWdE=9Lni81BEUgxeWQA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Clean up pmd_get_atomic() and i386-PAE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
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

On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The robot doesn't hate on these patches and they boot in kvm (because who still
> has i386 hardware).

Well, I had a couple of comments, the only serious one being that odd
'__HAVE_ARCH_PMDP_GET' that I really didn't see anywhere else and
seemed actively wrong.

Other than that, it all looks good to me.

Thanks,
              Linus
