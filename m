Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067676219CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiKHQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiKHQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:50:21 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE6157B5A;
        Tue,  8 Nov 2022 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667926210;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7c4OzQgE338JFPjKcpP/KZGKw9KzVGPVi+wsbrwESPg=;
    b=H9qX5HGT08ageoyoTrM/5eynuJeG3sAEVlIi7FvCgDS8VD9gsoHUgQfxpGx3AYK/2b
    xsJMTuotiETPquVvJxHcU507L7HJ4+y7TSMH2eZREDQmjeA4em5wg+DrkhXLhF1z6dBB
    5AIUyQ6dWpRyeuxfWamda+dPINM/QPdNUB5LjPlvjeYeqfrJ++6H2a0shYYpmaTScZ01
    bGPfx9kAdrZmVSeITfBc6lS7ffGQsqa6CrLUkEkauZTP87/07VsoG9gDg3nASP0Va1cV
    051KDIJku4X5oJl2WiAGImQfbGjUMgp+5L9tSY54KCzwYhSZXJFo5IX2DXlH0nO2nhou
    rUEQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyA8Go7p2k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Nov 2022 17:50:07 +0100 (CET)
Message-ID: <1eda1c55fdf8292c2912c6d0adb741d8dd7f0a20.camel@iokpp.de>
Subject: Re: [RFC PATCH v1 1/2] ufs: core: Advanced RPMB detection
From:   Bean Huo <beanhuo@iokpp.de>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Nov 2022 17:50:06 +0100
In-Reply-To: <DM6PR04MB6575145B168BB80F3D2910A7FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
         <20221107131038.201724-2-beanhuo@iokpp.de>
         <DM6PR04MB6575145B168BB80F3D2910A7FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avri, 

thanks for your review.

On Tue, 2022-11-08 at 13:40 +0000, Avri Altman wrote:
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > Check UFS Advanced RPMB LU enablement during ufshcd_lu_init().
> > 
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > ---
> >  drivers/ufs/core/ufshcd.c | 4 ++++
> >  include/ufs/ufs.h         | 3 +++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index
> > ee73d7036133..d49e7a0b82ca 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -4940,6 +4940,10 @@ static void ufshcd_lu_init(struct ufs_hba
> > *hba,
> > struct scsi_device *sdev)
> >             desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT] ==
> > UFS_LU_POWER_ON_WP)
> >                 hba->dev_info.is_lu_power_on_wp = true;
> > 
> > +       if (desc_buf[UNIT_DESC_PARAM_UNIT_INDEX] == UFS_RPMB_UNIT
> > &&
> Please remind me why do we need both UFS_RPMB_UNIT and
> UFS_UPIU_RPMB_WLUN ?

I see. they are the same value, we should remove one, will change it in
next version.
> 
> > +           desc_buf[UNIT_DESC_PARAM_RPMB_REGION_EN] & 1 << 4)
> (1 << 4) or BIT(4) ?
> 
> > +                       hba->dev_info.b_advanced_rpmb_en = true;
> > +
> >         kfree(desc_buf);
> >  set_qdepth:
> >         /*
> > diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h index
> > 1bba3fead2ce..2e617ab87750 100644
> > --- a/include/ufs/ufs.h
> > +++ b/include/ufs/ufs.h
> > @@ -199,6 +199,7 @@ enum unit_desc_param {
> >         UNIT_DESC_PARAM_PSA_SENSITIVE           = 0x7,
> >         UNIT_DESC_PARAM_MEM_TYPE                = 0x8,
> >         UNIT_DESC_PARAM_DATA_RELIABILITY        = 0x9,
> > +       UNIT_DESC_PARAM_RPMB_REGION_EN          = 0x9,
> This is awkward.  Better to define it, or - 
> Maybe it's time for rpmb to have its own unit descriptor - it surely
> deserve it.
>  

no problem, let me think about it, will add in the next version.




Kind regards,
Bean

