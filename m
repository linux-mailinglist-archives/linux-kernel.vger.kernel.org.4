Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F421674BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjATFSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjATFSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:18:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5BCDF957;
        Thu, 19 Jan 2023 21:07:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2812082wms.4;
        Thu, 19 Jan 2023 21:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhMPVNs8pc5Gcf/TDLS+cJfOurg6Vice8ut9+SSmMY8=;
        b=lPBcCni7LAwqOkrg3tNCH8jOSMnkyLgfAXhdSPuWk9jqGAy9XkKAhwTW8VXN/9cXFV
         /EN0DPv42as4B6vtPxwtHVBwWplBaFE/xI5qQE1NXH2AxyMx+9gxLM6ptWd4KJEHRmzb
         PWErnbqiYuGQMwvJmYfqM0L2mhGwa+odHughUHnkGdEyq6xKmjaDieso4h0auyn1xV0/
         lBCEyQlbbCtZSbCcG8TVIhyA7/s3F7B1TPz8ZVSzu0Eb+ilsNuvhPuFTvNLaf5EP+9e8
         SOaQlWzjm95h2IVLfV4LSD8eAOj5Q8/S5SKJDdPTZEuZbGPPrCSjmErCocWV6VcxF625
         40sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhMPVNs8pc5Gcf/TDLS+cJfOurg6Vice8ut9+SSmMY8=;
        b=aCsddHc2ydYxmY8WAPB7NdvGA8XCFIBJveipTumBJ6rzR9qoozt9dQ7k1IJHk7vn2j
         9tnu1HUxV8W4/xY89Y4pFiTemdLQlRpSGU7/Q0I8sSPzSl20ZV9CLXSfhtTPPUcjbhRB
         Q5koJG+d+kSt3M+rZCiHy/yC2X+4ZiYj3fy7HrzdtfUUAPYkN3iNWRvB5eLj551aAzId
         9WzFaaJl2m1qzWuOGG3t3oFY0EBh7XqIqeU65VwllOvk2xVPb1R5E4nKRqqkdFiomRX3
         slzHWcSR2IMCktAd/zict30VP4EBBCbt6N6M1zdAoO7L41Vy5z9idvK6ADSFeHHGrw3/
         c0lg==
X-Gm-Message-State: AFqh2koPFMCfXugtjvPuTLSSBEw2dP8n0x4lXLtgC9HeGxqIB6znShS1
        wzQXP+bubcKz3r07xfX2mwxGJqTAiZbUTw==
X-Google-Smtp-Source: AMrXdXuIRvrqtfIdcYDBTulA2LssPIlvNF6wzU/SosHvPjy1IlAsQclQWt+6yA36sTmWOi1wqynaYg==
X-Received: by 2002:a05:600c:3412:b0:3da:f678:1d47 with SMTP id y18-20020a05600c341200b003daf6781d47mr12556081wmp.14.1674191250364;
        Thu, 19 Jan 2023 21:07:30 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c188f00b003db122d5ac2sm1036738wmp.15.2023.01.19.21.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:07:29 -0800 (PST)
Date:   Fri, 20 Jan 2023 08:07:26 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Gaurav Pathak <gauravpathak129@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Fix some endian problems
Message-ID: <Y8ohjkgNjyQPD+Dd@kadam>
References: <20230119191219.12080-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119191219.12080-1-Larry.Finger@lwfinger.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:12:19PM -0600, Larry Finger wrote:
> Sparse lists the following warnings:
> 
>   CHECK   drivers/staging/r8188eu/core/rtw_mlme.c
> drivers/staging/r8188eu/core/rtw_mlme.c:1197:49: warning: incorrect type in
> 					 argument 2 (different base types)
> drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    expected restricted
> 					 __le16 [usertype] mstatus_rpt
> drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    got unsigned short
> 					 [assigned] [usertype] media_status_rpt
> drivers/staging/r8188eu/core/rtw_mlme.c:1275:57: warning: incorrect type in
> 					 argument 2 (different base types)
> drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    expected restricted
> 					 __le16 [usertype] mstatus_rpt
> drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    got unsigned short
> 					 [assigned] [usertype] media_status
>   CHECK   drivers/staging/r8188eu/core/rtw_mlme_ext.c
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58: warning: incorrect type
> 					 in argument 2 (different base types)
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    expected restricted
> 					 __le16 [usertype] mstatus_rpt
> drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    got unsigned short
> 					 [assigned] [usertype] media_status
> 
> The second argument of rtl8188e_set_FwMediaStatus_cmd() needs to be in CPU
> order, not little-endian; however, when it uses that value to call
> FillH2CCmd_88E() the parameter must be in little-endian order as that
> value will be sent to the firmware. Note that the conversion from LE to CPU
> order was le16_to_cpu() rather than the correct cpu_to_le16.
> 
> The definition of FillH2CCmd_88E() is revised, and the proper conversion
> routine is used.
> 
> Note that the original code performed one byte swap on the secong argument
> of FillH2CCmd_88E(), and got the correct answer even though the semantics
> were very wrong.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Reportewd-by: Gaurav Pathak <gauravpathak129@gmail.com>
         ^
Extra 'w'.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter

