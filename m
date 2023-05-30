Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A9F716E88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjE3US1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjE3US0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6CF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4482616F0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD70AC433EF;
        Tue, 30 May 2023 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685477904;
        bh=8AeSnbzSIaL+NlgndNF+LMpT5xRE4WNBb45fs45fe9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2dmdC2ibU6ItUUDc4koUAIj8LvA/Cz8QzXRU3v6Qc3oYkbEntttE6mcGQIXhrCNV
         P2kdfJE8752Psu3pNkukLnemKYP7BiQdavx4eKv3/3pFuneuR2kmxASyO7fojcGX0E
         YcWr2c8prSGHl8RyxVh2Ck0FVq18xoQHSn/eViwc=
Date:   Tue, 30 May 2023 21:18:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/4] debugfs: Add simple min/max "files" to debugfs to
 fix sched debug code.
Message-ID: <2023053025-blinks-vexingly-60d3@gregkh>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194012.44411-1-chris.hyser@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:40:08PM -0400, chris hyser wrote:
> v2:
> Apologies. I sent this the first time without including lkml.
> 
> v1:
> This originally started as an attempt to solve a divide by zero issue in sched
> debug code that was introduced when a sysctl value with non-zero checking was
> moved to a simple u32 debugfs file. In looking at ways to solve this, it was
> mentioned I should look at providing general debugfs files with min/max
> checking. 
> 
> One problem was that a check for greater than zero for say a u8 succeeds for a
> number like 256 (but stores a zero anyway) as the upper bits that don't fit into
> storage are silently dropped. Therefore values greater than the storage capacity
> must also fail. Getting an error when what the user wrote is not what was
> actually stored, seems like a useful requirement for the other simple files and
> so I moved the check into there.
> 
> To enable easy testing, a test module and test script are provided which can
> validate the new functions as well as check the new limits on the older
> functions. This was stuck under selftests, but it is not currently tied into the
> testing infrastructure.

This is a lot of new infrastructure for a single debugfs file that you
could just check for in the file write callback instead.

I'm all for cool new features, but wow, this seems like major overkill.
Are you _SURE_ you need it all?

thanks,

greg k-h
