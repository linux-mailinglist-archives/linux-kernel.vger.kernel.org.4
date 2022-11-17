Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC462DD28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiKQNtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbiKQNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:49:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DA374CC0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:48:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1844993wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exT2ZQLPAoL8Phw+t6FICqCJGLGtwOOjmtYci6xC2LY=;
        b=A1XarG81kWg5nTxjgA5WIYiv4myKkso5jzrI4CRayZl6pCAKrqVWy5qG7+4LhJ1mdj
         eiWYWyeIegz6UJan0h5W+kbJAIxvDI3oH/vOzlNoSfhS7p290fnavonWxqKiMSHk9Glr
         lxdp3j8AyWNbSGYhh2eaEhILBN+Hc+ACixMBcCCBdQlHdrI7v+bS8X5Jt2m7eQ+HqGeH
         uvo5nHaXMObIvRuy/1SrDfaknlCZH5gYV+gVFOt7Eg98PjLNvAwOq0E2zG43BXRkqv4R
         C44LyDAXD3z0uJT9x3Yuuom9PIa9iHojvkJuhh2zMspvy71qcRfx0T2A9bHeExAf5nIK
         tSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exT2ZQLPAoL8Phw+t6FICqCJGLGtwOOjmtYci6xC2LY=;
        b=CP3ppeDlI/SMVf8w9rYloKcwa5dZ2iWdqpjAmeoWORD1Lx0D5A1kmcmDdHlXQq6pzE
         YNWx1EohFGFQtTgZRE6Zx++IPhH+ogJlb1oPeFtofefM2Fsb2OZ4TjsGJ4DjqBPME9+S
         D9LTKXVq48Wo0X9qYB4FFW4z11IKkp8RSBFy+/yyVMcDQdTDhSGpriZxOKKiUIJn2CGC
         Y/VUY+yQxj0Oh4t7Q0v+ap+v24GWQH2qOEpX8R45d0OekbxbyI4cUkkgurbSAya9dA32
         pf5TLZSHUB1h+E6Arz0a96zN2/kIVaPtMhUSX1cde8jfsYuXmWmA+565eECUCLYgPwgr
         3AIg==
X-Gm-Message-State: ANoB5plxRSYWC+DHR3II/qxA+9LBaJXdxoKUYjDL5o/PE+ORcwpmc6i6
        fODmVx1VxZoniuZA8JR/8ys=
X-Google-Smtp-Source: AA0mqf70KaB7xiqLNOLXa+qscg+ayWkZsC462X0+3cZu1xEpprjF5WH4/oF4DF2trfuZapP8FFKKdg==
X-Received: by 2002:a05:600c:3503:b0:3cf:f0a8:d04e with SMTP id h3-20020a05600c350300b003cff0a8d04emr5413810wmq.45.1668692932796;
        Thu, 17 Nov 2022 05:48:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a1c750b000000b003cfe1dcd354sm1242507wmc.27.2022.11.17.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:48:52 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:48:44 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 2/2] staging: vc04_services: mmal-common: Do not use bool
 in structures
Message-ID: <Y3Y7vCk3gwDH/TpK@kadam>
References: <20221117125953.88441-1-umang.jain@ideasonboard.com>
 <20221117125953.88441-3-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117125953.88441-3-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 06:29:53PM +0530, Umang Jain wrote:
> Do not use bool in structures, it already gets flagged by checkpatch:
> 
> "Avoid using bool structure members because of possible alignment issues"
> 

This checkpatch warning was removed almost 4 years ago.

regards,
dan carpenter
