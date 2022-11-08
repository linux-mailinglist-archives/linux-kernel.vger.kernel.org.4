Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F08621905
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiKHQEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiKHQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:04:39 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEA5E3F7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:04:37 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13b103a3e5dso16731231fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V9WW/Du0LmflcuOKD72qp9hdgPApATYBjvbbNnooJNM=;
        b=pvW3ul5TA2U+eZJ2wXA2kdXoN89zJU48kYrRmknFgRokK0CzXywAVNV2Hxfj2PCFxN
         0rlLlWF6j/zEF9vfJdObccLk+GeRboCIP0gxau8ghbh6+zBR1GcYQWLzQelP9sEjjRxV
         2h9juXWNHAlGyabhFRGdTFYjXDL94RLaAtQfNemCBmfJU7e2xGs+Fatm5KgkLu6max91
         0gSL21e5n5Xci4zcn3DdLNJ+wtZlOTtBBA1z31+OpDcXSkIPCE1tnglr04qEHqONbbBw
         +gi3ivWbEb0ezhYncRCP/P5sG8GubGDBP/RsJJsC+nhYDKeh7e7pqf8y7d1yQoqiux/g
         QqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9WW/Du0LmflcuOKD72qp9hdgPApATYBjvbbNnooJNM=;
        b=UN6UcNbW1fKRTckYo8W2+OX2xKve+11KFeBKQtzukD3OB4wdFZKqI2QXpGp5Fmnthk
         rv+IUGen2VVaYVoH6OLb/ZDcTFjra+B+8d+k5oN0GXvjcVdOuCcFH9OlyKCVjDu5eG84
         nWzWRjFNTqjUx3fLeIn0rjAgqzyKRj8ggkxj3tS1u5howpWHikwpxsDtme5rSpbFEgyM
         pleXZpjacrPCqOtWgeM4Pj6h40LZXjbMEpAN7tUMSO0GMkcR/xAzC7GgtyVUSLiK/fNC
         dXpus65v9RyzDoimZ+LYEKQ0qC/6o4oHm1UcujHHMGULFBXclJ/zZwImHaf7dAOFPHi+
         gRiw==
X-Gm-Message-State: ACrzQf2ahmXhGdheZV/rVM0NShU95BQWKIf5NXmyqNKi3li6s4z3+M+C
        DT1W63QlOF+0+VFTeTuPAPPsq7bDhUqrEZYcXnQ=
X-Google-Smtp-Source: AMsMyM6BjPUKTgkeMdt975a7Gbd69NCGhbEeA3cnlPUJ5xqBsVxxF7ICZN+CcqXY0kaFQ3uibC2Wj5qVLNIBu6aorwQ=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr33934235oao.96.1667923451842; Tue, 08
 Nov 2022 08:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20221104092931.20226-1-tanglongjun@kylinos.cn>
In-Reply-To: <20221104092931.20226-1-tanglongjun@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 8 Nov 2022 11:03:59 -0500
Message-ID: <CADnq5_Pxh8G=xguW=wa9x2W_c67RD+5EGJXcTC99_sbUqsVLBA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amd/display: Have risk for memory exhaustion
To:     LongJun Tang <tanglongjun@kylinos.cn>
Cc:     alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        harry.wentland@amd.com, aurabindo.pillai@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        lange_tang@163.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 10:06 AM LongJun Tang <tanglongjun@kylinos.cn> wrote:
>
> In dcn*_clock_source_create when dcn*_clk_src_construct fails allocated
> clk_src needs release. A local attack could use this to cause memory
> exhaustion.
>
> Signed-off-by: LongJun Tang <tanglongjun@kylinos.cn>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
>  8 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index 020f512e9690..9b7e786bd4a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1323,6 +1323,7 @@ static struct clock_source *dcn30_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index f04595b750ab..7c1225046544 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1288,6 +1288,7 @@ static struct clock_source *dcn301_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index b925b6ddde5a..73ae1146dad5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -458,6 +458,7 @@ static struct clock_source *dcn302_clock_source_create(struct dc_context *ctx, s
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> index 527d5c902878..0ea97eeec5a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> @@ -425,6 +425,7 @@ static struct clock_source *dcn303_clock_source_create(struct dc_context *ctx, s
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index fddc21a5a04c..b02aa8874efb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1625,6 +1625,7 @@ static struct clock_source *dcn31_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
> index 58746c437554..b2ff29e5f93c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
> @@ -1623,6 +1623,7 @@ static struct clock_source *dcn31_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index a88dd7b3d1c1..71730b6666b0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -829,6 +829,7 @@ static struct clock_source *dcn32_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> index 61087f2385a9..d3980fc243c9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> @@ -828,6 +828,7 @@ static struct clock_source *dcn321_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> --
> 2.17.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
