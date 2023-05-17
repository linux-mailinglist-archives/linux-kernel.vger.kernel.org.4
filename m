Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DE7071B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEQTNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEQTNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:13:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD34AD37
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:13:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab032d9266so12944055ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350814; x=1686942814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1LoPTJbncGj0zRlQjVQv3mXnAMywvSaO6mLN0ylsDA=;
        b=lzIhsYITQfnlvkxnxaTLqpMZDUwTS8G8kKF8F549pn5Veo9fN0ljeVbZH/2hili2zP
         VDCZgc0qG1i7EHVLCRzwIlpFEX6MKfZ4glGslTOLBrY/R7scFgR4yxgzAtgxv3PZx36I
         UQJb9eVcN6zf+G6ZnK4le7uqSGLx+KvUGEJqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350814; x=1686942814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1LoPTJbncGj0zRlQjVQv3mXnAMywvSaO6mLN0ylsDA=;
        b=cmfdmZbtNaie9LWVATIGY1VLQXuvyH6rnszZgBkUaFZRif7pp96Vcc7EegP/UH2SRt
         hcRFdPYfc4rWaplDd18+6VphorrAl5SJ7T6JM96du9rJxhimmucWjVcdF6U99s5PU4z7
         WaFeg/gGuvKcxj2BeW3QXU9kSEiiL+wYEHjJFCGcUodUIzE9ygnCrzQr1RLdqZTv6+Ag
         SltjPCS/OwtLIgnBm0pZQ7V3oiPiaPxPPoJr9lOoQ5HkDxMtm8Q05W45ziplTHV0I8pH
         0A4IKPEO6LQJDDuSBF1GPTg8VWEOJJDMKH5t2zCxFOL0aWhmJKz3a1n9OGB2wwaICCCY
         zD2A==
X-Gm-Message-State: AC+VfDxbADPePMoYFW371ey5iVOSzInbV5RmLTK62n2ZAb525s8+EtPc
        Cp5WZJ8i1Rkv1DjpoQCpEmabde2k5d9L3gahsVE=
X-Google-Smtp-Source: ACHHUZ4JPsHm4F2JyvSlEeT7wms9HdBEUFjbBD3IpAsMfcJwtkQsjelIUPjNuG827RbZkDbKc67HDQ==
X-Received: by 2002:a17:903:41ca:b0:1aa:d545:462e with SMTP id u10-20020a17090341ca00b001aad545462emr56626362ple.13.1684350814555;
        Wed, 17 May 2023 12:13:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001ac444fd07fsm14196116plb.100.2023.05.17.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:13:34 -0700 (PDT)
Date:   Wed, 17 May 2023 12:13:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: aacraid: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305171213.4BE193E@keescook>
References: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517143049.1519806-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:30:49PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
