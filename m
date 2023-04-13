Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878496E0F48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDMNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDMNzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C255199D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 280FE614C8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AB3C433D2;
        Thu, 13 Apr 2023 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681394106;
        bh=ZF5StzuND+t5rpz6XiP5Vi+VTLCV1JJRdj6HFuXDfQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHlpML0q0/9r13mg+OBDDVx5p0MpMSLjJOLHrNnAkbUuEWtfA0NXLquMdjE7rojP1
         gfVgll64aMagrxmPGMhVyq2ANFrRt+iviAzOT6hoxd9Zx1NzzBsHwwzWtkYYdLINxM
         O2TxZhiT4Gcu4P+yu8BagOxRGENnfkRDx/taqTIFUIHNl1fywBUBb8Vs+lI65ZoOlq
         9HtsCtPP3hb+uZw9gnGid7O2iSQOhr5AhFLJ9cyka7D8tkTRlS2XAoAGgqHfS+3Kka
         /YjtRcVzwAopkLJy6+qMauHO2evvIzSAOu81984Vyj5KLkdXIv+vGk/CidHdUr1JKz
         DnLUv/KvFQfTA==
Date:   Thu, 13 Apr 2023 15:55:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, lihuafei1@huawei.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        quic_neeraju@quicinc.com, paulmck@kernel.org, heng.su@intel.com
Subject: Re: [Syzkaller & bisect] There is "task hung in synchronize_rcu
 bisect" in v6.3-rc2 kernel
Message-ID: <ZDgJtWmSmGeY2aJl@localhost.localdomain>
References: <ZBG4HOCQIlGFFcIn@xpf.sh.intel.com>
 <ZDdsz+5/QehZ25hg@xpf.sh.intel.com>
 <ZDflLOCujdBNXl3D@lothringen>
 <441aa796-5c39-1cf5-c71a-f04633773968@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441aa796-5c39-1cf5-c71a-f04633773968@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Apr 13, 2023 at 06:40:16AM -0600, Jens Axboe a écrit :
> Is there a reproducer for this one so we can take a look? It's not
> impossible to get into this state if you muck with signals, eg ring
> exit work is queued but needs requests to complete, and the latter
> is prevented by deliberately sending a SIGSTOP to the task that needs
> to complete them.

Yep, the original message provides all the necessary steps to reproduce:

     https://lore.kernel.org/lkml/ZBG4HOCQIlGFFcIn@xpf.sh.intel.com/

I cross my fingers that you'll be able to trigger it...

Thanks.
