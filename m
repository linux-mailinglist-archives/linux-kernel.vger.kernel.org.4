Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329B5BF26B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIUArn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIUArk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:47:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E99279A4B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:47:39 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 207so4363475pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=s1FOrqjygEbmu0BmCIrL35SMFO1fwNdkg4TnmgX4fl4=;
        b=SAaPUtusg1LzZcGU9ZnR3M1upMfkGwiaJwVJ3/I7XD5XjhDTbqslZXkzkzzqWgu+pJ
         OoAOSWZl9/nqOdD8RaF9bcjjp+uPcWoNJB0FIK3vUrt39xJRWtJzXo40TVno28hbH2RP
         46Dk8AVbB3hyI/JEVK6yZ1T3FWPTvcaVzCjWVZJndFE5vbtaV70fWsbqIep2zvbupGW4
         LQ1vPV8wOfGH4dXmgMRU1HxUeH1IIPhcpwGi78a/3DKtb1EaDxTIL+WXwd3wIHWDIHNc
         jm00G6AXJvb5j3STs+NJTW0k/oOSyzsPx3u2fyprlGgvZkTtoPo9BWlJphcU4FYKFMfp
         pNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=s1FOrqjygEbmu0BmCIrL35SMFO1fwNdkg4TnmgX4fl4=;
        b=GUilcJ+NURjMwNMv0uUN/gelFkuO7Pl1gAIDnhX+Jwn/kQlYGqQrX81A4ZfVFwyxEn
         YS3wBSU3lq3W1agl2caWbS9ULvZbut5b96uDsl/N/mG1ArN3EuUiQ96y5BqxPjGjX9xV
         2Shp0bp/Xp2XEFUjsvzl1EsSoB5zG1zLQiKejFs2R/PpBI0WX4nYmedScKUrjHrtd/2+
         RxSbJtkYbNDSfLhL6TWy6GQ2CvV+GE7oX0UZBzz5YsJlZOUMPpeOZBzcT2Zvmx1DuSaD
         NJ/P5RjaFbox+RQtTMq1rlnKxY+wy9/hwCPI13tJwlxxzan0zCnmxBU3uwflUovlOLDp
         J9eA==
X-Gm-Message-State: ACrzQf2iz1IPV3ePizoRTWe8LHwsOrnGBaF54Ir2Z4SqnY33Od5o0W2e
        w4ZndmKgwGDQduq9SeQnIS77Dg==
X-Google-Smtp-Source: AMsMyM4bmTabaLi0slG7jDIme09E1tBWgonZt4SU3dt9++j/WqgfVYMol/lliXueln/j7tPvuUVAQA==
X-Received: by 2002:a63:ee09:0:b0:439:d27b:3c77 with SMTP id e9-20020a63ee09000000b00439d27b3c77mr17326929pgi.579.1663721259022;
        Tue, 20 Sep 2022 17:47:39 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:c6d4:8998:edf3:9779])
        by smtp.gmail.com with ESMTPSA id 38-20020a631466000000b00419b66846fcsm538972pgu.91.2022.09.20.17.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 17:47:38 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:47:33 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YypfJQqj8PeOp8A4@google.com>
References: <YlkkGpVx8rhcsBot@gondor.apana.org.au>
 <YllALIgZcQJ6asdA@arm.com>
 <YlllpH+PB8XVUn6h@arm.com>
 <YlvLqkIdrCp/rOsG@gondor.apana.org.au>
 <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au>
 <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com>
 <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtWeJ12GI7LxQ4IK@arm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 06:53:43PM +0100, Catalin Marinas wrote:
> So do I but holidays get in the way ;). I plan to refresh my kmalloc
> minalign series at the end of August.
> 
> One significant change I have though is that now ARCH_KMALLOC_MINALIGN
> now goes down all the way to 8 and using swiotlb bounce buffering if the
> DMA mapping size is small.

Hi Catalin,

This sounds like a good idea for optimizing kmalloc's memory usage
beyond what this series originally achieved. I'm sure a few other things
have come up in the meantime, but I was curious to know if you had a
chance to get back to this?

Thanks,
Isaac
