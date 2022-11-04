Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE033618F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKDEkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKDEkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:40:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B2D27933
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 21:40:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3662821pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 21:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHhq7f9BhY24T1T5sV6nTbvw95hjS6tddB46N4/JrJs=;
        b=q61CJlag5GuvD6AvssWOA7BBqEgsuqQErgcTGMuGUkBAIWEwM9nZmwtIXkTGeDeHjI
         Sw+f7p5acerlEmkfbbfIxqm5K1gB/3Gb6z2XVhwSi2u1m49ZByHVqwrZnHER2BuvVnE0
         MAyHqcAg2Ca79V6Zb+1jvkhveQvR67DnLXMWUVNfMqCpwNlgZ/YJxWGI4IOZuzoV8j7d
         t+Hb+ziCXhXSUjh6cJVrCuFjuZ77LWDVLDWwtRii6XmbMhqtNhFV70urzDOkRJ1f0Rzj
         yPT8gbr2dZwsJtYNGhHgwpUNIL5xg/CR2RxN1woseGzx6tSLVTgItTkx8F7Ly5f/xfPm
         kjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHhq7f9BhY24T1T5sV6nTbvw95hjS6tddB46N4/JrJs=;
        b=J/8fG7nekf7kU5o7LcJKY76a3SOT/Q8+oaENRRnLvd0drnNVAanArZ+jRYlTh17MCb
         24Z95kDY46BrPJHyZNDonuiUPib0MAcpfqzZxjl+ZQ/T/TJ4h4aT/hem3d9o7NRohtyS
         hB6/A+8yYHrY8ZFfuts+1BFWiXnfVzMBz2wsCLakKpeMkYqW4JzGGEy8D1e2axfCuaRK
         0IV66YsHWvzt//CuO7M0iDxMhIUG/vme/PuRaObuptnB4qYZkVbIG5+ADN0JsSuOJyPt
         3rK/Vydi5tv59kfhW5NbaT+Jclp+rlbR87KdUAyHPMGgk56aV9cnZEcfEVt+CZmkKkAl
         fLtQ==
X-Gm-Message-State: ACrzQf070GGtvDo4W3uQWqV3EG7I8w3Et/ujNeVcSAePSrBxm2C6V6SH
        VdzOysbhQWBeV3dllkCtCMyTbA==
X-Google-Smtp-Source: AMsMyM446Gb7kE9Mo4dZRb75fZ7IQcnvmWxa5gH04kpR6ALDlnPHcVI3oDuLeG9y5lgi7sByMb7MKw==
X-Received: by 2002:a17:902:aa8b:b0:178:8f1d:6936 with SMTP id d11-20020a170902aa8b00b001788f1d6936mr33693293plr.168.1667536810325;
        Thu, 03 Nov 2022 21:40:10 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id l7-20020a632507000000b0046f73d92ea5sm1462956pgl.90.2022.11.03.21.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 21:40:08 -0700 (PDT)
Date:   Fri, 4 Nov 2022 10:10:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: SPEAr: Make read-only array sys_clk_src static
Message-ID: <20221104044003.vfuna4xnasknrltc@vireshk-i7>
References: <20221103143654.85275-1-colin.i.king@gmail.com>
 <20221103143807.tamhepos3cureoga@vireshk-i7>
 <ef637642-7d0f-66b8-2225-b6f8609f037e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef637642-7d0f-66b8-2225-b6f8609f037e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-22, 14:49, Colin King (gmail) wrote:
> But really, this is kind of basic C level stuff. I suggest reading K&R 2nd
> Edition, Section 4.6, last paragraph before exercise 4-11.

Yeah it is and I said this for the benefit of later readers of the commit log,
who may not know the exact reason of the same:

"I am just looking for a valid answer in commit log".

Anyway, the patches look fine otherwise.

-- 
viresh
