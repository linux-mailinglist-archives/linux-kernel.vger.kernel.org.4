Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48595F670E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJFNBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJFNBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:01:04 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29789AE2;
        Thu,  6 Oct 2022 06:01:03 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13207a86076so2085416fac.3;
        Thu, 06 Oct 2022 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOxzxB6Ta+ahPUPvLHNT/LSeggT991ufeQf/qCTG8Fo=;
        b=J0ntHF1dSQQ0tlazjlpP2Q3oLKRNeFydIFk705ZhfWD0PjX4AHrPuhKgSLVw3QBCNc
         /jjV3C9dTfZUjA86pji0cJDcv3L65F9/P0/mbvkPQcWrsjy59iG198llUg2b1rC47bKm
         RI52/V+TTW/ECY1Qd33ZoEv9SXBiqd/U91j7qwrZrBdvNrm8mG2kEcf+vdHbwPdfIsEj
         Kh5roIS2XhcYo23wHgLemMsvBAVWPKm5R8K3gJ0eFHUcrptyXWGD8EnumW35odH0mnGG
         Mm5H8BJPy+AJESqaJs+qX8QrOCKkAapbti86UhhciCwdFryygyEftMA4Zodp3Iu7i/NH
         jc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOxzxB6Ta+ahPUPvLHNT/LSeggT991ufeQf/qCTG8Fo=;
        b=WOIYjYfY+o2VBNppnffETxvHgmKyxeqAoQz3DabejSEv7+rVPLrK0A7Pqvk5H8WSsa
         epTrA3tEjzTNXejMZM4pV3Nddtem7pOp1T7Wm4Sl0+eRAgIhl7ohT0JX+nXvg/bAcde0
         YgFG9L8NBr8HGF4xcx8i2KN7BGi4QZFfktcYhHZatwfo+LBq0y8pgqspdjZG964a0xsZ
         ShdIGGdyJbyMEARO05hbVX9TAY3+NqDg58/kT8thj8dQU5YSU/uyDluy2jIK/WHJMzfe
         1bApVn0LCQSU41igJZRNyg/EStlnEcIN2pYs1Bllbe3AnN5FPmUxTaVVsFCywUn1FN9R
         QROQ==
X-Gm-Message-State: ACrzQf3cAU2ROmjh1n81oxR3Dm782iYR6QDOW7Sz/LngkVm86t+e3Bxt
        yoeF2V3Go9XQYe1Q+ePqOAjIJIH27kE=
X-Google-Smtp-Source: AMsMyM5X0YKCU+QQiYrM8MOLk5TvEmefyBe31tSMObUbU+zn/ns8r3CsDen7PU5j1DvARavs8JrerQ==
X-Received: by 2002:a05:6870:160c:b0:12b:9663:67ca with SMTP id b12-20020a056870160c00b0012b966367camr5359068oae.36.1665061261549;
        Thu, 06 Oct 2022 06:01:01 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id z4-20020a544584000000b0035418324b78sm516940oib.11.2022.10.06.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:01:01 -0700 (PDT)
Date:   Thu, 6 Oct 2022 05:58:49 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH bitmap-for-next 0/5] bitmap,cpumask: Add
 for_each_cpu_andnot()
Message-ID: <Yz7RCVTUeZAa4zM7@yury-laptop>
References: <20221003153420.285896-1-vschneid@redhat.com>
 <YzsvVx+i1JM8V72D@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzsvVx+i1JM8V72D@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:54:20AM -0700, Yury Norov wrote:
> On Mon, Oct 03, 2022 at 04:34:15PM +0100, Valentin Schneider wrote:
> > As suggested by Yury, this is the bitmap/cpumask specific bits of [1]. This now
> > also contains an extra fix for blk_mq.
> 
> Patches ##2-5 look good to me, but I'd like to give them some testing.
> Let's also wait for other comments, and if nothing wrong will be spotted,
> I'll take it.

OK, taking those in bitmap-for-next.
