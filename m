Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E36672849F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjFHQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjFHQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:10:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9311A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:10:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75d46c7cd6cso61429985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686240604; x=1688832604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Loo5qde1he69f2u4i/ib9ZVM0psMD7Cg0M9AatqdFv0=;
        b=aqqlosKfbPjKw/3gdBd2lQ7muprhCLsHawg3f4IEwYAKT/Q/itA1SQba/NYMZGYD9R
         xByoMotkQ5YSr3smggHQRSUbmzsdMAbf02yCN/Mhm6mz8WQzdkQSQWhYdBByBGWDT2gQ
         J8MXMovb/38C4r1QveZxusv3xE43gRWXE/y/5w1tQFj5VWhmY91XBGwsWLxBqyX1VCqq
         9cvUg7fSyMgxDp1kYNUxpwBPzjwODYSinR7UbCGP0ydkvL8SP9VD/npfh8ejuRmu2x/3
         6+IybunedSIMYu5nrUJvl1WrNfQ7oq3wtakVljkD8f+KYETinQm55Gjjoj/aosJsFkO5
         DLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686240604; x=1688832604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Loo5qde1he69f2u4i/ib9ZVM0psMD7Cg0M9AatqdFv0=;
        b=O+NpnhzqgzlB23rKfAyw1Tdk04xT3q0kK/acjFzyzbxCuHulitfN5u+vvXgH8rFPVw
         qQ7WnpDTbU3dv7es1a5Wge/kiBEUUdlo5HESPZ+nAwin3vj24ADsGfU+v/kwx873GHyr
         uV2WzTnalKD2XRr9nxokip25vjOIV6ArrhN9NIY4MHv+Phf4z6E0LCuXfq2UAb0il1W+
         yPyR7YALMT617msZoQBV0j4Fmpdb2K/juP1mrVcxj5a7ligmPdrnAuSmyujEcyoEf9Hj
         475uHO5fpMI9vhkR7EuZpkfoH3noxSi8vP7BHfWERMT79EwjYHqC2vKZnGJV0lJRtb7k
         vEUw==
X-Gm-Message-State: AC+VfDxPEkunYlK2d9aLE2Y1L4p1wMopvKySzTo3l4TZNatFkSDWbc2y
        dPKLkYQZUflTfCN+UKXUpO37Zg==
X-Google-Smtp-Source: ACHHUZ7mv0riOE/OFmjTpYzXkTHyDiyj3eH4VJr6BV5clO7YGWIkdpN3aq6+yAf4fKZ4SWED3zZGBg==
X-Received: by 2002:a05:620a:8086:b0:75b:23a1:8345 with SMTP id ef6-20020a05620a808600b0075b23a18345mr7447418qkb.64.1686240604100;
        Thu, 08 Jun 2023 09:10:04 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a15cc00b0075b17afcc1esm409106qkm.115.2023.06.08.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:10:03 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:10:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 5/7] mm: zswap: remove shrink from zpool interface
Message-ID: <20230608161003.GE352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-6-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-6-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:56:09PM +0200, Domenico Cerasuolo wrote:
> @@ -40,7 +36,7 @@ enum zpool_mapmode {
>  bool zpool_has_pool(char *type);
>  
>  struct zpool *zpool_create_pool(const char *type, const char *name,
> -			gfp_t gfp, const struct zpool_ops *ops);
> +			gfp_t gfp);

This fits into a single line now.

Otherwise, the patch looks great to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
