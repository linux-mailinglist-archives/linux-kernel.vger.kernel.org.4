Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0F6F1D85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbjD1ReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346273AbjD1ReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:34:19 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48D1BE9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:34:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f851bcd4fso1756637b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682703255; x=1685295255;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2a4lhXo98d7cy3HtSaP0LMxEWTUsm/6EQ2BD6MDwSH0=;
        b=dNTPS1gJ5oQwb7NFCQ6mEam2Hl1g1fWR1TMDl+MC2MGS43JUrRfd0ef8hH/zkZwFLV
         qAqss5VXan2WsU5Lvr0hHAM6VSsjd5mlFWSHXnIq5cZ8Rnz3s5t/4Wy/8SX5CF8wq19s
         Lu4FfIKPdSaNAkmcNBmnay3QHwBSwEf/HgWQ4dZYXnVv+9sBTb7u/5GtSAQd50Hur6Bz
         T5JrubYoCN5BJCFB/Owd8VR7xVjt7GCghPW86VNpTKvt60mQlQ1+Gim8N6cv7Eid+oW9
         eIlBcxDzFa1NxlvE0hzLHE/B+p+nTNu4bEjgdtYoX3La6dgmaxMfHN8T1L4ELMCulzUz
         3h5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703255; x=1685295255;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2a4lhXo98d7cy3HtSaP0LMxEWTUsm/6EQ2BD6MDwSH0=;
        b=XyESN96cnf1qnyjy48FNGRJyOaWy4O5e/3QfRByjFuzn0yea385S8hkNWv+IHYAB9s
         CiI0+ruzksYWhwNfKvllMG9TJrno+uHD3LcjiQ4iCcOLON2G2JQwZaFfPjAvjFX1Td1V
         2px6sQEOAcmanpugXFP4vncJC3c0mF/RDedepGYaTtqt2rsF4nf7vqk0jjA1jbU8p7OW
         iD9t7oJ85O5nvwLJrXf+pnMHF+KF6aLExOy2rsAgLlF7SKDyS4rtEPeJrKrslrJwYrOh
         MWh2dUYNGjecIoetkEzo+1fYsGKpV6lUKtG+L7hMB09rS8jwArfhNZGQdgNh4SB4GTSc
         perQ==
X-Gm-Message-State: AC+VfDx3eUXCHUoAfQZWmMnesDA65FOOj4SQ+PBpqCqJdjWeRbHHfxVM
        Zo7TgDY+or0QybkBAQ43oHFWBSSeaW7hchl8ZMNV
X-Google-Smtp-Source: ACHHUZ4HWpc/xqxb0N1Ab9iwzOilwC5hf+MKcASluqTL4Ot8dGhQnFyn3eOMw/zpNxUIwcoELRzWTvOwgBITenqCRF4=
X-Received: by 2002:a0d:d74c:0:b0:54c:11e2:d32 with SMTP id
 z73-20020a0dd74c000000b0054c11e20d32mr4258489ywd.27.1682703255371; Fri, 28
 Apr 2023 10:34:15 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Apr 2023 13:34:04 -0400
Message-ID: <CAHC9VhSGT_kK7fB5Tea5HVTXjTWYxh+hZ+v4R1A24wdLtthPXg@mail.gmail.com>
Subject: [GIT PULL] LSM fixes for v6.4 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A single Documentation/LSM fix for v6.4 to update the LSM hook
documentation references from lsm_hooks.h to security.c, please merge
this into your tree when you have the time.

I'm even going to remember to include the proper pull-request text this time ;)

Thanks,
-Paul
--
The following changes since commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c:

 reiserfs: Add security prefix to xattr name in reiserfs_security_write()
   (2023-04-04 14:26:26 -0400)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
   tags/lsm-pr-20230428

for you to fetch changes up to 6d2ed653185baa5ba601306cbd6cd7192642045d:

 lsm: move hook comments docs to security/security.c
   (2023-04-28 11:58:34 -0400)

----------------------------------------------------------------
lsm/stable-6.4 PR 20230428

----------------------------------------------------------------
Randy Dunlap (1):
     lsm: move hook comments docs to security/security.c

Documentation/bpf/prog_lsm.rst             | 2 +-
Documentation/security/lsm-development.rst | 6 +++---
Documentation/security/lsm.rst             | 2 +-
3 files changed, 5 insertions(+), 5 deletions(-)

-- 
paul-moore.com
