Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01A763F648
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLARkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLARkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810B5DB8C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669916384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SozBPIbJb2UCYQ0LnWyqv+b8uP4TnIspTEbWHeE9j9k=;
        b=eohDkD2c7BMJEFdqM/JbH6mWizqOv4SGdp43q5rhmPERbzyuPg9merbreBxFlnIDxqtkWe
        KOUh0tvBU+QPNaBNxrPcYgnnxy2yGQdf0b2zou8gz/lBxiCw25ks0OxyaNrk+MeiXIrXuQ
        jwHCmLZC3WB5RU1DIPKB34L3Es+7Rl8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-nKCY4PkfPIai_UYYU_JiVA-1; Thu, 01 Dec 2022 12:39:43 -0500
X-MC-Unique: nKCY4PkfPIai_UYYU_JiVA-1
Received: by mail-io1-f71.google.com with SMTP id f23-20020a5d8157000000b006dfb209094fso2176893ioo.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SozBPIbJb2UCYQ0LnWyqv+b8uP4TnIspTEbWHeE9j9k=;
        b=nLKVK9XfiGJ6W98CDoMTjqAkfHDVrx8vWSGG36H6+z8omGCeDx0JjGP38F5RAFhLlq
         vMdz7yVp43OHwP+cG4yOonS/YcQH2Siq4Or9VcWiQs48jRCX18pdAxwjmnaR4LgvQ5dI
         JmZ0b2V2qws84DRPgQRtKBYwWwRhSThMATMFN1KENZdUeUYerqRlPzfFq9Y4rg0SWS7T
         ypap3zCXunE5Ntkx/tK0aHv0Z5B6MyYFo9r0jK2x8FVkwLWS2wnJrLfnj+/Vt5XmZZBC
         bCSce9qfKrQdWyqhVSR4Jw0Ai5fVatDbwYwkY3l0Wa/b4AaJ3NJtVRHMfob78mPtfO5h
         h+ew==
X-Gm-Message-State: ANoB5pnOxxcmxK7cRfxbx+KZC3fT7rzf5nhdprhRyCFg56KLTezdqtGv
        PrbOQlrbz66Hnv5WCgiIneUyOJhqZcu4ivyTEPt8NOHLDBTjMhE+Fphngy2ILDw9UEJLFt6Eggw
        to1cRsfYBqPaDJ/Ibd/rIWfDOF8OL/1GNZ80uEErT
X-Received: by 2002:a02:999a:0:b0:388:375a:9011 with SMTP id a26-20020a02999a000000b00388375a9011mr6429263jal.84.1669916381409;
        Thu, 01 Dec 2022 09:39:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ybWZZe1siMmv1qu+701M82c9gUy5g0uXmn8Z04LHA/nwl84gldlRq3c0TBSkhy2DRED6vruqXbGIDsdxo37c=
X-Received: by 2002:a02:999a:0:b0:388:375a:9011 with SMTP id
 a26-20020a02999a000000b00388375a9011mr6429246jal.84.1669916381102; Thu, 01
 Dec 2022 09:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20221121104403.1545f9b5@gandalf.local.home> <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic> <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home> <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org> <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
In-Reply-To: <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 1 Dec 2022 18:39:29 +0100
Message-ID: <CAO-hwJ+PyqBPAO-3MmR+WFKiRzX-FPd41uNR5tX9sgtgdyf2Og@mail.gmail.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
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

On Thu, Dec 1, 2022 at 5:59 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 30, 2022 at 2:37 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 22 Nov 2022 14:51:08 -0500 Chris Mason <clm@meta.com> wrote:
> >
> > > On 11/22/22 1:29 PM, Steven Rostedt wrote:
> > > > On Tue, 22 Nov 2022 12:42:33 -0500
> > > > Chris Mason <clm@meta.com> wrote:
> > > >
> > > >> On 11/22/22 5:39 AM, Borislav Petkov wrote:
> > > >>> On Mon, Nov 21, 2022 at 03:36:08PM -0800, Alexei Starovoitov wrote:
> > > >>>> The commit log is bogus and the lack of understanding what
> >
> > Why am I not understanding the controversy here?  With this patch
> > applied, people who want function error injection enable
> > CONFIG_FUNCTION_ERROR_INJECTION and people who don't want it don't do
> > that.
> >
> > Alexei, can you please suggest a less bogus changelog for this?
>
> People are using ALLOW_ERROR_INJECTION to allowlist kernel functions
> where bpf progs can attach.
> For example in the linux-next:
> git grep ALLOW_ERROR_INJECTION
> drivers/hid/bpf/hid_bpf_dispatch.c:ALLOW_ERROR_INJECTION(hid_bpf_device_event,
> ERRNO);
> drivers/hid/bpf/hid_bpf_dispatch.c:ALLOW_ERROR_INJECTION(hid_bpf_rdesc_fixup,
> ERRNO);
> drivers/hid/bpf/hid_bpf_jmp_table.c:ALLOW_ERROR_INJECTION(__hid_bpf_tail_call,
> ERRNO);

To be completely honest, I mark hid_bpf_device_event and
hid_bpf_rdesc_fixup as ALLOW_ERROR_INJECTION only to have a dedicated
function to create a SEC("fmod_ret"), but I am actually only using
__hid_bpf_tail_call() to call the bpf programs.

So technically, I should be able to not use ALLOW_ERROR_INJECTION but
that would mean manually calling the BPF programs from
__hid_bpf_tail_call() instead of relying on the magic of libbpf, but
also would force me to have an other way of telling these 2 other
functions are fmod_ret capable, which would be definitely not clean.

>
> The hid-bpf framework depends on it.
> iirc Benjamin mentioned that chromeos is one of the future users
> of hid-bpf. They need it to deal with a variety of quirks in hid
> devices in production.
>
> Either hid-bpf or bpf core can add
> "depends on FUNCTION_ERROR_INJECTION"
> to its kconfig.
> Like:
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index 2dfe1079f772..281e5263f3d1 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -32,6 +32,7 @@ config BPF_SYSCALL
>         select BINARY_PRINTF
>         select NET_SOCK_MSG if NET
>         select PAGE_POOL if NET
> +       depends on FUNCTION_ERROR_INJECTION
>         default n

FWIW, this is what I'm going to apply in hid.git for the time being
[0]. But I'd rather have a BPF_HAVE_FMOD_RET as suggested in [1].

>
> but the better option for now would be to drop this patch.
> For the next next merge window we can come up with alternative way
> (instead of ALLOW_ERROR_INJECTION) to mark kernel functions
> purely on the bpf side.
> I don't think we have time to add this marking infrastructure
> for the upcoming merge window.
>

Outside of the "should we add ALLOW_ERROR_INJECTION in production
environments", all I care about is that I want to be able to attach
SEC("fmod_ret/...") on a specific set of functions that I control. So
for me, I don't need to full "let's randomly add errors in any
functions" (which I doubt you can do with ALLOW_ERROR_INJECTION
anyway), I just need to be able to say "I want a bpf program to be
able to change the return code of this dedicated function".

So I agree with Alexei here. The situation has been to enable this
parameter for quite some time without any complaints, and this patch
prevents HID-BPF to be enabled on systems where sysadmins would think
this is unsafe. Postponing this patch to the next merge window will
give enough time for the BPF folks to change their implementation.

Cheers,
Benjamin

[0] https://lore.kernel.org/linux-input/7df26319-f4ee-6dd1-a1b8-1caaf595528d@nvidia.com/T/#m9416ad54e2ef63244585c4ef83d07bebedf6e143
[1] https://lore.kernel.org/linux-input/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com/

