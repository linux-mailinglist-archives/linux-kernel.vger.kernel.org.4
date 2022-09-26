Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95F5EB401
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiIZWAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiIZWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:00:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78775B07F2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:00:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so6326030pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+ZEMgKZ50aCDjQK68MSGFBCexnl9R3k5e5W2Tro3RWg=;
        b=fT38y1rOWTApfMEBjCgOn+LCoJfBghe/FDgFowftaeDO4tVznkuBwLIPkzDxuMmfu1
         MgaBR9oig2qy8w6PV7ea9JgluQBhB+QBkH2sYw8+imkgqruS0mJh0HXofXKM/RnPWZcP
         vSiKGqcczjqIX8/E8qIY/PaBX7yXfkZAJumsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+ZEMgKZ50aCDjQK68MSGFBCexnl9R3k5e5W2Tro3RWg=;
        b=s8wT2uRX/uudvqjczfqFyiUQf9UpKugGgiemrYfWmQ6GatUPg2kUjna9yltKfHGzAo
         19RDzeK5XdDk4jdnd1jiA+Qg1uKwxH5ZqxSCCdO1aWGdHxzV2ZoTgfn2Ov+Iedo+Wam1
         w49Yss0fXwkxW7aN702K22UqYmkbRHlIDl3JM2F+Dm4tDBbdvDOXmrkdQrOYAdB0oCyM
         /Aal4DUO6blXgmjet8S06mke10vreTfEXRMrSagNnfPDAXB3dre5erClZYt8UrsYDnqV
         eG08iac9grvh5kRZ7ea13R6TplbRqOD4TojYoZ9a8dnpGvWJ7QGfcMSWUzeprQte8qIK
         OsFQ==
X-Gm-Message-State: ACrzQf3mPbFvW4alSCsGcCNEbE/57M1Nnao9qwb3xxL1mM4WNKjOJcal
        U8R80AiR1B1DCnn2yDn7O3cwe+GKv6JQug==
X-Google-Smtp-Source: AMsMyM7kXAcWDr5781Na6ZCbqCa+1IKpuvbiKuMQr7jAwzaYb8SX5lYFg3nTy86MYmKaq1Xy5AVdWg==
X-Received: by 2002:a65:6cc7:0:b0:42a:4d40:8dc1 with SMTP id g7-20020a656cc7000000b0042a4d408dc1mr21904988pgw.321.1664229643966;
        Mon, 26 Sep 2022 15:00:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mn5-20020a17090b188500b001fd66d5c42csm7021210pjb.49.2022.09.26.15.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:00:43 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:00:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcache: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261500.5A71026@keescook>
References: <YzIc8z+QaHvqPjLX@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIc8z+QaHvqPjLX@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:43:15PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/213
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
