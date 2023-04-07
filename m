Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8DC6DB5CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjDGVaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 17:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:30:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BB4BDC2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 14:30:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54bfe7a161eso80087047b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680903014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYPq8AwRA75JijczTkRxvHK/tBvZRTY57s49oX1Ykp8=;
        b=JjSKyK0ghI+n2n6WkYs7pBEEv8CzmM+vM2buKnh+R5NxM7drEiKARST7GbiMEgE314
         l6ZC/Zqj4HzHf5Il2W/nNyTBA4ycRyQmKIK9+qs87IBAE0xhJBbqaATnMjPw8j3y7wlF
         7Lbpm421K4NIqVP3uBBNmehy2TCppOgM0yIzvbYcm15KGrrBRhHu0xyW1Sn4ou7GGE7w
         OqrlvIdJpkXifjBnnAr+h1BHTbJ1CMTzNOaclraIv5vjT1mEV8I2ickin3JdpvbweJ0v
         veZjR6qA9Le6HA7A7Yb/iadrQtgCJfLW4hb5Y0NsgNkWgbpgKGgflRaRPzMAhKyTFAIH
         d4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680903014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYPq8AwRA75JijczTkRxvHK/tBvZRTY57s49oX1Ykp8=;
        b=q9ci3E6Q/JEE8uaE1t4T9nPVvXk4U5DVlDkMXXvX6UmoC47QLTrHmrPVVWzFCh8OVt
         vmZKcbB09F39KhGSAzM9fxxLg9fKgJxacQzj+x8bccCmtxMBFE3TJO07wXiY8EOptpKu
         wSf76O+nVh7VeIhd07VEBcv6oeer980JXyaRXqrZnFml+3tjrtT5okcOwNT1L8md2fbF
         nYkxdoqEEenqr4jzXrqSHDFIzCBgjNGCTD0gxyC5Sx+1QAorIfTz85zQ+/18dG7uRJtS
         gg2VQ/sSeCe8xqrYfGMMlwdV02e/wlFuOscxtWvYGQaRr1kx9eDxDy3MUtHW9znMRV1Q
         xSFw==
X-Gm-Message-State: AAQBX9eY5Nr50Wzo0WYqbFkuu5k7XwXyvdKlwm9rTkIZmeY61xq8bpPi
        Clz56ehxKMGl8sA7h3txqAfZudDj8KY=
X-Google-Smtp-Source: AKy350bf+tpG54R4vH4SX+ilY39rfLPWmhUntcHYl3m11DWx9xyhqhzc5f9mglEiIxcO+L/1cxDUiRXEe4E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cad1:0:b0:b78:4788:525b with SMTP id
 a200-20020a25cad1000000b00b784788525bmr2581462ybg.0.1680903014011; Fri, 07
 Apr 2023 14:30:14 -0700 (PDT)
Date:   Fri,  7 Apr 2023 14:30:06 -0700
In-Reply-To: <20230310113349.31799-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230310113349.31799-1-likexu@tencent.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <168090262913.941979.18246241626899412092.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/pmu/misc: Fix a typo on kvm_pmu_request_counter_reprogam()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 19:33:49 +0800, Like Xu wrote:
> Fix a "reprogam" typo in the kvm_pmu_request_counter_reprogam(), which
> should be fixed earlier to follow the meaning of {pmc_}reprogram_counter().

Applied to kvm-x86 pmu, thanks!

[1/1] KVM: x86/pmu/misc: Fix a typo on kvm_pmu_request_counter_reprogam()
      https://github.com/kvm-x86/linux/commit/4fa5843d81fd

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
