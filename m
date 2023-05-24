Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADD70EF41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbjEXHUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEXHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:20:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DCF8F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:20:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-309550d4f73so258546f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684912844; x=1687504844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o1HIpOF3eeuHdCfM/1tBPhYiXaOiOf07PpD3Af3S0JE=;
        b=T6+R7I2wunS7lt7fOfWOXSEWlS1Fi/PD3heV7tV4tRaNcQnXiq9D0XU6O+EG6quyQs
         UX+cNeE5h+JwFObIxlw+hWAbcx4zU/y9YW6cQNwdmjz3Gs1x7mK8NdJIypmaaYAqhrdN
         RQWM6t80dBEkd7F/mvF61jBsvu/KttCMzOVFcdSfvPRUJtWrN34ayxNLW/JLltea2t0m
         293yUIZeliiz99pzwVNtsc5fcm9B1k4AF1zJlfCJ2+VCb2kpN038fA6NvtVcFQqAVKQT
         wxsdC7YgLW3riunUHKRN1WD/d50B3HnHMiEpiynO6pgBnwichNWNdmmkNoDZVh9S1PQ9
         g/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684912844; x=1687504844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1HIpOF3eeuHdCfM/1tBPhYiXaOiOf07PpD3Af3S0JE=;
        b=bCpvYQTLK46YEz4nwFlcq70bONMUoW0r0oCE0HL+f0HVYJ8J1wQjkktLRKHdYf0y5d
         KyZkHbdshyc/fgG+AzDz85VanU4vxd64H3Wv3DVlQL/Hg5aMtx9OYMbA888EGetsy+h9
         tgoP/1rAOpWHQXwu6vCyQf7uv7ZjfbBrRyU7NRvYSC5JgTeuunTB9N18wevzOzGp8ayU
         MyicvdKHPxmmBHRFQ9M4tqdtPQo2BTPJqU5M/DCXpmYIeceyLtfx4wFurvSCrtnhgwim
         +aYXC3+ftoZwuOXnbV1AeAxWmHTdjXrCgz9tKGRlqkfLhI4NA6rVHt6k1mR5ET4wDZ6p
         NAKw==
X-Gm-Message-State: AC+VfDzxefqBEL71WPOsBb9AAfzB2eb+NlvRTbP3F+nw7Ak6kzwUXuhs
        bg2UeFV5VEB+V4u/niZe9sdYtA==
X-Google-Smtp-Source: ACHHUZ4OlZB3R72tJJh78in+0Xfto5vaL136BybJtcnJIsPbR9nZTqNsC0tYfXHmQyV4M2Lr7ZdEGA==
X-Received: by 2002:adf:ea0b:0:b0:309:4642:8795 with SMTP id q11-20020adfea0b000000b0030946428795mr16910312wrm.12.1684912844070;
        Wed, 24 May 2023 00:20:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d4b48000000b0030771c6e443sm13470769wrs.42.2023.05.24.00.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 00:20:42 -0700 (PDT)
Date:   Wed, 24 May 2023 10:20:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        YongSu Yoo <yongsuyoo0215@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: dvb_ringbuffer: Return -EFAULT if copy fails
Message-ID: <7466fead-1b99-4a78-86cb-5dd8a9baec19@kili.mountain>
References: <41a9c6a6-4b9a-4d84-9e32-09bf64c65b6c@kili.mountain>
 <aab14cc4-0400-c114-f180-6db943fd7e32@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aab14cc4-0400-c114-f180-6db943fd7e32@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 01:20:27PM +0800, Su Hui wrote:
> It's confusing about the comment on function declaration.
> 
>     /**
>      * dvb_ringbuffer_write_user - Writes a buffer received via a user
> pointer
> 
>     ..........
> 
>      * Return: number of bytes transferred or -EFAULT
> 
> But the function Only returns  the number of bytes transferred.
> 
> Maybe the comment should be modified because it never returns -EFAULT.

To be honest, I think that -EFAULT is probably a better return.  But
there is no way we could apply the patch with that commit message.  The
commit message doesn't explain the problem for the user or why returning
the number of bytes copied is not correct in this case.

I think that maybe it's not too late to change this to return -EFAULT,
but it would have been easier to make the change in 2014 before there
were many users.  Also it would be easier if you were testing this on
real hardware.

Possibly other people think the current behavior is correct or that it
is too late to change it.  That's also fine.  I'm not a domain expert
here.

regards,
dan carpenter

