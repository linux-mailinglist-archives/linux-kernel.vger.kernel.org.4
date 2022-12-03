Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742F664134C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiLCCXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiLCCXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:23:19 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F5A13E3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:23:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s7so6238056plk.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 18:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eui6IDrtJSSwvghE5R4NrO3c3J2R5hMTpHZZ03nZEDQ=;
        b=b8s8foi748iQssfrqgZytxf8OJPlcTCQd3FFA3C7R8UrNbbxplUy3TFNX7WfSfyy6S
         FhB+VuU4K0rWbo2IdtW+FwMGeuyZAI9GUIMQSXtf3Wg09KAtYhntwLhrVWb6bSw1nza5
         uHW04n+u3peLELfFsAaxBMvepzcpDEWzIFKTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eui6IDrtJSSwvghE5R4NrO3c3J2R5hMTpHZZ03nZEDQ=;
        b=ejy3iaRDZYagRdVFeHhKPoZnIL+btiWsiaZQlk2rvT2kPH3OcgXjOfYyyVMydduo7q
         rrkjue+kVN7iVqsABVBV52auqS2vAJMfDGybxqpxUrFR2br8dWqYkc93ni6HSyrypvwN
         uQ7U9gdCFH38NAH/Ku1eOcj4ZzzxogMpScowt3NnhiRUH4M8iK2hmffrn8JxNO+FLCtL
         AEfwOgKToUygx+2eUjc0dJh4lAJfzue2MN3Ct/WZzYohGcYgqjAL+zzCZDvpwkBmHxvZ
         54JRFcjACAQyn+XyMdCP2R6ej0omNLLLXngGdAWxtTa/z7OzV7cFstZuwVC/6MVOCn+z
         xEwA==
X-Gm-Message-State: ANoB5pmfLO2AWD7p3GYYVk3JqMT1Y6XWxbpJqcR1MVFbSJmv83vy0jbL
        RVU5j7YQLEocgzPgwMF2sMEf3w==
X-Google-Smtp-Source: AA0mqf7CFiIRiM/dXied6BXdYG00/YaUHb6cOHGI0hwn0YmJaYYeUOBz/+ex15TNr099/qRV1Mzuaw==
X-Received: by 2002:a17:90a:fe05:b0:219:8766:6f61 with SMTP id ck5-20020a17090afe0500b0021987666f61mr7437321pjb.40.1670034198151;
        Fri, 02 Dec 2022 18:23:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1-20020aa79421000000b005765a5ff1fasm2124160pfo.213.2022.12.02.18.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:23:17 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:23:16 -0800
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow
 stack
Message-ID: <202212021823.81E4669@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-5-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:31PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Setting CR4.CET is a prerequisite for utilizing any CET features, most of
> which also require setting MSRs.
> 
> Kernel IBT already enables the CET CR4 bit when it detects IBT HW support
> and is configured with kernel IBT. However, future patches that enable
> userspace shadow stack support will need the bit set as well. So change
> the logic to enable it in either case.
> 
> Clear MSR_IA32_U_CET in cet_disable() so that it can't live to see
> userspace in a new kexec-ed kernel that has CR4.CET set from kernel IBT.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
