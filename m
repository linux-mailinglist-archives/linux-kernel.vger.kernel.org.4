Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E55EE279
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiI1RBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiI1RBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:01:15 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FAD85A9F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:01:12 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 28SH0c4G031805
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:00:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 28SH0c4G031805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664384438;
        bh=tCJmf3EpTV35WjXn2+DIeB+r4N+wrQ9T/PusSzDEUs4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pVBsNOBG9xP/uzzgUQkANr8c5ghSqzZOdJFoj7xWNCNd8ayz35CZVFkU8lJMfWpvD
         kJFFo19Oy4XZNrvZPX2b6wGowYwi5EKmJoItioE3pActndVo7ObHmzw6DfA7A6CuJ7
         BW8tqHC33NWZpnaRcJMY6Mod+tXCsM2y0N0U1Qdd7CyzCRBUTfD8LefBSDnzjf6xkw
         zvh//IWSHLkQu3eVHSA0GBlWCv4wvgUAUb5drNMLjQa3RenSTrS5fLHRfzcS358MKV
         jhfpw7pyR8kECUSWMsD5oIfP1RlgNBvAHsSGqU2gKLEMeDBq/Mb9IbPbq+oLwA6D5G
         0ODVHD3zb2bFw==
X-Nifty-SrcIP: [209.85.160.54]
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-131a17bf7fdso3404514fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:00:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf0A8yEc9v+WpicW+/YjOHHupRZfHHItlQ9K0FB7FaneYcMaW9rx
        U/0+kF2bfMkLyRkD2RC0EEch4GyCuGb2+R1T4+A=
X-Google-Smtp-Source: AMsMyM51XB4LYPrBu1PFCEEk/qwLk11r17By6C0PuZ28DoIA4ArbJbiHA1BZBoWXlLYAPF+ROuzHc1CEOOpDRNgW7uI=
X-Received: by 2002:a05:6870:6326:b0:131:9200:c99d with SMTP id
 s38-20020a056870632600b001319200c99dmr4361288oao.194.1664384437349; Wed, 28
 Sep 2022 10:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220429053329.2278740-1-aik@ozlabs.ru> <YoLjpivvU7dRVTuL@dev-arch.thelio-3990X>
 <7d30583e-7e58-5184-be2d-773882dd9092@ozlabs.ru> <ba973bf8-fee6-ba17-244e-32c00d6a06e4@ozlabs.ru>
 <CAK7LNARNMhTn-+GcOHZrVj=viQxTMUS_7syat4icaPXUGtYkVw@mail.gmail.com>
In-Reply-To: <CAK7LNARNMhTn-+GcOHZrVj=viQxTMUS_7syat4icaPXUGtYkVw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Sep 2022 02:00:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARgfw7K+hKrsKVb9AEQHEQP308kp5dpiyFqzLg5URrcyQ@mail.gmail.com>
Message-ID: <CAK7LNARgfw7K+hKrsKVb9AEQHEQP308kp5dpiyFqzLg5URrcyQ@mail.gmail.com>
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 9:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Jun 22, 2022 at 3:56 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >
> > Ping? It's about 2 months now :)
> >
> >
> > On 6/6/22 15:12, Alexey Kardashevskiy wrote:
> > > Ping?
> > >
> > >
>
>
>
>
> Applied to linux-kbuild.
> Thanks.


I dropped the patch from my tree because
I confirmed that the mainline + this patch
breaks the build.

Please check the 0day report:

https://lore.kernel.org/lkml/202209221359.0J5ktdOy-lkp@intel.com/




-- 
Best Regards
Masahiro Yamada
