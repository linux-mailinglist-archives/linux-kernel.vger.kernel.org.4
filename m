Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C469C665D48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjAKOGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjAKOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:06:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CEC103C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:06:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E476461D34
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAB1C433D2;
        Wed, 11 Jan 2023 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673445988;
        bh=1/WxTmG8XkF0x5JjcCvVsXAgoeqkHdknYzulROmr7KM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oVSfpKENZBMsFEuN9u/YMqjxSkjFMju2PRaLPugkRDcbwEW781ZeO292HPHWvG672
         9vxymakNumXkBgu8BzfVzr2re2AjyxoeutgVje6XkxEvRtDM1ix6tuAmG6HwNcreCC
         Tjbmf2T5RsxBnNxIRkXRms/h3Yce0HPVGlFGVW3CXVJMFXbQRyEUwlQD1rmloLkFfv
         rbvryZERYe6346KCbHcXlsWzNTO4pW7KmxXw0q/1SerdHqysYnlW82N6dhwS2Qm9f8
         oad//AuWiBMeZOjFGld4OYqeQ9t/5IcFI8KTe9elgKhGtkks/5c4yzZSCb9k0+rlWL
         K2KU1YPhroXxw==
Message-ID: <7378f01b-3f02-a81c-7266-c743381131fb@kernel.org>
Date:   Wed, 11 Jan 2023 22:06:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] f2fs: reset iostat_count in f2fs_reset_iostat()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Yangtao Li <frank.li@vivo.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230104112158.15844-1-frank.li@vivo.com>
 <Y7XRc+UiLBF/m3KW@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y7XRc+UiLBF/m3KW@google.com>
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

On 2023/1/5 3:20, Jaegeuk Kim wrote:
> Hi Yangtao,
> 
> These are all in dev-test branch, which means you don't need to stack up more
> patches on top of it. I just integrated most of them into two original patches.
> Could you please take a look at this?
> 
> c1706cc0cd72 f2fs: add iostat support for flush
> acd6f525e01c f2fs: support accounting iostat count and avg_bytes

+#define IOSTAT_INFO_SHOW(name, type)					\
+	seq_printf(seq, "%-23s %-16llu %-16llu %-16llu\n",	\
+			name":", sbi->iostat_bytes[type],			\
+			sbi->iostat_count[type],					\
+			iostat_get_avg_bytes(sbi, type))			\

'\' doesn't align in column, otherwise it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
