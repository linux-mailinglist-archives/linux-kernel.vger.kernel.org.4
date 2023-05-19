Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF4B70A36E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjESXj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjESXjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:39:52 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B97A1B3;
        Fri, 19 May 2023 16:39:51 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so3530272a12.1;
        Fri, 19 May 2023 16:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684539591; x=1687131591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+/I1DakxPrd+okwwNtUEXRwJ7ucYEoX+rOCHphwT6I=;
        b=B4U12YwCYTeNLFHf+F6NnDTiONqlnERt6n4jt+H00j4OT/7WnLUBOFVSve7MZHPsAc
         ZaHn2Pu2wT8QFbrH2uXUG12KjsLeqfHtjkuGchc/B49nW3FsIdcvFKdDVoISs8vkPd2g
         39Hv+OQ0gqBbU/KMrTnHQjHV/mKMZBmcYrewkAF1tloXWajUi6AZvKYlYkuwDqx45v3q
         qQy01bhau/+1mLLUKrpOin/W8W7vai43rGMnUHAWxKx1m2TGKFje2BbylHP2a73klI9y
         pn9QwOQknSR+yGKYKSOs/mmNKcXcpIKRkbjvtZTb+JbhADCsWFrLLDqOIC02Qudc1YBa
         volw==
X-Gm-Message-State: AC+VfDzZEqG1MZAW5kj2oZe8W1WP/NaBi391i2HdbVV9vLwSMIOrpN7+
        1lw/0wesZPNfnSorOD1c8d5EnsrDZMIeSrVO
X-Google-Smtp-Source: ACHHUZ70tJtQIqEYhaAi+PGMl9f8G8LSCKi3EFC8z7gNKkwLrwkpzW/lG6RgAB29zE9TPARoQtOpMg==
X-Received: by 2002:a17:902:d4c6:b0:1a5:150f:8558 with SMTP id o6-20020a170902d4c600b001a5150f8558mr4038822plg.17.1684539590542;
        Fri, 19 May 2023 16:39:50 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001960706141fsm170742plg.149.2023.05.19.16.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 16:39:49 -0700 (PDT)
Date:   Fri, 19 May 2023 16:39:47 -0700
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <ZGgIw3rzigqI92BO@dev-linux.lan>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
 <f47b17c1-1c02-2aa3-ba10-fcef70cb25a8@linaro.org>
 <b0115d7d-d15a-4948-8726-09a8b37f3f36@kili.mountain>
 <fa0e9d9d-6362-456b-87f7-990ccf7e8930@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa0e9d9d-6362-456b-87f7-990ccf7e8930@kili.mountain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 01:58:10PM +0300, Dan Carpenter wrote:
> This is unrelated but I was looking through the driver and I notice
> a bunch of code doing:
> 
> grep 'return ret ?' drivers/firmware/ -R
> 
> 	return ret ? : res.result[0];
> 
> "ret" here is a kernel error code, and res.result[0] is a firmware
> error code.  Mixing error codes is a dangerous thing.  I was reviewing
> some of the callers and the firmware error code gets passed quite far
> back into the kernel to where we would only expect kernel error codes.
> 
> Presumably the firmware is returning positive error codes?  To be honest,
> I am just guessing.  It's better to convert custom error codes to kernel
> error codes as soon as possible.  I am just guessing.  Sukrut, do you
> think you could take a look?  If the callers do not differentiate
> between negative kernel error codes and positive custom error codes then
> probably just do:
> 
> 	if (res.result[0])
> 		ret = -EIO; // -EINVAL?
> 	return ret;
> 

Thanks, Dan, for sharing your findings.
Yes, sure, I will take a look.

Regards,
Sukrut Bellary

> Also there are a couple places which do:
> 
> 	return ret ? false : !!res.result[0];
> 
> Here true means success and false means failure.  So the !! converts
> a firmware error code to true when it should be false so that's a bug.
> Quadruple negatives are confusing...  It should be:
> 
> 	if (ret || res.result[0])
> 		return false;
> 	return true;
> 
> regards,
> dan carpenter
> 
