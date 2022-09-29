Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C01A5EF04C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiI2IWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiI2IWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF8212BD9D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664439742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GvL840Kk8DVZlJW6RhVLU2un7rLr7tAXkBGCR+lZrQE=;
        b=NFfZuHRbVWcL6ptQh504+acJlXnRKpcVjtOJaJyfL4y7HlHu9NXS1Ak2hJm25FhHSBNB2z
        YoE/m+t7m/ZVHxwpWDNzo6nR5y3t5+tbZ9rQLWyDZGXjwN433HL89liO9PLhbtJYNu9eVE
        E4zWd8Y4LzVXP85MYm6v/arBPcunhUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-214-88NvP7gWNgyU4pVso-awVQ-1; Thu, 29 Sep 2022 04:22:18 -0400
X-MC-Unique: 88NvP7gWNgyU4pVso-awVQ-1
Received: by mail-wr1-f70.google.com with SMTP id k6-20020adfc706000000b0022cc19d5dd2so226453wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GvL840Kk8DVZlJW6RhVLU2un7rLr7tAXkBGCR+lZrQE=;
        b=vJ7wd0jBssy5raWdkBmd8FcTZ9jngcj7rpztAUn+BtAkyn97Qhga3k6ztBpMdzmHrS
         uVNFUjS+uUXL1guz5p50zfR5sfQxnw/7OoRz8GCmd2AYeJA7kNf5+ZkWnTfWHbuxfYzQ
         7Ngm7KcuN7huo+dejqtoAYIjPsJQavOcAMozeY5K1KP0FskKTSYJs55vHTOHLnsOZmDt
         NqjzBvoQ6FNx89AFCPdW8GDc9Qcqo0Y30johvLWaia1xWDsouBuJAdLPtS421Qi+XZqh
         atZ3oYLWmDqdqHyzZucAUVdE8VuDmvlu7jZlNj+tXjfe+gLtckNmLvRzwq/Jhz+D1FLt
         xeFg==
X-Gm-Message-State: ACrzQf2g76qFnIOCZGZX7eqIe/pMTn2dS5sXZOxzoxqdwCli2145+Xm4
        K6pcfxqzNBnV7Uz0hQNAvsVG5JWw184Lc0JhGWEtv6sx4E12+ZtDT38lHwHHqe4segPbQXBcr+r
        NbcADHlNsq+W3q3aOQLP5vZE=
X-Received: by 2002:adf:d1ea:0:b0:22a:9cd2:3557 with SMTP id g10-20020adfd1ea000000b0022a9cd23557mr1322399wrd.675.1664439737524;
        Thu, 29 Sep 2022 01:22:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Paxa2225xl2216kWRIszih5KIxmpPHxmbkA9MH7KHLBii/qgGz+O5Ynrk5avN7HVsCEPm/A==
X-Received: by 2002:adf:d1ea:0:b0:22a:9cd2:3557 with SMTP id g10-20020adfd1ea000000b0022a9cd23557mr1322386wrd.675.1664439737376;
        Thu, 29 Sep 2022 01:22:17 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d554f000000b0022cc7c32309sm2331237wrw.115.2022.09.29.01.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:22:16 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:22:16 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Rafael Folco <rfolco@redhat.com>
Cc:     frederic@kernel.org, mtosatti@redhat.com, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        atomlin@atomlin.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 4/5] tick/nohz_full: Ensure quiet_vmstat() is called
 on exit to user-mode when the idle tick is stopped
Message-ID: <20220929082216.vbkyzbxhsq2ixjdm@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220924152227.819815-5-atomlin@redhat.com>
 <CAOr2xH5DjEy7agHYx=5+4cr+OeJz52HUeUttkF9ueS8JHbQMFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOr2xH5DjEy7agHYx=5+4cr+OeJz52HUeUttkF9ueS8JHbQMFg@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-09-27 13:17 -0300, Rafael Folco wrote:
> Tested this patch w/ nohz_full setup and oslat 8h run on isolated cpus, max
> latency is 7us versus 15us without the patch.
> Thanks.

Hi Rafael,

Good news. Thanks for the feedback.
May I add Tested-by: ?


Kind regards,

-- 
Aaron Tomlin

