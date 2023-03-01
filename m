Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF56A7491
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCATyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCATyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:54:08 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79864498BD;
        Wed,  1 Mar 2023 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677700430; bh=KfS7hS0J7xuE68udlOubvFGTC2KonI1Drjpg6rRNbgg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=QPgJGe9o7ub+EDYb1FGYxEbS63yEcFy1TsM64ffG9R+WMckTlYeIuoDpahFA0iYCu
         x9UADYoCVJFEIhnvxLSjT4h10Jdfu9kICR3LWRQjtvsBXKSqKvKS1zWwOgBBMwf2JP
         N5vgPE5dmhC2YvOtMjwO2Vt5s33mbzjNaFDMFH4g=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 20:53:50 +0100 (CET)
X-EA-Auth: JGVVnp4Oj+hgsy//vZv/bmZxhDUe6GuLmgCnGlz9GaFR2TEcHfAHDQMYp/J1pq4IH2fMvvex8btEdmox2uqE1g==
Date:   Thu, 2 Mar 2023 01:23:44 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH RESEND] scsi: libfc: Use refcount_* APIs for reference
 count management
Message-ID: <Y/+tSLVxw0xuS9k1@ubun2204.myguest.virtualbox.org>
References: <Y/+hVSSFgeV+yPhY@ubun2204.myguest.virtualbox.org>
 <cfe11fadc3d3e61ce6c7d6f00e1e427edea8a4e3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfe11fadc3d3e61ce6c7d6f00e1e427edea8a4e3.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 02:28:49PM -0500, James Bottomley wrote:
> On Thu, 2023-03-02 at 00:32 +0530, Deepak R Varma wrote:
> > The atomic_t API based object reference counter management is prone
> > to counter value overflows, object use-after-free issues and to
> > return puzzling values. The improved refcount_t APIs are designed to
> > address these known issues with atomic_t reference counter
> > management. This white paper [1] has detailed reasons for moving from
> > atomic_t to refcount_t APIs. Hence replace the atomic_* based
> > implementation by its refcount_* based equivalent.
> > The issue is identified using atomic_as_refcounter.cocci Coccinelle
> > semantic patch script.
> > 
> >         [1] https://arxiv.org/pdf/1710.06175.pdf
> 
> Citing long whitepapers in support of a patch isn't helpful to time
> pressed reviewers, particularly when it's evident you didn't understand
> the paper you cite. The argument in the paper for replacing atomics
> with refcounts can be summarized as: if a user can cause a counter
> overflow in an atomic_t simply by performing some action from userspace
> then that represents a source of potential overflow attacks on the
> kernel which should be mitigated by replacing the atomic_t in question
> with a refcount_t which is overflow resistant.
> 
> What's missing from the quoted changelog is a justification of how a
> user could cause an overflow in the ex_refcnt atomic_t.

Thank you very much James for the review comments. I truly appreciate your time
and guidance. I will study your feedback and send in a revision with necessary
update to patch log.

Regards,
./drv

> 
> James
> 


