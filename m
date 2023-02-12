Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB68E6937EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBLPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBLPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:25:26 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC472A5;
        Sun, 12 Feb 2023 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676215510; bh=mpR96e6qxmMwlJVFXeWvgAkz3O9/lUP1cX6Qlad8/Kc=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=jNylcrLsxxtlueflIVCaosXP9J4cEC1feXeniMEtOCxgVL/zZ/SBh+71kd3tW/mcF
         tur01LMekMju7YyQS1QTJiw7ZYMAdVxQ6g+9b5DGLG4ZgvMBvYXgl0O1xgfsU0RMxq
         UvUhLKwKIoEtJDZCxb4xKbY4Pl8Aon5Q60d0YLyk=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 12 Feb 2023 16:25:10 +0100 (CET)
X-EA-Auth: j3uijOJdy5rNvIbou+VZqUPkrKFlz6+NBxVo4F7DZ78VurCpb7fehBjRFbVxfATVPOMj/wGXs0qjg3XYZloDRS4BVKi7z9e+
Date:   Sun, 12 Feb 2023 20:55:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Bart Van Assche <bvanassche@acm.org>, Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] scsi: qla1280: Replace arithmetic addition by bitwise OR
Message-ID: <Y+kE0oWExkE6sLnH@ubun2204.myguest.virtualbox.org>
References: <Y+I7/QpQYjBXutLf@ubun2204.myguest.virtualbox.org>
 <aed35866-507c-870c-7e8a-c1868bcaa084@acm.org>
 <Y+kA1j10JCsLG9mN@ubun2204.myguest.virtualbox.org>
 <alpine.DEB.2.22.394.2302121611010.9268@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2302121611010.9268@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 04:11:58PM +0100, Julia Lawall wrote:
> 
> 
> On Sun, 12 Feb 2023, Deepak R Varma wrote:
> 
> > On Sat, Feb 11, 2023 at 03:25:03PM -0800, Bart Van Assche wrote:
> > > On 2/7/23 03:54, Deepak R Varma wrote:
> > > > When adding two bit-field mask values, an OR operation offers higher
> > > > performance over an arithmetic operation. So, convert such addition to
> > > > an OR based expression.
> > >
> > > Where is the evidence that supports this claim? On the following page I read
> > > that there is no performance difference when using a modern CPU: https://cs.stackexchange.com/questions/75811/why-is-addition-as-fast-as-bit-wise-operations-in-modern-processors
> > >
> >
> > Hello Bart,
> > You are correct. Modern CPU designs have improved addition and the performance
> > is at par with the bitwise operation. The document I had read earlier mentioned
> > a performance improvement for old CPUs and microprocessors, which today is not
> > the case. Thank you for sharing the link.
> >
> > > > Issue identified using orplus.cocci semantic patch script.
> > >
> > > Where is that script located? Can it be deleted such that submission of
> > > patches similar to this patch stops?
> >
> > I have added Julia to this email to understand how to best use this semantic
> > patch. I already discussed with her on improving the Semantic patch such that it
> > doesn't suggest making change when constants are involved.
> 
> FWIW, the semantic patch was never motivated by efficiency, but rather
> with the goal of making the code more understandable.

I think my interpretation of the patch log for [1] was not accurate. The line
"Running time is divided by 3 ..." made me believe OR'ing would replace "F+A+R"
instructions by a single operation. My bad.

[1] https://lore.kernel.org/all/alpine.DEB.2.20.1711130649370.2483@hadrien/

> 
> julia


