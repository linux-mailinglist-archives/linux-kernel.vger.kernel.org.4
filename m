Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5083E74194A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjF1UKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjF1UK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:10:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0E81FF6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:10:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b80b514fb7so2574505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687983025; x=1690575025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1LPKrRFxE7z5JbsWiXfc4MacbMwcaBP5SMmmJSg5X0=;
        b=ZU3GIiembL+qyfBPhg67vh1VPEfgsm2sf0Vwcw6HRFQNJgaVTvdkpkktE/zK0VPcp4
         IZ5FmVj/fjCSttx5u2xwbJe183QdD/j+WgWm6cBdPsCELoLiqyh/PLCkRyjNR4TJ5HIi
         9X/jgh4DeqGFE8/ajeQfuh0wGJgOSE0yizNyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983025; x=1690575025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1LPKrRFxE7z5JbsWiXfc4MacbMwcaBP5SMmmJSg5X0=;
        b=Odm0cF5WpSqfjP7zGJ2p5ZfiwXJsvVvmvw6/2lyRtpR7GeEYmiT/i1TjFSuHJS5Kyw
         vOlmfLr08N608uo44//sCI0ETA+bdEbquIYOLTku5xV0GVZRC0lAQy1Sr2SG0Ka67LOi
         n5lHVEr3nq9HQ2eQ3hOnUQ9sNqEQDGtNgR0uk5GLZ88OS6g2d4LIbTvom0vCaiwemtF5
         PwPq+L03DVRZowl+0qGNC2TwT/0Sg+7N1vO2xxH07DGTF74kM95QjmT30gSdErdPdoBL
         L6glcunP9+gwF5Dw6RCBVMX6Fo6J/xo5bYikCXSumhCVNAdq4gD3lGSRGvDBACAh5dSt
         WwPA==
X-Gm-Message-State: AC+VfDwcjE8h/O1FZLWmMT0S469Bmy+nIJKhwuuHj/euDX0FvpSfAfO9
        c1jX/UxQChUj1O/pvM9f+ACajw==
X-Google-Smtp-Source: ACHHUZ4WKbNj/e4fSFBNa7A4PfXgK9d496EWwQvNqQn0V6qk9DE1wLP5eFn/lHS8TLGVhPQjuqo7wg==
X-Received: by 2002:a17:903:2656:b0:1b3:f8db:6f0e with SMTP id je22-20020a170903265600b001b3f8db6f0emr10107522plb.43.1687983025193;
        Wed, 28 Jun 2023 13:10:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b001ac444fd07fsm8011776plt.100.2023.06.28.13.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:10:24 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:10:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct aac_aifcmd
Message-ID: <202306281310.850C08F8@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <65907ee4083de62fbaadc5c2e6512e3828912d1b.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65907ee4083de62fbaadc5c2e6512e3828912d1b.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:55:24AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> aac_aifcmd.
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
