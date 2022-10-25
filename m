Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DAD60CB36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiJYLp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiJYLoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:44:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8CEDECE;
        Tue, 25 Oct 2022 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666698261;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/T7xHT9Z2IDUSpjyKqLJDtXu1ZdgAr0BSgg/EankUec=;
    b=BotJy90wFl3W6XNRuPlp/bLFUzg/tZ2c2eG+Z2CqCd4RoJKA9M073Kzb3fCSmSUIki
    LkP67iVLwvJsYyijU9qagHNZoSlHTY5s3xJMRNMQswOZGX7ZpW+6WCSGl4g1tGEQSbiZ
    e1+usyiCHvLfJfmtj2yfMEuI2O0Q1ypMdrvVImQO4KlijGNqzwBVkfYFzuYKZbNNXmeA
    ngVao5d3GjV0efEphEBZAUnC5g7FHI07Wl3Q76lpXUfw5j+IoDSGbBMaSW6aaZ6z+MDF
    DlEiMUkeRNChg0kZ+y7ojaXzqSj2VDLZJSWXPkiHR9lBhKJP64xRXpbPwp9Un4Ww4HEn
    ZWtw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from [10.176.234.249]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfy9PBiI0W8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 25 Oct 2022 13:44:18 +0200 (CEST)
Message-ID: <2f0141705b06339d31063c731b0511fc186364fd.camel@iokpp.de>
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
From:   Bean Huo <beanhuo@iokpp.de>
To:     Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Oct 2022 13:44:18 +0200
In-Reply-To: <1915c52f-0c76-0f90-97e9-0c27c36a9e1a@acm.org>
References: <20221022213650.626766-1-beanhuo@iokpp.de>
         <20221022213650.626766-3-beanhuo@iokpp.de>
         <1915c52f-0c76-0f90-97e9-0c27c36a9e1a@acm.org>
Organization: IOKPP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-24 at 16:25 -0700, Bart Van Assche wrote:
> On 10/22/22 14:36, Bean Huo wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 lun_qdepth =3D hba->nutrs=
;
>=20
> How about changing this into hba->nutrs - 1 since one tag is reserved
> ('reserved_slot')?
>=20
> Thanks,


Bart,

If having a look at=C2=A0

scsi_change_queue_depth() {

  depth =3D min_t(int, depth, scsi_device_max_queue_depth(sdev));
	...
}

so the finnal depth per Lu is still 31.  I did test and debug, this is
true.



+set_qdepth:
+	/*
+	 * For WLUNs that don't support unit descriptor, queue depth
is set to 1. For LUs whose
+	 * bLUQueueDepth =3D=3D 0, the queue depth is set to a maximum
value that host can queue.
+	 */
+	dev_dbg(hba->dev, "Set LU %x queue depth %d\n", lun,
lun_qdepth);
+	scsi_change_queue_depth(sdev, lun_qdepth);=20



so lun_qdepth is 32, but scsi_change_queue_depth() will return 31,
since we set sdev->host->can_queue is 31.

If you need me to change the patch, let me know, it is no problem for
me to change to:=20


u8 lun_qdepth =3D hba->nutrs - UFSHCD_NUM_RESERVED.

or

u8 lun_qdepth =3D UFSHCD_CMD_PER_LUN.


Kind regards,
Bean


