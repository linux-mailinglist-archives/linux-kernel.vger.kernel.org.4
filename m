Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4970960C2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJYEbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiJYEbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:31:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18A3BC46
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:30:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso8528116pjc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6h1+DjMgXYk5SBvTQFkMhV5avjxJynJWDYxK+h8k8Gk=;
        b=Pi773woPjEWwQNRLqVhtYpX5mNraee12hJP8+dcfgmtDqtcUeTGO3/VrJhfgd/JCOe
         22OIbih2tMxq+gHTCjwwbNnZEbNi+0CGyrb05dTd8JC68xZ0q+NZuN3pen80IFkzycH2
         4ImqFgFZp4buOrtJ3GEmPHJhiAmqIxVQz0oeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h1+DjMgXYk5SBvTQFkMhV5avjxJynJWDYxK+h8k8Gk=;
        b=6oIaBOVNaQjS4Pub5ajsY26W/aDOeDisQXHI2jqQldUnO14OckbcJDNNgb6M6R5827
         cCdZSv0Lhd5Qab+IseFVcnjyhpLaGrURIgFqqiksO+HxwfRPqf7Q+N05gfYMgRXH7KH8
         j0zIBvTtwtAwN1k46O3G20CHZ38IzY/CD2U1hGlL1mZHh1+g5w5k/T0dQBgZCXu9gilT
         A/un9i25K4Uh8BxRDbA8OtAYelU7JG52qsgH48+e3kohFKR5IqiD9AIaxLQIPvPl+k8/
         kJhSuXBOuOwIH3wrsC/Fm8Py6PgwU4NJ6eHcnIzHLmcF+7ZURK9R/Fdom5VqjO7BAc3e
         gRqw==
X-Gm-Message-State: ACrzQf0kCx79ua5xdfklnQ2+lzXHM9cLed34ylUYY+7Gy5vJ550CkpPx
        12GtSnMPFIMeLQYOSqQcX/sxKD7WD40Ldg==
X-Google-Smtp-Source: AMsMyM5bl1YOyqe/Lde+0E4GHE4rT3bfQtkYCoRQfv8rr39CsEKKTGwDRx2h/MfYWOlU84qKhOhmsg==
X-Received: by 2002:a17:902:7296:b0:180:1330:b3c0 with SMTP id d22-20020a170902729600b001801330b3c0mr36042603pll.170.1666672252594;
        Mon, 24 Oct 2022 21:30:52 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:c493:65a6:2d64:1325])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902c74c00b00176a579fae8sm453472plq.210.2022.10.24.21.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 21:30:52 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:30:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 0/6] zsmalloc/zram: configurable zspage size
Message-ID: <Y1dmdycqFTztP8VE@google.com>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024161213.3221725-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/25 01:12), Sergey Senozhatsky wrote:
> Sergey Senozhatsky (6):
>   zsmalloc: turn zspage order into runtime variable
>   zsmalloc/zram: pass zspage order to zs_create_pool()
>   zram: add pool_page_order device attribute
>   Documentation: document zram pool_page_order attribute
>   zsmalloc: break out of loop when found perfect zspage order
>   zsmalloc: make sure we select best zspage size

Andrew, I want to replace the last 2 patches in the series: I think
we can drop `usedpc` calculations and instead optimize only for `waste`
value. Would you prefer me to resend the entire instead?
