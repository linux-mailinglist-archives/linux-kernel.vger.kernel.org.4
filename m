Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3245738E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFUSKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFUSJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:09:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD101BC3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:09:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25e83a63143so4617297a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687370978; x=1689962978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtCU2aNHiXALlbRX9I4DukzgSyp1YjBiNC4CphoFrEw=;
        b=EqOdfYunj6JALtj6gBMDXY1XZ1NuBHwdT6XXru7HPOH40ch1whOqrIXaaidsAZDU3c
         Fyo49GFMqwN5ola8kxFJPPzHnSTASl4xCJIP6q5pNko7QF/Nq7b3hAnUWDPFGJS2E85F
         NsvAwizAbJH+Sdjb0+9M5uQSkL7rxy7YsCFNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370978; x=1689962978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtCU2aNHiXALlbRX9I4DukzgSyp1YjBiNC4CphoFrEw=;
        b=b2HpzhdskQMCNlq0tWBBrbI4QliceOa3HZa6YltLQuu9tuqADnA7cnyrqcWSjntrP+
         /x7dau1Bmzlqc/u6T5KOZgwA6e5ig0eJNNGkYtRCTLvojGdpBK9BH9qnSwud55uT9uSX
         EoIXtjx2oGZPVMkAAslbvGpXJaj30XCHAUN75VO+vpcZUaWZwW+115gfFX1HbQ3zWk24
         iDiNn7JZtuDXTKF9wLPO1hgeXaZHK+5wLpiXetyl7zdFagOejMJX/bqCQSow/Wt/wfxH
         9Vq8sX6fy66G5R8ErK1Bc5BTe0tUODm7e50SHCIL9UUP97o/rffltk4hIAU8ZItj5ELS
         F/OQ==
X-Gm-Message-State: AC+VfDx1UseQaFpfWjgxqtLILUg6tW/mmXAvZhu8EmEwavwwPwlIa4dZ
        0I2WISWIg7az0wGsqDOkNUPeyA==
X-Google-Smtp-Source: ACHHUZ4FWbV1RyWBA8tediI/mnxk6UaQLmEhERVpP43CeGJ2wgt9fIxD9VuISBehmuwGWMB9HhtIlQ==
X-Received: by 2002:a17:90b:38c8:b0:260:fd64:a20 with SMTP id nn8-20020a17090b38c800b00260fd640a20mr2364445pjb.9.1687370977767;
        Wed, 21 Jun 2023 11:09:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090abc9200b002533ce5b261sm9274479pjr.10.2023.06.21.11.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:09:37 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:09:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bodo Stroesser <bostroesser@gmail.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: target: tcmu: Replace strlcpy with strscpy
Message-ID: <202306211109.72E5989586@keescook>
References: <20230621030033.3800351-1-azeemshaikh38@gmail.com>
 <20230621030033.3800351-3-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621030033.3800351-3-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:00:33AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
