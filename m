Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E696562C83C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiKPSxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbiKPSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:52:29 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8BD67112
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:49:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id h206so13919933iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+5NOj/eN7Sd6zRcjl8U07Wqml0C/EahqV1VAbj3kLI=;
        b=3a+/zkDiOpLfoSG+mtPZSx/BkQe0mtIT+bCyIDz99pulN7wgz1ryTHjFU576r5zr47
         BYY7bRC7QNjQdh0AthCUEclr2OFeRxAe2kY6VQGAvLp3aY2L8ZyCiLMkBvS5YqQ+HoiY
         zrH4jji0EHBd+pGd9mYnIcN0SBFm6Gve0vSZ1M5w5J7Ufb9lU+XUcyp4arSJbnaA3wJ3
         Rb7b4U4FSgi6F41tpOwgBUtdXEotp0FKO2a7h42O1ONT8uU8Meefc4e+Iv9mPYHYjK4Y
         FvOrP5fvbYAOAP4+hLKYhQq93TWz5coOUpxrHR3zA3O4YCP3Jr2vyRBSF8tfcrD7S5jL
         5Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+5NOj/eN7Sd6zRcjl8U07Wqml0C/EahqV1VAbj3kLI=;
        b=W6C/nev7kS0YHFzlv5bv7oYwQvSe5cS7O41MS0N9yoQfALJnEJc84IUbFQj57KzDDY
         LSsW4GaEpI3QT9lNqTAuX2tHXkrR75b01WIICql6xzhrrwBG1TeXcTdqa8o1ryXnOeZ9
         NYk9NJXorRkEInlfDqfv8j0w5HbrwjhYIbnQvvVvUl+LKvc/0Akcly5G5Ic8Kmckm7fn
         MlKoxJHXdnYfP4PgNjJIQ1/f7Ki5++56+DRG5r+JJxIgZy/a+sUJ3LevQCYIZXVMXepe
         ofh2ENFjugjHtFdIkAOsZLHzSMNufydDCYNCE/V+Tx/cBV9GO1+dhW94l+tog44V1XC5
         GRTQ==
X-Gm-Message-State: ANoB5pnRdv4xs0dBPNAX2F9WDtXwDTN7KRKQUlhnrcqYzQVUVm1nfjub
        vyO6dOrQNXZATOPkY4QbPy1rwQ==
X-Google-Smtp-Source: AA0mqf7vRHK9SdHOKCvaaWwNJAo58DVTBKpqQuukd1w41sRkOWimHGDz5HNQTHZi3PKUV8M8AOvWCQ==
X-Received: by 2002:a5d:948b:0:b0:6bc:2a47:a874 with SMTP id v11-20020a5d948b000000b006bc2a47a874mr10180859ioj.126.1668624576555;
        Wed, 16 Nov 2022 10:49:36 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m1-20020a0566022ac100b0067b75781af9sm6913174iov.37.2022.11.16.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:49:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, jack@suse.cz,
        chaitanyak@nvidia.com, peterz@infradead.org,
        liusong@linux.alibaba.com, linux-block@vger.kernel.org
In-Reply-To: <20221115224553.23594-1-krisman@suse.de>
References: <20221115224553.23594-1-krisman@suse.de>
Subject: Re: [PATCH 0/3] sbitmap: Fix two issues in the per-bitmap wakeup counter code
Message-Id: <166862457559.199729.5082175605885412089.b4-ty@kernel.dk>
Date:   Wed, 16 Nov 2022 11:49:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 17:45:50 -0500, Gabriel Krisman Bertazi wrote:
> Jan reported two issues in the original thread.
> 
> The first is that wake_index was not updated after returning from
> sbq_wake_ptr which meant we'd have to empty the wq before moving to the
> next one.  Patch 1/3 in this series reorders the code to avoid this
> condition, increasing fairness of queue selection and preventing
> starvation.  I sent this patch already on the other thread and Jan
> reviewed it, but since it is a small one, and a dependency for the
> other, I'm resending it a along this series.
> 
> [...]

Applied, thanks!

[1/3] sbitmap: Advance the queue index before waking up a queue
      commit: 976570b4ecd30d3ec6e1b0910da8e5edc591f2b6
[2/3] wait: Return number of exclusive waiters awaken
      commit: ee7dc86b6d3e3b86c2c487f713eda657850de238
[3/3] sbitmap: Try each queue to wake up at least one waiter
      commit: 26edb30dd1c0c9be11fa676b4f330ada7b794ba6

Best regards,
-- 
Jens Axboe


