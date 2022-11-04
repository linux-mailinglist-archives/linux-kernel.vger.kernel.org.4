Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290B8618CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiKCXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiKCXPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:15:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4511F2EE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 16:15:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 128so2981355pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pJGBtBRlC9W/3VmM7ygD0kmJPJcspp2vFQhK+ae1yM=;
        b=Pc3Tukbe96nkZq7WE50GOppnzvRDyHzpjEDNUwc9j2gDNlL6kqpj9LYcrF96/bHzup
         IHoLbCJsuuo/a9fmyXmDsgguopfAkwXbRj3ke25k/DoWY0IkPcoD7J0QsIpZRtPsHNw6
         MtT9alzx6INifvV9APbEe0RfIQtng9UaI7v+qJ8XjETsTc1B6NQ4lUV+DTx8Iu+nYQbD
         S/0kDXSy/w8jSebuqXX1q+wvr7d47hSUUXQeLQymdpzBOSdHYMSyfLyVMmWeL7Z6MbI6
         EomhcxeSje6rgd14lbKbCBH0syZwUjRBq2lC+ImfrOsQ3KpWvq/QGn/KuldN2bDJ/V9u
         h2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pJGBtBRlC9W/3VmM7ygD0kmJPJcspp2vFQhK+ae1yM=;
        b=TAQX3XMoft2a309jjVyE2CW18tcLAOW4AF74N/7UW9sukWFrJ2vJb0mKc+qPsJuv+i
         Al/GPcPT+4Cy/BeDdahKyt7Cuo5rit8JUXDxH2jZTuAEBctaQlm5d6I6LVl2g/BNMgHe
         LScRFoDd/T49s/Z9/k4oloc9fj5rTwORz0uMKzWb6bbv/M6T19aUUgihxqLjzM4eepBK
         VqBjn0LKkhv7iP831D0Xnp+ODLnOicUTgMTofECeMaFSrcgYlV+qmcdLrdL3X3egO7T0
         FUN2nuYBvyyRthnPcp2z8XL44VFrIJUr2/30BViYAK9BCQkEIHgFukwO9y+om45Kf5uD
         8JoA==
X-Gm-Message-State: ACrzQf20pu3RVKBVelb2Gl4uvu5rg33GMWcAUCLVbYUgoi898bSMxkqw
        jZyeCMJgFl0wJgI/UktefnKiHQ==
X-Google-Smtp-Source: AMsMyM57twHEvXBJIS3qcQoWrBfAFUYMl9uKmJeRisR6YKbh30zSMThvHbGtJ7f2Tuh8JsiO42fJ6Q==
X-Received: by 2002:a05:6a00:189f:b0:56b:b192:cda with SMTP id x31-20020a056a00189f00b0056bb1920cdamr32586422pfh.2.1667517339926;
        Thu, 03 Nov 2022 16:15:39 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ij17-20020a170902ab5100b00178143a728esm1121159plb.275.2022.11.03.16.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:15:39 -0700 (PDT)
Date:   Thu, 3 Nov 2022 23:15:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] kvm: x86: Keep the lock order consistent
Message-ID: <Y2RLl8MaGw/rn7TL@google.com>
References: <CAPm50aJPpzWz1nnBu6vhcac2kwKq29h-oq7jZtKz23XJ46LW0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPm50aJPpzWz1nnBu6vhcac2kwKq29h-oq7jZtKz23XJ46LW0g@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit, capitalize KVM in the shortlog, i.e. "KVM: x86:".

On Mon, Oct 31, 2022, Hao Peng wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> Acquire SRCU before taking the gpc spinlock in wait_pending_event() so as
>  to be consistent with all other functions that acquire both locks.  It's
>  not illegal to acquire SRCU inside a spinlock, nor is there deadlock
>  potential, but in general it's preferable to order locks from least
>  restrictive to most restrictive, e.g. if wait_pending_event() needed to
>  sleep for whatever reason, it could do so while holding SRCU, but would
>  need to drop the spinlock.

Extra whitespace at the beginning of each line should be deleted.

> Thanks Sean Christopherson for the comment.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---

Nits aside,

Reviewed-by: Sean Christopherson <seanjc@google.com>
