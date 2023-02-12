Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262506937DC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBLPIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:08:40 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066721025B;
        Sun, 12 Feb 2023 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676214491; bh=BVZh8NWkfVvv9Bl1sW0aX5grGKzjw9dI0z32Aitq6lM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=JuFJZ1sDdaD6LaT46e8ggXkg5OTWgFB0HdNirrAh58Al9Hks2Ek2ce5O7JpVZyY9v
         pR9u52Owr0gk14HbhrSS+jXHntSduKPFXUIC7n4ailVHBqB/H5gqb112bWspIhk+eG
         xYeNMwrpdFuKJE/uOuyj58QTr3P88EgRLKjkmK58=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 12 Feb 2023 16:08:11 +0100 (CET)
X-EA-Auth: zFIgjDpeiRUBDO/GmC8onFM2fhht9rM/u+kar2gUbBkWuDJIxfDdlEvrEn21W6P30xmuunAprPxUvxW1k7dj7OcCnFanFNKO
Date:   Sun, 12 Feb 2023 20:38:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] scsi: qla1280: Replace arithmetic addition by bitwise OR
Message-ID: <Y+kA1j10JCsLG9mN@ubun2204.myguest.virtualbox.org>
References: <Y+I7/QpQYjBXutLf@ubun2204.myguest.virtualbox.org>
 <aed35866-507c-870c-7e8a-c1868bcaa084@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed35866-507c-870c-7e8a-c1868bcaa084@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 03:25:03PM -0800, Bart Van Assche wrote:
> On 2/7/23 03:54, Deepak R Varma wrote:
> > When adding two bit-field mask values, an OR operation offers higher
> > performance over an arithmetic operation. So, convert such addition to
> > an OR based expression.
> 
> Where is the evidence that supports this claim? On the following page I read
> that there is no performance difference when using a modern CPU: https://cs.stackexchange.com/questions/75811/why-is-addition-as-fast-as-bit-wise-operations-in-modern-processors
> 

Hello Bart,
You are correct. Modern CPU designs have improved addition and the performance
is at par with the bitwise operation. The document I had read earlier mentioned
a performance improvement for old CPUs and microprocessors, which today is not
the case. Thank you for sharing the link.

> > Issue identified using orplus.cocci semantic patch script.
> 
> Where is that script located? Can it be deleted such that submission of
> patches similar to this patch stops?

I have added Julia to this email to understand how to best use this semantic
patch. I already discussed with her on improving the Semantic patch such that it
doesn't suggest making change when constants are involved.

Thank you,
./drv

> 
> Thanks,
> 
> Bart.


