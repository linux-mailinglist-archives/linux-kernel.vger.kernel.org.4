Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14E5FA6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJJVTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJJVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:19:06 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24047962C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:19:04 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-132af5e5543so13803723fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou8u6bVkjCRr3Xr1Lah+AUzkZJ2HrW7g8shUlmEGxHg=;
        b=OHd1/mjbRNL2zPNT4wvWpaX1l4jN2d4aYCgtVyosA36z1fCe5QL1C6pU9E7ApCX9Yl
         /E53mkDFJJxxzt8I7VIAXeb3kGR3xXVL+eIpdtJVC0CS1IwrsGoWnsA0JHOHIcnvUqPE
         g07fvm5Z6h0smvRzYznDoXX2lvRDPbOcUDUGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou8u6bVkjCRr3Xr1Lah+AUzkZJ2HrW7g8shUlmEGxHg=;
        b=CIa3Cd9BI6SMG6UmjKp/7gNzCmNuP65KAOi7aVOE86IjGAv7qynDWAu23MCgj0R/2r
         VBxgahOapGpnyg7jHBoUbRZo4zgmsyqHfnb9azMu8q3Repu1jQRg8hR4gRtsoElVzvO/
         qbKXIVnnhp4nF/7P43DvsoRCCktb2fXko4UuSVW224xlu3/nWhiTP7m92uDd2kkcv188
         Tb7I0l85w1mVtg7jlO1L8e7OArG+bKcFxBotCWFTmGt92Yek0cKhGIhQxguc/IEngE2M
         Z8RDQjyCJVytgltTpBHxcibBnAVN2djUOWVIEyB+zjTrvKFGflA+YmfiZqHL4UCc1Fi2
         pD/A==
X-Gm-Message-State: ACrzQf37VrfvWQJPX66sbWt8BPVMNW+tnMAEJGHyX1WzbgsphxdR7/r2
        vnNejv/EdWSTby6KCd7tKQtojOkA6EmlAg==
X-Google-Smtp-Source: AMsMyM6nWj42q6fUt52Y7zwDsPE4a7RM9cnowNB4hsovf4KKkzSBw3KbP7l4smNHm4USEEEtlFVn9w==
X-Received: by 2002:a05:6870:e750:b0:132:9b8a:7b1e with SMTP id t16-20020a056870e75000b001329b8a7b1emr10817869oak.67.1665436743774;
        Mon, 10 Oct 2022 14:19:03 -0700 (PDT)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com. [209.85.160.41])
        by smtp.gmail.com with ESMTPSA id j17-20020a9d7d91000000b006619533d1ddsm2184808otn.76.2022.10.10.14.19.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 14:19:03 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-132af5e5543so13803660fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:19:02 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr10643747oad.126.1665436742662; Mon, 10
 Oct 2022 14:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <YzpC+uJlYq1nbcIw@yury-laptop> <CAHk-=wgO5YjyPRz9dfP8AyZ8kKZPSQ78xyEbi8WmuHe09R36Hg@mail.gmail.com>
In-Reply-To: <CAHk-=wgO5YjyPRz9dfP8AyZ8kKZPSQ78xyEbi8WmuHe09R36Hg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 14:18:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf2zgBzGMse-y-yD_oTfofRHQQV-gy3O-iQBE7oOiSGA@mail.gmail.com>
Message-ID: <CAHk-=whf2zgBzGMse-y-yD_oTfofRHQQV-gy3O-iQBE7oOiSGA@mail.gmail.com>
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

On Mon, Oct 10, 2022 at 2:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Oct 2, 2022 at 7:03 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> >       lib/cpumask: add FORCE_NR_CPUS config option
>
> Side note: I think we should make this option depend on EXPERT.

Oh, and if a constant 'nr_cpu_ids' is such an important thing from a
code generation standpoint, maybe we'd be better off saying 'for small
NR_CPUS, just make nr_cpu_ids be that small constant".

Rather than confusing people with a question that is a bit strange.
Afaik, all our kernel code has to work with "nr_cpu_id's doesn't match
the number of CPU's we actually have", because of cpu hotplug (and
suspend/resume) issues anyway.

So I _think_ all the nr_cpu_id's games are mainly because we don't
want to allocate huge arrays when  you can't actually have that many
CPU's - but for a small NR_CPUS situation that just isn't an issue
anyway.

Yes? No?

              Linus
