Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119A570DF89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbjEWOlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbjEWOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:41:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7151B5;
        Tue, 23 May 2023 07:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACC6E63341;
        Tue, 23 May 2023 14:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054AEC433D2;
        Tue, 23 May 2023 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852867;
        bh=d9J3DkDPYoY3R19fL1JMV5Kh4ZEEyVTMhbq27T3m+Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etOhZG44wkJggVLmEJT26ihmCK04oldyLTDOs4/a17yQwOSWMGdPOrUlrOTRlcqdM
         HMqarlJcFu81mB4zFNS9MpyG8gLgBh/AZVslrR4Eo073J9Jpe1CbF+dwrimwJIMDJq
         sv4Thqo5bkx4pq4LJPvZ1K2q1hSHsE2m6IqvmLKtBqGn8LN+1ggaywHtOujvpUucJy
         6bFWMzNUskpAm3vg/NPOlPrsQo4jxcM/aSkXKYk36H2UYXs2zvqeP1GawNs3CBdDP5
         Rx9LmTIwyDqTEX8lXysrrqacTatQDqJRMkYEOag7/5+bfWJKS3NYKqoNRbIaK5INcX
         g3D5+AqswI92Q==
Date:   Tue, 23 May 2023 08:41:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] scsi: lpfc: Use struct_size() helper
Message-ID: <ZGzQt2VFG4P/Vufn@work>
References: <cover.1684358315.git.gustavoars@kernel.org>
 <99e06733f5f35c6cd62e05f530b93107bfd03362.1684358315.git.gustavoars@kernel.org>
 <202305171601.B3FF9D0BB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305171601.B3FF9D0BB@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 04:01:47PM -0700, Kees Cook wrote:
> On Wed, May 17, 2023 at 03:23:01PM -0600, Gustavo A. R. Silva wrote:
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
> >  drivers/scsi/lpfc/lpfc_ct.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
> > index e880d127d7f5..3b95c56023bf 100644
> > --- a/drivers/scsi/lpfc/lpfc_ct.c
> > +++ b/drivers/scsi/lpfc/lpfc_ct.c
> > @@ -3748,8 +3748,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
> >  		rap->obj[0].entity_id_len = vmid->vmid_len;
> >  		memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
> >  		size = RAPP_IDENT_OFFSET +
> > -			sizeof(struct lpfc_vmid_rapp_ident_list) +
> > -			sizeof(struct entity_id_object);
> > +			struct_size(rap, obj, rap->no_of_objects);
> 
> Has rap->no_of_objects always been "1"? (i.e. there was a prior
> multiplication here before...

Mmh.. not sure what multiplication you are talking about. I based these
changes on the fact that rap->no_of_objects is set to cpu_to_be32(1);
for both instances. It doesn't show up in the context of the patch, so
here you go:

3747                 rap->no_of_objects = cpu_to_be32(1);
3748                 rap->obj[0].entity_id_len = vmid->vmid_len;
3749                 memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
3750                 size = RAPP_IDENT_OFFSET +
3751                         sizeof(struct lpfc_vmid_rapp_ident_list) +
3752                         sizeof(struct entity_id_object);


--
Gustavo
