Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B86665A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjAKVao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjAKVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:30:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF58ACA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:30:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A48FEC;
        Wed, 11 Jan 2023 13:31:20 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7843F71A;
        Wed, 11 Jan 2023 13:30:36 -0800 (PST)
Date:   Wed, 11 Jan 2023 21:30:34 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com
Subject: Re: [PATCH v6 17/17] firmware: arm_scmi: Add per-channel Raw
 injection support
Message-ID: <Y78qa9IBKUE7MZWO@e120937-lin>
References: <20221229182253.948175-1-cristian.marussi@arm.com>
 <20221229182253.948175-18-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229182253.948175-18-cristian.marussi@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 06:22:53PM +0000, Cristian Marussi wrote:
> On a system configured with multiple transport channels, expose a few
> additional debugfs per-channel entries to allow a user to explicitly select
> which transport channel to use for the SCMI message injection.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  Documentation/ABI/testing/debugfs-scmi-raw |  43 +++++++
>  drivers/firmware/arm_scmi/driver.c         |  30 ++++-
>  drivers/firmware/arm_scmi/protocols.h      |   3 +
>  drivers/firmware/arm_scmi/raw_mode.c       | 142 ++++++++++++++++++---
>  drivers/firmware/arm_scmi/raw_mode.h       |   3 +-
>  5 files changed, 201 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-scmi-raw b/Documentation/ABI/testing/debugfs-scmi-raw
> index 45817d465b1f..5468ec08c084 100644
> --- a/Documentation/ABI/testing/debugfs-scmi-raw
> +++ b/Documentation/ABI/testing/debugfs-scmi-raw
> @@ -64,3 +64,46 @@ Description:	SCMI Raw stack reset facility; writing a value to this entry
>  		Can be used to reset and clean the SCMI Raw stack between to
>  		different test-run.
>  Users:		Debugging, any userspace test suite
> +
> +What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message
> +Date:		March 2023
> +KernelVersion:	6.3
> +Contact:	cristian.marussi@arm.com
> +Description:	SCMI Raw synchronous message injection/snooping facility; write
> +		a complete SCMI synchronous command message (header included)
> +		in little-endian binary format to have it sent to the configured
> +		backend SCMI server for instance <n> through the <m> transport
> +		channel.
> +		Any subsequently received response can be read from this same
> +		entry if it arrived on channel <m> within the configured
> +		timeout.
> +		Each write to the entry causes one command request to be built
> +		and sent while the replies are read back one message at time
> +		(receiving an EOF at each message boundary).
> +		Note that these per-channel entries rooted at <..>/channels
> +		exist only if the transport is configured to have more than
> +		one channel.
> +Users:		Debugging, any userspace test suite
> +
> +What:		/sys/kernel/debug/scmi/<n>/raw/channels/<m>/message_async
> +Date:		March 2023
> +KernelVersion:	6.3
> +Contact:	cristian.marussi@arm.com
> +Description:	SCMI Raw asynchronous message injection/snooping facility; write
> +		a complete SCMI asynchronous command message (header included)
> +		in little-endian binary format to have it sent to the configured
> +		backend SCMI server for instance <n> through the <m> transport
> +		channel.
> +		Any subsequently received response can be read from this same
> +		entry if it arrived on channel <m> within the configured
> +		timeout.
> +		Any additional delayed response received afterwards can be read
> +		from this same entry too if it arrived within the configured
> +		timeout.
> +		Each write to the entry causes one command request to be built
> +		and sent while the replies are read back one message at time
> +		(receiving an EOF at each message boundary).
> +		Note that these per-channel entries rooted at <..>/channels
> +		exist only if the transport is configured to have more than
> +		one channel.
> +Users:		Debugging, any userspace test suite
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index da60f218aed9..2d7e669d6dc4 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -42,6 +42,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/scmi.h>
>  
> +#define SCMI_MAX_CHANNELS	256
> +
>  static DEFINE_IDA(scmi_id);
>  
>  static DEFINE_IDR(scmi_protocols);
> @@ -127,6 +129,8 @@ struct scmi_debug_info {
>   * @handle: Instance of SCMI handle to send to clients
>   * @tx_minfo: Universal Transmit Message management info
>   * @rx_minfo: Universal Receive Message management info
> + * @channels: The list of configured channels.
> + * @num_chans: Number of channels described in @channels
>   * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>   * @rx_idr: IDR object to map protocol id to Rx channel info pointer
>   * @protocols: IDR for protocols' instance descriptors initialized for
> @@ -162,6 +166,8 @@ struct scmi_info {
>  	struct scmi_handle handle;
>  	struct scmi_xfers_info tx_minfo;
>  	struct scmi_xfers_info rx_minfo;
> +	unsigned int channels[SCMI_MAX_CHANNELS];
> +	int num_chans;

I have a small rework for V7 to get rid of these channels/num_chans
additional fields that are un-needed and can be retrieved dynamically
when raw mode is initialized.

Thanks,
Cristian
