Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A776C6291
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCWJCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCWJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:02:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619BE19F12;
        Thu, 23 Mar 2023 02:01:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id br6so26760787lfb.11;
        Thu, 23 Mar 2023 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679562117;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeKpxRkxGHsen3R9CE60PmIdGzFJliSRTZ2LQ26QvEE=;
        b=Gg/R8XFM+7F7/j/PgljzMAp5BU8Xj20rWae2+5+eKcWsu28YVvHre0+6NjRkMUj0mZ
         /7f8kSz0lyuxuVizN+q6CxpKFK3Fw8ikwqEsiYSfJPADbqQFXMcKDFwebAeGz+zNDazx
         kT4y10HIj0r38eeWK2t5sS13fXMYM73eJsr/SURX6dem98P7msMcANOoGvuE/3hYA20u
         yFg5xttuI+OFt8yMfnCZr36Wk7kexZIC1aiwxEt0Fye5tsrgCQvTHgm9+0ToHcJFYZDz
         tJ+EKzYGVQtLnoLRUZR4oHRrDRS4Tjnpy80mhpTe62jsLBzN6Sfbrwhe/lbZeHZc0Npp
         NnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562117;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeKpxRkxGHsen3R9CE60PmIdGzFJliSRTZ2LQ26QvEE=;
        b=G3JrpNOPcd0chbcLSMIsIDA5eXDDxKTQMWSrhXSScvcggH41P+fhBsRtFfzjTO8PJr
         Si9ZoU+1U4YvlBrD6ES8zw9EXTfGh6jTXKFcfQThUCJmHDV9CC3wDYTjyNdiTx5NJpm3
         i+ztYQTJHBhLHBJKnQ5X7CxJbBlTwxN6q4betagfyV+62GkzsSx2o0BbfYzahNysiHHk
         zQaWKTw+lM781JPWfwwlkW/QBpMFQdU6DUrDrBtF2IkxUsIfXtRjJWJphegOmKux40OW
         h/LqX8nHZ2UZ1sMR0K6G92aj0QbdPT+oqwxkTR/zNDxWwWHgvrXIANqANQ1Cjzv7l1gp
         H2Pg==
X-Gm-Message-State: AO0yUKV3ab58nNzsaEyAu0Z4OjjiSU0zfUAp0TUFlPObpjr25ugNsqiC
        4Vgx3zG1Q6CU3JvgxW4gQQwiRm3fT8A=
X-Google-Smtp-Source: AKy350YkkEBi8AWyazctY5qpjTSz2ybeVQzPbXNM4hgPnAqNRKUOQdrSyQfxgEI7gCjoY/nOV3g9pA==
X-Received: by 2002:a05:6512:218d:b0:4ea:f6f2:7a7f with SMTP id b13-20020a056512218d00b004eaf6f27a7fmr1654565lft.34.1679562117116;
        Thu, 23 Mar 2023 02:01:57 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.74.111])
        by smtp.gmail.com with ESMTPSA id r10-20020a056512102a00b004e7b84c6419sm2852967lfr.192.2023.03.23.02.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:01:56 -0700 (PDT)
Subject: Re: [PATCH] usb: dwc3: host: remove dead code in dwc3_host_get_irq()
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323054232.1135734-1-mx_xiang@hust.edu.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <75332169-0249-c53d-962d-c5f3641a7980@gmail.com>
Date:   Thu, 23 Mar 2023 12:01:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230323054232.1135734-1-mx_xiang@hust.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 8:42 AM, Mingxuan Xiang wrote:

> platform_get_irq() no longer returns 0, so there is no
> need to check whether the return value is 0.
> 
> Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
> ---
>  drivers/usb/dwc3/host.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f6f13e7f1ba1..aa19c27344e6 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -57,9 +57,6 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
>  		goto out;

   Shouldn't *goto* be dropped now?

>  	}
>  
> -	if (!irq)
> -		irq = -EINVAL;
> -
>  out:
>  	return irq;
>  }

MBR, Sergey
