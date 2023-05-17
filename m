Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA447071BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjEQTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEQTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:14:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358ACA5D3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae3bd3361dso3054295ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350854; x=1686942854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OF7IqNqVQSygRXbJNJpQpYbU7auySEzr+GtmPXPUAn0=;
        b=kLvGGdy9095Ptm/Iw5wLciEqANZvZC/ZQvRqDejeZ+g8iH3tWkpb8UrWLCnwC7bUvh
         jePogsfjsQJGmJuHLgK+r1dPVWOCozPS4oak3WZjwMPmEmh98jj0SqcnuMdRbwMsULUC
         vGmXiL/4ES71EDTTOYLumVKH1b8WxpBT5qq5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350854; x=1686942854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF7IqNqVQSygRXbJNJpQpYbU7auySEzr+GtmPXPUAn0=;
        b=Sc6jZVMTKNNQz5WOL5TvG1VL8EmIPRfb2hzF5dx9Cll/0eQ3cHXHOPAKZfVoAy4VqL
         ewYztssPuGZlpHpP/UejhfS71gU3BAuI0G7yxY15b0xterpKn4zPxl+6NM3yJUCWo4zq
         G64jQuFA7tGicAphaw9YVHQQRnX3SKZjtKX+6R44zf9Ses8y7T1d+vX1gcEoNjZWtWs6
         4gyGafzmfo8aoBYtaPq+nvtv+TOSR3X7JFxfRgBwyOaknOL3p6R3K2gmahtsQp6Rm8YH
         PSR9ypzq9fWfRGugSWSQGvhqTvmxP4zW97hZerbLHqhN5AKG4o4WL+wQW1pTCvwpZcrH
         UbqA==
X-Gm-Message-State: AC+VfDy1Jbv9NA76ZPi9W4TYhesZnv4062N/CSzVv2FgkNKVT9UEi8XY
        TDJG6hDTnL5EenHn1JQHWa2dmA==
X-Google-Smtp-Source: ACHHUZ4nuz053NvmXbLbdrszQSK5dz3F32gcEeoYsXHr2TnuVxVZbs8n03qMVpMDaT3d8xSlRKwJQA==
X-Received: by 2002:a17:902:d509:b0:1a6:f93a:a136 with SMTP id b9-20020a170902d50900b001a6f93aa136mr4029240plg.22.1684350854522;
        Wed, 17 May 2023 12:14:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b001ab2592ed33sm2121588plb.171.2023.05.17.12.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:14:14 -0700 (PDT)
Date:   Wed, 17 May 2023 12:14:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: qedi: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305171214.4DFF2CAAD4@keescook>
References: <20230517143509.1520387-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517143509.1520387-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:35:09PM +0000, Azeem Shaikh wrote:
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
