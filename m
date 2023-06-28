Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9B7419E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF1UvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1UvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:51:16 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D147102
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:51:14 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1b0719dd966so160787fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985473; x=1690577473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hToyBpF286Hw/boztsHPGGVcJfrub4UlNJjY6++yzrQ=;
        b=PlhS6mZUDCXu/H5P96F7OAgMX8ScSlMC1/t4KPNfwE+io6blSxqzJeLUACudjJYv9I
         lxXDKVMaMR1yUIfyBwVbNKLwConVSG9Xq2gJiukgntJhnu9DddVY3QuqxUO2uUNAEA9l
         bt+5N2/qHPYcFF7Ls3181LHQG5jAqXjX7n7Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985473; x=1690577473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hToyBpF286Hw/boztsHPGGVcJfrub4UlNJjY6++yzrQ=;
        b=Hu1GdzUaC/QhwHMFxvOKRDNm6CCs349/4YXGPiImx8fWd0ASLS4ZV4NwSi1P0GGSgg
         0qUgA6ibupIL8XFXYBQQzCuAbtxXbHKSt60OgzncCAFhiVAwqWLQK5CFPutVrawTI/5g
         HSkCmDYG9lBSqBxcM5GtVWwR1CMgtIRA4GPR9nYIXs0NM5WxKme8+64+gBuz1qryM8YH
         ZUy7b0qC0+8nAdLSq1UFAvG8nqKq1GhfLRDDdj4L8nt51HlVB1OZ0JZZN3a29ALOn3fL
         Kh0oi2N4Z6k7dsG8Y43Nqfvz8feuahPVHhxvXwb7x/ICRMXDRpunXDK6kwOobKLS29A9
         LHvA==
X-Gm-Message-State: AC+VfDzhyfgB+BAHAX19iP4r6A+qMTHPgydbv7MDC4biHp5TJ4kXgb6E
        FnoF7GeDksep3TTgt3O9Biig/Q==
X-Google-Smtp-Source: ACHHUZ5nxR8s1z286EFR3jK8wMq1RzdKDcYrke+gXGBTPWlH/qBXPY6I5dfuU5bCNP15XZNh06y8QA==
X-Received: by 2002:a05:6870:770c:b0:1b0:1b2b:7e0b with SMTP id dw12-20020a056870770c00b001b01b2b7e0bmr12966828oab.30.1687985473125;
        Wed, 28 Jun 2023 13:51:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b0025bc49aa716sm8194783pjv.27.2023.06.28.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:51:12 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:51:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 02/10][next] scsi: aacraid: Use struct_size() helper in
 aac_get_safw_ciss_luns()
Message-ID: <202306281351.91DB52F4C@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <cd80ea8f2446fe62ec15ffb0bbcecb69e0c342af.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd80ea8f2446fe62ec15ffb0bbcecb69e0c342af.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:54:58AM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
