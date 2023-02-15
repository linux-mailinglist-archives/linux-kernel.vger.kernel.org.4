Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E20698555
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBOUOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:14:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F74C2597E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:14:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cq19so22734605edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PGQ2Tjph2raaiJJrHEWHFU5AYzV1uv01WttFdbl8X1E=;
        b=V4bh0Fv36Oc96JTrtwDRSTpRRhi4LZ/kX4qEbvP6JqRfZk1/DM5jUVx5Kyj39yoIhi
         aq33fcQOTI5PPoku2ND7mukiujbjW4a1bQG4ZzuMpv6Onpj3W8XzL9y6VaGZ/XlDqAxd
         MWIEni88bTVGzfFSjBMo33x9Bj5G7hovJOQRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGQ2Tjph2raaiJJrHEWHFU5AYzV1uv01WttFdbl8X1E=;
        b=CG8Sy+VDfxAlw6x2UNZlAmwlUNPUfmN9NvIXKI8YvVQUYkFQYgIfQgNO4oIxlrqzM4
         y022RXLDZ5TNu9zyoPGaeJcbZF60Rc+blIWjER/edIjLFhqZAS5qrWjPiv3qOPclJf3M
         MBohwKhPZFxXlIkjZ6m8RJ2YpjId7ccM1/P99CqojtRR5NviIoFgebJgV7VKJy8Jjlm6
         GBzU0ac7jq2uHPKD3UGi7nwA3ne5sf2ngU5P5SPQ9dEuJXwP4AM+X+EOsKD6uFZ609sM
         YVxQfs8eTOGNwdZtLc1DsoTLGie1vIxW6AWqd2OYwInnGlqFQMf4IC29H/CIZtH0CPA8
         AX7A==
X-Gm-Message-State: AO0yUKUdrFl2B32ysDw8CrPO27yr48Zoasnyz7pjesXkgkkZ4xPZJrtS
        urjq+ylKfg9n5Y+BqS8fD/9sJU83J33Ef+gUL4w=
X-Google-Smtp-Source: AK7set+fALXJrdWPLbAXiuUpq6kpEn2VZSJKIZT/QKkCk026kB1QFl6JiB4PtMPk7vG9AK+tJxfVqA==
X-Received: by 2002:a17:906:5ada:b0:87b:6bbb:11ac with SMTP id x26-20020a1709065ada00b0087b6bbb11acmr3431665ejs.60.1676492085827;
        Wed, 15 Feb 2023 12:14:45 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id gf17-20020a170906e21100b008b12614ee06sm3274508ejb.161.2023.02.15.12.14.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:14:45 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id eq11so25461470edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:14:44 -0800 (PST)
X-Received: by 2002:a50:bb2f:0:b0:4ac:c720:207c with SMTP id
 y44-20020a50bb2f000000b004acc720207cmr1826668ede.5.1676492084676; Wed, 15 Feb
 2023 12:14:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Feb 2023 12:14:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjG+MD3JBJ1qN8tD_di9K+kV0_PSe+DE9MRGd8Vco9CNA@mail.gmail.com>
Message-ID: <CAHk-=wjG+MD3JBJ1qN8tD_di9K+kV0_PSe+DE9MRGd8Vco9CNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Change the return value for page isolation functions
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

This v3 series looks like it's making things more readable, so ack as
far as I'm concerned.

But it looks like it's firmly in the "Andrew's mm tree" category, so
I'll leave it up to him to decide.

                   Linus
