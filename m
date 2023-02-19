Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADD69C250
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 21:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjBSUfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 15:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBSUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 15:35:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E717CF5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 12:35:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id t5so1404446lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 12:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNFoYkLdQGAYbCO6Cz194SggiqspOYW+cT3O5G/GHEw=;
        b=uepmuSJ316HFby/v1zLnAZKSIJ9rWKyYvQpyvOxba3h6EvU+l6GK/Uu7BuXmFnq1hF
         kAnEx6DcmrmtZbgXSDuZ0cWv5hmpEk9hg16ciGeZSQ8mP0Nz68P6v9n3pSyp/YB0KQNn
         TqCF036OZQnAAObkxNNbHJPKFLlpSfYJetH0Cu3QrpHs580ID7dqRBmsFmiBkHC8B/+Z
         G9gckrCjYyXBRKrOg3SfzHT/BqpVlMUledGZhoHl6JpBthWBKH3N+I73eBi0jEoIH9E2
         OVJ/hUBQJn+TfszgH8vdehAR8nYGSHIyWgf96vsRC/g0KkXyOhg1TEa+yi2KM/KdnNIw
         XcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNFoYkLdQGAYbCO6Cz194SggiqspOYW+cT3O5G/GHEw=;
        b=ia+Kc29yvi9S6xgVl/ZuNYjLyqNSm4yWcV2CVpWV/Xarfo5c9js+bfHtWph3SCPngR
         C2LLyk60cX5lDb++JlKyBcZ3jJF46Z44SJQnLziQH79cCagsPbIxu6lpElHmc0WFZPe3
         cLzyQENmS+/htCDEZpm3SVmpjg2rtuRLC64WDQhdvFS84Wz+g5NX6ZEic7DmXL/+zAj6
         H9C6lwZ58GbcS/2O2QApC+NOhtdfQVDPFlVBXtGCfTq4G0HMDwFaCAWFkWBCqdsOpchU
         ZOD2VoHaaxQh9LbgUAJqY2DhBSZC9RZZoLToM4u1BadHEPcS798Q5VQ6t4aL04iE8dFs
         IaUg==
X-Gm-Message-State: AO0yUKWE7yjnrmt+Q6NEIDk4oL7hbuZw5x/LGP5ycVa20alGds22cvUW
        x0sG0xk3cn9hXiWNASAP9lCJEA==
X-Google-Smtp-Source: AK7set/biAf/T3vyrs0RgzzYbZppnqSrbJ6xP6jBIO8iCgWEatf30nvt5JBrubAwaJSe3/1ImaXsIg==
X-Received: by 2002:a05:6512:15a:b0:4cc:a166:e27f with SMTP id m26-20020a056512015a00b004cca166e27fmr537470lfo.3.1676838918463;
        Sun, 19 Feb 2023 12:35:18 -0800 (PST)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id n8-20020a2e9048000000b002934fce87bfsm286710ljg.108.2023.02.19.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:35:18 -0800 (PST)
Date:   Sun, 19 Feb 2023 21:35:16 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Remove get_kernel_pages() for v6.3
Message-ID: <Y/KIBDu3BiHdIsX7@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these patches which clean up shm_get_kernel_pages() in the TEE
subsystem and ultimately remove get_kernel_pages(). The patches have only
been in linux-next for close to a week but you told me it was OK to send
them anyway.

I'm normally sending my pull requests to arm-soc, but with the short
time in linux-next and everything I decided to send it directly to you
this time.

Thanks,
Jens

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/remove-get_kernel_pages-for-6.3

for you to fetch changes up to 816477edfba6e7ab9411acec5f07cfa00e0882f7:

  mm: Remove get_kernel_pages() (2023-02-13 14:16:41 +0100)

----------------------------------------------------------------
Remove get_kernel_pages()

Vmalloc page support is removed from shm_get_kernel_pages() and the
get_kernel_pages() call is replaced by calls to get_page(). With no
remaining callers of get_kernel_pages() the function is removed.

----------------------------------------------------------------
Ira Weiny (4):
      highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
      tee: Remove vmalloc page support
      tee: Remove call to get_kernel_pages()
      mm: Remove get_kernel_pages()

 drivers/tee/tee_shm.c            | 37 ++++++++++---------------------------
 include/linux/highmem-internal.h |  5 ++++-
 include/linux/mm.h               |  2 --
 mm/swap.c                        | 30 ------------------------------
 4 files changed, 14 insertions(+), 60 deletions(-)
