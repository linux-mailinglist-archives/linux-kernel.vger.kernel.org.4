Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE574194F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjF1ULX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjF1UK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:10:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4D51FF5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:10:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e97fcc60so149378b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687983054; x=1690575054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPuF9yHugeE7qGYrhgIx3HdvRmEnZj5SYVSQZwrTnzs=;
        b=LyIozwLW6BJ8L75SPZ5k62iYFqwM829PwYYxM61K8xVbNXWv2PrkvZYtrPI0pe1oHU
         JoOzrQ0n7LDK6NKYmNPpcq9BPSahVoRq0h/np4dAmsco3AunvPKeBxE19KLyGuA5rtZ/
         zwkwzVLXll8+gKuzvlV4h1kHibndHGc7oAdsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983054; x=1690575054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPuF9yHugeE7qGYrhgIx3HdvRmEnZj5SYVSQZwrTnzs=;
        b=G+F/CYR5Lau0dJW7P6Y0DbdRD21UnTfDO66XfwYKtmVl3rnh7m/G5d9td2wVKQ3QcK
         3E35MhRXq2Yj+nmQfua8A4BOfhfD4EVWDBmVPzSHM5mmrbWsOACVkmdHE8+grpWAx2eM
         K4G3xuo47VRp3q1Cnc4ZbyW4BiCvjdMWuN3RzhiZdORm8ydfNRw4E9gzkRlO+g6h37zz
         z3ng0cSdnJVvNQUe/TYU67BcmE6gzljYCOz74Ctovmt50epW/BEWKvc3t2VOHBXT1yqb
         MHbijr/I3r+4Q2a+UEHaLgSGtWFa1yrG7hScZnkhh27oz/uVh8hLZPKGyUiwJkvmYq8a
         TrnA==
X-Gm-Message-State: AC+VfDwbpIkt/ztLcAkSY+cujUaAjClyWLa1rH8ix1OEZyA+5CRxS8A5
        XPFO05b8UayAe4wTRLqZ2WZHWi4U4gWi+3uSpa0=
X-Google-Smtp-Source: ACHHUZ55jdjN5EWitI5f7ABp6SmlMK0NO4JcVOamLfeFTSEqKRFsrILQSCkGHc4APhbxSZFt3e/G1w==
X-Received: by 2002:a05:6a00:14c1:b0:681:4726:2975 with SMTP id w1-20020a056a0014c100b0068147262975mr3170493pfu.7.1687983054649;
        Wed, 28 Jun 2023 13:10:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b0062bc045bf4fsm6881611pff.19.2023.06.28.13.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:10:53 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:10:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 07/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct user_sgmap64
Message-ID: <202306281310.6CC48E4D@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <bf0845f7cbe2a507a54b9d5bb35a22a1ca265178.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf0845f7cbe2a507a54b9d5bb35a22a1ca265178.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:56:52AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> user_sgmap64.
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
