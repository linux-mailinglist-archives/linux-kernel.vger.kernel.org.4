Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C201C64A374
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiLLOev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiLLOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:34:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B46B7F7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD36DB80A09
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8C0C433EF;
        Mon, 12 Dec 2022 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670855678;
        bh=xrxm9027GcAIsmiBgBtStkdcOzlrTaOUqUnQjxV8w2w=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ooNgKFhMxlQUDD+qy9kGKVKk6EFT5vIYTPXu/+sFDk9QdepzsYhH63GADMkqI4IjI
         cRo5w4eVWI1WMIbCAYKkQsBIfcJwl+CZRdK5RyXwJ6wekmui1xFTbxWooZml0JoeC2
         7AP2vVidjIN1TQkYdZgM8fjuzVLfz44adSIzp36xClC5DWHW23W9thQs5QF4jgKQXZ
         PSgtUPfxg70CFmhxXwqkARDDjHmJhywXoqZyI9b+Cg7ENNglZNGUdQgFfez0v/dQOd
         HdeN9h8oOMKy+uKgJTiukHpA2kexpUHcJgVLuZkbgPXWE0MlNHGYuALDZoI46ksDkT
         YOZEXUPKsS4kA==
Message-ID: <2f100a4a-592d-f098-b204-efeef58341ee@kernel.org>
Date:   Mon, 12 Dec 2022 22:34:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
 <20221212141429.6329-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: don't call f2fs_issue_discard_timeout() when
 discard_cmd_cnt is 0 in f2fs_put_super()
In-Reply-To: <20221212141429.6329-1-frank.li@vivo.com>
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

On 2022/12/12 22:14, Yangtao Li wrote:
> Hi Chao,
> 
>> The difference here is, if we use f2fs_realtime_discard_enable() in
>> f2fs_put_super(), we will only write checkpoint w/ CP_TRIMMED flag
>> when discard option is enable and device supports discard.
> 
>> But actually, if discard option is disabled, we still needs to give
>> put_super() a chance to write checkpoint w/ CP_TRIMMED flag.
> 
> Why do we still have to set the CP_TRIMMED flag when the discard opt is not set.
> Did I miss something?

Hi Yangtao,

I guess it's up to scenario. e.g.

mount w/ nodiscard and use FITRIM to trigger in-batch discard,
if we set CP_TRIMMED flag during umount, next time, after mount
w/ discard, it doesn't to issue redundant discard.

Thanks,

> 
> Thx,
> Yangtao
