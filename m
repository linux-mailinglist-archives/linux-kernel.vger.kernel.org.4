Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2846EF9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjDZSKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjDZSKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:10:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A797298
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:10:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a814fe0ddeso78412235ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682532633; x=1685124633;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSnadq1rdsAY73hqg4R8sAB1GhbZrkH/98e+g3pDbGk=;
        b=Y9nkBSewNWf2SslscrFfOIlQYb0KsxiTuC3JXedSsF/qXT0Txe8XzOgG+aj+9VX8XD
         wSqehj10r9ctKwSk7XVLKjkgOW7KKhK4vB9FGSEu+CqbKTDsdlnL/5/rNxLZAiAC+BQX
         iowQG1Zq26ZQuy9OYhzbPuJ5W9es6ySyk+Zd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532633; x=1685124633;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSnadq1rdsAY73hqg4R8sAB1GhbZrkH/98e+g3pDbGk=;
        b=Ok9qLh0Fx9o3m0Nrhk45/boBGhzbgkOl7YoExlcwjIkV4NET4za1Rf8uRM5JvgZD+M
         9Q1MnFLyYgxHBjt4UzSmMpWpPg//rcsho9ctNJkOIRdZ7GbtQL1wD1D18DrESDicRNtD
         ZcF16wsfZREhIgHBRP3V0JoggQm56GkC6fbEt5Qj3v85Cm9Qkdamw1gfbujlxpitPYaL
         RhB6osfYofZ5cIhTW6DV6DFtyr1qjF7OCM/41nCjoqnDvM1Xyyp6wVLR/bFW+C98YNpk
         vbNrkvXUzWEOP0OrzzW3YbDNLoRKVFWb2mpc0gzL36HjFHQbA411IhgIgqVV4qPHeub2
         JsEw==
X-Gm-Message-State: AAQBX9f6pEaj/+RAtJkK2yjwBAOEncQYw2lOstU8ICKmwUAMoziHEELY
        HF1GVHO1uX6o6x857ZHsfnpRuQ==
X-Google-Smtp-Source: AKy350bqhgXTLv67FxRqIzwPXI7d3V7K42F2hw3aLiujbQEc/MzY4MFZBmoQV1MBpGU/grMNfacM5A==
X-Received: by 2002:a17:902:dad1:b0:1a6:d15f:3ce1 with SMTP id q17-20020a170902dad100b001a6d15f3ce1mr27719574plx.34.1682532633548;
        Wed, 26 Apr 2023 11:10:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b0019c93ee6902sm10182857plb.109.2023.04.26.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:10:33 -0700 (PDT)
Message-ID: <64496919.170a0220.2c3ce.53bb@mx.google.com>
X-Google-Original-Message-ID: <202304261110.@keescook>
Date:   Wed, 26 Apr 2023 11:10:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Chunhui Li =?utf-8?B?KOadjuaYpei+iSk=?= 
        <chunhui.li@mediatek.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        John Stultz <jstultz@google.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        Midas Chien <midaschieh@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tony Luck <tony.luck@intel.com>, Wei Wang <wvw@google.com>
Subject: [GIT PULL] pstore update for v6.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this tiny pstore update for v6.4-rc1.

Thanks!

-Kees

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.4-rc1

for you to fetch changes up to 5239a89b06d6b199f133bf0ffea421683187f257:

  pstore: Revert pmsg_lock back to a normal mutex (2023-03-08 15:00:25 -0800)

----------------------------------------------------------------
pstore update for v6.4-rc1

- Revert pmsg_lock back to a normal mutex (John Stultz)

----------------------------------------------------------------
John Stultz (1):
      pstore: Revert pmsg_lock back to a normal mutex

 fs/pstore/pmsg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
Kees Cook
