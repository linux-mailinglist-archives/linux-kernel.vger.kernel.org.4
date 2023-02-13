Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B79694DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBMRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBMRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:16:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2071E9CB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676308538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO9yWwo9vtU3iHdmRXxQpw7q9DBKrgQFiJMFo0shriM=;
        b=Vcp8gVkNyGOil1dVKuSSkxRNNo+DyMbuKBRzUD85R5ouUwfgJNSIpvgqffi1gUnfXUKYVr
        h7oOS6wvEBZjY23OEToGyTkZegRrOttp9M9Axb54djY6rjAqjJnj6HmIkJe3sxzmNCqXdB
        BiWZM8P7uxWspqqPFLp4kFM1hRvJNQ0=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-57-KZyfCubCMXGhzJyuFQ8eow-1; Mon, 13 Feb 2023 12:15:34 -0500
X-MC-Unique: KZyfCubCMXGhzJyuFQ8eow-1
Received: by mail-vk1-f199.google.com with SMTP id bb21-20020a056122221500b003e20d9fec6dso4961786vkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676308534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO9yWwo9vtU3iHdmRXxQpw7q9DBKrgQFiJMFo0shriM=;
        b=1TkddQq0IceI0IzZ7pBX99seM+cqr3OO4+H0+coO5YeHT+ugwnvZDXY1kUg26db2Z6
         HS7xbKhNbgiYGT1pl7aNLNh4XVDJWSaH2WRjPjQ5KT2lAKwZ9ADAGX5ropDaT8Z1uyKo
         LiZ013W2VaDAbtiy0J3kVLN2wKtzu1PJaftYWA58oL78GE/Omf1kTbqV6fZUZTR51Z+a
         GtmEPU1tu1ajE+85DbfiKzO4vqKKtmm1WIlXgVxWooFvqKnkD+iIUiHRZ8nR9utbqql1
         MCnx9i4ZLf+FngGsUlqrbLA8CKZXmKIcRrYmspi+zVXkKceknj7WnlHN1Yz7satBT45J
         Y8bg==
X-Gm-Message-State: AO0yUKUZrxh9/gPG3zG1g00SatWtbUbZRdRQlIzsy45FzKOgs4xbcdjO
        8AQ89CvXuoJkRQY8bLuWWLQyQLIGiBwFkPTtK0GDBKwuaMsRWutumbU0Nzc8pqbGAmzCrBEJ9ID
        mY1W95WurCsJvfC5JA7OcOaPjUTvtMwkQf6lZkziJ
X-Received: by 2002:a1f:b685:0:b0:401:b0cc:f96f with SMTP id g127-20020a1fb685000000b00401b0ccf96fmr149914vkf.11.1676308534156;
        Mon, 13 Feb 2023 09:15:34 -0800 (PST)
X-Google-Smtp-Source: AK7set9SCfvG2pXjcynyi3JTNlAgUIexnHd1Ro0ps7FctoZkveGxkgYQ5kpx4sOfqRSiZHb0pjNBjmGb22dmQ3G0C0Y=
X-Received: by 2002:a1f:b685:0:b0:401:b0cc:f96f with SMTP id
 g127-20020a1fb685000000b00401b0ccf96fmr149909vkf.11.1676308533926; Mon, 13
 Feb 2023 09:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20230211091302.4576-1-lina@asahilina.net>
In-Reply-To: <20230211091302.4576-1-lina@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 17:15:18 +0000
Message-ID: <CAOgh=FzCOvv86HG=AhCBDW6cUHDnzq8UPBgmYPR12PNNMRNx0w@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: rtkit: Do not copy the reg state structure to
 the stack
To:     Asahi Lina <lina@asahilina.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
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

On Sat, 11 Feb 2023 at 09:21, Asahi Lina <lina@asahilina.net> wrote:
>
> The register state struct is 848 bytes, which ends up bloating the
> apple_rtkit_crashlog_dump_regs stack frame beyond 1024 on some
> 32-bit platforms, triggering compile warnings.
>
> This doesn't matter for 64BIT/ARM64, but there's also no good reason to
> copy the structure to the stack in this case. We can use __packed to
> avoid alignment issues, there are no double-read hazards, and this is a
> fatal error path so performance does not matter.
>
> Fixes: 22991d8d5725 ("soc: apple: rtkit: Add register dump decoding to crashlog")
> Signed-off-by: Asahi Lina <lina@asahilina.net>

LGTM, less copies too.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

> ---
>  drivers/soc/apple/rtkit-crashlog.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/soc/apple/rtkit-crashlog.c b/drivers/soc/apple/rtkit-crashlog.c
> index dfa74b32eda2..8319e365110b 100644
> --- a/drivers/soc/apple/rtkit-crashlog.c
> +++ b/drivers/soc/apple/rtkit-crashlog.c
> @@ -57,7 +57,7 @@ struct apple_rtkit_crashlog_regs {
>         u64 unk_X;
>         u64 esr;
>         u64 unk_Z;
> -};
> +} __packed;
>  static_assert(sizeof(struct apple_rtkit_crashlog_regs) == 0x350);
>
>  static void apple_rtkit_crashlog_dump_str(struct apple_rtkit *rtk, u8 *bfr,
> @@ -126,18 +126,18 @@ static void apple_rtkit_crashlog_dump_mailbox(struct apple_rtkit *rtk, u8 *bfr,
>  static void apple_rtkit_crashlog_dump_regs(struct apple_rtkit *rtk, u8 *bfr,
>                                            size_t size)
>  {
> -       struct apple_rtkit_crashlog_regs regs;
> +       struct apple_rtkit_crashlog_regs *regs;
>         const char *el;
>         int i;
>
> -       if (size < sizeof(regs)) {
> +       if (size < sizeof(*regs)) {
>                 dev_warn(rtk->dev, "RTKit: Regs section too small: 0x%zx", size);
>                 return;
>         }
>
> -       memcpy(&regs, bfr, sizeof(regs));
> +       regs = (struct apple_rtkit_crashlog_regs *)bfr;
>
> -       switch (regs.psr & PSR_MODE_MASK) {
> +       switch (regs->psr & PSR_MODE_MASK) {
>         case PSR_MODE_EL0t:
>                 el = "EL0t";
>                 break;
> @@ -160,11 +160,11 @@ static void apple_rtkit_crashlog_dump_regs(struct apple_rtkit *rtk, u8 *bfr,
>
>         dev_warn(rtk->dev, "RTKit: Exception dump:");
>         dev_warn(rtk->dev, "  == Exception taken from %s ==", el);
> -       dev_warn(rtk->dev, "  PSR    = 0x%llx", regs.psr);
> -       dev_warn(rtk->dev, "  PC     = 0x%llx\n", regs.pc);
> -       dev_warn(rtk->dev, "  ESR    = 0x%llx\n", regs.esr);
> -       dev_warn(rtk->dev, "  FAR    = 0x%llx\n", regs.far);
> -       dev_warn(rtk->dev, "  SP     = 0x%llx\n", regs.sp);
> +       dev_warn(rtk->dev, "  PSR    = 0x%llx", regs->psr);
> +       dev_warn(rtk->dev, "  PC     = 0x%llx\n", regs->pc);
> +       dev_warn(rtk->dev, "  ESR    = 0x%llx\n", regs->esr);
> +       dev_warn(rtk->dev, "  FAR    = 0x%llx\n", regs->far);
> +       dev_warn(rtk->dev, "  SP     = 0x%llx\n", regs->sp);
>         dev_warn(rtk->dev, "\n");
>
>         for (i = 0; i < 31; i += 4) {
> @@ -172,12 +172,12 @@ static void apple_rtkit_crashlog_dump_regs(struct apple_rtkit *rtk, u8 *bfr,
>                         dev_warn(rtk->dev,
>                                          "  x%02d-x%02d = %016llx %016llx %016llx %016llx\n",
>                                          i, i + 3,
> -                                        regs.regs[i], regs.regs[i + 1],
> -                                        regs.regs[i + 2], regs.regs[i + 3]);
> +                                        regs->regs[i], regs->regs[i + 1],
> +                                        regs->regs[i + 2], regs->regs[i + 3]);
>                 else
>                         dev_warn(rtk->dev,
>                                          "  x%02d-x%02d = %016llx %016llx %016llx\n", i, i + 3,
> -                                        regs.regs[i], regs.regs[i + 1], regs.regs[i + 2]);
> +                                        regs->regs[i], regs->regs[i + 1], regs->regs[i + 2]);
>         }
>
>         dev_warn(rtk->dev, "\n");
> --
> 2.35.1
>
>

