Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CE749777
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGFI2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGFI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:28:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCC9173F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:28:32 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso4035835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688632111; x=1691224111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xdgSXkLW8btnJKUBXJC+TeWedvbKjdiDMe6ulQpDuH8=;
        b=XJV62+zlp/K4ml2ErtWJOpPTQLWSjeHPy+ncWelv1YSfL5T/oIKfUBIJP08CVA7p0f
         r7oWZa+Avh1hlP60A664f+m9xe3EPXcEB6S3zOvHzHrfrcenPdxdlI9ilVktxxM/0dYh
         aRIpJfQkrPhDksSFjvjqeBeEK1J1M5rPZVBTaHNmOpkJtl8xaGAu1k36IrIp12fSxNLs
         7us8sHelvghMPDUzzH13PuKUmQNiH51PsypRSaKvhCmb6V6Q4jT9/drV2tmiGtNhjRMd
         hH5LASNt0xprVVOS5UwjsRlGOmprtUHF6tzzPraEK1kwX1As6zGEj1X0dZCkIdbjN5X5
         lUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688632111; x=1691224111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdgSXkLW8btnJKUBXJC+TeWedvbKjdiDMe6ulQpDuH8=;
        b=XJQrpo8uLDOqn3Nib2rv5rUrL3+AKJL1v35HM2EcZUr+6lxY+kKgTNyD1s3gbRvdHN
         swuC0UKNvKSRJLzccyTIgbTe2NqVtZA6GdgOYCkQDvBs9zvHd6MMhEdK71KCQ6LBn2jU
         hyhRgCy/uBSboBUFcqFdj1iR8yRBTkdXIvdwBKT0BaSk1ySYvg8Ntg/Q/eG/JXHWBP/C
         hyyALuz9OZZyaYySKW8wRCwyHe2FceSV8WpSSOb/NwTrytAeDbjw6RCBExzDgMFDmShy
         LJrN5LoAO5+qosHQsaWLWrXEM7WeFDxGEDMkvkwXwQUey4+dtqOJeyV1bhNAhrWjM3sJ
         jzbg==
X-Gm-Message-State: ABy/qLZOwBCZP10YGLJn/BbZjrxDkr8whIfKhl/TTmVBoqTdTwQlSbVh
        E6IWgxPbg1h7FMeAX4SCYp4AR2gUynOt7F4etmA=
X-Google-Smtp-Source: APBJJlEZb3nPZqefx4c1NG+fq3u2P2HPtqyiUlSmHOa8fdh5zvO02GNVGBScZyFzHbbD4oZYR7Si+Q==
X-Received: by 2002:adf:fd47:0:b0:314:268b:21f1 with SMTP id h7-20020adffd47000000b00314268b21f1mr899410wrs.18.1688632111297;
        Thu, 06 Jul 2023 01:28:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d4ed0000000b0031411e46af3sm1188648wrv.97.2023.07.06.01.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:28:29 -0700 (PDT)
Date:   Thu, 6 Jul 2023 11:28:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wang Ming <machel@vivo.com>, kernel-janitors@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>, opensource.kernel@vivo.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in
 svc_create_memory_pool()
Message-ID: <083cfb82-84cd-417d-b5ac-2b831b24710e@kadam.mountain>
References: <20230704082706.1721-1-machel@vivo.com>
 <fe780326-2150-a3e6-e451-ea82be65e0cf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe780326-2150-a3e6-e451-ea82be65e0cf@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 08:21:02PM +0200, Markus Elfring wrote:
> Please apply a more appropriate patch subject.
> 

Markus, a number of people have asked you to stop with this nonsense.

> 
> > The devm_memremap() function returns error pointers.
> > It never returns NULL. Fix the check.
> 
> Would the following wording be helpful?
> 
> 
>   Replace a null pointer check by an error pointer check after a call
>   of the function “devm_memremap” in this function implementation.

No.  The original was fine.  The original commit message is more clear
than your proposed commit message.

regards,
dan carpenter

