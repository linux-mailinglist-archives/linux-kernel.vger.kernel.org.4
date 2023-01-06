Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A6E660979
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjAFW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbjAFW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:27:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032F184BDA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:27:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so4599161wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EMQOzwmfuRZl552G69+pCqsXxQZTt1N1oJx/8nrVhvU=;
        b=L8b6ctlnXzv5qRopWOZuNC8OcoxVT5s+SS1wp75LfHRZhMDwxxizVYWgi1QDlHRNeA
         qlZXTyp2cHOMXcPOO0t5U41sRF4VuYKyiE8Kv24cY9HoF19o5q5CXOMu+l+rbtqDukgS
         Xh1URH2uJq18iu/KgMLYx3WQWEl1vk41h0jfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMQOzwmfuRZl552G69+pCqsXxQZTt1N1oJx/8nrVhvU=;
        b=JTMc+XHpXUfgofPCv2PrTKfpsEWAE4KV3ZX7B0q1lcBE4LLALU3u52bfFkU2IiT/AF
         jWin5ab8FAM0Wcp7QdLe+VFIQhjsozfJ8Hm7+N1gBUBfJvZ8Rd5+JEqnGl1A0RFwJyqc
         TjBslu+qxm05AhcuYVJQ8C+kTkngt575uPTxfH3uKBSn0qNEfGLU8F/eCauFbxdGJL8/
         vnZTDHJqILfqc8eUzNYRWBEnbdqAIU2p0YyNGj4CsbzAWe65wExzgWVr0YRRgIab8kNR
         a/GmkKQtFREnjJkE5a8Cz0a3bZdqR2u9/ipu3+DUsTEygsnQF/PR1VkUtnzZHD25VmmG
         CTlA==
X-Gm-Message-State: AFqh2kpngd69oodAfixjTMUQgBmCxWduSDBZMY4tlyVUrnz0JYq3Yjau
        KHKaPkHvsfMOQiZbhFtV303OcQ0hyOtAvVmLh/onCg==
X-Google-Smtp-Source: AMrXdXvGiqtx4OP9tf7Dg1vIM7dQN3Foq/M6hy40hKYPkPEposJNKfVCPl63IUt5Wc2pxvHBEfkGB8T3Z11tjmWnEmI=
X-Received: by 2002:a05:600c:4153:b0:3c6:c182:b125 with SMTP id
 h19-20020a05600c415300b003c6c182b125mr3731572wmm.145.1673044036338; Fri, 06
 Jan 2023 14:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20230106045327.never.413-kees@kernel.org> <CAODwPW8kXZ107kMuVGya9Y=i+8QwQzQHokXCpybzMBjd_w_83w@mail.gmail.com>
 <202301061234.D15CF0E627@keescook>
In-Reply-To: <202301061234.D15CF0E627@keescook>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 6 Jan 2023 23:27:04 +0100
Message-ID: <CAODwPW9bM8+V+JphjpNHS9YRmb+AXNQUi+VRjORkGZP6gY=ynA@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Check size of table entry and split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, exactly. Isn't that a bit simpler? (I wasn't aware of the
flexible array member in union issue, but it sounds like we have a
neat solution for that already.)

On Fri, Jan 6, 2023 at 9:35 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 06, 2023 at 04:03:35PM +0100, Julius Werner wrote:
> > Have you considered adding the flexible array member directly to the
> > union in struct coreboot_device instead? I think that would make this
> > a bit simpler by not having to copy header and data portion
> > separately.
>
> Are you thinking something like this?
>
>
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index 2652c396c423..564a3c908838 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -93,14 +93,19 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
>         for (i = 0; i < header->table_entries; i++) {
>                 entry = ptr_entry;
>
> -               device = kzalloc(sizeof(struct device) + entry->size, GFP_KERNEL);
> +               if (entry->size < sizeof(*entry)) {
> +                       dev_warn(dev, "coreboot table entry too small!\n");
> +                       return -EINVAL;
> +               }
> +
> +               device = kzalloc(sizeof(device->dev) + entry->size, GFP_KERNEL);
>                 if (!device)
>                         return -ENOMEM;
>
>                 device->dev.parent = dev;
>                 device->dev.bus = &coreboot_bus_type;
>                 device->dev.release = coreboot_device_release;
> -               memcpy(&device->entry, ptr_entry, entry->size);
> +               memcpy(device->raw, entry, entry->size);
>
>                 switch (device->entry.tag) {
>                 case LB_TAG_CBMEM_ENTRY:
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
> index 37f4d335a606..d814dca33a08 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -79,6 +79,7 @@ struct coreboot_device {
>                 struct lb_cbmem_ref cbmem_ref;
>                 struct lb_cbmem_entry cbmem_entry;
>                 struct lb_framebuffer framebuffer;
> +               DECLARE_FLEX_ARRAY(u8, raw);
>         };
>  };
>
>
> --
> Kees Cook
