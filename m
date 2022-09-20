Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6785BED8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiITTWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiITTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:22:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32EF27FE6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so11815406pja.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Y1Vq3TVJb/VWSLfO0Rb19+4XJtG6XYStvEWudetclg0=;
        b=VfqVLJ45y647x0gXwo2gQ+z8ehdPiGmN765iLaQZImjK9/W6CfiT4udXBkZJQS5RWi
         5YUKsiZRaPGTmFqgMg0S6JrUAb3QT+mxnm8vI0rl1t7Uz1P0at2DCiu6MyDDIRqDVqp5
         mkNGp3A0YtuQgcMH37ZLEU/iA03FJATEvCmKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Y1Vq3TVJb/VWSLfO0Rb19+4XJtG6XYStvEWudetclg0=;
        b=y7q4cOkpvYA5XNvdFifdHVf75bQg2z8ZTmsJ5id7A3Mxp19d8eeGU/J/IY+s44T1Wy
         ykQdRw9xDLd/26NqfWOx8fWRyL4oh9nTFNmYpFcn2YT24l9I0O6te0AGj0jqZ/O3xiMH
         CWelbL8WabXx6CCOFDhqPuE2OSdmWOkytYGJR6mPWC9bA3ZNseyIBcYUj60K5AlHW+Zx
         70KosWQNhY+tVACp1M2yz8jxnVFRfUt090IA912P6YVhD3G1UlMURq2izMz0yEGNQWzW
         ut32Hfha5ymGcocJZS5+e7d8bmP7iORY5I0gAZUbbCevt9YBArbQRIYlicdcp6MwWypE
         eS+Q==
X-Gm-Message-State: ACrzQf2loFmJcEzahe+vVvCS7UOTtYVwTegYRAeHobYDL2IXtyymXYNp
        JG5jVMTWLlolf06c98L3kG8qig==
X-Google-Smtp-Source: AMsMyM7UlJUymG96TUt4dcAXXoMYIq3o2jMOjyUAGOo5qGscwQPpXzcr9kpEC2WhUoygo4z9X6EyFg==
X-Received: by 2002:a17:902:8307:b0:172:e611:491f with SMTP id bd7-20020a170902830700b00172e611491fmr1079757plb.111.1663701730500;
        Tue, 20 Sep 2022 12:22:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm249174pfp.163.2022.09.20.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:22:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 0/4] fortify: Use __builtin_dynamic_object_size() when available
Date:   Tue, 20 Sep 2022 12:21:58 -0700
Message-Id: <20220920192202.190793-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; h=from:subject; bh=J1jKJHEXW6fuYZp0bwrwLqGsXtJ2fCfxnhbkDPep9j4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjKhLY5BfaUkXVQJ7vCxL3yWuutd9/BjsHihL3Ygj4 bXMlY6aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYyoS2AAKCRCJcvTf3G3AJoxoEA CNWvotJduQ1+tj7cnZlwvQosnG4/aa+Tua7+dPMGebxam64/SsgNEoEDE+iYOFec1iIT+TWr8DmBMs EMbqXsh+5rZssPPBiIy/lKv6+nO58viHWBPTOrFOxjJezOdqzX5hdK95NTYC6eyawrsUC7KnHrfVyv 8uBqte82ZYL5hfRgO1u02u8C5Bf6vtyatkJ2a5nZLLcpnur5eQLS1TX6/TsVUqcbNF6RYURASxZYxq lNcTVV+DgbsaId76L8ljOwV7Dz08ykjlIWsJYinvKgJWtHh3Ya/FIg6Fg0wsSnoRpdKL2pEBS+mjw8 scvWa4vMb/CTqwBfYwJRi1l4lScrE/BeIUVBtCu+xcGpc+gp1l4FTKTxoTMk45DT0CXAWU9xxTqc6c gSsZV2A0ZaxVRmLjiXIVZBZyjq6GQ2v89cwHB25GBATaN7EksK82VcoD9hAPrZcOauqYKDNVOXZqcv PpO5iSx1rbRkKKc25kGoYIrCrM5qRXyBEQK/TJcmBLXtaqCGukGx0OBRVuBhi/+PKBc1unOPjp5s39 fBtan6hdZ+J2bxFNBlDxauaECtMUzhFuGY+UDK278LYJq5ucd/NRTst6+Tn32tg7T5c+nM37eKAa/C y46/iBV/2fCPGMCZHrv1f27M6fd0S4sj9JrAy2oCimhN5Gm+bmpFdDiS46lw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adjusts CONFIG_FORTIFY_SOURCE's coverage to include greater runtime
size checking from GCC and Clang's __builtin_dynamic_object_size(), which
the compilers can track either via code flow or from __alloc_size() hints.

Thanks,

-Kees

Kees Cook (4):
  x86/entry: Work around Clang __bdos() bug
  fortify: Explicitly check bounds are compile-time constants
  fortify: Convert to struct vs member helpers
  fortify: Use __builtin_dynamic_object_size() when available

 arch/x86/xen/enlighten_pv.c         |   3 +-
 drivers/misc/lkdtm/heap.c           |   1 +
 include/linux/compiler_attributes.h |   5 ++
 include/linux/fortify-string.h      | 125 ++++++++++++++++------------
 4 files changed, 81 insertions(+), 53 deletions(-)

-- 
2.34.1

