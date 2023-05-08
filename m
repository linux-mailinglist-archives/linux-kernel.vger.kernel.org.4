Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426806F9F55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjEHF66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjEHF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:58:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F15249
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:58:52 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so40703975e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683525531; x=1686117531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvA3BbB5eTzMJDO0Xj1V5sRcebpMMil+vQRxCJL4nIs=;
        b=xDIAoKjRxh1WHbxAA6RvXEZMnI/KSmHcXZZ1nhICt2VnmLT9Z1lohGdva6AeZL9Jyv
         VtC5FjqRCv7Jtb07ptQuFpcaSbwfE0laWcsWVZta6VXzPqVY7Nr3bFUPG1OOrD1MJ69a
         bpgd5TBHyxCZorJ+pxZx2y9vKrby0XSxsqJHVEvsEQUYHZQlJ9Q+1lDQVmT+KuJ91W/G
         oKJIR/siGj8Taxk7G1hat4OGmlA9TC1W1QVztRyhjbAfhNufvOMlbTMw6khW+ky6co9+
         sD3x90jLKPKlSoeqSOkLjDNy2ZBYoic92fxQDMcojDnkf5t2HLpTtsBtbL/MpFp8c//L
         b1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683525531; x=1686117531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvA3BbB5eTzMJDO0Xj1V5sRcebpMMil+vQRxCJL4nIs=;
        b=ebpHe7N58nol2BKpzkyZDii71zzBhiOD5Ofc9LFCIm9+AH9U0e2ueBIaoFvV2PVLnw
         4QD35XGtsyEl8FwfrlP5Mx2MnQZuFReQrO/M7/t3R7xXRARyQuLIk+0uiW47ss7SI47T
         AGu+I5oUcJ3oIXFdhld/24JS92xedbOq8p2+awkJ6qdfnh0uBYLWp8RteMiW79+G7PqK
         +PjE6jBaH3KliFUGKJIrX/zhNLkGpbd1Hn4uOAUyqD4sr2EteBLfI7ok0/VXcEnhbe4X
         BG5z5w4u9Shq9SwdAr70NigBe4tJaEGYllBT3mnkLYlCdi3qi7jN88ZWTFp3KSagIAFz
         LSvw==
X-Gm-Message-State: AC+VfDxdSaEBtMJvTHWz9f3iitz1wEPWH60HbDKtIFmnt1nIRNTtHKgH
        X4742VcnxG+vo7BSNQz9v5zDYw==
X-Google-Smtp-Source: ACHHUZ7kDPVe7FvT1eLdhpgOyd9pM4EuemhqOQKpxgQxIAchh3l9w3IogVUbfMCPsTWEXXHshOsPEA==
X-Received: by 2002:a7b:c455:0:b0:3f1:79ad:f3a8 with SMTP id l21-20020a7bc455000000b003f179adf3a8mr6075223wmi.16.1683525531435;
        Sun, 07 May 2023 22:58:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u24-20020a7bc058000000b003f173987ec2sm15629013wmc.22.2023.05.07.22.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 22:58:49 -0700 (PDT)
Date:   Mon, 8 May 2023 08:58:46 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Brandon Pollack <brpol@chromium.org>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, keescook@chromium.org,
        nathan@kernel.org
Subject: Re: [PATCH v2] .gitignore: ignore smatch generated files
Message-ID: <d7e5e4ea-c931-4eee-9a49-3cf167c9ab8e@kili.mountain>
References: <20230508055226.3183447-1-brpol@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508055226.3183447-1-brpol@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 05:52:28AM +0000, Brandon Pollack wrote:
> ignore smatch generated files.
> 
> Change-Id: I8ca4002128e53024ea8a3daef908ec5e49cec65c
> Signed-off-by: Brandon Pollack <brpol@chromium.org>

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

