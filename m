Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B925F3555
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJCSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJCSLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:11:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C4E37408
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:11:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so10388312plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zRpyaE88IPezVOhw7iDOjlsRbtSXUjPIrXfaa3Vd3zo=;
        b=PWArMU3a7kjBwWCA46WWP4zzfx02BDKVm4Jb2Z339yWHDI+W7ISC2qQN51aA/T1cmp
         4qlyLW4V3YZ9vPNyyr7J2q4Gwp/zmqjoyGzZ+I0HRBmpyvbyNFV3jXd6BlreiAM4z9sc
         3sAwUQEoaOtYanSqbEquaqOPgyq+F9eL1RUcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zRpyaE88IPezVOhw7iDOjlsRbtSXUjPIrXfaa3Vd3zo=;
        b=KoSUNFmEjjgugpUFYJAe5nPdckpKsROb6ptvA8lTrV3ze3fDDNfd3BggFYZdEn7VEN
         8OiKvb06DmBh4BsU7E5zylvi1pvW2iSdwmsP8ESD7SAlimMVsd0LDVzKGHE/5UBgUZK7
         pd4zn8lOZEQfuqpZShWYRA444kzRsSB/F3B3VYJW1jAzLl1DJpxUSWfESoopXOJn1laM
         e6XmCmX9NQ5DkND1gPEg4zIxyOvpaDKAEVMNdQcVjs5olCyNJrF7jbIFzJpmWNEYBRvj
         NC7/3buA/XQ2fikIPil6TqNwwptPi/LjoN6w/4N578Rtry9uSPrQZsWCl22g9AJs+PeJ
         SCxw==
X-Gm-Message-State: ACrzQf3lzOOjUOjCLcIkVof+DKRWl9p9yooh8T9icQeRVE+bDSPzMxTw
        PT3vno2L/Xudc1VhJYtGmzQAfg==
X-Google-Smtp-Source: AMsMyM5XAU3N6BrociuiRhaNddnUYSLkzWBAzwcCZoX/da8Tx8mE88aWLj364HqDnnvojMSluB2wpg==
X-Received: by 2002:a17:902:e54b:b0:178:75b9:f1e9 with SMTP id n11-20020a170902e54b00b0017875b9f1e9mr23501376plf.104.1664820706785;
        Mon, 03 Oct 2022 11:11:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902b58f00b0017849a2b56asm7513913pls.46.2022.10.03.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:11:46 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:11:45 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 13/39] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Message-ID: <202210031111.01D879A@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-14-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-14-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
