Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B32B674BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjATFIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjATFHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:07:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E44C45B2;
        Thu, 19 Jan 2023 20:55:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B60CB82109;
        Thu, 19 Jan 2023 07:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FDC433EF;
        Thu, 19 Jan 2023 07:46:40 +0000 (UTC)
Message-ID: <ccedda97-ed68-9453-30d3-24506d771b44@xs4all.nl>
Date:   Thu, 19 Jan 2023 08:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] media:cec:fix double free and uaf issue when cancel data
 during noblocking
Content-Language: en-US
To:     Xinghui Li <korantwork@gmail.com>, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>, loydlv <loydlv@tencent.com>
References: <20230111123712.160882-1-korantwork@gmail.com>
 <b1a8593b-b4f3-b943-39db-ed17679e32cb@xs4all.nl>
 <4D54942F-92F0-429D-9F54-3D8F7705D576@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <4D54942F-92F0-429D-9F54-3D8F7705D576@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 05:49, Xinghui Li wrote:
> 在 2023/1/18 18:18，“Hans Verkuil”<hverkuil-cisco@xs4all.nl <mailto:hverkuil-cisco@xs4all.nl>> 写入:
> 
>> ...while this free is called if data->blocking is true. (see the 'if (!block) return 0;'
>> further up).
> Do you mean this code?
> 
> 	/* All done if we don't need to block waiting for completion */
> 	if (!block)
> 		return 0;

Yes.

> I notice this part code. But I'm not sure if 'block' will be modified in other sync operations. 
> So I sent this patch for community to review.

It's not modified anywhere else.

> 
>> So I have my doubts if this patch actually addresses the correct issue.
>> Do you have an actual debug trace of the UAF? Or even better, code to reproduce
>> this issue.
> 
> And we found this issue by the code scanning tool developed by loydlv and filtered from 200 issue by human.
> So it could be the none-issue. If so, I hope I didn't waste too much of your time.

I'll reject this patch since I believe this to be a false report. For future reference:
if a patch is based on code scanning tools then it's good to mention that in the commit
log. I wasn't aware that 'loydlv' is such a tool.

Regards,

	Hans
