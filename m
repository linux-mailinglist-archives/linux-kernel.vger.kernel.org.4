Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37E56A11FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBWV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBWV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:28:49 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDAF48E3B;
        Thu, 23 Feb 2023 13:28:48 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id bj35so2935452qkb.8;
        Thu, 23 Feb 2023 13:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xcnV+WgofUdUnjHcn7ttpHLZ5uRJGLZF9ORsYeoBcbk=;
        b=Jda2qXz5ZcSOX9oiet2fZus9g6dKWs5X4QEqA03KqGYW53Sk4A4Excv/83QdbL4m+r
         ZKy/hqFLy8E1cLfzbiBC/WFUzSK3LkpxSXW9H819vHn1Ip+zm40gCm5lD87arSla8llT
         wYwh/bRPU2Om2s7tGEaEAqauoqA+lj3d69EaCBJSIrrq9bH1z7CFVBNpBP9rVO2ZdbzV
         Z9Jn/eE9Wker9utigtgLgdO/yAswVBSmeEc5RV1YfHN8tcepTuKeHA0Rzu5ohazBT/wT
         vU/DrMzMAMTU5STqakuy08k/6F2fW2VARKPIvidCqCk9JQX3V/Oaz8yLwx4WKfltBryh
         D4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcnV+WgofUdUnjHcn7ttpHLZ5uRJGLZF9ORsYeoBcbk=;
        b=7UJ+8DpAhUBWCh7jaX2K2h3cnK4zBa5oyDB0Bz58wKZmD+aOevAdwhRL2A3DVvDeVr
         7wspmexyqhUp3se3hneA2I50BpZavu+4gFNRgrlz8toKy1KG3BQXse7m5fGrnSUWBHpc
         MZiwvFOrCJ69ATyT7AiSOdQrh7zh7rgNIW55crBWxClJvsaGPYVkYziMMPnoV8tCjGvP
         kAG12qX9hZPF03w/ZsOO6J5EQz1vnz8qkyI8+F0uVPD75uvYsUJ3yxFC9E6BTDlUhnoW
         b0GkIekGuz5UwFxdEz06vtA3Rimkd9TnQDKa3nyyMbOaSPUb+Tp95qrtzoLCUsyaNB+U
         HdSQ==
X-Gm-Message-State: AO0yUKXXm5Kmwcg3O7JoDspQLxcnp4NzXwHqxISV9t4O4yOZoSQ5KL7A
        vOuSiMQndG5XDDphKTjgKsPm+draMPPyWIq2tkUpNbSQjpiAERGY9D4=
X-Google-Smtp-Source: AK7set/Rw1eMOOQeLyIb2ALAtyWO7vjkufPbwgJNJmJCxVMFW2vQMrp2nO3n5eGrlqT/MSHDurWAQBibA4YGmQh/yGc=
X-Received: by 2002:a05:620a:342:b0:73b:a6e7:adb7 with SMTP id
 t2-20020a05620a034200b0073ba6e7adb7mr2310982qkm.14.1677187727732; Thu, 23 Feb
 2023 13:28:47 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsOnzrZa80BMZdJU=16Z7SZP2a-zbtkDQ10P+NyLhioqRA@mail.gmail.com>
 <Y/ekjIpVHG/jZ2Fu@lore-desk>
In-Reply-To: <Y/ekjIpVHG/jZ2Fu@lore-desk>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 24 Feb 2023 02:28:36 +0500
Message-ID: <CABXGCsP49H3TivoQKkBRos1Cx4zOVBUbbmXTrf-=1g2FBzs=gQ@mail.gmail.com>
Subject: Re: [6.3][regression] commit 2f5c3c77fc9b6a34b68b97231bfa970e1194ec28
 definitely causes use-after-free
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, deren.wu@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Thu, Feb 23, 2023 at 10:38 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Hi Mike,
>
> can you please check if the patch below fixes the issue?
>
> Regards,
> Lorenzo
>
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
> index b88959ef38aa..5e5c7bf51174 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -706,6 +706,7 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
>                 q->entry[i].urb = NULL;
>         }
>         page_pool_destroy(q->page_pool);
> +       q->page_pool = NULL;
>  }
>
>  static void mt76u_free_rx(struct mt76_dev *dev)
>
>

Thanks, with this patch use-after-free issue gone.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

-- 
Best Regards,
Mike Gavrilov.
