Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EFD674855
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjATAwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjATAws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:52:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C394C9E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:52:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so7606116pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1C2ctxswyAGed+VsNkOxUKGn6gRJyI8cRWlSvVIO/8Q=;
        b=i+VgjtzVxyiavJTmAvH09Qn7ZzhTFpMqXoIJacerr3JSNd/f+ZgcETHvMZ8j9a/qHg
         6cxIJ0s7hH18e7a5dd5Fz6rmK+w1pd9b3oNgvthM3x9srmt9IMNRq8lGgu8hfUgwFYpx
         43+n9VMuUcLoXUU4rM6GSmnSC5UaHbnsDlq8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C2ctxswyAGed+VsNkOxUKGn6gRJyI8cRWlSvVIO/8Q=;
        b=386y+QJnWtuZ7+csxodfPtN1rGuimqreAeaWRDEzjI4I9MP0ZMpbJ6skUwvoXbVgAA
         GaVcXl/75twfKlVN10Q6rLUqf8TBAay44osg470w6BrtK575hkfwMUOxZlUzBU/QkV4Q
         9qbBilvZbl/Qtqy3iLX8Z9/N5IIZKy7qNqfO5CkjOObnvmgCMKmvvLhssVAKph5DFAKL
         QuvWtyYPGBN3VcQpoG4FCVkJDLpavPvhr11rubA1g+1m0EDBbP/hhQ3U2q1a1dIDlYNH
         GpGhx3UC/rvnYanIr/kxGwivurZxCj3tA9wcmxqZe91Z8hMrR2FYBBFLt32FsSmOwsRS
         yOrw==
X-Gm-Message-State: AFqh2kprDZyl5EaRxwxhFQvTasAIRcrrdFjHIhZqO/UVxAm/f+svSlfa
        ugbnseYFkVDwZ7fYQbOwlMDtuA==
X-Google-Smtp-Source: AMrXdXsDu2HwbCVFC9JsEmeSgASgPieeUX36pana6UedcUBOEOfYByTAr8XSuHo9hlfLcW6XCZ0Ifw==
X-Received: by 2002:a17:902:9a97:b0:193:2a8c:28cb with SMTP id w23-20020a1709029a9700b001932a8c28cbmr13298362plp.21.1674175966284;
        Thu, 19 Jan 2023 16:52:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b00194ac38bc86sm5757193pla.131.2023.01.19.16.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:52:45 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:52:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 08/39] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Message-ID: <202301191652.57B10DA48@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-9-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-9-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:46PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> New processors that support Shadow Stack regard Write=0,Dirty=1 PTEs as
> shadow stack pages.
> 
> In normal cases, it can be helpful to create Write=1 PTEs as also Dirty=1
> if HW dirty tracking is not needed, because if the Dirty bit is not already
> set the CPU has to set Dirty=1 when the memory gets written to. This
> creates additional work for the CPU. So traditional wisdom was to simply
> set the Dirty bit whenever you didn't care about it. However, it was never
> really very helpful for read-only kernel memory.
> 
> When CR4.CET=1 and IA32_S_CET.SH_STK_EN=1, some instructions can write to
> such supervisor memory. The kernel does not set IA32_S_CET.SH_STK_EN, so
> avoiding kernel Write=0,Dirty=1 memory is not strictly needed for any
> functional reason. But having Write=0,Dirty=1 kernel memory doesn't have
> any functional benefit either, so to reduce ambiguity between shadow stack
> and regular Write=0 pages, remove Dirty=1 from any kernel Write=0 PTEs.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
