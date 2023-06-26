Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8790A73DDAC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFZLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFZLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:33:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C4B10DB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:33:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a04so9703585e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687779205; x=1690371205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMePQhdtBcD145xWWP6ObKBgPBwVavSA5DCnm+uLPN8=;
        b=U6qu03h0316pgcKA70DgwCkGBgdWx68jKFZW+1WrRbBsaHb5uHLiy1iibBG3su9pDe
         n4qg8U1R2B0+Q71zIEflIORXD3QiaQU/DDloPAr7wnCXwOLQVfxhWE7iGBtSuafeHA1n
         McIfhqj0WwFIQLFFCB5JcbARHZvEHcMCwYDmkVCaIb69S3S73jdmMyOvg1Ryq5NIE35g
         bWVeYdHid7Dtw2zL/YB69XFYaYIiWbTVnSADSY2s4q1Q+6ArVrR39Axfvui+9+kx/kVd
         SliSHdJiwBXy5FFLZhNG6iy4Q7jX6afHZbji/zyaJEZJdkHVDnn0gUa+4K5mINDF3AtG
         UxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687779205; x=1690371205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMePQhdtBcD145xWWP6ObKBgPBwVavSA5DCnm+uLPN8=;
        b=JBXWPq0ZxAUb+UkMD0TVPnijjFGKxEZfSswgMEMWoolA/hFGKLKgLuDdHxarWVZ4zU
         rWUSFIKHY4exqSpt1mFDMmpsOVKqAHIimJA/IYoc3kT7whcB8eN2enNchUcpUk6fbQrz
         W85fd6q4baYpa83o3TVow7tDvBFVIsFjLFB/Kzjt5OHSm0JEGWpkFKA/i92OT+di6zrz
         M0i6N6c7nsZ3mDuL43gkzNMvpHq1Bc7PMH0ydFHsrrLjyQ/Z3VEC5Ro38gQ5TzV09Xq7
         L2sewgEHB/dQQBag0+qPCqwLKawfP2mtccwqjCYVhhRQTaj+ynyZlqbu1jZXTYkFOCh1
         BdMQ==
X-Gm-Message-State: AC+VfDxKQgtp33b93NxS89obPI3/zmH2XyGmN4Yy4IHilt6S7yJi9XoC
        NzQJbFfzd3R/NAeCTfveCGBdLg==
X-Google-Smtp-Source: ACHHUZ4VqIEYP2PnHQc0NwXfgsVq3bgr+yPFv0RukQVPK2hxMBmZPFYLFUNb0ZpxLDmYzqbgruO3Yg==
X-Received: by 2002:a7b:cd11:0:b0:3f9:c7b0:4976 with SMTP id f17-20020a7bcd11000000b003f9c7b04976mr10274874wmj.12.1687779204683;
        Mon, 26 Jun 2023 04:33:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm7453169wmb.8.2023.06.26.04.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 04:33:23 -0700 (PDT)
Date:   Mon, 26 Jun 2023 14:33:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Message-ID: <3ea88e87-9b24-4f7a-958c-97e27d94ec30@moroto.mountain>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620133711.22840-5-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:37:10PM +0200, Daniel Wagner wrote:
> Commit 4c984154efa1 ("nvme-fc: change controllers first connect to use
> reconnect path") made the connection attempt asynchronous in order to
> make the connection attempt from autoconnect/boot via udev/systemd up
> case a bit more reliable.
> 
> Unfortunately, one side effect of this is that any wrong parameters
> provided from userspace will not be directly reported as invalid, e.g.
> auth keys.
> 
> So instead having the policy code inside the kernel it's better to
> address this in userspace, for example in nvme-cli or nvme-stas.
> 
> This aligns the fc transport with tcp and rdma.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/fc.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 472ed285fd45..aa2911f07c6c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2943,6 +2943,8 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>  	/* force put free routine to ignore io queues */
>  	ctrl->ctrl.tagset = NULL;
>  
> +	if (ret > 0)
> +		ret = -EIO;

All these checks for ret > 0 make me unhappy.  I don't understand how
they are a part of the commit.

I have tried to look at the context and I think maybe you are working
around the fact that qla_nvme_ls_req() returns QLA_FUNCTION_FAILED on
error.

Also the qla_nvme_ls_req() function EINVAL on error.  I just wrote a
commit message saying that none of the callers cared but I missed that
apparently gets returned to nvme_fc_init_ctrl().  :/
https://lore.kernel.org/all/49866d28-4cfe-47b0-842b-78f110e61aab@moroto.mountain/

Let's just fix qla_nvme_ls_req() instead of working around it here.

And let's add a WARN_ON_ONCE() somewhere to prevent future bugs.

regards,
dan carpenter
