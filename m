Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5771F7D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjFBBZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjFBBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:25:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020681A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:25:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-258b62c7a6bso1193220a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685669142; x=1688261142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNwsGgw7ySQdxjes7tCjQhCwzQRSlKbr2bG197tBqGI=;
        b=k+uKy4F+9e7EWxKo5qW/+3AYcM1MFqiwRebIg5kVwmbc7Af0HdouAwMxAnjD7GHZhG
         qs8I/xgtnO1yiDtiFaU+mN1JCiAiyUGCn6tfFcrLlUUZIO5y5uRif7uk9/lamINiEXei
         7+PJwTQdeR61RaIoEb5CGteLzcUOt8xjYxNzy04r5KFW4/XMAzRKGdlgDI5WUSMKNeh7
         N87YMTvvpWGSBwqjtukCwPWmyCD1uBbCK1NZcQTy6/HSxv0zs/+GjuOMJuHYbjBGdWEl
         uM1xCt8oqRPFxATHEPa8kaNiW4kHOi1riDbkDAVO0DhSBtFkaDXWqnZRMsHXnANeXAJH
         pF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685669142; x=1688261142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNwsGgw7ySQdxjes7tCjQhCwzQRSlKbr2bG197tBqGI=;
        b=Ae7eaTHPfuSMB/50CCVNQ2dVgsWemRtWHL4yC0kBMGe3S1/kNnc8evFerAdoyforTd
         VWPhwK7bPKHkVgRtuzWP76Cka/Hp+3rPnPbpY7w4+rq3+L/gNPXKTvyQLvEdXRhXQgs8
         D+xglkBnIuGTZ8XuQNiu/a+VU6FelsC8sHw6TeFxtmZ0FFWGzPzTOOSvfiKXXnq5XewV
         lRNyPdjLEPT4EYd9VA+0bCyLdxNvGVka4U24v6783qUBJtnMsMTuzu0psf1KtaF4yaED
         saOPF3zCSfu8jgkdv7crlSZTyLp1nEvcdzDqgphF0zsORZ7DtZHRfRsLIGMYUAB9IeF0
         9HQA==
X-Gm-Message-State: AC+VfDx0/jXQgK6GUQNnghpenh36f7cSbZA2Mv6uFw/vIr/q8YB7KjEl
        Dhd9j6DiyuOZUBY5qeOaXp+C1UkBSt8=
X-Google-Smtp-Source: ACHHUZ795BvQa3kQvzfr2T88kbf/BqKWtO2hl8CWGJSP7wFHlro6elVUB5m/Q2jVG6S9JbydmPorQcgMMbw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e693:b0:256:3fcb:616c with SMTP id
 s19-20020a17090ae69300b002563fcb616cmr223324pjy.1.1685669142484; Thu, 01 Jun
 2023 18:25:42 -0700 (PDT)
Date:   Thu,  1 Jun 2023 18:23:40 -0700
In-Reply-To: <20230406001724.706668-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230406001724.706668-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168512532900.2750329.14930937967401138045.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Refactor stable TSC check to use TEST_REQUIRE()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Ge <gehao@kylinos.cn>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 17:17:24 -0700, Sean Christopherson wrote:
> Refactor the nested TSC scaling test's check on a stable system TSC to
> use TEST_REQUIRE() to do the heavy lifting when the system doesn't have
> a stable TSC.  Using a helper+TEST_REQUIRE() eliminates the need for
> gotos and a custom message.
> 
> 

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Refactor stable TSC check to use TEST_REQUIRE()
      https://github.com/kvm-x86/linux/commit/5efde6d73d58

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
