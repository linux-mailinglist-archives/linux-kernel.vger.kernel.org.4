Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9596875AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBBGN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBGNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:13:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A46E42F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 22:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98483B824C7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EFEC433EF;
        Thu,  2 Feb 2023 06:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675318402;
        bh=Ky/1ghQ0FqtHg3xtb96YzswiIfdF+Rqi4ezcKZbriac=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oq+IOUsNJsb8KLDC9noPayjVCf2oBUFxMuMDB1bNOoRSDuWLWRHJ3eWvHqXfARpVT
         QBxInPNh415ggQ8QKILcvq7V/ZcAzU3+gThlkmEJeANvWHTJIGDGTWEX5vlN5Gxem3
         Izw2eeLw1PxNKeysXvULTeOFPGUhi1IhSVZ4nJ8fMVj2oTPXhpmd2wbM9418Gzyy3n
         ouKTIP8XDudyWgLTk+aGySOtxVRhLzQM34Xr7UEBFfgQc2/qXLrf/Mhuv9wAomcsBp
         SNSgBCUiGTVU+2AbqmOqZAhCJBpEzPYBYRrGoH9GUz/Tv4NfEwUqHZ/tC6EOHhNHno
         D0ssbfmqouC0Q==
Message-ID: <64d1f9d3-12d8-cc7a-501e-5c0286b0cfa1@kernel.org>
Date:   Thu, 2 Feb 2023 14:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: Fix type of single bit bitfield in f2fs_io_info
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>, jaegeuk@kernel.org
Cc:     ndesaulniers@google.com, trix@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20230201-f2fs-fix-single-length-bitfields-v1-1-e386f7916b94@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230201-f2fs-fix-single-length-bitfields-v1-1-e386f7916b94@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/2 0:40, Nathan Chancellor wrote:
> Clang warns:
> 
>    ../fs/f2fs/data.c:995:17: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>            fio->submitted = 1;
>                           ^ ~
>    ../fs/f2fs/data.c:1011:15: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>                            fio->retry = 1;
>                                       ^ ~
> 
>    ../fs/f2fs/segment.c:3320:16: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>                    fio->in_list = 1;
>                                 ^ ~
> 
> There is not a bug here because the value of these fields is never
> explicitly compared against (just whether it is zero or non-zero) but
> it is easy to silence the warning by using an unsigned type to allow
> an assignment of 0 or 1 without implicit conversion.

Nathan, thanks a lot for catching this, do you mind letting I merge this fix
into original patch? as the original patch has not been upstreamed yet.

Thanks,
