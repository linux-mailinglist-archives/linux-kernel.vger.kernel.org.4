Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27DF63B8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiK2Duw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbiK2Duu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:50:50 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763274D5CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:50:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g10so12173530plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwCjVVGhHFD6Udh+pB2OpQrjXihuVZC5jsAaLzyB+MI=;
        b=fdpLrLtD15LEao5sDj/J1KxszT/Qe7YR4Ba3yt6rh5Ihkp80bMAnl1z8zJPs12u6vr
         SwomnLKQ+YMnuWmG/sGhpsmAqtS7EvyrX6Fqg/NznXc8bp05Li05jwulTXDUJmGYlvd2
         ah4hO0AKUiVFp9yVkmV399n2IaN8yKl8/s2xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwCjVVGhHFD6Udh+pB2OpQrjXihuVZC5jsAaLzyB+MI=;
        b=7Alc1hAdSydUuI/Rqx3S2L/zbSMSLWyYcwzpn7YWx3HCMm2pkfgHg/NKWY/I7ZdEpW
         RPXmPBUZn92u4DoGN/ds9Yph7mASjt374/Rio36WbEzJZnLlll+lB7rgsJpT+ywUonCE
         jcsqUI1We+20fS9gAY0mZrRjvC4L6prkpuOAifjkYtS2csul90Tr92irlQxVhpTakufE
         mpCBfq5FwuNx5cOpnUYKjto/HnvXoUeVaR0cH21OejPKqCmDy4CxzCn5r4lEej2wqUI4
         fNiD/BPLa8EiyYMcQpNgtPv014RGSwZyGH/hKVsDgwAigKVYamWebDbYXO6xTP3PdP2q
         LkxA==
X-Gm-Message-State: ANoB5plGJdIwL0WlKZqeJjOR715xZx8eweRe+3STXXHCEcN14ykOjs6s
        1M1VEb2wASO4rqnj0Dzgb0KTOA==
X-Google-Smtp-Source: AA0mqf5708hP0KnPZ9DxgfsBBzbDlWk1ATS3SmCY64IaSvTpJN/10jkdhpxD9xTDHzw/ekU+xuZ7bw==
X-Received: by 2002:a17:902:aa44:b0:189:fdf:a3d9 with SMTP id c4-20020a170902aa4400b001890fdfa3d9mr45778858plr.9.1669693849020;
        Mon, 28 Nov 2022 19:50:49 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:2565:b2f5:cacd:a5d9])
        by smtp.gmail.com with ESMTPSA id l64-20020a622543000000b0056ddd2b5e9bsm8717076pfl.41.2022.11.28.19.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 19:50:48 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:50:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v7 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y4WBlNUGwDfT/odp@google.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128191616.1261026-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/28 11:16), Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
