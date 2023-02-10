Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC76925AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjBJSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjBJSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:46:39 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4557D3DA;
        Fri, 10 Feb 2023 10:46:38 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 70-20020a9d084c000000b0068bccf754f1so1806178oty.7;
        Fri, 10 Feb 2023 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUlqb+3iXXfUE/FtNTwardLG1byHcjeEmEXkZMeCbkQ=;
        b=ZcfcSMyWh/mAJd3LS255hXso8SlulM0qCYlf9Ezodpu1CNUpgaoJgptkreUgpTv+q+
         6JM5c7CuV5qZl0dSU9fBnJvpJzR2XvAqr94HmSEhNVZ/BVO+H38+4DYTKUG3ld/7B7y5
         6ofTzX7FpkvRnqilU3p4h7aGSrZvE0NlXtuUXq7zkUWHTqdCzkxjQqykJxKXRROU7yEs
         Nx7/4i0BJz33MapvEZqBsehhwxnNHfbaXyVEc9Y1keUaauR7nxxVleagC+OSnQQ9Oak4
         CocANXAGpNrPVCCBI2sQfkUOAd/gN4rlTxE7tJMpSwRcjoj0IF0SKzRiAgB+LlWPUG7W
         Pjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUlqb+3iXXfUE/FtNTwardLG1byHcjeEmEXkZMeCbkQ=;
        b=AkmjkCWAE5tcxYMwLTU9ARO2e6FLSKKu3rZIPBBvj1QxfJqA2trhXRxqkDhWt7+xkg
         g6y1tjQ9y7e0ZXfHSpdNA668PWgSlLw4jAciEKFvFSMTIWzUjLD8k24c7zk/Y/+YTWNW
         U8JEonL6gp7ON/D1E/5S69kkgW1u2J7VtgTQoLVhRGyxkhtbUlHcduJxznoSSeNcwa/g
         wL2O6hCUCHM1d0qf0jgNZFONW4Dd9HJJW1KKImr8wjbVuZAOSuJs8MOfD151e2q5iA4h
         JLFWjM9lVARBGAhDyWVAVxhM/CmVwYUYFiY275jR8HJQQrh8o6FOqIRwaufJCVCJPs6Q
         qzIQ==
X-Gm-Message-State: AO0yUKULmZKlGLJm6NbGiD1b3D9FRWgZRi4jRp8BV5DEDLtzsTXWXeMV
        pzci3V7QYSOBWazQKcKi9wkU9ml6LY0=
X-Google-Smtp-Source: AK7set/6WDjb0Ac8FyBvdHvYVEnN4JHixBgCqM+nFi/eMM4fSBpF45E0195TXdlRGCEsxx/DghyJvw==
X-Received: by 2002:a9d:64c2:0:b0:68b:e391:324d with SMTP id n2-20020a9d64c2000000b0068be391324dmr8417383otl.0.1676054797334;
        Fri, 10 Feb 2023 10:46:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x14-20020a9d628e000000b006863ccbf067sm2254944otk.74.2023.02.10.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:46:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Feb 2023 10:46:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     corbet@lwn.net, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation/watchdog/hpwdt: Fix Format
Message-ID: <20230210184635.GC3670524@roeck-us.net>
References: <20230210184247.221134-1-jerry.hoemann@hpe.com>
 <20230210184247.221134-3-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210184247.221134-3-jerry.hoemann@hpe.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:42:47AM -0700, Jerry Hoemann wrote:
> Add list format so that compiled documentation looks like it was
> intended to.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/hpwdt.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/watchdog/hpwdt.rst b/Documentation/watchdog/hpwdt.rst
> index c972fc2a3d0b..5eab5dfec042 100644
> --- a/Documentation/watchdog/hpwdt.rst
> +++ b/Documentation/watchdog/hpwdt.rst
> @@ -63,9 +63,9 @@ Last reviewed: 08/20/2018
>   and loop forever.  This is generally not what a watchdog user wants.
>  
>   For those wishing to learn more please see:
> -	Documentation/admin-guide/kdump/kdump.rst
> -	Documentation/admin-guide/kernel-parameters.txt (panic=)
> -	Your Linux Distribution specific documentation.
> +	- Documentation/admin-guide/kdump/kdump.rst
> +	- Documentation/admin-guide/kernel-parameters.txt (panic=)
> +	- Your Linux Distribution specific documentation.
>  
>   If the hpwdt does not receive the NMI associated with an expiring timer,
>   the iLO will proceed to reset the system at timeout if the timer hasn't
> -- 
> 2.39.1
> 
