Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BD60C65E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiJYIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJYIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:25:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D1660FF;
        Tue, 25 Oct 2022 01:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49825CE1C03;
        Tue, 25 Oct 2022 08:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7934DC433C1;
        Tue, 25 Oct 2022 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666686302;
        bh=95Bw03v1d7DpNovUuUhhDHWGN1eDfLvag7c8d/BfT3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpgBnumk2WY6jmeSGjyimBupg2i/Gz6Fj2jYBdav4GuS3vZI/mAXM1HF8jxL7DUXp
         vktLYfItFNox/TbNJ489U1YqgjlZEOVxIRB5bS5ImslUiWGhPR9HuUcR27uK2zb94n
         oQlfJCv7PnTb43Ue5MKcOUWFWcvK8OI1OgChi5EmM1XsYrPqOH9BundJPug0e0u1Ni
         KCgwlpmLY4g8wOF/AJeQyb25VuU9ckJzdWMQ5OX/9FAVVu3atq1GxrDHge0QNTZNYe
         yAlAy8azCC5yH3WxWFduwVngJI9TYFKe19LHy0WEfr4XSlkv/3kKzfw1FmKc+QQzcR
         KGSLN0I3aEnow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1onFEq-0000ud-7S; Tue, 25 Oct 2022 10:24:44 +0200
Date:   Tue, 25 Oct 2022 10:24:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/4] soc: qcom: pmic_glink: Introduce altmode support
Message-ID: <Y1edTHlbaPlhxIuB@hovoldconsulting.com>
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
 <20220818031512.319310-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818031512.319310-4-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:15:11PM -0700, Bjorn Andersson wrote:
> With the PMIC GLINK service, the host OS subscribes to USB-C altmode
> messages, which are sent by the firmware to notify the host OS about
> state updates and HPD interrupts.
> 
> The pmic_glink_altmode driver registers for these notifications and
> propagates the notifications as typec_mux, typec_switch and DRM OOB
> notifications as necessary to implement DisplayPort altmode support.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/soc/qcom/Makefile             |   1 +
>  drivers/soc/qcom/pmic_glink_altmode.c | 477 ++++++++++++++++++++++++++
>  2 files changed, 478 insertions(+)
>  create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c

> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> new file mode 100644
> index 000000000000..8d2d563cb756
> --- /dev/null
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c

> +static void pmic_glink_altmode_worker(struct work_struct *work)
> +{
> +	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
> +	struct pmic_glink_altmode *altmode = alt_port->altmode;
> +
> +	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
> +
> +	if (alt_port->svid == USB_TYPEC_DP_SID)
> +		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
> +					     alt_port->hpd_state, alt_port->hpd_irq);
> +	else
> +		pmic_glink_altmode_enable_usb(altmode, alt_port);
> +
> +	if (alt_port->hpd_state)
> +		drm_bridge_hpd_notify(&alt_port->bridge, connector_status_connected);
> +	else
> +		drm_bridge_hpd_notify(&alt_port->bridge, connector_status_disconnected);
> +
> +	pmic_glink_altmode_request(altmode, ALTMODE_PAN_ACK, alt_port->index);
> +};

I'm seeing fairly frequent crashes during boot of the X13s due to these
notifications being propagated before things have been fully set up:

[   16.591910] panel-simple-dp-aux aux-aea0000.displayport-controller: Detected SHP LQ140M1JW48 (0x1511)
[   16.592142] qcom,fastrpc-cb 1b300000.remoteproc:glink-edge:fastrpc:compute-cb@12: Adding to iommu group 17
[   16.597644] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[   16.597653] Mem abort info:
[   16.597657]   ESR = 0x0000000096000004
[   16.597663]   EC = 0x25: DABT (current EL), IL = 32 bits
[   16.597670]   SET = 0, FnV = 0
[   16.597675]   EA = 0, S1PTW = 0
[   16.597680]   FSC = 0x04: level 0 translation fault
[   16.597686] Data abort info:
[   16.597689]   ISV = 0, ISS = 0x00000004
[   16.597694]   CM = 0, WnR = 0
[   16.597698] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000106b93000
[   16.597706] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
[   16.597722] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   16.597731] Dumping ftrace buffer:
[   16.597742]    (ftrace buffer empty)
[   16.597744] Modules linked in: fastrpc(+) rpmsg_ctrl qrtr_smd rpmsg_char qcom_battmgr pmic_glink_altmode rtc_pm8xxxr
[   16.597831] CPU: 0 PID: 389 Comm: kworker/0:3 Not tainted 6.1.0-rc2 #195
[   16.597838] Hardware name: Qualcomm QRD, BIOS 6.0.220110.BOOT.MXF.1.1-00470-MAKENA-1 01/10/2022
[   16.597842] Workqueue: events pmic_glink_altmode_worker [pmic_glink_altmode]
[   16.597864] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   16.597870] pc : drm_kms_helper_hotplug_event+0x1c/0x50
[   16.597882] lr : drm_kms_helper_hotplug_event+0x18/0x50
[   16.597887] sp : ffff80000c20bca0
[   16.597889] x29: ffff80000c20bca0 x28: ffffdba5eadbb000 x27: ffff22a9f6f2dc05
[   16.597898] x26: ffffdba5eadc0b20 x25: ffffdba5eadd8ca0 x24: 0000000000000000
[   16.597906] x23: 0000000000000003 x22: ffff22a888526000 x21: 0000000000000002
[   16.597914] x20: ffff22a88ceed000 x19: ffff22a888526000 x18: 0000000000000020
[   16.597921] x17: 4d003632323d524f x16: 4a414d00313d4755 x15: 4c50544f48006d72
[   16.597929] x14: 0000000000000001 x13: 0000000000000040 x12: 0000000000000000
[   16.597936] x11: 0000000000000000 x10: 0000000000000228 x9 : 0000000000000000
[   16.597944] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000062e00
[   16.597951] x5 : 0000000000000000 x4 : ffff22a9f6f2d290 x3 : 0000000000062f00
[   16.597959] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[   16.597965] Call trace:
[   16.597968]  drm_kms_helper_hotplug_event+0x1c/0x50
[   16.597973]  drm_bridge_connector_hpd_cb+0xa0/0xc0
[   16.597983]  drm_bridge_hpd_notify+0x40/0x60
[   16.597990]  pmic_glink_altmode_worker+0xc0/0x150 [pmic_glink_altmode]
[   16.598006]  process_one_work+0x288/0x6c0
[   16.598014]  worker_thread+0x74/0x450
[   16.598019]  kthread+0x118/0x120
[   16.598028]  ret_from_fork+0x10/0x20
[   16.598039] Code: f9000bf3 aa0003f3 97ff22af f9445e60 (f9400801) 
[   16.598043] ---[ end trace 0000000000000000 ]---
[   16.603424] [drm] Initialized msm 1.9.0 20130625 for ae01000.mdp on minor 0

I've verified that it is the funcs pointer in
drm_kms_helper_hotplug_event() which is NULL and a hack like the below
prevents the crash:

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 69b0b2b9cc1c..d515f5b6f3d5 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -661,7 +661,9 @@ void drm_kms_helper_hotplug_event(struct drm_device *dev)
 {
        /* send a uevent + call fbdev */
        drm_sysfs_hotplug_event(dev);
-       if (dev->mode_config.funcs->output_poll_changed)
+
+       WARN_ON(!dev->mode_config.funcs);
+       if (dev->mode_config.funcs && dev->mode_config.funcs->output_poll_changed)
                dev->mode_config.funcs->output_poll_changed(dev);
 
        drm_client_dev_hotplug(dev);

It appears that pointer is set in msm_drm_init(), which suggests events
are being forwarded before the driver is ready.

Johan
