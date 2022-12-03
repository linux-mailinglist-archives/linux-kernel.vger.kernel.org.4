Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7913E641710
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLCNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiLCNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:40:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CBB1DDC7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 05:40:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h7so5955646wrs.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 05:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=neBCVgIui0MRdgHsRXnX/gsXlEtzYrqSiZ1/TzCSAcY=;
        b=l6FNyLYnI3GuO5fA5OIS8w79IjgZYgT//MfiO05nu6YPvKzy3wdhX/PIgj3YUcJO4I
         fRVyn4LvFBLjnPpTe2MduSe5unRwV7Ug7v7yGCQDQnH3IEv0zJXOVMn/fGD5drKxGAM2
         ZaBN6JijhvfLkTWQ5SpkPtHGxmZHoMj8blG1Aljb7mySB4AmTB11dzrWrTH9V8Fc625v
         AJARQMY9Za9z1vCOkm9vIbjhNWHFi3TXAfcFyMcPyMONLHgTNWuDZoBkOQkCkMXZK/66
         a6W+donev60NDaCtACROom0Ue/2KakuMPXCvZitFPgLDrjp6VHLnQDDVoNXULecdSeRq
         8wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neBCVgIui0MRdgHsRXnX/gsXlEtzYrqSiZ1/TzCSAcY=;
        b=JcRvSU3QUrQuI/sgfx6MhiaCPur7rqjERUyhbRqDF4vP+U8awfK9yBdUZnuS81eoq6
         R8tJo0dxJZdrH8SLrQ/koyCfrqovGXvAHdIdQQJQ+5YB8OxnN8yyWssZA29Hkt0WxdMx
         W5xrREZPDMLRrkW/cIeZG897KzFH9xwDvgB7Pec6xQfhAtwxDGN6BS4QA0h6Ln0ur/EA
         b+Trvk8dh700sENRentsgNhlu6LnjvuBNYrPMOKT4qc8v7zP/8NGfrobe9na3EFQjSip
         1y6LxRbm7TtuZ2qTkCbKoBugvDP5pWl0LL2xFKivXEp3MEXmvcf7us0PWVO9vqQ8NGK5
         +iLA==
X-Gm-Message-State: ANoB5plHF7DMB3vwB/Lt3vKisKXDZrEVTJt7sS9yxjonA7G1Sux2BnH9
        uPfrANFzOw3HDBVaDn4kr3QZYw==
X-Google-Smtp-Source: AA0mqf4PPHh8ibGHSSDf7vrOYSCKWB8RkZYhV46iHsXidUKAf2L6K7OtGzChXJDgNmESZOFg4dsCeg==
X-Received: by 2002:a5d:4d8f:0:b0:242:1121:54b7 with SMTP id b15-20020a5d4d8f000000b00242112154b7mr20012728wru.687.1670074808314;
        Sat, 03 Dec 2022 05:40:08 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id p33-20020a05600c1da100b003d070e45574sm12228577wms.11.2022.12.03.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 05:40:07 -0800 (PST)
Date:   Sat, 3 Dec 2022 13:40:06 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
Subject: Re: [PATCH v2] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <20221203134006.lj6uicaeo55npoq4@airbuntu>
References: <20221127142657.1649347-1-qyousef@layalina.io>
 <87cz976pwn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cz976pwn.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 08:48, Jonathan Corbet wrote:
> Qais Yousef <qyousef@layalina.io> writes:
> 
> > The new util clamp feature needs a document explaining what it is and
> > how to use it. The new document hopefully covers everything one needs to
> > know about uclamp.
> >
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >
> > Changes in v2:
> >
> > 	* Address various style comments from Bagas
> 
> Just a handful of nits - this looks like a good addition to our
> documentation, thanks.

Thanks a lot Jonathan! I've taken all your comments into account. Thanks for
having a look and hopefully it wasn't a bad read!


Cheers

--
Qais Yousef
