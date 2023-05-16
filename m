Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AB70568C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjEPTCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEPTBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:01:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7FFC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:01:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaf21bb42bso59195ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684263696; x=1686855696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUkmmpx1M4MtXHMNNv8IRyExX8PTEgvpMh/addFkD4o=;
        b=YTcgXElpvGt3LVfiNgl5PSEl/rBXxtslgzs1wn0AulV9NHy7s3dRPgUgymNAKMd4u5
         dobM79MDBBTmVDF8lrKoENPSGJIbzl032aZ+Ie0w8hNTx80kVCt54FdiVcZ6LR+4YxjA
         L6PuoiBV9Q/FJUVAooL5QT+66KDs7lg3YwX/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263696; x=1686855696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUkmmpx1M4MtXHMNNv8IRyExX8PTEgvpMh/addFkD4o=;
        b=aJYclYu07NYksRCVMBPLKQ+2r5Tqjbfi2OIbDZs408m7/mT2mX1GGFDwU219j4bCHv
         I+eWKoUlOdL5HUd7EqpIocmpZHK6pvuirTwb12vh1QHikdBwAVXSH25dNbeAdBx3B+zL
         yOWlct9nWDSoRP1LfAbxFD/+qk7qZVwojfkC019inAGIYG5kkVxvHYacC7ks18SIqNFr
         MiMe8URdLDIbTZiFNqDaWHomwzIz3V7t2OWGus6rZGWsAEDn55MZCIFH1GjdoDYour/a
         xyOwJlb+cEUzU5Dgrwa/8yT4zSyjvKYU5cDdBQ9HNasjrN+U0DRjtwjhyUJumUpHL6G5
         Jfsw==
X-Gm-Message-State: AC+VfDy3EgF/tVUj//j86NnZBpI/0j8EPLVbKZQjxE9x6LpgSflNpYZv
        nsVgv+ehL3EwNrTNuiAoVD8I7A==
X-Google-Smtp-Source: ACHHUZ5ZLD7j3APDOySoMJHuE3aU18Lrbi+vh403ZC/xZCJwhn9YLHMEtvqEWZXDOHofmDlW+yYTpA==
X-Received: by 2002:a17:903:2452:b0:1ad:bc86:851 with SMTP id l18-20020a170903245200b001adbc860851mr29197280pls.45.1684263695791;
        Tue, 16 May 2023 12:01:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902728f00b001a69c1c78e7sm15783248pll.71.2023.05.16.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:01:35 -0700 (PDT)
Date:   Tue, 16 May 2023 12:01:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iavf: Replace one-element array with
 flexible-array member
Message-ID: <202305161201.4AF77552@keescook>
References: <ZGLR3H1OTgJfOdFP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGLR3H1OTgJfOdFP@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 06:44:12PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct iavf_qvlist_info, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/289
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
