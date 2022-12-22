Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD3653A65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 02:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLVBx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 20:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLVBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 20:53:25 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86C22B0E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:53:23 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 82so444434pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eIkct3ZfSboStP8z3R6ybBFElc9FQkJ/iv0LTePN+2I=;
        b=6GCzxC9SHk6Uyy1tXgHXC2yL2d/TzID4JshKxXfbNzUqY+PZJuPxW4qkbHLtGwHXlN
         XKXTxrDqEcXMMpHue8kn9RirQxNfh4xIXu05nIeChdHxsfWugAm0uvt517tBMsFgVBEh
         7yPlXe3OKu+7jdNKJpEKswfbyxRdbZSaIMO46/IANdBtSP465SF+Yz7CwPqWb4DWyNqu
         Y7WyuZYIfKH/igF8UuBaiPoAANHNfXRCSTLwwxNTsJ8pFNlYBIjE0bnk3trdsNJqHmVq
         pPSPlLCKPKhMZd/hHY+y4mO94gsFmrA5PqfD4OajEdpDSCltU/wrUBsw7fDc87k2JPKz
         z4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIkct3ZfSboStP8z3R6ybBFElc9FQkJ/iv0LTePN+2I=;
        b=cBo5yn34uQ35pflv9FwFWSlxSmtDVq3nwMlL/vVxrE+KjHMoWIktwFlv+PcOPri+9c
         9SS8OQMLt/yRaAohi91eoA6fSTiXSudi15ixCxu7vSdcBdVpNDoIyjiYi9WjwkRTLQfY
         TNmO8O1IMmqTGubmlSqTzA/hJBS483KRDKHRWdx+uPwrA7pIlU1cEulAPLJ0M48FQsUg
         r59hxkCeRLIngJJ63IvurGL+j3wVndPaJfTKHstLybcgMwAx0bz7HJ00RrYs7BSyAzOg
         ooAgdHyYtvTsPFmh+TZfb3zNgFH+QGqFGwlYvJTjhX4KVSaz0+BAydz9TRLJdyLi78gN
         B3dg==
X-Gm-Message-State: AFqh2koAHQiz/f5qGDzCXJlLraV5CpqVwG2tOdAfgcmCL7Jb55ZqRn3d
        BxuK9shy2vFkVI/vrVF1TTazsQ==
X-Google-Smtp-Source: AMrXdXvrYuTFH3qSlP667iS3ZQJNEqaSJAAWY0j67aUM+W3yzV06OOh6OREykNkcmxaHsyBd7nDV0Q==
X-Received: by 2002:aa7:81d4:0:b0:56e:a7a7:35a0 with SMTP id c20-20020aa781d4000000b0056ea7a735a0mr4287219pfn.25.1671674003222;
        Wed, 21 Dec 2022 17:53:23 -0800 (PST)
Received: from ruihai-HP.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id 12-20020a62150c000000b00574f83c5d51sm11202517pfv.198.2022.12.21.17.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 17:53:22 -0800 (PST)
From:   Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        knoxchiou@chromium.org, weishunc@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: deferred probe when typec count mismatch
Date:   Thu, 22 Dec 2022 09:53:19 +0800
Message-Id: <20221222015319.29142-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
References: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, but I agree with Guenter; I don't think this is justification to add a
> hack for 1 board in this driver.
>
> In what situation does the EC task take so long after reboot that it
> occurs after a module probe (which occurs shortly after system boot up)?
>
> Why is the "corsola" board increasing the Type-C port count dynamically
> after some delay, and what is that delay amount? Why can't this be set
> via CBI/DT or its equivalent on your ARM platform?
>
> This seems like fragile code in the EC and should be fixed there. The
> number of Type-C ports reported by the EC really should be invariant
> across the boot lifecycle. I don't think this patch can be accepted.
>

Alright, I got it. Thank you for your patience and the suggestions.

Because the tcpc/pd tasks are not needed for the HDMI port.
The EC don't want the tasks initiated on starting up, and increase the
counts after the tasks are launched. The delay amount was 2 second before,
(always failed when ec reboot on firmware normal mode) and change to
1 second later, and 500ms yesterday(not reproduce until now).
The delay on EC can be referred to here [1]. However, with the current
design, the number of type-c ports reported by EC isn't invariant across
the boot lifecycle. Also, maybe printing the counts getting from EC
when encountered this field will be a littel helpful for debugging. just
an insignificant thought.

> If you really need to change the number of ports dynamically in the EC,
> add a board specific-hook to not respond to the EC_CMD_USB_PD_PORTS
> host command until you have "set" the number of ports.

Got it. Thank you again for your suggestions.

Link:
[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/program/corsola/src/usbc.c;l=222

