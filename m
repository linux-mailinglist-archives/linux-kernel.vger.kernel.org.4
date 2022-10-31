Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27E1612F62
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 04:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJaDwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 23:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJaDwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:52:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFFE6148
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 20:52:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso14778077pjz.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I21cCJCWzwa8h49wcXGzeXQhOZvvflCzQcd6UuE2zWU=;
        b=KL2LH3b4va5k6gTuWpyglwWk9uIF/pxPF8vz5wfF9STqAI4VNHhFwJbnm7iv1gD+wQ
         DLtFxxalLnDbYfw7+9J6SOiCGvlfIIZRgsJ1cxb8iMH77oElt2+eLpXxIeJOTFzuqjI8
         hS8E6st+Bf0kXUaz0uAJmS/WtsnS009LRV/FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I21cCJCWzwa8h49wcXGzeXQhOZvvflCzQcd6UuE2zWU=;
        b=OFVuEIIS1ZiC5nNldRVcAG4VVqmBSNuqnFef1tPO87umUpkX9X2R+ke6jFnMHyWMR+
         aeFZp9zAKgGMWDkXr4MKnGY32AJbEIowJFtuQ/7r7qau86RH2TfuId0EREYHnRLmlmzJ
         L5gXEWrysa9EjlKAnDwheLTOeugA4FbJwtWdUK1OVpDhI8tDMzmPm7OicSgDKBgnN/QM
         DPAzuxhXYBuXTA1xCpeKCJxl7Vf5I5qMygB2MXv6+LB5ycF6c8p0/FWaGxgLgzVyY2nD
         SBHHFiV1n1+AfQgQukGn7iTggy6qO6qQP7x74vhdSDpIOqZdZfngH5h2L7K+n4azmSkQ
         a1lQ==
X-Gm-Message-State: ACrzQf1ir8dQy+pcdww/IhMxdSbDHeQ3C/AdZvy23d5VgDkOXqbieCkT
        RUR5PxUkQfNo0SlwDruexuDpx66Hqik0Uw==
X-Google-Smtp-Source: AMsMyM54jFk2mBz/o1yRYVtXbsqLJ9pdocTsGFyRkYXG7q/qQDt4mJ1zt+SM1g7PD6l1nI+/2Xm7Hg==
X-Received: by 2002:a17:903:40cb:b0:187:1d3:461a with SMTP id t11-20020a17090340cb00b0018701d3461amr11960773pld.155.1667188362334;
        Sun, 30 Oct 2022 20:52:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f624:9e85:ec7a:fa29])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090a294100b0020d67a726easm3120676pjf.10.2022.10.30.20.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 20:52:41 -0700 (PDT)
Date:   Mon, 31 Oct 2022 12:52:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: apparmor: global buffers spin lock may get contended
Message-ID: <Y19GhTg8Q/3ym/VD@google.com>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/28 02:34), John Johansen wrote:
> From d026988196fdbda7234fb87bc3e4aea22edcbaf9 Mon Sep 17 00:00:00 2001
> From: John Johansen <john.johansen@canonical.com>
> Date: Tue, 25 Oct 2022 01:18:41 -0700
> Subject: [PATCH] apparmor: cache buffers on percpu list if there is lock
>  contention
> 
> On a heavily loaded machine there can be lock contention on the
> global buffers lock. Add a percpu list to cache buffers on when
> lock contention is encountered.
> 
> When allocating buffers attempt to use cached buffers first,
> before taking the global buffers lock. When freeing buffers
> try to put them back to the global list but if contention is
> encountered, put the buffer on the percpu list.
> 
> The length of time a buffer is held on the percpu list is dynamically
> adjusted based on lock contention.  The amount of hold time is rapidly
> increased and slow ramped down.
> 
> Signed-off-by: John Johansen <john.johansen@canonical.com>

Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
