Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B725FE319
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJMUMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMUML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:12:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339451BC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:12:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so2471690pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=grD4IYCh0UiIbHKRcxJvMIXk9HpYpI4U9Q2DjBhgHQg=;
        b=NkyllWQ/U++ZkI8CsOHLeJ8tBwoBuraA0T8V4KsjpoYtcRlHZfUeD/KvtzBjnxJZhg
         y2ThvKn7rTjSv17EQJXiQwGg/EZZ7Jxw2bqDqpg3GnOdDbqlros/BUYxM/etlHSpjkIh
         IJqCLr6Y8i6Lx38OjRKlBbXT+henGgAfs6Cc6jry5gpNREx95OdPiUHnz+Uw/lbxPZxC
         gLw5t32mKFo87j2xh6+mrKSs8/Sb5/bhiMiRwJqDP4cx66SM75eJfvMInYt8oIKbpAwE
         ed8Y75TfawBmlhc7EMqn+hqROev36FXXm2axJs1W6RSRbWfaD5foLPzLdp/VUlu1SLU0
         wllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grD4IYCh0UiIbHKRcxJvMIXk9HpYpI4U9Q2DjBhgHQg=;
        b=v3CbzZeFIP92oSJa+GpgsjEyR6gLM0Jb6er9A2QJeiU6+aZu0FqCEfMynu6iC8bUUL
         I9ld/4R6o8FiqzqEWjxvWaCB2dR7mRivaJzKWuRnkG51ht+QAwHGbbvsLNDFhzQP7Drx
         ImX4ku100/HxAKkcDxpGXtJfyQ1Z9runePr0NZo44XT8vEyHpqDmkkWGCCsTYUUdUW1L
         HpPjPyJZPYKfdJtQ1i179eYfmXTSi6fjm5H0K0S7i+N7I300yp62d7fWSUnCji9yzyDx
         yNAf/EB2SS3Cj3p2Diq0qUrcapzp2i8JoEc0a59C6EbtUTfOJnterKFYCitC9WAvsbvQ
         NjUA==
X-Gm-Message-State: ACrzQf0NMInYFUw4jB1nRVcJE1+YdF4l8ER1yd8qisfwqvm5yjhN+GVt
        wAhaJtiZ3YgCuahDdtSdWJ/Czg==
X-Google-Smtp-Source: AMsMyM6ne2ZYQ7Zlck9SyJVU4lSDiS8HIA9Q4dfUad4uNjr7hz36kIC7Bs9iVR9bPyB/CyrxbSlL+g==
X-Received: by 2002:a05:6a00:c8a:b0:563:8d31:879c with SMTP id a10-20020a056a000c8a00b005638d31879cmr1434529pfv.74.1665691928515;
        Thu, 13 Oct 2022 13:12:08 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090aa08200b0020b7de675a4sm153304pjp.41.2022.10.13.13.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:12:07 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:12:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH v4 00/11] KVM: x86/mmu: Make tdp_mmu a read-only parameter
Message-ID: <Y0hxFF6ai3cX8uA+@google.com>
References: <20221012181702.3663607-1-seanjc@google.com>
 <CALzav=fZvNttbXSZfCCaFym8cNHYmFZX7286CW_zTZA1CTr3kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=fZvNttbXSZfCCaFym8cNHYmFZX7286CW_zTZA1CTr3kA@mail.gmail.com>
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

On Thu, Oct 13, 2022, David Matlack wrote:
> On Wed, Oct 12, 2022 at 11:17 AM Sean Christopherson <seanjc@google.com> wrote:
> > I'm not dead set against having a dedicated TDP MMU page fault handler, but
> > IMO it's not really better once the TDP MMU vs. shadow MMU is reduced to a
> > static branch, just different.  The read vs. write mmu_lock is the most
> > visible ugliness, and that can be buried in helpers if we really want to
> > make the page fault handler easier on the eyes, e.g.
 
...

> My preference is still separate handlers. When I am reading this code,
> I only care about one path (TDP MMU or Shadow MMU, usually TDP MMU).
> Having separate handlers makes it easy to read since I don't have to
> care about the implementation details of the other MMU.
> 
> And more importantly (but less certain), the TDP MMU fault handler is
> going to diverge further from the Shadow MMU fault handler in the near
> future. i.e. There will be more and more branches in a common fault
> handler, and the value of having a common fault handler diminishes.
> Specifically, to support moving the TDP MMU to common code, the TDP
> MMU is no longer going to topup the same mem caches as the Shadow MMU
> (TDP MMU is not going to use struct kvm_mmu_page), and the TDP MMU
> will probably have its own fast_page_fault() handler eventually.

What if we hold off on the split for the moment, and then revisit the handler when
a common MMU is closer to reality?  I agree that a separate handler makes sense
once things start diverging, but until that happens, supporting two flows instead
of one seems like it would add (minor) maintenance cost without much benefit.

> If we do go the common handler route, I don't prefer the
> direct_page_fault_mmu_lock/unlock() wrapper since it further obscures
> the differences between the 2 MMUs.

Yeah, I don't like the wrappers either.
