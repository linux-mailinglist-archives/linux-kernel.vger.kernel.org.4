Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4D71666C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjE3PMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjE3PMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A5BE;
        Tue, 30 May 2023 08:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7F9462906;
        Tue, 30 May 2023 15:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C417FC433EF;
        Tue, 30 May 2023 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685459555;
        bh=4kszkiKYQZZBlC9XFCYpDiNYoZ19gI+fLwDPLNndKzU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G0Jabv367okXjl+PR0dnMMOSyHI2z+LaykTYgyjXEbYiilKX+419JA7ARffaR9t3M
         7cMpsTljIe7hGzmFHVwwoOjLJXsexJP6f7vKSKbG/cs5qyGAuOnkpI5SCdxvSnXk9x
         RYzAccWTtYwzSChWOR9HXWuRkXSs/38eAOUWd1ortKwryWdX1lWcZySyCoiZCKQdtE
         Sry3mSrPcmr/QRG4P/80TCJV+yW6/UTJTZTMrOtkDIBz+3EUrfFRbH3qXe6hou2apm
         6BHkjatycqfh/rPqPiMeEZlVC8P4yJdZkrjmMLsqE0QzsAxExeBVBq8uZOJtVVBc8Q
         RpQxhWY9/9jrA==
Message-ID: <7bdb0e44-eaf7-8085-2ea5-6bb06b01ef35@kernel.org>
Date:   Tue, 30 May 2023 17:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 3/4] dt-bindings: remoteproc: add compatibility for
 TEE support
Content-Language: en-US
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
References: <20230523091350.292221-1-arnaud.pouliquen@foss.st.com>
 <20230523091350.292221-4-arnaud.pouliquen@foss.st.com>
 <1b4eba7e-2771-b0c8-ec23-2ed882374e5d@kernel.org>
 <d4a98500-5cb0-b3fd-7f40-8b56a2258619@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <d4a98500-5cb0-b3fd-7f40-8b56a2258619@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 17:00, Arnaud POULIQUEN wrote:
> Hello Krzysztof,
> 
> On 5/30/23 13:50, Krzysztof Kozlowski wrote:
>> On 23/05/2023 11:13, Arnaud Pouliquen wrote:
>>> Rework compatibility description according to the support of
>>> the authenticated firmware relying on OP-TEE authentication.
>>>
>>> The expected behavior is:
>>> - with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
>>>   non-signed (ELF) firmware image,
>>> - with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
>>>   firmware image. In this case it calls TEE services to manage the firmware
>>>   loading and the remoteproc life-cycle.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>> ---
>>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 33 +++++++++++++++++--
>>>  1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> You missed at least DT list (maybe more), so this won't be tested.
>> Please resend and include all necessary entries.
>>
>> Because of above and RFC, I assume there is no need for review. Just to
>> be clear - that's a no.
> 
> I did not add DT list and maintainers intentionally to avoid that you
> review it.
> As in a first step the associated OP-TEE pull request has to be reviewed.
> And my plan was just to share the Linux implementation part until the
> OP-TEE review cycle is finished.

Sure, that's fine. I just don't know whether this is intentional or not.
Many people skip list without such reason...

> 
> Now regarding your mail (and very interesting feedback from Christoph Hellwig),
> it was clearly not the good strategy.
> So my apologize and next time whatever the objective of the series I will add
> all peoples and lists in the loop.

No worries! Thanks.

Best regards,
Krzysztof

