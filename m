Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72717630CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiKSHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKSHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:20:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADBA317A;
        Fri, 18 Nov 2022 23:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB8B60AC1;
        Sat, 19 Nov 2022 07:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F88C433C1;
        Sat, 19 Nov 2022 07:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668842422;
        bh=sW4bR0iino+52jhmCyIFPNfNs72ZrD2mGqFwf4IX264=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob2H1EUF3u2Qd3sE7bMNaJIehqs7LeqLnkshPiuSAFnKZBCS8084Snv+dzCsurabc
         K1T87oN1cOuFCIadyFxLXQbY3zRsXclKqnG82NvnTD598LBQdlE9oIGfptSibI6a+X
         6JXmIJJri24URftwRxGrcfXnU9Ob8IMMFZuCFEep0Cp4FNXZXq2vyP8J0X5eafIS22
         nTIyYRAAktBuphoDfvtcIOMEPsWMUyOQZQeGpYLcs8d5N2lN0qiVsl+xkvUMZA1d2h
         0Hy2tB0XTzySLgujEd1DTJl/0TepUzzREGHaquZHdc0ZxevM6uWkrk4jEQ2pwWyZMk
         7Xlmr2c/eoJTA==
Date:   Sat, 19 Nov 2022 01:20:09 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] scsi: qla2xxx: Use struct_size() in code
 related to struct ct_sns_gpnft_rsp
Message-ID: <Y3iDqTPFdoUQ3a0f@work>
References: <cover.1668814746.git.gustavoars@kernel.org>
 <9bd4775fe9c88b33c3194f841a2ec2f559d58032.1668814746.git.gustavoars@kernel.org>
 <202211182309.D5AC082E3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211182309.D5AC082E3@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:10:44PM -0800, Kees Cook wrote:
> On Fri, Nov 18, 2022 at 05:47:56PM -0600, Gustavo A. R. Silva wrote:
> > Prefer struct_size() over open-coded versions of idiom:
> > 
> > sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> > 
> > where count is the max number of items the flexible array is supposed to
> > contain.
> > 
> > Link: https://github.com/KSPP/linux/issues/160
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/scsi/qla2xxx/qla_gs.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
> > index 69d3bc795f90..27e1df56b0fb 100644
> > --- a/drivers/scsi/qla2xxx/qla_gs.c
> > +++ b/drivers/scsi/qla2xxx/qla_gs.c
> > @@ -4072,9 +4072,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
> >  		}
> >  		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
> >  
> > -		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
> > -			(vha->hw->max_fibre_devices *
> > -			    sizeof(struct ct_sns_gpn_ft_data));
> > +		rspsz = struct_size((struct ct_sns_gpnft_rsp *)0, entries,
> > +				vha->hw->max_fibre_devices);
> 
> This should be able to use sp->u.iocb_cmd.u.ctarg.rsp instead of the
> explicit struct with a NULL. (It's just using typeof() internally, so
> it's okay that it isn't allocated yet.)

mmh... yeah; and considering they're already going all the way down to
sp->u.iocb_cmd.u.ctarg.req_size, I think accessing sp->u.iocb_cmd.u.ctarg.rsp
is perfectly fine. :)

I'll respin. Thanks for the feedback!
--
Gustavo

> 
> -Kees
> 
> >  
> >  		sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
> >  								rspsz,
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Kees Cook
