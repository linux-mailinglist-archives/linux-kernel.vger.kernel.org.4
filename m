Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E16C3530
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCUPKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCUPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:10:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45A9E;
        Tue, 21 Mar 2023 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GbKk9gj4d8dqcMphqOHsujgPCRXc9qWJUYdgRs9Ow3E=; b=BuVS9SV+hLG6s4TcejdyMBO4/X
        mla/q0PKrz9NMiIg6hqSGGBagVnT5vVhYxF6rEchBedhJQ8RgNi/Y7OtHbluvwO5kQ+cSx/KeOQjf
        GlzMPYivDCbyuh6LG6iOwgl2P2XDVk9aBt++5yER0vn1Wv4lrQ1AJYJM/MqIQO/fp65yIjRGAIiZt
        LjSKFL0FGQ+rSkmXbThIfACFUrCapS5mYEIKYUFY47+mjXcyvVhyafAhSiuw9oaXQiKZOE68au65F
        CDH6jHZUSbsmXtIzUqPVuJm3mrlpd8ITC3qZ9jCSqpJFG1/8GEKMb/0pS6bzQUUGy2pOJyghjDOwG
        RUCw+Ujw==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peddS-00Crh0-35;
        Tue, 21 Mar 2023 15:10:51 +0000
Message-ID: <7e876937-4254-a2d8-f810-513f067b4855@infradead.org>
Date:   Tue, 21 Mar 2023 08:10:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Build regressions/improvements in v6.3-rc3 (drm/msm/)
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320082146.4117022-1-geert@linux-m68k.org>
 <c85681c6-6fcf-33ed-210f-661e539f78d8@infradead.org>
 <CAMuHMdWw0OdLPUORh6=Be8AW6bN+Pa2t=dcF47B1m=-ihsNPZQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdWw0OdLPUORh6=Be8AW6bN+Pa2t=dcF47B1m=-ihsNPZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

On 3/21/23 00:34, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Tue, Mar 21, 2023 at 6:38 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 3/20/23 01:21, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v6.3-rc3[1] compared to v6.2[2].
>>>
>>> Summarized:
>>>   - build errors: +9/-14
>>>   - build warnings: +4/-1447
>>>
>>> JFYI, when comparing v6.3-rc3[1] to v6.3-rc2[3], the summaries are:
>>>   - build errors: +0/-1
>>>   - build warnings: +0/-0
>>>
>>> Happy fixing! ;-)
>>>
>>> Thanks to the linux-next team for providing the build service.
>>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e8d018dd0257f744ca50a729e3d042cf2ec9da65/ (all 152 configs)
>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c9c3395d5e3dcc6daee66c6908354d47bf98cb0c/ (all 152 configs)
>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/eeac8ede17557680855031c6f305ece2378af326/ (all 152 configs)
>>>
>>>
>>> *** ERRORS ***
>>>
>>> 9 error regressions:
>>
>>>   + /kisskb/src/drivers/gpu/drm/msm/msm_mdss.c: error: case label does not reduce to an integer constant:  => 300:2, 299:2, 296:2
>>
>>
>> Are these due to the sign bit being set after a shift?
>> It looks that way since it is only reported for such values.
> 
> Yep.
> 
>> From the reports on the build server, it only happens when building with gcc5.
>> I don't have the ability to build with gcc5 or I would test it.
> 
> I deliberately installed gcc-5.5.0-nolibc/aarch64-linux to reproduce it
> (gcc5 on x86 didn't reproduce).

Yes, I installed that same compiler. When I tried to use it, I got:

/opt/crosstool/gcc-5.5.0-nolibc/aarch64-linux/bin/aarch64-linux-gcc: unknown C compiler
scripts/Kconfig.include:44: Sorry, this C compiler is not supported.

and I didn't try to track down what that means or what is causing it...

>> @Rob and other drm/msm people, what do you think about this?
>> (or is this already fixed somewhere but not yet in linux-next?)
> 
> Thanks, I posted a similar fix two weeks ago:
> https://lore.kernel.org/all/20230306090633.65918-1-geert+renesas@glider.be

OK, I replied to that one.

Thanks.

-- 
~Randy
