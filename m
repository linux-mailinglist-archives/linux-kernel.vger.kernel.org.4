Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1C5F1017
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiI3Qfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiI3Qfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:35:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A30F5340
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:35:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 138so3675424iou.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Kezpom8rJsVG2Syyn3/zEYfm5bdVOEFSAlE2suSQHSw=;
        b=Ua3NLrKFNNJu6C4h1UF2NO39rwaNSmYfnEN7gjCb18BRAS6dacl6NzRduKI+jgI2oG
         6UemSvw3H8jUS9rZlDzuIY60pEwUbh/+U944llY6mSCOb22iWIAUy6ouvWSMD5iQ8P9v
         xK+UeWkyfqW3yhiVBHd0Mu5t+ei4IcGnQVt2yzEkbQ7eWFjPQMVbqRFGleMgMgVnu8c6
         6Ra+8kdkNgM7auHiixqajLA+e8Rto+/xwTD+r3r7GwF2/b+nGls6wTTOGvGPBdevM/Dm
         ZxmMT22DFu/WD/bdD7ed0ViI0hg8TkaQTH4Z3nMCrvpL9+RYjlDPbsPfKON3KK9cl+92
         Ovaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kezpom8rJsVG2Syyn3/zEYfm5bdVOEFSAlE2suSQHSw=;
        b=pwjl1DJ/KgjpVkRppFTJhfwgy4o1iiRbyHvXdOm/OmgM5qAgOIj425SKdASWVgo5BG
         +vsSbVvaIswRBXke09G21uJHb0RgK81+RTrJVJXoc+szpQIa6hVpdZiKsc1wfbn4z0B7
         lthov6BPmTMrcQCVUX/uF4ayj3JZPhPr+FIikph6C3jXXdLzZiLWg9BNV6x6NHRMrE3i
         4WH3wsaqVzC6wImer6ch2XrofrF4CXkyjznrf6f/mdtFfpthEgPPYpAJULjp7om/Mwm8
         0pwOR4VzKzdUpzcxjYK5QnFXBPKJQNmONe3rU+pR+wAUlCMNxgibtL7LujUk0Fs2mlLt
         7lHQ==
X-Gm-Message-State: ACrzQf0razE+Q9RbhFg9tN/+0NoKlAkRDIO8tji4RgyvSB11eHDdkXdm
        riuMD6yCdK8Mc9ilUfFZjx4BU4M/hlCdRg==
X-Google-Smtp-Source: AMsMyM6Bo9kMyMyymRpkgRpKKTUXxbHzMlJDn6OcG2Z3krboh5VsAHz+9gA1c/PjmQHw9bBBWA8O6w==
X-Received: by 2002:a05:6602:3944:b0:6a4:cae3:12fd with SMTP id bt4-20020a056602394400b006a4cae312fdmr4452725iob.189.1664555741237;
        Fri, 30 Sep 2022 09:35:41 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x37-20020a0294a8000000b003583063a6cdsm1089478jah.104.2022.09.30.09.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 09:35:40 -0700 (PDT)
Message-ID: <12aa1043-14c3-0f95-6cb4-f7a021268ae4@kernel.dk>
Date:   Fri, 30 Sep 2022 10:35:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: block: wrong return value by bio_end_sector?
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 9:59 AM, Paolo Valente wrote:
> Hi Jens, Damien, all other possibly interested people,
> this is to raise attention on a mistake that has emerged in a
> thread on a bfq extension for multi-actuary drives [1].
> 
> The mistake is apparently in the macro bio_end_sector (defined in
> include/linux/bio.h), which seems to be translated (incorrectly) as
> sector+size, and not as sector+size-1.
> 
> For your convenience, I'm pasting a detailed description of the
> problem, by Tyler (description taken from the above thread [1]).

I'm a little confused - currently it returns non-inclusive end, the
proposed change just make it inclusive. In general in the kernel the
former is used, and this one follows that.

-- 
Jens Axboe


