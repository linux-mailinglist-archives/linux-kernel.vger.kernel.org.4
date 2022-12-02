Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A248640BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiLBRJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiLBRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:09:18 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8ECE3697
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:09:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so4874359pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbEpNpUzseZTQupf42Rj1IKHfu3QLHpqGxrYsl/wNeI=;
        b=mI5cA7a7Sg4TXS0Q5VfJBHIQvZ1ELh7hKpc8t0/8ipN5qOI6hp/FHLxfcP/hVRDl7P
         uQyB/HYT89CTdt+HkzoUetTK9gKWusrqfNO79ltDCsyA23omDi8YKC3AmYlXhZlQxuAu
         /fEsFl8gLO0PEgvinbnVwi8rBO9Ba+PbMnoy/k8tK2glpCxr5G6SvJ4hJpMuWvPZpVH5
         E3VosW0P14YRG2cOzOzTYkSP/FAXH8pgRonht5k8KDdk6x7ljewzNaK9uMvCc2qXdgH4
         zFi3S0RkARbtcDqxxZLnk46HSHdSS8V7JBcWI+/tQFwsfSW1THHtNRdqNchAAYIFnQ7v
         IP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbEpNpUzseZTQupf42Rj1IKHfu3QLHpqGxrYsl/wNeI=;
        b=Jw6hTZP5mkIkTdtiUG+OWc3UqY4ZlNKXCgIaBVVZ55j2R7nCUAkC/rXq1xyZkDu7Fa
         DrrINkf4Rf0/7I7nVKvtZytiRY9MHrbhBL6EZgbc9voqrU0UUiOv+QYpqUYJ0GQrv6nv
         ZdEYNHALp1kl2ca9M66BiIAtazt3E2/cYCWFCdeRkFnwMyKQg4+36idl1nz9uTOIFvfs
         kml0/+R2iH2LndDUKkePXi+f95ECKniXXFUowpiTGUJT993j2fl4nJgQaz+jSjn2A3sW
         /T5uUGbOMGkG7MkNNvlBlUD3pAchkqSiZyymxOnFvElpHG2thxsuT3oQUT6DK0ck5CCR
         gd6g==
X-Gm-Message-State: ANoB5pl3kHHyXjXy0/l6qrw5iSQdbKhKhYC9rSTV9cKGkuKcRT5J4Qfi
        ibAFH0jMYQGuqSfGZyrXpC1mig==
X-Google-Smtp-Source: AA0mqf4kl0zvfaDO4FTtGaa5lHreKmD7cstYdlvhz+MAO6zO8v0H85mFV60iIiabONC9Ox4WnKDcAA==
X-Received: by 2002:a63:ed0b:0:b0:477:9319:eb4f with SMTP id d11-20020a63ed0b000000b004779319eb4fmr47408147pgi.257.1670000953165;
        Fri, 02 Dec 2022 09:09:13 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b0018853416bbcsm5879737plg.7.2022.12.02.09.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:09:12 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:09:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC  8/9] RISC-V: KVM: Implement perf support
Message-ID: <Y4oxNbQwOldICdnw@google.com>
References: <20220718170205.2972215-1-atishp@rivosinc.com>
 <20220718170205.2972215-9-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718170205.2972215-9-atishp@rivosinc.com>
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

On Mon, Jul 18, 2022, Atish Patra wrote:
> RISC-V SBI PMU & Sscofpmf ISA extension allows supporting perf in
> the virtualization enviornment as well. KVM implementation
> relies on SBI PMU extension for most of the part while traps
> & emulates the CSRs read for counter access.

For the benefit of non-RISCV people, the changelog (and documentation?) should
explain why RISC-V doesn't need to tap into kvm_register_perf_callbacks().
Presumably there's something in the "RISC-V SBI PMU & Sscofpmf ISA extension" spec
that allows hardware to differentiate between events that are for guest vs. host?
