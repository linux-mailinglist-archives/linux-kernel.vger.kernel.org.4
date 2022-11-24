Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9960637C81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKXPKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiKXPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:10:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4238C1541AB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D03756219C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ADEC433C1;
        Thu, 24 Nov 2022 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669302601;
        bh=jy/VddZQBiwD+16FHO9sWnOOWepGfjbF8iNxZJH/hF0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=AJy94VGFGikAlAAbsj96vWT9FtJtq8Cig3KLZtlS0NjGokZT35sREumWQzi3Tsc91
         bp9cJbAWh5/SyFsAbazTZdrL3KCWEtcBCxiHrTp5gbMISV6wodCcyT9R9cQ4ohRmRS
         kQc7vKsNZnjFBt8X6RkLipHVAhhxAVSVgLe1DPwPL6+GZ2vUNGqg+pxJC/x3fXt92o
         gUX11vIiNToojxpDVmc+aPQ+4sbR58DvIgLoom5kJPhchi6mySNmx2bvdpLVF1GQ0/
         LhBW4P91bGS9lDZhRzGg08r+/Hw3CQgAzb8Yl4WjDxOPWCDTOClQRDJHqlryQa3/r5
         vvU1FEao1uxmg==
Message-ID: <d8e36305-1f0a-092d-2286-76f40e91e19a@kernel.org>
Date:   Thu, 24 Nov 2022 23:09:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RESEND][PATCH] f2fs: avoid victim selection from previous victim
 section
Content-Language: en-US
To:     yonggil.song@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20221122090320epcms2p2e5df6f7bb1c2d80ae69fd5e4f84b08be@epcms2p2>
 <20221122090320epcms2p2e5df6f7bb1c2d80ae69fd5e4f84b08be@epcms2p2>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221122090320epcms2p2e5df6f7bb1c2d80ae69fd5e4f84b08be@epcms2p2>
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

On 2022/11/22 17:03, Yonggil Song wrote:
> When f2fs chooses GC victim in large section & LFS mode,
> next_victim_seg[gc_type] is referenced first. After segment is freed,
> next_victim_seg[gc_type] has the next segment number.
> However, next_victim_seg[gc_type] still has the last segment number
> even after the last segment of section is freed. In this case, when f2fs
> chooses a victim for the next GC round, the last segment of previous victim
> section is chosen as a victim.
> 
> Initialize next_victim_seg[gc_type] to NULL_SEGNO for the last segment in
> large section.
> 
> Fixes: e3080b0120a1 ("f2fs: support subsectional garbage collection")
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
