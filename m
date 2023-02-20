Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6479069D059
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjBTPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBTPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:10:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9940E7;
        Mon, 20 Feb 2023 07:10:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68ABFB80D56;
        Mon, 20 Feb 2023 15:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83842C433A0;
        Mon, 20 Feb 2023 15:09:02 +0000 (UTC)
Message-ID: <c910c54b-989b-8ed0-e4b5-fedd38a86e88@xs4all.nl>
Date:   Mon, 20 Feb 2023 16:09:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: v4l2-test-controls.cpp(325): expected 8 private controls, got 7
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        nicolas@ndufresne.ca, xavier.claessens@collabora.com,
        benjamin.gaignard@collabora.com
References: <CA+G9fYt=mHaGEyKeyF+24u=QnDpePNz9_vh3SMK31+mGHSsCTg@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CA+G9fYt=mHaGEyKeyF+24u=QnDpePNz9_vh3SMK31+mGHSsCTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 15:42, Naresh Kamboju wrote:
> Following v4l2 tests are failing on Linux mainline v6.2 on arm64 hikey device.
> Am I missing anything in my test environment ?
> 
> Driver Info:
> ----------
>   Driver name      : vivid
>   Bus info         : platform:vivid-000
>   Driver version   : 6.2.0
> 
> Fail  log:
> ---------
>     fail: v4l2-test-controls.cpp(325): expected 8 private controls, got 7
>   test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: FAIL
>     fail: v4l2-test-controls.cpp(366): qctrl.step || qctrl.minimum ||
> qctrl.maximum || qctrl.default_value
>   test VIDIOC_QUERYCTRL: FAIL
> ..
>     fail: v4l2-test-controls.cpp(473): g_ctrl returned an error (22)
>   test VIDIOC_G/S_CTRL: FAIL
> ..
>     fail: v4l2-test-controls.cpp(593): returned control value out of range
>     fail: v4l2-test-controls.cpp(706): invalid control 0098f90f
>   test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL
> ..
>     fail: v4l2-test-formats.cpp(264): fmtdesc.description mismatch:
> was 'Y/UV 4:2:0', expected 'Y/CbCr 4:2:0'

This suggests that you are running with an old(er) v4l-utils version, since I adapted
v4l2-compliance to avoid this failure. It's due to a change in the kernel, so currently
both old and new descriptions are accepted.

Looking at the logs:

v4l2-compliance SHA: 5d8c459c1bf9 2021-04-08 13:28:26

That's much too old.

Regards,

	Hans

>   test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: FAIL
> 
> 
> Test details,
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14859062/suite/v4l2-compliance/tests/
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.2/testrun/14859062/suite/v4l2-compliance/test/VIDIOC_ENUM_FMT-FRAMESIZES-FRAMEINTERVALS/log
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

