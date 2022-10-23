Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB660924A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiJWKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJWKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 06:18:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F763D2E;
        Sun, 23 Oct 2022 03:18:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t18so5802405edt.2;
        Sun, 23 Oct 2022 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a49dQpt0mwa02CJjoTD0sBT5Nd7LDoy07iM+U677f/w=;
        b=Hct0GyHQnH/Jq61huSKY2p64NSsRz3QYoM7ZFS+JQXlUe6JAjydfdvAO+2pC9JxQ9N
         76fgONXMpbhQkpYVQ3hW6t697IrAoZVA1x0dxyPRmxwdfldIoiAC8JaMCF8C7S35k/L1
         MUuF6wDNba/A3/e3EPXcEtaF0O9ET9cpnjzNe4zgWwP0kMvccysRZhtfZ9lpI2KdfLSw
         iR8VAXM78sc/O7Qa4YG1mL40QxwuRzj2uDhE0BDCmKb65KBCOyreH5uo4kU1XKJoBRvl
         6Ag9JVwNk4/BW0HqetRzZTaqal1T5NgqCJSEWfQeoO49bTwsCyu6rIRqtArO3NnidJpC
         icQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a49dQpt0mwa02CJjoTD0sBT5Nd7LDoy07iM+U677f/w=;
        b=tQOQp9rpZkjXjikGRDqtNpUQ3qsRbdpzQtNT4G7Rr65eXavxg0vNE+FnQ9QojTxisi
         QR9/4jdAwKqafyy8SrFVVvVM5MoYZ13GldMYB5mL2NZl+xPhZICzwSBOTH4CX6L+eCAP
         EKzDFbFadnemD2cMHtxKrowywXeMyYNWZ78eABAuVVYwDXPwGGKU5J33XBWLfWIYm+q7
         AUXfml4rlOt2cjtenpYiPLDOSuEJ2m034wZ6HGeStg58QwBbWfiyiwHiEDvABVyO5XbP
         KRrT+hQSS6V9rbURQg8YWEUz2T5/bj4GfPZDf4dARWl5TOvbvsX6+evIDjkSx2jaw5ky
         VvZA==
X-Gm-Message-State: ACrzQf2P6tck9yakXDiFqJ4DxYxkwXE7wCSAggpA3HZx7iHorGuqa6Wq
        u5G63/ZnaKWDz4R0w5F/sutE4cbQsXdWuABuQkQ=
X-Google-Smtp-Source: AMsMyM60JZRumSTvt9G+5ddw2RQoBxrqxN3zHp19qYYqqnoZKtmC26HArvU3HzyL4l0OOGdrAtemgD59irSBv0+O2O0=
X-Received: by 2002:a05:6402:1e8d:b0:454:79a9:201f with SMTP id
 f13-20020a0564021e8d00b0045479a9201fmr26051157edf.176.1666520333531; Sun, 23
 Oct 2022 03:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221021015217.20272-1-zhewang116@gmail.com> <DM6PR04MB6575BA226F07DC4752235C79FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575BA226F07DC4752235C79FC2D9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Zhe Wang <zhewang116@gmail.com>
Date:   Sun, 23 Oct 2022 18:18:42 +0800
Message-ID: <CAJxzgGony0JQs07Uy1j9oNMmh+Y_rcG1u+gxAmze9TfxZCZ-OA@mail.gmail.com>
Subject: Re: [PATCH V2] scsi: ufs: core: Let delay value after LPM can be
 modified by vendor
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "zhe.wang1@unisoc.com" <zhe.wang1@unisoc.com>,
        "zhenxiong.lai@unisoc.com" <zhenxiong.lai@unisoc.com>,
        "yuelin.tang@unisoc.com" <yuelin.tang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Zhe Wang <zhe.wang1@unisoc.com>
> >
> > Some UFS devices require that the VCC should drop below 0.1V after
> > turning off, otherwise device may not resume successfully. And
> > because the power-off rate is different on different SOC platforms.
> > Therefore, we hope that the delay can be modified by vendor to
> > adjust the most appropriate delay value.
> >
> > Signed-off-by: Zhe Wang <zhe.wang1@unisoc.com>
> > ---
> > V1 -> V2
> > - move turnoff_delay_us to struct ufs_vreg instead
> > - replace usleep_range with ufshcd_delay_us
> >
> >  drivers/ufs/core/ufshcd.c | 9 ++++++++-
> >  include/ufs/ufs.h         | 1 +
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 7256e6c43ca6..386ff6ed2f20 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -89,6 +89,9 @@
> >  /* Polling time to wait for fDeviceInit */
> >  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
> >
> > +/* Default value of turn off VCC rail: 5000us */
> > +#define UFS_VCC_TURNOFF_DELAY_US 5000
> > +
> >  #define ufshcd_toggle_vreg(_dev, _vreg, _on)                           \
> >         ({                                                              \
> >                 int _ret;                                               \
> > @@ -7784,6 +7787,10 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
> >
> >         ufs_fixup_device_setup(hba);
> >
> > +       if (hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM &&
> > +           !hba->vreg_info.vcc->turnoff_delay_us)
> > +               hba->vreg_info.vcc->turnoff_delay_us =
> > UFS_VCC_TURNOFF_DELAY_US;
> > +
> You answered my question to your v1 - where otherwise you are setting this value:
> "We are still preparing and discussing our own UFS host driver code,
> which will be uploaded once we are done."
>
> Well until then - this isn't very useful.
>
> Thanks,
> Avri
>
> >         ufshcd_wb_probe(hba, desc_buf);
> >
> >         ufshcd_temp_notif_probe(hba, desc_buf);
> > @@ -8918,7 +8925,7 @@ static void ufshcd_vreg_set_lpm(struct ufs_hba *hba)
> >          */
> >         if (vcc_off && hba->vreg_info.vcc &&
> >                 hba->dev_quirks & UFS_DEVICE_QUIRK_DELAY_AFTER_LPM)
> > -               usleep_range(5000, 5100);
> > +               ufshcd_delay_us(hba->vreg_info.vcc->turnoff_delay_us, 100);
> >  }
> >
> >  #ifdef CONFIG_PM
> > diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> > index 1bba3fead2ce..792335dfd70b 100644
> > --- a/include/ufs/ufs.h
> > +++ b/include/ufs/ufs.h
> > @@ -569,6 +569,7 @@ struct ufs_vreg {
> >         bool always_on;
> >         bool enabled;
> >         int max_uA;
> > +       u32 turnoff_delay_us;
> >  };
> >
> >  struct ufs_vreg_info {
> > --
> > 2.17.1
>

OK, thanks for your review.

Thanks,
Zhe Wang
