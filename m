Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98768DF35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjBGRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjBGRq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:46:58 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B035A3;
        Tue,  7 Feb 2023 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675791996; bh=ii4yoI1YfOqgXUDUFrZF3AkgOsKIFlm4QdS+yQ2YnnI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=d6nj7V9XUBHGTHXwAeCyU5EutnYlDdFfSj/SQkfdygrNTqNkCK5vJDADtyvk5TywI
         0wJ+jWQxUXmLGnO2gXmENhyD168zaqphTGwI8Ow9ItMgPmQacwCsF3gEKJBS2+yhbf
         NrgSfOO/YxXi+9y/mbHjamEoOeh5DSEVQVkksA9w=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  7 Feb 2023 18:46:36 +0100 (CET)
X-EA-Auth: 2Gy1ppoYqDnuraQ5LgQ/oD15lFOEcXlTXiILHsKqJbC9Jk5cYGFzLi8N/jfAJ62+Hc91BBhZIlWhxj344v6R9V/oFpDKJDTI
Date:   Tue, 7 Feb 2023 23:16:32 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: FlashPoint: Replace arithmetic addition by bitwise
 OR
Message-ID: <Y+KOeP0OOiem3lR5@ubun2204.myguest.virtualbox.org>
References: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
 <9a78cdd254d5d962450242d2e01c3a0f702a63a0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a78cdd254d5d962450242d2e01c3a0f702a63a0.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:26:48PM +0300, James Bottomley wrote:
> On Tue, 2023-02-07 at 16:51 +0530, Deepak R Varma wrote:
> > When adding two bit-field mask values, an OR operation offers higher
> > performance over an arithmetic operation. So, convert such additions
> > to an OR based expressions. Issue identified using orplus.cocci
> > semantic patch script.
> 
> No it doesn't, at least not for constants, which is the entirety of
> this patch: the compiler can find the value at compile time, so the
> whole lot becomes a load immediate of a single value.  Whether the
> compiler sees OR or + is immaterial to the compile time computation. 

Hello James,
Thank you for the feedback. Your comments are useful. I was not aware of the
compile time computation of constant expressions before. Thanks.

> Perhaps Coccinelle should be fixed not to complain about this case?
Yes, sure. I will review the semantic patch and deterrmine if and how to fine
tune the same to avoid false positives.

> 
> James

James, there are a few other patch submissions for the scsi subsystem that I
submitted in last few weeks. I sent couple of reminder request for comments on
those submission, but still waiting. Could you please also review those and
share your feedback?

Best Regards,
deepak.

> 


