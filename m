Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE663D111
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiK3Iu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiK3IuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:50:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74BA2981D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669798169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xANXvbQ7iywMEyVlB4xJE5gylEi2EmdID1HL+8vvXPE=;
        b=PxZyN/eC3+mCkrwvSLGUbQ8yNBTLufUh1mglHN4SGUmv1OWG4g4LQt8p+FSPRvgAqMZpvm
        2R0jUc1dIPgCCgmuWw/DdpPQuCIXowQpYrvqtbjcd9zeb4eTH1pSXoGpWcBL7cOEuPypBL
        tsW1zz0bJ7r1+0Gfnuqwcbgu6xwUa9Y=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-zZI-usHNPLqw4EYCeP0LoA-1; Wed, 30 Nov 2022 03:49:28 -0500
X-MC-Unique: zZI-usHNPLqw4EYCeP0LoA-1
Received: by mail-il1-f197.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so14963911ilv.23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xANXvbQ7iywMEyVlB4xJE5gylEi2EmdID1HL+8vvXPE=;
        b=Fso4f0CBC2xAj2a44EEVRpSYqNiw1gD/ACra8Xht33Ju/cXabjHRFge6WNN34vZFC5
         q4wT5tvkmyOxAq7C+f4FZzVaKVxhOpvH0wYqhIS/oYU2eTcY1j82mbfsKddecVMyxWXQ
         o2pnG6396dPnWzD5SLKf4kSYKL3Fh8VzBAQxvFITqu8Q0MIbHIGNxdpxaaEvdfnOM5/Q
         soAwzkgo+rgaAR8OU9a4I+ax4mwtw6yhp3ugEoCisN2lqJ/9kGV5Jqen5/2ZbzKADPVv
         ecVjGh3QioLxds0nhi9GEnxcb5loOy0gvUEZ5HpdSiwsIkntCq2CuYbewWlHO+vwZ8Gd
         gsig==
X-Gm-Message-State: ANoB5pmr1Di+vFXKJBq2nMk1SrT2rAHCbPFC1rHYz/QvwtJmZ1i84lP6
        5zbZZnS3cwEYuOaTUJFVeEPx5UXD0t41sXq2hi6ed0lBvORVFm8jMz55cTkD/U9TdrsGsu81Mun
        kJ5Sa37wYERcl3YWOY8xwWDi0R5nDxvTnUzp/wOZB
X-Received: by 2002:a02:c737:0:b0:375:1c5f:3127 with SMTP id h23-20020a02c737000000b003751c5f3127mr19645304jao.251.1669798167861;
        Wed, 30 Nov 2022 00:49:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7SN6S5FthjsMHHZOOe/zeRLlQAj+dr+Vd7yWgLU3oWLPsaRFF+jtmM/MiCe0/FyZMhWdA7awXCX70M14aatZE=
X-Received: by 2002:a02:c737:0:b0:375:1c5f:3127 with SMTP id
 h23-20020a02c737000000b003751c5f3127mr19645276jao.251.1669798167237; Wed, 30
 Nov 2022 00:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com> <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
 <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
 <CAADnVQ+kE+EJ9LAfwge9ksC0LR8r+ShQNYi5g-MDajufXq8Yxw@mail.gmail.com>
 <CAO-hwJJGxvrLRGSt7g0T1rYiuCCigVzQ-L6yKLM1-44EpYqmsQ@mail.gmail.com> <CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com>
In-Reply-To: <CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 30 Nov 2022 09:49:16 +0100
Message-ID: <CAO-hwJJz8KpWYbnbK6eJQDzwcY2zsBzEyACnEQ3GzEbMZSiA7g@mail.gmail.com>
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
To:     Florent Revest <revest@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        KP Singh <kpsingh@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 7:00 PM Florent Revest <revest@chromium.org> wrote:
>
> On Thu, Nov 24, 2022 at 4:50 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 9:14 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 6:53 AM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > Hi Jon,
> > > >
> > > > On Wed, Nov 23, 2022 at 2:25 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > > >
> > > > > We have a kernel test that checks for new warning and error messages on
> > > > > boot and with this change I am now seeing the following error message on
> > > > > our Tegra platforms ...
> > > > >
> > > > >   WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13
> > > > >
> > > > > I have a quick look at the code, but I can't say I am familiar with
> > > > > this. So I wanted to ask if a way to fix this or avoid this? I see the
> > > > > code returns 0, so one option would be to make this an informational or
> > > > > debug print.
> > > >
> > > > I am not in favor of debug in that case, because I suspect it'll hide
> > > > too much when getting a bug report. Informational could do, yes.
> > > >
> > > > However, before that, I'd like to dig a little bit more on why it is
> > > > failing. I thought arm64 now has support of tracing bpf programs, so I
> > > > would not expect this to fail.
>
> We have BPF trampolines on arm64 already but no ftrace direct calls
> right now. (so trampolines get jitted but don't get called eheh :)) So
> indeed BPF tracing programs (fentry/fexit/fmod_ret) do not work on
> arm64 at the moment.

Oh, OK. Thanks for the explanation.

>
> > > Unfortunately the patches to add support for such tracing bpf progs got stuck.
> > > Florent/Mark can probably share the latest status.
>
> We are working on an implementation of ftrace direct calls that would
> fit within the constraints of arm64 and play nice with the other users
> of the ftrace call site. Hopefully we have a patch to share in the
> next couple of weeks I'd say!

yay!

>
> > Oh... I noticed Jon's config was lacking CONFIG_FTRACE. So should I
> > also add a depends on CONFIG_FTRACE to enable HID-BPF?
>
> If HID-BPF fundamentally depends on a fmod_ret program being attached
> to function, it seems to me that it should depend on both:
>     CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS (CONFIG_FTRACE or even
> CONFIG_DYNAMIC_FTRACE aren't enough, there can be architectures that
> do not support direct calls. here you noticed it on arm64 which
> luckily should get fixed someday soon but there could be other
> architectures with that issue too)
> and

OK

>     CONFIG_FUNCTION_ERROR_INJECTION (since [1] error injection needs
> to be explicitly opted-in, it's easy to miss it and fail to attach
> fmod_ret programs in mysterious ways)

Ok as well.

>
> I'm thinking that maybe encoding these two dependencies in the
> CONFIG_HID_BPF is leaking too much of the bpf tracing abstraction to
> the user. Maybe the BPF Kconfig could provide "proxy" configs like
> HAVE_BPF_FENTRY_FEXIT, HAVE_BPF_FMOD_RET (naming is hard) to expose
> these dependencies better ?

That would be nice, but requires some sort of synchronization between
our 2 trees, so I'll take the 2 configs in the HID tree, and try to
submit a patch for the bpf tree with the macro. Then I can reattach to
that macro when it hits Linus'.

>
> 1: https://lore.kernel.org/lkml/20221121104403.1545f9b5@gandalf.local.home/
>

That thread is a little bit worrying to me. HID-BPF relies on
CONFIG_FUNCTION_ERROR_INJECTION, and I would definitely like to see
HID-BPF in production kernels. I don't really care about cloud
servers, but chromebooks are something I'd like to have enabled. We'll
see how this thread goes I guess.

Anyway, thanks a lot for the deep explanation and understanding of my code :)

Cheers,
Benjamin

