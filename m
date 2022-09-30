Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E25F0956
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiI3Kwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiI3Kvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:51:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E01E5567
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:33:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lx7so3911162pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9QNM2usOJSJEzq0vyfmhe5gpExUhlXHYcY918/Wu7bs=;
        b=ZE74zU0vO8ubSkcQY7YHo0zfbQtfWYgsgtpfkIepXAGc+ef0aDkDqmLg6tKZVClL/3
         B9Utvd3zDIqlwMvJSPEN+0OuxhMLT2wB6ahFC5ClaDaTCqLV5Ypq6xCbb/uHSWdOfMKk
         QAP0+B6Vu08qM5lGuME/tYzc0zPE1OZY0n6P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9QNM2usOJSJEzq0vyfmhe5gpExUhlXHYcY918/Wu7bs=;
        b=RaHqlvR89VeIGuOTpE3gQ+azDMcOsqiY5S6AYCbFvtPIKuyskRq9QjKxI4Y787LnCM
         ZehNXgGZlxcGeSraEn/F1njo0zxyTCTYhXRCtNc4eongNhzarNrggl3XU//kqBG6rqwa
         E85VqQ/aJE4M6FWRVdnsmFl1QyXd1sdMrFwW8G242LSETPlnhzF29SxlRwHLJuFRDpxh
         PbI9VNK49iK8LIyUkPRLtrs5B4bYlZcegZJGyfxLO3r1702xDcH+TsHhjQGvcUq4hDsQ
         dfdAGzMyuF8/v6r9hFfTr46A/RobmjR3bNwwaete+ROj5Y65CHQOVy+XSpuraQ4A0vuv
         U0JQ==
X-Gm-Message-State: ACrzQf3rcXCkFNg1cJGy1q7Zy59YNMK2LmXsS0oF+QOVfWYDh0/vQYz+
        R4F0GJE9NW14QYYDbcxGtOLj8g==
X-Google-Smtp-Source: AMsMyM4aQbRBlUWBAuBTF2x1i1Cooeb7gMyaXLwAcqqQVeL8A0Yb+MD1hXnSakzuoCzpUuCYbtfUfw==
X-Received: by 2002:a17:90b:1e45:b0:201:6b28:5403 with SMTP id pi5-20020a17090b1e4500b002016b285403mr9045775pjb.164.1664533915527;
        Fri, 30 Sep 2022 03:31:55 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:948b:dc8:349f:7e70])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00172fad607b3sm1571174plg.207.2022.09.30.03.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:31:55 -0700 (PDT)
Date:   Fri, 30 Sep 2022 19:31:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Jason A . Donenfeld " <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YzbFlbY5d6A98YUm@google.com>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-3-bigeasy@linutronix.de>
 <YzMnb8NWlCpqsqSG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMnb8NWlCpqsqSG@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/27 18:40), Petr Mladek wrote:
> With "system_wq":
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
