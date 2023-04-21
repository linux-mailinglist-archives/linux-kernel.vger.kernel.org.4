Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594026EADE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjDUPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDUPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:17:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CF61FEE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:17:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso53445295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1682090220; x=1684682220;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FLIRu+J3TTNH4UC41pvBd3yuWmEfjvLFBhfQG12ctk=;
        b=TVoz+qIZFjTNqFGQR7N+9SmzNW/TlKMeSydu6mfCgsxrtVMF21U1n5yIoc+5ToMimC
         p0do4+yC8QJmbzE4zDobrvFli/ArhW/FE0clp3wWI3Rvgb/IXj3F6ZIBmVBTzeGPo7EP
         YnWVItChXlfATI0KLc92b14iv98yYLr+4sftc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682090220; x=1684682220;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FLIRu+J3TTNH4UC41pvBd3yuWmEfjvLFBhfQG12ctk=;
        b=OMs7BGHeA9yHzr827869ZNKcYVt8PDAuKTGt1sBaD9C2OwOpswBqtxIgPh8703A5zM
         fN/H7xZn66ouc4XSeG8eiL1a1fUAFx8KdZ51hgNe9d4NZk+ldYEjDxuiYWWcOe275b94
         4sPWgJ+SsiXREeAx5uTnH7K1Q1sQyWBVSW1gHptlnVMoZCtkmavWkE3j8EKkHUO85tm9
         FBr22Zegv2eKWNytkf6O7X1NV5vaEYOobnMEL3iyaFv5Q/96OsIOTak8R3ixX4+I1ssM
         nvohVmf4fIZfQJZuM2dGzH3oyxbsjPTg+8hVU+GdrxOjmO89ip45YsBSChlBbNpNBpvh
         Sf/w==
X-Gm-Message-State: AAQBX9eExf7yXp8RKtHvc+hLUagogL63XEaTxRO8184ISjpdST7fzN2k
        ypnfyBLNChJ5fW6ViSfjV0dNjg==
X-Google-Smtp-Source: AKy350a2se3RpoghadyqoDnl7K3fPuHUrm7BD47UxyDgzE8hqtX9JzyFIdkZyqIzm7SW062U3y4b0g==
X-Received: by 2002:adf:f092:0:b0:2fe:c8b5:b5da with SMTP id n18-20020adff092000000b002fec8b5b5damr4306620wro.13.1682090220316;
        Fri, 21 Apr 2023 08:17:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm4640202wrp.20.2023.04.21.08.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:16:59 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:16:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] usb-audio: Rate limit usb_set_interface error reporting
Message-ID: <ZEKo68jUGe1taYxz@chrisdown.name>
References: <ZEKf8UYBYa1h4JWR@chrisdown.name>
 <87wn25qosu.wl-tiwai@suse.de>
 <ZEKiO7lh94QUyuAs@chrisdown.name>
 <87mt31qngg.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87mt31qngg.wl-tiwai@suse.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai writes:
>Hrm, is "usb 3-7.1.4" really the USB audio device?  The previous
>errors like "Unable to submit urb #2..." are certainly for USB audio,
>and those are with "usb 3-7.4".

There are two USB audio devices -- 3-7.1.4 is input, 3-7.4 is output.

     % dmesg --notime | grep -e 'usb 3-7.4' -e 'usb 3-7.1.4' | grep Product: | sort | uniq
     usb 3-7.1.4: Product: USB2.0 Microphone
     usb 3-7.4: Product: USB Audio Device

Thanks,

Chris
