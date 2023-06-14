Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9571F30B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFATgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFATge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:36:34 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D7D186
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:36:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f80e055549so9512781cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685648191; x=1688240191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMBOA4WH9GmX8va2TeN6IF1hKckQ4hk2vM+qJu7Yuk8=;
        b=JKQScWQlepZwk1rwr8D4B8rhFPkzPfrRjo7oBWfw+nEP9EfqxAcT+QW4osjwPhmT5Q
         ZQV6JWXs8rJRB3wOSil33aA6VH95iOYN6NoX5pyxPzvm5t4sMk6BhLLDlzYUm0BDj51b
         NzeK/c8Vw1d6f0CTxvogTrH8Jj3bZjQMBYb3ccX2/bMjCwpvFGw6aikcmLyNiBcs4KEU
         czOUcxsiQkOFgG8W7JYe0fmkQADh9wc7yDtbyUxt+Mn4vHqjpz7R6q6mj9tnNkmcZpcb
         6qOD1px5L7EOtewVnd2LWHez4iP7SCtbcRjjzfJCt5Ov8Ju3NzRD7iK3yEysqmi3RAWk
         z6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685648191; x=1688240191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMBOA4WH9GmX8va2TeN6IF1hKckQ4hk2vM+qJu7Yuk8=;
        b=NbnQDMQix7dbhvzilEq0K5yjtUDKUr/YnYrSC1LY4PpXOsmr3rjBX6Hr8wxGZKZBHa
         v/5PIrNk8vogvL/RZv/BSa/yr+VmfkdFgHANB9joV84qAhZTaZbTTvuYbIm/m0em5dd3
         hlSF+SFQEjOkSAzZWq+RZhQ344Yg7TpAeQvZnvW/xQ2dq8mom7Rfk4T4Z5rV3UI0cuXh
         6acLKdKEnAKeyLT7QVFN6+ZdfbbW2S6z/SiHyx/HDsIvBntIMOv0+Ove/S3NjUE2usBp
         0MQHypzbKhRACsrR3JqLWEVPspNCUByceUlO5T65Q8nArznYfXYYhmmXDGpGVEIU6Qyk
         Gxog==
X-Gm-Message-State: AC+VfDzIaczX0TQdV1eRDyp5b4sKQ8mkWrAyNmCMr+fTw+8MmUoGivOC
        Fy1hv07YMGhRo6cqW11+L05KHg==
X-Google-Smtp-Source: ACHHUZ7CZ13+q3p59s8LZm39fYm6itDCPooJs/hGoBcJsKdzQMerh2esQX0ar5jZ58mA8fqbfZLxrQ==
X-Received: by 2002:a05:622a:4d:b0:3f7:fcb1:3153 with SMTP id y13-20020a05622a004d00b003f7fcb13153mr11551235qtw.30.1685648191239;
        Thu, 01 Jun 2023 12:36:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8774b000000b003eda962ed24sm7973574qtu.22.2023.06.01.12.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 12:36:30 -0700 (PDT)
Date:   Thu, 1 Jun 2023 15:36:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Clarify usage of memory limits
Message-ID: <20230601193630.GA157732@cmpxchg.org>
References: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:38:19AM -0700, Dan Schatzberg wrote:
> The existing documentation refers to memory.high as the "main mechanism
> to control memory usage." This seems incorrect to me - memory.high can
> result in reclaim pressure which simply leads to stalls unless some
> external component observes and actions on it (e.g. systemd-oomd can be
> used for this purpose). While this is feasible, users are unaware of
> this interaction and are led to believe that memory.high alone is an
> effective mechanism for limiting memory.
> 
> The documentation should recommend the use of memory.max as the
> effective way to enforce memory limits - it triggers reclaim and results
> in OOM kills by itself.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

Yeah, this is quite stale. How this ended up working in practice is a
bit different from how we initially conceived it.

Thanks for updating it.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
