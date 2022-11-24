Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B0637E50
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKXReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:34:08 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD9BFA73B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:34:07 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x13so1032403ilp.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LlU9Qf9jw8Z61+uQjLqzmHr/p9fSoZ4UQV22Vwf9cig=;
        b=MxczP6tVR/oSxFbEsB9+dyn6GSIC0+70cnrt2zDKXIkBta+N2y6NsVPTc+0ds0Dahu
         NwFYpN7C0GpyYNQ4u1mjJwmkmhbmCupP2KPBagZXVVfMO/OjkGuJQGV0u31ElfmshERr
         fsOJJQmlirt9/a+7bxcn6QCtoy775rXdQGV2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlU9Qf9jw8Z61+uQjLqzmHr/p9fSoZ4UQV22Vwf9cig=;
        b=SZFBnyBGaZwnhTa0M98bYZ9KFx7P/zvB14ru4jvC/57NkCSZXdbpAlyqS12gLRwLbc
         eOqbnNgqDk7qxmGAlQ4meNimE0VkvGBxNme4qdHLZjZob48BQLtjhbF4IJ6Y4xmVDpVY
         BO/9CnzBN9aFYt2LW5z264nEViemNWLTch1tdcmituS/ll9vIqYbcPr79u8PEo9O50CY
         z15/6CsSvo5+1XJOBYmr8PVw2mtHyTdUUqkiDVnPWUih87cEfYtCmur3WT/CbW6EFPFu
         rKnNhj4ERI2DtSwDjFqY5plHEGTC6rcGODm1YmgmeHMoH9pJi1Y+j/zdpm90hYQ9N9ZN
         AYMA==
X-Gm-Message-State: ANoB5pnpuU8yz++ywLgYFVkUEZf/TSjOgRDn7HELVd3Z+4lbkNvvta8X
        p7Axw/eU8W5p7UyyW/agB5OlVHxyvheYUw30
X-Google-Smtp-Source: AA0mqf5Vt94HQv26lAsFxI9u15PJcF9/KJCeAHhj0y94UTuPAjLmEBKswAMBaak1sX1ggfv2mxkuPQ==
X-Received: by 2002:a92:d90a:0:b0:302:bfca:d385 with SMTP id s10-20020a92d90a000000b00302bfcad385mr9255750iln.51.1669311246647;
        Thu, 24 Nov 2022 09:34:06 -0800 (PST)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id z26-20020a05660217da00b006bccaa66ee4sm629988iox.40.2022.11.24.09.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 09:34:06 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id p141so1594284iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:34:05 -0800 (PST)
X-Received: by 2002:a5e:c64a:0:b0:6cc:e295:7bde with SMTP id
 s10-20020a5ec64a000000b006cce2957bdemr6693699ioo.183.1669311245352; Thu, 24
 Nov 2022 09:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org> <Y3+hX2c+/rBwZ8VN@sirena.org.uk>
In-Reply-To: <Y3+hX2c+/rBwZ8VN@sirena.org.uk>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 18:33:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCvGwLips_03DvWz3FJmnZQumGFxkeKF6Vvan8m1uGZSOw@mail.gmail.com>
Message-ID: <CANiDSCvGwLips_03DvWz3FJmnZQumGFxkeKF6Vvan8m1uGZSOw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] regulator: da9211: Fix crash when irqs are pre-enabled
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark


On Thu, 24 Nov 2022 at 17:52, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 24, 2022 at 05:45:30PM +0100, Ricardo Ribalda wrote:
> > If the system does not come from reset (like when it is kexec()), the
> > regulator might have an IRQ waiting for us.
>
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.

I am using the "b4 prep" workflow and I think there is no way to
disable the cover-letter.

Let me ask at tools@linux.kernel.org if they plan to support "old lore
links after the ---" for single patch

Thanks!


-- 
Ricardo Ribalda
