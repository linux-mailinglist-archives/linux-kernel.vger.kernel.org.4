Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64273FB41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjF0LlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjF0LlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:41:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0B19B0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:41:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31297125334so3857184f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687866062; x=1690458062;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Gsocut1RLICHqyRanQnJqv4Xl4Nj+KV9T+GNDDTjHL8=;
        b=U55x36O0p0TasOBMJMqOYa2/T4ObQ4tIUw/l+5mcsrKESqEHMVDfK5tFEU+4BT5Cqn
         0ngWR3KItiJk/Cfh3QPWIDPSGfNHz7o0Gu+2kIX+m4ugk//SiS5XKEAAgD5dH2/KOQ+8
         98xm5zHGwJKv2poDBaLtIhHU3dKQPlrHh6aoYJj1wP5shAlvHlVmOzuxmWSCiJG9uR5T
         lzVEhwjzwdei+pYu3gMJftmcHStW+pMSyvj2DWcrEwSv7gT9BsGMMY3JI+FyS4LsbfsJ
         KfFbeJG8OCzT5oguiNa5MmtWJocWLFOAb9F9ADIrh6K1E187UECayRqDu2Thl1/6+ayG
         XNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866062; x=1690458062;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gsocut1RLICHqyRanQnJqv4Xl4Nj+KV9T+GNDDTjHL8=;
        b=WFSUIUKFPJ7ZSPWbzsty816NCqGyNBS6JYktEgApx0d8B7sFZDR6yXvfrmVVkOOdz3
         QrkJkmzat1hJc1lpiO2uSN63zBJOhBDBPhj2/5lNthnBY84ZjeLRuZ6g226gWjCVxqJ0
         JcRzs24bBzlz3yAadH0PaEHzeJ2gUh9ADiDhZV9gIKCQhlnAsRjptR69ojz9H/3Vcj3C
         WvgcTQkpRZKz28a+cUQpwVrzbqKVj8LzMXjPyWD/gPoS27t7DsSC0/FK/SG/z3cu3/d1
         QUVVUPuoOk4mgyUmulCOENg0iqfoIO82mnUzXAlaWi07COLaYDJMsusQI+8GT2suBCgl
         dwTA==
X-Gm-Message-State: AC+VfDypqmdmuqDZlOEvAY6fIXuO3CERQV1O1nfO5afYk31xEPzBGB6c
        u05c/nHKoydHm9uofJqee1w=
X-Google-Smtp-Source: ACHHUZ7b02q9hbG/jg1FJ/AjoJKSB3O2cA+zgdpi3fdBzCRtFkDXymZilCRP0/axlO/JLk3bzoeuYw==
X-Received: by 2002:adf:e9cb:0:b0:313:f4e4:9e4 with SMTP id l11-20020adfe9cb000000b00313f4e409e4mr4429550wrn.15.1687866061985;
        Tue, 27 Jun 2023 04:41:01 -0700 (PDT)
Received: from gmail.com (1F2EF7E2.nat.pool.telekom.hu. [31.46.247.226])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003f8d6647661sm13394034wmi.15.2023.06.27.04.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:41:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 27 Jun 2023 13:40:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/mm changes for v6.5
Message-ID: <ZJrKy3TzC2b/R5X1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-06-27

   # HEAD: 78841cd185aa74bc92d3ac2c63a870395caaa086 x86/mm: Remove Xen-PV leftovers from init_32.c

Changes in this cycle were:

- Remove Xen-PV leftovers from init_32.c

- Fix __swp_entry_to_pte() warning splat for Xen PV guests,
  triggered on CONFIG_DEBUG_VM_PGTABLE=y

 Thanks,

	Ingo

------------------>
Juergen Gross (2):
      x86/mm: Fix __swp_entry_to_pte() for Xen PV guests
      x86/mm: Remove Xen-PV leftovers from init_32.c


 arch/x86/include/asm/pgtable_64.h |  4 ++--
 arch/x86/mm/init_32.c             | 17 ++---------------
 2 files changed, 4 insertions(+), 17 deletions(-)
