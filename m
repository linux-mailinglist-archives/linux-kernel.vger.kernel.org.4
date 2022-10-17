Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101E60141C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJQQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:57:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B7A5F23D;
        Mon, 17 Oct 2022 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666025812;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3Sabb/ug9H7p9DkKJIV5v2qLEbScGY4rh4praJux+7c=;
    b=D9TkxMcida7gF0Hc5Q87BUnm7Z3qbDz0w7I/JUTm8fRqkD10Nex4PRvg26G+lSbkO7
    z3AvDZWravlZVFhjVXSwS8MuGVH67ChxlyZT+7YKShcM0AFYmBnFULnXCD5jjlp3dEyU
    djd2ql91c+BvjIzkww+pfhfp1sRUggj1cZQf3TkyzFc4BaRFl34GVALP4qWyeYpqrlwp
    ohiFc6kR0O6SY2LtflyDGlJicMNGFlooQNEK1QNd0j9oYMnUEIDrBgSPjSkJESl79wOK
    kUXjjqhGrzTETkwCP6F+5xPnyixuGuLQwsFdQyvHmtMyaDOyQ+Td3tDIHCgDm20Pw6oa
    RXDg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from [10.176.234.249]
    by smtp.strato.de (RZmta 48.2.0 AUTH)
    with ESMTPSA id zad98cy9HGunTIg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 Oct 2022 18:56:49 +0200 (CEST)
Message-ID: <f44cd84b206ae67e47ad101a1e85d4db40dcb680.camel@iokpp.de>
Subject: Re: [PATCH v2 2/2] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
From:   Bean Huo <beanhuo@iokpp.de>
To:     Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Oct 2022 18:56:49 +0200
In-Reply-To: <925af9f5-b05b-1b61-c905-d19cdc54ce19@acm.org>
References: <20221010092937.520013-1-beanhuo@iokpp.de>
         <20221010092937.520013-3-beanhuo@iokpp.de>
         <925af9f5-b05b-1b61-c905-d19cdc54ce19@acm.org>
Organization: IOKPP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

I took all your suggestions and will send new version patch tomorrow
when the autotest is complete.

thanks,
Bean

On Fri, 2022-10-14 at 14:05 -0700, Bart Van Assche wrote:
> On 10/10/22 02:29, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > Combine ufshcd_get_lu_power_on_wp_status() and
> > ufshcd_set_queue_depth()
> > into one single ufshcd_lu_init(), so that we only need to read the
> > LUN
> > descriptor once to replace the original twice.
>=20
> The following part can probably be left out from the patch
> description=20
> without reducing clarity: " to replace the original twice".
>=20
> > +/**
> > + * ufshcd_lu_power_on_wp_init - Initialize LU's power on write
> > protect state
> > + * @hba: per-adapter instance
> > + * @sdev: pointer to SCSI device
> > + * @b_lu_write_protect: bLUWriteProtect value read from LU
> > descriptor
> > + */
> > +static inline void ufshcd_lu_power_on_wp_init(struct ufs_hba *hba,
> > const struct scsi_device *sdev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8
> > b_lu_write_protect)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hba->dev_info.f_power_on=
_wp_en && !hba-
> > >dev_info.is_lu_power_on_wp &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b_lu_writ=
e_protect =3D=3D UFS_LU_POWER_ON_WP)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0hba->dev_info.is_lu_power_on_wp =3D true;
> > +}
>=20
> The body of this function is only three lines long and this function
> is=20
> only called once. Are you sure that you want a separate function
> instead=20
> of inlining this function in its only caller?
>=20
> > +static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device
> > *sdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 lun;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 lun_qdepth;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *desc_buf;
>=20
> Most kernel developers these days order local variable declarations
> from=20
> longest to shortest line ("reverse Christmas tree").
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lun_qdepth =3D hba->nutrs;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lun =3D ufshcd_scsi_to_upiu_=
lun(sdev->lun);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D hba->desc_size[QUERY=
_DESC_IDN_UNIT];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0desc_buf =3D kmalloc(len, GF=
P_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!desc_buf)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto set_qdepth;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ufshcd_read_unit_des=
c_param(hba, lun, 0, desc_buf,
> > len);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -EOPNOTSUPP)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/* If LU doesn't support unit descriptor, its queue
> > depth is set to 1 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0lun_qdepth =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (desc_buf[UNIT_DESC_=
PARAM_LU_Q_DEPTH])
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0lun_qdepth =3D min_t(int,
> > desc_buf[UNIT_DESC_PARAM_LU_Q_DEPTH], hba->nutrs);
>=20
> ufshcd_read_unit_desc_param() can return fewer bytes than requested.
> How=20
> about modifying ufshcd_read_unit_desc_param() such that it returns
> the=20
> number of bytes that has been copied and using that return value
> above=20
> to check whether at least UNIT_DESC_PARAM_LU_Q_DEPTH bytes have been=20
> initialized in desc_buf?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * According to UFS device s=
pec, The write protection mode
> > is only supported by normal LU,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not supported by WLUN.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret && lun < hba->dev_i=
nfo.max_lu_supported)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ufshcd_lu_power_on_wp_init(hba, sdev,
> > desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT]);
>=20
> Please insert an if (ret < 0) check after the=20
> ufshcd_read_unit_desc_param() call and jump to the kfree() statement
> if=20
> ret < 0 instead of checking several times whether or not ret < 0.
>=20
> Thanks,
>=20
> Bart.

