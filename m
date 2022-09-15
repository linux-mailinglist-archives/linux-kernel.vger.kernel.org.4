Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0765B9F93
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIOQWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIOQWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:22:06 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F79DF88
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:22:05 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1278a61bd57so48185181fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kIZF7U62VhlKQ/wsT9kXxUWvD5ul4B0Zexz0rH7KxH0=;
        b=dmTbYZK01Z+jat9aGUxZxkD8Imdflo3gSi4+Q0GPKYQ7ZZwhCf6XQBEeBWWU2YpIn7
         /tlkC/LvyNz1CtSIvPDe+CSV+dzBAt5p45/NdSXDOK/Ip0lY4Q23rlb6qxulNzSxXMwD
         aMblJjXZUMIL+xCmY+R5Z69MZ3+bMj2hbJglE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kIZF7U62VhlKQ/wsT9kXxUWvD5ul4B0Zexz0rH7KxH0=;
        b=LCdGplZ98Mjct5Vr0n2Iqgc+U9yRsAtKamqXT0o4PABd9/Oq8u2Lubc7Pz+dCpVq02
         NhyqBrjLY47ibKgU899/EITPEYKzO9Td+r0ztT0/esgYp3lld6J55s/doE+ZIzBda1dt
         DUqeRKDcf/GndCsW0vCLOOwg+72cLUoc78TckFquFU021JNgde1DL6MWkmvwpIup12b8
         vz/7MbfwUep+yV8q00shdLYRT4l6FIZYTMuXaEpDdT8+oxrZOH3LIgXx9xbBNemmmNXO
         oVrQGEnluCyZROeN52K1/WR9LfxV2wkJ7v02LGZHutu+abdYzwyY+w3wTh2vQMJYvahm
         KVbQ==
X-Gm-Message-State: ACgBeo2706XuSqpIbYkCwwonXPIqkVR5OdgErZNwLSh9nBelDTQMJSWX
        TZeVZyhnvfClPMOu4Te/iL2BeTKU9CI8TQ==
X-Google-Smtp-Source: AA6agR59Gzpkd2Yf1Zvg6fgzrcxXTtPzkp4Ux4SWLcShfutUZGvAzNLFJufZWN6Z3yBH79r1YghJzg==
X-Received: by 2002:a05:6870:1607:b0:116:82f3:a563 with SMTP id b7-20020a056870160700b0011682f3a563mr5924449oae.152.1663258924717;
        Thu, 15 Sep 2022 09:22:04 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id y19-20020a4acb93000000b0044b02c62872sm7941438ooq.10.2022.09.15.09.22.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 09:22:04 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so12883543oth.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:22:03 -0700 (PDT)
X-Received: by 2002:a05:6830:698e:b0:636:a515:35eb with SMTP id
 cy14-20020a056830698e00b00636a51535ebmr214988otb.169.1663258923000; Thu, 15
 Sep 2022 09:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220914132146.6435-1-hadess@hadess.net>
In-Reply-To: <20220914132146.6435-1-hadess@hadess.net>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Thu, 15 Sep 2022 17:21:52 +0100
X-Gmail-Original-Message-ID: <CA+jURcvMcKgLzrCxXoYoxvR9uQY-J5GfQhcrpkm6mBgqqKHqmQ@mail.gmail.com>
Message-ID: <CA+jURcvMcKgLzrCxXoYoxvR9uQY-J5GfQhcrpkm6mBgqqKHqmQ@mail.gmail.com>
Subject: Re: [PATCH v1] HID: logitech-hidpp: Detect hi-res scrolling support
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sept 2022 at 14:22, Bastien Nocera <hadess@hadess.net> wrote:
>
> Rather than relying on a never-ending stream of patches for quirks.
>
> This change will detect whether HID++ 1.0 hi-res scroll, HID++ 2.0
> hi-res scroll or HID++ 2.0 hi-res scroll wheel is supported, and enable
> the feature without the need for quirks.
>
> Tested on a Logitech M705 mouse that was unsupported before this change.
>
> [    9.365324] logitech-hidpp-device 0003:046D:406D.0006: input,hidraw3: USB HID v1.11 Mouse [Logitech M705] on usb-0000:00:14.0-4/input2:3
> [   57.472434] logitech-hidpp-device 0003:046D:406D.0006: HID++ 4.5 device connected.
> [   57.616429] logitech-hidpp-device 0003:046D:406D.0006: Detected HID++ 2.0 hi-res scroll wheel
> [   57.712424] logitech-hidpp-device 0003:046D:406D.0006: wheel multiplier = 8
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216480
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 118 ++++++++++++++++---------------
>  1 file changed, 61 insertions(+), 57 deletions(-)

Ah, I'd been wanting to do this in my initial implementation, but
couldn't work it out for some reason. Good to see the need for the
quirks list replaced!

Reviewed-by: Harry Cutts <hcutts@chromium.org>
