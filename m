Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964F2630F85
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiKSQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiKSQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:39:06 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E0553EFA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:39:05 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 8so5490359qka.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXZa3yham7LQjkFxwlwbANAnqcPLbUrepQwS5mjQX0o=;
        b=F1QoWU/3dbOxgcJjwF8lNKPJAum7Fr4uX48L66l4QxIIUQzhIyYBbL3ib/LwHKD130
         uT+Q81r+hQl0x3DJ3yGZP7YgyENSXoK/L4APFW9GL+rbY5xrr4Gp/kaorWNHD2cbGFc2
         reZYcE58RZEBJu8CMIZhc2ypZqPKCkcVHk/Lwz6xTUtEd42eoUhn8Fu+H07S5Vzeazjh
         Limq0jXVD67IETUdQwrmBMMUvjFBHeSR7ELc3yS+pB6OmUIpKktW/mKvBHR9TeY8/287
         7A5w/3hQuEbYYrPS7CybAS6tU+qUsA1a203abx9NczDCTXAafi1+m2fGOSt4KF6vP1Eu
         nrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXZa3yham7LQjkFxwlwbANAnqcPLbUrepQwS5mjQX0o=;
        b=gxTDrdTkhSRabfcrJ303KAqB+s9uqvU+DWXd27pB2KdKesenm5OeGJK0QlJJRZLgC+
         rXW3u2lpE0YO5ELZwqS3mpoim4nwCWHQQWbssAWloOG9DI0qJOGBXiF82tMxOfAR876h
         soacmXz9GcdRy/fntI3H88jhL5B6DMBfZvhMcnogI4FhkYwIcLmKTxAmd+zEaf3rOBHp
         sbZcWzO9KIafz1DGyPve0wPaDZ8GajTs6mp1rMn5U4ZbLElr2xMl4VljevpXzwfMohS3
         1nyq8xnY0uKLNyQAOQfOKqJoUReenS7/VIwIEQ4kd+lbWkzauTqoNgc1mWDdQIKthmlV
         gkkA==
X-Gm-Message-State: ANoB5plIeyDiYEkbGvPhjrkkKGCYPr9ZIVYgb6xyKBjsW+4loq54RhG1
        e0V42Y+6ipHXSOfv6BPGnt5ucw==
X-Google-Smtp-Source: AA0mqf6K6Pdgb4/27H4e5lun9cB6uIBEvVz2DYcRt062F8AkYfOh0Nm/bDT2C3s+wxK5UJjHGvNrvg==
X-Received: by 2002:ae9:f807:0:b0:6fa:330f:85c8 with SMTP id x7-20020ae9f807000000b006fa330f85c8mr10093388qkh.127.1668875944343;
        Sat, 19 Nov 2022 08:39:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id he40-20020a05622a602800b00398ed306034sm3996637qtb.81.2022.11.19.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 08:39:03 -0800 (PST)
Date:   Sat, 19 Nov 2022 11:39:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 5/6] zsmalloc: Add zpool_ops field to zs_pool to store
 evict handlers
Message-ID: <Y3kGwF0BENkuJnS3@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-6-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-6-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:15:35PM -0800, Nhat Pham wrote:
> This adds a new field to zs_pool to store evict handlers for writeback,
> analogous to the zbud allocator.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Nice, much simpler. This should make Sergey happy too :)
