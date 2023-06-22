Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0273A252
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFVN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjFVN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:56:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58DA1BFC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:56:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-311167ba376so7218424f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687442195; x=1690034195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEW2WXBte3jN1fLJ211gvIuJSeoOteLGjUnX78P98k4=;
        b=rrCXA0HYW+NRaxuK0LzkBkWHaS32roNXnVTcSlzHkz0PKFiRzi6Lf0a2kxT5sw4sbW
         jjMVv3gbRGX7y73/rTeAxgcyKJRaEjx8hgeXVmr1KOVjDxufD90egWATGqaHhCdg5lyL
         CCWBPoNFR/6czRV2XsuleAFb6zUW8evSN0nKHKSOPM/86ngFyJnI//xhzazH6g+ufdey
         iAvpeJ61KZ0V6PMuriG406hq6r4Jp2DjThmRQnPoG+2mD5V8pIHj1OSfFc1yhmt6x4Iw
         hJJY0N9IrNvCEy31Uv4j6O7vgmIRqgPp5toYxfIEQfRxNvrKDPf6N2IWfmuS9pLtFoy0
         IMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442195; x=1690034195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEW2WXBte3jN1fLJ211gvIuJSeoOteLGjUnX78P98k4=;
        b=Ub0jIric64AB1Og6C9GIVErC5/ET/wZVVFYjf4JQVvjncj0pZotKEKGmg/vHYrYadP
         T/CjaEdzMEDZWDlpLEF9pufz+4p/LTXEu3RZEIWBgYQiB3DoiViPe/7vW2BONF+iB5Pa
         gP7CO9atGxg+i5ahwe8osNbxvPSBdpLQoxFrzQNtDLIurOPQXmlWTurICseqaY+IClBL
         /r+N3sFM2pRIrxpbKvpKJXo0MZXIjTfaX42cOAtnSiy+3vMFId3jq+xS5ooyQkkqSZHz
         AaNx2ktYOwI4N81Jtzk/lDRP7q9+sKVZO9C+aq5sxj0BE4gm+3g6++sXy2gu/ANBkr+d
         Qjmw==
X-Gm-Message-State: AC+VfDwn/ywAs4l/3wmbaDh0Dd8Ph3lq1XHBUf5e0WgTLBe6HhiGdeLv
        C8Xqxc1cuW/+S0caO2ApS6Xbfg==
X-Google-Smtp-Source: ACHHUZ6a6EZPyQbiw2QFhMNDMLiHUFcNZTWVMQXmY1brW9zlZbdXXamxNjQ4bnHgoRKMXiHVkCeg6Q==
X-Received: by 2002:adf:ec45:0:b0:30f:af06:7320 with SMTP id w5-20020adfec45000000b0030faf067320mr1923670wrn.23.1687442195120;
        Thu, 22 Jun 2023 06:56:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s3-20020a7bc383000000b003f6132f95e6sm18924956wmj.35.2023.06.22.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:56:33 -0700 (PDT)
Date:   Thu, 22 Jun 2023 16:56:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v3 03/11] media: videobuf2: Remove VB2_MAX_FRAME limit on
 buffer storage
Message-ID: <1d9fea5b-5c74-4fc2-9287-71cd68adbda1@kadam.mountain>
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622131349.144160-4-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 03:13:41PM +0200, Benjamin Gaignard wrote:
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index f1ff7af34a9f..86e1e926fa45 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -455,9 +455,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  	struct vb2_buffer *vb;
>  	int ret;
>  
> -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
> +	/* Ensure that q->num_buffers + num_buffers is UINT_MAX */
>  	num_buffers = min_t(unsigned int, num_buffers,
> -			    VB2_MAX_FRAME - q->num_buffers);
> +			    UINT_MAX - q->num_buffers);

The UINT_MAX limit adds a level of danger.  It would be safer to do what
the vfs layer does for MAX_RW_COUNT and use "INT_MAX - PAGE_SIZE".  That
way you can take size + sizeof() and it's only very rarely going to turn
negative.  Or at least just INT_MAX.  I would keep the VB2_MAX_FRAME and
define it as:

#define VB2_MAX_FRAME (INT_MAX & PAGE_MASK)  /* The mask prevents 85% of integer overflows */

>  
>  	for (buffer = 0; buffer < num_buffers; ++buffer) {
>  		/* Allocate vb2 buffer structures */
> @@ -858,9 +858,9 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	/*
>  	 * Make sure the requested values and current defaults are sane.
>  	 */
> -	WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
> +	WARN_ON(q->min_buffers_needed > UINT_MAX);

This will trigger a static checker warning because the condition is
impossible.

regards,
dan carpenter

