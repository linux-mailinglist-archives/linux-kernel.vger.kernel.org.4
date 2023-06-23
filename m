Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84F73AFAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjFWFBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjFWFAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:00:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB512690
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:00:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39e8a7701f0so146962b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687496440; x=1690088440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dO3MpsG2FPQPtCv7mlnZdFOdJg6cQkJoBs2wodZ0qFE=;
        b=ENvITiWl82bmXDiJLimeWRzeEHEf1ln05ugojEWad/Js1Nz+uQeXK4+Z/WAHbfGqf0
         rbiZjOjv25tD2F25726CThGsOrX7cjuRALOeDCps5H4nNIGerVZwbj1vVhY3/sSEADjE
         sDPIoUgnhiRkd7WT4A5eCGBO1kfJKKDsJOXg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687496440; x=1690088440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO3MpsG2FPQPtCv7mlnZdFOdJg6cQkJoBs2wodZ0qFE=;
        b=F+H1h7lgViOliQwk/4fmkujQkJrMhUKbSqq4Pothu1XlDpp6SDLyxME9OJrJrDEWpd
         ySbCVwGGVdSLZqzycd8atXxRSdN48rtIhIrNFomgIwEUhu9F/TLoZDPQ/rovpEGSLy3j
         RaG30O9ogUsMaj+gbPLQQbk8cL+rowBgGQ9dwE9F5MZZHs5IbAGRIJdfPPK6xsXXcgS2
         oAEoLO4aHXUY1od0asJxmAoJ3LLFL6IHyjZ0HPSLiEYK5A/kknqwBQJNlzl9g2UJC30Y
         BQZXcblgpNybO6lspT614a8mklN/9OR1tsMxYSlbd4n21pW2HF7+mSEFt6GD5s8L+cm0
         qQOg==
X-Gm-Message-State: AC+VfDxJ27zST6elxFh0D+XWpvIBS0krv3t7cGuywbRgSwE+IjPy0ruq
        KTvGJiGRP2glbdlAiPJl3SRouA==
X-Google-Smtp-Source: ACHHUZ4QrKXVokRHjUt66Kft/IMDEJ80EeRHZoEf3iPCaC97ad3S8FSVewv0YRPDVlMlg0KPF7Pzaw==
X-Received: by 2002:a05:6808:abc:b0:3a0:3685:874a with SMTP id r28-20020a0568080abc00b003a03685874amr9412504oij.21.1687496440211;
        Thu, 22 Jun 2023 22:00:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090ae38600b0025c07d07e54sm524952pjz.50.2023.06.22.22.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 22:00:39 -0700 (PDT)
Date:   Fri, 23 Jun 2023 14:00:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] smb: Replace one-element array with flexible-array
 member
Message-ID: <20230623050035.GB11488@google.com>
References: <ZJNnynWOoTp6uTwF@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJNnynWOoTp6uTwF@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/21 15:12), Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct smb_negotiate_req.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/317
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
