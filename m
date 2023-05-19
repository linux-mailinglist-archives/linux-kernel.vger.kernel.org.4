Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB8708EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 06:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjESEQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 00:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjESEQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 00:16:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7C10F3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:16:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30636edb493so224044f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684469779; x=1687061779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOiBfpLle6Gi5Vqn7d5zcbeqcAGVB/cx7aZwFnLEQjE=;
        b=M4LfsQRfZLH8eZr583rnEXDxZ1YR2akpiiNlcESNINRmRUVnIKwJ1EXPb/QYYNn/If
         8VXV5eCwWFZzcstNvnO4lcW7ZPl5koeph7YJvTU7Js2Ya6XlpojAJe+YXq7Dq6QgLuGh
         reVgrz+2T1GljEAeuTWCsthUWBz/QZl9g/WGYIF/gVs7OLXegfWnBPVb8WHu3XOsWeGU
         Fq2LMnom73QdwcH0zA5IQNufz/NAxYkmqGYeZlHLGLjvYO2jI4N8daCwFqld8wAFTB3r
         oMNGUtbTP9oTppZJvvlBj1RkfNbe5IxHrcBiBbYkEX0lEAfEsnU6+iReQZ4wIR28/abZ
         1T/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469779; x=1687061779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOiBfpLle6Gi5Vqn7d5zcbeqcAGVB/cx7aZwFnLEQjE=;
        b=jAtxBx4w9MVGph+nURvJM7oeU7MtAsuqQoVmTMPlbHz5u8irzuE8Y1NwxuzmfdPABO
         nCfDVKEf07i3dfe0Fz/i0+RFQrz5NEJ6ECoVb6MeI63zLyBT3pfoQz0nWxWxmvZdGJ4S
         zc6+erQiP5fDxzXBUhcF46OIYLNpVHH+GBo2sxBwk1q9fpkj9uOus7Iom8hXnqoupaKv
         QSf0JkwFqqlzfQysJUsB4tk5Th96kSBuN9rrgUietR/LOeD+OwWXJoFq/PyGXrDFxhtm
         CyNgMizqFzdgtuiLqXr9xO8BgvyhHXFfVp5H6Zvob88zINwv4Wg7Kh034ZdwVZA5nIWf
         jSbQ==
X-Gm-Message-State: AC+VfDybxEJq+NKgBklzVsqAsZrqqLkWBfM7rJBFYJvzRiBm6TDl3xfQ
        FDCl9GhFpuDO1WR7UShtjQvSeg==
X-Google-Smtp-Source: ACHHUZ6lvEClvnoZ6W7RJTr48PMCFljHZrwfZW3qRwcdTtyy43WymSlg+dChSeNU8i3tIs2Ew+mchA==
X-Received: by 2002:a5d:534d:0:b0:304:7bbf:7c1e with SMTP id t13-20020a5d534d000000b003047bbf7c1emr2822166wrv.4.1684469779096;
        Thu, 18 May 2023 21:16:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4ec2000000b0030647d1f34bsm3967241wrv.1.2023.05.18.21.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:16:17 -0700 (PDT)
Date:   Fri, 19 May 2023 07:16:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <28c6814d-1863-41fa-a471-35a3ccf4447c@kili.mountain>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
 <ZGbiwqMxnFFvS7y8@dev-linux.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGbiwqMxnFFvS7y8@dev-linux.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 07:45:22PM -0700, Sukrut Bellary wrote:
> > > 
> > > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > > Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> > > ---
> >   ^^^
> > Put testing caveats here instead, where it will be removed from the
> > git log.
> >
> 
> Shall I add "This is based on static analysis only. Compilation tested"
> here 
> or 
> is it not required to mention this for all the fixes?
> Can you please recommend what's is the preferred method I need to follow?

You can't go wrong with always adding it.  The untested part is useful
to know.  Also it's good to know how a bug is found so we can say if
it's affecting user and so we can improve our processes going forward.

regards,
dan carpenter

