Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2328A65A1F2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 03:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiLaCvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 21:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiLaCvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 21:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDB11160
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 18:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F2C0B81E71
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB09C433D2;
        Sat, 31 Dec 2022 02:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672455066;
        bh=0A42kWkIs381juGuLpCG9DoytaGwDUdX7uyHrnK1/SM=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=OR6sYtogoecFKH1Lqk1l7qtiTfHpuGgWLVZqMEO+W8fUTaSN9aT3kHNsDmAf9FL3I
         4JYhdZES+cRYjqX+nMmP3+HLfqOTcLGIZUP5w9NbrwBorpX70WrY80GA9CrbO5g/e4
         k9/Xu8Q574jMJyNjjeky22v7PESePViY1+FYXOxX1XmyWQ/hEC8r+IRUOM5GV8s2QP
         CPzoSSDmrK6HEEbrc+2ZO8XdVDSOGRWzNc7IDFqacBttgbL84wmgta8p+zstxWRexf
         iX86806B09kdxhidEWAI3z4hfgjRxuc8OzQj9Fu6ROCmayuzkg8gXcm2CeGrvKlDmV
         +MkeCwRLY6XLQ==
Message-ID: <3dd9808e-ffbd-7959-2111-a9f13f2031f1@kernel.org>
Date:   Sat, 31 Dec 2022 10:51:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        F2FS Development <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Regressions <regressions@lists.linux.dev>
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
 <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
 <Y6bz4wOC0nwu2yGU@debian.me> <0c70ba66-ef00-7242-d198-844f803662fa@gmail.com>
 <CAAJw_Zv0iBg4rkzxQ2UOOLS9JQZ4cCmM7gSoDXec_gm-GggB6A@mail.gmail.com>
 <f500d64b-c26d-ee34-092a-421c64c69f9e@leemhuis.info>
 <Y66Hk6waTeXQDz1/@sol.localdomain>
From:   Chao Yu <chao@kernel.org>
Subject: Re: Fwd: f2fs write error Linux v6.2
In-Reply-To: <Y66Hk6waTeXQDz1/@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 2022/12/30 14:39, Eric Biggers wrote:
> If you could provide the mkfs and mount options you are using, and any other
> relevant details, that would be helpful.  Bisection would also be very helpful,
> as Thorsten mentioned.

Other than that, I found some cases which can cause similar issue, so I figure
out a patch for possible fixing, if you can have a try with it to check whether
it can fix your issue, that would be helpful as well.

https://lore.kernel.org/linux-f2fs-devel/20221230154332.5082-1-chao@kernel.org/T/#u

Thanks,
