Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09F463B517
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiK1W7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiK1W7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:59:05 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9941D2F01D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:58:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z17so7168885pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+By6HFUUEwUgnjL5kXpV1830a0YqTs0ZVljGp7cOJQ=;
        b=el41oB3BXH/tgxJVskjVyKSNwBLVjF1y0fQdlKBRchmPG6fnHN4amDJwqWG1B9uFnP
         FHlv/IF/BS8HURNI6rK5h3k47an88/5JO1rM80rBFPTbvif23N4sjK9WOPgSq8x6hSfm
         YmwcOwbbfhszFcttK4pGpWcPwftwS8AWihv9cGokzXSJkRPb65lzuOwDQ2jyqy8GVTd0
         65evjFx5i3NKAtQiFe+gWjJ4sPx4s6zEpU72O6SC0CiQfBDQ8ZFiV1enK10Eg7tD/6PK
         8wC4/thSBKwORmQD2k9J+8BUKxIVsePuFf6/Q447D5TaJe91eEHei/kxXeF/AnTJ5fmq
         CIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+By6HFUUEwUgnjL5kXpV1830a0YqTs0ZVljGp7cOJQ=;
        b=4BAsBkmcynJFqhmcfHwEXgWCjLe9q2OqM13zhtJXMObNp42albnVsmnGtnZ4Q1qFzq
         S+Hb8fv3EYYOsBu3cKjJxeXwt0BcJJ5LLkv9BerRS7BaIHKLJDa3x6MLi/yqvwDOiH+q
         nbAkMLNHofcaB0XdM876dXvCYo5tmdfDrAmpJjOZ/wjnIVTdXct5ONhc950x2w65x3yG
         iQFdR25h1LGMBaPLR+dzi+yHcntFhclEaLB1DhXTKiy8zM0l6Iu2ZdD5Bv/duMRSduXH
         7a/PadAWxvKvAOPdSvAkGgGCggNO3yaMNNrllXK/cb/4G/bTE69w1SvE1AVMefg04Rv6
         6qew==
X-Gm-Message-State: ANoB5pkcfIeeqxblToGbzF7MKnoz7s+A+1R8URK7Eynb80Idikxw+KIk
        hsEKdMmRWJpUG271YHYCZcljoQ==
X-Google-Smtp-Source: AA0mqf6OzYufTB/nmTdNbu7FYDOjkXrxqlRZBZ5kt/SmtnHWph37DNttW81hBX1L/qjneFif8XIMXw==
X-Received: by 2002:aa7:91c9:0:b0:56d:8e07:4626 with SMTP id z9-20020aa791c9000000b0056d8e074626mr55464096pfa.70.1669676333026;
        Mon, 28 Nov 2022 14:58:53 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b00189217ba6ffsm9380220plk.38.2022.11.28.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 14:58:52 -0800 (PST)
Date:   Mon, 28 Nov 2022 22:58:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KVM: x86/mmu: fix an incorrect comment in
 kvm_mmu_new_pgd()
Message-ID: <Y4U9KaI9zv6bsbPQ@google.com>
References: <20221128214709.224710-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128214709.224710-1-wei.liu@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022, Wei Liu wrote:
> There is no function named kvm_mmu_ensure_valid_pgd().
> 
> Fix the comment and remove the pair of braces to conform to Linux kernel
> coding style.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
