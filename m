Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358CA63826E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKYCd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYCdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:33:55 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91BF201A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:33:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id io19so2796399plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3ynaYc2KmE6H+RiMyNuG83Uvj+d7vH3kcd1RvLrvVE=;
        b=LZiLMbqEfNJ/UzarkS4hWdRi0UqvtipwE5umrihLJEfEpmnFKvTVAYgUxJA+hvUeS6
         6u6yKHwyJ6YyWMx3g7qlA16mQZBfsdXpg7X3rVGNF0VznaxVAqPSlpuS6kb418uU4RkX
         lRljPR5TngzJSNcKG0A1th0a84WzhacZLpeoVgnavSOzIeQqi2Rg44ph548q37Dtmq8V
         ytASQ/GqA7qrvQvBJbpttjVd+usCCZ0Ge/b6wUqQyfPAW2KBWLR/fHCrzlGQBjsDW9ur
         iLZN0mIn7+10nkXCnVpoHAsoV5/kePSQio7vdM0bZNemBqC6Rk+IrvonaJITj7Px2rQP
         +Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3ynaYc2KmE6H+RiMyNuG83Uvj+d7vH3kcd1RvLrvVE=;
        b=jliSFKbTniq8rvVMBcHrlYD6xuXyoXPXfmzZIzBLgjnFvWtp9hOZkDFhSZEw+ijLnS
         ropRD0v4S0qnuZCqGyuoMaAQuHPsTFSVGLvcQ/mgGrVPsuT3DhDb8pHS7cP7ovXNXeJj
         JS4nFgNTrCI7g20Ai+Q5FkRu8inlyJT6Mx0gajW6li9fmi24zFMTXDiEidgD/AG3g99+
         rKOrxvXqr13mcGbjAMZm7Jh3SCQ6/kgo91qxBantZBygkyuVWITAeGeeRbh0O2YEJEQV
         bOerTElVFOzliGdhn0EeZR3pJp8isLAf/bHMDApZSOvdVrgcnvqUmHuU72OXrKGgcBa3
         Lx2Q==
X-Gm-Message-State: ANoB5pmi96bVNYHl4vxpUyFxS279IREeaq6HMsO2Nugh/DjmMyniVJsP
        sIMagjRlTV5U49Apl2hkWkM=
X-Google-Smtp-Source: AA0mqf4X1W4dSDu2L4XQm+rbEdzMxOkbnq92dTwKQ1DynkEBADnVfjtyPvqp5RrjMFgAyyrI5Ec2HA==
X-Received: by 2002:a17:902:eb86:b0:188:c395:1748 with SMTP id q6-20020a170902eb8600b00188c3951748mr18390066plg.155.1669343633332;
        Thu, 24 Nov 2022 18:33:53 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m127-20020a625885000000b0056bc5ad4862sm1893822pfb.28.2022.11.24.18.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 18:33:52 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/2] x86/asm/bitops: optimize fls functions for constant expressions
Date:   Fri, 25 Nov 2022 11:33:28 +0900
Message-Id: <20221125023330.195581-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compilers provide some builtin expression equivalent to the fls(),
__fls() and fls64() functions of the kernel.

The kernel's x86 implementation relies on assembly code. This assembly
code can not be folded when used with constant expressions.

This series replaces the kernel assembly by a builtin equivalent when
appropriate. It is a follow-up on this previous series:

  https://lore.kernel.org/all/20220907090935.919-1-mailhol.vincent@wanadoo.fr/

in which I promised to also modify the fls() functions.

* Changelog *

v1 -> v2:

  * [patch 1/2] add Reviewed-by: Nick Desaulniers tag.

  * [patch 2/2] replace:
       BUILD_BUG_ON(sizeof(unsigned long long) != sizeof(x));
    by:
       BUILD_BUG_ON(!__same_type(x, unsigned long long));
    and slightly modify the commit description.

Vincent Mailhol (2):
  x86/asm/bitops: Replace __fls() by its generic builtin implementation
  x86/asm/bitops: Use __builtin_clz*() to evaluate constant expressions

 arch/x86/include/asm/bitops.h | 70 ++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 30 deletions(-)

-- 
2.37.4

