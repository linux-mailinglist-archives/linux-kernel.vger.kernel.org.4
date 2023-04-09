Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064DF6DC1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 00:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDIWio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIWim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 18:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE793581;
        Sun,  9 Apr 2023 15:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75EAD60C91;
        Sun,  9 Apr 2023 22:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEABC433D2;
        Sun,  9 Apr 2023 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681079920;
        bh=bp+Z9WwA1xQfPySpTfK4b9+Tcx6sde4HaYQ4IZhMPeY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=l5yIOOA3piwHRGWc//od5DUAHgpW1oajA167D3mf0/8woNUW5gnpKxbLgyJq1YIZH
         c+uq3Sx28cSv09v796o5Jij6lMcC9q7TuB3PLNMXErkSFwU4WZHbwI+jxgplzn5q1O
         hoGuOWWYuECWTcebdVRJoI9FsCyaSBYSUSi6Cl8dak1fks4NdXX9rXf834Kkgne5r5
         ql/c1eTqpnPQPdu+rPryv55QzeQWEhFjh9YX4Sc11tB32KKbf1bvMFmEBa/Dcj7Bb8
         Ox3SMka22GZ4oMPknzd7+IdckgG9RXQwZQyV/JFiPPkIFjXM87ltPycfgNSCFYiu7y
         Cd8NMaSjyMbrw==
Date:   Mon, 10 Apr 2023 00:38:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Ding Hui <dinghui@sangfor.com.cn>
cc:     jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Kolar <mich.k@seznam.cz>
Subject: Re: [PATCH] scsi: ses: Handle enclosure with just a primary component
 gracefully
In-Reply-To: <b71bca20-401f-c877-168c-c26ca1c282d1@sangfor.com.cn>
Message-ID: <nycvar.YFH.7.76.2304100037190.29760@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2304042122270.29760@cbobk.fhfr.pm> <fa174980e5c9bdafae3426fffe45b97b37f69c84.camel@linux.ibm.com> <b71bca20-401f-c877-168c-c26ca1c282d1@sangfor.com.cn>
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

On Wed, 5 Apr 2023, Ding Hui wrote:

> >> This reverts 3fe97ff3d9493 ("scsi: ses: Don't attach if enclosure has
> >> no components") and introduces proper handling of case where there
> >> are no detected secondary components, but primary component
> >> (enumerated in num_enclosures) does exist. That fix was originally
> >> proposed by Ding Hui <dinghui@sangfor.com.cn>.
> > 
> > I think everything in here looks fine except this:
> > 
> >> --- a/drivers/scsi/ses.c
> >> +++ b/drivers/scsi/ses.c
> >> @@ -509,9 +509,6 @@ static int ses_enclosure_find_by_addr(struct
> >> enclosure_device *edev,
> >>          int i;
> >>          struct ses_component *scomp;
> >>   -       if (!edev->component[0].scratch)
> >> -               return 0;
> >> -
> >>          for (i = 0; i < edev->components; i++) {
> >>                  scomp = edev->component[i].scratch;
> >>                  if (scomp->addr != efd->addr)
> > 
> > If you remove the check, then scomp could be NULL here and we'll oops
> > on scomp->addr.
> 
> I think we should remove the check, because the edev->components 
> represented the effectiveness of array pointers, so we need check 
> edev->components firstly instead of checking edev->component[0].scratch, 
> if edev->components is 0, we won't enter the for loop, don't worry about 
> dereference scomp.

Right you are. So v1 is actually more correct.

Martin, could you please consider adding

	Tested-by: Michal Kolar <mich.k@seznam.cz>

to v1 and applying? Thanks,

-- 
Jiri Kosina
SUSE Labs

