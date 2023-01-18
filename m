Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE176670E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjAQXys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjAQXy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:54:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4DF279B8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:06:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s3so9130398edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34NRbc6Rn5Hl13DlQK5hbHVd7yokEN6LIZjVZYLB8G8=;
        b=mOosTStJClf1s+/aMHv4S9eSJthVfst5f0cCzLOs1zteP8KNfa71CF91fExyu7VZ97
         xSm0YCQlKvZnF3zYP8GSxnl8E+kVDjs1ja+TgYK9xk+fStA1q97MHIQf+gw4UW0F0+yZ
         OVgaZH+yNXuXUWq9swdoOXdxPHPzbDbbLBJlrhycbusqjUHZm2gbbwRmYJVOAasR1i+1
         9i/8U0igntuW//mMuCx4ExS6UnuJ5+7rX3aqk84HnNSPBVixf4WeqTX8C6mOSUNKO+vS
         yGMZgpaLF7ewxO5tmaI4I3CalehZhVUPA414tyTk1QYqDZRfZ/834dIrY1A1gR8OkeVn
         8ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34NRbc6Rn5Hl13DlQK5hbHVd7yokEN6LIZjVZYLB8G8=;
        b=iPam0TiHpCY9PQnhWd3ThygoEGIFCj2vt8O3rkuN5QI3b18uvq5WGH/PEDWHXE9OG1
         8ugoJMqDRzfmqtntn8c8E6KIZycLXSmHnxlEdlOhgINZK2Fd3R4MfodKopw2HxM426tj
         oxXgWTDPp1as1sZEh/xVE3xwujTbhHjaD2nSedXkjQa6PMBjDUNFdplOOS0MIywoFJnY
         W+QOqGmVzQ3/M0h+GisKxD4zoveaEdWR5eqOrJCiOshxnJe1J042XltoDHHfd0aHKW5t
         YnYR/19XxEFCzSRmts9yeTT4I4/3pfPDZ+pab1GhFzCPxuxCjQyFq9AF9DVfWsoET0Pl
         N6XA==
X-Gm-Message-State: AFqh2kqlHEQ6JUkk2OVPTY4sfgyXFEutfswHPKb1mD8BmRLFcp2n0xXJ
        WfTVSqaHHuxQ+qPE25oqQ25IgAf/HUJktAs9+SnT2g==
X-Google-Smtp-Source: AMrXdXuD8XDTRfhe8VdadVUHbu5H49U/f3QNMGiza2JXIZMnTQHUeeLXRJYvdz8Z6t4UwnRQmicWSGwLne3BbvoTf/E=
X-Received: by 2002:aa7:da51:0:b0:49e:4936:bbd8 with SMTP id
 w17-20020aa7da51000000b0049e4936bbd8mr34172eds.410.1673996817849; Tue, 17 Jan
 2023 15:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-4-vannapurve@google.com> <Y8cXvS2gKcK8tU2D@google.com>
In-Reply-To: <Y8cXvS2gKcK8tU2D@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 17 Jan 2023 15:06:44 -0800
Message-ID: <CAGtprH-xN_mSrsJtf4FAKM7xtCoz7XPZvsxdoj_N9XEL__QSkA@mail.gmail.com>
Subject: Re: [V2 PATCH 3/6] KVM: selftests: x86: Add IS_ALIGNED/IS_PAGE_ALIGNED
 helpers
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jan 17, 2023 at 1:48 PM Sean Christopherson <seanjc@google.com> wrote:
> ...
> I certainly don't object to adding IS_PAGE_ALIGNED(), but it's not needed for
> this series.  Verifying that KVM doesn't allow an unaligned page conversion during
> KVM_HC_MAP_GPA_RANGE belongs in a separate test+series, as that doesn't have a
> strict dependency on UPM.
>
> TL;DR: this patch can be dropped, for now at least.
>

Makes sense.

> >  #define HUGEPAGE_SHIFT(x)    (PAGE_SHIFT + (((x) - 1) * 9))
> >  #define HUGEPAGE_SIZE(x)     (1UL << HUGEPAGE_SHIFT(x))
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
> >
