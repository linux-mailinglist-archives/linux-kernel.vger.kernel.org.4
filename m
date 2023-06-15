Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8101A731E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjFOQpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjFOQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:44:49 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E2A30E7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:33 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3111547c8f9so837102f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847472; x=1689439472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Egc4fmm7smvfOFVQ5s3mS2mzKk6KiuOWVMSMxPPdik=;
        b=VpXK5YNXS/HtX+hVmjlJhE8f5WiWEsHho/TjZuL1Joqxv/i5Oesln8761YBsGu6pw9
         Z/HvRtryCldkj8L9em3gyoTosLU+3XiKceQbt3bgfjDkzFb7PJzewe7+zQUsu+fU/Uul
         Nvjie7ZdurubDMNygzgWlszSM9wTgVfWGiMuINKbiXZ7sDbC/jaOQW5IEk86RPCA8pYv
         cqZMENuL9/hAV28bfTIuZArVWLiixOo1pm6qiStJNAJTYeNYNN9g+tjAE5M1Gxa7QdZY
         Yq0BRbzAMshi7UWL964mV2+0/07wg+0TK5YHKF3Szhv4Hnhv9DopENutwN3Nsy3o+rGz
         fzVg==
X-Gm-Message-State: AC+VfDwack0fWX5w282iUKWGrNvXSHErT6fRE+ia0NJ508Dq+cQXk4my
        nzbtKtIPOzZ/UyjPEm3P5WI=
X-Google-Smtp-Source: ACHHUZ6zhzYN6oAaFFfvbT3Be6zWySwMH+fDayw3K3IJRZC489llcfGrPebhYUtFhg6qnFKS2qYeDw==
X-Received: by 2002:a05:6000:1b0c:b0:311:1a9a:90e4 with SMTP id f12-20020a0560001b0c00b003111a9a90e4mr841266wrz.57.1686847472206;
        Thu, 15 Jun 2023 09:44:32 -0700 (PDT)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm21515912wrv.108.2023.06.15.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:44:31 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de
Cc:     leit@fb.com, hpa@zytor.com, x86@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/bugs: Break down mitigations configurations
Date:   Thu, 15 Jun 2023 09:44:15 -0700
Message-Id: <20230615164417.3588162-5-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615164417.3588162-1-leitao@debian.org>
References: <20230615164417.3588162-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to compile a kernel today with some of the speculative
mitigations disabled. Even if the kernel has
CONFIG_SPECULATION_MITIGATIONS=n, some Intel mitigations, such as MDS, TAA,
MMIO are still enabled and can only be disabled using a kernel parameter.

This patchset creates a way to choose what to enable or disable, and,
get the mitigations disable if CONFIG_SPECULATION_MITIGATIONS is not
set, as the rest of other mitigations.

Also, we want to print a warning message letting users know that these
mitigations are disabled.

Breno Leitao (2):
  x86/speculation: Disable mitigations if CONFIG says so
  x86/speculation: Print error when mitigations are disabled

 arch/x86/kernel/cpu/bugs.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

-- 
2.34.1

