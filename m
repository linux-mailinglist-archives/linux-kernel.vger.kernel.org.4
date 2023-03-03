Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD7B6A994A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjCCOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCCOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:18:06 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374AD14EA0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:18:03 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v10so1008226iox.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677853082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=fjGTvIsVKzMr8r9ze4iPbKO1eXg5JUd7tUyTHwLPgO8ZGf0BhzOMEDF7o68bJSDKFH
         Ouf8RR99I23NYUedB4XuP1L9Y6zJBKKQqYjyf8dJldwJQnTpl4K0pwLZ6VoeHXf7YeIn
         f5qTJrEDRhocaOGnxi/76IKiRLvrsNkQcELsLvPf9QFmS0mmPxO5jO3/fffq9lZa8/2u
         W6pB4fO5VNndUa2rl3rpyEXh/zxb5LIp0FxCGJi+H6kI9Gmjowcl/PtP+fObeTcZqOy2
         10ranCKrPxnfU3TkxWKYa9MFAAd5ey7rX6otcPiCNrRmwO00Q1LP/lP78I3crBxPn/pA
         JOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B3hgicuXjM7bBAtA4QLzoXhHV0rOr+vQWIDTCOLWjA=;
        b=hGDRB4cR3Uof+4f7271o20Iv/3JrnlG0aJMoMEjP2SK8/bYiy8X3YWyiQoGxRvM/LU
         DukySd3IJvKGkpW/HAZp9JWbph3ifhBxLj2AwmiKmk4LqGrOzk2epinVyGJJZwi09Zxx
         1OuMZTqRl1oyGSWml4sYS+zCYMTKmNchbvKIeWrXA5pyYsp+xcxbGjwjwG1zypd3tNdI
         jOaM9yZQcTGE9fG2SPumN795zIoPLekVLmWm+u5jke45dlpkk59pk4GhYos4S9Q8JrZV
         96/rjuk9R5E5QkrMSg2dM7gn78firYGU1AHS0U46nUUjzhovTqJno0d7/cnn5vwdwVDI
         j+dA==
X-Gm-Message-State: AO0yUKUgAZL5vpjywmZQolGOfALnumeGp2UtG6CQFJcyjc6x3RiF9Rnd
        YlAxUCbzYsguX85lI3AlkUKp5yU+bQZgu18vlh2/6g==
X-Google-Smtp-Source: AK7set8VpZiB/c+1Vt46hXeETErozY6WVS+3pH4DvTtKrHd2JD+Kfzyk84dXiUhVAxTJY9jfB+wi+Z+KFtjIi5BaPJ4=
X-Received: by 2002:a02:634e:0:b0:3ea:f622:3c7 with SMTP id
 j75-20020a02634e000000b003eaf62203c7mr633456jac.5.1677853082348; Fri, 03 Mar
 2023 06:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20230303141433.3422671-1-glider@google.com> <20230303141433.3422671-4-glider@google.com>
In-Reply-To: <20230303141433.3422671-4-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Mar 2023 15:17:25 +0100
Message-ID: <CAG_fn=XpUkTxQytHtWLCuU+w5nu2De0ri+rW3fupot3VRMu51g@mail.gmail.com>
Subject: Re: [PATCH 4/4] kmsan: add memsetXX tests
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        nathan@kernel.org, ndesaulniers@google.com,
        kasan-dev@googlegroups.com
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

This is the second version of the patch. Sorry for the inconvenience.
