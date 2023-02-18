Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6729969BA13
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 13:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBRMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 07:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRMyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 07:54:36 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25310D7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 04:54:33 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 16so791585oiy.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 04:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112; t=1676724872;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=//sb/NYNvOOxKrp04fWS+VMUo3F1GFZIyJCs1w1+uek=;
        b=I7P7JsNGzgkMCPgCrqRXdA9ZpA9DOa2tP8KSY8Oy5dWp3x2KJ4cANa9ZYZ+uhdtv58
         wKz1ZkawqpIBakGgBvuy9Idg+QjE+JGuiG9uHqzZjFFqbjjt+C217c/Ce+UuCMAWMmAm
         oHY2nZOtM86GH0FJExXKnPgRP2nbL0/LXrX186H4WcFk+43wXGFVLMPLrOkjw04KJJTg
         1ScetLzsQ7qy7EILdSksGllAL+nqO7DNZycJ25QY7+IWBlQYWEJwZiPyB45M/ZnCVlBW
         ajx6M9qAjtLPy3YN/3om3eRPyv23USb/4PR9j+GCAaSRwV7y63Z5v2faAKGAF2YSH62N
         y1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676724872;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//sb/NYNvOOxKrp04fWS+VMUo3F1GFZIyJCs1w1+uek=;
        b=50MXEIk2ne7nWFyBQV4Ddl4wrwupTw2DIMDDZ9zcuqE3+MstlzqodvPyZjJzp3SZb7
         7CpMIEZ2Da2YxwIlXns/0nlwcH/jk2ytyVyBYyiJJN4FXLoU+VJuoqgYKsfm/CeubDG1
         NWY3d+6Fp8gZ2S3B8ZfM1HVQP2sT4+TQeGY1bj9xrOhBg30GE1iOJTUiTYdBNUH9abWa
         JMiTmgZvnz9gby3JcNh8aqcJgAjuHiPRVgDYdNTRGI07u8CiiLEWC69H32lTMKtNcJ9U
         VC8dRKJQPWtS++pWj9bRBzh8WDKgAuU50dsNalSf+ros/USa1zB+h0SL3OK54zeygkP8
         6/aQ==
X-Gm-Message-State: AO0yUKXlbN/tlLgLj9Mj7TuRgDl0Y7oFqhfueFty/2KUIaQndwWu/19y
        iEqofLW0zDdJX3VqqAFTmHP+nA==
X-Google-Smtp-Source: AK7set8hgUotSkKUQWpkFmsCbsIrZ1DR8W4XyJ/l7M9d1e2GFLgZ0l2Xw76LWIUq6qL4UMbVzzM/jQ==
X-Received: by 2002:a05:6808:1a1e:b0:367:163e:a0e with SMTP id bk30-20020a0568081a1e00b00367163e0a0emr2039035oib.4.1676724872484;
        Sat, 18 Feb 2023 04:54:32 -0800 (PST)
Received: from [192.168.10.175] ([190.11.59.127])
        by smtp.gmail.com with ESMTPSA id q132-20020acac08a000000b0037d813cd612sm2868122oif.43.2023.02.18.04.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 04:54:31 -0800 (PST)
Date:   Sat, 18 Feb 2023 09:54:20 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v8 0/6] media: verisilicon: HEVC: fix 10bits handling
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     robert.mader@collabora.com, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Message-Id: <K61AQR.89JE1N9UODFT2@vanguardiasur.com.ar>
In-Reply-To: <20230203091622.127279-1-benjamin.gaignard@collabora.com>
References: <20230203091622.127279-1-benjamin.gaignard@collabora.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

We are almost there, just some minor comments.

On Fri, Feb 3 2023 at 10:16:16 AM +0100, Benjamin Gaignard 
<benjamin.gaignard@collabora.com> wrote:
> When decoding a 10bits bitstreams HEVC driver should only expose 
> 10bits pixel formats.
> To fulfill this requirement it is needed to call 
> hantro_reset_raw_fmt()
> and to only change driver internal state in case of success.
> 
> Fluster score for HEVC (140/147) doesn't change after this series.
> Fluster score for VP9 is 146/303.
> 

Given the series is changing the format negotation which affects
all codecs, can you test MPEG-2, VP8, H.264 and JPEG encoding?

Can you also run v4l2-compliance on all the /dev/videoX devices?

(Adding Robert Mader, who recently helped test the JPEG encoder).

Thanks,
Ezequiel

> version 8:
> - Correct patch 4.
> - Add a patch for VP9.
> 
> version 7:
> - Remove unused ctx variable in hantro_try_ctrl().
> - Change HANTRO_DEFAULT_BIT_DEPTH value to 8.
> - Simplify hantro_check_depth_match logic.
> - Keep ctx->bit_depth as integer value because it is use
>   to compute buffers size for hevc.
> 
> version 6:
> - Split the patches in multiple sub-patches.
> - Rework hantro_reset_encoded_fmt() usage.
> 
> version 5:
> - Add Nicolas's review tags
> - Add Fixes tags
> 
> version 4:
> - Split the change in 2 patches.
> - Change hantro_check_depth_match() prototype to avoid using
>   ctx->bit_depth
> - Return the result of hantro_reset_raw_fmt() to the caller.
> - Only set ctx->bit_depth when hantro_reset_raw_fmt() returns is ok.
> 
> Benjamin Gaignard (6):
>   media: verisilicon: Do not set context src/dst formats in reset
>     functions
>   media: verisilicon: Do not use ctx fields as format storage when
>     resetting
>   media: verisilicon: Do not set ctx->bit_depth in hantro_try_ctrl()
>   media: verisilicon: Do not change context bit depth before 
> validating
>     the format
>   media: verisilicon: HEVC: Only propose 10 bits compatible pixels
>     formats
>   media: verisilicon: VP9: Only propose 10 bits compatible pixels
>     formats
> 
>  .../media/platform/verisilicon/hantro_drv.c   | 49 +++++++---
>  .../platform/verisilicon/hantro_postproc.c    |  2 +-
>  .../media/platform/verisilicon/hantro_v4l2.c  | 90 
> +++++++++----------
>  .../media/platform/verisilicon/hantro_v4l2.h  |  3 +-
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>  5 files changed, 86 insertions(+), 60 deletions(-)
> 
> --
> 2.34.1
> 


