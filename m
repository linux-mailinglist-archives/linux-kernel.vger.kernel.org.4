Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77B676CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAVMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjAVMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD21ABCA
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674389779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rXwZ5IpRiYOpk4BxqOLDiJBQ1xame8DGBmk28ubnqrM=;
        b=EOxMFGRJxQS23LUEbd53cuVgp9Ci8F14jZ2Qs6RNQIkPM5jf1Om1iZg3kxXbxmTxkw6oQm
        c6QGTObQHcHd9zonRHJR9vNXiehUxoimyYaPs6brTHOjJVe3UoBKCU7/RgisFxQNGTQEgz
        izvVsD6I9Jj0d9yiYkUmJZmPM3w03ec=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-pyTtpBOoM0a66DEbgV-WXQ-1; Sun, 22 Jan 2023 07:16:17 -0500
X-MC-Unique: pyTtpBOoM0a66DEbgV-WXQ-1
Received: by mail-vk1-f197.google.com with SMTP id f123-20020a1f9c81000000b003e1a7591524so3718198vke.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXwZ5IpRiYOpk4BxqOLDiJBQ1xame8DGBmk28ubnqrM=;
        b=RD64/BxhttJYD96alMxkwypTUTrli/dsFVel3WHcCXI0cYDl7Rr3k3zk81ddZoIjTf
         4IpMiFDAbIGHh4Balu/DLnMdocdXTCLY/Tybx4OvvVnNzeScYu3BChzZvxBkh+9S8P2p
         RdFSVd3aS7fWhMFMR4YwBRKKJdrcLm5KX/3ws08HvZ5Gu8BkoxAKF9/c82ush4Z9nj/z
         eDQEDKU8xLXk3yPJBRmgdbgnhIIPooSiJlT1mcaJvBrKx7b3ziZkzvXlIR1e25UDLgZ+
         dT9625yiZCa1amxEy1v9R7YFfi/XGWh96SvvB+MJYt3Ubq/B/MMztMhloxToFprte34C
         gQnQ==
X-Gm-Message-State: AFqh2kpDeaLk7bfdw6HBqISypAXQIIWxffXIXyIKSbRA4oWt6+sgZt/p
        kTHkhX6fc1KWwWVyOt1HEgAD3xcQLRBD8BF3/xJydWU6l0NTTtRq7i3wX1VgjxBL8hUpntdEME0
        B7l6YBREv1txcWpPGbXpZgQ9P/NSlM7f5hfg/AyAm
X-Received: by 2002:a67:e992:0:b0:3d2:e26a:d76f with SMTP id b18-20020a67e992000000b003d2e26ad76fmr2567177vso.41.1674389776840;
        Sun, 22 Jan 2023 04:16:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt8RUTbUD2yYmQlhCh6ICsxMQJZgQco/EAGYx4CajKySDnAqSNvz1kUZi1oL2Ez+ij8lioHGTWMAHPAEv1502o=
X-Received: by 2002:a67:e992:0:b0:3d2:e26a:d76f with SMTP id
 b18-20020a67e992000000b003d2e26ad76fmr2567173vso.41.1674389776614; Sun, 22
 Jan 2023 04:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20230121073741.3807-1-lina@asahilina.net>
In-Reply-To: <20230121073741.3807-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sun, 22 Jan 2023 12:16:00 +0000
Message-ID: <CAOgh=FxN=5dvxvUm=Fj-6hVuieN6GFnfG96F9c9=td6B8OvP3g@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: rtkit: Add register dump decoding to crashlog
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

On Sat, 21 Jan 2023 at 07:48, Asahi Lina <lina@asahilina.net> wrote:
>
> When the coprocessor crashes, it's useful to get a proper register dump
> so we can find out what the firmware was doing. Add a decoder for this.
>
> Originally this had ESR decoding by reusing the ARM64 arch header for
> this, but that introduces some module linking and cross-arch compilation
> issues, so let's leave that out for now.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Signed-off-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/soc/apple/rtkit-crashlog.c | 83 ++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/drivers/soc/apple/rtkit-crashlog.c b/drivers/soc/apple/rtkit-crashlog.c
> index 732deed64660..e29ef0a80ab8 100644
> --- a/drivers/soc/apple/rtkit-crashlog.c
> +++ b/drivers/soc/apple/rtkit-crashlog.c
> @@ -13,6 +13,7 @@
>  #define APPLE_RTKIT_CRASHLOG_VERSION FOURCC('C', 'v', 'e', 'r')
>  #define APPLE_RTKIT_CRASHLOG_MBOX FOURCC('C', 'm', 'b', 'x')
>  #define APPLE_RTKIT_CRASHLOG_TIME FOURCC('C', 't', 'i', 'm')
> +#define APPLE_RTKIT_CRASHLOG_REGS FOURCC('C', 'r', 'g', '8')
>
>  struct apple_rtkit_crashlog_header {
>         u32 fourcc;
> @@ -31,6 +32,24 @@ struct apple_rtkit_crashlog_mbox_entry {
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
> @@ -94,6 +113,66 @@ static void apple_rtkit_crashlog_dump_mailbox(struct apple_rtkit *rtk, u8 *bfr,
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
> +               dev_warn(rtk->dev, "RTKit: Regs section too small: 0x%lx", size);
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
> @@ -140,6 +219,10 @@ void apple_rtkit_crashlog_dump(struct apple_rtkit *rtk, u8 *bfr, size_t size)
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
>

