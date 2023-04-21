Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193036EAD66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjDUOsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjDUOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:48:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF6E58
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:48:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f178da21afso12866495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1682088509; x=1684680509;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTbZjx2Ju7l0danMJinUwAgoWWitXzPCiVyIbPSimKU=;
        b=E4WlLCNh9cY9f0OQilScTn8I4bDE5QieQlYcbD2RdZ6vrpoRUGIya8HY4K6ORhFpzr
         GgP70+ww+cob+kdwv2yXLZJlfwSEGhyTsls8yKPiT+4lWuDGWe5uNkSlkuOmAYsVVNiy
         cG/o27T56DLAG0OO4drFQmFOfLBNgkwVKfN+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682088509; x=1684680509;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTbZjx2Ju7l0danMJinUwAgoWWitXzPCiVyIbPSimKU=;
        b=IoetM20WxVoDJsa/vCj9XCjkd/wkJyRwAKW3w09PTUqff3e8FQ9QM+M0jB8dlaNl9A
         mpP+mtJ90peZMBCb79U2OipaSR9IHjzNxmS9Qz0TIqbfdML0tYHTGPU0OPzxnx+k7MSC
         xtSA1PYd6XZxMUtkJS0nVcBCc8PVg3AIaiYutIl2WqoOGMCx06LnXF+C99t4PZu2DuIy
         Vp0mVpywcpYMgCjLzuYcMQl4nQm7dIBMVatBIQ8QP99wN/wY2Hdn/ZzIXaGGuaGZcoUk
         kYk68HQ7qX5yVspjBzPnOkb5Oh++gtSoZRgXOovwZyhBHZHe6Xb3E8Ra1pcivNR644ks
         r/oQ==
X-Gm-Message-State: AAQBX9crxHtmi9HSYNOU9XkZ/9ijgfM1DMD4OSuOeQjh0Khn/FcDREFL
        TuS1LAwYOdhDjjeOY8Ot2ovKjw==
X-Google-Smtp-Source: AKy350btJKj/Eho9sNQ77ryDl0t2OzKq0NwdI8z5zPWlI+1B0eIAUwep3uQE2s8DrRgzBZEzcAHs1A==
X-Received: by 2002:a05:600c:ac1:b0:3f0:7eda:c19f with SMTP id c1-20020a05600c0ac100b003f07edac19fmr2194046wmr.11.1682088508728;
        Fri, 21 Apr 2023 07:48:28 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d43d1000000b002fdf0f6b07csm4549010wrr.67.2023.04.21.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:48:28 -0700 (PDT)
Date:   Fri, 21 Apr 2023 15:48:27 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] usb-audio: Rate limit usb_set_interface error reporting
Message-ID: <ZEKiO7lh94QUyuAs@chrisdown.name>
References: <ZEKf8UYBYa1h4JWR@chrisdown.name>
 <87wn25qosu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87wn25qosu.wl-tiwai@suse.de>
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

Hi Takashi,

Takashi Iwai writes:
>This patch itself is safe and good to have, so I'm going to take it as
>is.

Thanks!

>But I'm still curious in which code path the problem happens.  That
>is, we should address such unnecessary repeats if possible.  Do you
>have some more data?

Unfortunately not, I've been running with a kernel testing some other mm 
changes recently so haven't had a chance to debug what's going on here. But it 
starts like this:

     [Fri Apr 21 13:21:10 2023] usb 3-7: USB disconnect, device number 39
     [Fri Apr 21 13:21:10 2023] usb 3-7.1: USB disconnect, device number 40
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.1: USB disconnect, device number 42
     [Fri Apr 21 13:21:10 2023] usb 3-7.4: cannot submit urb (err = -19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.4: Unable to submit urb #2: -19 at snd_usb_queue_pending_output_urbs
     [Fri Apr 21 13:21:10 2023] usb 3-7.4: cannot submit urb 0, error -19: no device
     [Fri Apr 21 13:21:10 2023] usb 3-7.4: cannot submit urb 0, error -19: no device
     [Fri Apr 21 13:21:10 2023] usb 3-7.4: cannot submit urb 0, error -19: no device
     [Fri Apr 21 13:21:10 2023] usb 3-7.4: 1:0: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.4: 2:0: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.2: USB disconnect, device number 44
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [Fri Apr 21 13:21:10 2023] usb 3-7.1.4: 1:1: usb_set_interface failed (-19)
     [... thousands of messages ensue ...]

So it looks like maybe some ordering is not quite right in destruction, perhaps 
only on multi-level USB topologies?

Thanks,

Chris
