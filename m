Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B3741956
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF1ULs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjF1ULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:11:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEEF2708
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:11:10 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7db2e162cso2447075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687983069; x=1690575069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5K4gcsgfu5VdAQZmgsxJjZsYjNzsysi7aJ/FIr0V2kA=;
        b=de0X15c22x4phdM0BKgrnCVftBlKRbqym+5tXlx3mmoYm2yv2sZUv7lssa3ypa5liF
         494z/vLNcOuupUwxI6KNzv5kLS+IerDQhhxtsdWSzbITrutMyGQUCw64p6Dr5N7CiE3i
         wJqJM/v/Lvx77uHrLUotpWbiKbgPFumcU2xB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983069; x=1690575069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K4gcsgfu5VdAQZmgsxJjZsYjNzsysi7aJ/FIr0V2kA=;
        b=Y1vD0IUPlWjzTKk0h60exhp7Qu9gxgVc650JHi4cYb+abt4k+fU6QrpzApcigan6RM
         SRWedBcZaKnMx9ZYrfbt3/2OqEgn091gqB5ydgepkLcUNkCurHx3lR8ynUIScW6jhEdJ
         28A10wYN81mxVuHqn+1NeUS8uGwylNnC29Z9HAFYz1AFu+juk3O4cqQU3mJhc4Izfq8U
         O2WgK4zXvVp0iF3QszJ5BmCoKqBp3Av3uGOUGEBWz2RLGZs0ZWOXU4idxKiw5MRlFAMx
         CNUfLEddFYlxyNbg35Lb+qnT8349YbHlH+/SytWaKW43/7jU0VE2cpOibL4zLXwhmT2z
         ZSAg==
X-Gm-Message-State: AC+VfDwDe0EG3KyTkxZByiLWA3oFnMM84e5czebc/1Q8Ee4rGDIsRoQV
        dxm71mW7rcSxjVJsyhMQM63l1g==
X-Google-Smtp-Source: ACHHUZ4PcHsrof2rSh4ypgQ4TC9TefxxeJCtnWJr6LVXVz2BjqfkCNVlKErJZ2LW9jafeiNxTeHaIA==
X-Received: by 2002:a17:902:9a09:b0:1b3:e003:be8e with SMTP id v9-20020a1709029a0900b001b3e003be8emr9732346plp.7.1687983069715;
        Wed, 28 Jun 2023 13:11:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b001b53029fef1sm1950809plb.172.2023.06.28.13.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:11:09 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 10/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct user_sgmap
Message-ID: <202306281311.8AE923473@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <2ebb702f25c4764fb36ab29f4f40728e12b0e42b.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ebb702f25c4764fb36ab29f4f40728e12b0e42b.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:57:48AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> user_sgmap and refactor the rest of the code, accordingly.
> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.
> 
> This results in no differences in binary output.

Confirmed.

> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
