Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8AE68A762
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 01:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjBDA7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 19:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjBDA7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:59:31 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940DC60C96;
        Fri,  3 Feb 2023 16:59:30 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e6so6946039plg.12;
        Fri, 03 Feb 2023 16:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WiNNH+9DZZB506Oa/vKHoEbzxK1t9Z949cf39BjEKw=;
        b=GL+KYFCQaGEQwlNKfXtrVmaCVfQYRRZ6arQTr6G7oN7vx8WicJbFyVOsEAVk9MesqQ
         Mepa+5LWCSRQyET48O/ap5uzIoiqg57GflCepN89VIA3Qek3flF+kSSMWuI0RRItYcoN
         IPP6oowt9/f6Yr0x+LF+QuHtcn84BRwDQbEu99Bad1pVB8EkMlPSAkfwgzjxOVYAeLTa
         SjBdRjNdSkRnk4sq3deDvb+Mw2TNrlF42WKVKRup/DXA83GMvXgbos2sKpGqf54K7Ts+
         DE267ngxS2+WXSXm8c26Mpb1E1wcFNMy14L/EizA0+iWSegN2wCqYM4KO9tktH2UEjoX
         0I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WiNNH+9DZZB506Oa/vKHoEbzxK1t9Z949cf39BjEKw=;
        b=WOBtO7gcMdC6m1otsBmJQJpGDN4nVvHfzP3h1XYNnXRVWCjWxAZtXmLcuGm9pkXHuP
         u2AxratNPtDfpoJF5kl2d7rxSNMxXG1/sDf6+R0Q9yqEEZJJX0TQGsDGAfCNLh9RJWcP
         mSiI8vfZh97kHB9f1zkN17i6HXCcAO4eM3y34VFq5G1s/rCYWO8pzlBrSaLwAtjlc7NK
         CaJzVKu5qi+e5WE+WiGaCmZo3o9BMqJOXwTm27awgBkCOkXqOVBqXIjFUf+ygqz7JsJF
         KQ7YJMxg1oBrUUpZ/mVpgeaKxQ07OKwnz+a/pxymQPMh4s54Px9SNSiEW3D6Lv3CqmFr
         TO/w==
X-Gm-Message-State: AO0yUKUy8ZTF7IDe+YN3TCLtohtJlbCXK0NhexS3TEP8+ugRDu6jQLf8
        YXggfukIZcqYOnu8b+XhmHo=
X-Google-Smtp-Source: AK7set87+IR7DmXet+TZXIMY9bdUa6tXTLmhnDme8jOMm4Mqert5pZBZCFyELoOFxpgMX3xRwCCOvQ==
X-Received: by 2002:a17:902:c40f:b0:191:7d3:7fdd with SMTP id k15-20020a170902c40f00b0019107d37fddmr6702403plk.60.1675472369957;
        Fri, 03 Feb 2023 16:59:29 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5a16:81a3:86ec:ceb2])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902d38100b00192820d00d0sm1576585pld.120.2023.02.03.16.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 16:59:29 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:59:26 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Kjerstadius <kjerstadius@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Richard Kjerstadius <richard.kjerstadius@teledyne.com>,
        linus.walleij@linaro.org, alistair@alistair23.me,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: cyttsp5: Fix bitmask for touch buttons
Message-ID: <Y92t7uqj/F8kFbi8@google.com>
References: <20230127102903.3317089-1-richard.kjerstadius@teledyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127102903.3317089-1-richard.kjerstadius@teledyne.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:29:03AM +0100, Richard Kjerstadius wrote:
> Prior to this patch, the bitmask ends up being 0x3, as opposed to 0x1
> which likely was the intention. The erroneous bit results in the driver
> reporting 2 different button activations in designs with 2 or more
> buttons.
> 
> To detect which button has been pressed, cyttsp5_btn_attention() uses a
> for loop to iterate through the input buffer, while shifting and
> applying a bitmask to determine the state for each button.
> Unfortunately, when the bitmask is 0x3 and there are multiple buttons,
> this procedure falls apart.
> 
> Consider a design with 3 buttons. Pressing the third button will result
> in a call to cyttsp5_btn_attention() with the input buffer containing
> 0x4 (binary 0100). In the first iteration of the for loop cur_btn_state
> will be:
> 
> (0x4 >> 0 * 1) & 0x3 = 0x4 & 0x3 = 0x0
> 
> This is correct. However, in the next iteration this happens:
> 
> (0x4 >> 1 * 1) & 0x3 = 0x2 & 0x3 = 0x2
> 
> Which means that a key event for key 1 is generated, even though it's
> not really active. In the third iteration, the loop detects the button
> that was actually pressed:
> 
> (0x4 >> 2 * 1) & 0x3 = 0x1 & 0x3 = 0x1
> 
> This key event is the only one that should have been detected, but it is
> accompanied by the preceding key. Ensuring the applied mask is 0x1
> solves this problem.
> 
> Signed-off-by: Richard Kjerstadius <richard.kjerstadius@teledyne.com>

Applied, thank you.

-- 
Dmitry
