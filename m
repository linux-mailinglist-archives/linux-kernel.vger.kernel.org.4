Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B706D6F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbjDDVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjDDVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:41:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99753AB0;
        Tue,  4 Apr 2023 14:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6456B639B3;
        Tue,  4 Apr 2023 21:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12877C433D2;
        Tue,  4 Apr 2023 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680644506;
        bh=lMszXUPs3xmT4/L30IdHdQrLlqYnTYyFa1K84xFbLzU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=suGmChBU3viKp/0FZp/PClBH3B/13p89RcgTbkDT3EsMOXC3oDkh6gYjPX2bapCZ/
         aGs5TKU6V9bgcqh1+blinlxGO/YS49LgT+ZRsn9CSuZPUp3XhsRjKZLNJQERP6YH7n
         SH0zxfrw3GYMpps3+hAiPGqPJhzv05asqqtUeUY3Xpu/X0hkpApOyLdZR3MDWmeS9l
         bznh3G5HdNQLT0FjYySymJB7exOOe9Wsj+D0Gp1bOXwFubBCPhL4NtvoRFPcBS1Tka
         gIFnl1bh9qp5+7QWCvUEVBHU7dlLZ+y16JCBSFBb75449My+VcOMpvtX1EiA9MhlVW
         Y9JbxaO1APLFA==
Date:   Tue, 4 Apr 2023 23:41:42 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     James Bottomley <jejb@linux.ibm.com>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ding Hui <dinghui@sangfor.com.cn>,
        Michal Kolar <mich.k@seznam.cz>
Subject: [PATCH v2] scsi: ses: Handle enclosure with just a primary component
 gracefully
In-Reply-To: <fa174980e5c9bdafae3426fffe45b97b37f69c84.camel@linux.ibm.com>
Message-ID: <nycvar.YFH.7.76.2304042251560.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm> <fa174980e5c9bdafae3426fffe45b97b37f69c84.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023, James Bottomley wrote:

> > This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has
> > no components") and introduces proper handling of case where there
> > are no detected secondary components, but primary component
> > (enumerated in num_enclosures) does exist. That fix was originally
> > proposed by Ding Hui <dinghui@sangfor.com.cn>.
> 
> I think everything in here looks fine except this:
> 
> > --- a/drivers/scsi/ses.c
> > +++ b/drivers/scsi/ses.c
> > @@ -509,9 +509,6 @@ static int ses_enclosure_find_by_addr(struct
> > enclosure_device *edev,
> >         int i;
> >         struct ses_component *scomp;
> >  
> > -       if (!edev->component[0].scratch)
> > -               return 0;
> > -
> >         for (i = 0; i < edev->components; i++) {
> >                 scomp = edev->component[i].scratch;
> >                 if (scomp->addr != efd->addr)
> 
> If you remove the check, then scomp could be NULL here and we'll oops
> on scomp->addr.

This hunk was taken from the original 2020 fix, but you are right, thanks 
for spotting this.

Please find v2 below, with this hunk removed, and Tested-by: added.





From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] scsi: ses: Handle enclosure with just a primary component gracefully

This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has no
components") and introduces proper handling of case where there are no detected
secondary components, but primary component (enumerated in num_enclosures)
does exist. That fix was originally proposed by Ding Hui <dinghui@sangfor.com.cn>.

Completely ignoring devices that have one primary enclosure and no secondary one
results in ses_intf_add() bailing completely

	scsi 2:0:0:254: enclosure has no enumerated components
        scsi 2:0:0:254: Failed to bind enclosure -12ven in valid configurations such

even on valid configurations with 1 primary and 0 secondary enclosures as below:

	# sg_ses /dev/sg0
	  3PARdata  SES               3321
	Supported diagnostic pages:
	  Supported Diagnostic Pages [sdp] [0x0]
	  Configuration (SES) [cf] [0x1]
	  Short Enclosure Status (SES) [ses] [0x8]
	# sg_ses -p cf /dev/sg0
	  3PARdata  SES               3321
	Configuration diagnostic page:
	  number of secondary subenclosures: 0
	  generation code: 0x0
	  enclosure descriptor list
	    Subenclosure identifier: 0 [primary]
	      relative ES process id: 0, number of ES processes: 1
	      number of type descriptor headers: 1
	      enclosure logical identifier (hex): 20000002ac02068d
	      enclosure vendor: 3PARdata  product: VV                rev: 3321
	  type descriptor header and text list
	    Element type: Unspecified, subenclosure id: 0
	      number of possible elements: 1

The changelog for the original fix follows

=====
We can get a crash when disconnecting the iSCSI session,
the call trace like this:

  [ffff00002a00fb70] kfree at ffff00000830e224
  [ffff00002a00fba0] ses_intf_remove at ffff000001f200e4
  [ffff00002a00fbd0] device_del at ffff0000086b6a98
  [ffff00002a00fc50] device_unregister at ffff0000086b6d58
  [ffff00002a00fc70] __scsi_remove_device at ffff00000870608c
  [ffff00002a00fca0] scsi_remove_device at ffff000008706134
  [ffff00002a00fcc0] __scsi_remove_target at ffff0000087062e4
  [ffff00002a00fd10] scsi_remove_target at ffff0000087064c0
  [ffff00002a00fd70] __iscsi_unbind_session at ffff000001c872c4
  [ffff00002a00fdb0] process_one_work at ffff00000810f35c
  [ffff00002a00fe00] worker_thread at ffff00000810f648
  [ffff00002a00fe70] kthread at ffff000008116e98

In ses_intf_add, components count could be 0, and kcalloc 0 size scomp,
but not saved in edev->component[i].scratch

In this situation, edev->component[0].scratch is an invalid pointer,
when kfree it in ses_intf_remove_enclosure, a crash like above would happen
The call trace also could be other random cases when kfree cannot catch
the invalid pointer

We should not use edev->component[] array when the components count is 0
We also need check index when use edev->component[] array in
ses_enclosure_data_process
=====

Reported-by: Michal Kolar <mich.k@seznam.cz>
Tested-by: Michal Kolar <mich.k@seznam.cz>
Originally-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: stable@vger.kernel.org
Fixes: 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has no components")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

v1 -> v2:

	- fix potential oops in ses_enclosure_find_by_addr() spotted by 
	  James
	- add Tested-by:

 drivers/scsi/ses.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index b11a9162e73a..f3fa92f493ec 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -602,8 +602,10 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 						components++,
 						type_ptr[0],
 						name);
-				else
+				else if (components < edev->components)
 					ecomp = &edev->component[components++];
+				else
+					ecomp = ERR_PTR(-EINVAL);
 
 				if (!IS_ERR(ecomp)) {
 					if (addl_desc_ptr) {
@@ -734,11 +736,6 @@ static int ses_intf_add(struct device *cdev,
 			components += type_ptr[1];
 	}
 
-	if (components == 0) {
-		sdev_printk(KERN_WARNING, sdev, "enclosure has no enumerated components\n");
-		goto err_free;
-	}
-
 	ses_dev->page1 = buf;
 	ses_dev->page1_len = len;
 	buf = NULL;
@@ -780,9 +777,11 @@ static int ses_intf_add(struct device *cdev,
 		buf = NULL;
 	}
 page2_not_supported:
-	scomp = kcalloc(components, sizeof(struct ses_component), GFP_KERNEL);
-	if (!scomp)
-		goto err_free;
+	if (components > 0) {
+		scomp = kcalloc(components, sizeof(struct ses_component), GFP_KERNEL);
+		if (!scomp)
+			goto err_free;
+	}
 
 	edev = enclosure_register(cdev->parent, dev_name(&sdev->sdev_gendev),
 				  components, &ses_enclosure_callbacks);
-- 
Jiri Kosina
SUSE Labs

