Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1E5F0962
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiI3K6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiI3K6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:58:02 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36630CAF94
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:36:05 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k6so4310390vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iA7UOa7PaACfIetnSW6mT06TPQlH0GZKGgDd0gAwTYw=;
        b=gAvHz4ay9fFRCK4ime9EqNsEIlYAgX3J+Iubj8I4oRj26PV3x/cTww1dwEhwcC+mkd
         q5z1BDFwvxpTEjqg3qx7pHfaIaKnqLps8W0/RK1razdiWdKtA+PKwiQxofKqcGqAm20B
         sIyw7o3d3p5G5MWxqQVDM8AKxNXLDZusEz5H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iA7UOa7PaACfIetnSW6mT06TPQlH0GZKGgDd0gAwTYw=;
        b=UiCr3SLEBGKYnajat5yD/R3t7+vGhDJP7PKZU9ath9jQRneQJTxWxHP8jKcHqD2AFm
         xKXoGHIJCmpXeDjU0MjBM7Ghyz38Xp6g3DOLmFc3chI9QTLTUnkIq4xRjWXkKy5QjTee
         83S1PjfvDcF+9ZphVZ0y4MIVXPWaQuTi+IAgANMD1z49lkAZM6KS9J/ONrVAV8faxrNe
         UmLSDspvRgk/T3y2XDnnm44h84rH8wUeYVNJItH+CD7hcrS3p2/tnGuL1pZzSI+kTB/j
         0N7ZR/3ampXnzRGDIbKOfE+3LXj+N3ll3XQXXnwMeGT5+gtXv/m8M8E9AGIB3o+bA/ZQ
         gIJA==
X-Gm-Message-State: ACrzQf2idh4zk2Wba9wSeYAfC0FRYgB4UOAhNXmJ1fmRsNMDzgEYi5zj
        tayJEgOGJKpW+OKeHalxZ/zicKa4hDpEZw==
X-Google-Smtp-Source: AMsMyM6ZMBNxX+fUom/k0/ZssEgPUVXNovQItiEo0lIlgpk0H0aKzWVvNOnLWhlUbvGRiDhN6aUckg==
X-Received: by 2002:a17:902:7d97:b0:178:6505:10f6 with SMTP id a23-20020a1709027d9700b00178650510f6mr8004603plm.155.1664533655621;
        Fri, 30 Sep 2022 03:27:35 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:948b:dc8:349f:7e70])
        by smtp.gmail.com with ESMTPSA id 67-20020a621446000000b0054aa69bc192sm1417230pfu.72.2022.09.30.03.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:27:35 -0700 (PDT)
Date:   Fri, 30 Sep 2022 19:27:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/2] lib/vsprintf: Remove static_branch_likely() from
 __ptr_to_hashval().
Message-ID: <YzbEkTzcQ0fV+Fsd@google.com>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927104912.622645-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/27 12:49), Sebastian Andrzej Siewior wrote:
> Using static_branch_likely() to signal that ptr_key has been filled is a
> bit much given that it is not a fast path.
> 
> Replace static_branch_likely() with bool for condition and a memory
> barrier for ptr_key.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
