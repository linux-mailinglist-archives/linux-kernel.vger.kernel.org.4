Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA52645806
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiLGKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLGKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:36:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB94666A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:36:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so16652763plw.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXDt43WcxRi0yEl4LUCrE6EiS048gbigVAfotYTXWMA=;
        b=OfSidZZyzHwOccnkBhJr31EUDTd0aqwPIP2Vy/2s64q3/hYi2Cj9nhU6X4OXnM9kj8
         cQk/Sc2/UcvAJR0ySTJ52FJIBDWbBfNWy0RjyUPgwLQt/ogm3pY2AmsIHPwcK6x4kOlS
         3iGTfY/9iJ7W3ZFSgE28u9R6mSyzxBmb2YERT2AslNmqSlU2rniGfwDviVxrAjzokS1R
         gybmuvaODSUe6TU/7pIfG3IvMTn4GTtJ+TvkJfoB93SgnNm3mxEz3y5eaGbamFMhjcT0
         LbfFb+olIQfp2rVKtrpE38IK2+py5xywcKPP+xbQGFSyBFNl821c4Io5TvIaenR2Xh9z
         ML+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXDt43WcxRi0yEl4LUCrE6EiS048gbigVAfotYTXWMA=;
        b=O8v1mB25dYwv/65i90aK4Mb5g1zoGPhkBtybNSBcq1c/tyxrQiFaLFe4vV7pENUSQ9
         rXYwmo4giW8MEnqxAgJZ0cse5SxAHTYdJYBjctGAt0G4dn+J+ExchX3LumwvXvFDn9Rb
         3bCSD2hwtk1+e61PulOyQxIkM1INlLVCDY8XVg3pUbPBFxVPyRxplA1lu49t7sPs22JK
         sgSVjFnjWU2xWKllRrE/OE2D+QaaZsha3O5MuVndZYZk/edXwYyHZ5/JbOofEJgmchoL
         bk2MaNnKv/JazJAS/jgPQWxbDFXpgeOAilXg6UGGJQwm4+reaSJKr0knQ05UhJDYYAFq
         93SA==
X-Gm-Message-State: ANoB5pmtf7qu1XP+P7RQ58kjv4ovNZqqa5jyiBZLn8+FKqmvxUvZIdoI
        HvhSnU99KdzIZWrNi23SpZduZuCn9iwD0LHnQeZEFA==
X-Google-Smtp-Source: AA0mqf6POyxwbgYFsLY6UGBqsMViLNvBcr1ewyhVLGs8qFhj4QOL8HVd374Y0hYDeyCuP7dK9zIMkn3CGStA+VYOKYM=
X-Received: by 2002:a17:90a:7485:b0:219:ef02:a5eb with SMTP id
 p5-20020a17090a748500b00219ef02a5ebmr10202121pjk.84.1670409391243; Wed, 07
 Dec 2022 02:36:31 -0800 (PST)
MIME-Version: 1.0
References: <202212011950119139713@zte.com.cn>
In-Reply-To: <202212011950119139713@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 11:35:55 +0100
Message-ID: <CAPDyKFpEqKUaqoJhD4xQYXaG-fmsG_XgqD3AJV=DjftiGbW1bA@mail.gmail.com>
Subject: Re: [PATCH] memstick/mspro_block: use sysfs_emit() to instead of scnprintf()
To:     ye.xingchen@zte.com.cn
Cc:     maximlevitsky@gmail.com, oakad@yahoo.com, axboe@kernel.dk,
        hare@suse.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 at 12:50, <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.

There are plenty of other conversions that can be done using
sysfs_emit_at() in drivers/memstick/core/mspro_block.c. Would you mind
doing that too, as part of the $subject patch?

Kind regards
Uffe

>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/memstick/core/mspro_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index 61cf75d4a01e..ae3a5dc00344 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -356,7 +356,7 @@ static ssize_t mspro_block_attr_show_modelname(struct device *dev,
>                                                      struct mspro_sys_attr,
>                                                      dev_attr);
>
> -       return scnprintf(buffer, PAGE_SIZE, "%s", (char *)s_attr->data);
> +       return sysfs_emit(buffer, "%s\n", (char *)s_attr->data);
>  }
>
>  static ssize_t mspro_block_attr_show_mbr(struct device *dev,
> --
> 2.25.1
