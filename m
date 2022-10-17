Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4056D60115D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJQOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJQOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:44:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2B1F60A;
        Mon, 17 Oct 2022 07:44:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E03E933E2D;
        Mon, 17 Oct 2022 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666017891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hCwp1KGuFl3/01j4y5Cf1ZkRiA3haQfv1blk7AuYxY=;
        b=3KMQeJFy6O4qTKbRbrmbY+oWKEIcmkR3LrRt5Zs9AwLhqWCMHaygZ652jaw1aWBt9PskVQ
        tPVeOo181rS78l4WY2vM/CBS2Q6ORnPKJNeeZwu8Ol4gyygH/pe+vjKIlsD4MK+pwF9cVe
        d5HxHrjhmPwECMfP+hyjhMRZnpDawXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666017891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hCwp1KGuFl3/01j4y5Cf1ZkRiA3haQfv1blk7AuYxY=;
        b=Iff5kbgFOfo1IkDYeqdWc2kshLFStRHjvCGM4UQuRYZIhgWRbUJSRsdG19MGmpGRUljm+d
        XYnefirgThv51FBw==
Received: from lion.mk-sys.cz (unknown [10.163.29.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D4E302C141;
        Mon, 17 Oct 2022 14:44:51 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id BD1B66043B; Mon, 17 Oct 2022 16:44:51 +0200 (CEST)
Date:   Mon, 17 Oct 2022 16:44:51 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     mpi3mr-linuxdrv.pdl@broadcom.com,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpi3mr: add explicit dependency on
 CONFIG_SCSI_SAS_ATTRS
Message-ID: <20221017144451.tpqqilhpjgdcpgtu@lion.mk-sys.cz>
References: <20221017140533.CC46F6043B@lion.mk-sys.cz>
 <0c6f49e95cbb9e2de9501b11b1391a5fd7b132c1.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6f49e95cbb9e2de9501b11b1391a5fd7b132c1.camel@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:13:58AM -0400, James Bottomley wrote:
> On Mon, 2022-10-17 at 16:05 +0200, Michal Kubecek wrote:
> > Starting with commit 42fc9fee116f ("scsi: mpi3mr: Add helper
> > functions to
> > manage device's port"), kernel configured with CONFIG_SCSI_MPI3MR=m
> > and
> > CONFIG_SCSI_SAS_ATTRS=n fails to build because modpost cannot find
> > symbols
> > used in mpi3mr_transport.c:
> > 
> >   ERROR: modpost: "sas_port_alloc_num"
> > [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
> >   ERROR: modpost: "sas_remove_host" [drivers/scsi/mpi3mr/mpi3mr.ko]
> > undefined!
> >   ERROR: modpost: "sas_phy_alloc" [drivers/scsi/mpi3mr/mpi3mr.ko]
> > undefined!
> >   ERROR: modpost: "sas_phy_free" [drivers/scsi/mpi3mr/mpi3mr.ko]
> > undefined!
> >   ...
> > 
> > Add an explicit dependency of CONFIG_SCSI_MPI3MR on
> > CONFIG_SCSI_SAS_ATTRS
> > to prevent inconsistent configs.
> > 
> > Fixes: 42fc9fee116f ("scsi: mpi3mr: Add helper functions to manage
> > device's port")
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> > ---
> >  drivers/scsi/mpi3mr/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/mpi3mr/Kconfig
> > b/drivers/scsi/mpi3mr/Kconfig
> > index 8997531940c2..8ada8e8d25ac 100644
> > --- a/drivers/scsi/mpi3mr/Kconfig
> > +++ b/drivers/scsi/mpi3mr/Kconfig
> > @@ -2,7 +2,7 @@
> >  
> >  config SCSI_MPI3MR
> >  	tristate "Broadcom MPI3 Storage Controller Device Driver"
> > -	depends on PCI && SCSI
> > +	depends on PCI && SCSI && SCSI_SAS_ATTRS
> 
> This should probably be select not depends.
> 
> All transport attributes are designed to be selected.  The reason is to
> avoid people having to figure out what attributes they have to set in
> Kconfig before they see the HBAs they're interested in.

OK, I'll send v2 with select in a moment.

Michal
