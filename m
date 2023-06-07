Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F9725143
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 02:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbjFGAzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 20:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjFGAy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 20:54:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA742170D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 17:54:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569fee67d9dso2221437b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686099297; x=1688691297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JXuPOLvrVg9/ksu6Mrrqfogv4kOQAht/SYRJa//Rr0=;
        b=Op0Pthgyxp87IhRuxWauKzySxGWWBhArFXPrQ8NKc2gA9FwHTRDArNPyIWmhQ3MztH
         tyYj+T0csfvejiks6cXJ30V9Et83VN1FBekCDFC7OSk+E/RyZFyAT7jPE1ijZlKqqR0Q
         q9CwMwMTjYputBZWNTqfE4H+lr7yTJCxaCMjkKEc+O5NuVNTai6xFZI5d1vOZmeRjiU2
         YA1M+XmyneGWARP3gwQdQ2aVBKWxdb/9JtomlEzGY95wXl2lbPXa8bROKvMpkXIFXFt2
         cAOQlPc5raVHKv7BPCbofWqgNBE8eSrv1enP3Sc0fIa12D94uv6rH5TKtE0AHhwr8q8m
         Hfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686099297; x=1688691297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JXuPOLvrVg9/ksu6Mrrqfogv4kOQAht/SYRJa//Rr0=;
        b=el71qPVXbwsZmGg85uB0FqPP3/89pGGju/7PyXwlOOfC52eWNkscC1DeDh+lDzPJgH
         kIosQpMghuxd+ZAUgf7QWGZCOXnOjfQfei91oOPRJEnF61vMn72qxZunuNbtCQsFGXQR
         zrygaJJcaeKavQal3l9apiSmchIGlcIzUQTwjn+2twoxXeRaL3w/skv5MmEoOM1wcriT
         CNNz0fXvlpstcfLybuA1tmSNwnjIhnl7/zxsXYV860fLGwLinzH6epBTlYyGGeYxF5qD
         K3F5FZ3azKEqWPmX+HfzgnjgSwe79/RhhZtUuQNUUHXuT3Vvzu2WVSXtkDWog+1Piq3/
         QgJQ==
X-Gm-Message-State: AC+VfDxItktqVtLvWCOVkzSrE24V+p5ewrx4s0qcBp41RLbRkNNDLjQs
        WPtFLhAWHY1c3WEzdHFXnpSSP9VJiVc=
X-Google-Smtp-Source: ACHHUZ5jlBs1POQKngX/PYCp0EblPlBRAXZfRu9mwOLPLiQpRYYQT7AMDcl6WhSgILliK29VWwZnYvu1U/o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:1994:0:b0:565:8b2e:b324 with SMTP id
 142-20020a811994000000b005658b2eb324mr7477940ywz.3.1686099297042; Tue, 06 Jun
 2023 17:54:57 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:54:07 -0700
In-Reply-To: <20230607001226.1398889-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230607001226.1398889-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <168609780581.1416323.11712101389299064130.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Allow specify physical cpu list in
 demand paging test
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2023 17:12:26 -0700, Sean Christopherson wrote:
> Mimic the dirty log test and allow the user to pin demand paging test
> tasks to physical CPUs.
> 
> Put the help message into a general helper as suggested by Sean.
> 
> 

Somewhat speculatively applied to kvm-x86 selftests, as I'm OOO later this week
and want to get this into linux-next before I go offline.  Holler if you don't
like the end result.

Thanks!

[1/1] KVM: selftests: Allow specify physical cpu list in demand paging test
      https://github.com/kvm-x86/linux/commit/d4ec586c60ab

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
