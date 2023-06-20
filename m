Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF0736315
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFTFSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFTFSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:18:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ABB10D5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:18:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b45c289615so53892101fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687238288; x=1689830288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y7PuqpyqHE/HUVu8CRaW9WlThpzPBfO6+875ZQx+jnA=;
        b=euZ3NbqF9mB24d0ScudIoCLcjGflfbklhPemkj/vHLxufMsWRiAGBP9qLHpeL7+ibl
         KRmAsBeL396AbnFIajAYSoVRQP1OSDV73iXpEuEqKjWbJuW1jnhGCNpaD4i0QrN0y4SC
         YYqtSkae846yMDjV3BaQJTSXpLLQqClqPJQylp5sQ9hbnOQKXk86ODhLiNMZFzXOUmqw
         spw6fYU/7QuiB7LtKQuSToUkUX4PVOZ7HQi9Sg3oPqRwUMlyvKkWTohnsVrmuBqhDdjp
         MORXtKz1IOxy2hQ2xYKKGz6TA5JWo/svqiWxln2fXV1LiYLgXbWOUwRQFaBoRWj+xMHI
         ESxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687238288; x=1689830288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7PuqpyqHE/HUVu8CRaW9WlThpzPBfO6+875ZQx+jnA=;
        b=BTIh4Qa8Lf48uUUTrVCTmsBihp7SSTw5CO5DH7dOZvcALvPpLSPidIgyRBIwf/KTLQ
         Zzjat/SWnTWJl2sA5Z1PKzmdiYCppA0v1y/zz9YKHtY8RE6av3lICa7PQUo8PYfQ9QVW
         t3HLS/Wa7NyqUivuJLHapSut0YGjDVliVuOHTkSGXeUDV/wGEHwrOGDMY8wzI6QVJxu4
         9Nzeh89mOb2zr8KupLuZPGm1iFwg8FO6Vm+tSceSsVc0TX1UKvNLszh4EwRqMHtFVnGM
         h67FiWUHDzCvOq4UCf8/9Uhrtr5Cwr3mgeuDSczuXPmmM2Ah/QW3A+DLDkGRQjgiQTgE
         txjw==
X-Gm-Message-State: AC+VfDxFKRs9v8Z7hWeW3xx1UhxoP/IqCoYGUZqf8ya+Q7w8HHeROmTe
        aGOF4JrRpX0+LlhuIpOiaUZXC+jm0R6HrvfZOwU=
X-Google-Smtp-Source: ACHHUZ5ccBcWPxcFeRk9KZTmk2iY37jAco/koAiv37L1FuAnmeROZMwkEffaczENJYwJooQ+gl1ReA==
X-Received: by 2002:a2e:95c4:0:b0:2b4:6a20:f12d with SMTP id y4-20020a2e95c4000000b002b46a20f12dmr4718664ljh.43.1687238288311;
        Mon, 19 Jun 2023 22:18:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c220800b003f9b12b1598sm4395724wml.22.2023.06.19.22.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 22:18:05 -0700 (PDT)
Date:   Tue, 20 Jun 2023 08:18:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: Re: [PATCH v6 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <e118d13a-d36e-4417-9fe5-68d46472c09a@kadam.mountain>
References: <ZI/5H+GZU6/2osGT@redkillpc>
 <20230619162246.33007-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619162246.33007-1-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:52:44PM +0530, Prathu Baronia wrote:
> In various places, string buffers of a fixed size are allocated, and
> filled using snprintf() with the same fixed size, which is error-prone.
> 
> Replace this by calling devm_kasprintf() instead, which always uses the
> appropriate size.
> 
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
> V5 -> V6: Split into api change and name change commits
> V4 -> V5: Remove the dev_info() and use a unique identifier for dev name
> V3 -> V4: Split into warning fixing and cleanup commits
> V2 -> V3: Fix smatch warnings from kernel test robot
> V1 -> V2: Split into logical commits and fix commit message
> 

> -	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
                                      ^^^

> +	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%p", DRIVER_NAME, &r_mem->start);
                                                          ^^

This is a sneaky fix which Greg already kind of complained about if I
remember correctly...

regards,
dan carpenter

