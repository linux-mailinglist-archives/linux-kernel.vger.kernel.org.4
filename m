Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA96637E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKXRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:35:55 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2FFAEAF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:35:55 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c7so1583394iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/cdY5HAlRpYkIKOhfK2rjmSjuQUyTK9iygks/LbK6M=;
        b=Tu4QuLykXDpwzAodsdEkf3yQCsZwSpqD/JK7ljYuRfCqbb2AT9bBo+D+PndorLT7ia
         pSUAg0HFZKCcqiDg89mvNpt7PLaxKs1g8W7AaOU91iFkGypNVgG5VWlfO2iiZ5VZr0Ko
         0ksTpNOeXuIwaDIWRIpfUB7EiPnNvBVgmmjUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/cdY5HAlRpYkIKOhfK2rjmSjuQUyTK9iygks/LbK6M=;
        b=PvdK/Ly4cYJpc6/qBoEfk7yQfkDe4Xg2pfx3XKW2V2iWBlUrK8BOcq56Bei45sORRu
         /twCUWI6exvwfsvdDsuTd/p4qKLsx5kWYLN68Z8MIqPlsw3e/z26bLuqhEVJea8FsYMK
         6e5VH4n+u427Pdn3qXAKFETGObQ0ablTfOlKmdPfdSP86lz4rQQrk48a/tjsGMzrwgCT
         j6WEh0QloD7JPCHgKLHe6G6es+TJNPMD/cTtPRmxVlmvb3yZFWYzfhsjPjUChcgSqjqL
         uBiKi61kIeDMDEWO5D+RjDj5kf4Jh0ehl6d9bm5Xo7262SqfE+X3leWpTqq2A/5iVNMU
         JUpg==
X-Gm-Message-State: ANoB5plvLJZC24Km2r0mXzqHo5UCi8wyX2dNRHouqln3WvdjTHNEJH1P
        93MDRNbCxauKcK8DZ/tSVHTLNDb1+MUAcNln
X-Google-Smtp-Source: AA0mqf5RJ5mUX52bsv3wOt8Jv8aq+uVK1p7cEAKUpSdW9mkDz9J+2bUs+Ph3UZxfYQSIggtckkeNYg==
X-Received: by 2002:a02:3b56:0:b0:375:8878:9c80 with SMTP id i22-20020a023b56000000b0037588789c80mr14355716jaf.157.1669311354476;
        Thu, 24 Nov 2022 09:35:54 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id n207-20020a6b8bd8000000b006df19c8671fsm631980iod.27.2022.11.24.09.35.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 09:35:53 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id p141so1596875iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:35:53 -0800 (PST)
X-Received: by 2002:a05:6638:3d03:b0:373:9d0a:33a0 with SMTP id
 cl3-20020a0566383d0300b003739d0a33a0mr6759388jab.286.1669311353367; Thu, 24
 Nov 2022 09:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
 <20221124-da9211-v1-1-a54549aa6d3b@chromium.org> <Y3+hpgjQVK+8Ut9s@sirena.org.uk>
In-Reply-To: <Y3+hpgjQVK+8Ut9s@sirena.org.uk>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 18:35:42 +0100
X-Gmail-Original-Message-ID: <CANiDSCuMA3N-spbKQUZJywKMhxZyd-YB0bYSEeC9reQJOSi7mw@mail.gmail.com>
Message-ID: <CANiDSCuMA3N-spbKQUZJywKMhxZyd-YB0bYSEeC9reQJOSi7mw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] regulator: da9211: Use irq handler when ready
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

Thanks for the review!

On Thu, 24 Nov 2022 at 17:54, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 24, 2022 at 05:45:31PM +0100, Ricardo Ribalda wrote:
>
> > [    1.141839] Unable to handle kernel read from unreadable memory at virtual address 0000000000000078
> > [    1.144475] tpm_i2c_infineon 3-0020: 1.2 TPM (device-id 0x1A)
> > [    1.150883] Mem abort info:
> > [    1.150884]   ESR = 0x96000005
> > [    1.150887]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    1.167749]   SET = 0, FnV = 0
> > [    1.170794]   EA = 0, S1PTW = 0
>
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Do you want that I post a v2 of the patch?

Regards



-- 
Ricardo Ribalda
