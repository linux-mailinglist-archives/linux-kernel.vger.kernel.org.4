Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD72765BAF3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjACGvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjACGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:51:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23270B68;
        Mon,  2 Jan 2023 22:51:28 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso15892982wmb.1;
        Mon, 02 Jan 2023 22:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zvm/NFAuK45vvysV5ROF8aqgqwjzu2CCXnvz1aWo4So=;
        b=MLwvy/EyS1jKO51O6p0H8dZSyEeX16in2WqUDXhDxLFaQVpR4qARAuRzQSFB0vcSAi
         MY22qMmS2+2hC7d5gnyH350MucyeiiIAT1YHTmmFNcY088g7JyChJIhptwb6ICB78TCx
         /Lzc17SjQzZgjf+AkcfNpRq1emOnQb3tUdIk+lTsJaMwC0FjKecj028P6hytqleKF+fT
         QB+r86Nw+F66IiPtQ80HRNINvwF27JOtx0e/jPbPcx2TMyxg/WsOg91mZEQ2aWkWO7nI
         BSG4SL04EkTr9dVVj8dmL1nAwxBb27capie0GnD4wEFynlU93m/CuG3BB73hy/+RGQK/
         hxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvm/NFAuK45vvysV5ROF8aqgqwjzu2CCXnvz1aWo4So=;
        b=pAiYwOvlpO0rAh1eD+8vmf7BYSS2wZypSXtowpZGE4S6DBOQaKxsWUqjfcIolenN46
         GnBK13LYazZNOH/mbrz5o/F+sD/LkFmZstz857TimU6sOdoWgeOXSK3qXXG3Wv+cc0EE
         bSNX6zC0SQk+4HnNDwk0MpWbWN5t24UBUwjSiM7RoR3efxNo/8KYtY9h/U3eES8ROa9S
         lwVdNXWsDbJSSzcHH7GnyApK1NDNSqB5QIquV7aZwF8GSNc1gRUwhLRBlI3USliLfKDn
         1/S6owIUBjVPVzolVYEs22K43jovxardAzsdhtZBGPmMu0rpRGjleDcJNbZvarV+faMH
         dLqw==
X-Gm-Message-State: AFqh2krbc9lYVGFOMZhsU8gD8Q8Z4Mg6rP4woDMRO7cXd18iFdLW+Yz2
        EseTeyX1XMAkHJ1HtQg6pEQbnxzMBDs=
X-Google-Smtp-Source: AMrXdXvx8ij6viMFBgSN0O1G4ZhOQt8phXBwB4dVfRwoDkc3xvl4dwcv3D261EaKIC2u2TF6qrm3vQ==
X-Received: by 2002:a05:600c:3acc:b0:3d9:a145:91a with SMTP id d12-20020a05600c3acc00b003d9a145091amr9407893wms.28.1672728686664;
        Mon, 02 Jan 2023 22:51:26 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id v9-20020a05600c444900b003d997e5e679sm25805212wmn.14.2023.01.02.22.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 22:51:26 -0800 (PST)
Date:   Tue, 3 Jan 2023 07:51:24 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LinuxKernelMailingList@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: sun8i-ss - Remove GFP_DMA and add DMA alignment
 padding
Message-ID: <Y7PQbNrgs2EvkXMB@Red>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
 <Y4xpGNNsfbucyUlt@infradead.org>
 <Y47BgCuZsYLX61A9@gondor.apana.org.au>
 <Y47g7qO8dsRdxCgf@infradead.org>
 <Y47+gxbdKR03EYCj@gondor.apana.org.au>
 <Y61WrVAjjtAMAvSh@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y61WrVAjjtAMAvSh@gondor.apana.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Dec 29, 2022 at 04:58:21PM +0800, Herbert Xu a écrit :
> GFP_DMA does not guarantee that the returned memory is aligned
> for DMA.  In fact for sun8i-ss it is superfluous and can be removed.
> 
> However, kmalloc may start returning DMA-unaligned memory in future
> so fix this by adding the alignment by hand.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Hello

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-a83t-bananapi-m3
Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>

This means that lot of other crypto driver (sun8i-ce, amlogic, etc...) I maintain need the same fix, right ?

Regards
