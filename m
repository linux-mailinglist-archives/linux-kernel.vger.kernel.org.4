Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8264C2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbiLNDQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiLNDQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:16:50 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A8C17880
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:16:49 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id cg5so1544544qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvzT+B+8onz0XwW8tP7LZhFUkgvaUBUIsKTNifavDD0=;
        b=Zpf+UnsSBWVTB+EqduW0e2YPidtcRNJDiUZFTqjdKl9peWQfa19zD9cGRcDCcGtzYv
         w2crcz/k4rACxCPkIFnpfWBWIPjCb5QkxMupBOa0l8NWOiLahZqk2XL0MIrEH0J33AQi
         kS35fgrt7ZGpdQNle240eiv95Mh/374MXgw6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvzT+B+8onz0XwW8tP7LZhFUkgvaUBUIsKTNifavDD0=;
        b=1MZs86KUnPqSDz2fAOQn68+bfSVddV2D8EVXt+uzf4NkHyN/GT+cMx0wDSovToqULw
         B+rjv1uuQ44Ws7tkAKHuY3lOIAtmDUWwtbFnjK0XpyDwc6m6JNbZj3INhnqEyfHmDtJW
         KQfd2jOOCgWzZLZlwT5GrQkSBsfe1sBWKNpNgbzeMUgvsuPnTuzafqBV8xXqFEG28x5z
         dtPa38p/uxAvB0nXSv13qpPun9EVO/zHMhN90CtczMdVwCN/t2uTC9cNLXjwHfIBvxVb
         eChU4ojP9laUaCgt1o8sgGKAmHXeoHFvUXqYptr1rAUWXbdNdh8tBqaOHnn3dCHvuMy3
         L6yw==
X-Gm-Message-State: ANoB5pmO8pBw/q+PEWetqOS3my1jQWCrIqqE7DdJzLQZeO7w3ngpG7fN
        8Ds0hFHkwigvWJmZ3EijJA9YCbPCWAa4HK8G
X-Google-Smtp-Source: AA0mqf7FPeVzZbrJg5pmNc55mvJ624kie/HLjWdT6I1H03AVQftL9AEM7DmDivLhu1K0jUXTML0cBA==
X-Received: by 2002:a05:622a:424b:b0:3a5:79fe:7a87 with SMTP id cq11-20020a05622a424b00b003a579fe7a87mr31099506qtb.31.1670987808303;
        Tue, 13 Dec 2022 19:16:48 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a000400b006fba44843a5sm8784020qki.52.2022.12.13.19.16.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 19:16:47 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id a16so1548864qtw.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:16:47 -0800 (PST)
X-Received: by 2002:a05:622a:5a87:b0:3a5:47de:a214 with SMTP id
 fz7-20020a05622a5a8700b003a547dea214mr71172620qtb.304.1670987806759; Tue, 13
 Dec 2022 19:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20221214020651.1362731-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20221214020651.1362731-1-srinivas.pandruvada@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 19:16:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-bq6-d=aoVRDWpLxU-2c2vjkU3OTv37hcK5q781aK+w@mail.gmail.com>
Message-ID: <CAHk-=wi-bq6-d=aoVRDWpLxU-2c2vjkU3OTv37hcK5q781aK+w@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Don't set HFI status bit to 1
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, linux-pm@vger.kernel.org,
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

On Tue, Dec 13, 2022 at 6:07 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When CPU doesn't support HFI (Hardware Feedback Interface), don't include
> BIT 26 in the mask to prevent clearing. otherwise this results in:
>     unchecked MSR access error: WRMSR to 0x1b1
>       (tried to write 0x0000000004000aa8)
>       at rIP: 0xffffffff8b8559fe (throttle_active_work+0xbe/0x1b0)
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 6fe1e64b6026 ("thermal: intel: Prevent accidental clearing of HFI status")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

You can add my tested-by as well, it seems to fix the issue.

Of course, it could be that I just didn't happen to trigger the
throttling in my test just now, so that testing is pretty limited, but
at least from a very quick check it seems good.

                 Linus
