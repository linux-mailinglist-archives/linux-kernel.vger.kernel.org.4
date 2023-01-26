Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC267C60C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjAZIk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjAZIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:40:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F8228D31;
        Thu, 26 Jan 2023 00:40:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80FE161755;
        Thu, 26 Jan 2023 08:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9507C433D2;
        Thu, 26 Jan 2023 08:40:01 +0000 (UTC)
Message-ID: <7d1a375a-c3d1-0f8e-4d69-10dedacf6974@xs4all.nl>
Date:   Thu, 26 Jan 2023 09:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 4/6] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver v4l2 controls handler
Content-Language: en-US
To:     yuji2.ishikawa@toshiba.co.jp, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael.j.wysocki@intel.com, broonie@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-5-yuji2.ishikawa@toshiba.co.jp>
 <741cc02e-9d72-db59-171a-14bbd7925c7c@xs4all.nl>
 <TYAPR01MB6201386D11891171A984744792CF9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <TYAPR01MB6201386D11891171A984744792CF9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 01:38, yuji2.ishikawa@toshiba.co.jp wrote:
>>> +#define VISCONTI_VIIF_DPC_TABLE_SIZE 8192
>>> +static int viif_l1_set_dpc(struct viif_device *viif_dev, struct viif_l1_dpc_config
>> *l1_dpc)
>>> +{
>>> +	uintptr_t table_h_paddr = 0;
>>> +	uintptr_t table_m_paddr = 0;
>>> +	uintptr_t table_l_paddr = 0;
>>> +	unsigned long irqflags;
>>> +	int ret;
>>> +
>>> +	if (l1_dpc->table_h_addr) {
>>> +		if (copy_from_user(viif_dev->table_vaddr->dpc_table_h,
>>> +				   u64_to_user_ptr(l1_dpc->table_h_addr),
>>> +				   VISCONTI_VIIF_DPC_TABLE_SIZE))
>>> +			return -EFAULT;
>>
>> NACK!
>>
>> I thought those addresses in a struct were iffy. This is not supported, it
>> basically bypasses the whole control framework.
> 
> I understand. 
> 
>> The way to do this is to create separate array controls for these tables.
>> And table_h_addr becomes a simple 0 or 1 value, indicating whether to use
>> the table set by that control. For small arrays it is also an option to
>> embed them in the control structure.
> 
> As I wrote in reply for patch 2/6, I thought embedding is the only solution.
> Thank you for giving another plan: adding controls for tables.
> When I use individual controls for tables, are there some orderings between controls?
>  -- such that control DPC_TABLE_{H,M,L} should be configured before SET_DPC

There is no ordering dependency. But you can cluster controls:

https://linuxtv.org/downloads/v4l-dvb-apis-new/driver-api/v4l2-controls.html#control-clusters

The idea is that userspace sets all the related controls with one VIDIOC_S_EXT_CTRLS
ioctl, and then for the clustered controls the s_ctrl callback is called only
once.

You can also check in try_ctrl if the controls in a cluster are sane. E.g.
if control A has value 1, and that requires that control B has a value >= 5,
then try_ctrl can verify that. Normally controls are independent from one
another, but clustering will link them together.

It's really what you want here. A good example is here: drivers/media/common/cx2341x.c
It's used by several PCI drivers that use this MPEG codec chipset, and it uses
clusters and also implements try_ctrl.

> 
>> Are these l, h and m tables independent from one another? I.e. is it possible
>> to set l but not h and m? I suspect it is all or nothing, and in that case you
>> need only a single control to set all three tables (a two dimensional array).
> 
> These three tables can be setup individually.
> 
>> Anyway, the same issue applies to all the controls were you pass addresses for
>> tables, that all needs to change.
> 
> All right. These controls must be fixed.
> 
>>> +		table_h_paddr =
>> (uintptr_t)viif_dev->table_paddr->dpc_table_h;
>>> +	}
>>> +	if (l1_dpc->table_m_addr) {
>>> +		if (copy_from_user(viif_dev->table_vaddr->dpc_table_m,
>>> +				   u64_to_user_ptr(l1_dpc->table_m_addr),
>>> +				   VISCONTI_VIIF_DPC_TABLE_SIZE))
>>> +			return -EFAULT;
>>> +		table_m_paddr =
>> (uintptr_t)viif_dev->table_paddr->dpc_table_m;
>>> +	}
>>> +	if (l1_dpc->table_l_addr) {
>>> +		if (copy_from_user(viif_dev->table_vaddr->dpc_table_l,
>>> +				   u64_to_user_ptr(l1_dpc->table_l_addr),
>>> +				   VISCONTI_VIIF_DPC_TABLE_SIZE))
>>> +			return -EFAULT;
>>> +		table_l_paddr = (uintptr_t)viif_dev->table_paddr->dpc_table_l;
>>> +	}
>>> +
>>> +	spin_lock_irqsave(&viif_dev->lock, irqflags);
>>> +	hwd_viif_isp_guard_start(viif_dev->hwd_res);
>>> +	ret = hwd_viif_l1_set_dpc_table_transmission(viif_dev->hwd_res,
>> table_h_paddr,
>>> +						     table_m_paddr,
>> table_l_paddr);
>>> +	if (ret)
>>> +		goto err;
>>> +
>>> +	ret = hwd_viif_l1_set_dpc(viif_dev->hwd_res, &l1_dpc->param_h,
>> &l1_dpc->param_m,
>>> +				  &l1_dpc->param_l);
>>> +
>>> +err:
>>> +	hwd_viif_isp_guard_end(viif_dev->hwd_res);
>>> +	spin_unlock_irqrestore(&viif_dev->lock, irqflags);
>>> +	return ret;
>>> +}

<snip>

>>> +static int visconti_viif_isp_get_ctrl(struct v4l2_ctrl *ctrl)
>>> +{
>>> +	struct viif_device *viif_dev = ctrl->priv;
>>> +
>>> +	pr_info("isp_get_ctrl: %s", ctrl->name);
>>> +	if (pm_runtime_status_suspended(viif_dev->dev)) {
>>> +		pr_info("warning: visconti viif HW is not powered");
>>> +		return 0;
>>> +	}
>>> +
>>> +	switch (ctrl->id) {
>>> +	case V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_CALIBRATION_STATUS:
>>> +		return viif_csi2rx_get_calibration_status(viif_dev,
>> ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_CSI2RX_GET_ERR_STATUS:
>>> +		return viif_csi2rx_get_err_status(viif_dev, ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_GET_LAST_CAPTURE_STATUS:
>>> +		return viif_isp_get_last_capture_status(viif_dev,
>> ctrl->p_new.p);
>>> +	case V4L2_CID_VISCONTI_VIIF_GET_REPORTED_ERRORS:
>>> +		return viif_isp_get_reported_errors(viif_dev, ctrl->p_new.p);
>>
>> My question for these four controls is: are these really volatile controls?
>> A volatile control means that the hardware can change the registers at any
>> time without telling the CPU about it via an interrupt or some similar
>> mechanism.
>>
>> If there *is* such a mechanism, then it is not a volatile control, instead the
>> driver has to update the control value whenever the HW informs it about the
>> new value.
>>
>> I can't tell, so that's why I ask here to double check.
>>
> 
> I quickly checked HW and found ...
> 
> * CSI2RX_GET_CALIBRATION_STATUS: No interrupt mechanism

So that remains volatile.

> * CSI2RX_GET_ERR_STATUS: An interrupt handler can be used
> * GET_LAST_CAPTURE_STATUS: information can be updated at Vsync interrupt

For these two you can use v4l2_ctrl_s_ctrl to set the new value.
Note that this function takes a mutex, so you might not be able
to call it directly from the irq handler.

> * GET_LAST_ERROR: An interrupt handler can be used
> 
> I'll try building control values while running interrupt services.
> Do I have to do G_EXT_CTRLS followed by S_EXT_CTRLS if I want Read-To-Clear operation?
> Currently, GET_LAST_ERROR control reports accumerated errors since last read.

Interesting use-case. I think this can stay a volatile control. Make sure
to document that reading this control will clear the values.

> 
>>> +	default:
>>> +		pr_info("unknown_ctrl: id=%08X val=%d", ctrl->id, ctrl->val);
>>> +		break;
>>> +	}
>>> +	return 0;
>>> +}

Regards,

	Hans

