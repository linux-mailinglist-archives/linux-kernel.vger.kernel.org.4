Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCA64364D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiLEVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiLEVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:02:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07422CDEC;
        Mon,  5 Dec 2022 13:01:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f7so17565327edc.6;
        Mon, 05 Dec 2022 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR2ojr4E4/FvABpHMdPE1tBl2qE5ugC0vWs+LUlEhI8=;
        b=VDtbOT60TvVrEjQjbx0WDlRo+AwmdYcjrF1PiLmi4ycg6zyoil32hMK07venuroC8k
         xQGAzoclaWb1++ZmwD5vfeqyHXv/LoWzHhkd/gI1zSdaxctkeybwYKbwr+JrETj4ZcCG
         aUc/RL1tAcqdF1eKX6cPpa/aNYuVecrawB6v7Gg9loPpZz0RyEQJbRX9ygvI6goe+Ew9
         /3TTuHuJyW3iHms/mnGSkhT0U7+fnuctAOZzyBBMj00YYXptDm9dhOACiqJ2M10OMVrx
         C0mjJn+NENrgAuCkBvybgnWAtAt9eH3lbuo93emLGPkkAJby9m2PYxlA0WUuQTDlmOhD
         l6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR2ojr4E4/FvABpHMdPE1tBl2qE5ugC0vWs+LUlEhI8=;
        b=FufNX07xauPBpJZ/qLhbTybHm8AuDlT7q6KIjt3do4dNeU8ISZmbx6feBHPpszLYUX
         jyc4UtIWiezTCC3+8wncurg/8+SR2iGu58pr0pzCADiSGoTDR/1C7hXpQm4P/eWiSq1l
         k+mXo19J70suZpWJmXpP2z+GsGwiIULiTzV3BxvT8HtQb+72GvcluHYD6m6qHmxuCLIh
         tBu7i9A/Hti/JIcozqwhDT8XyKV5R2MiOzMA+aXonxmCszq+sBwTbbrl0/aBxhkXHOfg
         nNNE8sAOriUrIv0j48Z4Haa8MZKCIA/T3mbluy8SxkN7vGs1ycMZVVQ1NHezZ1P1HREW
         UziA==
X-Gm-Message-State: ANoB5pk2aMdYUH/zE5oMiHnDagkMIB9AH0cLxvU9E2nPLkn++3rTj3RB
        FdFNLfpaNePEkGSI43ljJtY=
X-Google-Smtp-Source: AA0mqf7TE6/gHtnfOWjM/gdQJDtF6FGAYEHlnA9LDGiGZ/bEoqQVQg36nIkcEZaiwGa6wt4FBfx7Jw==
X-Received: by 2002:a05:6402:4507:b0:467:205b:723d with SMTP id ez7-20020a056402450700b00467205b723dmr17483455edb.69.1670274076195;
        Mon, 05 Dec 2022 13:01:16 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b007b9269a0423sm6634332ejd.172.2022.12.05.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:01:15 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH] media: cedrus: Convert to MPLANE uAPI
Date:   Mon, 05 Dec 2022 22:01:14 +0100
Message-ID: <45143854.fMDQidcC6G@kista>
In-Reply-To: <20221129074530.640251-1-wenst@chromium.org>
References: <20221129074530.640251-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu!

Dne torek, 29. november 2022 ob 08:45:30 CET je Chen-Yu Tsai napisal(a):
> The majority of the V4L2 stateless video decoder drivers use the MPLANE
> interface.
> 
> On the userspace side, Gstreamer supports non-MPLANE and MPLANE
> interfaces. Chromium only supports the MPLANE interface, and is not yet
> usable with standard desktop Linux. FFmpeg support for either has not
> landed.

I don't like fixing userspace issues in kernel, if kernel side works fine. 
Implementing missing non-MPLANE support in Chromium will also allow it to work 
with older kernels.

Hans, what's linux-media politics about such changes?

Best regards,
Jernej

> 
> A fallback route using libv4l is also available. The library translates
> MPLANE interface ioctl calls to non-MPLANE ones, provided that the pixel
> format used is single plane.
> 
> Convert the Cedrus driver to the MPLANE interface, while keeping the
> supported formats single plane. Besides backward compatibility through
> the plugin, the hardware requires that different planes not be located
> too far apart in memory. Keeping the single plane pixel format makes
> this easy to enforce.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> 
> This has been tested with Fluster. The score remained the same with or
> without the patch. This also helps with getting VP8 decoding working
> with Chromium's in-tree test program "video_decode_accelerator_tests",
> though Chromium requires other changes regarding buffer allocation and
> management.


