Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0876DD416
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDKH04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDKH0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496128E;
        Tue, 11 Apr 2023 00:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73EB6113B;
        Tue, 11 Apr 2023 07:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039D7C433EF;
        Tue, 11 Apr 2023 07:26:49 +0000 (UTC)
Message-ID: <6ee01cf1-5a8b-081f-e218-8c7da39343bc@xs4all.nl>
Date:   Tue, 11 Apr 2023 09:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] media: vivid: Add webcam parameter for (un)limited
 bandwidth
Content-Language: en-US
To:     Max Staudt <mstaudt@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20230410063356.3894767-1-mstaudt@chromium.org>
 <20230410102350.382f7d02@sal.lan>
 <6aafad18-13a2-ef45-48a1-1f094554af31@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <6aafad18-13a2-ef45-48a1-1f094554af31@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 08:51, Max Staudt wrote:
> Thank you Mauro for having a first look!
> 
> Questions below.
> 
> 
> On 4/10/23 18:23, Mauro Carvalho Chehab wrote:
>> IMO, instead of a parameter that just enables/disables the bandwidth
>> limit, the best would be to have a parameter specifying the bandwidth
>> (with 0 meaning unlimited).
>>
>> If not used, vivid would initialize it to dev->webcam_bandwidth_limit,
>> so a read operation will show the current limit.
> Up until now, the bandwidth limit is a rather arbitrary reduction of two interval sizes per frame size.
> 
> How would you prefer to define a limited bandwidth in this parameter? How would it affect the simulated camera, do you have a suggestion for a formula from bandwidth to frame/interval sizes offered?
> 
> 
>>> +/* Default: limited webcam bandwidth */
>>> +static bool webcam_bandwidth_limit[VIVID_MAX_DEVS] = { [0 ... (VIVID_MAX_DEVS - 1)] = true };
>>> +module_param_array(webcam_bandwidth_limit, bool, NULL, 0444);
>>
>> I would also use 0666, to allow changing this on runtime.
> 
> I guess that's possible, though it would add complexity.
> 
> Currently we can ask for two instances, each with a different setting:
> 
>   n_devs=2 webcam_bandwidth_limit=1,0
> 
> This creates /dev/video0 which is limited, and /dev/video4 which is unlimited.
> 
> Maybe this already sufficiently covers the case you are looking for, and we can keep the complexity low? A real webcam won't suddenly offer new frame rates either...

I think we either use this bandwidth option and calculate the max fps based on
that (basically the bandwidth divided by (image_size + some blanking factor)),
or we keep it simple and instead of going down two steps in fps we allow up to
60 fps up to 720p, then 30 fps for 1080p and 15 fps for 4k.

The fps values currently used are a bit outdated w.r.t. modern webcams, so
upgrading it wouldn't hurt. And this is a lot simpler than doing bandwidth
calculations.

Regards,

	Hans
