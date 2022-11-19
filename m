Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B7D630D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiKSI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:56:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B199EB2;
        Sat, 19 Nov 2022 00:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE5E6009E;
        Sat, 19 Nov 2022 08:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511E8C433C1;
        Sat, 19 Nov 2022 08:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668848185;
        bh=krixhKpby3khoZS5ZrXiQOYkpJ3aUIRA96zasq5os58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qh0iMCLdTFFK024CYjNk1NiqC9BV6bhxUiEeq4wBDrjOZWe6BN6MNT6+Vt3pKZj61
         j30ndvwKFCl/vFUvOwWE0R49wkiv6bQcCUiuRqJk6Kk5w1XnAJpF9VnlXk9f1dDH/2
         Cwa3p19XwhzIC4Aaod5d7CC1jzdUQH+ovYB13y1LgKFTLga0DWfdLjoHw0qEily9He
         kWP7izjYKaED0Zp0nODboxV6ZGlb+dysss5sU/Xo5oXZ54XhWb9EYFF2eRdq+dNbyB
         8N0VRPcpPgwS80wRZtld6nlB5XwVF3oPm2iXOdkqvRgZyrGfmDkM1np4z07pzmDQ1Y
         lsWqaYGDise1g==
Date:   Sat, 19 Nov 2022 02:56:12 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2][next] scsi: qla2xxx: Replace one-element array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y3iaLCY68E6Stgrp@work>
References: <cover.1668814746.git.gustavoars@kernel.org>
 <faa40e6b31ecc9387ad1644bb1957aa53d7c682f.1668814746.git.gustavoars@kernel.org>
 <ef2881de-7843-97b5-8e0e-64c23ee168d8@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef2881de-7843-97b5-8e0e-64c23ee168d8@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 09:44:02AM +0100, Christophe JAILLET wrote:
> Le 19/11/2022 à 00:47, Gustavo A. R. Silva a écrit :
> > One-element arrays as fake flex arrays are deprecated and we are moving
> > towards adopting C99 flexible-array members, instead. So, replace
> > one-element array declaration in struct ct_sns_gpnft_rsp, which is
> > ultimately being used inside a union:
> > 
> > drivers/scsi/qla2xxx/qla_def.h:
> > 3240 struct ct_sns_gpnft_pkt {
> > 3241         union {
> > 3242                 struct ct_sns_req req;
> > 3243                 struct ct_sns_gpnft_rsp rsp;
> > 3244         } p;
> > 3245 };
> > 
> > Important to mention is that doing a build before/after this patch results
> > in no binary differences.
> 
> Hi,
> 
> even with the:
> 
> >   		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
> > -			((vha->hw->max_fibre_devices - 1) *
> > +			(vha->hw->max_fibre_devices *
> >   			    sizeof(struct ct_sns_gpn_ft_data));
> 
> change ?

Yep; that change compensates for the removal of the 1 in the declaration
of entries[].

The above piece of code is a common idiom to calculate the size for an
allocation when a one-element array is involved. In the original code
(vha->hw->max_fibre_devices - 1) compensates for the _extra_ size of one
element of type struct ct_sns_gpn_ft_data in sizeof(struct ct_sns_gpnft_rsp).

--
Gustavo

> 
> CJ
> 
> > 
> > This help us make progress towards globally enabling
> > -fstrict-flex-arrays=3 [1].
> > 
> > Link: https://github.com/KSPP/linux/issues/245
> > Link: https://github.com/KSPP/linux/issues/193
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   drivers/scsi/qla2xxx/qla_def.h | 4 ++--
> >   drivers/scsi/qla2xxx/qla_gs.c  | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
> > index a26a373be9da..1eea977ef426 100644
> > --- a/drivers/scsi/qla2xxx/qla_def.h
> > +++ b/drivers/scsi/qla2xxx/qla_def.h
> > @@ -3151,12 +3151,12 @@ struct ct_sns_gpnft_rsp {
> >   		uint8_t vendor_unique;
> >   	};
> >   	/* Assume the largest number of targets for the union */
> > -	struct ct_sns_gpn_ft_data {
> > +	DECLARE_FLEX_ARRAY(struct ct_sns_gpn_ft_data {
> >   		u8 control_byte;
> >   		u8 port_id[3];
> >   		u32 reserved;
> >   		u8 port_name[8];
> > -	} entries[1];
> > +	}, entries);
> >   };
> >   /* CT command response */
> > diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
> > index 64ab070b8716..69d3bc795f90 100644
> > --- a/drivers/scsi/qla2xxx/qla_gs.c
> > +++ b/drivers/scsi/qla2xxx/qla_gs.c
> > @@ -4073,7 +4073,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
> >   		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
> >   		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
> > -			((vha->hw->max_fibre_devices - 1) *
> > +			(vha->hw->max_fibre_devices *
> >   			    sizeof(struct ct_sns_gpn_ft_data));
> >   		sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
> 
