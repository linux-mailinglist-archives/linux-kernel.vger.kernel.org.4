Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41067626035
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiKKROv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiKKROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:14:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E93E08C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:14:48 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p21so4707516plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTcif9FAK1ZGkmzomIK8r/gCq3xMcVIfUb58B9OBtKE=;
        b=poYD0imxGJeJIKeaGfVOTqQreVkMV0Yz/8rx6gVn6IXFpAhzWM+BrHt1OnjUYsu7/Y
         DTjhY9lrITMIlrFXcMJnC2BHsLP/T/fP2o8kT2jb7h3QyBTTYXORvzigC1/Ec00Va0og
         Vk5z54nKSJWZjS2Y2yivCTpBFVRJf2jgYtoR1hJn/RAwDHsW4ZB3XgZ5p1NBmwnoWj9C
         gypWFglJmk9A43FEQwOlKoP3n2RhaCy5EjAEZPw+7bMQtzUYAT+mLMAY6XBfSedq1vCT
         qYsCjVbpzk1U7Wt00A5DQJ059o6Y46qXjltiMNhe6AqRNQKrWmM84rpFr3aeOPVeWB+J
         xXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTcif9FAK1ZGkmzomIK8r/gCq3xMcVIfUb58B9OBtKE=;
        b=3KvTXd7NWQL+Ly1KJG4F6m42JxxquFdR3qWuGdTSYmvhF/UUBcfx/xvxzh1Z5HMF95
         WWaiAw4JLfBBVdF3cAuwy79Wd8XFnHjauoVGWtB0yaP2NVv2QqDgfGv3x/pYz6HrLCbL
         FZeCEY6TeaX/IRlTWtFnlMFNZPgJBpBok1dmAfJTE/dRDdzaz58MAHE8BhpYZeeihRcQ
         MpdMIqZOiLOT9ZlO2QSZ753q5bm1a5PhUeYyJ7hiCAVY+4TFl1JBqme+eZ1Tdyv5OZHa
         qmkPiz948zrIltbCnqjV4lzRv+SD2K+VgIWeqaTRNIxxt+mVmzmi3X/dlEvWvG9XSZ9v
         khdA==
X-Gm-Message-State: ANoB5plwodVC/946UTq0mF1PzC9HKt2zonFkYzEcj93OG/YfTE0GZozM
        YUQ3W2bYWHZrSpfSRYRjCQ8=
X-Google-Smtp-Source: AA0mqf5iNZpM0bpIDzPt3g3jI9YmXHRm56dpUlR6NwoO7jkm71+5c7XRh3ebFEn0rT4dRWUABMK5Rw==
X-Received: by 2002:a17:90a:7288:b0:213:587b:8a83 with SMTP id e8-20020a17090a728800b00213587b8a83mr2853484pjg.22.1668186887773;
        Fri, 11 Nov 2022 09:14:47 -0800 (PST)
Received: from google.com ([2620:15c:211:201:dab:6951:19b1:b46b])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b00186acb14c4asm1985677plg.67.2022.11.11.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:14:47 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 11 Nov 2022 09:14:45 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 6/9] zsmalloc: pass limit on pages per-zspage to
 zs_create_pool()
Message-ID: <Y26DBfcjGvIvjDfq@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-7-senozhatsky@chromium.org>
 <Y2tHq6O9IA3g8Xt7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2tHq6O9IA3g8Xt7@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 03:24:43PM +0900, Sergey Senozhatsky wrote:
> On (22/10/31 14:41), Sergey Senozhatsky wrote:
> [..]
> > -struct zs_pool *zs_create_pool(const char *name)
> > +struct zs_pool *zs_create_pool(const char *name, unsigned long num_pages)
> >  {
> >  	int i;
> >  	struct zs_pool *pool;
> >  	struct size_class *prev_class = NULL;
> > -	unsigned long num_pages;
> > +
> > +	if (WARN_ON(num_pages < ZS_MIN_PAGES_PER_ZSPAGE ||
> > +		    num_pages > ZS_MAX_PAGES_PER_ZSPAGE))
> > +		return NULL;
> 
> I tend to think that creating `struct zs_tunables` would be better. For
> the time being zs_tunables will contain only one member max_zspage_len,
> but it can be extended in the future.

+1 zs_tunables if we go that way.
