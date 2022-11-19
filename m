Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D78630FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiKSRej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiKSReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:34:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCD61705D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 09:34:14 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ci10so916955pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzW1WDW1B0HE1jRCXoewb98hjNRzjSs0BS5xSZbsGDA=;
        b=BuwSOAt3OcZxTLX7RPNeWY53zRDgTOrQ41tmc56R3VngRP/XPlJoPbK4EMvdITAB+l
         tEl8oE0PEAg37WfOlOwdzGQGLK6yfQBdz2W3Vo+e2TdZxqyG89NIN7n5qPX/bKnqvpOw
         bxoS83RFZkd8wP9h4d3Dl8bu/M/oUTWOR+/mlWFOfZchxmalBD7+m3LLP3/GTb7eBNHw
         P58Jiy3f6bI5jniLlL8H9oy9VW+21I6kt27VLibr3pZunORG0UQAfDHxWsKWBrS/9iSR
         E8usrreM36jU0gWYOpt9HE0zKQ5Q1QLwM/7DiSKREN6bxQim1ewevJYQh8VCldWuAK7z
         Ldcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzW1WDW1B0HE1jRCXoewb98hjNRzjSs0BS5xSZbsGDA=;
        b=Uc9FTazJlbjKXED+jBqfI6t+bP+SenF9Ay6Tf5V7rXHRgwyG6EduELtDMxw4Qvk1HQ
         TxsuwnuQ79O0UloL7ngA8gyVenMq9G0ixzo1pIikGpWlHvg0Imf+iDQg5G35YTGjzHrd
         xor0CgiBzEhT5sGvhkU+Fb/IRbOvwsXigYvz2RFkuSC5N6Li3pG79YQEX7Qwd5VsPzkX
         gOj7F0SQLPt+JmJvsJ7VeTSnj5KBF9rP1KYWIxkp0nxPaNYXS1clQugOePv95xI+MQ1t
         kzKBKipFkMAl0Wt7WEwSliRS53q7c4z+hfi4v3OCd1uR2Ip0hqiVyBRLkhDwnp4VpjHR
         1j8w==
X-Gm-Message-State: ANoB5plJP3V3zOGXebucvpZHniJ/6F+JX6OArzYUKak/hjmNKaoUEqna
        eJCwPAzdd7q7i2aqqUbKJag=
X-Google-Smtp-Source: AA0mqf7W1FZiY6/XJNR0Zd3Ay9ADN6vUr6wWzJmCrJSEvZlx0WePBxLFrejDtcTVlOexPDVUKg2vFw==
X-Received: by 2002:a17:90a:de0f:b0:213:1143:9886 with SMTP id m15-20020a17090ade0f00b0021311439886mr13360381pjv.236.1668879253509;
        Sat, 19 Nov 2022 09:34:13 -0800 (PST)
Received: from google.com (c-67-188-95-58.hsd1.ca.comcast.net. [67.188.95.58])
        by smtp.gmail.com with ESMTPSA id z14-20020a65610e000000b004768b74f208sm4694608pgu.4.2022.11.19.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 09:34:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Sat, 19 Nov 2022 09:34:11 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3kTkw5VrimZu+mU@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-5-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:15:34PM -0800, Nhat Pham wrote:
> This helps determines the coldest zspages as candidates for writeback.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
