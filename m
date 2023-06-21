Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC13738DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjFURwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjFURwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:52:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825381FE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:50:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25ea0c44acdso3115225a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687369856; x=1689961856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul91Gz+yGEhmaOXTQJ2di/sLFzTVDLLuzrW8OhsrW9o=;
        b=PN88XqpGSql5ti6zvT6MUvr9iRN8qejKRO5qMqIuXMl4qKT/uKG4P1FmNIemZkRScj
         KsudeTVuvXIjTPV/yKqEfzwR1i99um4nsgTQ0U0KpdcF/BxGhOsbrldKHFhAe1mViIHK
         JWPqzFj8jkO0Mk5C1pG3VeABn0XA9qWSNdi9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369856; x=1689961856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul91Gz+yGEhmaOXTQJ2di/sLFzTVDLLuzrW8OhsrW9o=;
        b=PMwhNUcoVgCplDPHABGcQ93jA677WD6S6aVQfhmFZVGZVr2z6Un4OJtOCLeKzkicCr
         vTQmwripVjm/tqst3Xx+tj0qGbsQhgvhLMUvUFTKxlZbP5UQBM44XlJiAJX7yxQXTT0Y
         MaV2cFYqJd7UeXo0LiOmoprJYpGoP6XBZe2RGzDYxm2FSSNsQ91FjgKy5e+bMCsvUsO+
         pM835wQE+z36k0kRj0qdghBzgCDgplgn9Bv+zKSXrn9vgymT/GZ/alhSEa7senXQx0/m
         M27oXrNw/SlnngYDewZKN9FvueUBaNgmy4xltq3UBn6bC2k9qp7LShxWZ8MBrWHaWh6B
         Cwzw==
X-Gm-Message-State: AC+VfDx3pUwgvkgwZf6XjtIN18+nEIxLn+Y/jreXERXgNx9IxlkoCFMB
        B4sp9O1ZfWr0mdLMv2j34+/TkjXe3eLK8awDWHY=
X-Google-Smtp-Source: ACHHUZ7ylAOPxm0ae9kRQYk6NPxzV0WTtVMQNcAedwT2Ag86/ZawLLXcJ65lEiAZwo2vPHOjAsR1Cw==
X-Received: by 2002:a17:90a:d908:b0:260:afef:7b6d with SMTP id c8-20020a17090ad90800b00260afef7b6dmr5982996pjv.39.1687369856294;
        Wed, 21 Jun 2023 10:50:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a6b4600b0025bda194e5esm9179619pjl.31.2023.06.21.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:50:55 -0700 (PDT)
Date:   Wed, 21 Jun 2023 10:50:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 56/79] pstore: switch to new ctime accessors
Message-ID: <202306211050.969F935BB8@keescook>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-55-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-55-jlayton@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:46:09AM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
