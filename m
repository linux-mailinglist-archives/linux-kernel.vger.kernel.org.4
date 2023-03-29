Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6B6CD754
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjC2KJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjC2KJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:09:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AAFDE;
        Wed, 29 Mar 2023 03:09:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F0AC61C27;
        Wed, 29 Mar 2023 10:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2075AC433EF;
        Wed, 29 Mar 2023 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084586;
        bh=w809a55v4vcQohpdyf5Egn5InyKp6z0v44dJrseoAoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xzT3hnifD7adIi9OAR9RZf/6fHxeVYu4gY84oA0vOZQxfuM1DBOKDFOY3VdCxB/r6
         ZnRfn/LB6h85OxjEsZJusXaJd9lsqa6DCjEHEMCnm52vdB3N82vDHUQ2NvgojTR4PG
         bXWWLS6o7ZsBvzQL6HiIW/t0BOMSqZEsBFj2jACI=
Date:   Wed, 29 Mar 2023 12:09:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org, ekangupt@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
Subject: Re: [PATCH v1] misc: fastrpc: Reassign memory ownership only for
 remote heap
Message-ID: <ZCQOaMcObl0vYqlg@kroah.com>
References: <1679394100-27119-1-git-send-email-quic_ekangupt@quicinc.com>
 <17185edd-aa6f-386b-4252-0c6eac1ddcfc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17185edd-aa6f-386b-4252-0c6eac1ddcfc@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:53:33PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 21/03/2023 10:21, Ekansh Gupta wrote:
> > The userspace map request for remote heap allocates CMA memory.
> > The ownership of this memory needs to be reassigned to proper
> > owners to allow access from the protection domain running on
> > DSP. This reassigning of ownership is not correct if done for
> > any other supported flags.
> > 
> > When any other flag is requested from userspace, fastrpc is
> > trying to reassign the ownership of memory and this reassignment
> > is getting skipped for remote heap request which is incorrect.
> > Add proper flag check to reassign the memory only if remote heap
> > is requested.
> > 
> > Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
> > Cc: stable <stable@kernel.org>
> > Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> 
> Thanks for fixing this,  without this fix the code inside if condition was a
> dead code.
> 
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Are you going to be collecting these and sending them on?  If not,
please do.

thanks,

greg k-h
