Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B763B1C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiK1TBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiK1TBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:01:40 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A527B1F;
        Mon, 28 Nov 2022 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669662090;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ErdC6uu5zPnOUyN95Vazd0I9LlC4+nj26wXSX8wJOBM=;
    b=sci7gHyswfIaP0MIdvkQoxohbyJSsSEAJnvsmlhP0YiTBAaMulEZLHxe+6z4uVVw/L
    un3SwguNm0LvGLzsyUMfXJyPFqcn+7P1fhFruK7X22QuT0gpPkSd7T9mBwRJ4f7KOHXr
    Ad++O01zFT/NasucRGN9TYwHid4OpbsEDe7A4P+V/1ej69JT1oyTon4e2r7yiKtvJGmE
    esJEfA2k+k3ObJ0xY6Z+bdg2Xf1mpPl1618e/QEbmhahLE2+930RuAHcmNbsjB9Wj2Ei
    TfKksSK0+CZd0Rp5N8k7UAcsBvgerxmOiuT94miHdn2HPmSSkm9Jt+Z7D5TNECpUYYfq
    m5Ng==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyASJ1S5Ew
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 28 Nov 2022 20:01:28 +0100 (CET)
Message-ID: <12c9e417168cdc044b9fd53c30d02ccab29179b2.camel@iokpp.de>
Subject: Re: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
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
Date:   Mon, 28 Nov 2022 20:01:27 +0100
In-Reply-To: <DM6PR04MB6575750D9C6F84FC3BE06AFBFC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
         <20221120222217.108492-7-beanhuo@iokpp.de>
         <DM6PR04MB6575750D9C6F84FC3BE06AFBFC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 11:55 +0000, Avri Altman wrote:
> > +static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba,
> > struct
> > +bsg_job *job) {
> > +       struct ufs_rpmb_request *rpmb_request = job->request;
> > +       struct ufs_rpmb_reply *rpmb_reply = job->reply;
> > +       struct bsg_buffer *payload = NULL;
> > +       enum dma_data_direction dir;
> > +       struct scatterlist *sg_list;
> > +       int rpmb_req_type;
> > +       int sg_cnt;
> > +       int ret;
> > +       int data_len;
> > +
> > +       if (hba->ufs_version < ufshci_version(4, 0) || !hba-
> > > dev_info.b_advanced_rpmb_en ||
> > +           !(hba->capabilities & MASK_EHSLUTRD_SUPPORTED))
> > +               return -EINVAL;
> > +
> > +       if (rpmb_request->ehs_req.length != 2 || rpmb_request-
> > > ehs_req.ehs_type != 1)
> > +               return -EINVAL;
> Maybe you could also check:
> In case of rpmb write, the request payload 4096 × Advanced RPMB Block
> Count,
> And same goes for response payload for rpmb read.
> 
> Thanks,
> Avri
> 

Hi Avri, 

in Spec:

"If the Block Count indicates a value greater than bRPMB_ReadWriteSize,
then the authenticated data write/read operation fails and the Result
is set to “General failure” (0001h)."


I think this should be checked in the application in userspace because
if the application passes a wrong/incorrect payload length, it will
error out and have no effect on UFS. In order to add this check in a
driver in the kernel, we need to maintain bRPMB_ReadWriteSize in kernel
space. Sometimes this is a waste of resources because we don't know if
the client will access the RPMB.

I have enabled Advanced RPMB feature in the ufs-utils as an example,
will be refered in cover-letter in the next version.

Kind regards,
Bean

