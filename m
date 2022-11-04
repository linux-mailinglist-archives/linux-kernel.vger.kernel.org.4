Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899261917B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKDG5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKDG5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:57:22 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1692F656F;
        Thu,  3 Nov 2022 23:57:22 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id g16so1895872vkl.11;
        Thu, 03 Nov 2022 23:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAu7avbRwIGd2fwGHCJmgmPKqmQjXHREloI21uMgOjM=;
        b=Votyuy76zN6cU4EntSX9bdqU4qeiY/VJDpt62DtPMUzaY+nmsxh8NwAGjuhmFEPt/o
         YBIeOcaTE2DGB8q4aSR5S9V6S7Dvo0IYm9gxkP0toA3APMQjHNb08KnpZgyoMRaXO31B
         BJzLY+kuqqDHSzyBXAQAPQN11Jdky0bZnu01f9DKjANFAxLtHIvCab0ucxHWHcrNtrBJ
         x0fP2Cg2nLNBLismWFQ/D2tfXw6tCgd2v4O9AXSk2MFjqU4OVFpgqBWimiVSPZq9w/Xg
         N90RiyN8cjkeczYVJ/WlZsDpj9BkBTKDFpakLPKqyIOXk5JcGqIk579wevtu5VJIWHjt
         wK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAu7avbRwIGd2fwGHCJmgmPKqmQjXHREloI21uMgOjM=;
        b=f5gOUOA7USIZp0XOxHuXYeLChvySMgE9O4Z1FxQJYCBLe6vAWgYqCaTVXWV3cRf12D
         JDM5izKPCPuydSCfSr8IWzkJm1THun4P/bki4GGi4a7DPCpu5CiS94DfQ/VbS8UyxtJ2
         D47OjBid1olNKRrThuDxy2wp6ZlHKK08aW7M38WvqU/ju5wm0nZUjGHS/+IfHQHmbk3f
         2IP3wVwUD1bn2DY+7zvCVcHSNYGPBUw9otQs7B8SqOY1kVGcDrr+fI1ORB8lKbq47dK8
         c4jse6x3WToRtgdnzV2NgmlTCIcdVvMNR+WeWo2+CayzhK3GaseXimiZghl9/Y3XlvCR
         tIwg==
X-Gm-Message-State: ACrzQf2m55bf8OE6huKaIipI8MSpgUqFjcyDZpqbvL/DWRVPOrI980xP
        tPvAfcPjhUU2eELbKSxqTSyJXlKdc5t1FF+1HLI=
X-Google-Smtp-Source: AMsMyM7r4TvZPI/sr1xuU0sKbFppIpO4bFK9VcmyZLhh86+X3uSB2Ia2n26fQoKt3h9uu2Xl2tU3+4Z0x2zlaZPBN/g=
X-Received: by 2002:a1f:254f:0:b0:3b7:7495:86d5 with SMTP id
 l76-20020a1f254f000000b003b7749586d5mr19345652vkl.23.1667545041030; Thu, 03
 Nov 2022 23:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221104054053.431922658@goodmis.org> <20221104054917.009383303@goodmis.org>
In-Reply-To: <20221104054917.009383303@goodmis.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 4 Nov 2022 15:57:04 +0900
Message-ID: <CAKFNMomoVn3Zj5xaH6hjXHO+KXj983yZEue5Jx4wH+_m5NiJjA@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 28/33] timers: fs/nilfs2: Use timer_shutdown_sync()
 before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org
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

On Fri, Nov 4, 2022 at 2:48 PM Steven Rostedt wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Before a timer is freed, timer_shutdown_sync() must be called.
>
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/nilfs2/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index b4cebad21b48..c50dc377da26 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2752,7 +2752,7 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
>
>         down_write(&nilfs->ns_segctor_sem);
>
> -       del_timer_sync(&sci->sc_timer);
> +       timer_shutdown_sync(&sci->sc_timer);
>         kfree(sci);
>  }
>
> --
> 2.35.1

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

This is the second time, but my Ack is not tagged, so I'll reply again
just in case.

Thanks,
Ryusuke Konishi
