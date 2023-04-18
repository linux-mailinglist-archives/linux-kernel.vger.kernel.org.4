Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5DD6E5922
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDRGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDRGJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:09:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA35468E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88A61616FD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F432C433D2;
        Tue, 18 Apr 2023 06:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681798197;
        bh=4ZkApvugcZU8+OzPj66QCEvINcz6Rwtaf4yAgfpReEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ddQ0hm5o0cm62yfrEGgFMMF03zuf3Kj3Fc2GSAF8ToK0M9jVRJyDM+rZm7/cfNMv6
         tYG9DhRxOVzRypYCCCcI3yVnj8ljV7GDOlpZ9+UmpaL1vbfg+iFmKiXW+MCceTQAjC
         Z/ME8LtGglMH+UbZkTmJBI63JJGZ3KtdbqO6+16I=
Date:   Tue, 18 Apr 2023 08:09:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: sleeping function called from invalid context in
 __might_resched
Message-ID: <ZD40MfJ1kzJuPD1l@kroah.com>
References: <CA+UBctCZok5FSQ=LPRA+A-jocW=L8FuMVZ_7MNqhh483P5yN8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UBctCZok5FSQ=LPRA+A-jocW=L8FuMVZ_7MNqhh483P5yN8A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:44:30PM -0700, Yu Hao wrote:
> Hello,
> 
> We found the following issue using syzkaller on Linux v6.2.0.
> A similar bug was found in function `n_hdlc_tty_wakeup` before.
> (https://groups.google.com/g/syzkaller-bugs/c/XAyZCUO-eAY/m/Lpj5SzDNAwAJ)
> Now it is found in a different caller `gsmld_write`.
> It needs to fix the bug in `gsmld_write` again.
> 
> The full report including the C reproducer:
> https://gist.github.com/ZHYfeng/eb410de5d7aec253d8c83cf34e628d6a
> 
> The brief report is below:

Please submit a patch to resolve the issue, otherwise this will just end
up going on the huge other pile of syzbot-reported issues that we slowly
dig ourselves through...

thanks,

greg k-h
