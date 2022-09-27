Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89205ECA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiI0RIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiI0RHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:07:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16245883CB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:07:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v1so9634179plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=f0hIq2KYifdNKFEFb7aEPEmJFmBWVDO/Zv/NjHfHkzg=;
        b=kp2y1pD2TNHkVmFbKg/OSxw8KFbGNkM5ZdloYEPiV5zUAUrwEerxBdZKOJi0qRkwcM
         fp/Zhiqf547RsKsnk784wVwp3youq2kUThdSRzsrx7HU+53VR+sIgN3UatNFz/xtzjZX
         VA0U4dC2UnSJij6sWt4a4DCfqh3LsF7xhSHtZnlR+oUkOwNu7fsZzUbiaFE7UlXmmmW8
         eSGzbAnmfMCZw9SAtwbi43UiPe7oTueIPEevMmHBOyKSblSqZltt/7rBOz4Xu0CfjeSW
         pUWt2/k8jfcvjjj9CbAWQDPsRZUjW59edFsi0exMCRXEgvqaFHQYwIrxElO4Gc2V4Qee
         vsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=f0hIq2KYifdNKFEFb7aEPEmJFmBWVDO/Zv/NjHfHkzg=;
        b=5K/hhkgLLkScae9txZqbKkFanL8fIgIPkFAx20Ie8ZcIFO3Kthm2jQcnJjMcgSvIpN
         lP7sEI/OcWioVxmlDse7h21+2s0mJG82PxFsO5RNXyf/Iw7JTVejRFGwGt//mPsoIpOx
         JAeHoxWGgVLxs5QGFh4SSPS9Q92PSZVy/9ncsucNRnhHtoisWI0OvhJrCbZui5Ghs+Cm
         Hez0F9iJT8Je0GDFeGHn0lLuPPG4a30k3vBmCCCKblnkYp+HFOPJw1JUcM+mBZv8jffh
         IYl0EjSNhg9dJCmOwkYiNIUadWprWzAPvtujGkjxXuxMIhJN3fe7VzrNWHBHrMYRe32G
         oAIg==
X-Gm-Message-State: ACrzQf1+OXiX5ms3CqopZXr8UJWzPKjXF8o9MKAWnUI9xs6ia/PABVyG
        NWZSMM1Jioa/RDqPb2546oLBVw==
X-Google-Smtp-Source: AMsMyM6d4d9UEcUbarBTqOcimdO4fhX+S9ZIQ+PNycGAaBaQZTVuUQHdnhU/14HYz93HVs9WNBULfw==
X-Received: by 2002:a17:902:d512:b0:178:2898:8099 with SMTP id b18-20020a170902d51200b0017828988099mr27694224plg.131.1664298464296;
        Tue, 27 Sep 2022 10:07:44 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y68-20020a623247000000b0053e7293be0bsm1991287pfy.121.2022.09.27.10.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:07:43 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:07:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: disable on 32-bit unless CONFIG_BROKEN
Message-ID: <YzMt24/14n1BVdnI@google.com>
References: <20220926165112.603078-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926165112.603078-1-pbonzini@redhat.com>
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

On Mon, Sep 26, 2022, Paolo Bonzini wrote:
> 32-bit KVM has extra complications in the code due to:
> 
> - different ways to write 64-bit values in VMCS
> 
> - different handling of DS and ES selectors as well as FS/GS bases
> 
> - lack of CR8 and EFER
> 
> - lack of XFD
> 

More for the list:

  - SVM is effectively restricted to PAE kernels due to NX requirements

> - impossibility of writing 64-bit PTEs atomically

It's not impossible, just ugly.  KVM could use CMPXCHG8B to do all of the accesses
for the TDP MMU, including the non-atomic reads and writes.

> The last is the big one, because it prevents from using the TDP MMU
> unconditionally.

As above, if the TDP MMU really is the sticking point, that's solvable.

The real justification for deprecating 32-bit KVM is that, outside of KVM developers,
literally no one uses 32-bit KVM.  I.e. any amount of effort that is required to
continue supporting 32-bit kernels is a complete waste of resources.
