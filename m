Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E127401E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjF0RIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjF0RIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:08:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB0198C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:08:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d1b86a64so51708537b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687885721; x=1690477721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmTYBHiq1aAEhFeB5lbw1u0SmbjoMvuQpM4GCZ6yf38=;
        b=IVA1fW9z3fvV2citHCS4ShP8SJ355AticUoDo8b4hCd7KVDGS3NOP0gYlyt4iz5YTS
         HAki00VvRLmzk1A388nL1Pqw2E6th3LdFtMjILyxEZmr6mdFs80Vlq4cbYPVMVjSULq9
         OguibegXP3fdCKzrispjaCvcaiHsItetv3OaZKsfWM4B3krqFqOCDKXyaU5FtaHoUa54
         lhfjc5h563F0SoDc6Y9XXlljkNAANgnzNQQElnZrKXuCxNX5naT2+Y041W0YBSdPOBmS
         EIOddBn7CiOslBCcl+66cqhgqclSDddd2PKx6mBJdkjOGd/lQ6yVYUwgjexWDhQ5WfHU
         Wr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885721; x=1690477721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmTYBHiq1aAEhFeB5lbw1u0SmbjoMvuQpM4GCZ6yf38=;
        b=k6bnmhdoBg1lpmdeeZ5PNkOMHYj/5ZBT+Zi9xlF1WEju/N+5P1WKDM9YC2OWyQ1sei
         5onJRfhN664j47+/10g7d+gytb7Y55mmqO1/HAE4MQkDNh93JA2CQMDrAVZrlOODqndm
         mHzlYLjIcR98yzqSj/fDXa0PiUJsuwaMNj9xnpE6+mWeT17Qo+DMF2E++LZ4u4xBzY4Z
         QXzbRnpl0kaHqhKBGTmwHHXgVDeHrWaAdO30NEVd9Lx4cb5Wi9Dhc9oTsjOUCGjqf/Dq
         NKOIKg5HGA97eimTeJBPaaxIxnJlvGHBfIRR1qHF5Ae4RJeUkS4DIrSlRmbdmAKGGqeG
         dLqg==
X-Gm-Message-State: AC+VfDx2566QRlB91cK6WVWBZ0U1aLxbo97QvYeg7nx0f1tOKVARhgyo
        kLQarWHudmisb2YMtyuY5uG7cszVjm0=
X-Google-Smtp-Source: ACHHUZ4x/kmMRFuVDQPoWm9oePlEoaxawv+Tl+xLy1w6ikaFM/ufb1HKrZ3JhOLWb11Z/yZ7OXbmMpfiMmA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4046:0:b0:55d:d5b1:c2bd with SMTP id
 m6-20020a814046000000b0055dd5b1c2bdmr10445571ywn.8.1687885720828; Tue, 27 Jun
 2023 10:08:40 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:08:39 -0700
In-Reply-To: <20230601142309.6307-1-guang.zeng@intel.com>
Mime-Version: 1.0
References: <20230601142309.6307-1-guang.zeng@intel.com>
Message-ID: <ZJsXl6emfV2yr4rs@google.com>
Subject: Re: [PATCH v1 0/6] LASS KVM virtualization support
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        H Peter Anvin <hpa@zytor.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023, Zeng Guang wrote:
> This patch series provide a LASS KVM solution.

... and depends on kernel enabling that can be found at

https://lore.kernel.org/all/20230609183632.48706-1-alexander.shishkin@linux.intel.com

> We tested the basic function of LASS virtualization including LASS
> enumeration and enabling in non-root and nested environment. As KVM
> unittest framework is not compatible to LASS rule, we use kernel module
> and application test to emulate LASS violation instead. With KVM forced
> emulation mechanism, we also verified the LASS functionality on some
> emulation path with instruction fetch and data access to have same
> behavior as hardware.
> 
> [1] Intel ISE https://cdrdv2.intel.com/v1/dl/getContent/671368
> Chapter Linear Address Space Separation (LASS)
