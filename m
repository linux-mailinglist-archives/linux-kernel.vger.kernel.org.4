Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3F5F729C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJGBp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiJGBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:45:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4C8D0DC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:45:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so3389167pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 18:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onv5P620AmNNedNAxg3+XP3vAvUoceHtCwXWh28hGnQ=;
        b=dQJMrDwL5UVoakMYkWxfUudErzh3bGhynK3gdAmH+Fpm4v4X+h1T/mKrTToRfXSbBk
         S3eNc12+zyP7OoYNK5iajT8AONZaYAdGsIaadggClYf/+9cCYtKjWo+Q8l8o4a7UPN/g
         RRdQHCKruaoEqYGGKkWbgv0ok+oYfhow67fnvpa6pqUc6xuvXf8ucXdc4SVAdurDm35e
         89aWKO+49BxAzDOgmzw4nyW6C5vJpowdFsKGl6sxttfdUHmP/OxAVx7pu6fUfztvjyqS
         uU6yGQtWzNsugPAAyY6HQsY37SoEbtIHXNfdy1MjmG+yDfQ/2DZxmuOHBbAZfUT14Jdm
         US7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onv5P620AmNNedNAxg3+XP3vAvUoceHtCwXWh28hGnQ=;
        b=S397SGKVkKcnJh66QnoQo3/erFMXZAcasaX5uo0Lq4bewLvpi1QH8ABSog8iVOAmdu
         JoAblYjsFlBk8JtkdAr7YLtj7zLhXNWPIwTkXL6echrqUol8z1qL2VLvbrdbgZzsJniu
         MHcYnvAgiPleBIhsLixU992sScIF3tzTvL9Vlz/4SMH0rDlL0H/+QWfGUybYVRZyz1Aw
         ATUZq/vz0jQtDsxCoAqyWlxIMP9PwzPP+qnfrp9+n/7mSi/AlE4j0JPc/TsI3AEWS8cV
         tH6i/sKVuACCWMhZwgPxg1x0v6IMgjAXqEwr1PXE2+b9Mv621czw4xm37fyuSO7Ym/JU
         Ok+A==
X-Gm-Message-State: ACrzQf1h28gu5w0Ve3IPgD0GkpAFJW514W2fgqtkkpgA246wKRyeGzvq
        8PXctyDgvld97GA0yjFtx3hUHQ==
X-Google-Smtp-Source: AMsMyM6s5wEJXDvb3j8PLSCoebp5LNqIQLh/ASkusre74Q4oT+0bwwL+LTbvlrCBBHDuufXmzYuOgw==
X-Received: by 2002:a17:902:f789:b0:17f:8cb6:7da3 with SMTP id q9-20020a170902f78900b0017f8cb67da3mr2654285pln.167.1665107153339;
        Thu, 06 Oct 2022 18:45:53 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b0017f637b3e87sm251570plg.279.2022.10.06.18.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 18:45:51 -0700 (PDT)
Date:   Fri, 7 Oct 2022 01:45:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)" 
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] KVM: x86: Expose CPUID.(EAX=7,ECX=1).EAX[12:10]
 to the guest
Message-ID: <Yz+EzB0Y0tRl7rAz@google.com>
References: <20220901211811.2883855-1-jmattson@google.com>
 <20220901211811.2883855-2-jmattson@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901211811.2883855-2-jmattson@google.com>
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

The shortlog is trying to win some kind of award.

And technically, KVM_GET_SUPPORTED_CPUID advertises features to userspace, not
to the guest.  How about this?

  KVM: x86: Advertise fast REP string features inherent to the CPU

On Thu, Sep 01, 2022, Jim Mattson wrote:
> Fast zero-length REP MOVSB, fast short REP STOSB, and fast short REP
> {CMPSB,SCASB} are inherent features of the processor that cannot be
> hidden by the hypervisor. When these features are present on the host,
> enumerate them in KVM_GET_SUPPORTED_CPUID.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>

With a less cryptic shortlog,

Reviewed-by: Sean Christopherson <seanjc@google.com>
