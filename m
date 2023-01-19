Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF46743D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjASU6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjASU4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:56:23 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924A4955F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:55:42 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id f22-20020a056a00239600b0058d956679f5so1430888pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr5Q2q0Ve+Pe7+jty2F9WP7IXPdPCiaONGdC3SEcJCc=;
        b=JkxQZ/LVH/doRkTNSUgHIzqJaOyeOz+COgABHjmdN+WH4SnXL/nz5hbWj/VKwNNVZG
         kGbCjEn58I77K4yGndK8XJo+LUpRbqCdBfOvfrKmDnWOYl689/kkl/sBwR7RNEbd3d3f
         EQg/RX4IBBeZ3cbCX9pkToCuZ5RlWKsCE9IScqQ3J4/WZ1d2Hf2QM357nZgZkuW8KOfB
         drFIDkUY2qRqJYR6OxBeXevkWOhW+suw3TVJnOLzWlgDSiMezXr/Foo5290cKicj1Otm
         Yz3JNSvapNwD/hRyLxftb0bFts2Qxjfr+kd+N+7MaTSv+95X8urL0Bv81c+y0RDk8ywA
         33TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr5Q2q0Ve+Pe7+jty2F9WP7IXPdPCiaONGdC3SEcJCc=;
        b=ezgKollH2RMQ53lsyQY/v6XzntrnwLKMYHcvaI/julYtVAE41fr64b1cZhD16s7Hh0
         Bi9wk54Zopbdcp/ei9TfnI34oRAI2FnLHBLZ3yQZMRwfVttpiyLiHuvshVMTll1IAk3R
         9kIgvA6hvINGLiUsyjXHLLC7pN1rOaT4DDpwdMmmQj5xNa3GO9M5GtuIJE6VCGipakUK
         7g3uLOIUo6SuSGQnBs/qWZVdS42gh0e0F4ZhEz4su2dtU9W1WqAI+LyOQIHfTMLpeIIt
         IPXcQH9ZrHHYTgahkQQ3d0+NemiAH7+d0CsQna/e+SS5E/72Zt2BX9rZdxB65IeDSzr4
         2Bqg==
X-Gm-Message-State: AFqh2koTRGN8EfDw05XJBTPnYGKD47pan7dE/nlg8vvnMcvFqhgk1agy
        BWMbwIAoJMISf9RDbwIBfv4q2ZJMMKI=
X-Google-Smtp-Source: AMrXdXsuBbPBjEznnLSHkdPQBP68LTshyCgo7rSUXG1m6MFFIQwwWFDTODCN2vx+gGO4Jg5ebGIcn9UOVlQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:414c:b0:229:9369:e62a with SMTP id
 m12-20020a17090a414c00b002299369e62amr1532308pjg.231.1674161741551; Thu, 19
 Jan 2023 12:55:41 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:54:04 +0000
In-Reply-To: <20230105100310.6700-1-jiangshanlai@gmail.com>
Mime-Version: 1.0
References: <20230105100310.6700-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167408804666.2363885.5695334430262199072.b4-ty@google.com>
Subject: Re: [PATCH] kvm: x86/mmu: Don't clear write flooding for direct SP
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023 18:03:10 +0800, Lai Jiangshan wrote:
> Although there is no harm, but there is no point to clear write
> flooding for direct SP.
> 
> 

Applied to kvm-x86 mmu, thanks!

[1/1] kvm: x86/mmu: Don't clear write flooding for direct SP
      https://github.com/kvm-x86/linux/commit/5ee0c3718540

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
