Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740B76EE7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjDYTAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 15:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjDYTAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 15:00:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284BCC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:00:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63f273b219eso2856949b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682449203; x=1685041203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDX3WVDeqV3T2CMpRikgyumVKXfy4cO/HBX4zWdU/4Y=;
        b=IrY9DJlAjr/XA8zSmpi00Z8vLPQUeFykPjlluI4fcd+k8fqmZnLWeUjd7daC1xoDR2
         /ToKMhEiCsFuurTjbCSGjSHLTcaQTzYlam4EGYM29R744AnzHNqNhL4M9S4DlaZe/Dat
         Zq08Ro2LlkXmUGpD5PRkg9/RQzB30O04U9/hjn9+gkKySvHq4sJl+sLkLX8P2W4WmFgl
         BJvqR+1T+vuRQBbSmIzDfltArs7HAoeKIL+RhGs7L8ov3pgPSX/4SPoVTsqMoTIV2i1q
         RMCwkEyj4ibGT0HUEROf/mClOt7TqKyQACvwXnPCmFVmdg8j6flIiWp6ninvq/587X8m
         HyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449203; x=1685041203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDX3WVDeqV3T2CMpRikgyumVKXfy4cO/HBX4zWdU/4Y=;
        b=SuPTsMRtJR6gphVuQpT1Qpb/ou6QH0rmkw2uJvLZpRKu/6jAvgivrlUlrnvA74MjYR
         nHvZWt8xYslMVNAFyP6uBJftzd4Wh8fjRi++/zeulzBvtoEfJDKekSsr887CT/GYqp0/
         a9+FHbtATyxWUwkGanvoJF04F7VFFzjfwt5busmAqnPxCJz/q3+8a8dDkQeiE0dD9N2F
         xHcWisBBncqOWyrbgHhrIywLKy2gdj6Ptz/fJqyZc/FGM5i5eNhIMvvxmK67q1KgNKoi
         ZjNbkQGZgDXXm4l9pS22T9BANA0Pg7jyY4xwDXd1Xs/Vl/6yTATxT+799hmmQwyKSxRa
         n6ZA==
X-Gm-Message-State: AAQBX9cNeHuXK2SqbqsAIPsM8kS555yIOYQD8HzFcfstrSZ3zz8rk0tL
        V4M6DgDjCIzjCZQnbyftK6OOUA==
X-Google-Smtp-Source: AKy350bEnT4LPQRT0lChSkm96hkstaSHWDrosJq0F3kc+fqUDHosmco4GuQCehFgoD99+Ww12oUI6A==
X-Received: by 2002:a05:6a00:814:b0:63c:1be4:5086 with SMTP id m20-20020a056a00081400b0063c1be45086mr26711939pfk.6.1682449202660;
        Tue, 25 Apr 2023 12:00:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b200-20020a621bd1000000b0063b1bb2e0a7sm9516895pfb.203.2023.04.25.12.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 12:00:02 -0700 (PDT)
Date:   Tue, 25 Apr 2023 18:59:59 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH v2 2/2] Binder: Add async from to transaction record
Message-ID: <ZEgjL3giBNMA3zUH@google.com>
References: <cover.1682333709.git.zhangchuang3@xiaomi.com>
 <0c1e8bd37c68dd1518bb737b06b768cde9659386.1682333709.git.zhangchuang3@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1e8bd37c68dd1518bb737b06b768cde9659386.1682333709.git.zhangchuang3@xiaomi.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:05:15PM +0800, Chuang Zhang wrote:
> From: Chuang Zhang <zhangchuang3@xiaomi.com>
> 
> This commit adds support for getting the pid and tid information of
> the sender for asynchronous transfers in binderfs transfer records.
> In previous versions, it was not possible to obtain this information
> from the transfer records. While this information may not be necessary
> for all use cases, it can be useful in some scenarios.
> 
> Signed-off-by: Chuang Zhang <zhangchuang3@xiaomi.com>

Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks
