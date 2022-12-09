Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC3648875
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLIS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLIS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:29:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B643E096
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:29:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p24so5761564plw.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r2PSJMZNi7Lx3K9QcpxGsYdFe40hPnGOZyUy1ujyzNA=;
        b=tfI4xAi74SE707QKT/mlAJrn1WsRQMKi7foG6V+hJ3/ZeeH4mn18qk1TNdC36Ofusg
         ux9dVwjH+WeN8+ll50wN/ZVU3fRCV4j51jzLF1QBiKy3L9UcnDNWfvJFpdXUVutD6LSX
         B+nJJ/Z+4pMPkiKT5aQXAVSXC5gZy5nkHgjxcvcgJaZh4I2OJC7oMP//CIrni2xl0jSV
         Mmw/ny6WvzljNwb3mAlZHa2O41ZhCD7YCeG0EvMDL4eX3mZ4scebmz0Nk9VnZxQOhYOB
         3LvxaClg/ESU/pP7naEJRn8Pv2TZh2Wrj3eyhM2yqtbeuzCfNRyNSicIITnV7GFt+P1e
         tuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2PSJMZNi7Lx3K9QcpxGsYdFe40hPnGOZyUy1ujyzNA=;
        b=Xuzn4mGoRcpDPY8GcsJkCPCEmXH4Ezuq9HF1cFuHLUaRah1aVlqjYINORsZ6dONlt8
         B8Vla1GPdiTCPRTH9pgrdCH3UcgpjWzt1ypY7sHkwZF1Ghc7WoTCD53lsRXiFfw6d5ZQ
         lynHOtTwyrX9eJpCtqpn5ZWJ8GQrN+lAgQMiRaHuL8/KXaRMWY+QPRTGSrFCgKnHSre4
         E7z7zlfpq2BV8T4sGcEiqPhmoGtweSsjzMB+A8RpTVk23LyVLrWnDhxEPw7IjaBtkyDY
         T1wuY7nPncd+RlHUhX5IIjzNU8iUw6sVlXw2pq1ChomIUdwxVLzceO8wlGeJH4e+5dKZ
         UvFw==
X-Gm-Message-State: ANoB5pl8vSpcl9cTAqAqZ/cqJZYxnLB7jslBH3srm3q3IkK2wXk8FwSF
        zHq30O501fKeesSAH0lKKdYpYeyvmlxCLqUKoDBYmuGT2xSgrNw=
X-Google-Smtp-Source: AA0mqf4pAFPz9IcBXP3Ikc3/BIQ2Fh9HTUyem6n1RTDDoggYxub8h7ftdTIbBK+SxRWviGCqD0xcosbYz5JA2HpPsTg=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr108649177pjb.147.1670610559976; Fri, 09
 Dec 2022 10:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
In-Reply-To: <20221209160453.3246150-7-jeffxu@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Dec 2022 13:29:08 -0500
Message-ID: <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, keescook@chromium.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> The new security_memfd_create allows lsm to check flags of
> memfd_create.
>
> The security by default system (such as chromeos) can use this
> to implement system wide lsm to allow only non-executable memfd
> being created.
>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  include/linux/lsm_hook_defs.h | 1 +
>  include/linux/lsm_hooks.h     | 4 ++++
>  include/linux/security.h      | 6 ++++++
>  mm/memfd.c                    | 5 +++++
>  security/security.c           | 5 +++++
>  5 files changed, 21 insertions(+)

We typically require at least one in-tree LSM implementation to
accompany a new LSM hook.  Beyond simply providing proof that the hook
has value, it helps provide a functional example both for reviewers as
well as future LSM implementations.  Also, while the BPF LSM is
definitely "in-tree", its nature is such that the actual
implementation lives out-of-tree; something like SELinux, AppArmor,
Smack, etc. are much more desirable from an in-tree example
perspective.

-- 
paul-moore.com
