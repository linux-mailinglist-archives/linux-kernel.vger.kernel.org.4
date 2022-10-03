Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87E5F3596
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJCSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJCSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0E5C6B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664821475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P57fOCRr8L8IWMz1idkV10HcfpUZXl9CrILykX0M7Do=;
        b=NdM6BOSZHnPZh7QU1Ys5UnWDmcl7fk7sBp9lmQ9fkSLPcliMP30/F5vnctbWi6WRdTbbX2
        Uu8iCJOzP/exgxgJDk0cCLq235QLu2b27NuhBWs7oCLJxJge8coAOsU8HuUxhvJwJ30M+0
        igsBM7P3c8zqkij22Lcx73idwq+0PU4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-290-mdvslV0qOMWUc5rVUUQSgQ-1; Mon, 03 Oct 2022 14:24:35 -0400
X-MC-Unique: mdvslV0qOMWUc5rVUUQSgQ-1
Received: by mail-qk1-f198.google.com with SMTP id n13-20020a05620a294d00b006cf933c40feso9828416qkp.20
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=P57fOCRr8L8IWMz1idkV10HcfpUZXl9CrILykX0M7Do=;
        b=6sylt+7HnXeppWaL4IDzV87/qPaR6GoOIDpnnVwWy4+FJ/JxjFL9EkBB0ZD3z/gjyZ
         3mWQtuI8HjTEYsytcPfqukOdRFHauhxdYePWZ+Sr6S0HqzcfdnQOhbXPbxCHCuZ8JzCq
         DlCccH4pPnJUf3iiKUbe2ML5xE7o6I1IfNE5S205+2Zelsm7UXwP69gZWDxDhfRI094h
         SzKIqHkVEErMnkuf2xe+yRK8DzA4H5ji+C/7V0C32aKjWRrzb4p92NgRSywLWY4wxcsF
         Ku4xPqjYNddedaenqxJ2cykW5Y9lhu6qYk3FmTxsnC6+U+YXi1gC4spLOhb1Tn2+/r6j
         v6cw==
X-Gm-Message-State: ACrzQf1u2rNmKfXMBbxzSxkyafsJc9qBymCrxqPzpwHf4Na8vRJpwx+f
        8vk5Im8ggKmUsk5KbkOp2yGcIYbT7tX38c6hsN9idT0hbZCCNarRWjtL7BMaR3ySZW2jYgcLrH6
        tF2SbqkMkhOmTOsimBv3Y7ucO
X-Received: by 2002:a05:6214:5609:b0:4ac:aa5e:5425 with SMTP id mg9-20020a056214560900b004acaa5e5425mr17021809qvb.81.1664821474557;
        Mon, 03 Oct 2022 11:24:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Af9yw7ubrxehHYf5SG+wnB1n3fA8M/KRQPPpTdYDWvwqKkVBNCpZxbdY+JnLWNQEAjxNlsw==
X-Received: by 2002:a05:6214:5609:b0:4ac:aa5e:5425 with SMTP id mg9-20020a056214560900b004acaa5e5425mr17021775qvb.81.1664821474349;
        Mon, 03 Oct 2022 11:24:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8580c000000b0035d4f68232esm10631028qtg.3.2022.10.03.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:24:33 -0700 (PDT)
Date:   Mon, 3 Oct 2022 14:24:31 -0400
From:   Peter Xu <peterx@redhat.com>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 13/39] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Message-ID: <Yzso39wMlI8Tyn9c@x1n>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-14-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-14-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:10PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> To introduce VM_SHADOW_STACK as VM_HIGH_ARCH_BIT (37), and make all
> VM_HIGH_ARCH_BITs stay together, move VM_UFFD_MINOR_BIT from 37 to 38.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

