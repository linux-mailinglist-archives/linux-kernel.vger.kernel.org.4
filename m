Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE9739179
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjFUV1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjFUV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:27:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4F19BF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:27:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6689430d803so1951057b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687382849; x=1689974849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6XMJ/c0tXaMsLQ5pmA6s+F2ev1ZjVyFaNvWpRZRfpo=;
        b=WL5g94mpCAHGN8aYkBCYLfpDwX7L+CRtCjMtLOysVeHsdAIJrTEresjjphdof1hgbT
         2XytLFiTaE3V+YAH+aztL836LGzNt2quPxfUw5lqqsgiFOmTHF8vvEhmatFqinE+7ZSL
         7z5JzsOfgeApl+oKm8f+2peFxXeJbLzYYhtyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687382849; x=1689974849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6XMJ/c0tXaMsLQ5pmA6s+F2ev1ZjVyFaNvWpRZRfpo=;
        b=Sjckqoz3zuZvfV6SMiLqr7D+/WSzROhlTmoSlwn5NU0oD2mq+fF/QHGNTipOwA9jqr
         8FRs1NUrHEsrN/ectWpP3KwP/7rtauKyefcxPzUxDC6dOz48/7qNIcnI+/oGeMe2EslW
         JkaPi1J17Y5QkpISFu6vALdrycEi9iEkR4rQa+u2UiUO9TQ+RriHJoXXZjgTSqxzwJHO
         nSilbcVQubVBoLdDM7DT94GxpfN7QkHOZ0Xg6fgKe9fDtASysivQm/B87K8hP8wukIy9
         Giw/puFWffgz8RD6HKjDVO32wPxZ7i1Xcx9CF6k0csRwUcir8QgtFOLTnEUjcY9dk1WM
         JcmA==
X-Gm-Message-State: AC+VfDzRd3aUxyi27vSrvAdi7YQTEjIMausyj7270uXGbOfgLk7J1M6f
        XaGC9LBhWFdfbDcl8feDjdfsUg==
X-Google-Smtp-Source: ACHHUZ68Q2VWIHG82voT+EKyIL5GNKKVS/+sbMJ/2g3xUhaAv1QL0fCk/waB6HV290TGrrV2cWfG3A==
X-Received: by 2002:a05:6a20:54a6:b0:122:2c01:9bd2 with SMTP id i38-20020a056a2054a600b001222c019bd2mr7754893pzk.37.1687382849346;
        Wed, 21 Jun 2023 14:27:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79149000000b00666e883757fsm3293063pfi.123.2023.06.21.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:27:28 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:27:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] smb: Replace one-element array with flexible-array
 member
Message-ID: <202306211427.B789D305A5@keescook>
References: <ZJNnynWOoTp6uTwF@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNnynWOoTp6uTwF@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:12:42PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct smb_negotiate_req.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/317
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
