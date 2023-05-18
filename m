Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE6170879B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjERSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjERSMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A913193
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E55065174
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 18:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A80AC433D2;
        Thu, 18 May 2023 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684433558;
        bh=GNlcuW3+7623yOfnEPCTxQifwH2hirg4FSU2Phfotc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtZN4OtgGcovwPt8Q7PxLLuh9yDkyxvoFx0hvvrk0BLtu37A3H0WQAhLYHmjYZQEV
         OLry301uPXfaJIO+b8I9e+yqqrOo+JNQsP1I2nt/sFK94fvZZLUAEN+UwwF9Udvks6
         6GpGy8noKAe6ReRB+uu9ErdqqSXrchXDluc5J9HY/r2D05nuWX/zkdjJbuV3UIIN9b
         qyub6MafY66tyUD8XX9Piv3FZKmh+/PRM3q3zWPPDZPTBct8thYQ9pt64cKo2M4Unz
         7P3dTvJqFSJWnUSvi4HhaTlGCTteoYJPmBrzPNrikEPXGm9dcL61H6janKnJJ99bWD
         +SWSk00B2asFQ==
Date:   Thu, 18 May 2023 20:12:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
Message-ID: <20230518-fettgehalt-erdbeben-25587a432815@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <20230518-kontakt-geduckt-25bab595f503@brauner>
 <7412912a-a470-bd3d-fb1c-54c094cc01ee@oracle.com>
 <20230518-ratgeber-erbeben-843e68b0d6ac@brauner>
 <20230518180809.GA5817@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518180809.GA5817@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:08:10PM +0200, Oleg Nesterov wrote:
> On 05/18, Christian Brauner wrote:
> >
> > Yeah, but these are issues that exist with PF_IO_WORKER then too
> 
> This was my thought too but I am starting to think I was wrong.
> 
> Of course I don't understand the code in io_uring/ but it seems
> that it always breaks the IO loops if get_signal() returns SIGKILL.

Yeah, it does and I think Mike has a point that vhost could be running
into an issue here that io_uring currently does avoid. But I don't think
we should rely on that.
