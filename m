Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327064A237
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiLLNv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiLLNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:51:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD63B1261E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0846BCE0F7E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52742C433D2;
        Mon, 12 Dec 2022 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670853011;
        bh=aCRBoLb0YwdtiYohSjElCBoIIed7LaVrdwrE9FuvRCY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HisaF9J54DDZsmM4cYHCx2OsCOKayYe/1tDBrdjjhtAqEV7qUhsIiO5ZZAqzbnjg1
         8ldiR+SfNHvADy/XHvUlAdZWkmj8kBlDOlLUIwTZbMyc7uCibbOaQuVyOI4qMujOT0
         xLLUOWWaOIe/46TV51ZHdyPVP2cGtliWSCt9z+92Cv+r89lE0ybcZtkHHTTInS3c4p
         waAw+v52B67ltwKdPsl3y536VwTpn8bkFlgKCXwUMuooQzqr2tvmxX7pHDf9wKTuoE
         k6/3NmL53Xqgq8//X5mY87idXJ5hv0446ZrhflcEwT0XKP3v3SbcGyhvL+nIeKiF+B
         PM2fZ4thAg+iw==
Message-ID: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
Date:   Mon, 12 Dec 2022 21:50:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when
 discard_cmd_cnt is 0 in f2fs_put_super()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <3f2c81f8-7946-d2e0-8768-6f0b03282944@kernel.org>
 <20221212130554.79049-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221212130554.79049-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/12 21:05, Yangtao Li wrote:
> Hi,
> 
>> static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi) {
>> 	return (test_opt(sbi, DISCARD) && f2fs_hw_support_discard(sbi)) ||
>> 					f2fs_hw_should_discard(sbi);
>> }
> 
>> It looks the logic is changed?
> 
> For a storage device that does not support discard, and we have not actually
> issued any discard command. I don't think it is necessary and f2fs should not
> be equipped with trim markers.

The difference here is, if we use f2fs_realtime_discard_enable() in
f2fs_put_super(), we will only write checkpoint w/ CP_TRIMMED flag
when discard option is enable and device supports discard.

But actually, if discard option is disabled, we still needs to give
put_super() a chance to write checkpoint w/ CP_TRIMMED flag.

Thanks,

> 
> Thx,
> Yangtao
