Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6837263AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbjFGPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjFGPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:07:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35F11734
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:07:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso36413705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686150447; x=1688742447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KH8Z1a3lx04BjjGgQh8aDWIlPdF1CYV0Q+kaQr1wwYU=;
        b=RPz/yVLPBvrSoUXI4bmqeFypmd4VQR+o8OHdrINgHbgrp/k7jrVOrjde4qcvKLsL1F
         OmpuDXucztTOMvaaI5Ro0E9arPla6VDp6H35i6sES8gBoQTqfL6qwgi1rWJKN9GMwKKE
         4zMW5JG+653chqLbFD3Kj0JVzDRRVILqLlufxrwKmcykTVfpZxy7CmlQBuaeocIjTdZq
         pwpJ5iDwxsh7FyZuqgiSDfD+NaLJmjLosA6KD5e5nyJ8fR3M86x15HPVZhjQFA6xrVeX
         SNW2mrUz+4WK3FE6hNiS1cfuCvTODSDBuTjrhvs3KdCW7/3pLCOucs8YQ7d8hxcJYlG3
         08ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150447; x=1688742447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH8Z1a3lx04BjjGgQh8aDWIlPdF1CYV0Q+kaQr1wwYU=;
        b=h38W4EkEYh5+5VdPMiE0XZVBLYVqpIr+bzNEUln8e3otIXgoFVUyox6rjxhB//48JU
         ZFMHSpLfuqq8WWMmJLgA/C75w4HEVShsqm4fl5YPHJ3IsLjBxRiNqnsdcMbmWMflvTsP
         9zu6shPys0TJIvYq5IISVdTHb5Xn0SVq4lLZPNLqIY2TznWkzJGUCTangvdlnte5pYSW
         PmbCyiuEZ+kNX1PBoaEr1LaLPhpFUNwEQ/piZ5JX9PC0euSlsaV/N/9sz4cwFnMcc0go
         WhGQsXeGL/BJ7Udwu0cg6vuqH/0zgi9QxJIXwKftp0YLXgLUxFy5w23FztiIRXCp1lBi
         ksDQ==
X-Gm-Message-State: AC+VfDwUVHXFWfQxfF8Kp9aW0w/PlwAov2BJis8iXxzngsdFjk/I+ocn
        UEOXSOPZ8aRQd9vJ16VNB3T/v600YiCCKjUFr9Y=
X-Google-Smtp-Source: ACHHUZ6KhqbmwhFvTf1Jv9nGQY+WC2ITFQzkw+o7B+v+PixosEq1f3BOeT1qq/1BEiYg+pf7QJ0Ysw==
X-Received: by 2002:a05:600c:2150:b0:3f6:58ad:ed85 with SMTP id v16-20020a05600c215000b003f658aded85mr4808156wml.10.1686150447182;
        Wed, 07 Jun 2023 08:07:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v4-20020a7bcb44000000b003f7e4d143cfsm2446750wmj.15.2023.06.07.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:07:25 -0700 (PDT)
Date:   Wed, 7 Jun 2023 18:07:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] staging: rtl8192e: Remove variable SetWirelessMode
Message-ID: <01a162c5-f0de-47b1-97e7-8a451a89df80@kadam.mountain>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
 <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba56522e419351b05e33df8cd0ac31806534d8c.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:31:41PM +0530, Yogesh Hegde wrote:
> The variable SetWirelessMode is set in only one place throughout the
> driver. This patch removes the variable and calls the real function
> directly instead, eliminating the unnecessary indirection.
> Additionally, the removal of the variable aligns with the checkpatch
> guidelines by removing the use of CamelCase.
> 
> Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> ---
> 
> v2: Removed the variable and called the function direction instead of
>     just renaming the variable as suggested by Greg Kroah-Hartman
>     <gregkh@linuxfoundation.org>.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

