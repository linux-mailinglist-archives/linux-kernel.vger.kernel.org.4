Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1A6CEDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjC2Pxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjC2PxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:53:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2734EC8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:53:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so65250451edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680105182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LntU8hVOBoHkWmNhbXV9EpuSAtmMh1BLUhcUYUs/Fc=;
        b=UarrBNY26ZztKIUwGdRk+yQnPoZB7KXyQItg/8WYhN4Tc1EmsG/dTPb+B6H6kEfzYO
         +N6vUMrdBIQRMNFpVbXa1CuCPtCJgFO+nBGwRmonSLEr1okEiAhUTTJSNpRoF6JU7WaC
         gPZWJm6f51W+QzbB04TKCzKdY/tEuKJzm8s03FYGRKNGzXckaadLP2qo4O5vYSrH4wu3
         JI0LwaZv2pd0b9r8zWtC5UVN6Yxr8fvDVj5LF+L1wOlDSuSyVcc7Lt23+7DXGqHMKKoi
         VC0NPDCwTa5E7NVVXOH7RWxII02AakVbCN/H1oCN2Ge5K+yd4ZO7aM5IViL/Fvvpub/Z
         xpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LntU8hVOBoHkWmNhbXV9EpuSAtmMh1BLUhcUYUs/Fc=;
        b=VW2Gu85z2x2gFpr5U8UAWh7aAHXKl3g7urJBj6u5sWT9PNiQ8aXDObqmZx8+TAgKtA
         KYrAAAev0KEsjEKeyAOMmKj3m6YMvxwTbDnscwHVgkkHq3u1O6c4r/wFOcIAiL88qw3V
         qpx7eQZHjv//jCMejrnDO2oQmGT9J5A6jyoAGHxKFhAlWuYC22ggyxVZusoIk4zvbQqg
         zw+B3ayh2xRHRMLTWVtQXvOxD5sVOC+gN6rvh9n36yMAMCHaHgJi2wALgmEgKAU6zCXy
         m56NmQoYtXr6PjBs9bb87SNJovuuzku2cMz0RmyFBx+TiIOeiOYVyu5NrImuSiwHv7h4
         1Mgg==
X-Gm-Message-State: AAQBX9fwe2H5vFZ1sQsov2rWFiK5guSbcCk7ha2ED1xhg19EPBmjriBl
        7xsPGoRgUJi3sVp64zCwmSOdUQ==
X-Google-Smtp-Source: AKy350aY+t3khGRTTDU8SD7Q5r2ZkylsgklRX9fU2HsKe1EXZ8z+sIdAIwcnwjhAdKUdTOFS6KKdgA==
X-Received: by 2002:a17:906:b24e:b0:930:21a:c80 with SMTP id ce14-20020a170906b24e00b00930021a0c80mr20674195ejb.47.1680105181811;
        Wed, 29 Mar 2023 08:53:01 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:e994])
        by smtp.gmail.com with ESMTPSA id wf4-20020a170907d68400b0093f3d12d64bsm5926751ejc.179.2023.03.29.08.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:53:01 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:53:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v4 2/4] sched/psi: rename existing poll members in
 preparation
Message-ID: <ZCRe3FViwj0iHcxF@cmpxchg.org>
References: <20230329153327.140215-1-cerasuolodomenico@gmail.com>
 <20230329153327.140215-3-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329153327.140215-3-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 05:33:25PM +0200, Domenico Cerasuolo wrote:
> Renaming in PSI implementation to make a clear distinction between
> privileged and unprivileged triggers code to be implemented in the
> next patch.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
