Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0A5F592E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiJERlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJERlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:41:08 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892253A483
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:41:06 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-131dda37dddso19717794fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ET0IoJ6rEVtbRVeWGB0pVw9IcwTsGPczYsuOM1U4f0=;
        b=EJ6WcTBoO6oU/ezXuBkBYjEbQ7S8KRcou3xsWIrbiRwE9EOHqoC6FTsAgwu07Mfe6Z
         0beVDIN9DJs7HZ9oYRIYFeffRZ+wggTvShNIAeZ04kK/I7kiVn2nPmIYDHSxv9mrcTmq
         8i+3y+6uRFx9mVL0EBCbpPWxMRHMnS1wVblHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ET0IoJ6rEVtbRVeWGB0pVw9IcwTsGPczYsuOM1U4f0=;
        b=NrQAHWO8x0U9o56GNzKa2fhAKTUhEJqstgNuK3a4pkwJdBHy9F9lbj5byG8nX0W566
         4nIeU5HYGtvdfnNA+cXc1dj67gQOYUgAtGUYOPEhFQRrwHo921xr1oBIDoCi2F0Siyec
         wdbE4BOu2mvFTpmlsghYFIVVLbEm3Ih+DqcSIa+HQ+mQ2erfC91EJtZ3E+nU1kIYS9+7
         W8BUrUXYr7/Xp1b/dmRsbK4yJjLJs/KYDnkKIPlTAWZf6HbeUmGCZQkjJh5bR1d6KM5v
         qJ8/3XW3zqQtmgohLpf1hsn2JCXClCghkV8qJBvzjgZM3x7lk98VzZ7V/S+WvnhRtHFW
         ZA7A==
X-Gm-Message-State: ACrzQf1PQIJ33p7v+qnPfwZBDp8xT+3lLiyYyyKatnaQD4TgE9GA+Xy0
        6Bzc+xrBbKHiaI3pPGou5uXHkK+G2E0lXw==
X-Google-Smtp-Source: AMsMyM5NnD+XY6mpzRlaNJfDrO5aUNP9TeEv5YFq/zLWWBGq32+tq14xzplRVwew71nuJF/UBEOD2w==
X-Received: by 2002:a05:6870:618e:b0:130:9e9d:650d with SMTP id a14-20020a056870618e00b001309e9d650dmr396897oah.109.1664991664856;
        Wed, 05 Oct 2022 10:41:04 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id 7-20020a4a1507000000b004767df8f231sm3641525oon.39.2022.10.05.10.41.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 10:41:03 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q10so18397857oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:41:03 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr465391oif.126.1664991663308; Wed, 05
 Oct 2022 10:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
In-Reply-To: <b23c765b-4999-17a4-d89a-55d6ba72f68d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Oct 2022 10:40:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDpj0wAwFK8tDjVUkRoT06ZD-d+OQpojodPPqE_eEcHg@mail.gmail.com>
Message-ID: <CAHk-=whDpj0wAwFK8tDjVUkRoT06ZD-d+OQpojodPPqE_eEcHg@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.1-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
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

On Wed, Oct 5, 2022 at 5:46 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> There also is a small conflict in drivers/platform/mellanox/mlxreg-lc.c
> due to a locking fix which landed mid 6.0 mixing unlock + return with
> goto style exits in error paths. My tree has a fix on top to consistently
> use the goto style. Here you can just take the version from me tree.

Ugh.

Why use goto when a simple 'break' would work for all but the first case?

I took your side rather than clean things up and not being able to
test the end result, but it does seem pointlessly complicated.

              Linus
