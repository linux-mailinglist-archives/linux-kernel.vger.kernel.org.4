Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0B6908BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBIM2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBIM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A086AD;
        Thu,  9 Feb 2023 04:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27B0CB8211A;
        Thu,  9 Feb 2023 12:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5875FC433EF;
        Thu,  9 Feb 2023 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675945678;
        bh=ATL0djbkEUSi/KWp+SICltBse0RRA4vkL5CV9dcF9BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Rc5VnU/AxCLBb7+MbeindkrlcMD05/DD0RJUxiTnR7Hktvk6bHxcMeEsMPExrxlX
         3FzyqHwCX9l70lHGXRvaf/llA9pSx/j9/cZVaH0ozUIZT57o6y1iWSBwR13GOi9Wn2
         L6lyNom1+5uFtLkALnQGGKbgfn+MCmLQFl4mDLKM=
Date:   Thu, 9 Feb 2023 13:27:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: snic: fix memory leak with using debugfs_lookup()
Message-ID: <Y+Tmy/2VY9O6w1gC@kroah.com>
References: <20230202141009.2290380-1-gregkh@linuxfoundation.org>
 <yq15ycbzphb.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq15ycbzphb.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:50:53PM -0500, Martin K. Petersen wrote:
> 
> Greg,
> 
> > When calling debugfs_lookup() the result must have dput() called on
> > it, otherwise the memory will leak over time.  To make things simpler,
> > just call debugfs_lookup_and_remove() instead which handles all of the
> > logic at once.
> 
> Applied to 6.3/scsi-staging, thanks!

Wonderful, thank you!
