Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4066A28C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAMTCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjAMTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:02:42 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381D544FB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:02:41 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s67so15609515pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Esn860/b7q2FuVfCNzZ6mccJ1X/ZkalyPjwmd217Nv4=;
        b=Ery1UMs1jDwUi0O+CXdO2n+YdU/UHLge+mNe4ZmVdYZVyEbilxA035tLhx4HIQxmf/
         HVcCxE9PvQ/niZzlQ8b+a4mdSHwLyyeghuEcEIUR9CV5ug1E6Ld2JYeIGmrEeGdzGoqH
         JBZQbfHTCqJYx0Dkl++j+gVFGIE9rbtOCAyY19r5nuk5TPxtLrztVK6dEHAz4D0oGIal
         zhtqnF/9LWftIrGaaJH6KpABefdUB8pJBOSvJaCLRsGQQtWM662WilzhzqCUVdXW/epn
         GK+yLiw+LmMv6XLJJc1PDKvFL3FAxWcbUr/F8goR5cweMEt11j7ja86Mc0KYCsBnuiF2
         zjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Esn860/b7q2FuVfCNzZ6mccJ1X/ZkalyPjwmd217Nv4=;
        b=NZqoxpCTXp7pZyq53ILvYEHMpqKty9M1kt4thidrBnZ7eq70dHzR1CkPNtBW5dRZhK
         zYe1WN+JH9KKBH8ixCh9BggFaUE6/GViN14FeEL0u1CBPLyAocu0EH6JbyyxBDC7qZEC
         M9TZkgsZbt3/28gEroXL3GnovJEjDQN0KfnEc41WEQ1aFRbiEtAbvFLQjC1r2yP3OqOi
         vI7TpKa4s2tpWd0KiCanGvPAWdZAWMDnlrUFKz2FXEI+/jmSF1riqvj1jLxygsE+Oit+
         C/C3hdtt3gK73oR3dy/1DNSAoSOX55A0WVag22xyvIADLmbj73lgpytqr08EbEfBC8Uf
         sCfw==
X-Gm-Message-State: AFqh2kqpW+ZS1yF9fPYORya+P1iYVrG8IyvLZzcL3OYrtT63+jYsC5l0
        9vZRLelrR2NhaCdQyXQTMsk=
X-Google-Smtp-Source: AMrXdXsTwypi3hXE5837mhpHBU4iIcaBxV7ODjHBBoshttfRO0lfABfRnWVwsVB8sgZjDfQ2Qi9Mew==
X-Received: by 2002:a05:6a00:d77:b0:587:102b:edb6 with SMTP id n55-20020a056a000d7700b00587102bedb6mr22154080pfv.17.1673636561162;
        Fri, 13 Jan 2023 11:02:41 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2e4e:fba:501b:3a8c])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7981a000000b00585cb0efebbsm3572849pfl.175.2023.01.13.11.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:02:40 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 13 Jan 2023 11:02:38 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 4/4] zsmalloc: set default zspage chain size to 8
Message-ID: <Y8GqzpA8G8KOoV2n@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <20230109033838.2779902-5-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109033838.2779902-5-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:38:38PM +0900, Sergey Senozhatsky wrote:
> This changes key characteristics (pages per-zspage and objects
> per-zspage) of a number of size classes which in results in
> different pool configuration. With zspage chain size of 8 we
> have more size clases clusters (123) and higher huge size class
> watermark (3632 bytes).
> 
> Please read zsmalloc documentation for more details.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks for great work, Sergey!
