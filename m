Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2FB5FA6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJJVMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJJVMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:12:49 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C592C6DAFC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:12:48 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so8767031oog.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nqvSz48L0AQ7i/lklY25gA7KA/pc5dUDrWtx/8mqzEY=;
        b=UvvNKdI3/AgQN/UyKQSR7DjAEcKiSAAziHJZF2zH2zv/DCjCP1VdYaT2dCgJDchB+a
         CiGVorhEX5sWkZ0r5dAh5t9aZrtwcd9ZlEo3szWMdTZLKSkLnU/zDl8ICyyG7dft32GR
         Cu/H00UHmX1OyJyWGZkC59/ei8pF2Q+r4fcxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqvSz48L0AQ7i/lklY25gA7KA/pc5dUDrWtx/8mqzEY=;
        b=SV5CLxngULLLozxRmlsGoAtohl/6VzPEmD3u8sS+mH+mov7T8OFsoZGNeajRUNF/wu
         abtQCq23eRX81OTElkoqcjtOIPCy5jXytsP0amFTM7KNfPFpgcQp81vh+CowSK56I9Ud
         KX0s3O4FYFu3gCnY3/fQ/Roh6m0lQxpArV8NoPw3mbOpT3hD5ivbZWqiHNSlXLC8tW1Y
         DTtAw0P6ck3ZUPUatrQceFvJ1K9d8vkT/KhqhclmMPSodc4TeZ0CDdAs9qeAr4itGAxJ
         /PqSURAs1OZEAWaAaK6Mkg60ZCjUJVkDFh4vqfbq5PLlmMCKCx6H52t1rGFFnyr76uaY
         cN8A==
X-Gm-Message-State: ACrzQf3mHlE55lCSpNS44a8+XWquM9H7hsn1S6LWigkb0bZrLT+pL7uG
        7t9AbaMaVekYQ4ZOSyOGH/GwfSuy5IQ5Tw==
X-Google-Smtp-Source: AMsMyM6PvompOQHHZfO6mpVC73rby6cMKaMqxzOGSm26l6nEKHJORCZqHHwV9xaueKCB7IejUbIHmQ==
X-Received: by 2002:a9d:19ca:0:b0:655:bcdc:f546 with SMTP id k68-20020a9d19ca000000b00655bcdcf546mr9322044otk.304.1665436367009;
        Mon, 10 Oct 2022 14:12:47 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com. [209.85.160.46])
        by smtp.gmail.com with ESMTPSA id 93-20020a9d04e6000000b00637032a39a3sm5292132otm.6.2022.10.10.14.12.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 14:12:45 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so13755613fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:12:45 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr10632726oad.126.1665436364960; Mon, 10
 Oct 2022 14:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <YzpC+uJlYq1nbcIw@yury-laptop>
In-Reply-To: <YzpC+uJlYq1nbcIw@yury-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 14:12:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO5YjyPRz9dfP8AyZ8kKZPSQ78xyEbi8WmuHe09R36Hg@mail.gmail.com>
Message-ID: <CAHk-=wgO5YjyPRz9dfP8AyZ8kKZPSQ78xyEbi8WmuHe09R36Hg@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap changes for v6.0-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Sun, Oct 2, 2022 at 7:03 PM Yury Norov <yury.norov@gmail.com> wrote:
>
>       lib/cpumask: add FORCE_NR_CPUS config option

Side note: I think we should make this option depend on EXPERT.

It doesn't make much sense in any generic kernel, so it's mostly an
embedded thing. And the question is very confusing.

                 Linus
