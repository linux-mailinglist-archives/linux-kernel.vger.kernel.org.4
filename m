Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F16EC257
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDWU5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 16:57:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3063B1AB;
        Sun, 23 Apr 2023 13:57:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9505214c47fso674038766b.1;
        Sun, 23 Apr 2023 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682283420; x=1684875420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eU1Tk/gnXrnHdm84vw9TLyvNW9CFqnp1t/CWjp9JRhA=;
        b=S0am4xMmSjK8nfNHQPjGBaesjmnvMyXntZB/bvW3dK82NNjT9tYgsNWiDVA1sdYdzv
         js5tmbQz3O6QZyxcgwyuDb1QzZ8fjBcFHxDMhkGtKJv0CYeMmZvqzHFfa83qWDrQmgX7
         ZdYyoTSRk/FE04DJ3yuZzXIQYYAhwmpMpD2WAkyc2hv9/pJaxVk+Wk7FnmnImwiYTEp5
         rllaOUCBk2nsT0lcfagBN//TxWfudqKDpOoOJCSuhxoM+xH+JQA1710fwYttY/+vwU61
         1QVXdPkI3ofYzrJHD93JkT8V0A6GIdwghe4ghT79rtNExmo8NIbI3y6atw/WQyNnKT6S
         iiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682283420; x=1684875420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eU1Tk/gnXrnHdm84vw9TLyvNW9CFqnp1t/CWjp9JRhA=;
        b=heeZXL9KD8t5sjHUQ9wiLigN1Hz/Yi0ZeJZt5NqtHrUK24D9asnzJp56J0l8ci3RZH
         7wPXLjT4Wrfg37L1aei1U6xn6LzxLPFzFIyXejCFqKLC12lr1OX3U0wDO/1O8eE+rWQo
         XZfKVGYORs+Jrklrd7Q1bik8bBn9I31vFI4PT8XMWUD/bd+GiGda8TmcC+/3pIL0Uvgj
         gCqpKLSFJY3CJS9M4eQ+sj/c0bjIk0Ai3gkAWHZSAj0G5Oic+XNN3r8lGMlw+meHnTqx
         HHkAp4R/GFuPjkRJlB7ChApKuS7qJJBAYvZTBrGoMKxO4xVHtNMn4tUMkM0iXIBaN2ZM
         xB0A==
X-Gm-Message-State: AAQBX9ccIGW+/bV1T5GgaYfLhMv31+3sEfrY0ZheeTlr4fBkwIxv4zwv
        OwV9lMd2xmsr5O0+LenVfkw=
X-Google-Smtp-Source: AKy350bItPTLFl3p6XwDCCEpUteu9ipM6f51Y+fgIxwoiIQ4L4WHxEbZEUOd4IH/lzG7VvEgfV/5Qw==
X-Received: by 2002:a17:906:4a8b:b0:94f:7d45:4312 with SMTP id x11-20020a1709064a8b00b0094f7d454312mr7253697eju.29.1682283420445;
        Sun, 23 Apr 2023 13:57:00 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b009572db67bf2sm3208007ejc.89.2023.04.23.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 13:56:59 -0700 (PDT)
Date:   Sun, 23 Apr 2023 22:56:57 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, jic23@kernel.org,
        mazziesaccount@gmail.com, oe-kbuild-all@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZEWbmSuJqWJWf0aD@carbian>
References: <cef09595632a40eff8a0864fea2e0eb6653930a5.1682019544.git.mehdi.djait.k@gmail.com>
 <202304220729.FCofPRvH-lkp@intel.com>
 <ZEQGqFLIyxm5XENQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEQGqFLIyxm5XENQ@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

thank you for the review.

On Sat, Apr 22, 2023 at 07:09:12PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 22, 2023 at 07:19:44AM +0800, kernel test robot wrote:
> > Hi Mehdi,
> > 
> > kernel test robot noticed the following build warnings:
> 
> I believe it's not just a warning, it's a full functional error in the code.
> 
> >    686	{
> >    687		struct device *dev = regmap_get_device(data->regmap);
> >    688		__le16 buf_status;
> >    689		int ret, fifo_bytes;
> >    690	
> >    691		ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> >    692				       &buf_status, sizeof(buf_status));
> >    693		if (ret) {
> >    694			dev_err(dev, "Error reading buffer status\n");
> >    695			return ret;
> >    696		}
> >    697	
> >  > 698		buf_status &= data->chip_info->buf_smp_lvl_mask;
> >    699		fifo_bytes = le16_to_cpu(buf_status);
> 
> You need to mask in the same endianess space, i.o.w. either on CPU or device side.
> 
> I believe you wanted to have fifo_bytes to be masked, but I'm not sure.

I wanted to read the registers buf_status_1 and buf_status_2 --> 16 bits
and mask the result of the read to get the bits 0..9 which is the
buf_status: the number of bytes in the buffer

This is due to my lack of experience, but I have a question:
If I don't get any warnings when testing, how should I go about this ? I
will obviously fix this, but this is for the future.

--
Kind Regards
Mehdi Djait
