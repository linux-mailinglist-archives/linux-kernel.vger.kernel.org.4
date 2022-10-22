Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99A608FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJVVag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJVVac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:30:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837431377;
        Sat, 22 Oct 2022 14:30:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a67so18163751edf.12;
        Sat, 22 Oct 2022 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+hGdhRgOCzlkGtKUjyz6dck4ikAJQvjzGJB7xTbBslg=;
        b=JNtQjpGOqnt59MtqDZi7dQWCFmvlmHe9m3yFh2Fyok5MK+ZXDTWLlwEU1NsQu4mSPr
         Ead+0IYopERTVC+xsIIDWKLFYbYhYe4eBaS2GaiOa40R2Hgqzu12tbw43GfW9Gx6aFb8
         9slHnfade+jRT+3eKbLEuRurK4BuywBGNELNXM49CrZ/aQR2JWV3GlK3i00GatbvNAvr
         hYHhK73DpT54FgGEPJ5TVWVRLjgRX7PlGKYRGdMPKDakFu4zJ2IVciqUj+Iad6vwtNB6
         +Ze2ZK0CiANg975PgcbuNxUQ2FX7KfiNmB/nV9KGm6QitjjVwQfOMBdF+nHmp930bY1q
         yF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hGdhRgOCzlkGtKUjyz6dck4ikAJQvjzGJB7xTbBslg=;
        b=TCva3CX9TPTO6W+MMJ+RAacEF1zukoK9+/NmURejc2CruodsahodI4m/OkLCV5RNQE
         bLYgmn73VBsdP/MpCw1Jz7yVPEHEHtk97A/rJA2L5uMhCjBm2GhUkiLYynV52zgoW3uf
         loUv7LB0zXW9y8XDCgbgRisIGNQFGmIFVfxvmwJUFEw3EqyB1jr8kHChfYSOqZHS9EJU
         aXe7t3FT/Hwg7ddRwHDtS+0TWfa6rEgemYVKwzrwunVgpOGQT5TJJ61m/r1y8QEcykMj
         4Q9g4No1UYc9hOpjvu12F/qmmg4lr79pIxwTLGSJ3X5Fw2dyVzcgUN99eeVqqqfKwzFx
         kn2g==
X-Gm-Message-State: ACrzQf1y9B3md3B3hqc8Meas5gDNwF/+pHCFjRgYlPvALCawdLUnvAD5
        RzuFTJPBYPw64Tk0ifR41WY=
X-Google-Smtp-Source: AMsMyM4FtJOwMxwlm7U+8P5D3jLJFqk7zt60mAWDgnsdb6NdYXlj6Z4t+VfmqyLjmKaSnDCuxDgnEg==
X-Received: by 2002:a17:907:3e01:b0:730:a690:a211 with SMTP id hp1-20020a1709073e0100b00730a690a211mr21150540ejc.596.1666474228786;
        Sat, 22 Oct 2022 14:30:28 -0700 (PDT)
Received: from [192.168.3.3] (p5798b771.dip0.t-ipconnect.de. [87.152.183.113])
        by smtp.googlemail.com with ESMTPSA id f13-20020a056402068d00b0045c3f6ad4c7sm4312930edy.62.2022.10.22.14.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 14:30:28 -0700 (PDT)
Message-ID: <3112c599b68342ced021dab4521c96aca95e5bff.camel@gmail.com>
Subject: Re: [PATCH v3 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 22 Oct 2022 23:30:27 +0200
In-Reply-To: <9868763a-d360-db53-02b9-2d7ab9628d79@acm.org>
References: <20221018181627.326657-1-beanhuo@iokpp.de>
         <20221018181627.326657-3-beanhuo@iokpp.de>
         <9868763a-d360-db53-02b9-2d7ab9628d79@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-18 at 11:27 -0700, Bart Van Assche wrote:
> Should a test be added that verifies that UNIT_DESC_PARAM_LU_Q_DEPTH
> < len?
>=20
> Additionally, please use braces ({}) around multi-line if-statement
> bodies.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * According to UFS device s=
pecification, the write
> > protection mode is only supported by
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * normal LU, not supported =
by WLUN.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hba->dev_info.f_power_on=
_wp_en && lun < hba-
> > >dev_info.max_lu_supported &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !hba->dev=
_info.is_lu_power_on_wp &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc_buf[=
UNIT_DESC_PARAM_LU_WR_PROTECT] =3D=3D
> > UFS_LU_POWER_ON_WP)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0hba->dev_info.is_lu_power_on_wp =3D true;
>=20
> Also here, should the following test be added:=20
> UNIT_DESC_PARAM_LU_WR_PROTECT < len?
>=20
> Otherwise this patch looks good to me.

Bart,=20

len is already the LU descriptor size. UNIT_DESC_PARAM_LU_Q_DEPTH (0x6)
and UNIT_DESC_PARAM_LU_WR_PROTECT(0x5) are very basic parameters in the
LU descriptor, no matter what version of UFS is, there are these two
parameters in the descriptor. So the return value of
ufshcd_read_unit_desc_param() will be -EOPNOTSUPP, -EINVAL, -ENOMEM or
0 (successful read of LU descriptor). the checkup of "< len" is not
neccessary.

Kind regards,
Bean
