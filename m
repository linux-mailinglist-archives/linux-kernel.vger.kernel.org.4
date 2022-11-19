Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8F630D05
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiKSHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:49:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670D4A056;
        Fri, 18 Nov 2022 23:49:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFEE260B04;
        Sat, 19 Nov 2022 07:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324C3C433D6;
        Sat, 19 Nov 2022 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668844170;
        bh=1iHofFxDs+k8g+czw81aPVHhnz1WiyY0BGTlSsyDFb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZE7grWCns5eIT52eXsP4/vCsLtIgeA/U6BgzMNPwEzpDce/RozHobnuFfX23T8qtl
         2mzNw3AAoxbI3OYqwvIfUteCj38NRsSDmNLbn8s74yBYKIkjn3/RBJHK7dvJxBWj5Q
         mMDRpQW0GLhkZVqBrCOWJZ0KqFJVgPSrFWxs5440VsP+woBNTbG6eqanTHqr/6tNaO
         p+R+nySiY6kZTqBCbEavB3zFzUDeeJpcz3enBXsSOlO9MIqnjF1gLDgcHmT+NfiAfo
         Qe6MRHuWWNh8uE/TKifzYChpL2Zj1NronlpPHJxA7S/Ec42ZuBFS++rgSgzKEK6DIl
         cABmSp2nQGE3Q==
Date:   Sat, 19 Nov 2022 01:49:16 -0600
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
Message-ID: <Y3iKfHMmsm3UF23M@work>
References: <cover.1668814746.git.gustavoars@kernel.org>
 <9bd4775fe9c88b33c3194f841a2ec2f559d58032.1668814746.git.gustavoars@kernel.org>
 <202211182309.D5AC082E3@keescook>
 <Y3iDqTPFdoUQ3a0f@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3iDqTPFdoUQ3a0f@work>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 01:20:09AM -0600, Gustavo A. R. Silva wrote:
> On Fri, Nov 18, 2022 at 11:10:44PM -0800, Kees Cook wrote:
> > On Fri, Nov 18, 2022 at 05:47:56PM -0600, Gustavo A. R. Silva wrote:
> > > Prefer struct_size() over open-coded versions of idiom:
> > > 
> > > sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> > > 
> > > where count is the max number of items the flexible array is supposed to
> > > contain.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/160
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >  drivers/scsi/qla2xxx/qla_gs.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
> > > index 69d3bc795f90..27e1df56b0fb 100644
> > > --- a/drivers/scsi/qla2xxx/qla_gs.c
> > > +++ b/drivers/scsi/qla2xxx/qla_gs.c
> > > @@ -4072,9 +4072,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
> > >  		}
> > >  		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
> > >  
> > > -		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
> > > -			(vha->hw->max_fibre_devices *
> > > -			    sizeof(struct ct_sns_gpn_ft_data));
> > > +		rspsz = struct_size((struct ct_sns_gpnft_rsp *)0, entries,
> > > +				vha->hw->max_fibre_devices);
> > 
> > This should be able to use sp->u.iocb_cmd.u.ctarg.rsp instead of the
> > explicit struct with a NULL. (It's just using typeof() internally, so
> > it's okay that it isn't allocated yet.)
> 
> mmh... yeah; and considering they're already going all the way down to
> sp->u.iocb_cmd.u.ctarg.req_size, I think accessing sp->u.iocb_cmd.u.ctarg.rsp
> is perfectly fine. :)

except that... it seems sp->u.iocb_cmd.u.ctarg.rsp is a pointer to void
and not a struct of type struct ct_sns_gpnft_rsp. :O

drivers/scsi/qla2xxx/qla_def.h:474:
struct ct_arg {
        void            *iocb;
        u16             nport_handle;
        dma_addr_t      req_dma;
        dma_addr_t      rsp_dma;
        u32             req_size;
        u32             rsp_size;
        u32             req_allocated_size;
        u32             rsp_allocated_size;
        void            *req;
        void            *rsp;
        port_id_t       id;
};

I wonder if you wanted to point out something entirely different...?

--
Gustavo
