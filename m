Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC868005F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjA2RLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2RLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:11:20 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF01ADE3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:11:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id dr8so4270771ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94W74mHvDSg/R/IAj9g8qxZMTlIKl8dtcZLqaYqBeFc=;
        b=ZtNPxR3dpiWaX1UNv2uCtY9Ru5vsgnpzRhtw2g8bK3sc0oLqIEmkgaS5lSjqyWfE7q
         F199UZbQbxG4KdGXhWIy1fSy2DVpes/M5HGksOuwLo8q6D9j8sDDFfTPUuTATguh/Vyl
         +qIK1J/kOdOx5SDoY2fq+wqKsL1zxCKIlInb5r2OpMJwY3zParwtGoR4mDGTeay9USaN
         3PB4IjLE//MDYnwoq91g32+sTnIl+SSXWxJS0x/YYdm3EYfFp8OPRLhxRxJBl0Xy6Cr/
         4wDlIX/zJ25Rl9NFaHJcCrSU8HukXDLYXjvDOGm63i8674kOOpDvUtA/5uO2RGEz/yeL
         t+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94W74mHvDSg/R/IAj9g8qxZMTlIKl8dtcZLqaYqBeFc=;
        b=72aBuwy8Qc+YpsPOnSJvUEEc0al5Dq5S7RqWNofHuj4rGoQlsCIdRfK7xbUa12PLY0
         6VN1VDvlDPAL5ekJ44BbySlYHnrRqu+BJBPqn6+mY/YDgm/Lhn0aZXpbPUwkIAT7MzK6
         32zBiTBWyDVd30zySIaggk9l0lgm21DuCBNF1QKwDVKWMkeIJb/pZa0NZaZmbOOCCFf6
         0U8UCM1CgrxQdZDxFRre0JudT6VIkPdtROSCxLGfq/MSHks7IsP4tu+6mT2BIooNX8xT
         8ky+25ZPCM6R699/kDOnXUqe7Vq6BjHP5dXkRzzM7NVAS3PczXYaipJRTVEQ0OQAh2g0
         F1nA==
X-Gm-Message-State: AO0yUKUmjAB0mhxQXOUyWXH6kZ5uB+1z7ZU6R6FANtU35W4aXVRYVu9T
        vetl6mrj1vK7IpSpSCOFRtU=
X-Google-Smtp-Source: AK7set/+YzZebpzZzbPohtzT+15bMbpoTDUayMI+fjN47dm5Vqy+lO7GyCTnPZCvvNy25mdhiQS8AA==
X-Received: by 2002:a17:907:93d6:b0:87b:a1ed:4a57 with SMTP id cp22-20020a17090793d600b0087ba1ed4a57mr9363909ejc.16.1675012277269;
        Sun, 29 Jan 2023 09:11:17 -0800 (PST)
Received: from andrea ([217.9.231.172])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170906f9c800b007c14ae38a80sm1870884ejb.122.2023.01.29.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:11:16 -0800 (PST)
Date:   Sun, 29 Jan 2023 18:11:12 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9aoA2UxvWyNwOtx@andrea>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason why Wx=1 ->ww-vis Wx=2:
> 
> 	0:Wx=1 ->po-rel 0:Wy=1 and po-rel < fence < ww-post-bounded.
> 
> 	0:Wy=1 ->rfe 1:Ry=1 ->(hb* & int) 1:Rdy=1 and
> 		(rfe ; hb* & int) <= (rfe ; xbstar & int) <= vis.
> 
> 	1:Rdy=1 ->po 1:unlock ->rfe 3:lock ->po 3:Wx=2
> 		so 1:Rdy=1 ->po-unlock-lock-po 3:Wx=2
> 		and po-unlock-lock-po <= mb <= fence <= w-pre-bounded.
> 
> Finally, w-post-bounded ; vis ; w-pre-bounded <= ww-vis.

To clarify, po-unlock-lock-po is not a subrelation of mb; see what
happens without the smp_mb__after_unlock_lock().

  Andrea
