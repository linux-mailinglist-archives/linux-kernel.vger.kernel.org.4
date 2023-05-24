Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F1870FF90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjEXVB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEXVB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C912B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684962068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dODs5ZTn+ErGWbdibvZPgi03pCRB3lhisq+Guk0Aefs=;
        b=QCfb8KwLrgMgQrXtuEAXRBuPRHG0M8Iz+46fLCyfk3Lci4UH3xBUp3xzUkx3JtCIKedYf4
        S2XsGKD3/lbWwWKSWVsFQCLG8qu4rpfKwwAdrhQ8Uk/TDg3yf0FVye/k8+yYWcndDhj7mf
        NZM4SVi/rDIVijTwSm2bpT+n6W30ZZM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Nnkk3kx2PpyfXym6GcCK3A-1; Wed, 24 May 2023 17:01:06 -0400
X-MC-Unique: Nnkk3kx2PpyfXym6GcCK3A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-623a303a27eso4039856d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 14:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684962066; x=1687554066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dODs5ZTn+ErGWbdibvZPgi03pCRB3lhisq+Guk0Aefs=;
        b=Oas0f6m/Zgmg/+oLtkYRPDL8lEQgW+6j5vWYJtESeLTm6uMcaNihRIS9Piz1yasThP
         xD8CHHk5paJM1yeirQxUQZU/AwsjzSBU59JJtaFbgzGuAeHkOSSCJ1iVYicgPiPLCpHK
         pHC8T+Kian2301wkw/ZDcTnKiXeUoggY+JGdf/SnDaA7mc2n7GuLgH3saWdx9gmJOS0H
         5fG7lqEoHeEDFofQkTmtglqMo2Ie4VBlFEqKb6Cv+uS6sqQr4p3KbY1kTRPd2BT0BEBv
         2gwY0aU3AyyKvZNhKbHiv33pdAy7r+P2LyDyKzTQBxmGDRJVW1jQ8Rbhq3rhwwlNopzg
         1FKQ==
X-Gm-Message-State: AC+VfDx9AHgkWblpiN5xPhqZyfQRkrDsiw63ZIMc4bYA9stVEvcYCunK
        YsHlhxxHa5/GhqSTLSX+yrQepjsUIdXsLPeD9D617EWKl2pFpyJPGCSFxTqADfeFLM4O4QKeTsy
        9SgzkMK7AGjVtKeSRUW+KnJDg
X-Received: by 2002:ad4:5f0f:0:b0:5f1:6892:7440 with SMTP id fo15-20020ad45f0f000000b005f168927440mr33130478qvb.23.1684962066219;
        Wed, 24 May 2023 14:01:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7O/5uTpY0b5HdIavkAWDeSIAxBpa10qbCz5cuioocwwPtQwVYPGqqlIFOfsx4TYmU37r8V5A==
X-Received: by 2002:ad4:5f0f:0:b0:5f1:6892:7440 with SMTP id fo15-20020ad45f0f000000b005f168927440mr33130452qvb.23.1684962065941;
        Wed, 24 May 2023 14:01:05 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::3e])
        by smtp.gmail.com with ESMTPSA id bt8-20020ad455c8000000b005e750d07153sm3841558qvb.135.2023.05.24.14.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 14:01:05 -0700 (PDT)
Date:   Wed, 24 May 2023 14:01:02 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: vmlinux.o: warning: objtool: xen_sched_clock+0x4a: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <20230524210102.h2bbhlvujcg77wuw@treble>
References: <202305242215.M2ZKRxS0-lkp@intel.com>
 <20230524142954.GN4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524142954.GN4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 04:29:54PM +0200, Peter Zijlstra wrote:
> >    vmlinux.o: warning: objtool: acpi_idle_enter+0x65: call to ftrace_likely_update() leaves .noinstr.text section
> >    vmlinux.o: warning: objtool: ibt_selftest+0x1e: return with modified stack frame
> 
> Robot folks; could you please discard all:
> 
>  ftrace_likey_update.*noinstr
> 
> warnings, they're -EWONTFIX.

Could we just make CONFIG_TRACE_BRANCH_PROFILING incompatible with
CONFIG_NOINSTR_VALIDATION?

-- 
Josh

