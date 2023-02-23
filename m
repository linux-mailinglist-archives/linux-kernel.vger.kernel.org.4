Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8C6A0CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjBWPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjBWPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:13:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA1A244
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:13:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l1so10663134wry.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl40oJi2pBeUXOYPVMzhSKoIVj3ilKaHVt6O2jbv2T8=;
        b=jr7OqN8ruyPSzTTzsOphScY4iRhy2nJzxpXx1pnR0lRhbdPp0Yn5lPsfYWzT76S+nm
         98lsj7f61PFHzmMO7UaeCybFQAxWfgD1ppPSqt2PMRxB1a2GPZcilPo0xvW0LR60WLlU
         xYJNjNrDGBA+tJ5vJBOc2vZSjxGo3PzNfuMk31IpW4ueaR2RTq4MgZkmiMhPSdrKMYr2
         lNncL+kry7v1ZRloJKidhtyKLbe2BtzKMgJ625R6b6lyRHmL3PqJ8Jng4kL75gaNs/II
         9z2MpNjNbkZ1AjgD9XoH7/WgcyFoxejMnjn0AZmwawql8JXJKVqTK9l7ph5bbCqYoHhy
         Ahzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hl40oJi2pBeUXOYPVMzhSKoIVj3ilKaHVt6O2jbv2T8=;
        b=8QhxxQZYyZrTYvmCVzmxLLjboDEVLZ47XdYNvCJgWauRJ6elN6yivaZJQJ299rPbFB
         /IHKQNywyovq61cRaNG18sc7gCvY5PDUUhZ0b1v7S0kU+ARZgKmDemIRI+fFHW1dz+l1
         rQeYiY1bhwxb7GwhoeSyzZBYlKl7jwfZ0/FlKEj3w8dpEr2OST5E3kx3Ymr6qT8YuaJu
         im4LFr8+StJAiDUDTzHsL0kGF1iq7ajg6iHyAWupTACfxHuDpl5GVouz2/8/wBIt0WcI
         Bju63i1tYaCT2ryjm6YHyD8u6Rw+MqRwYbAV5Sxl/vsHJDAS8TMPqvPCuIWmaKgsSFcJ
         QaCw==
X-Gm-Message-State: AO0yUKWTP4S3roTzpY/m3Y6kaCZunxko5dig211C2dcyGsL9W+0Kr2tj
        q0Eym5Hxwn4iBVEkVbFY7wZGTQ==
X-Google-Smtp-Source: AK7set/SSt5ZD6ckO9twAvgzVSJVwihRxFfO1fnk0/J4zz8AKRhLcMhnTi79GL8scMRY6QVdfD882g==
X-Received: by 2002:adf:fc82:0:b0:2c7:70d:cc36 with SMTP id g2-20020adffc82000000b002c7070dcc36mr6981629wrr.5.1677165227903;
        Thu, 23 Feb 2023 07:13:47 -0800 (PST)
Received: from airbuntu ([104.132.45.105])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6291000000b002c70c99db74sm4344689wru.86.2023.02.23.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:13:47 -0800 (PST)
Date:   Thu, 23 Feb 2023 15:13:46 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230223151346.pzqtbjzoqgkak3g2@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <20230211172829.f2igueizqpwijjjz@airbuntu>
 <CAKfTPtCGjRR3k_m9OAra6XZP83dBxbiDPnGr7B52M_o=D=Oqng@mail.gmail.com>
 <20230221120545.iki7giafykvht3fp@airbuntu>
 <CAKfTPtBL++445hTvhvCeog19+XpokVvb7DpJAkjC2zxSFfiUUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBL++445hTvhvCeog19+XpokVvb7DpJAkjC2zxSFfiUUw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/23 11:59, Vincent Guittot wrote:

> I haven't looked too much at uclamp_max impact in energy calculation.
> Nevertheless, I wonder if one solution could be to not clamp the
> utilization to cpu max capacity in this case. The fact that
> utilization can go above cpu capacity when we clamp its frequency
> reflect that it would need more compute capacity or it will run
> longer. I will try to look more deeply in this use case

Okay thanks!


--
Qais Yousef
