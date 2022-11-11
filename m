Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E73626181
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiKKSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiKKSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:39:01 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA2887B23
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:37:24 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l2so4837941pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zopk0rw6sOKpPrVkf7AaBWipWAGDYC/DOt4g7IQQok=;
        b=kcsezOqNufRfkxyWjgLGPakA70WuxeV7jkZyE7XuC0wOqVe0MCexND2iU7GZpMbBxl
         Yn6zYHoiiKl0ws9Hj/7kQYHnpkTcXV8YtlxfyMWGvBWFmlkeb96zD6kUjj9xXEVFMCXA
         8h5POE/BxhfVHu2ggf/Xn+jFysst6oGdOcLiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zopk0rw6sOKpPrVkf7AaBWipWAGDYC/DOt4g7IQQok=;
        b=GTgTZ7h0iHfqdihH0IL4+qn960vaY8YrpjONTE1FIFzxMlUFRHC6m+FvtrGqVbHUzj
         b2ymvdoBaFWm5OEQ0ihoR4HjPoPgPkSVddPrNMYv0yx+UBoSflIl5dwjx4zw6vQFCHMI
         6mMUCxKNyl0QiROwyERVnnvVwPS9NaaXTaPi+Q0uSifa6Lv3Sw93BQN/TxdSzjkfzz/J
         4uGt35b4Q5WjAnKhU3eQ9EBN3UjHPEAW3aeThR15Q5tQIOmSTCjMSsgFdqWjRfy+hUn6
         VmO28o2rZ+HPI8tZ1l5EteSAbPTkGEF6ETgBplvG4RZJyY0kb5avUTiqEmWK5LQRRc1Q
         eufQ==
X-Gm-Message-State: ANoB5pkXZZH4caHjIwZzQRrsDj98wn+hzI6b6TQCyYNPYjOgZ81sJvMu
        wAiXZTGXO0kNRwn4bTMbbd7byQ==
X-Google-Smtp-Source: AA0mqf4tiZiL8j8pnB8z9MXoQai0fdaTKw3SqhVwm3QpSu6mYu+9f8dAEAzUILgwilqsrJxZ5tGOQw==
X-Received: by 2002:a17:902:9a01:b0:186:9c43:5969 with SMTP id v1-20020a1709029a0100b001869c435969mr3463900plp.32.1668191844445;
        Fri, 11 Nov 2022 10:37:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b00470275c8d6dsm1626207pgk.10.2022.11.11.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:37:24 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:37:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        xiafukun <xiafukun@huawei.com>,
        Zhao Wenhui <zhaowenhui8@huawei.com>
Subject: [GIT PULL] kernel hardening fix for v6.1-rc5
Message-ID: <202211111036.19260F591@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this kernel hardening fix for v6.1-rc5: a small fix for !SMP
linker section orphan handling.

Thanks!

-Kees

The following changes since commit 6f7630b1b5bc672b54c1285ee6aba752b446672c:

  fortify: Capture __bos() results in const temp vars (2022-10-28 16:07:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc5

for you to fetch changes up to 000f8870a47bdc36730357883b6aef42bced91ee:

  vmlinux.lds.h: Fix placement of '.data..decrypted' section (2022-11-08 09:59:19 -0800)

----------------------------------------------------------------
kernel hardening fix for v6.1-rc5

- Fix !SMP placement of '.data..decrypted' section (Nathan Chancellor)

----------------------------------------------------------------
Nathan Chancellor (1):
      vmlinux.lds.h: Fix placement of '.data..decrypted' section

 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
