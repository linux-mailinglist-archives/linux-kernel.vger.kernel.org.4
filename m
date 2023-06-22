Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332B47396A1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFVFG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFVFGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:06:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5916E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:06:22 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-570877f7838so58723047b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687410382; x=1690002382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MthCju+rZIz8gsMWBktpqG65ZcoIquNN1JdN3p215eU=;
        b=MAQtGOkk9kv3FBWEGGwDM+cn/NBnQN5GtguG9BsU406oxl0g2RznHS5jTaljD/MQ5D
         uoCxw55206+2UxWQ25tgkyHKqpylI8l/m+P8KKNmyBmi0Lg8x/lhar4WrcwMFmBJQxZU
         yoeLUdlZoJiVaps/ZX6kXgrDHffOelo7GxnHaMBmhHuNMR/NImgUCcFRdubxdmQWGAXd
         kS67jYfCRV6R5ZxE2WnMc+35QfNtg7dyTllhc+FzwoBtuYwk/OoScvjgrVMpkT2yHhx3
         B4+V9mjxrwOFUK8QRz/Ygw8iRPY9Cu5SDpCzobzfs0k4RJNTl2lm66JYxJxZ/7DnoT2j
         fVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410382; x=1690002382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MthCju+rZIz8gsMWBktpqG65ZcoIquNN1JdN3p215eU=;
        b=YfND0uHhHaDFMiJ9uyc/Cgt9HMOR6PA516/yYMy49anrshA8My2TqYgepXBz8+7Zr1
         OyIFG8NK8UDpPekf/K3jWT7ZTznP5J56oOGEzyQhWtuELVHZFqR1C4NhDWI4rN1kvu/V
         6rcXllKi8UYKyTfpFDiL7oXoRLKapMTiIkTvY6Wd5R/H79sGSh3b/jIs9CqsCAmSfjbG
         vWV/YF+bEubOMQiinRvtzvZlQlVUbz2Qo5gpxFQ2weAkoRHj8HWbKFSE8dxaO/0HvkgK
         7x26c72n6cykxVMEBWN4CCabtvpYTqfj1j0hR+6OKQei6RD1OUu7gtkP0T58xy+6PgJC
         Srig==
X-Gm-Message-State: AC+VfDyEBp33+iVqYajn4Bs1acU2OHzdnVajtVQKJe8W+4hv60QuqhwV
        Rs0a2ND0IuWUlbuj19n0elmUnMcYPaj6fdbC7ls=
X-Google-Smtp-Source: ACHHUZ4PrGtZEFFrewBaR05yFcgsXGgNCDzkJCtEBW8P4mRUZ3wPZzIjyHdtDb4Dc4s8KAXE/aYDdtx5SpuH9HwFmeU=
X-Received: by 2002:a25:b10c:0:b0:bc7:60cb:5cb4 with SMTP id
 g12-20020a25b10c000000b00bc760cb5cb4mr12950168ybj.12.1687410381729; Wed, 21
 Jun 2023 22:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230615142016.419570-1-zhiguangni01@gmail.com> <22bba771-f10b-8624-1874-5eb747e798dd@intel.com>
In-Reply-To: <22bba771-f10b-8624-1874-5eb747e798dd@intel.com>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Thu, 22 Jun 2023 13:06:10 +0800
Message-ID: <CACZJ9cU81BObhY3RGb9mdhfWxqhNW=JhjSOyUXpizZ-S8hjdEQ@mail.gmail.com>
Subject: Re: [PATCH] x86,NUMA:Get the number of ram pages directly in numa_meminfo_cover_memory()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        akpm@linux-foundation.org, rppt@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 01:49, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/15/23 07:20, Liam Ni wrote:
> > In a previous implementation,The ram page is calculated
> > by counting the number of holes,
> > however,the number of ram pages is calculated during hole calculation.
> > Therefore,we can directly calculate the amount of ram pages.
>
> What problem does this patch solve?

I has send patch V2 to improve the execution efficiency of
numa_meminfo_cover_memory()
by optimize the way of calculating missing pages.

patch V2:
https://lore.kernel.org/all/20230619075315.49114-1-zhiguangni01@gmail.com/

In the previous implementation, We calculate missing pages as follows:
1. calculate numaram by traverse all the numa_meminfo's and for each of
them traverse all the regions in memblock.memory to prepare for
counting missing pages.

2. Traverse all the regions in memblock.memory again to get e820ram.

3. the missing page is (e820ram - numaram )

But,it's enough to count memory in memblock.memory that doesn't have
the node assigned.
we only need to traverse memblock.memory **once**.
