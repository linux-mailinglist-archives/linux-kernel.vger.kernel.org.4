Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE16E5829
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjDREnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDREnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:43:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5EC272C;
        Mon, 17 Apr 2023 21:43:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so12998455wmb.3;
        Mon, 17 Apr 2023 21:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681793009; x=1684385009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo1dY/ttewg13qVvGQdVcJPBa1hUmnXLA4fbsLDnKVc=;
        b=P2/wTxe/u056PKJtPuL+KjH/34N8gvJxmrFOtAFqIhFBOsZrLDojAOAHd6fzN2Qe7a
         iGzXEXksMsxKSwLZ6PYwwLsaj/Gg8uo251YpzBYC63H0h1MwJ+bw6QgSDSq+dghzmgF8
         4oyNsZ+xVBQ2uqyY1YX9XunXPDDw57AWSoarIHh0vT6NCnQlDYnV6F22KXHwlqhMYe1Z
         iz/7pzgOmLEwwEFG40MbXfCaSzNZE/VPyaD1tWmDhr3jM2qQ8J0H7y6OMzFa6bilAVrv
         fghW8rKmIhFUyT1XwLBvI9Ju4aguPPoFW7pLsUfQY2kPak/hdAN70gKw5nVWkPJ9zt8t
         B2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681793009; x=1684385009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo1dY/ttewg13qVvGQdVcJPBa1hUmnXLA4fbsLDnKVc=;
        b=N1wb0bMzwiYvBRqE5eGJWTnhrAcpCQPvIqMIMPbz06lOz5ifXPQR0V9Vwc5FMTYsOJ
         Ncwq0A+Q17fxS8pOz5FEJmRHlXq/gyk/L+HphZYFMdluJXr2+rTJu6LYn5OfSGvj0AQU
         pkwxZP/lHbkyUrhsFPUSKv7D1wHWADX3onpLl2Ia4sEEP8s/qiCBtpn0zWlF+scEuG1X
         YbIAbeI5zGyOZvqyYc3n/DP8W/TNFT6vDZyAW1+yNlx21Ng1Xmw1tezC4BYWN7xxzkpc
         9sqQuhEhjpuEypuKfifvxoLzqxNcULMrdlEp93TL1n4Rn+zAtITWRo7ifhtmjmnII4D/
         OyIg==
X-Gm-Message-State: AAQBX9e9Usl7PxxkIogbpmA/WYznN2TcMQaTQ8xqQ3GincWcKWNwzu7h
        nyEFRgAZNUVpc6BTJvd9QTdezq6s4faF4PAY
X-Google-Smtp-Source: AKy350YCgcQ296ja4deDMuyoPZgAFD/KiSBIyP+WT9ox0lGEwO7mXcoadEYNo8ROEFvprJ8PD0y6tg==
X-Received: by 2002:a7b:c38a:0:b0:3f1:6fba:b69a with SMTP id s10-20020a7bc38a000000b003f16fbab69amr6614091wmj.11.1681793009247;
        Mon, 17 Apr 2023 21:43:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b003f0a090d798sm15629180wmo.18.2023.04.17.21.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 21:43:28 -0700 (PDT)
Date:   Tue, 18 Apr 2023 07:43:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: remove some dead code
Message-ID: <2867d5b3-c6cb-49fa-854a-0f58f9a5adb5@kili.mountain>
References: <523ec4b037d064e92e19203e3ab9a161e3d9aa71.1681764681.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523ec4b037d064e92e19203e3ab9a161e3d9aa71.1681764681.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:51:46PM +0200, Christophe JAILLET wrote:
>  
> -	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
> -	if (!ret)
> -		ret = ret2;
> +	ret = filemap_check_errors(NODE_MAPPING(sbi));
>  
>  	return ret;

Let's get rid of "ret" as well:

	return filemap_check_errors(NODE_MAPPING(sbi));

regards,
dan carpenter

