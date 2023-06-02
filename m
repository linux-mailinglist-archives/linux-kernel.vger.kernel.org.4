Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F76720BFE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjFBWfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjFBWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:35:47 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F31A2;
        Fri,  2 Jun 2023 15:35:46 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-568ba7abc11so27149487b3.3;
        Fri, 02 Jun 2023 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685745345; x=1688337345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKxX9BPtCe/QC3WZ+iLM12X1lSFTxsdLPSQSQjO2KP8=;
        b=WCd4O6JI1asaaZQtxrd0ZUaUz5nyRiitobCkJSkTPqKfJTCRwkjOOZyE7cfF16GaDO
         spqYdJDExG86F4FunZ09NCBnYh2OUYGp17Rk5eqgIcMGJEL6gRapO26xare152Q0oydP
         s71WlWfJsAByTpt7l82B+Gh0/ZlQWVN6NMzAEj12TzzYaxRoQFB2fMSGv4v9SnD/NzFw
         iwVu3E3bb53dpMDIaOMH07a82luIRayOLj67M6nnaMWUiwk66hnwriXg5h1SDDA8jGAv
         Ms9LT5IZVKrobR2NqU5zEM3zTWUt0HtZ5XlPQxjASrsCLJ1Uki+aRvsNqBmQaC/RP3nn
         Jaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685745345; x=1688337345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKxX9BPtCe/QC3WZ+iLM12X1lSFTxsdLPSQSQjO2KP8=;
        b=Oz3jvgRLlUi+5/0xLGKvMICaO/0/sm6hXR6hrQ16Yddslxw9L90eQgpjKtHT0L3TH0
         f2qUzpWgTFEuCVDcxnEzXSFc8qNeHrs+xpEag9RZ9mAxMeqO9VHyPvi8mdAO9af6cJf4
         q3Uif+XbOmUyWb46hTROxcd/UFcIu8R1FwDAU5F5nVLPsucuY57cWYFDn4PPIUkDlBID
         dE5xw1psvvWgZ9Qh5c09Z7hr2JNNAymuhPJOEoFLSVxNf+8WrQykC9FzvpxzGjnVJnrz
         uZjlLTGrLhwp3fby41juOwlFvZgcKuT4I56gzLMpxyAqZsM8+B2cI0S74RGRaNdLm8SI
         e4wg==
X-Gm-Message-State: AC+VfDw8tNQpeyQeLRSKIU6kiQ3U0XW8sF5czPrKb26MOZZw0THR1mZm
        N1/Gw7bSW+DoL3lsx902erfsvnpLsHE=
X-Google-Smtp-Source: ACHHUZ6mKI3YGequo+Mwo7sxzY5i7uN8fBMtQ6C36ED3jcePOGhWE7Io/CgNLcDO7Sddna/efqt3Vw==
X-Received: by 2002:a0d:d785:0:b0:569:43f4:155c with SMTP id z127-20020a0dd785000000b0056943f4155cmr1407173ywd.33.1685745345665;
        Fri, 02 Jun 2023 15:35:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020aa780c4000000b0062dcf5c01f9sm1440840pfn.36.2023.06.02.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:35:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jun 2023 15:35:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/39] 6.1.32-rc2 review
Message-ID: <bef2da78-cf81-407c-bbf8-0273a42f6ca0@roeck-us.net>
References: <20230601143327.479886832@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 03:35:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:15 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
