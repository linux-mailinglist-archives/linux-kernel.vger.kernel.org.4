Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B536944E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBMLw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBMLwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:52:55 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34875768A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:52:52 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v6so98919ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1TmLUW6hPremyHfH02mI1sZyfyvVZyCwA3fX+FOaBXI=;
        b=VMQNm0eiqoREYEAK7DXg+w4SBxCO4umzKJRt8APol006bSZpUXBrdJG6xAPuKFu7wF
         u5H/oktmJFRlzgGX+vF03cJq02hjSTH21rDe298h0DT33agIvlLq3EVK6vWIMnJxbPxB
         y2S6Chpx1brT7vYnKMYJhJXtUu0UH5SQuDwal5LGlv4Lz7AfbNfiBZEJcWwnoEdM0dyP
         QeiRznx8uqyecdyQc4Gn9/M3ZEsIjIvhOfL0fKDOg/pmJcwWNmY5YQ58axxmsv/YlMXn
         IlRuasdu18hKaMiZT4nvEAgGg4eH98U7Vhp56soBNjOoBT6EDn3Q4AzB95JXCCEuEFry
         S5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TmLUW6hPremyHfH02mI1sZyfyvVZyCwA3fX+FOaBXI=;
        b=QxEhUW7qKYwYI5Ihmn7sS/qbKqF6On+5ouwD+NkqwR01e0CFtZOOaxbNfK/DzYuEIY
         PilA3xyY8y1XYzXGWrK/ASMFm7qFL3Ri1lYgQa0XABzrwXQw38IRCco8BGiL4GT8tIBn
         MLu/nNl/hXQ5qXQgc5+LykOYkVdUMA9aBmJsVWTfkGjbwzzOzbI+e+095lEh2/Xj7nYc
         vhB/PrDKCaUttW93b6EU8KI+2+udlWrvJBvLvi9Lf7H0qMUqC29dtJNfjSEc1/h+e0+U
         0uf3A2sb1PdhDPoh3S+1Y4WzE5h4YHP7z1JQWXCJQFiqW+3vpTC3VNgz64m16DnxNMbJ
         QYmg==
X-Gm-Message-State: AO0yUKVIVM2s5rF6owbvQkKn9EQ0TkvwfeDG7xy+pkErFtrbEw3/uPZQ
        Qlq08IcYTNGsp5Nl2MtTvqs0QVl7pzeFgkdXAe1E3Q==
X-Google-Smtp-Source: AK7set+Jv4HZl0nSf1uZg7MOawEojcn8ISEv4W9PIqKYmccB/VLVVt+9l+W+zQuslLejUuemhSR18qAuVCNghXpzs0I=
X-Received: by 2002:a92:8e43:0:b0:30f:5797:2c71 with SMTP id
 k3-20020a928e43000000b0030f57972c71mr13118156ilh.51.1676289171334; Mon, 13
 Feb 2023 03:52:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <359ac9c13cd0869c56740fb2029f505e41593830.1676063693.git.andreyknvl@google.com>
In-Reply-To: <359ac9c13cd0869c56740fb2029f505e41593830.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 12:52:12 +0100
Message-ID: <CAG_fn=WTXE67+zPc7frp7sPvJ82G+GCJe-0+Uz+nN4PUP7+uag@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] lib/stackdepot: annotate racy pool_index accesses
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
> Accesses to pool_index are protected by pool_lock everywhere except
> in a sanity check in stack_depot_fetch. The read access there can race
> with the write access in depot_alloc_stack.
>
> Use WRITE/READ_ONCE() to annotate the racy accesses.
>
> As the sanity check is only used to print a warning in case of a
> violation of the stack depot interface usage, it does not make a lot
> of sense to use proper synchronization.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
