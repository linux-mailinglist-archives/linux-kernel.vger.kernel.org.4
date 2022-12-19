Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A6465135F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiLSTjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiLSTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:39:35 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50A9B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:39:34 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id o12so6919513qvn.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwBHnN2XVu4+0SF8dWKpDPbcRCSXj6F42AS9B3puGuI=;
        b=kaE6y9tsMsBueNXs0gNvf/SBmxv1gEWOGL46Cgy6DFkoNEL46EfnNUX9qvbIS//73M
         EXeD3w8EI/uv1NRjVdx/Qs5PTW6oV8gnoeVuq1Y6Pb+HZpFM3O/Jm4Ga7rqVbjElii4W
         6He7djaG2TsloMI18lV/axe/ByYM4iEYRVxUJq2E/OI+CAEF50L6G82pvCYLbbJDda8n
         yeDLWQ4pXD2VuMsuNnBzP2LFJHZNscpzUQd5eerU0PpMp4ewAJUbk6aJFC9LN4Dhyvxm
         tpL9DMAnIzdI4K64IPxowGrWcm1u4dtfuPuxc0h99+22zwZzPp8JVIrCjJezCDG/92mP
         GjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwBHnN2XVu4+0SF8dWKpDPbcRCSXj6F42AS9B3puGuI=;
        b=aS2ir8yhEaIvnohB2U3t9tB1SC9kZHxAAFwD9SSp20hKin9QmoTxL1igyonyUYEzTu
         ucffgjL9VOUGr5jDqA3dwfqdqRKP0Cmln0rmXgcWqRD3seSr8HWYlCQ45M9xYQx0f+dR
         DIJjzBB9pOhqZ1rmM+35GpsSzXJMm1POBmkgfzbzmixD6fy/wwLUA7RYhBt5Diy2dzVE
         0nthuOFzcxSChE0EjUv9noxjWH03R7xtsCK30qiDphwmvgB/6lCAXW+6y0morI8O42l0
         5ECOny0MhGVEMdyxBctD4Nf31rOmt1+rJ6o5rWaQe98D4CtqDx2dKzdWPgRmOsIpmWci
         zZ7A==
X-Gm-Message-State: ANoB5pmXilJfuGnz/GeU7LdHHhxWS1GmhhcpD9siSt1wZzdiJjd9j6ak
        uKeSJXuLokRQGqZYAPhsxlyyWJCPhw==
X-Google-Smtp-Source: AA0mqf7q16iL0flP1B75wUVzZIYe4C55zWMeCm+np/5ufqtxSQuopAqqm7pByHJxHC0RTztpQF9BMg==
X-Received: by 2002:a05:6214:1190:b0:4df:2bdc:14e1 with SMTP id t16-20020a056214119000b004df2bdc14e1mr38848654qvv.47.1671478773475;
        Mon, 19 Dec 2022 11:39:33 -0800 (PST)
Received: from citadel.. (075-134-122-108.res.spectrum.com. [75.134.122.108])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a269900b006fc447eebe5sm7654130qkp.27.2022.12.19.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:39:33 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/2] More x86 signal cleanups
Date:   Mon, 19 Dec 2022 14:39:02 -0500
Message-Id: <20221219193904.190220-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set takes code from signal_compat.c and moves it to the
appropriate signal_$(BITS).c file.  No functional changes.

Brian Gerst (2):
  x86/signal: Move siginfo field tests
  x86/signal/compat: Move sigaction_compat_abi() to signal_64.c

 arch/x86/kernel/Makefile        |   1 -
 arch/x86/kernel/signal_32.c     | 127 +++++++++++++++++++++
 arch/x86/kernel/signal_64.c     | 127 +++++++++++++++++++++
 arch/x86/kernel/signal_compat.c | 191 --------------------------------
 4 files changed, 254 insertions(+), 192 deletions(-)
 delete mode 100644 arch/x86/kernel/signal_compat.c

-- 
2.38.1

