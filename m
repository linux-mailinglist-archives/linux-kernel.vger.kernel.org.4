Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169BC62E067
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiKQPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiKQPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:55:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102B769D8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668700494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRgEstsiaza00mxfx8Zw8rQJ2a50YhYzkAACPA1ZNfM=;
        b=SsXXiZrFbAr+sV+LsUEbjO3naCtwXu72k36KDJjmmc9Z9X1Iu++t6QiILP0Fji2RBzcf0g
        4cKMbQ/8tYhEcz9o8nec8LV4uHKYIIJ+HAnjO2jaXj2DuAjTC5ifnSFlMvTUpV9ijntoEd
        DCRv9IgunE4nPAAzRgi8npmQ6dSGa4A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-TRjPvw3SPm6DDzBxJSU-rw-1; Thu, 17 Nov 2022 10:54:52 -0500
X-MC-Unique: TRjPvw3SPm6DDzBxJSU-rw-1
Received: by mail-qk1-f199.google.com with SMTP id de43-20020a05620a372b00b006fae7e5117fso2571214qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRgEstsiaza00mxfx8Zw8rQJ2a50YhYzkAACPA1ZNfM=;
        b=If1qjHiBgdY6QZieHZ3pgwH+1QMZrgwuTusC5l3NjVqCAy2zBfhKYoR+fsE6R9QAH8
         dKZrU6Snk0krOztXcINOJQCQ06qZRkB+gXgR9K9pISziFegyWbogxTx9MPydT9Nh9gL/
         pht8XdpfEAopUMIvX9HVCmCi16Hj0t12hM3GiB5SYS3fcfP7NxJlRGawgsX04wJEnLMN
         M1g4Imf0qI5lC1fWbmtpTZIBq1zio4cnAg22owxWvl+ysXxLb09Wj7rXyw2oe49Qs0XJ
         AjrFlpst7ZVOX6E3uRrtsNWjbSXFaYE9QmdBYUQ64xITDidIivgxyasTvRew7LwDYeLn
         sZlA==
X-Gm-Message-State: ANoB5plv6YEhGLD7XbpSLRaI3deu6P/QPJhfg+x1pNaQcqDUylyd2uAN
        0wthsdgDG3QuK1FDlHoXGlBWVaN+YPkia9XIBDa69/sVZ4J32AlrFbcT1T0rfigVIrmrmEEMGr8
        W+h9VSam/623izO58g9DfS0PC
X-Received: by 2002:ac8:5299:0:b0:3a5:3623:17b2 with SMTP id s25-20020ac85299000000b003a5362317b2mr2724076qtn.543.1668700492289;
        Thu, 17 Nov 2022 07:54:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4xz3uBUV6IVgVCKdytOyvXVviItTtAVxx7J+xEH7uoA8FGlQTKyqHopJRsvmbveNc+qoxBpg==
X-Received: by 2002:ac8:5299:0:b0:3a5:3623:17b2 with SMTP id s25-20020ac85299000000b003a5362317b2mr2724056qtn.543.1668700492084;
        Thu, 17 Nov 2022 07:54:52 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85642000000b003a5612c3f28sm548302qtt.56.2022.11.17.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:54:51 -0800 (PST)
Date:   Thu, 17 Nov 2022 10:54:51 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v1 1/1] gpiolib: Unify access to the device properties
Message-ID: <Y3ZZS+/QKXtRKH9B@x1>
References: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 04:17:28PM +0200, Andy Shevchenko wrote:
> Some of the functions are using struct fwnode_handle, some struct device
> pointer. In the GPIO library the firmware node of the GPIO device is the
> same as GPIO node of the GPIO chip. Due to this fact we may use former
> to access properties everywhere in the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

