Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E786BCEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCPMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCPMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:05:24 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF765A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:05:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r36so1154331oiw.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678968323;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RHK9cOuEeUz5rqUW+dgIK39QatovxgfybZXB5f1x2Q=;
        b=IPwEb03AreDMeZM2z/HCIaXakUuz6kjp3MdBkPHuoqkJTPuuhLTSO68vjLKW1VGYPf
         6j7xjopGv/xIbPlhBCv1TyvSMLITYyhxP26Vkj2n1rF+JEPa90aoff/Uy+QdTKqSoe40
         sGwLf1g+An8UjfxlwC3gh30dmztkCWkDdYtavcTsXS/2R4YJbQaHq+s5AVN59PWR/zW+
         1mBUrGcQq4v8gdt5WdCfbIp5lrEw+baXr8WEXPcoHBRmXw1mL3n49AOj31ZjOIIX2a91
         +NoEu+fZ1O9XjqTE85Yro4q4/0XaemrkO/CborKe4DQRS1F70pppeVMtEjukhlkR10YJ
         ic6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968323;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RHK9cOuEeUz5rqUW+dgIK39QatovxgfybZXB5f1x2Q=;
        b=0si5PG+jpP/rK/SanfRf/NBHkHTCn+ADiEIvybRqk0WZb7Y8fbFeb8r1MGaoGwKe14
         pmNleAlYxYubFbhVdnScgxJMOgUgHBNG0zGHOKC73lDlYQRkJ/HZ+blz7Du2iG6HyiGX
         dKtllXVwlbYDAEe0WVBQ6Q73mQdfdgQNI5RVGPbFY9KbxvgZmCqzkU/gNkw1uDgHTpvF
         0GFOfXp+/FpWSZMSZJjAQLTj/++FBtcO9EemJgkx4s2DpH2BKjA4jhS2bAyF9I46/h9k
         djOwF5IiCD3MWBEZadW6rM3nsLQvaGmpywSlrLKZH3lpiV7bljmod9fzT55/mw5LgysJ
         ilOg==
X-Gm-Message-State: AO0yUKVFyLZ8CCfY0V1QpkZlOWrMdiIFke9MOlvstMX/oAZjUMD/uVha
        RZwR3Zg078y8jRuyney2Kf/FKTeRqg==
X-Google-Smtp-Source: AK7set96pdgZ4Ojnlh0KkhqBkHRMtr3tl9BNUgafUZ2a3n4wFljMkTKLNUaXdgtbDXBDPDXQl2W0CQ==
X-Received: by 2002:a05:6808:234b:b0:383:f8a3:2529 with SMTP id ef11-20020a056808234b00b00383f8a32529mr2812623oib.6.1678968321620;
        Thu, 16 Mar 2023 05:05:21 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id be8-20020a056808218800b0038694b7dc09sm2876498oib.55.2023.03.16.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:05:21 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:a22e:e7c0:9025:2a43])
        by serve.minyard.net (Postfix) with ESMTPSA id 069A0180052;
        Thu, 16 Mar 2023 12:05:20 +0000 (UTC)
Date:   Thu, 16 Mar 2023 07:05:18 -0500
From:   Corey Minyard <minyard@acm.org>
To:     zipeng zhang <zhangzipeng0@foxmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char:ipmi:Fix spelling mistake "asychronously" ->
 "asynchronously"
Message-ID: <ZBMF/v14oqTcv7pS@minyard.net>
Reply-To: minyard@acm.org
References: <tencent_F0BFF85BC7C1FC84E440A7B7D364D2ED4209@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F0BFF85BC7C1FC84E440A7B7D364D2ED4209@qq.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:39:58PM +0800, zipeng zhang wrote:
> There is a spelling mistake in the comment information. Fix it.

It's in my queue.  Thanks.

-corey

> 
> Signed-off-by: zipeng zhang <zhangzipeng0@foxmail.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index a5ddebb1edea..1a85b400e929 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1283,7 +1283,7 @@ static void ssif_remove(struct i2c_client *client)
>  		return;
>  
>  	/*
> -	 * After this point, we won't deliver anything asychronously
> +	 * After this point, we won't deliver anything asynchronously
>  	 * to the message handler.  We can unregister ourself.
>  	 */
>  	ipmi_unregister_smi(ssif_info->intf);
> -- 
> 2.39.2
> 
> 
