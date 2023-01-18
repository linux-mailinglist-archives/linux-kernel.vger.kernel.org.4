Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11429670FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjARBQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjARBQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:16:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDCA38030
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:09:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q64so34214222pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JuSDYqZWGf39oVCbPD+c17ZjYNYI+6+cfw+Ots82+Y=;
        b=Ve3FxUDvOHo6Fn7HY/ppNZz+WelafZ+RJ2HzV3I/qvn1wkPTF599o9nRJTX3hXldgb
         ianClHwAyXr4VeNKpAE6Ue/lSK8Okcw7wiWZkSciZSXDlPXaAeGaoTg1OklCVs9h0fLM
         m9/gFhYNxrKaZ+f8LJSj3fdKM7zqw0fiD5S/ueOWCQdkCeof82/rL75xM/G+N6tC2r/C
         YtYxcPce/m6LRW5kv8PKvg0mbIjuarPCZfYT6ehmzP6FHK4ZyylgC1JKWdSsjAlSt3DE
         7dsOOZiCAR3/NwwHwwrOTAYPmKI0b1ej46mfNHWgMfUXtNJit69u3lhXZ9pThoJy2EpK
         vuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JuSDYqZWGf39oVCbPD+c17ZjYNYI+6+cfw+Ots82+Y=;
        b=ARacOF/fizcRQ92YeecZYG+QXIAYQxmAXeYSydRK1Fm6+MQV0pjTDdDkgAe4062KJl
         ew9yyDxBsxPS+wNikSGqug+iAl65wPmjT131YeqKERCzpCcDcVajoEPSPB3tkJCG4/Nr
         9Yno8kHNXRFF0BFpCubENuo9InZk3nNHhnpHQE/lAuvdNQRkDtMFikQvP2I71VCzqCAF
         1oTDseN65jkS4YgXzAeYJodrXqc6QpfaDBZu+ARqZkiwhTG77O5bgFk4Pd3E7H59B2Zc
         soN/AsQRTE3tXP/Ub6XAw0nB/qD86KXnAXIMl/3SFufxAvyIAIekBzL+1/uSwC1t8hxH
         GEfA==
X-Gm-Message-State: AFqh2krNAziecjeCeCGe597AUdOTnLklc/dIqIacEMJkvxmXI7VSZt3p
        g/RBVhwbDGvFGiw8g+2m1sHIJg==
X-Google-Smtp-Source: AMrXdXv5kooD4dGpQLPvyRvgMkoX5y8OCxWBHB/rOCGPjku7DRiAMCKQl96+K8+2t75cauDHnHGELw==
X-Received: by 2002:a17:902:ebc6:b0:192:8a1e:9bc7 with SMTP id p6-20020a170902ebc600b001928a1e9bc7mr3150303plg.0.1674004192919;
        Tue, 17 Jan 2023 17:09:52 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm154353pje.40.2023.01.17.17.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 17:09:52 -0800 (PST)
Date:   Wed, 18 Jan 2023 01:09:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private
 memory
Message-ID: <Y8dG3WDxY2OCGPby@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-1-vannapurve@google.com>
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

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> This series implements selftests targeting the feature floated by Chao via:
> https://lore.kernel.org/lkml/20221202061347.1070246-10-chao.p.peng@linux.intel.com/T/
> 
> Below changes aim to test the fd based approach for guest private memory
> in context of normal (non-confidential) VMs executing on non-confidential
> platforms.
> 
> private_mem_test.c file adds selftest to access private memory from the
> guest via private/shared accesses and checking if the contents can be
> leaked to/accessed by vmm via shared memory view before/after conversions.
> 
> Updates in V2:
> 1) Simplified vcpu run loop implementation API
> 2) Removed VM creation logic from private mem library

I pushed a rework version of this series to:

  git@github.com:sean-jc/linux.git x86/upm_base_support

Can you take a look and make sure that I didn't completely botch anything, and
preserved the spirit of what you are testing?

Going forward, no need to send a v3 at this time.  Whoever sends v11 of the series
will be responsible for including tests.

No need to respond to comments either, unless of course there's something you
object to, want to clarify, etc., in which case definitely pipe up.

Beyond the SEV series, do you have additional UPM testcases written?  If so, can
you post them, even if they're in a less-than-perfect state?  If they're in a
"too embarassing to post" state, feel from to send them off list :-)

Last question, do you have a list of testcases that you consider "required" for
UPM?  My off-the-cuff list of selftests I want to have before merging UPM is pretty
short at this point:

  - Negative testing of the memslot changes, e.g. bad alignment, bad fd,
    illegal memslot updates, etc.
  - Negative testing of restrictedmem, e.g. various combinations of overlapping
    bindings of a single restrictedmem instance.
  - Access vs. conversion stress, e.g. accessing a region in the guest while it's
    concurrently converted by the host, maybe with fancy guest code to try and
    detect TLB or ordering bugs?
