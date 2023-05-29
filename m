Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8B7148C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjE2LpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjE2Los (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:44:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E309B
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:44:47 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d1e96c082so2380866b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685360687; x=1687952687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjm4PS56z1gyE4pd4bEwf/9whtkeMcCRIdP6RDpCngU=;
        b=vJTYOGcR60r4BmR4eY04yDKwQj/b7gxrG2lNOLWPDfRvyrpTnGCMeB5kekcX2bvKz8
         cWnyzVOU1fZP6T9hV8MlVcYuNQAnDjRk1XP5cGYeqYXPnr7lKU9pwYwslvCk0dxxwmr1
         g2yrWsaZXL8xyAcyeZ5Ii6raYaiiRwR7BwS2I3STBhuYszvO7PmKn2GVNfloNoLSbWpY
         GGC3vHmGL8/f3r6LmZ7djmJSWsPp7f30COwIkj9Xv1dqhwRo1InDUbXx2SZgyeWRmsYO
         OJpJpUFJu6oIMfcaWsboc4HEGdaBv0Q7fpTgcinmRUNFfEtffVjsFppUo6hlPOVUNUVm
         F/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360687; x=1687952687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xjm4PS56z1gyE4pd4bEwf/9whtkeMcCRIdP6RDpCngU=;
        b=lLd+e4n7WU6x4/cudGaHUhDoMtYhW87zOf7xWsCzPP/3hI/CC2WJYiiFORlqnioIFW
         Vo5CywU/7MYARhwODFFecuBsdijhsZUzderu+XYW7DZ3gu5OrJeBLWIp1VrSyuI/5kaj
         hzOrZqrHM7iJntz3RLInUGSBvsw+atyvZRKQ3SV3t5XZqQZAjkWP/5EycDfnTFEt1UAN
         NussoesMDYgmVMOA2iGV/ApxNnRz+Bmib9PWAOtu6cCXlqBdDAEKKiCQyNdZSPhN4Eh1
         8qUD1RSL6i/vTZSZh/eVRMUvS9Oaok0/12z0Vzu2mSBiPPbPn9JMTFdE4KL3KPTAQn8r
         ljcg==
X-Gm-Message-State: AC+VfDz+a7g/HZ2bnWIivrSxbEIfzWv28vVkJwmpH9KEM+/5NRfZ984H
        e9vKAgy24wZXqX1Nlur16/IgSA==
X-Google-Smtp-Source: ACHHUZ5mBN1ktRwr9aXdj/LvweDGHaPKCPAMJuFxUdPObRpGpihC+SrLzr/u3h9QEQIVOQS2Cl9jiw==
X-Received: by 2002:a05:6a20:914e:b0:10f:500b:18a2 with SMTP id x14-20020a056a20914e00b0010f500b18a2mr7982058pzc.48.1685360687170;
        Mon, 29 May 2023 04:44:47 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79249000000b0064aea45b040sm6517819pfp.168.2023.05.29.04.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 04:44:46 -0700 (PDT)
Date:   Mon, 29 May 2023 17:14:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Message-ID: <20230529114444.kkciicopgt6fb6xq@vireshk-i7>
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
 <20230526105320.pfnu3oxl2cm37ot7@vireshk-i7>
 <f8731d93-b335-6d9a-183c-34a652f45455@linaro.org>
 <20230529045854.gh36k5my4i35jspc@vireshk-i7>
 <cbea8bc5-5dd2-b097-964d-3494935d4f68@linaro.org>
 <20230529094041.s4fj6gjliivugk3r@vireshk-i7>
 <485cd9cf-6a0d-4a1e-0212-9afc1a41a10b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485cd9cf-6a0d-4a1e-0212-9afc1a41a10b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-23, 13:38, Konrad Dybcio wrote:
> I did some more testing and I think that I was just trying to abuse
> the APIs.. Adding power-domains + pm calls + required-opps to the genpd
> provider made the set_opp func work fine on suspend.. Consider this
> solved!

Nice!

-- 
viresh
