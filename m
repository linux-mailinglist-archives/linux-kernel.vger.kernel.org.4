Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED38658B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiL2J6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiL2Jzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:55:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C2313E98
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:54:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso9729174wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGbWpL0DNZKbYvlvS2zwuY6SU88y6BayDLXZUlHWO+I=;
        b=XAx5xBafnAL9dpqePbaKrhbnMREVc94BB5V3q71Qm8hMsTq7P3emFNVfRfMAAqCJwh
         DzcSGs9WW3Hq67TjVliWzQXmNQZIx9i/Hf6TaQPGf0oVB51AMbW/4IfHrbsGxt3zICDM
         dpA64u4IjV8Mf4I9BjAKl37V3FF6yN10ZaORyQZomlsBJuhmWMte00ijXsj1iVgv0Vcr
         s3VTDRs3eOf4hrAt1gfrSefLSGFNduwNxaASf2j5IrUK/rxsL741H/h5b2ESsP7jxNUJ
         KgDPzi1uasq8BGY0/DEuQjYOgQ/AYkcLv5PSTOOQmjuQZaaK4+j46xqKR1PmP7zjF5Br
         IMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGbWpL0DNZKbYvlvS2zwuY6SU88y6BayDLXZUlHWO+I=;
        b=V1PkQAMOUBwz9jZRZBN9q0I1GJ3irJ4w0e8hCOIg0SelBsI1pzS/pMBjkTyEhNCSWE
         ED84CCAVofgsMZJPb7EPYsuxy+FZ7EzY33kT0I2A7Wzn/kXSBNjIpwAT34vayccXZBBj
         wcSymL31CGg+4Kg0P9svm0sh7qyuoO0SCsT7LZbwajczozfJQr7Hd9s/oUWplSD7R/HA
         PKWsfnZzH64yNgasxkq2l0aPVzrL9wJ3HaDVdbkX6yCEJ9w5lVe3cg9nPNMCDbppcfzo
         QbtnK4mUyt3UtIE4jxq24iB5kGmjEq+WJSGA2kOLrMyZ10kXO9iOy+KxBgdGXJmVGH5z
         HPmA==
X-Gm-Message-State: AFqh2kotzCDAqb6PYF4ITTMd6Q+Wk1RHoBaG8deZVd7dJXhWNqjaOEC1
        NmdXQcjNQuJR86T6gEarrCw=
X-Google-Smtp-Source: AMrXdXv1yxSN05BwXx/7xpHfFtmInzrvAXkdw+kTEUqLfln0bgcZevJfZjphRsbPvaHfnVEd7D1D8g==
X-Received: by 2002:a1c:4b04:0:b0:3c6:f0b8:74e6 with SMTP id y4-20020a1c4b04000000b003c6f0b874e6mr20245900wma.4.1672307671861;
        Thu, 29 Dec 2022 01:54:31 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b003d34f170487sm36078662wmo.0.2022.12.29.01.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:54:31 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:54:28 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     yang.yang29@zte.com.cn
Cc:     gustavoars@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] staging: ks7010: use strscpy() to instead of
 strncpy()
Message-ID: <Y61j1JRx0ZMeVjji@kadam>
References: <202212261903245548969@zte.com.cn>
 <Y61hpuMcp3NKbqL5@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y61hpuMcp3NKbqL5@kadam>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 12:45:10PM +0300, Dan Carpenter wrote:
> On Mon, Dec 26, 2022 at 07:03:24PM +0800, yang.yang29@zte.com.cn wrote:
> > From: Xu Panda <xu.panda@zte.com.cn>
> > 
> > The implementation of strscpy() is more robust and safer.
> > That's now the recommended way to copy NUL-terminated strings.
> > 
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > Signed-off-by: Yang Yang <yang.yang29@zte.com>
> > ---
> >  drivers/staging/ks7010/ks_wlan_net.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> > index 044c807ca022..e03c87f0bfe7 100644
> > --- a/drivers/staging/ks7010/ks_wlan_net.c
> > +++ b/drivers/staging/ks7010/ks_wlan_net.c
> > @@ -382,8 +382,7 @@ static int ks_wlan_get_nick(struct net_device *dev,
> >  		return -EPERM;
> > 
> >  	/* for SLEEP MODE */
> > -	strncpy(extra, priv->nick, 16);
> > -	extra[16] = '\0';
> > +	strscpy(extra, priv->nick, 17);
> 
> I think this code is a buffer overflow.  This is an implementation of
> SIOCGIWNICKN.
> 
> net/wireless/wext-core.c
>    169          [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
>    170                  .header_type    = IW_HEADER_TYPE_POINT,
>    171                  .token_size     = 1,
>    172                  .max_tokens     = IW_ESSID_MAX_SIZE,
>    173          },
> 

Yeah.  I was wrong.  The extra size here is .max_tokens * .token_size so
it's 32.

Sorry for the noise!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

