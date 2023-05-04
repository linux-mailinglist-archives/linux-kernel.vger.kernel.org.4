Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37EB6F6EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjEDPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjEDPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:09:46 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF544A1
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:09:42 -0700 (PDT)
Received: from [192.168.1.5] ([183.94.69.234])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 344F8TQO000684-344F8TQP000684
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 4 May 2023 23:08:29 +0800
Message-ID: <6b0523d1-c8ff-d746-bf50-ddabadd07bcf@hust.edu.cn>
Date:   Thu, 4 May 2023 23:08:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] drivers: staging: greybus: fix GPF issue in
 gb_camera_capture
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo.mondi@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230504135841.1566958-1-dzm91@hust.edu.cn>
 <bc5546c0-2c16-4b2d-ada1-c6dcf1d8c1a4@kili.mountain>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <bc5546c0-2c16-4b2d-ada1-c6dcf1d8c1a4@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/23 PM10:53, Dan Carpenter wrote:
> On Thu, May 04, 2023 at 09:58:41PM +0800, Dongliang Mu wrote:
>> In gb_camera_capture(), it does not check the value of settings
>> before dereferencing it. And gb_camera_debugfs_capture calls
>> gb_camera_capture with the 6th parameter settings as NULL.
>>
>> Fix this by checking the value of setting at the starting of
>> gb_camera_capture.
>>
>> Fixes: 3265edaf0d70 ("greybus: Add driver for the camera class protocol")
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
> No.  The original code is correct.  memcpy(p, NULL, 0); is allowed.

Oh, I see. This memcpy with src as NULL and len as zero is intended.

Thanks, Dan.

Sorry for the false alarm, guys.

> I don't see a bug.
>
> regards,
> dan carpenter
