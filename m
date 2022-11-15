Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4262AE73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKOWlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiKOWkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:40:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E8EA1A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39C51B81B8B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBCAC433C1;
        Tue, 15 Nov 2022 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668552045;
        bh=JiFlzgedeiJa2EV18L8uT1+agi0HgcdcNrox4VF6fdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/4fbRkN04g/ko6drcGu5hZlH8vXr94R0TQYroNgFRtxUz4TmTutLFcWoNp/SLoXt
         ZWC9x6azBnsJuAO7gVMTQJe93olRmNijuDh1qSWq+rxgbkAoWaFG0Eck+NBh6e+CE5
         99QmH40BvQL6PdEMIesgdtl8sgLyba45NGXCipYprM3Cps394goMpWULSP0N1az6an
         pgVk7EY4cVXdr94YaJL6Uccn4cDcIWH1pUtOfX7gxe16QX8DkjjZpXO3eqeKOIF+Mx
         jqIYGp0WIWRylq6pP7Zvcf6NhklHJk1sOl/TQNK6c30F0gpE8frKhA6pLY9T8Ig6tG
         ao8iFTK8LdmNw==
Date:   Tue, 15 Nov 2022 23:40:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhou, Yun" <Yun.Zhou@windriver.com>
Cc:     "jstultz@google.com" <jstultz@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers: fix LVL_START macro
Message-ID: <20221115224042.GA722789@lothringen>
References: <20221115025614.79537-1-yun.zhou@windriver.com>
 <20221115120239.GA721394@lothringen>
 <SN6PR11MB300812CA336B497C40E93CA19F049@SN6PR11MB3008.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB300812CA336B497C40E93CA19F049@SN6PR11MB3008.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 01:15:11PM +0000, Zhou, Yun wrote:
> Hi Frederic,
> 
> The issue now is that a timer may be thrown into the upper level bucket. For example, expires 4090 and 1000 HZ, it should be in level 2, but now it will be placed in the level 3. Is this expected?
> 
>  * HZ 1000 steps
>  * Level Offset  Granularity            Range
>  *  0      0         1 ms                0 ms -         63 ms
>  *  1     64         8 ms               64 ms -        511 ms
>  *  2    128        64 ms              512 ms -       4095 ms (512ms - ~4s)
>  *  3    192       512 ms             4096 ms -      32767 ms (~4s - ~32s)
>  *  4    256      4096 ms (~4s)      32768 ms -     262143 ms (~32s - ~4m)

The rule is that a timer is not allowed to expire too early. But it can expire
a bit late. Hence why it is always rounded up. So in the case of 4090, we have
the choice between:

1) expiring at bucket 2 after 4096 - 64 = 4032 ms
2) expiring at bucket 3 after 4096 ms

The 1) rounds down and expires too early. The 2) rounds up and expires a bit
late. So the second solution is preferred.

Thanks.
