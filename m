Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B482D611D78
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJ1Wmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJ1Wm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:42:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A2F1C3E7F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:42:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso5752136pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qiyREI2SgqEB0J7OWHvr962cdqJ8Dp9P5OV9egU229Y=;
        b=RMT+IuqVyDLxzVmXaVtVtqLevGLIyWNxAWTJBPXpIiQWhWr2HbTMty6+sDQVRUAPva
         +lRry2mLQfsIjIOH1wclj9jcvG8dGoOGwtjb2sOTHDuX9EoZ7dfMWrYUUIQ9yr6i00Q7
         jyJ6hPbNO+Npnuxj/JkvV3C7J72NONB7xto3ixhTU4ZbfYYqApiQiKPp/YGYEY9Di3YO
         IrGaw2VOWZpf+mPFPUVUSt2+p607jbxmqSUk/hRYMl4CeBmTnPIpcd5LvTBmnBl+D3ry
         ZsnR2POs2hnnRJBpzSHh6XSuRX2nuzvOmpYaErnyg9eT2C5vngho7r+qU3mDogzBh4T3
         AxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiyREI2SgqEB0J7OWHvr962cdqJ8Dp9P5OV9egU229Y=;
        b=xSIyNI6zgylfodndcaT00X/6RgMDjFUrQiMLErG6vb/hxAX0n/hp5ci2ia+Fv3AW5/
         X9D/FJa6rnsEjFnMQ43nISS9k6+0fstIBJZxsNRhkKtqfU3xjRn1sN0CFelu4sBnkgcT
         Emtv3BkQvqoeKUfk36aQL+zl3na8pkPT1mW+zuwuMLxb9IZKnWHAbqgvo+PjDr+WQvHW
         eLtgs+7OluypQO2Ddu4RwmwFgB+21oC/4R2rtS80rsScxAXOE1zZfahFC+uQcjHiAAwo
         q8/J5/9GAZqwp5BrjzeUHVWu8xQSZH+EHvXPferhsOCuL3v7paglf0wr6OVGjDNxtgZs
         oKEQ==
X-Gm-Message-State: ACrzQf2ivePKD0OcWQ/sKmk5uK0GQmZ7m4Y7rhdS7PjeIZpYQcDzkR26
        m/Fn6Oc2SDSAXwCeYXoadp8kEw==
X-Google-Smtp-Source: AMsMyM5+xtov/mwzo9L/TFZOlK/NdN5EmaYAp4NRYJSIxKolirKLt73cS+s9Xvq9FbBvgdjT7hY+lw==
X-Received: by 2002:a17:902:f683:b0:184:d45b:a096 with SMTP id l3-20020a170902f68300b00184d45ba096mr1267483plg.23.1666996947750;
        Fri, 28 Oct 2022 15:42:27 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f13-20020a63f74d000000b00462612c2699sm3175221pgk.86.2022.10.28.15.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:42:27 -0700 (PDT)
Date:   Fri, 28 Oct 2022 22:42:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Shuah Khan <shuah@kernel.org>,
        Guang Zeng <guang.zeng@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Wei Wang <wei.w.wang@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RESEND v4 00/23] SMM emulation and interrupt shadow fixes
Message-ID: <Y1xaz4pkH2FYSYvA@google.com>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
 <0e3a0cab-1093-3e83-9e9c-f8639ebe5da0@redhat.com>
 <b0e8da09162cc6f2194e445a6e566f1bc356d5d0.camel@redhat.com>
 <4ce3d40e-9b2a-5f81-fc62-839f788fed16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ce3d40e-9b2a-5f81-fc62-839f788fed16@redhat.com>
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

On Fri, Oct 28, 2022, Paolo Bonzini wrote:
> On 10/27/22 19:06, Maxim Levitsky wrote:
> > On Thu, 2022-10-27 at 18:49 +0200, Paolo Bonzini wrote:
> > > On 10/25/22 14:47, Maxim Levitsky wrote:
> > > > This patch series is a result of long debug work to find out why
> > > > sometimes guests with win11 secure boot
> > > > were failing during boot.
> > > > 
> > > > During writing a unit test I found another bug, turns out
> > > > that on rsm emulation, if the rsm instruction was done in real
> > > > or 32 bit mode, KVM would truncate the restored RIP to 32 bit.
> > > > 
> > > > I also refactored the way we write SMRAM so it is easier
> > > > now to understand what is going on.
> > > > 
> > > > The main bug in this series which I fixed is that we
> > > > allowed #SMI to happen during the STI interrupt shadow,
> > > > and we did nothing to both reset it on #SMI handler
> > > > entry and restore it on RSM.
> > > 
> > > I have now sent out the final/new version of the first 8 patches and
> > > will review these tomorrow.  Thanks for your patience. :)
> > > 
> > > Paolo
> > > 
> > Thank you very much!!
> 
> Queued, thanks.  Note that some emulator patches should go in stable
> releases so I have reordered them in front.

Can you fix patch 04 (also patch 04 in your series[*]) before pushing to kvm/queue?
The unused variable breaks CONFIG_KVM_WERROR=y builds.

arch/x86/kvm/smm.c: In function ‘emulator_leave_smm’:
arch/x86/kvm/smm.c:567:33: error: unused variable ‘efer’ [-Werror=unused-variable]
  567 |         unsigned long cr0, cr4, efer;
      |                                 ^~~~
arch/x86/kvm/smm.c:567:28: error: unused variable ‘cr4’ [-Werror=unused-variable]
  567 |         unsigned long cr0, cr4, efer;
      |                      

[*] https://lore.kernel.org/all/Y1xNso2nYZkSSZ0T@google.com
