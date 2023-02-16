Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56669699FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBPWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:39:43 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A04245F4F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:39:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id a23so2172970pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1676587182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pi9noMYVGr57MR9lsBdKAfrR3AzH/XjRZ8qVHHkboUA=;
        b=ilRc6bGW2j1NFXeJp6gWho2MZHvncBJzu3o1KNvsLnf408IY0rj98GTY1h6WayouH6
         zAgn2nxBPGOD2xowZi/VXN3bUbI20JqRaTzKfy3y5c4iKIQWhO8IeGyTJE8L6oUnFIFW
         9oAczAmKp1mk2OUmoC5dC+TF5MgmgKvbZNUFgn0o86KlPUcr2CunouQy8UkELwGt8eIb
         S6rYMtbeDDSBbKR45nmx6nU/1u7nUeBwDQlpzNVciIAcYpLadY4lENO8qdNUXE3rH6Vu
         206IgDTGJpznNkkoHas4BePgbrCGqmjfFWSt05RgNQMB02JOPpvg8YmuD/BWABva/Brz
         tp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676587182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pi9noMYVGr57MR9lsBdKAfrR3AzH/XjRZ8qVHHkboUA=;
        b=ve6Upav/j6p/qw+BqPZx6XwnXwIRe6EgNyS5Gwu2facg1jfMtEYFsufeAvqGnlo8Fz
         MRa5u1ay9XlE6TsKtwpibGYPwy0OUxzGjArvCMaEs42wmzK35Ywyntx5M5EAfVHlhsl8
         KESd7fMSouoPQlDdUTqZggxj+TEBfFtH60vvptS6Rcyg+LJvhMBKbOp78tof1GUBTdR1
         8IxYrLsP3rjSLW1AntMTGMyUPnlpt02LRTGHJgraT7rI87hey16ubkeihBFz0J7bvxqx
         mmwDONUV9C9vohzd/5MdRPaFlClY7/T1Bd2zEcemaQfMCj+LaVoXLl9JLnB23NaTA+oz
         TNOw==
X-Gm-Message-State: AO0yUKVHmtsuZACyAU3Mu/Q8Vi4XqSj290U+x1RSafzKDMkhwC/iv/Cs
        au9nOnLF6v9Nn1hWWQDdSZmySMNkF7ULJ2e/X2IjVA==
X-Google-Smtp-Source: AK7set9kKa9eBzDeIKikiiDIWuCL4AJkcboiiV1ZwSCTRe6TdvP3fkDrAkB5UJ/Dp6ALZBtj1NnGPoiFrl7lYrtlORM=
X-Received: by 2002:a62:cd0a:0:b0:5a9:c837:5ad5 with SMTP id
 o10-20020a62cd0a000000b005a9c8375ad5mr207866pfg.14.1676587181637; Thu, 16 Feb
 2023 14:39:41 -0800 (PST)
MIME-Version: 1.0
References: <0ca02b1f-ab00-9fa6-aecc-c2c46d624e49@leemhuis.info> <e0998928-0f4e-f2a9-2e77-3e4bab459688@leemhuis.info>
In-Reply-To: <e0998928-0f4e-f2a9-2e77-3e4bab459688@leemhuis.info>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 16 Feb 2023 17:39:30 -0500
Message-ID: <CAEzrpqc6tweHqKKPZYyVuOXH1Wd+hmrTPfcrpa-5-btU_Z24Fg@mail.gmail.com>
Subject: Re: [Regression] Bug 216961 - Severe IO scheduling starvation issues
 with btrfs
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wyatt Childers <kernel.dbwta@haxing.ninja>, pmacedo@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:43 PM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi btrfs maintainers and developers.
>
> I might be missing something, but it looks like the report was ignored.
> Is there a reason for that?
>

Mostly just being blind.  I've responded to the BZ, I'll investigate
through the BZ.  Thanks,

Josef
