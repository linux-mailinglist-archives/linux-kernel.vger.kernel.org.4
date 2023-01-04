Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A165DCC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbjADTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbjADTcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:32:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4571B9D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:32:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jl4so30593511plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVBxTrv33g7zA+mp/bk4MeyN9FwQs/cg8GQ0ilVTcRI=;
        b=LI5zELm1XpQH6dCk60dK+sPGbl3bQ89h//gIXHC0GiFRRWfZHrGBURnB36vjQEz3hr
         8pKrHZSoUcvLnkfg0nyVvV5Hi23ZXAFcGrKAx4/nxl3CjQLVC8CKOquDduzxNwRNOIpz
         tJiGMT50xcgj+3+zKVGcRyMmcNZjyLylGqXqlWwG8Dwvd0UWE33mkCuuIIl3VXDkb8jm
         x+hiQ5CCu3RCJvuZINAJ2vAInshJv3lD7CCYS8uss6sJJOn2NyzDyQRJmXP5aZxa0YAC
         fofkXAJ/Iy78FjVJG065KuTe9RecR6tiVUABb4pyeGAYC8+rfPgDkeadPTHbFdt6xQiN
         G3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVBxTrv33g7zA+mp/bk4MeyN9FwQs/cg8GQ0ilVTcRI=;
        b=KAgGw1GuvBWch1t89iGhsCv9cGyqYYhWcWGfellGBWpPCdp3TPCsKH9RoYQyd3p8bh
         eCx/KPXTC3UYI9BfajnaD+rkJkzIpt/w+R13RB3B6MUdREaS5HgTgEjyI2Z0yPwLTA7r
         9SNDXkq7vXivnsvjiEPLLvfK/0uL4uJOiKmCFSDKA+N+wlK6KEhGrnm68ZU+CHBIvCG0
         uZ38q5XypWbhTnBeMpRJVDZOdX8GQQV4vJKEn8N9DtWIQd4+0GZALwLtLQiN9fmVwQ4y
         iXjfHYnD5ccjewccww1W8wkIxJt1x6iWeQoFscy4mdsZPNIS157jx2AohQGaZiK+J0Fy
         KDUg==
X-Gm-Message-State: AFqh2kqw3WfOXI514FBMVRMd7IueF/xNnmkrHjtMV05MjzIrq5a98CC2
        AtWM4pW18a+epUiYecv53xcjCUHX3ttFtgJZ
X-Google-Smtp-Source: AMrXdXuIquzqlAclremPdleyURzIFQq81yNkoc/XaQ2yJ29Yfu4cpc6KG0H9snhENw/xbZOKm3igrQ==
X-Received: by 2002:a17:902:a582:b0:192:52d7:b574 with SMTP id az2-20020a170902a58200b0019252d7b574mr45464299plb.63.1672860769580;
        Wed, 04 Jan 2023 11:32:49 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b00186b3c3e2dasm24573885plh.155.2023.01.04.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:32:48 -0800 (PST)
Date:   Wed, 4 Jan 2023 11:32:44 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com
Subject: Re: [V4 PATCH 0/4] Execute hypercalls according to host cpu
Message-ID: <Y7XUXMVoj0jb8utz@google.com>
References: <20221228192438.2835203-1-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228192438.2835203-1-vannapurve@google.com>
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

On Wed, Dec 28, 2022 at 07:24:34PM +0000, Vishal Annapurve wrote:
> Confidential VMs(CVMs) need to execute hypercall instruction as per the CPU
> type. Normally KVM emulates the vmcall/vmmcall instruction by patching
> the guest code at runtime. Such a guest memory manipulation by KVM is
> not allowed with CVMs and is also undesirable in general.
> 
> This series adds support of executing hypercall as per the host cpu
> type queried using cpuid instruction. CPU vendor type is stored early
> during selftest setup and guest setup to be reused later.
> 
> Changes in v4:
> 1) Incoporated suggestions from Sean -
>   * Added APIs to query host cpu type
>   * Shared the host cpu type with guests to avoid querying the cpu type
>     again
>   * Modified kvm_hypercall to execute vmcall/vmmcall according to host
>     cpu type.
> 2) Dropped the separate API for kvm_hypercall.
> 
> v3:
> https://lore.kernel.org/lkml/20221222230458.3828342-1-vannapurve@google.com/
> 
> Vishal Annapurve (4):
>   KVM: selftests: x86: use this_cpu_* helpers
>   KVM: selftests: x86: Add variables to store cpu type
>   KVM: sefltests: x86: Replace is_*cpu with is_host_*cpu
>   KVM: selftests: x86: Invoke kvm hypercall as per host cpu

For the series,

Reviewed-by: David Matlack <dmatlack@google.com>
