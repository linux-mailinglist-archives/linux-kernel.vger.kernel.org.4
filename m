Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798AD74194D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjF1UK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjF1UKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:10:42 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA921212F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:10:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so140914b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687983040; x=1690575040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSapW0FmCiFhc0XnA8Ry6zuPPnmsaSmu/yInPi5x4CI=;
        b=ghbynXK89qCF+G+B+jPDLyXDKK+ufG/em66+TPqJAG8Y+r0e0gX/WaalZXazXK/5lo
         gVzM0KQhZaGAuuRtF+qBoUmkTZX/7vIviJOp4np2J2qXoySfnZMQDaxV6rxAs/QT+mIv
         ibFAG65bYGMNwQPgdrEftVIz/l2XzU1gE1jco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983040; x=1690575040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSapW0FmCiFhc0XnA8Ry6zuPPnmsaSmu/yInPi5x4CI=;
        b=AE1oo8w+OSFaKieXfnjqaZXm+QOZe6mWjBf9U47h0zhhPPWn1+OeT/eFYGq4pw89um
         Nl3G/0h4TvzOu0eX/+1qhPv+iqcR25JnpJwtcMXuoSdwVsckKz8gFL0rG7DZy6LMw2ZV
         yWzm07KJEt8/7NOWHAd6V0X7yrKSeRTFj3FIlVHDTCxbR0oAR0d97ElJye0+xCzZG/s5
         Eqw99ceFZT2ueHXx4RvYKGG32S0ij/t0UHJrcD/6n7CYtkhIuH7d71K2MgOC4CbOEiLD
         1awyAwj0vMr0pQfvoYZq1oHW86o7g7swlG6oBhw/UupdLlqFybtueGQntMNai1ysETPb
         HhdQ==
X-Gm-Message-State: AC+VfDwSlyu0mDEZZreM6FnJN9a3Xj1q1IhmQmjiySH8xvKs0n7WrelD
        HAMKBfRebi9sseKVbzZqfudAuQ==
X-Google-Smtp-Source: ACHHUZ7fnyiiEJe1+e/jMPIJD24SQjyElEYOOpmIF1pRe0YUjvwzuY1nglQC2DszuIErUH2mxMqtjA==
X-Received: by 2002:aa7:88c2:0:b0:682:3126:961a with SMTP id k2-20020aa788c2000000b006823126961amr503644pff.5.1687983040309;
        Wed, 28 Jun 2023 13:10:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h21-20020aa786d5000000b00678cb336f3csm5048691pfo.142.2023.06.28.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:10:39 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:10:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 04/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct user_sgmapraw
Message-ID: <202306281310.7E77AE98@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <4c2277b8aa3de8600c807ff8c995635f414161f9.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2277b8aa3de8600c807ff8c995635f414161f9.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:55:47AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> user_sgmapraw.
> 
> This results in no differences in binary output.

Confirmed.

> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
