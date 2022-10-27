Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F14360FC36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiJ0Poe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiJ0Poc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:44:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF925E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:44:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so5954913pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl7TTiZu67z+KceFJoWbbpftR9c8WB/oiC+Xa0ObMYA=;
        b=sjqgUwfRJQ3b0vOGCj8YAk2syiaqov15hRa2+2j4g7M4liFUX7T+YYus50F5aPTGBR
         0ncqP7fzYeUyV4G5znJHyFsVe1hhGTkTMuLKExktW/SsIPIBGTn1zjrsTL6blZC54ilT
         XhX7MCjtZ6c3Ymzu1YDSrT7Ov5/8NcAwJCuT1WDDE6FDOy3o0vqg7CytJU3L4GCebgAc
         QMK1P04iaHjyDinqPa00nnnmxiMkeM5BI1pra8EusuUSSYCv6Rn5nB2HkB4LsAYxy3X2
         2Tt4JuoxVoxEBWomfGJHhFow+1GOWad3iCmgLEYYz+KfWORfIvfxPn7l4Csda2gTu9QY
         F6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl7TTiZu67z+KceFJoWbbpftR9c8WB/oiC+Xa0ObMYA=;
        b=taXkAeZ25i4NMTmrnHpUg8ObEhf8/ojI1kNYm+q74uQDCQHfHp5JYtZPQJEjsV8hsi
         n1FSSof5trN6DXKILrv7OBT6oYXxlSY43KzcdiCN4iifun3axhEJjw761FR3akP+gfhJ
         2FybipH8G4l6nvQDU55Mewgc5Ko46Tcf0VwNtPC9k+/eegFBQ3XL2ATro7yAKr4PFy6I
         Ms5W+cRCTmHlFtLtCA86oAMDRpZdjPlhbfcdGtKXx2P3FYSaedQ7g+4N4OD8ecPiY3L2
         hDEkYwW9Tabc+va8H1C0rJrJifZ3NMhWns0XreO9zrAOMPClX9GiUkZyKRr1RO2JxZlC
         Ne+Q==
X-Gm-Message-State: ACrzQf2fSRIwCMlXaK2MPtLE6qrnLTGugVS5tP+zIZUgW1jAYS9cJnfJ
        rZtMGDCXtHOcuEPJK8Rs1ypA6A==
X-Google-Smtp-Source: AMsMyM745VbIv0jTAwadLamyTmggrBgBVIXRhw/zFACHjVQstwHDj+uv7skybYQJgZCAjU49PGdkhA==
X-Received: by 2002:a17:90a:4bcb:b0:212:def0:cb00 with SMTP id u11-20020a17090a4bcb00b00212def0cb00mr10561273pjl.61.1666885468404;
        Thu, 27 Oct 2022 08:44:28 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id x190-20020a6231c7000000b00563ce1905f4sm1354535pfx.5.2022.10.27.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:44:28 -0700 (PDT)
Date:   Thu, 27 Oct 2022 15:44:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     David Matlack <dmatlack@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "vipinsh@google.com" <vipinsh@google.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/18] KVM selftests code consolidation and cleanup
Message-ID: <Y1qnWFzekT27rYka@google.com>
References: <20221024113445.1022147-1-wei.w.wang@intel.com>
 <Y1mlJqKdFtlgG3jR@google.com>
 <DS0PR11MB63731F2B467D4084F5C8D9B5DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB63731F2B467D4084F5C8D9B5DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
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

On Thu, Oct 27, 2022, Wang, Wei W wrote:
> On Thursday, October 27, 2022 5:23 AM, David Matlack:
> > I haven't dug too much into the actual code yet, but I have some high level
> > feedback based on a quick look through the series:
> > 
> >  - Use the format "KVM: selftests: <Decsription>" for the shortlog.
> 
> I know it's not common to see so far, but curious is this the required format?

It's definitely the preferred format.

> I didn't find where it's documented.

Heh, for all shortlog scopes, the "documentation" is `git log --pretty=oneline` :-)

> If it's indeed a requirement, probably we also need to enhance checkpatch.pl
> to detect this.

I like the idea in theory, but that'd be a daunting task to set up, and quite the
maintenance nightmare.  There are probably thousands of file => scope mappings
throughout the kernel, with any number of exceptions and arbitrary rules.

> If it's not required, I think it is more obvious to have /sub_field in the title,
> e.g. selftests/hardware_disable_test, to outline which specific part of
> selftests the patch is changing. (the selftests are growing larger with many
> usages independent of each other).

I agree that "KVM: selftests:" is a rather large umbrella, but it's not obvious
that "KVM: selfetest/<test>" is unequivocally better, e.g. if someone is making a
change to x86_64/vmx_exception_with_invalid_guest_state.c, the scope will be

  KVM: selftests/x86_64/vmx_exception_with_invalid_guest_state:

or 

  KVM: selftests/vmx_exception_with_invalid_guest_state:

which doesn't leave a whole lot of room for an actual shortlog.

When reviewing selftests patches, I do find myself pausing sometimes to see exactly
what file/test is being modified, but in almost all cases a quick glance at the
diffstat provides the answer.  And on the flip side, having all selftests patches
exactly match "KVM: selftests:" makes it super easy to identify selftest changes,
i.e. it's mostly a wash overall in terms of efficiency (for me at least).
