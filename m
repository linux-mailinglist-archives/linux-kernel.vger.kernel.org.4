Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF275FAB15
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJKDUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJKDUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:20:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B512C18369
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:20:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u15so8700667oie.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t1BVZAdPTxFxg7htOV+murrsY5ewQUXBRikH12qoJyY=;
        b=Gyb29+Q9yQfLY6mNF1kL2uDuCDDOq+5XuvnECS3WY8ZmpRIeu52yqk5VAu6WTTSbm4
         iwj2FcStEqxkuNrMBOLqajvs8Y5zPIFbTb/1pVkFDkmxIxmjyr1ofsFxtftvAlPk80Wu
         GysbjOm0DKyJOFaixiQTpyCqbTcq/NH9Q6J4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1BVZAdPTxFxg7htOV+murrsY5ewQUXBRikH12qoJyY=;
        b=2hljqpThgpUgwXlf1DU5swYMVxcu6D7ls57t9bfvkTPRmodUHvfqNV+I+i/ON+wHx4
         tbxqtqgr1DSDoxqxVBn5yik8ovCjM+J4BoJ8fiYYAep5eRbrNZj695vVgZN3G3fXAvsg
         SvRfonZVOUDVFeBzNihf26LPy3jkA4wgxjLk0DltIPjFKSWMe9Qom+M24LWHh2i6Y286
         DvcJ04Ms4Az3VZhtpDLwTNaNFrUDB8KKpKYn1u6GWHUR4W8l2TZmcGudZHAx3tynxboR
         yUcs4Cs8yCROQpJVoLRWGx+e/62GmI9sy58whpj5g1roQgIgMu+7MHILlRl/Y/Hm37TT
         vaIg==
X-Gm-Message-State: ACrzQf1EIXMwWJg9keyGxHE5/VHzmqZlymT/7+1rW/nAQNMbfmM35FFO
        CLRfF2gqCoaql/Gt4KuulNzGqk7kK/Whog==
X-Google-Smtp-Source: AMsMyM6EmzjQ/aaAG5P8TDbWw5QZhoils5bC1EPZAGGj39Mk+UTEx25bwyhE4z8RbvZVXiiKBI9hjg==
X-Received: by 2002:a05:6808:1142:b0:350:cbdd:c9d4 with SMTP id u2-20020a056808114200b00350cbddc9d4mr10235335oiu.124.1665458400395;
        Mon, 10 Oct 2022 20:20:00 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id d19-20020a4ad353000000b0044b22632d51sm4839098oos.2.2022.10.10.20.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 20:19:59 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id m81so14641612oia.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:19:59 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr10488141oif.126.1665458399254; Mon, 10
 Oct 2022 20:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <YzpC+uJlYq1nbcIw@yury-laptop> <CAHk-=wgO5YjyPRz9dfP8AyZ8kKZPSQ78xyEbi8WmuHe09R36Hg@mail.gmail.com>
 <CAHk-=whf2zgBzGMse-y-yD_oTfofRHQQV-gy3O-iQBE7oOiSGA@mail.gmail.com> <Y0TeAGLngwVbgtuK@yury-laptop>
In-Reply-To: <Y0TeAGLngwVbgtuK@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 20:19:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5n7w-HXeQZCzsr=8cH_6tTsm_4-bCsU3ChrSjCFoASA@mail.gmail.com>
Message-ID: <CAHk-=wi5n7w-HXeQZCzsr=8cH_6tTsm_4-bCsU3ChrSjCFoASA@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap changes for v6.0-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Mon, Oct 10, 2022 at 8:09 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> > So I _think_ all the nr_cpu_id's games are mainly because we don't
> > want to allocate huge arrays when  you can't actually have that many
> > CPU's - but for a small NR_CPUS situation that just isn't an issue
> > anyway.
> >
> > Yes? No?
>
> You're talking about .data section. FORCE_NR_CPUS is about .text and
> code generation.

No, it's more than just code size that you compare.

It's also the "walk over big arrays".

It doesn't matter if the *code* is simpler, if it's a fixed walk over
64 long-words because the code uses a fixed 4096-bit bitmap.

Yes, that constant 64 is simpler than loading a variable, but it's not
*better*. It's worse. It has allocated more memory, and then it wastes
time walking over it.

So just looking at code size and "simplicity" is bogus.

Yes, a constant loop is smaller and simpler, but unless the constant
is also *small*, it sure isn't better.

              Linus
