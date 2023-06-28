Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47D741BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF1WIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjF1WIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:08:44 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840692110
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 15:08:43 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5428d1915acso17445a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687990123; x=1690582123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWsQ+Zk7IjWGrlut4U5SpkgMPsmLAFUMniA+6zN69Ac=;
        b=uTE1vo4MY53qGUepRvI/eb4jxvbxYUEOkPTTvvoD4kGkMDRhRLsKzlGL+vQLMjhKRi
         rdeWPPHm+L2E8twFBAHl+ZoEMemoTY5PNpYWB+f1xGrPZGZ2la2YZiTaJab5HHqd1wGu
         e8TDq18vFJWMtrUvtcJUxqp4yTMOBToJdy/ugfjzlaSzjWeyDaxn9ot07hn/Pbz02y9X
         nLv8szoIVmDzsQGyNi1/NfgnmXBsbr3QltbMozbVHuKXTSLvqZ+0gEau2/8RUWMqkcYj
         zbwadNSttgKKZPrqDNVQfevrq9jnrko7CL5qNbCNLrVhTgwrR3NdAPk4RY/cPRIrFlwf
         sAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687990123; x=1690582123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWsQ+Zk7IjWGrlut4U5SpkgMPsmLAFUMniA+6zN69Ac=;
        b=D3hd5meVLeVkj4Qwu9abIkzO+m582CurRw/HtRyh3pIRM3gPTDGTaAgzeVRwyBc0dI
         2agK1AODnItbTsiqVOzsq/b+JgwYIUxSxkCtTKt0c+H3iNMq0bnTrDDl3im+7Y/cAq86
         +X/8KMUPDavQpb1pPhughBFcsa0fHsLjan+q7PYNKh4Ow4cDt3pCxQKhTa0zHaFMvvFG
         Nb2zjAibcndpbUDYGm2mgcohNWnCY+be1Sw1FtWHguYQl5qv27p+6leYiGXqEm395P6r
         BoumxboZiWe5LvgqIYq4Ul0xQWywT5zxnXgE6HrQEAxhFyidlJbw09sE/SXlBDXRG3rD
         XtCA==
X-Gm-Message-State: AC+VfDxFXNCWcggR6bek0JsA19cj6Y6rRJXxB4/bdWZZu2r69u0igA80
        X9/cABkPpKC5hyG/bjv6Xu0KUIWg69M=
X-Google-Smtp-Source: ACHHUZ7HOmJsurSrMF65FGkboY/aMr53gf5wL8po/HLlsjcs/5jxbF2RqSFGM05DvnggoK1dwXSa0P2+iKM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:cd09:0:b0:553:8437:3db3 with SMTP id
 i9-20020a63cd09000000b0055384373db3mr490412pgg.3.1687990122897; Wed, 28 Jun
 2023 15:08:42 -0700 (PDT)
Date:   Wed, 28 Jun 2023 15:08:41 -0700
In-Reply-To: <20230616023614.7261-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230616023101.7019-1-yan.y.zhao@intel.com> <20230616023614.7261-1-yan.y.zhao@intel.com>
Message-ID: <ZJyvaVVyxPmhvYph@google.com>
Subject: Re: [PATCH v3 04/11] KVM: x86/mmu: Use KVM honors guest MTRRs helper
 when update mtrr
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        robert.hoo.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Yan Zhao wrote:
> Call helper to check if guest MTRRs are honored by KVM MMU before
> calculation and zapping.

Same comment here about stating the effect, not the literal code change.

> Guest MTRRs only affect TDP memtypes when TDP honors guest MTRRs, there's
> no meaning to do the calculation and zapping otherwise.
