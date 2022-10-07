Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727715F752B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJGITT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJGITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:19:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF6FF8ED
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:19:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s2so6017691edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=udkgoVMMA5qGbuXwnYE/eKPj+LvvtolwfIl/3ldzyn8=;
        b=BU3DgN9ojN4fnIKsF6QsBtoyMrfq8O9Py0mfCVx6JI2ZEIaKHFJMv2pZP1VsOUcBLF
         zrx/yhiW7cRqC19iuxCH3vQjBmcsuMeh577ADRjZGpVLnmIoD7OadqnTQzmgqXdTXOju
         YobWc2uBd15s7pTtA+Edyfc8bX+4Zc3OlfNHSOc4gPSJXPC8FdVxv/P0Wi/cX0p9IaX/
         jCebQqqeMK/boGwoThHdMYEvzMtT3/hMdk5h5Dv5tDMnUnjng8g0rvDGAV9+NvbDXY0N
         JbSvkD3LX4+rQUvhwhvFzfPhJNOqX2CZIXcN6Y0l8+jHN8k40hnPLz0zhQdSOt+7IT3E
         0XYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udkgoVMMA5qGbuXwnYE/eKPj+LvvtolwfIl/3ldzyn8=;
        b=AK4C1Ldanzr0elmcY8PFwpk77fK57PD9s3vykvt0NiyKu1B2uqo9AZnw8Ye3VixgzI
         hfMAUGUiC4Mv3N2bJv7kpG0zK2Y2pJH75fuPuPlCCzFpUpsocBifJljDvTA+T2PzwPxJ
         gSagvUzUXPBVDKsKUM1rJcE3P6p917MupJFPg7dPDdPG+pwSmSjK/eQ8BI8oNXf6Ug7Q
         TbTF3uqsEUjNkbLPmAyl6IsxYzMgM3QrIkuPcDCv7NFJfBfduVfiToe7uYIijsGHA5P+
         XKl54SaeD3k31G7g5KQ/toRqBA5p7bQFgvmdMTEpLGW3l6i20HuZJyrOEflgFgbziM35
         TyYg==
X-Gm-Message-State: ACrzQf2cEGTn5fEnUMglOi8en2j4QQIkLVrj4I+cCihi7hExComkUGO2
        1GSk8CENFlB4gtmdF6+/ymVPP1mcbJ0=
X-Google-Smtp-Source: AMsMyM6gCfsIbBv1JnV4ph6IJRAeV8Q2G2C7q1RdAJBmx0jmZCU72VZwyw0fNeL7A9KOieYDTSsqYA==
X-Received: by 2002:a05:6402:2b8b:b0:43a:5475:f1ae with SMTP id fj11-20020a0564022b8b00b0043a5475f1aemr3362549edb.363.1665130749604;
        Fri, 07 Oct 2022 01:19:09 -0700 (PDT)
Received: from gmail.com (1F2EF191.nat.pool.telekom.hu. [31.46.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709067d9100b0073ddff7e432sm887994ejo.14.2022.10.07.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 01:19:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 7 Oct 2022 10:19:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] Objtool updates for v6.1
Message-ID: <Yz/g+0Ar/1z1d7Uh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2022-10-07

   # HEAD: 7a7621dfa417aa3715d2a3bd1bdd6cf5018274d0 objtool,x86: Teach decode about LOOP* instructions

Fairly small batch of changes:

Objtool changes for v6.1:

 - Remove the "ANNOTATE_NOENDBR on ENDBR" warning: it's not
   really useful and only found a non-bug false positive so far.

 - Properly decode LOOP/LOOPE/LOOPNE, which were missing from
   the x86 decoder. Because these instructions are rather
   ineffective, they never showed up in compiler output,
   but they are simple enough to support, so add them for
   completeness.

 - A bit more cross-arch preparatory work.

 Thanks,

	Ingo

------------------>
Chen Zhongjin (1):
      objtool: Use arch_jump_destination() in read_intra_function_calls()

Josh Poimboeuf (1):
      objtool: Remove "ANNOTATE_NOENDBR on ENDBR" warning

Peter Zijlstra (1):
      objtool,x86: Teach decode about LOOP* instructions


 tools/objtool/arch/x86/decode.c | 6 ++++++
 tools/objtool/check.c           | 5 +----
 2 files changed, 7 insertions(+), 4 deletions(-)
