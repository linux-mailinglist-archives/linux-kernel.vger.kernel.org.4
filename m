Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2863CF11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiK3GBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3GBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:01:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6219FDB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:01:43 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j4so25397070lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dd2bPOSx73YkfI4ietT0CtlJFPAPYcl5w03w++siR3I=;
        b=VueP3BV9DWQDNRdZ4CP4P+VNS3R/j4lV1uV1cXsTBW0u75pHBOhRYGDAUdYvUErmti
         624irIm4wqDMaReKRB30EvyBJ7amP4v+zfVwv2hJUhQyNoe0UAZcezmo2pnlQF6Xrpjh
         yHfvEx6D1DhBe6VCGE43YjmmeA3fyhA58EgzHePnSXxtFGhySFuXaheY0gqwf1leNssp
         YKzzaiR/iVoDS8dyWYp/GGWo6hPAsEsTL9CEXKpkfyfwWcFyvSWVxbos+mMe0ELBlrtr
         BCSxVxIiVT2+ZnQZ3g6aeNXUnk52IIb+bqRn9MbaK0C5Ol58dW3S5HKSmQdCRNC4NppZ
         OF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dd2bPOSx73YkfI4ietT0CtlJFPAPYcl5w03w++siR3I=;
        b=oWaCer7EGlorqOINv5OynkPrdC7EPjPNMnuEVfAosjuZuULSVrbMqc9+G2/oX4qUZz
         XEKXxIWZ3C2cUYrYDGBX/HXsq+Ui66aLPDqceLCzXcfpT99B2TaElhbYRDS5vmp6Fu34
         XHXmYg5g1y7DA+szUCL+JMcLHefEnq6PDDK9jqden/yIDOLb9d7eOuOF3Pxa4rX+MBee
         d8j924yh3eI8YwfpAOoLKUJ5W9H4ShVCnFWZahilZszb4piUSw3wEqsrK+Jvr7SKzWLN
         kwOFUitWL/N/1LM10+8R5+/dvRNEkWOqx425u+6laMTKPwjar0rv0H74HiepyIkj/ZLV
         2qBA==
X-Gm-Message-State: ANoB5pkBLA53EZ5QHoBMeaaFkDt7oN4tloV7/wQcVKPgV6pGRXcplBHT
        dx3vq+Fjv1sdnougGDM33wwrd59ubwsxB4BAX6o=
X-Google-Smtp-Source: AA0mqf7q7VYdGDYdxOCSlaJ6L0t8HZDI4fhO1M/d/muCK7Hva5Fqezbch6yxwkGj/aDj8LfChdO+7NneUt+SPFcXc28=
X-Received: by 2002:a05:6512:22cf:b0:499:fa38:3da4 with SMTP id
 g15-20020a05651222cf00b00499fa383da4mr19306949lfu.12.1669788101168; Tue, 29
 Nov 2022 22:01:41 -0800 (PST)
MIME-Version: 1.0
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 30 Nov 2022 15:01:29 +0900
Message-ID: <CAM7-yPSL2ewn9kjaR01vq8V410G+F1taJzAqVuvNOJOkbX7URw@mail.gmail.com>
Subject: [Question] Should we reuse target when damon's operation changed?
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello SJ.

While I try to use damon, I have some questions whether it is correct
to reuse damon_target structure when damon's operation is changed.

At first, one user set up damon like below.
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/pid_target
    echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions
    echo 0 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions/0/start
    echo 16384 >
/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions/0/end

    echo vaddr >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operation
    echo on >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/state

And some time pass, user change the operation as "paddr" like below:
    echo paddr >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operation
    echo commit >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/state

In that situation, the damon_target is reused and the region isn't changed,
former region information which damon_region has -- nr_accesse,
last_nr_accesss, last_sample addr is kept.

But, former accessed information is based on vaddr and changed
accessed information should be based on paddr and it seems the wrong
information to new applied operation.

IIUC, it makes some confusion to kdamond when it merges or splits
regions based on above information.

So, Is it much better to remove the target and region information when
the operation is changed? or should we check whether it's possible to
reuse former access information between former and new operation?

Thanks.

-- 
Best regards,
Levi
