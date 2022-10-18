Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4260A603162
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJRRND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJRRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:13:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6C9EE0B8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:12:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l6so13861576pgu.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAUG1pQ9zmruVe1EzRA9y5o1htxEAHaV3vjlx1PvioU=;
        b=nzKKwHewBZhQkpGqWY2fZ8Vt1vPyfMkkPk7rDiaTwuOOjEAVocgdOrZpuLpDpd3cSK
         EekAyNKusgAHiYURIJrYqayqPptP5UTEzTdjbxVZfu0MbujBKvHnNczNpQeK6XoJ8mL/
         ituEFLOXwJ0FCA/pMMzFCOfG4dcy5bUbRfg7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAUG1pQ9zmruVe1EzRA9y5o1htxEAHaV3vjlx1PvioU=;
        b=G9LxpVfOklgVOdylqZkmZAawCrwInBkpQtv3URET1mzy1Bjm05NIQyKoa2ENMBj+5s
         IwZcsLxfsWv8GQY71uuLOGMI4QU60YCuIMwlI3b/Rpue8KSugn5xnCRDtz8SY07vj4ev
         Hy7+5ZrP6ybZ9Ou+POafAdOeSx0ktlCYzKWYnsMG7ZXdV9aHysXc1jUANnizA4ko3Lom
         KLQ215Zf48a/KCT3aRn94B/DEb924XXbVx8O6tlYxYb77wMh5yeu3PDhoyVEbB1iJI3p
         1dDav4xMe0gkaQUBboRL/o9GiftqQV5Wd2I+6iaxxIDmgIPr6y1sk4y3Xjnz2Ahor3uo
         R+Og==
X-Gm-Message-State: ACrzQf2pSDrkWcg2R0zNVMs5/wmaGCudGwpfuny3p9tjf9NmRJudcUPy
        3sHibFL4E05bHXtn1RsxuImJs6au4FMpzw==
X-Google-Smtp-Source: AMsMyM5o5aEiKzImAs02HXBjk9nHa12jVLYhs6td4NQwwFXXfIjV1nZLD++2ZrmHM9N+w+Fbe5pn0g==
X-Received: by 2002:a63:2ac9:0:b0:457:24a2:6fa7 with SMTP id q192-20020a632ac9000000b0045724a26fa7mr3424011pgq.484.1666113179208;
        Tue, 18 Oct 2022 10:12:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0017f80305239sm9054018plh.136.2022.10.18.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:12:58 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:12:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] siphash: Convert selftest to KUnit
Message-ID: <202210181011.EA0B964@keescook>
References: <20221018100510.never.479-kees@kernel.org>
 <Y07bqnZVrA9FO03z@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07bqnZVrA9FO03z@zx2c4.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:00:26AM -0600, Jason A. Donenfeld wrote:
> On Tue, Oct 18, 2022 at 03:05:46AM -0700, Kees Cook wrote:
> > Convert the siphash self-test to KUnit so it will be included in "all
> > KUnit tests" coverage, and can be run individually still:
> > 
> > $ ./tools/testing/kunit/kunit.py run siphash
> > ...
> > [02:58:45] Starting KUnit Kernel (1/1)...
> > [02:58:45] ============================================================
> > [02:58:45] =================== siphash (1 subtest) ====================
> > [02:58:45] [PASSED] siphash_test
> > [02:58:45] ===================== [PASSED] siphash =====================
> > [02:58:45] ============================================================
> > [02:58:45] Testing complete. Ran 1 tests: passed: 1
> > [02:58:45] Elapsed time: 21.421s total, 4.306s configuring, 16.947s building, 0.148s running
> > 
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > Cc: David Gow <davidgow@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I'll queue this up. Thanks for the conversion. Appears to work well.

Cool! Thanks for looking it over. If we want to avoid some tree
collisions, I could carry it in my tree? I've got some other conversions
in progress. Though maybe this begs the question of "how should kunit
tests be ordered in the Kconfig and Makefile?" so that collisions are
obvious about how to order...

-- 
Kees Cook
