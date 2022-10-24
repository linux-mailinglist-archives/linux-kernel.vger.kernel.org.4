Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0985D60BB62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJXU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiJXU5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:57:07 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE81C2EB6;
        Mon, 24 Oct 2022 12:03:37 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so13888620pji.1;
        Mon, 24 Oct 2022 12:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpthEP7YXPpISJ6CGPHYOqUT6IOWvKcBQOAkgoQ0ELw=;
        b=n+/PUfdkNtRN6FsSyZnOuG2MGe6OwkXQ0etPDDKP0hjvui5n1+crE6l/t4YAS/hLdB
         hnYItTcEVr0LPjRQ/qxv2Gza3D4roOr0TkK+JhkQ5c5/bFGmK6QiLG9PXwtBTpW+Li3/
         vgIxPICaaJafC/tv8W5dxSWvuqdEHEG1/uQlJxaJB6hnSCvo/H/77PU46NgI7Z+vzCag
         N8ctFPw5ftvGptCDGk/DkAp975pL+W1VdBxMhwu9hxHBaZy9pJzvYN56g5Bae2XwWpwG
         FAqU3V0V8eRg1gMS6uXv11lkMN7yUxPDjJ7QR4JhEK6XDISOWwr0+/GHk9XxomwS5WGd
         qMmg==
X-Gm-Message-State: ACrzQf1Q8y4k94tDXbz6g/Zx9SJ86lk+11McZ6cY2CrnnBSjXsq86UIr
        pUBtuHKSETO00t/IGnA+UmE=
X-Google-Smtp-Source: AMsMyM41hqd/uZatx/NIZkdddex4IQIsPyvThfppQJMTcjKSxixD9lMXD6LAtqRvj3T+q4RUKykUsQ==
X-Received: by 2002:a17:903:18b:b0:185:43e6:20df with SMTP id z11-20020a170903018b00b0018543e620dfmr34041445plg.4.1666638167863;
        Mon, 24 Oct 2022 12:02:47 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i27-20020a056a00005b00b0056203db46ffsm135961pfk.172.2022.10.24.12.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:02:47 -0700 (PDT)
Message-ID: <dc89c70e-4931-baaf-c450-6801c200c1d7@acm.org>
Date:   Mon, 24 Oct 2022 12:02:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>,
        hch@lst.de, Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
 <90b6d45e-61a5-3eb3-7525-8467f1a67587@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <90b6d45e-61a5-3eb3-7525-8467f1a67587@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 14:24, Jens Axboe wrote:
> Noted. I'll find some time to review this as well separately, once we're
> on the other side of the merge window.

Hi Jens,

Now that we are on the other side of the merge window: do you perhaps 
want Pankaj to repost this patch series? From what I have heard in 
several fora (JEDEC, SNIA) all flash storage vendors except one (WDC) 
are in favor of a contiguous LBA space and hence are in favor of 
supporting zone sizes that are not a power of two.

As you may know in JEDEC we are working on standardizing zoned storage 
for UFS devices. We (JEDEC JC-64.1 committee members) would like to know 
whether or not we should require that the UFS zone size should be a 
power of two.

Thank you,

Bart.


