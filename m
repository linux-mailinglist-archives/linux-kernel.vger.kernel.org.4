Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42C619D2E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKDQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKDQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:26:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F8D1DDE6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:26:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s196so4803402pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vl/MFnMZWToBmu5A4jVqt8zL5+NKQFzCISCwYnVAW2Y=;
        b=PQdq7E71ycg0gOwLD2lncqKFIIQ9DNU4sK+LFxXU88WpDYN733tfqEj0iR4vZAKh+g
         2GtEi07IMbGTx89JVyqW4en1DSpSnQMnEIa+QpF0SrRorfxokN3/mjlenOYRMuvs7gt2
         jK8rhBVoUDPH1SMbGkSvEpbV6Q3+FPC4k7nEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vl/MFnMZWToBmu5A4jVqt8zL5+NKQFzCISCwYnVAW2Y=;
        b=5vnxwF5Esir4DJOVrMd3WjwXINjT6Nc9b9YY3ymbMWQ17qU4HL55yBzyFhiD+BETvP
         f2cKVuJV5qu++g3QH9OxbhI9CKfr9fST9tx+fPEU/4Q+9BCI9N0ALYCA93xpkAhSWJyA
         LRwMggZT+UNHQ4AGmUu5C9B5dqBa5fD8QnEmF8/Ly49gQ0B+hhhKkPMuQcmE4mqGwSNX
         87UQ5aStUDeB2xuZ8KKhYo2TBSKR+kyNsB3IruW2vIO7L6eIqrD6Bumk3vbJNICShQr0
         coMczNqm4pqsINH9h59VEBE0Mplcf76XP19BShBTVvIR1C6g1Q+7cFtsGEBXj5F+E6Ai
         YrmQ==
X-Gm-Message-State: ACrzQf2eLwrbxMbXSp/t1H98rFzaHPJai9Z8J5g11gfIuYnDlHhoK7NT
        XlNrSywQ/q6eubJmOK2sXurOWA==
X-Google-Smtp-Source: AMsMyM4cVgTe4Ak7y9MLEhk5QYQz3506Yk94FQT+AjVk3TLswCnDvtG5MCqa67zwxU1riSTtyNk/6g==
X-Received: by 2002:a05:6a00:993:b0:56c:80f6:db5 with SMTP id u19-20020a056a00099300b0056c80f60db5mr36279550pfg.45.1667579200953;
        Fri, 04 Nov 2022 09:26:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902d49000b0017854cee6ebsm2921403plg.72.2022.11.04.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:26:40 -0700 (PDT)
Date:   Fri, 4 Nov 2022 09:26:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [GIT PULL] hardening fix for v6.1-rc4
Message-ID: <202211040926.0E7BBDB1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny kernel hardening fix for v6.1-rc4.

Thanks!

-Kees

The following changes since commit 72c3ebea375c39413d02113758319b74ecd790bd:

  overflow: Refactor test skips for Clang-specific issues (2022-10-25 14:57:42 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.1-rc4

for you to fetch changes up to 6f7630b1b5bc672b54c1285ee6aba752b446672c:

  fortify: Capture __bos() results in const temp vars (2022-10-28 16:07:01 -0700)

----------------------------------------------------------------
kernel hardening fix for v6.1-rc4

- Correctly report struct member size on memcpy overflow (Kees Cook)

----------------------------------------------------------------
Kees Cook (1):
      fortify: Capture __bos() results in const temp vars

 include/linux/fortify-string.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
Kees Cook
