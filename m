Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945BD60CB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiJYLrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiJYLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:46:42 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C77963B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:46:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s9so2657705ilu.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkOLSjtDBaYH15rz5kr5Th8k/YFVwMAjgA02jyFP02I=;
        b=oxdotC+Q6HeQ/gfub29oYzM2uRkrTGZ65p0JdzarAedpX3XXnRTVjLR5Lz9JXGBhUK
         LsWA6V0mj7L2GNJyhHbbEL0q26Ee5hepMoPayZYEDVSLpmR2SAq35pF9Qa4y/FGY/rEi
         NoPioE87BupjsFKxu103qAN2gqT79poKBUjHsYjLM1fuvPXhaAYFU3k/p6Ob8bkMI0g2
         c97nfwX4WZKf5Rg6tgRXu9P8Lxn1tdKObVckDcOx3e0PC++YQkfHTPjjI0Z2SEP727qO
         R/ixNcwqARHveJamR1iyMcvP9qgycEStuwiXA8O/fLI3krsdQvnpxdo0EOfGfVCj5P82
         5KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UkOLSjtDBaYH15rz5kr5Th8k/YFVwMAjgA02jyFP02I=;
        b=o1sWRm/m8ZeHOs7ez8poB5eRLqZunTOgATIy5282xPqvOhStYSRJjXvwN+RX4/A5Pj
         VL4foOIuGwI4SSpYAb2jUVm7rbU/DYvHwI4UafW9t3sDv/AojVUmMJtkV1wdRgO7ELD/
         PbNc/Hp0QSNP3ANJJJmpUIPJdJCkvCeNwx41B+8ARvfzHQCz9DKdEy2Jo/WaPOdj2VWj
         ROhXOLgKuJU3tCpfxW9ZEItNr5Zbsez3tZzHBsDsGhTckOQJq4GIiH01LN5tOhWd1Tf6
         rv+LnpTpNsR4F/4rRyX7CnrpxT4ixYE3Pc0iBBHBbY8OWJoWxc/W+EwyxFVoqjfuxU6B
         EezQ==
X-Gm-Message-State: ACrzQf01iwIFbxCUerd9LwDP7ajHSmiSDvjmhbvzFvhWgfqJvPKGuqzV
        MAWF/mR3e5eckDoq7Q5Klw==
X-Google-Smtp-Source: AMsMyM63nZa4MNVDtyt1Q2lLYsKgeVQZK2niHUMonnWUtKnY4E2tohjZXP7bEylvukx2k0QxVe7fvg==
X-Received: by 2002:a92:2c0f:0:b0:2ff:e0ad:f548 with SMTP id t15-20020a922c0f000000b002ffe0adf548mr6282101ile.84.1666698377617;
        Tue, 25 Oct 2022 04:46:17 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id a95-20020a029468000000b00363bd76184esm809606jai.162.2022.10.25.04.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 04:46:16 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8fea:c04d:3e8:da78])
        by serve.minyard.net (Postfix) with ESMTPSA id 7A1781800BD;
        Tue, 25 Oct 2022 11:46:15 +0000 (UTC)
Date:   Tue, 25 Oct 2022 06:46:14 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Bo Liu <liubo03@inspur.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Fix some kernel-doc warnings
Message-ID: <Y1fMhj8ozX1WqQ2t@minyard.net>
Reply-To: minyard@acm.org
References: <20221025060436.4372-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025060436.4372-1-liubo03@inspur.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:04:36AM -0400, Bo Liu wrote:
> The current code provokes some kernel-doc warnings:
> 	drivers/char/ipmi/ipmi_msghandler.c:618: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Thanks, this is in my for-next tree.

-corey

> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index d5ee52be176d..f6b8ca6df9b5 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -614,7 +614,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>  static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id);
>  
>  
> -/**
> +/*
>   * The driver model view of the IPMI messaging driver.
>   */
>  static struct platform_driver ipmidriver = {
> -- 
> 2.27.0
> 
