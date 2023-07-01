Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24D744885
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGAKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:39:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74AE3ABD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:39:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso1492976b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688207978; x=1690799978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvKlv7V/zlmCRf2RivP0ePDgqQNtmt0BK9y0NTywrwY=;
        b=T9sdN6D9mCYudtM9XesIP1M5FSxYgOEkeSvOLkGaCIqIjsXSLjhvzcEXE053/Ur/Lp
         NBN52tKMJCyI0fwreg2a8EYYtF9VF0Y+1CmT8FsjdQbO+mZDlxkdl0eHclg0Dpsxq9qi
         OVgnssEyQ5V1ZHNioOHs2+ymbJeMR9Gn1ISIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688207978; x=1690799978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvKlv7V/zlmCRf2RivP0ePDgqQNtmt0BK9y0NTywrwY=;
        b=Z6fIWhI9KleuelldCLBC3hEKiCK4u0zYINWEGI4DKfOZgGDMI/F6bri2/telSqQ7+L
         9w4SWrUm57I0eTfrWdWHC5KQP3zOYxklvaTuic3jM/Wsyenlsj+YTHiHbnVZJfEgcl6m
         RyO+YV2lls3aZ4Z9uzUKw2nS2H6mA3fbk6mfeZpWUVgnyP5eFsQnRyCiUmfLLAlZG+VK
         3wp5I/0YMXAonVstxYomMmof4Z4nQd3GvFyd9hW6D+mxHEjPkHImyxvzzxeBjcMDmGq5
         CvHJMQSndwmmxenxA29xO7n/eVy6fpVFxMjt5S+jxahUWDR6AXz7w+ryYMDpQaY9clcW
         mPrQ==
X-Gm-Message-State: ABy/qLYkzp6hjowUez0SlPm5mJ6cQCrBvpqNMWZprBdXi3p9CclrzE5Q
        2C82Uk9A+7nvDTXerZWHd7hfRw==
X-Google-Smtp-Source: APBJJlGAgOqMCk3sQFJB96DMY3/EXzKpV/JFxAehUu73xAC0qUEP/nMLsgNpDco3vRRCz03KezBhpg==
X-Received: by 2002:a05:6a00:248d:b0:663:5624:6fde with SMTP id c13-20020a056a00248d00b0066356246fdemr5250642pfv.22.1688207978137;
        Sat, 01 Jul 2023 03:39:38 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id r2-20020a62e402000000b006783ee5df8asm8958554pfh.189.2023.07.01.03.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 03:39:37 -0700 (PDT)
Date:   Sat, 1 Jul 2023 19:39:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/3] zsmalloc: do not scan for allocated objects in
 empty zspage
Message-ID: <20230701103933.GA283328@google.com>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
 <20230624053120.643409-2-senozhatsky@chromium.org>
 <20230626105750.x7dxn7z4l6t4sicb@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626105750.x7dxn7z4l6t4sicb@cab-wsm-0029881>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/26 10:57), Alexey Romanov wrote:
> not sure if I can keep this tag but,

Sure, why not

> 
> Reviewed-by: Alexey Romanov <avromanov@sberdevices.ru>
