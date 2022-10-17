Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2342D601705
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJQTKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJQTKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:10:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A74DB2A;
        Mon, 17 Oct 2022 12:10:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so11835704pjo.4;
        Mon, 17 Oct 2022 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXrfwd7gNNvp6Yt0u4EpnteM52pQoIrwendRXuTj8qA=;
        b=Gqwr/qM5+4KYPFkY8CojJXd7D+89eVRg2YLwqL8DjIi3ZuNtRJzHGHJ7KNq/36CeVv
         bPUInVg0M5GTiPmYCniBiN2XmXcv/380eB7YqB6rAF2JjDbt5/O+Hb5VDrgicRL13OyE
         YHOS5C9K+vKjUq0f+qNY42yz2rm93XViAVhNuP49PLPu0p96/NCMllFLu5BkP33DoBdO
         cYx7a4GcWYTRts3fzJm1WG6E3wkfLWw0q9yL1WnNMc8HgavnaqKswnNWgXeaMQke594j
         QCJWMZKxNFhawpOmZy6ahjRoQPeCfSfjpXeJ3LL4ESqJf+DaUw7/tDm3uIlpQOPAIVRS
         bASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXrfwd7gNNvp6Yt0u4EpnteM52pQoIrwendRXuTj8qA=;
        b=C4X2xyRpUBAhFXGLNWQmfaO5wpN0DQXxXG4O3cNFM0GVOekWQcAJlh/pWCI6YjYflp
         Z9ET/gv7XUDeD7olwiuH/1IgD+3NdbVrpTwKzJFS1etJoJlpf6vLrhLQIb/b6g6zi3L8
         0pEcxQnllFUGPSt8y8NO5nmtEUt0NDHMIYPOQ23sRA3Cx2pRVM+3hy2/osH8pHvT+QQb
         EyLNwByHJH/nWBKLwQJHS8nzOns1Km8hvdji4AqIKYYk7KW8XIfC4EqvwwmUygWIE1jo
         Bpi/ykGRsnEpSdny/uNysOTPbuD3zfBEZeX+f19WnLInlxE6NXRFcRVyLt5O7M+OAweU
         g4/A==
X-Gm-Message-State: ACrzQf2rKSVbEdl8cZWAsbQADGODiEovcyaqK/Ze6gTlfsXwreblps/P
        8g1SGT2+ZI4qhL+i3dZ7E3k=
X-Google-Smtp-Source: AMsMyM4DTGBEwZH1kzFjjyuQypER81cfpdxfRrvj/nuz3d3N43HZoEzdyeAVB6hHSP5Q/tdg9MMS9g==
X-Received: by 2002:a17:903:245:b0:178:e0ba:e507 with SMTP id j5-20020a170903024500b00178e0bae507mr13698271plh.115.1666033801850;
        Mon, 17 Oct 2022 12:10:01 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 21-20020a631855000000b00462ae17a1c4sm6479293pgy.33.2022.10.17.12.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:10:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:10:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] blk-iocost: Correct comment in blk_iocost_init
Message-ID: <Y02oiFyRJiFm13cL@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-6-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-6-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:08AM +0800, Kemeng Shi wrote:
> There is no iocg_pd_init function. The pd_alloc_fn function pointer of
> iocost policy is set with ioc_pd_init. Just correct it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
