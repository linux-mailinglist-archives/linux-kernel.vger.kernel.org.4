Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144E167B62D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjAYPqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjAYPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDCC3867B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674661557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICOQ0lI4jayJOi1F8jmzacTe6AptwAx/4207AzFH5bw=;
        b=RhNDdKcO895Oq4aS8xdE8TNO/rPxdzGqx6Xbi9qpoLStN6bgDyOts38JoTk54X1xJfbh06
        pRSRZQWdi4o9gy/xW3rb3Wq/BSBKUV8PIJXw9dURq6uwVOr23HFfbJSy4bCH6ySCwpeZIq
        judDaSfx0+fBOgEsqesMrQ/BM0vuS80=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-qFP8qDUDOjGRoPCQhAf-dQ-1; Wed, 25 Jan 2023 10:45:55 -0500
X-MC-Unique: qFP8qDUDOjGRoPCQhAf-dQ-1
Received: by mail-wm1-f71.google.com with SMTP id az37-20020a05600c602500b003da50af44b3so11126720wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICOQ0lI4jayJOi1F8jmzacTe6AptwAx/4207AzFH5bw=;
        b=STLBA3H9fXMsH+V4McI1LSWqx63j6djadrikLNu6MWsU5v71TKrX4JUlv16tIjy9pV
         ht1LyIm5dP+bOiYnQgGNfs1XkmEz0PabkQWS8bf6vE1laAxYtj2UuAS3HZh12dtSn4L/
         0dSFiT8za8dWbXY8H4UfveE118YQA9OTso/sXywqxhR+vvTwtEHl0of3yoMvJWC1RHm2
         L50gqHBEvuN3y0Knlm7QxkeUS82NG+L/xmSPHReyRPNL+tDvllKB4xU6b+kRrYcVYqeM
         uq+bPUZtSxqsU0PHC3qgfOR3v5LXX40Ms6JkjyyBXPHd+uRxP72E49F3zUSsd0PdCgAP
         VOjA==
X-Gm-Message-State: AFqh2koNp3ouuL3W+oReh7Y4sQQ316G1Mct0rwX2bvppHSPd7h9CbJeR
        Zezl8NsmvLevDqdSdnmhd2yaIi6IZLn9ehOEpcLMgMWSW36KVUgOwfi3TKOeWLeeDDoQvSJ0qcq
        Itn0V9U7Ts9LWu1i6uTJ2qlHq
X-Received: by 2002:a05:600c:5021:b0:3d9:9755:d659 with SMTP id n33-20020a05600c502100b003d99755d659mr32291946wmr.22.1674661554323;
        Wed, 25 Jan 2023 07:45:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt4r3o4JC6sVvG5SGoomw0+ADd/Yrj1/OUW7gKaL25MnQJnEVdJ/foP+g2R3Vzo9Pg6b8EB1g==
X-Received: by 2002:a05:600c:5021:b0:3d9:9755:d659 with SMTP id n33-20020a05600c502100b003d99755d659mr32291918wmr.22.1674661554080;
        Wed, 25 Jan 2023 07:45:54 -0800 (PST)
Received: from redhat.com ([2.52.134.175])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003da28dfdedcsm3022846wms.5.2023.01.25.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:45:53 -0800 (PST)
Date:   Wed, 25 Jan 2023 10:45:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <20230125103816-mutt-send-email-mst@kernel.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <Y9FHsvVoPbgMR2s3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FHsvVoPbgMR2s3@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 04:16:02PM +0100, Greg Kroah-Hartman wrote:
> Everyone wants a subset, different from other's subset, which means you
> need them all.  Sorry.

Well if there's a very popular system (virtual in this case) that needs
a specific config to work well, then I guess
arch/x86/configs/ccguest.config or whatever might be acceptable, no?
Lots of precedent here.

-- 
MST

