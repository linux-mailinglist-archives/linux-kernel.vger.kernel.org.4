Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB15EB404
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiIZWB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIZWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:01:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2FD70D1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z20so576211plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wU3T4FjaU9qDfVJPctHKYbqwT9poMiNECQZXFxXpthw=;
        b=NpMtrDRZOXiB0xUb1TtKFQTAvPuh4asn7d0bK8R3rbFTShInim3HcHlWpa98Lk7J8e
         9878xE/E6Ib4yZnFyXBhnCE+7wCuMQ6kfgTjahcmfbxLCDNnpRMweeXz7uoCcywzIXR8
         ru37hfNCKOUgEFCCc8u29FBz/d0RxXPlz4xnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wU3T4FjaU9qDfVJPctHKYbqwT9poMiNECQZXFxXpthw=;
        b=TcwC4oY9zwxgVfd1j5atEnEdH+xpUvcAs1sP0LOoKNf2gAvAmNA+D7O4qFGjT6xMHl
         367WVsgrgarD6zv9rxwsrLs4JRI1hbvV9P4lardBv70S7yqmIQj59GOfj7WE3IrBUUqH
         U2vGI7v4/P6IpgVFIXYyy1fGsVqLp2zOlA/W2RiEQlKDiD/OCHsGt7oYgb5BHTmxx/pE
         3yLVy3SH7iwyI3LD0OrPjj11yrJIXLVI7+L+bvsztHJK76UUhFRpbjbJzswX8LuuETlT
         ZTzaeBeUOYwaReNhjcCl9r3pH3Pj8Vud/onq8QAIrf1VQiyHdMn6ccDVTSN/9lc1+G9i
         MEOw==
X-Gm-Message-State: ACrzQf3hHRf+rT2KDJFpiPOcdVMcCglktygG6GC9+FjQ1PQR6tbjzs19
        RlmhROtuWBBWMcLbWOCeH+2mWQ==
X-Google-Smtp-Source: AMsMyM7lWbAH8ThnXEDFlwVQ/98rO2TnRsqVKkIvvgMC1lr8gdwsVgpsJhLsEH1PLYkt0s8t1dKdKw==
X-Received: by 2002:a17:90b:4f4b:b0:200:876b:c1c8 with SMTP id pj11-20020a17090b4f4b00b00200876bc1c8mr966306pjb.32.1664229681755;
        Mon, 26 Sep 2022 15:01:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090a74c400b00200461cfa99sm7004676pjl.11.2022.09.26.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:21 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] can: ucan: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.12780DB3@keescook>
References: <YzIdHDdz30BH4SAv@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdHDdz30BH4SAv@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:43:56PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/214
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
