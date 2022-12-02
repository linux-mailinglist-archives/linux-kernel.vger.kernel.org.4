Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5DD640F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiLBUv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiLBUvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C32AD9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670014188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lmJqjycXnIm3mfXptIlpVA/MYamH6IUZDJJdpxDnvuY=;
        b=SKpcVZsdw5AyU2Wyc+79bT9pxINWeihMzRmo1aPo84uZAfm0ab8ceV7AdefwgSrz9xIHLw
        Hs6EH2m7nF/ltCCVupLDW3jBZgbFUMldRUeSbYwNA/tKjSEOtQXnAoE494GyZ89m6dnu6x
        Qtdh1pNzVsoDt+YaWWt3GOi+KjEY23U=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-5U5y3sLlMniyk_o7lfX15g-1; Fri, 02 Dec 2022 15:49:44 -0500
X-MC-Unique: 5U5y3sLlMniyk_o7lfX15g-1
Received: by mail-oi1-f197.google.com with SMTP id c11-20020a056808138b00b0035a17dd854dso3312027oiw.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 12:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmJqjycXnIm3mfXptIlpVA/MYamH6IUZDJJdpxDnvuY=;
        b=Ea6D9B4WXQ9lbn9XPwT/IiTwQdo1n1e8JtJD8DL2exrElpPik9T0d524izSjlmRu5M
         p4mNZFqeijV6lzJkfi7GcY++eEjAr/FZ9/tIPh6JXO6A7jLAzhrn7iV40Rn7k3y1JS5k
         cYwfWFWXXKvbfEX6JTYlKCu74K8Q9lEH5YKvKwvqyGEW7H87gf/44RM6Ckz/keZnXRpM
         YWFFjfZrt/zGKeeDaa/T6NvnMxW9s8w3EUeMOVa45XI/V/ZaVnF4xLKEi+GYlY1PQc/6
         6oQEBefZPG4t25hx8pUqNTHbpBdj3+szc/zuMKk4uQgwiZmxPksAGaKA57325dY7FZ2u
         unCw==
X-Gm-Message-State: ANoB5plkdykWtoNuQj22dGxiXjrUGgs8kacmdhHKC22QS2+dlqDnRx56
        CcWj2nIYMeQ3TFt4PeDcK+o7yr5eEqWCIITV4r8/AdRTIKSPrgqZG3qjOWaytWlQQYbFPqprHgp
        Dz/IXXxN7DsZ963OAZkvhjFnQ
X-Received: by 2002:a54:4714:0:b0:35a:7a65:5b76 with SMTP id k20-20020a544714000000b0035a7a655b76mr26774392oik.108.1670014184130;
        Fri, 02 Dec 2022 12:49:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6noLIf8pat9k4yYYZCWskVIULw37YazTQF+DxXXYYiq1qokYwFtLvCMg92rUjW390wZnssIw==
X-Received: by 2002:a54:4714:0:b0:35a:7a65:5b76 with SMTP id k20-20020a544714000000b0035a7a655b76mr26774375oik.108.1670014183872;
        Fri, 02 Dec 2022 12:49:43 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id fo12-20020a0568709a0c00b001431bf4e5a0sm4724774oab.38.2022.12.02.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 12:49:43 -0800 (PST)
Date:   Fri, 2 Dec 2022 14:49:40 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v4 00/23] ufs: qcom: Add HS-G4 support
Message-ID: <20221202204940.ojk5e43mu3lbmr2r@halaney-x13s>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:13:05PM +0530, Manivannan Sadhasivam wrote:
> Hello,
>
> This series adds HS-G4 support to the Qcom UFS driver and PHY driver.
> The newer Qcom platforms support configuring the UFS controller and PHY
> in dual gears (i.e., controller/PHY can be configured to run in two gear
> speeds). This is accomplished by adding two different PHY init sequences
> to the PHY driver and the UFS driver requesting the one that's required
> based on the platform configuration.
>
> Initially the ufs-qcom driver will use the default gear G2 for enumerating
> the UFS device. Afer enumeration, the max gear supported by both the
> controller and device would be found out and that will be used thereafter.
> But for using the max gear after enumeration, the ufs-qcom driver requires
> the UFS device to be reinitialized. For this purpose, a separate quirk has
> been introduced in the UFS core along with a callback and those will be used
> by the ufs-qcom driver.
>
> This series has been tested on following platforms:
>
> * Qcom RB5 development platform powered by SM8250 SoC
> * SM8450 based dev board
>
> Merging Strategy:
> -----------------
>
> The PHY patches are expected to go through PHY tree and UFS, MAINTAINERS
> patches are expected to go through SCSI tree.
>
> NOTE: Since this series targets multiple SoCs (base like SM8350) and
> (derivative like SC8280XP), testing on all of these platforms is really
> appreciated. Although, if the series works for base SoC, then for derivatives
> also it should work.

Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride

Without this patch series, the board's operating in gear 3. With it the
board's operating in gear 4. Gentle reminder sa8540p-ride is a SC8280XP
derivative.

I'm not really proficient in storage benchmarking, but a simple dd test
showed the following (sorry for the poor output, console got a
little wacky on the output).

Gear 3:
    [root@localhost ~]# dd bs=4k oflag=direct if=/dev/zero of=/dev/disk/by-partlabel/userdata
    dd: error writing '/dev/disk/by-partlabel/userdata': No space left on device
    19873276+0 records in
    19873275+0 records out
    81400934400 bytes (81 GB, 76 GiB) copied, 864.111 s, 94.2 MB/s
    [root@localhost ~]# dd bs=4k if=/dev/disk/by-partlabel/userdata of=/dev/null
    19873275+0 records in
    19873275+0 records out
    81400934400 bytes (81 GB, 76 GiB) copied, 75.7823 s, 1.1 GB/s
    [root@localhost ~]#

Gear 4:
    [root@localhost ~]# dd bs=4k oflag=direct if=/dev/zero of=/dev/disk/by-partlabel/userdata
    [   81.651598] ufshcd-qcom 1d84000.ufs: ufs_qcom_get_hs_gear: 296: UFS_HS_G4
    [   81.658592] ufshcd-qcom 1d84000.ufs: ufs_qcom_pwr_change_notify: 731: Agreed gear: 4
    [root@localhost ~]#  GB, 76 GiB) copied, 738.015 s, 110 MB/s
    [root@localhost ~]# dd bs=4k if=/dev/disk/by-partlabel/userdata of=/dev/null
    19873275+0 records in
    19873275+0 records out
    81400934400 bytes (81 GB, 76 GiB) copied, 63.9846 s, 1.3 GB/s
    [root@localhost ~]#

So a bit of a performance gain was seen with this patch series :)

Thanks,
Andrew

>
> Thanks,
> Mani
>
> Changes in v4:
>
> * Dropped HS G3 specific setting from SM8350 default init sequence
> * Added G4 support to SM8350 and SC8280XP
> * Covered all qcom files under drivers/ufs/host in MAINTAINERS file
> * Added missing Suggested-by tags for Can Guo
> * Rebased on top of linux-next 20221201
>
> Changes in v3:
>
> * Dropped the "device-max-gear" DT property and switched to reinitialization (Krzysztof)
> * Added HS-G4 support to all compatible SoCs (SM8150, SM8250 and SM8450). This will also
>   benefit the derivative SoCs of these platforms like SC8180x, SC8280x etc...
> * Splitted the qmp_phy_init_tbl changes into separate patches (Vinod)
> * Collected reviews from Andrew H
>
> Changes in v2:
>
> * Collected reviews from Dmitry
> * Renamed "max-gear" property to "max-device-gear"
> * Used min() for deciding which gear to use instead of open comparision
> * Added comment about the old register name
>
> Manivannan Sadhasivam (23):
>   phy: qcom-qmp-ufs: Remove _tbl suffix from qmp_phy_init_tbl
>     definitions
>   phy: qcom-qmp-ufs: Rename MSM8996 PHY definitions
>   phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tbls struct
>   phy: qcom-qmp-ufs: Add support for configuring PHY in HS Series B mode
>   phy: qcom-qmp-ufs: Add support for configuring PHY in HS G4 mode
>   phy: qcom-qmp-ufs: Move HS Rate B register setting to tbls_hs_b
>   phy: qcom-qmp-ufs: Add HS G4 mode support to SM8150 SoC
>   phy: qcom-qmp-ufs: Add HS G4 mode support to SM8250 SoC
>   phy: qcom-qmp-ufs: Avoid setting HS G3 specific registers
>   phy: qcom-qmp-ufs: Add HS G4 mode support to SM8350 SoC
>   phy: qcom-qmp-ufs: Add HS G4 mode support to SM8450 SoC
>   phy: qcom-qmp-ufs: Add HS G4 mode support to SC8280XP SoC
>   scsi: ufs: ufs-qcom: Remove un-necessary goto statements
>   scsi: ufs: ufs-qcom: Remove un-necessary WARN_ON()
>   scsi: ufs: ufs-qcom: Use bitfields where appropriate
>   scsi: ufs: ufs-qcom: Use dev_err_probe() for printing probe error
>   scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0
>   scsi: ufs: core: Add reinit_notify() callback
>   scsi: ufs: core: Add support for reinitializing the UFS device
>   scsi: ufs: ufs-qcom: Factor out the logic finding the HS Gear
>   scsi: ufs: ufs-qcom: Add support for reinitializing the UFS device
>   scsi: ufs: ufs-qcom: Add support for finding max gear on new platforms
>   MAINTAINERS: Add myself as the maintainer for Qcom UFS drivers
>
>  MAINTAINERS                                   |   8 +
>  .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h    |   1 +
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 454 +++++++++++++-----
>  drivers/ufs/core/ufshcd-priv.h                |   6 +
>  drivers/ufs/core/ufshcd.c                     |  63 ++-
>  drivers/ufs/host/ufs-qcom.c                   | 170 +++----
>  drivers/ufs/host/ufs-qcom.h                   |  70 +--
>  include/ufs/ufshcd.h                          |   8 +
>  8 files changed, 532 insertions(+), 248 deletions(-)
>
> --
> 2.25.1
>

