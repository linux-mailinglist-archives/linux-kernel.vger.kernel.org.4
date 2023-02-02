Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4F687469
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjBBEZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBEZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:25:36 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F47179F27
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:25:35 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r28so495340oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 20:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itM99aOoffDXT1O5rNhUQjy644OJmOL9qTSRIo99X4I=;
        b=YAD4HvTVI7glrN6D2XU9h1GqUTiuCTOtS+nA3p9ZWmbHAbhpbWxYn/rqmJDWeWlwph
         IMDww2JOtOIAMPikhL/p3A+2/06V1htwx0d9CFfkOZwdxrBo2WtdH5E3HFJt1Svs/sW6
         oeCH2Zh4vlim2iVuLMzZnyNN46lKNSq3afE4PM6bCnUBJaX7C9lD2gfQlXQYGj+p9orD
         D1t622glKs6peVanR55ALznuwnL5q2tSoPg7qpr8C5TCXO+EIPyfylhGWOIVYFWO+8QZ
         eHji2KRR+Eaev3gfugiYu4STgORfF70Qd/fbJDc12kFq4j978tzfn8sy2piFcTP2+oIM
         IHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itM99aOoffDXT1O5rNhUQjy644OJmOL9qTSRIo99X4I=;
        b=DuPRapDOeOjQTydvm5tAi1/xXxDFppUU1UuQOfhZTi4PFHk/QdkrO7o4FZjArAyy/A
         qL+g5YkkCr4q5IfmyetGgETqVc3Yr4sufV0U8gXaPzaRMsFczjZVfV4Fj0uL2ReyyHvy
         RPY+cwYBIaKgVW1JTjpW+eFNmbXCSv3gaS5BOSZO5PdE4yoAsQUAb5wMsBPW/nGha+GS
         XE0VX5TrmzDDePa0KGguVowGErtWnMET4J+eRmxW/bccC03uIKgfZPITGgo7nTBt02ec
         ReP8mgdIcJypIWn8CyBoY7gHyz1PyOr9pKzhkjyK+0wWz3tn0zXeiNdrW2I3LAzLakM1
         j9jw==
X-Gm-Message-State: AO0yUKXb8LkfK9CQQTacQvLfhcdu44NjsEcsdDYnHJhJeKUUBuEI+wkX
        B5HpYyRclwGUiR0BINUzLotQ+gpy8N4kIom8FweRaKfT
X-Received: by 2002:a05:6808:913:b0:378:94fa:a719 with SMTP id
 w19-20020a056808091300b0037894faa719mt161606oih.146.1675311934583; Wed, 01
 Feb 2023 20:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20221228034617.58386-1-zh.nvgt@gmail.com>
In-Reply-To: <20221228034617.58386-1-zh.nvgt@gmail.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Wed, 1 Feb 2023 23:25:23 -0500
Message-ID: <CAO2zrtZjDj5U4CCwVWQcWfbXJa0hwRjjNRE7jtHshrEb-nEwEg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: mailbox-test: fix potential use-after-free issues
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 10:46 PM Hang Zhang <zh.nvgt@gmail.com> wrote:
>
> mbox_test_message_write() is the .write handler of the message
> debugfs interface, it operates on global pointers "tdev->signal"
> and "tdev->message" (e.g., allocation, dereference, free and
> nullification). However, these operations are not protected by any
> locks, making use-after-free possible in the concurrent setting.
> E.g., one invocation of the handler may have freed "tdev->signal"
> but being preempted before nullifying the pointer, then another
> invocation of the handler may dereference the now dangling pointer,
> causing use-after-free. Similarly, "tdev->message", as a shared
> pointer, may be manipulated by multiple invocations concurrently,
> resulting in unexpected issues such as use-after-free.
>
> Fix these potential issues by protecting the above operations with
> the spinlock "tdev->lock", which has already been deployed in other
> handlers of the debugfs interface (e.g., .read). This patch introduces
> the same lock to the .write handler.
>
> Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> ---
>  drivers/mailbox/mailbox-test.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
> index 4555d678fadd..b2315261644a 100644
> --- a/drivers/mailbox/mailbox-test.c
> +++ b/drivers/mailbox/mailbox-test.c
> @@ -97,6 +97,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
>         struct mbox_test_device *tdev = filp->private_data;
>         void *data;
>         int ret;
> +       unsigned long flags;
>
>         if (!tdev->tx_channel) {
>                 dev_err(tdev->dev, "Channel cannot do Tx\n");
> @@ -110,9 +111,12 @@ static ssize_t mbox_test_message_write(struct file *filp,
>                 return -EINVAL;
>         }
>
> +       spin_lock_irqsave(&tdev->lock, flags);
>         tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
> -       if (!tdev->message)
> -               return -ENOMEM;
> +       if (!tdev->message) {
> +               ret = -ENOMEM;
> +               goto out_1;
> +       }
>
>         ret = copy_from_user(tdev->message, userbuf, count);
>         if (ret) {
> @@ -143,6 +147,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
>         kfree(tdev->signal);
>         kfree(tdev->message);
>         tdev->signal = NULL;
> +out_1:
> +       spin_unlock_irqrestore(&tdev->lock, flags);
>
>         return ret < 0 ? ret : count;
>  }
> --
> 2.39.0
>

Hi Jassi, could we get some comments from you about this patch?
To avoid potential confusion, we want to also clarify that this UAF
issue was originally flagged by our static analyzer, so we do not have
PoC or dynamic execution traces here, however, we have performed
a careful manual code review to confirm this issue and we think that
it seems apparent, as currently there is no concurrency protection
for the .write handler, while it should have some (e.g., the .read
handler does have some lock protection). Please feel free to let us
know if we missed anything here, thank you very much for your help!

Best,
Hang
