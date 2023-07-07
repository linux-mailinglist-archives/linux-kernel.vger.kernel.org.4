Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCD74B781
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGGTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGTxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3119A5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E845561A4F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC240C433C8;
        Fri,  7 Jul 2023 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688759616;
        bh=OTwBIWjS+lRVssTp4xtuqn6WnWPckgnWTLxmnMqHGMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kYR5DDiUGLuVRQ5kg3tQkEv5LFvouP7qrZE+obKy3HwP0yZvCnctPAOAFnRId00a4
         k4jXPDdEXYL3SqpJCGAtIyvfVhnbNCCq/AjVDMEXRyHu1VXlV0iXpa1oM+eAF0gWna
         rHauwGNlhAkKdWKSCq7mX9aKBuVNqMrAUh6w3XK4DS+oz1aa2r8HRamPxhKIZpJJ76
         cO4OM4z06YJ14R29uMnXrH/0EP4siStNtLXEqPd23cdcWj4rqw2SSocIDESMTfV3Ks
         wnPPxerIL562rK4L6NV7kfbhc6jWXdOsU1arbMXJBCtpIF7Ep0FL/r4nCRKLt2yCAh
         MvTU7wHMNxIBw==
Message-ID: <161c5a69-dd26-a7ae-7548-efa45418f5aa@kernel.org>
Date:   Fri, 7 Jul 2023 14:53:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2 RESEND] firmware: stratix10-svc: Generic Mailbox
 Command
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com, Teh Wen Ping <wen.ping.teh@intel.com>
References: <20230707080112.1722827-1-kah.jing.lee@intel.com>
 <20230707080305.1722983-1-kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230707080305.1722983-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 03:03, kah.jing.lee@intel.com wrote:
> From: Teh Wen Ping <wen.ping.teh@intel.com>
> 
> Add generic mailbox command that can support SDM command. User can use this
> command to send SDM mailbox command. User have to specified an input file
> which contain the command data and an output file for SDM response to be
> copied over.
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>   drivers/firmware/stratix10-svc.c              | 18 +++++++++++++
>   include/linux/firmware/intel/stratix10-smc.h  | 25 +++++++++++++++++++
>   .../firmware/intel/stratix10-svc-client.h     |  5 ++++
>   3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 2d674126160f..430e8bf0bca9 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -37,6 +37,7 @@
>   #define SVC_NUM_CHANNEL				3
>   #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
>   #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
> +#define BYTE_TO_WORD_SIZE              4
>   
>   /* stratix10 service layer clients */
>   #define STRATIX10_RSU				"stratix10-rsu"
> @@ -361,6 +362,13 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>   		cb_data->kaddr2 = svc_pa_to_va(res.a2);
>   		cb_data->kaddr3 = &res.a3;
>   		break;
> +	case COMMAND_MBOX_SEND_CMD:
> +		cb_data->status = BIT(SVC_STATUS_OK);
> +		cb_data->kaddr1 = &res.a1;
> +		/* SDM return size in u32 word. Convert size to u8 */

Check this comment. I don't see how this is accurate.
> +		res.a2 = res.a2 * BYTE_TO_WORD_SIZE;
> +		cb_data->kaddr2 = &res.a2;
> +		break;
>   	default:
>   		pr_warn("it shouldn't happen\n");
>   		break;
> @@ -534,6 +542,15 @@ static int svc_normal_to_secure_thread(void *data)
>   			a1 = 0;
>   			a2 = 0;
>   			break;
> +		case COMMAND_MBOX_SEND_CMD:
> +			a0 = INTEL_SIP_SMC_MBOX_SEND_CMD;
> +			a1 = pdata->arg[0];
> +			a2 = (unsigned long)pdata->paddr;
> +			a3 = (unsigned long)pdata->size / BYTE_TO_WORD_SIZE;
> +			a4 = pdata->arg[1];
> +			a5 = (unsigned long)pdata->paddr_output;
> +			a6 = (unsigned long)pdata->size_output / BYTE_TO_WORD_SIZE;
> +			break;
>   		default:
>   			pr_warn("it shouldn't happen\n");
>   			break;
> @@ -597,6 +614,7 @@ static int svc_normal_to_secure_thread(void *data)
>   			case COMMAND_FCS_DATA_ENCRYPTION:
>   			case COMMAND_FCS_DATA_DECRYPTION:
>   			case COMMAND_FCS_RANDOM_NUMBER_GEN:
> +			case COMMAND_MBOX_SEND_CMD:
>   				cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
>   				cbdata->kaddr1 = NULL;
>   				cbdata->kaddr2 = NULL;
> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
> index a718f853d457..ee80ca4bb0d0 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -466,6 +466,31 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>   #define INTEL_SIP_SMC_FIRMWARE_VERSION \
>           INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
>   
> +/**
> + * SMC call protocol for Mailbox, starting FUNCID from 60
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_MBOX_SEND_CMD
> + * a1 mailbox command code
> + * a2 physical address that contain mailbox command data (not include header)
> + * a3 mailbox command data size in word
> + * a4 set to 0 for CASUAL, set to 1 for URGENT
> + * a5 physical address for secure firmware to put response data
> + *    (not include header)
> + * a6 maximum size in word of physical address to store response data
> + * a7 not used
> + *
> + * Return status
> + * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_REJECTED or
> + *    INTEL_SIP_SMC_STATUS_ERROR
> + * a1 mailbox error code
> + * a2 response data length in word
> + * a3 not used
> + */
> +#define INTEL_SIP_SMC_FUNCID_MBOX_SEND_CMD 60
> +	#define INTEL_SIP_SMC_MBOX_SEND_CMD \
> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_MBOX_SEND_CMD)
> +
>   /**
>    * Request INTEL_SIP_SMC_SVC_VERSION
>    *
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index 0c16037fd08d..60ed82112680 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -118,6 +118,9 @@ struct stratix10_svc_chan;
>    * @COMMAND_SMC_SVC_VERSION: Non-mailbox SMC SVC API Version,
>    * return status is SVC_STATUS_OK
>    *
> + * @COMMAND_MBOX_SEND_CMD: send generic mailbox command, return status is
> + * SVC_STATUS_OK or SVC_STATUS_ERROR
> + *
>    * @COMMAND_RSU_DCMF_STATUS: query firmware for the DCMF status
>    * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
>    *
> @@ -164,6 +167,8 @@ enum stratix10_svc_command_code {
>   	COMMAND_FCS_RANDOM_NUMBER_GEN,
>   	/* for general status poll */
>   	COMMAND_POLL_SERVICE_STATUS = 40,
> +	/* for generic mailbox send command */
> +	COMMAND_MBOX_SEND_CMD = 100,
>   	/* Non-mailbox SMC Call */
>   	COMMAND_SMC_SVC_VERSION = 200,
>   };
