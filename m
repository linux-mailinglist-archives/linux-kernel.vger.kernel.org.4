Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF4C677AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjAWMTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjAWMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:19:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720C185
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674476308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OTvM8/77WaGvjImfyYI2+yBLtvSlGUW8L2vfPjCZgjQ=;
        b=BnWXVgXtxAdJGu3knIqB7kqFJX2JnsuAWjPcJKJZvwbzMe1llVCU1e3nKKQXO4tUyMUoMT
        EzRbqS1fzprU6c8NcKR3BRl6Ix0MACZH2AEnDZUNEPmITj2dRMYgR6ZbG9Leginnsl/pvK
        Jl11mmQxLAlAWsaPRCJv4ExdILZdGLY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-459-_uz6V6izNRe03qKm6xf4hA-1; Mon, 23 Jan 2023 07:18:27 -0500
X-MC-Unique: _uz6V6izNRe03qKm6xf4hA-1
Received: by mail-vs1-f69.google.com with SMTP id h63-20020a676c42000000b003d2301bce83so2838282vsc.20
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTvM8/77WaGvjImfyYI2+yBLtvSlGUW8L2vfPjCZgjQ=;
        b=gXnNWO95IEv688V2lj/soj9Zt9/uY0yiXF5rCoi/iFaFJNOGJJ9zF+YNbMG4v65ezo
         3WE6fVdMkItsE2zvDpfzAhWeV8veU/D3Rb7BFKJEyKEc5NwbJam3lSC9t52quFTZw488
         t/iTlyVUFhp7sblcgdftR6kHdZ4Pm1zEV4vxc2WkujfiIqJjdT025lCqBD2KzIWbcklW
         1MCMkC2fBX86ZOMA/ma17rsO6ApLyfqnE2Sl9by8/3bOyF1/9ff05dQmLfDDpbm/WIxS
         Y3NgiH95MZmE003kvQD6Q0+fTf86PRVnSJowtn2ckIC7oZMRHMiF7tB/uvR3DshP1UiW
         KZCg==
X-Gm-Message-State: AFqh2krsQ4BnamBQ9TLYKO0W2uPgXhF+HacSHgGuHrU35KWOrxOg8ky6
        db9jmR/EihngAJkvMdA9Ztea8cMi9s7Rn4MAzSGFshAgDZCXZqMo6BvDL655P7u11aIozqcUQc1
        L1YKvVnsm0/oXz1t6amjDzVej/D0sJHkbhN5PQgxI
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id g4-20020a67ea04000000b003d3ec781d72mr3839871vso.13.1674476307029;
        Mon, 23 Jan 2023 04:18:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsBByYTQiJlB1d+EY544N/VIJAqFf98IvridQlCPyx/yyru+q8aplGCCsHFyoh+gzwZPnFE94gRlY65q31SCow=
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id
 g4-20020a67ea04000000b003d3ec781d72mr3839868vso.13.1674476306787; Mon, 23 Jan
 2023 04:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20230123031728.22515-1-lina@asahilina.net>
In-Reply-To: <20230123031728.22515-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 23 Jan 2023 12:18:10 +0000
Message-ID: <CAOgh=FwHc_sy5dfQo8OvnG+gfy6UpW08a6qA7R9ErytG83NHrQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: apple: rtkit: Add register dump decoding to crashlog
To:     Asahi Lina <lina@asahilina.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Mon, 23 Jan 2023 at 03:19, Asahi Lina <lina@asahilina.net> wrote:
>
> When the coprocessor crashes, it's useful to get a proper register dump
> so we can find out what the firmware was doing. Add a decoder for this.
>
> Originally this had ESR decoding by reusing the ARM64 arch header for
> this, but that introduces some module linking and cross-arch compilation
> issues, so let's leave that out for now.
>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> Reviewed-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

I would be thinking, rather that duplicating the PSR_MODE_* defines
and values, why not just ifdef the whole
"apple_rtkit_crashlog_dump_regs(" function and the "case
APPLE_RTKIT_CRASHLOG_REGS" part (and maybe even
apple_rtkit_crashlog_regs struct also). Is it worth compiling that
code on other CPU architectures when PSR seems to be an ARM specific
thing?

But this way also works with a little duplication so happy to give
this tag, the above change is optional, but it would be less code and
less duplication!

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

>  drivers/soc/apple/rtkit-crashlog.c | 93 ++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/drivers/soc/apple/rtkit-crashlog.c b/drivers/soc/apple/rtkit-crashlog.c
> index 732deed64660..dfa74b32eda2 100644
> --- a/drivers/soc/apple/rtkit-crashlog.c
> +++ b/drivers/soc/apple/rtkit-crashlog.c
> @@ -13,6 +13,17 @@
>  #define APPLE_RTKIT_CRASHLOG_VERSION FOURCC('C', 'v', 'e', 'r')
>  #define APPLE_RTKIT_CRASHLOG_MBOX FOURCC('C', 'm', 'b', 'x')
>  #define APPLE_RTKIT_CRASHLOG_TIME FOURCC('C', 't', 'i', 'm')
> +#define APPLE_RTKIT_CRASHLOG_REGS FOURCC('C', 'r', 'g', '8')
> +
> +/* For COMPILE_TEST on non-ARM64 architectures */
> +#ifndef PSR_MODE_EL0t
> +#define PSR_MODE_EL0t  0x00000000
> +#define PSR_MODE_EL1t  0x00000004
> +#define PSR_MODE_EL1h  0x00000005
> +#define PSR_MODE_EL2t  0x00000008
> +#define PSR_MODE_EL2h  0x00000009
> +#define PSR_MODE_MASK  0x0000000f
> +#endif
>
>  struct apple_rtkit_crashlog_header {
>         u32 fourcc;
> @@ -31,6 +42,24 @@ struct apple_rtkit_crashlog_mbox_entry {
>  };
>  static_assert(sizeof(struct apple_rtkit_crashlog_mbox_entry) == 0x18);
>
> +struct apple_rtkit_crashlog_regs {
> +       u32 unk_0;
> +       u32 unk_4;
> +       u64 regs[31];
> +       u64 sp;
> +       u64 pc;
> +       u64 psr;
> +       u64 cpacr;
> +       u64 fpsr;
> +       u64 fpcr;
> +       u64 unk[64];
> +       u64 far;
> +       u64 unk_X;
> +       u64 esr;
> +       u64 unk_Z;
> +};
> +static_assert(sizeof(struct apple_rtkit_crashlog_regs) == 0x350);
> +
>  static void apple_rtkit_crashlog_dump_str(struct apple_rtkit *rtk, u8 *bfr,
>                                           size_t size)
>  {
> @@ -94,6 +123,66 @@ static void apple_rtkit_crashlog_dump_mailbox(struct apple_rtkit *rtk, u8 *bfr,
>         }
>  }
>
> +static void apple_rtkit_crashlog_dump_regs(struct apple_rtkit *rtk, u8 *bfr,
> +                                          size_t size)
> +{
> +       struct apple_rtkit_crashlog_regs regs;
> +       const char *el;
> +       int i;
> +
> +       if (size < sizeof(regs)) {
> +               dev_warn(rtk->dev, "RTKit: Regs section too small: 0x%zx", size);
> +               return;
> +       }
> +
> +       memcpy(&regs, bfr, sizeof(regs));
> +
> +       switch (regs.psr & PSR_MODE_MASK) {
> +       case PSR_MODE_EL0t:
> +               el = "EL0t";
> +               break;
> +       case PSR_MODE_EL1t:
> +               el = "EL1t";
> +               break;
> +       case PSR_MODE_EL1h:
> +               el = "EL1h";
> +               break;
> +       case PSR_MODE_EL2t:
> +               el = "EL2t";
> +               break;
> +       case PSR_MODE_EL2h:
> +               el = "EL2h";
> +               break;
> +       default:
> +               el = "unknown";
> +               break;
> +       }
> +
> +       dev_warn(rtk->dev, "RTKit: Exception dump:");
> +       dev_warn(rtk->dev, "  == Exception taken from %s ==", el);
> +       dev_warn(rtk->dev, "  PSR    = 0x%llx", regs.psr);
> +       dev_warn(rtk->dev, "  PC     = 0x%llx\n", regs.pc);
> +       dev_warn(rtk->dev, "  ESR    = 0x%llx\n", regs.esr);
> +       dev_warn(rtk->dev, "  FAR    = 0x%llx\n", regs.far);
> +       dev_warn(rtk->dev, "  SP     = 0x%llx\n", regs.sp);
> +       dev_warn(rtk->dev, "\n");
> +
> +       for (i = 0; i < 31; i += 4) {
> +               if (i < 28)
> +                       dev_warn(rtk->dev,
> +                                        "  x%02d-x%02d = %016llx %016llx %016llx %016llx\n",
> +                                        i, i + 3,
> +                                        regs.regs[i], regs.regs[i + 1],
> +                                        regs.regs[i + 2], regs.regs[i + 3]);
> +               else
> +                       dev_warn(rtk->dev,
> +                                        "  x%02d-x%02d = %016llx %016llx %016llx\n", i, i + 3,
> +                                        regs.regs[i], regs.regs[i + 1], regs.regs[i + 2]);
> +       }
> +
> +       dev_warn(rtk->dev, "\n");
> +}
> +
>  void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size)
>  {
>         size_t offset;
> @@ -140,6 +229,10 @@ void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size)
>                         apple_rtkit_crashlog_dump_time(rtk, bfr + offset + 16,
>                                                        section_size);
>                         break;
> +               case APPLE_RTKIT_CRASHLOG_REGS:
> +                       apple_rtkit_crashlog_dump_regs(rtk, bfr + offset + 16,
> +                                                      section_size);
> +                       break;
>                 default:
>                         dev_warn(rtk->dev,
>                                  "RTKit: Unknown crashlog section: %x",
> --
> 2.35.1
>

