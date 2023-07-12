Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7F75031C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjGLJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGLJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:30:51 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB510C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:30:49 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-783546553ddso213440839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689154248; x=1691746248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AtYtKFoXSNaR0HimX7VOb+3+TUw1E5irFW1i/Ff7fdo=;
        b=JiHaHowj0OR8KwgXRnSt+L69TkR1RoU8hgZP5ne/AABbP9RXRzfG9ZSAx0MAeVhVqZ
         RuJx/lQyMwgysM2NJJZoGKqSiN+WMv6gWAnXqOgWSf39ZVAdpNGkMwf0z6pgOK53tZuA
         nZHHD6009dX+C5GhWf1qYTFnrjMxXZkyN4CdO8MGWcgcWBxbLFUneXMMFHq6kXNET2dH
         oGHEe5b9x5GgGfutXNttjbwXHcMkXsMperI26dRitbb5OFBOJ6YL0HyVS4MyAEzpmCk1
         t/vxsrrakkSOfL3iplAd/KFb7WowFeadG8xtEht7siYoPYqUghzRkUEoi4NBlW5Y0EGe
         SN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689154248; x=1691746248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtYtKFoXSNaR0HimX7VOb+3+TUw1E5irFW1i/Ff7fdo=;
        b=F/FRtg3dgS5x8RE6F8p+S6rh/qpCGxPuOjwWvABgGcv4nHwR7abG0DZKnUcIsezaQC
         lik4THG/q+FjZGafbC1bT1sQvevve9knRWWBgHfIVw0ElkENTxnCqiguB8bunPQTFSUq
         q1LKaOXJIthn2KQIxP6T0Xcs5uCvo2zsSORViNUo8JApZ3eRkCwfaYJQpH1m8mQIpwH2
         9v8NN4hphlGsIExp0y1I7EA+wcyWlmzFj8LI5fwSWTYewSBCvudxVIQNGmbU+ulJBfC5
         6VCAyy3phMYYwQdBsO5mDOYgiUML6wS3RJNIOP0VcsNyYgTvaT+AsQo+Th9Dip5rB6rr
         HVCw==
X-Gm-Message-State: ABy/qLY37nFgCXgactRypExoTwdR62e9oJBZHxscapKM8JSlIq57eYk8
        QfRrNuypcGciRoKOLRPtK3mGr5dnzFDHVqJov1iWQg==
X-Google-Smtp-Source: APBJJlHlumhEigpYsGGvupqXZVMHwmq5rfVisQzfEtUqsBWOohrJU8W/yjpSj7l2e4UcAkLLYOQHsAPeiX/obZxeJqU=
X-Received: by 2002:a5e:dd0c:0:b0:786:ea57:22e2 with SMTP id
 t12-20020a5edd0c000000b00786ea5722e2mr14334765iop.20.1689154248240; Wed, 12
 Jul 2023 02:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 12 Jul 2023 11:30:11 +0200
Message-ID: <CAG_fn=Vj+rqkz0_3kvBoBVoxET10KV-zoD=YtJmCfsA8YEMemg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: allocate kfence_metadata at runtime
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Below is the numbers obtained in qemu (with default 256 objects).
> before: Memory: 8134692K/8388080K available (3668K bss)
> after: Memory: 8136740K/8388080K available (1620K bss)
> More than expected, it saves 2MB memory. It can be seen that the size
> of the .bss section has changed, possibly because it affects the linker.

The size of .bss should only change by ~288K. Perhaps it has crossed
the alignment boundary for .bss, but this effect cannot be guaranteed
and does not depend exclusively on this patch.
I suggest that you omit these lines from the patch description, as
they may confuse the readers.
