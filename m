Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A08B613E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJaTtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJaTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:49:06 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0913D6C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:49:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m6so11619934pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6AgIDxQuRAFQ/tU91FvvbPkOXFdK1i7OKUS4QLauwk=;
        b=qaWqNTVuKg37l/m/NyafX2IUDBwFtHm3CUfvTINS+7dRpsFyXvD1eZmr9+Jy7UViYk
         h4WcGK6roP3bbErjR6ssXtSrKBf3/fx4vIPv07BtmF8bD00xfckJu+dmWK438rGlP9Kd
         Fwq5foOevkAiZGwW3lt6DMkru+RFVN4JLQ8uE2svuzu0fDCILsDRy0g5kPWDyvfja08r
         oPcNU8BQ10FKWWur57J2FUw4+yBX6SsrF6vu1FkJpni3Q/RGQre8w7r9NqKpS41sVk1F
         FeaDGuqF/EXl5ZpIYRJLTvL3/BgMkoWVOZkBAW2MJmvqvISzhIJkibOEYGL/KXAMRPcy
         yLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6AgIDxQuRAFQ/tU91FvvbPkOXFdK1i7OKUS4QLauwk=;
        b=TExOm+HuTJgsZiNAT2HJSj+hWeU62aTcwTNE0XXW+Z4LzPFU9tIKvVxyEJ4TgyPVjg
         cF0DhjB5aGS9KQrHDpRlT4/wenDIoEH3mF1XUFqgdPz/KFHpfWZUvcTqA1MniULiP+uT
         bpK9/rrjORMBBTTqBReVvfQ58xcGDU9idwdEKq/7IYqmngxemvslpUV1XluhuMdHKy6z
         o7c8xuln9lRvhTcEgpstX4RMBkHmai6UsLEWUsVwBja8c4YNyZSFy9FsfrPVekkElX+u
         evpRLpj0Ycz8MLPL1Qc6h8j00wVW4kdt34josMQfYZqYtgu4SNV0K6gDCASKVYhSvaDX
         YZhg==
X-Gm-Message-State: ACrzQf2ljStJVLyU4DrqJDwi6Ytj4UeGgfeLiYLE34yT7OZm+VwqeRHK
        LZ9wUd9FZ5l0uYjP58bG3vY3YA==
X-Google-Smtp-Source: AMsMyM4OlJqDZkAznxVLJd48CDUG5btL1LdJ6izpa9/p30LOoqCzbzehrGUX+kcrqCOgDLYW/nXm9w==
X-Received: by 2002:a65:6849:0:b0:461:8779:2452 with SMTP id q9-20020a656849000000b0046187792452mr13707433pgt.383.1667245745143;
        Mon, 31 Oct 2022 12:49:05 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090a73c300b0020063e7d63asm4322330pjk.30.2022.10.31.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:49:04 -0700 (PDT)
Date:   Mon, 31 Oct 2022 19:49:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] KVM: selftests: Allowing running
 dirty_log_perf_test on specific CPUs
Message-ID: <Y2AmrZO0UtpU8EDu@google.com>
References: <20221031173819.1035684-1-vipinsh@google.com>
 <20221031173819.1035684-6-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031173819.1035684-6-vipinsh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022, Vipin Sharma wrote:
> Add a command line option, -c, to pin vCPUs to physical CPUs (pCPUs),
> i.e.  to force vCPUs to run on specific pCPUs.
> 
> Requirement to implement this feature came in discussion on the patch
> "Make page tables for eager page splitting NUMA aware"
> https://lore.kernel.org/lkml/YuhPT2drgqL+osLl@google.com/
> 
> This feature is useful as it provides a way to analyze performance based
> on the vCPUs and dirty log worker locations, like on the different NUMA
> nodes or on the same NUMA nodes.
> 
> To keep things simple, implementation is intentionally very limited,
> either all of the vCPUs will be pinned followed by an optional main
> thread or nothing will be pinned.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Suggested-by: David Matlack <dmatlack@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
