Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E086DF55C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDLMfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDLMez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:34:55 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C492136
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:34:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id f14so25945603oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681302892; x=1683894892;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDK9Cp8HzVSl++mB/RxkaQtFo/hPIKWZDJJQXS4MtRA=;
        b=Rh63gHiSr6jmdLK3n7x+ra3VpE6pkEpkG0NgICKr1ebfWXTbCJDoJ+yl7lzPJjkqJ+
         iN5F2DExWmIPNV4vok9BXSEF9DGV6VZDYg2OSQZhaUnSCUwVNHHjHl6SEZS4YNDiL6E3
         fhgbXxvCfU25nPPHPKVci+m6jGWKKc/xiiFR6VVkgF/ju1r+ei0QzwymlAtl+O0ZIoqY
         FXivzHnSi5D18dgGPOEw6lG2ZI3njV/n48o+nHZcrJS0aG509Kilvh36vTRHHA9IXMZo
         OeRmmYaSdDwqUoKwR2YxABZkQAosnVlUODTf61N1EcDq1Akvx0wrOz2bP+D9tUIXLYI7
         NLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302892; x=1683894892;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDK9Cp8HzVSl++mB/RxkaQtFo/hPIKWZDJJQXS4MtRA=;
        b=pCmAVotwyG6n2J5B9513VgvDlBJNzy8g0hQVlVRjD/SXRm778j90ZUCL1X3aftKWxE
         ZcrQO8xVi9ZZwOAqIS5QAuXhFUmxiY0LlZBA45Xw29YI6xbacb3lDVy+App/eYnD9QS3
         CH6L0fVMTjG5jfP6nVqHduaLSWfYk448pWWRxO6/5fLquq3KVcOSTNTM9p6y9by22n8F
         TVN1DswgiTpLS6Y3Oy5cthplu6//1Jz0RWoJOm45LK+xgZVAhYJg4KIK5IlqLVdSs1UO
         RLxoReNA+qbMRSg8AkGhUBVE2T4u+2PDSGZLv0EOQDYaogooKsXrfAKYU+rI3WJ7B3pB
         qsyA==
X-Gm-Message-State: AAQBX9cZljLm8MRLKNnpiUQqpiGiu7j3MnZxzc5eMbaRHN6bcFWBFLg0
        pKPT/2EfWyeoNmNJDGzKmg==
X-Google-Smtp-Source: AKy350aFbiAZ6znhOOgC3aWDyFn0gBmlU6uNr2ehVUGesJOXn42UyVCByZDJZzxKxdUVbjReaX36uw==
X-Received: by 2002:aca:a9ca:0:b0:389:4d01:de0d with SMTP id s193-20020acaa9ca000000b003894d01de0dmr1390870oie.15.1681302891703;
        Wed, 12 Apr 2023 05:34:51 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id e2-20020acab502000000b00383eaf88e75sm6619830oif.39.2023.04.12.05.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:34:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6dde:1386:156e:63])
        by serve.minyard.net (Postfix) with ESMTPSA id 38D3D1800BB;
        Wed, 12 Apr 2023 12:34:50 +0000 (UTC)
Date:   Wed, 12 Apr 2023 07:34:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: fix SSIF not responding under certain cond.
Message-ID: <ZDalaSuK1P7Tg3sC@minyard.net>
Reply-To: minyard@acm.org
References: <20230412074907.80046-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412074907.80046-1-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:49:07PM +0800, Zhang Yuchen wrote:
> The ipmi communication is not restored after a specific version of BMC is
> upgraded on our server.
> The ipmi driver does not respond after printing the following log:

Excellent explaination, this is queued in my branch for the next release
and marked for backport.

Thank you,

-corey

> 
>     ipmi_ssif: Invalid response getting flags: 1c 1
> 
> I found that after entering this branch, ssif_info->ssif_state always
> holds SSIF_GETTING_FLAGS and never return to IDLE.
> 
> As a result, the driver cannot be loaded, because the driver status is
> checked during the unload process and must be IDLE in shutdown_ssif():
> 
>         while (ssif_info->ssif_state != SSIF_IDLE)
>                 schedule_timeout(1);
> 
> The process trigger this problem is:
> 
> 1. One msg timeout and next msg start send, and call
> ssif_set_need_watch().
> 
> 2. ssif_set_need_watch()->watch_timeout()->start_flag_fetch() change
> ssif_state to SSIF_GETTING_FLAGS.
> 
> 3. In msg_done_handler() ssif_state == SSIF_GETTING_FLAGS, if an error
> message is received, the second branch does not modify the ssif_state.
> 
> 4. All retry action need IS_SSIF_IDLE() == True. Include retry action in
> watch_timeout(), msg_done_handler(). Sending msg does not work either.
> SSIF_IDLE is also checked in start_next_msg().
> 
> 5. The only thing that can be triggered in the SSIF driver is
> watch_timeout(), after destory_user(), this timer will stop too.
> 
> So, if enter this branch, the ssif_state will remain SSIF_GETTING_FLAGS
> and can't send msg, no timer started, can't unload.
> 
> We did a comparative test before and after adding this patch, and the
> result is effective.
> 
> Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF)")
> 
> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index a5ddebb1edea..48be3694fa64 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -784,9 +784,9 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
>  			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
>  			/*
> -			 * Don't abort here, maybe it was a queued
> -			 * response to a previous command.
> +			 * Recv error response, give up.
>  			 */
> +			ssif_info->ssif_state = SSIF_IDLE;
>  			ipmi_ssif_unlock_cond(ssif_info, flags);
>  			dev_warn(&ssif_info->client->dev,
>  				 "Invalid response getting flags: %x %x\n",
> -- 
> 2.20.1
> 
