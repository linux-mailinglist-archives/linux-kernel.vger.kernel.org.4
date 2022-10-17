Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98D6016C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJQS7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJQS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:59:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20091659C;
        Mon, 17 Oct 2022 11:59:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y1so11947691pfr.3;
        Mon, 17 Oct 2022 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3RkGrHNe93O2flzkjupVhNGIrEtZ8P1Kjmylh1rqio=;
        b=N+6GXjhofhL0JSlnFggN2e++RV40vyvsRNMMsB8NsX2MDeoao4xxykN150qKtnS9rd
         0UI1mZDdJW800saenR1acJv90FIIlPHKdlOnnrOoMHDPgi6B9JSRspSIOBq3tdi126e4
         tbajueFR1PvvJeTbpvuO3SUTHHlv/64ZJIoxyawsHSP74c39egpnTjIwBTxeF5ZFj8na
         aa9b8BH8LTf6LHhp3PseQr6Gtsji2qSxmjIn5rHj2HguUXTO+pMAwm5Jv/t+VK3574sn
         E51PBMrrqz7Wla/sU5CjhGQyTdE0YjMB9P+zmJgOyU/z/sYP8ZhS2onKdxsnL+LS/vJ2
         /bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3RkGrHNe93O2flzkjupVhNGIrEtZ8P1Kjmylh1rqio=;
        b=geuV8o5SVTPSSEjiPmmBKH3TE9scXwb+3wkTMt7s/RqvAHpglyirEJJPcoku9Ze0aG
         AIqoL1sXuCLqLP+XAQYbAs+RsdoJvo77NW5as//oE5iLNg6WczuELJIndtNIxn76067b
         K8W3fLRnOOA0rNNrtp9kSI9V9qaiEX7O1TdjV3Vai81QTj8m/jJM4QS1RH1TCklvhI+q
         U3ukgcDZ4+6xkadEpkEUWgkxa2C5xV+S4/m6wzUPpIZjOriRo6hK8pz4VCgp8aYpZ9fx
         HZ6GMPVVkvK8sj65ECnc+dahS1Y7+tT3UxS7j6+qbaorruBbRLNBE3GKkJZNLkH2NTcs
         RgUw==
X-Gm-Message-State: ACrzQf2Eun9UT60azXVdXPETIp8YSE5L84tBYWVGZpLgEjkQiTFuiETH
        DqciYb+9oC1mOA5wOzxrJsPxfWtyvi+D8A==
X-Google-Smtp-Source: AMsMyM4jwRbAj4ijIbXLyrc9djP9bh43MbTriGcY1NlPtlwKAWghvbtUkwQoVfzuGUhAy2u3ZO6mqw==
X-Received: by 2002:a05:6a02:18f:b0:44a:3972:898d with SMTP id bj15-20020a056a02018f00b0044a3972898dmr11748664pgb.525.1666033183400;
        Mon, 17 Oct 2022 11:59:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00174fa8cbf31sm6882461plk.303.2022.10.17.11.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:59:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 08:59:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-iocost: Reset vtime_base_rate in
 ioc_refresh_params
Message-ID: <Y02mHfatp0FZI650@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-3-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-3-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:05AM +0800, Kemeng Shi wrote:
> Since commit ac33e91e2daca("blk-iocost: implement vtime loss compensation")
> split vtime_rate into vtime_rate and vtime_base_rate, we need reset both
> vtime_base_rate and vtime_rate when device parameters are refreshed.
> If vtime_base_rate is no reset here, vtime_rate will be overwritten with
> old vtime_base_rate soon in ioc_refresh_vrate.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
