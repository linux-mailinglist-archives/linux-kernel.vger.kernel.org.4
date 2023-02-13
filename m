Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC56943C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBMLDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjBMLD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:03:27 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1388417173
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:03:21 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id s9so3865687ilt.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9smNmbml/2Z1XuxlO46/mzGZGe1qNudBrmiurlMq0I=;
        b=btEreWe/s17IA47Y8l9uW9sCT7m+lDsF1ol4e899b3Gs/XmjWsRrpj1tHkk/vivWlN
         vuSZmX7aMGCzFxkHDw1KCkt+FKf80BoxswjlZwoZIMXckjUnouGAi8+u8IhDA2J9GJVV
         /Y9RpvTD5d6BfYaSi+4/DdT/AzTU0rayIbb9aak26nDmjGobQ3afL/sYQiZqzD0R4ric
         Pq06hGn07LzOXq/714UbcjRa/xw514q8W5VDVhYy3L6RY3mxqF6nuQsDg8qsOETGXBsO
         OZKUjUayS1tBAY0D7TUl7A27J/qqLBSafqFhyaoqd2W/OWSjP+GekviVwYAz7uzuEgw2
         hk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9smNmbml/2Z1XuxlO46/mzGZGe1qNudBrmiurlMq0I=;
        b=ac2jtOaB7gxWLFUF/7WHV/wbJzw2uXgJlfZo3Gcw290K1sXAsR2L4Pf1hovfivWdF+
         p6PQuHEqndh6loJYs41NyGg4umrT3BJhADkSqOw8o00C6tLNPMZZZbQXpBBbNohOEg+E
         OWBVdfsXi6mpcx1726Uu+RdXVbolHzR5t/+QMaBFCwLKUXwNSxG4pgJeaUGG9Fw3Ludj
         8vGhyfzKPiRrgtttwoK0VLeO6cE9476WTnfvAb7t1kpp3dVV2sbpLl5TaT8zB0rudGQm
         BJmh2RS8I3smubAgmwA1HyQ+dQ17e5xMur8Li40nvnUCSgfH8VQS2hsAcEppMMTwWn3Y
         URgA==
X-Gm-Message-State: AO0yUKUpUdlx3LSrxXHA/JUbj4g9r10EaSHRJ911xFaIYRmgw/TE4Nug
        ZyVRVeJxS9QQeW0+K0fIfkHj6eR1t93z2XSkx4/SFw==
X-Google-Smtp-Source: AK7set9/1Xvhq2EEM3sZXotFmQ0DcCE7NLMJSFpUA4zHQbnV2TIscVDdL820r2kdAcg+kWozN+nCrQgaPpXe7c7SB50=
X-Received: by 2002:a92:3f0c:0:b0:313:f6fa:bc50 with SMTP id
 m12-20020a923f0c000000b00313f6fabc50mr2367655ila.5.1676286200296; Mon, 13 Feb
 2023 03:03:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <ce149f9bdcbc80a92549b54da67eafb27f846b7b.1676063693.git.andreyknvl@google.com>
In-Reply-To: <ce149f9bdcbc80a92549b54da67eafb27f846b7b.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 12:02:39 +0100
Message-ID: <CAG_fn=WJC8wj64NTGMuHzsiTs1hfXxFT_Z1zC6+Fh5cOEKLYNA@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] lib/stacktrace: drop impossible WARN_ON for depot_init_pool
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Fri, Feb 10, 2023 at 10:18 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> depot_init_pool has two call sites:
>
> 1. In depot_alloc_stack with a potentially NULL prealloc.
> 2. In __stack_depot_save with a non-NULL prealloc.
>
> At the same time depot_init_pool can only return false when prealloc is
> NULL.
>
> As the second call site makes sure that prealloc is not NULL, the WARN_ON
> there can never trigger. Thus, drop the WARN_ON and also move the prealloc
> check from depot_init_pool to its first call site.
>
> Also change the return type of depot_init_pool to void as it now always
> returns true.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
