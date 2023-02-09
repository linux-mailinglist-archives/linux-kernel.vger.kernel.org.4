Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E99690146
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBIHcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:32:53 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8411E9D2;
        Wed,  8 Feb 2023 23:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1675927953; bh=r1fA+MsK9ZQJWZQOUtHHcz4x+aTRED0EhcqthUCjArU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=kBE5qRl8X/SKZXuAOHx9mV7VuB+UjKlzenzn6v3UKmluFtPV0fQnfapsdlPp0EoGU
         V/LUMFrmgnyBx3pLKVsnCnooHKiNtUz4ZyR9K/NDrdcIOZDwNy73/JhTiVDQ9Wo/dK
         IY0vIIeBMOohfLMMaRu4GaNhyUE+6xkMiBFV9We8=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Thu,  9 Feb 2023 08:32:33 +0100 (CET)
X-EA-Auth: p9/A5rNAbpfRei2xl5YjSVou75VMmpO5ZC/nUciWpnYwBg2qNuAV5qV25D4vXCI3yMQYMZtkQc+0Jt1KZJkmbwE5aathiGoi
Date:   Thu, 9 Feb 2023 13:02:26 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: FlashPoint: Replace arithmetic addition by bitwise
 OR
Message-ID: <Y+ShipH6kaao0Dp/@ubun2204.myguest.virtualbox.org>
References: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
 <9a78cdd254d5d962450242d2e01c3a0f702a63a0.camel@linux.ibm.com>
 <Y+KOeP0OOiem3lR5@ubun2204.myguest.virtualbox.org>
 <yq17cwt2s0r.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17cwt2s0r.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:19:52PM -0500, Martin K. Petersen wrote:
> 
> Hi Deepak!
> 
> > James, there are a few other patch submissions for the scsi subsystem
> > that I submitted in last few weeks. I sent couple of reminder request
> > for comments on those submission, but still waiting. Could you please
> > also review those and share your feedback?
> 
> I only merge cleanup patches if the relevant driver maintainer reviews
> and acks them. And there needs to be sufficient justification, of
> course.
> 
> As an example I will observe that your sysfs patches say:
> 
> "According to Documentation/filesystems/sysfs.rst, the show() callback
> function of kobject attributes should strictly use sysfs_emit() instead
> of sprintf() family functions."
> 
> That's a "should", not a "shall". IOW, a recommendation. Also, there is
> no "strictly" requirement to be found in sysfs.rst. So the patch
> justification is lacking.
> 
> We definitely use sysfs_emit() for new code. But it is not clear that
> there is any value in changing old code predating sysfs_emit() to comply
> with a mere recommendation. It's just additional work and comes with a
> substantial risk of introducing regressions since virtually no cleanup
> patches have actually been tested on the relevant hardware.
> 
> Nobody has access to all the devices required to validate the many, many
> drivers we have in SCSI. So unless the driver maintainer (who presumably
> has hardware) is willing to test, it is impossible for me to qualify
> whether a patch introduces a regression.
> 
> One option is demonstrating that the patch does not change the generated
> object code as James suggested. But even if the binary is unchanged,
> cleanups often involve stylistic changes or switching to a more "modern"
> approach. And for those changes I still want the driver maintainer to
> ack. It's their driver.
> 
> To pick another example from your posted patches, it not immediately
> obvious that using min() is superior to an if-else statement. Sometimes
> it is clearer to express things as a conditional even though it takes up
> more vertical space (or maybe because it does?). In any case that's a
> personal preference and the driver maintainer's choice.
> 
> Hope that helps!

Hello James and Martin,
I appreciate your comments and the detailed response. Thank you very much. I
understand the proposals are mostly clean up and not a significant benefit to
the code in terms of bug-fix or improvement. I will leave the patches at the
current status if any driver maintainer wants to take those forward.

Thank you again and apologies for any inconvenience.
./drv

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering


