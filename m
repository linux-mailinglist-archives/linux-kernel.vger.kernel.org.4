Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6AE742C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjF2S7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjF2S7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:59:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C430FCA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:59:10 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbaed1ac99so10550375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688065149; x=1690657149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/FlO6Jg75h7o7gINpngRzGw5kuFzFb/sRPAmynbpWL4=;
        b=WNa2WqtwhDEFGZyeP3X1GuyXVe6QeR2n2jhIdc8gOr1KXIKZ09eD1yTtWDdh1ttCv+
         s5BT2021wqRbiDHRIBJwWy80hewSh4Qo9PcZhnMN5A3PFOzrgy4vfRGjNmwvVreROl5E
         tdxHLgjPd0A+hWD59C93r6O9SSU1K/IVTxdwZxwLv/2k7ZMxhKdUeb3+XF3kEMBanxd/
         cN/jDDcfItExCzIAAe5ledowEqjq5jzrgMoDbqs+6pCfabTuySDQDdro6yOq332RV4MF
         eS40zefM0IEKgWq20lJSBDfq3AU3738aGtzH6cvCBq8UR4Om+SbolC9gbKaqijN5x6d1
         TT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065149; x=1690657149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FlO6Jg75h7o7gINpngRzGw5kuFzFb/sRPAmynbpWL4=;
        b=i2iLYEGWZQhB5iyYKe6qnJjIzzJJC7Ip3lt07iXjBxL5o7CoDubpHMrjI3qWrh9SAt
         mshxeyNiZiVcVxIyFCVyUTpRZby+qIoxbLdzH3jJ3V83EPaPd4eMthFiVMNJOUW0tCzh
         mZzcDaNoItZUhrt1WTNXwcoYo4fMV3xGqdwSXa1pYKtQGs6dnHgaUJJr8qOO+8UFsckP
         KCQSU5dqQWN9SOM0niO1kezQ1PflOH7DhhV61DrFrDXDzM/ADoXTTHIHFlIx2CDZkXnx
         wuTKfc6II2szXsfNpSO9+PR/j+jQbLCYKU09mzR5csEXWCaOI15TNVgm96JmUVtbSr/U
         ZH3g==
X-Gm-Message-State: AC+VfDxFmgKMg4RhnkuGoQxoOIfi4op6SRPbz6xiceKLktkcy379u/nR
        WG0XlZ6NWrFGItqzFHavpN0zXw==
X-Google-Smtp-Source: ACHHUZ4XSSjq9/3ccSAd+4dK8gj9M+sps2SRU6Al/tfzcEUz4yRg1TX76PohGxqk7bXWla/9EpCt0Q==
X-Received: by 2002:a7b:cc15:0:b0:3fa:77ed:9894 with SMTP id f21-20020a7bcc15000000b003fa77ed9894mr236281wmh.7.1688065149269;
        Thu, 29 Jun 2023 11:59:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s25-20020a7bc399000000b003fa96fe2bebsm12106523wmj.41.2023.06.29.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:59:07 -0700 (PDT)
Date:   Thu, 29 Jun 2023 21:59:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, lakshmiy@us.ibm.com
Subject: Re: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs
 attribute
Message-ID: <45a29025-4c06-4f88-b82f-a8002c25c376@kadam.mountain>
References: <20230627184027.16343-1-eajames@linux.ibm.com>
 <b12935a2-a8b7-4d70-8c7d-6fd1e92037c2@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12935a2-a8b7-4d70-8c7d-6fd1e92037c2@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:53:16AM +0300, Dan Carpenter wrote:
> d2c6444389b625 Eddie James 2023-06-27  22  	char out[8];
> d2c6444389b625 Eddie James 2023-06-27  23  	int rc;
> d2c6444389b625 Eddie James 2023-06-27  24  	int i;
> d2c6444389b625 Eddie James 2023-06-27  25  
> d2c6444389b625 Eddie James 2023-06-27  26  	rc = pmbus_lock_interruptible(client);
> d2c6444389b625 Eddie James 2023-06-27  27  	if (rc)
> d2c6444389b625 Eddie James 2023-06-27  28  		return rc;
> d2c6444389b625 Eddie James 2023-06-27  29  
> d2c6444389b625 Eddie James 2023-06-27  30  	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
> d2c6444389b625 Eddie James 2023-06-27  31  	pmbus_unlock(client);
> d2c6444389b625 Eddie James 2023-06-27  32  	if (rc < 0)
> d2c6444389b625 Eddie James 2023-06-27  33  		return rc;
> d2c6444389b625 Eddie James 2023-06-27  34  
> d2c6444389b625 Eddie James 2023-06-27  35  	for (i = 0; i < rc && i < 3; ++i)
> d2c6444389b625 Eddie James 2023-06-27 @36  		snprintf(&out[i * 2], 3, "%02X", data[i]);
> 
> If data[i] is negative this will print FFFFFFF1 etc.  (This is an x86
> config...  Did we ever merge that patch to make char signed by default?)

I meant unsigned not signed.  But actually we debated both ways...
Signed by default would annoy PowerPC devs since they try to really
lean into the fact that char is unsigned on that arch.  :P

https://lwn.net/Articles/911914/

regards,
dan carpenter

