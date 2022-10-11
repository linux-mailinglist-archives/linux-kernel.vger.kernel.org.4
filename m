Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FC5FBA66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJKScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:31:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF051418
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:31:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bu25so22457090lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=seS24tNTym5nEd2SGt/l3cBI/O3EIg61ULZW2MK7SDI=;
        b=bYdSa0Hyjq48N3WfDUPsn5ZshePzmZBMccv2giokrGwX9fUa95+6srWDV20r5JaeN6
         D7Lf/VFEk+OeHxw8FsLa2/DTUhzQfyzLdhOpg4P6FULzCwoLvMmK85h7PxfcJVtM9nQe
         /RPEsHFtH3DBeQPZUBpodNk9hfXrhxAwimoX2kynjgLpGRb0YWJKfm3Wo1bUrXoF4bYk
         0B/K5SCGuqYtm2c3kzIm7Slyhokkz+dZXJJFWjkuTEfgMtKxs1usminE84unInhi60Ek
         F3ABJhNvqqiLokkFQ1ly5op1zfyT5iLAjp/swXHnPm/5zkX7KIx5zrwneIcQgz0GGPXT
         PcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seS24tNTym5nEd2SGt/l3cBI/O3EIg61ULZW2MK7SDI=;
        b=HAT78BzaLfSQLsucQozVYN99XLHPCTkLm9pnSNl2HIlt5blvyptjsQkixAh8na+nd0
         6dHyS0MENFyPYlgZOmRIEmFRAqqeChjTRyI7TDXrQ4oqIYHky3OaT+AeMnIAUP5JxRB/
         0qpL8NaPNsYlEmgx7OtJUCLeLY3K/Zyut7hGr1BuujdFxV4xbU2nAwJOx212UBwgl1zB
         8iFZDY7Bb5ckuYK79/DB0BtU5myWF5hZpTd2ZYyO55xxe7qUUcH9885tSnnZUIbh+/8F
         r4wRVapi/yWw6yvpt3lKY3Q1uJu/Vs6WMW5uOctQT77g3VqPK/lpl1D4LfE0j9uBXO3t
         XSaQ==
X-Gm-Message-State: ACrzQf23eJCB6AcWP3VgmvZ7p5+rE8AQZn/li1kdX8t9SZsAKQHA+27P
        biNU9lMCsSghjFjtIyJlA7Za5oX7YNZy7lR8jk5F
X-Google-Smtp-Source: AMsMyM5+WwrZvKzKUzqSJiPT+QTLnikyx+PbRUwDOtwShsFdBLak3ATCxZwwIprEI1Grwt+AvEVcGcotPhr4XtHQpB0=
X-Received: by 2002:a05:6512:1509:b0:4a1:7af1:51b1 with SMTP id
 bq9-20020a056512150900b004a17af151b1mr9856044lfb.515.1665513115996; Tue, 11
 Oct 2022 11:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221011030637.322874-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20221011030637.322874-1-ye.xingchen@zte.com.cn>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 11 Oct 2022 11:31:44 -0700
Message-ID: <CANDhNCr=umLmH4EV+KXhXPNK9UK0tD1ka3NhaS2BEdDKpO=MVg@mail.gmail.com>
Subject: Re: [PATCH linux-next] timers: replace in_irq() with in_hardirq()
To:     yexingchen116@gmail.com
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 8:06 PM <yexingchen116@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().

Would it make sense to replace both instances of in_irq() in that file at once?

thanks
-john
