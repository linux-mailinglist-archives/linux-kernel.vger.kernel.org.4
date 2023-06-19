Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0006735DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFSTsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFSTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:48:02 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB06106
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:48:01 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1aa291b3fc4so1244132fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687204079; x=1689796079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+p2DsI4lIFDo0S4udSiczU1T4pTI2tCOQoR71yXxagQ=;
        b=bJkJdpYziRLcGzOvCsbPwc4Wt79fWprAzsSOiq56NSddjdLdpYKFcYgngcQnNYKi4W
         L0IUkFxBOK/DqKGleDpzoyurSIZlyJvDN9m+Hs4MDml3n9aj2OCQ2EHQgd8ZnRY4z2cl
         Xu4gvJfq5+ja2Bqz+N6AuEokNQXBjj4NJ35Ah0BV/6IpQm39SbUAJ+onAHRzMedStPNm
         j7JtdxzF6m58wEiYrhROLk/hsXsaASbvIKGbgy+W3vk9wGi3nWpftujNYyWdHvwVvTTJ
         U8v1mYixq80GNOUzZ6cnYZ4Y23WlRtpnRIm3tN1bkW4KIEUoHlsNwLydM0k7yWqKSbcx
         dYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204079; x=1689796079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+p2DsI4lIFDo0S4udSiczU1T4pTI2tCOQoR71yXxagQ=;
        b=Jh68q15kmZJAqA/cSmC110Wfk09W8K/Qeqa/Ndyi3Q8/ta7B1Npx69JNXedOnuNDW4
         hZM4mbreJ4M7zbc6wQ4xgwBBMnUOvnyEB39DrlqsI4K8lR4IpjaIUsNHh2vK30ikQ8xH
         +IMbS6fU3Sgi7YInwlSM5mnvtQf92SdeQZJ/P1EeBlVLCU4anqABR3z5805pkNsyaRT1
         LuqbN4RiO6S/s7+OTblthz6NSl2vUqYsTBnJyIHddorfY3g5lItlDSedNZjVQtGmfdyz
         FV4HvjqdMto2GQWdywCvzxY1V6B+/2tZxkMFks7DvOrBIZyIruVGlAfLljVFdgi9fgmw
         EcUQ==
X-Gm-Message-State: AC+VfDx9stWXq47EVnw39nSjSfJz6qNQgksETSrWn3gS3uoQlLu4HfBT
        mKQ4zWKY8Pg5Zn9G7VZTekUjc8ArMQ==
X-Google-Smtp-Source: ACHHUZ51EcIIW5BVES5rZlQOYeOFPoTP2l00tDsm92MOiV8qrJX66p0IspXqjGXQE1fHQ1vY9437Ag==
X-Received: by 2002:a05:6870:1986:b0:1a9:8c0f:7a5 with SMTP id v6-20020a056870198600b001a98c0f07a5mr1453989oam.3.1687204079632;
        Mon, 19 Jun 2023 12:47:59 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870f10e00b001a9e4167444sm250939oac.44.2023.06.19.12.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:47:58 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/2] x86: Clean up ia32_unistd.h
Date:   Mon, 19 Jun 2023 15:47:43 -0400
Message-Id: <20230619194745.80552-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than one unused macro, ia32_unistd.h is just a wrapper for
unistd_32_ia32.h, and can be removed.

Brian Gerst (2):
  x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR
  x86/syscall/compat: Remove ia32_unistd.h

 arch/x86/entry/entry_64_compat.S   |  1 -
 arch/x86/include/asm/ia32_unistd.h | 12 ------------
 arch/x86/include/asm/seccomp.h     |  2 +-
 arch/x86/kernel/signal_32.c        |  2 +-
 4 files changed, 2 insertions(+), 15 deletions(-)
 delete mode 100644 arch/x86/include/asm/ia32_unistd.h

-- 
2.40.1

