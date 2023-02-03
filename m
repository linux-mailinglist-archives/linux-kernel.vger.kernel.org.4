Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766CA68A245
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCSvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBCSvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:51:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51349F9DD;
        Fri,  3 Feb 2023 10:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C358B82B9A;
        Fri,  3 Feb 2023 18:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C6C433D2;
        Fri,  3 Feb 2023 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675450303;
        bh=QqZRC2u1boJy3Js5uYACGA8XtSEoaNlNJE2qWK+ux1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3oWAFWcfsWBsAJJTy2eYah2beg9p4R9K6ZfBEYAa/IJxDIF6EY4mtkvnL8ZbGz5r
         miQVkAU1Rn4U86BHuehUNtgqsmg2pP7QeVzsv4iETOVY4MRJ9ai05Ubn4BhS81Engj
         UoymAu2/9xZh2oR/nfu9Kn8/Kyfa5r6tka0ZPT/ohmuWgqF2C7C2mUQlSy3MIqkcch
         4cQIs+ndDKxZlqJZtiYBpt68xG1B8BL1MuG+StbefOGxonE4Oanp50KU523ePLbliv
         xYgFl3kZ1Ys8pzdqMMo1P6Tg+NPlS8fGYYUsa5sLgVlzTMzpwaA+Q1Ulcw82HOtHwc
         6JNL8QMEgXtDg==
Date:   Fri, 3 Feb 2023 10:54:01 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware: qcom_scm: modify
 qcom_scm_set_download_mode()
Message-ID: <20230203185401.gud52iyr3hoymhq5@ripper>
References: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
 <1bca9111-1ad4-ad1d-b30a-9d2fbddf9e3a@linaro.org>
 <3ca6d220-447e-0578-b525-3fb470be7edf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ca6d220-447e-0578-b525-3fb470be7edf@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:23:29PM +0530, Mukesh Ojha wrote:
> 
> 
> On 2/3/2023 8:21 PM, Srinivas Kandagatla wrote:
> > 
> > 
> > On 03/02/2023 10:17, Mukesh Ojha wrote:
> > > Modify qcom_scm_set_download_mode() such that it can support
> > > multiple modes. There is no functional change with this change.
> > > 
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > > Changes in v2:
> > >    - Stop changing legacy scm id for dload mode.
> > > 
> > >   drivers/firmware/qcom_scm.c | 15 +++++++--------
> > >   include/linux/qcom_scm.h    |  5 +++++
> > >   2 files changed, 12 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > > index cdbfe54..6245b97 100644
> > > --- a/drivers/firmware/qcom_scm.c
> > > +++ b/drivers/firmware/qcom_scm.c
> > > @@ -400,7 +400,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
> > >   }
> > >   EXPORT_SYMBOL(qcom_scm_set_remote_state);
> > > -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> > > +static int __qcom_scm_set_dload_mode(struct device *dev, enum
> > > qcom_download_mode mode)
> > >   {
> > >       struct qcom_scm_desc desc = {
> > >           .svc = QCOM_SCM_SVC_BOOT,
> > > @@ -410,12 +410,12 @@ static int __qcom_scm_set_dload_mode(struct
> > > device *dev, bool enable)
> > >           .owner = ARM_SMCCC_OWNER_SIP,
> > >       };
> > > -    desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> > > +    desc.args[1] = mode ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> > 
> > I think this line should be:
> > 
> >      desc.args[1] = mode;
> > 
> 
> Should be fine..for backward compatibility as we want to avoid what is
> passed to trust zone without check and since this is legacy code, i would
> like to avoid.
> 

Afaict you touch every caller of this function, so there is no concerns
about backwards compatibility.

With some use of imagination, this patch is likely intended to be
followed by some other patch which adds more values to the enum, at
which point the state you leave this in would be wrong.

> -Mukesh
> > 
> > --srini
> > 
> > >       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
> > >   }
> > > -static void qcom_scm_set_download_mode(bool enable)
> > > +static void qcom_scm_set_download_mode(enum qcom_download_mode mode)
> > >   {
> > >       bool avail;
> > >       int ret = 0;
> > > @@ -424,10 +424,9 @@ static void qcom_scm_set_download_mode(bool enable)
> > >                            QCOM_SCM_SVC_BOOT,
> > >                            QCOM_SCM_BOOT_SET_DLOAD_MODE);
> > >       if (avail) {
> > > -        ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> > > +        ret = __qcom_scm_set_dload_mode(__scm->dev, mode);
> > >       } else if (__scm->dload_mode_addr) {
> > > -        ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> > > -                enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> > > +        ret = qcom_scm_io_writel(__scm->dload_mode_addr, mode);
> > >       } else {
> > >           dev_err(__scm->dev,
> > >               "No available mechanism for setting download mode\n");
> > > @@ -1410,7 +1409,7 @@ static int qcom_scm_probe(struct
> > > platform_device *pdev)
> > >        * disabled below by a clean shutdown/reboot.
> > >        */
> > >       if (download_mode)
> > > -        qcom_scm_set_download_mode(true);
> > > +        qcom_scm_set_download_mode(QCOM_DOWNLOAD_FULLDUMP);
> > >       return 0;
> > >   }
> > > @@ -1419,7 +1418,7 @@ static void qcom_scm_shutdown(struct
> > > platform_device *pdev)
> > >   {
> > >       /* Clean shutdown, disable download mode to allow normal restart */
> > >       if (download_mode)
> > > -        qcom_scm_set_download_mode(false);
> > > +        qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
> > >   }
> > >   static const struct of_device_id qcom_scm_dt_match[] = {
> > > diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> > > index f833564..f9bc84e 100644
> > > --- a/include/linux/qcom_scm.h
> > > +++ b/include/linux/qcom_scm.h
> > > @@ -14,6 +14,11 @@
> > >   #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF    0x1
> > >   #define QCOM_SCM_HDCP_MAX_REQ_CNT    5
> > > +enum qcom_download_mode {

This is not an enumeration, it's a set of constants. Please use #define.

> > > +    QCOM_DOWNLOAD_NODUMP    = 0x00,
> > > +    QCOM_DOWNLOAD_FULLDUMP  = 0x10,
> > > +};

Regards,
Bjorn

> > > +
> > >   struct qcom_scm_hdcp_req {
> > >       u32 addr;
> > >       u32 val;
