Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD0677154
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjAVSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAVSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A818B13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674410781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gilSQUvE0dUGEHMO/XtvnPFafetpB0grkVw7U+QJUzQ=;
        b=SlLFIxKqd2GBO+nSIDjyCF1JL7L8kHWSeCbENE8AkND2v1j5YD1+Alah2C/EFZ+hlOHY7K
        Vh1NxEwplVjtg3J9IvUyJ1w1Gol/N9WEw9dS1qPx5oS91bKnnsYzboZVXp4FDKiiSumI7n
        FxQEFMLiEh32vZyx6HVKu98Av0uW10k=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-Y3_lGBzHNZyOfUIywgKTRA-1; Sun, 22 Jan 2023 13:06:20 -0500
X-MC-Unique: Y3_lGBzHNZyOfUIywgKTRA-1
Received: by mail-vk1-f198.google.com with SMTP id s203-20020a1f2cd4000000b003d5b4915319so4052096vks.18
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 10:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gilSQUvE0dUGEHMO/XtvnPFafetpB0grkVw7U+QJUzQ=;
        b=XiMv6qglksN76zjqYSW1gBKFqUtgCJzhjK07nZZ2eTQ22t2/DiGRpByPzc1I4Z3Mes
         dsJfwvqIKXU5uXqZjlSwJLvVRMssEeu+5iDJaVyEbSb0l0OKXkXBf00XhffnraV+Hm6B
         MyfyTWuxVPYoBPuxMHQHOKIlwY5fYiYhWFSorZYElrXKgkdNi3F+uHjSvTu95hKIR9lr
         Ayq8yOtJy69P7gdflP6NwdIkZRYAwnhxNosQutjqSsC6C+CsuoihQLt6RVDWG0WYd87/
         rZ5ZTtd8Dty2OAZ2No7GMtyf3ZQV3O9Gyi0eKVsIBjooR5SrM5bxOvtnGAy3TvzxW0iQ
         qRbA==
X-Gm-Message-State: AFqh2kq4nIhVHkZ1y1LeZnyiiKcwAkoJceV5AHYRjcOzzG7lxtQslHlt
        eAfCDICH/2JIMZBWlcWucdV5Tv0B2u2+PZUsNChbjUoDE2bOFHMT2nUe14ZqkIze59aLPmsO23s
        M7nJF1cXN7er0t6LqTUJVAL0fDCB1JZU+XjASX5z0
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id g4-20020a67ea04000000b003d3ec781d72mr3478178vso.13.1674410779569;
        Sun, 22 Jan 2023 10:06:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtdEmTjJ/77UQcMCuunhBnfuNGkKR8+9PcjJwqdU/ksxBjUNeRj0TYyLMQaM2OYpT3rGQwrAKx3J7Byfkg0ByI=
X-Received: by 2002:a67:ea04:0:b0:3d3:ec78:1d72 with SMTP id
 g4-20020a67ea04000000b003d3ec781d72mr3478175vso.13.1674410779366; Sun, 22 Jan
 2023 10:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20230121073741.3807-1-lina@asahilina.net>
In-Reply-To: <20230121073741.3807-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sun, 22 Jan 2023 18:06:03 +0000
Message-ID: <CAOgh=FwK=L3Cc+yqVPuki0e__8-omdjppKy_Z5DJAKh4c7uahQ@mail.gmail.com>
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

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

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

