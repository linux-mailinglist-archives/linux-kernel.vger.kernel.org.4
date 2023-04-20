Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CC6E8ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjDTKCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjDTKCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:02:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F582703;
        Thu, 20 Apr 2023 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681984942; x=1713520942;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=BJ8FeGpPWT+byd7+7AOk70gXCbuSUqNXSNoscAHOLMc=;
  b=F6z8VLyRsuYQ0hONjs99X+HmPl9Ex1jsKwm03EyIvA4m5ZvMkgEc7n3i
   h4BN3uKHqu88yflWA9tEgn36DQVOQrFSsQQ+RiePrRzkxCkFWz8AtdCpc
   UMgA2qSwssDT/7/dbcwcZddUKKuTSNlXsTK3er+NJeQJap01IVZmPBKYC
   o96Wxwm44qO/5vA4xf+9yAnmVKXq9YrUHRUoQjpsolUC8lr+GUypPUicz
   G68ZxdgNaJ/Nh+IbA5fUSsCk78cXKq+mA+Myq5azTRrj6BsjPsflS7RNp
   fKR75BdtXSAUbU9EjHxNF7bWAJaBrTPb0dYEzO6akwf3SIMA5RX9Ep0Ye
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="326019861"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="326019861"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 03:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021531041"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="1021531041"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2023 03:02:17 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2] stm: class: Add MIPI OST protocol support
In-Reply-To: <20230419141328.37472-1-quic_jinlmao@quicinc.com>
References: <20230419141328.37472-1-quic_jinlmao@quicinc.com>
Date:   Thu, 20 Apr 2023 13:02:16 +0300
Message-ID: <87cz3yyiqf.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mao Jinlong <quic_jinlmao@quicinc.com> writes:

> Add MIPI OST(Open System Trace) protocol support for stm to format
> the traces. OST over STP packet consists of Header/Payload/End. In
> header, there will be STARTSIMPLE/VERSION/ENTITY/PROTOCOL. STARTSIMPLE
> is used to signal the beginning of a simplified OST base protocol
> packet.The Entity ID field is a one byte unsigned number that identifies
> the source. FLAG packet is used for END token.

We'd need a better explanation of what OST is, maybe a link to the spec
if one exists.

Another thing that this patch does is adding source identification,
which needs to be described better.

[...]

> +CONFIG_STM_PROTO_OST is for p_ost driver enablement. Once this config
> +is enabled, you can select the p_ost protocol by command below:
> +
> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy
> +
> +The policy name format is extended like this:
> +    <device_name>:<protocol_name>.<policy_name>
> +
> +With coresight-stm device, it will be look like "stm0:p_ost.policy".

The part about protocol selection should probably be in stm.rst
instead.

> +You can check if the protocol is set successfully by:
> +# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/protocol
> +p_ost

A successful mkdir is technically enough.

> +With MIPI OST protocol driver, the attributes for each protocol node is:
> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
> +# ls /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
> +channels  entity    masters

Where's "entity_available"?

> +The entity here is the set the entity that p_ost supports. Currently
> +p_ost supports ftrace and console entity.
> +
> +Get current available entity that p_ost supports:
> +# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity_available
> +ftrace console
> +
> +Set entity:
> +# echo 'ftrace' > /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity

This is not a very good example, as it will flag everything that goes
through STM as "ftrace", which is probably not what anybody wants.

The bigger question is, why do we need to set the source type (for
which "entity" is not a very good name, btw) in the configfs when
corresponding stm source drivers already carry this information.
There should be a way to propagate the source type from stm source
driver to the protocol driver without relying on the user to set it
correctly.

> +See Documentation/ABI/testing/configfs-stp-policy-p_ost for more details.
> diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
> index eda6b11d40a1..daa4aa09f64d 100644
> --- a/drivers/hwtracing/stm/Kconfig
> +++ b/drivers/hwtracing/stm/Kconfig
> @@ -40,6 +40,20 @@ config STM_PROTO_SYS_T
>  
>  	  If you don't know what this is, say N.
>  
> +config STM_PROTO_OST
> +	tristate "MIPI OST STM framing protocol driver"
> +	default CONFIG_STM
> +	help
> +	  This is an implementation of MIPI OST protocol to be used
> +	  over the STP transport. In addition to the data payload, it
> +	  also carries additional metadata for entity, better
> +	  means of trace source identification, etc.

What does "entity" mean here?

[...]

> +#define OST_TOKEN_STARTSIMPLE		(0x10)
> +#define OST_VERSION_MIPI1		(0x10 << 8)

Either write them as bits (BIT(12)) or as a hex value (0x1000).

> +/* entity id to identify the source*/
> +#define OST_ENTITY_FTRACE		(0x01 << 16)
> +#define OST_ENTITY_CONSOLE		(0x02 << 16)
> +
> +#define OST_CONTROL_PROTOCOL		(0x0 << 24)

Zero, really? At this point I'm wondering if this code has even been
tested.

[...]

> +static ssize_t
> +ost_t_policy_entity_store(struct config_item *item, const char *page,
> +			size_t count)
> +{
> +	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
> +	struct ost_policy_node *pn = to_pdrv_policy_node(item);
> +	char str[10] = "";
> +
> +	mutex_lock(mutexp);
> +	if (sscanf(page, "%s", str) != 1)
> +		return -EINVAL;
> +	mutex_unlock(mutexp);

You forgot to release the mutex in the error path.
Also, why do you need a mutex around sscanf() in the first place?
Also, the sscanf() can overrun str.

> +	if (!strcmp(str, str_ost_entity_type[OST_ENTITY_TYPE_FTRACE]))
> +		pn->entity_type = OST_ENTITY_TYPE_FTRACE;
> +	else if (!strcmp(str, str_ost_entity_type[OST_ENTITY_TYPE_CONSOLE]))
> +		pn->entity_type = OST_ENTITY_TYPE_CONSOLE;

Why can't you strcmp() on the page directly?
Also, this is where you do want to hold the mutex.
Also, what if there are more source types?

> +	else
> +		return -EINVAL;
> +	return count;
> +}
> +CONFIGFS_ATTR(ost_t_policy_, entity);
> +
> +static ssize_t ost_t_policy_entity_available_show(struct config_item *item,
> +				char *page)
> +{
> +	return scnprintf(page, PAGE_SIZE, "%s\n", "ftrace console");

Don't hardcode these.

> +}
> +CONFIGFS_ATTR_RO(ost_t_policy_, entity_available);
> +
> +static struct configfs_attribute *ost_t_policy_attrs[] = {
> +	&ost_t_policy_attr_entity,
> +	&ost_t_policy_attr_entity_available,
> +	NULL,
> +};
> +
> +static ssize_t notrace ost_write(struct stm_data *data,
> +		struct stm_output *output, unsigned int chan,
> +		const char *buf, size_t count)
> +{
> +	unsigned int c = output->channel + chan;
> +	unsigned int m = output->master;
> +	const unsigned char nil = 0;
> +	u32 header = DATA_HEADER;
> +	u8 trc_hdr[16];
> +	ssize_t sz;
> +
> +	struct ost_output *op = output->pdrv_private;

As said above, the stm source driver that calls here already knows its
own source type, there's no need to store it separately.

> +
> +	/*
> +	 * Identify the source by entity type.
> +	 * If entity type is not set, return error value.
> +	 */
> +	if (op->node.entity_type == OST_ENTITY_TYPE_FTRACE) {
> +		header |= OST_ENTITY_FTRACE;
> +	} else if (op->node.entity_type == OST_ENTITY_TYPE_CONSOLE) {
> +		header |= OST_ENTITY_CONSOLE;
> +	} else {
> +		pr_debug("p_ost: Entity must be set for trace data.");

You forgot a newline.
Also, this message seems to be quite useless: it's either a nop or a
dmesg storm. In general, it's a bad idea to printk() in the write
callback.

> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * STP framing rules for OST frames:
> +	 *   * the first packet of the OST frame is marked;
> +	 *   * the last packet is a FLAG with timestamped tag.
> +	 */
> +	/* Message layout: HEADER / DATA / TAIL */
> +	/* HEADER */
> +	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
> +			  4, (u8 *)&header);
> +	if (sz <= 0)
> +		return sz;
> +
> +	/* DATA */
> +	*(u16 *)(trc_hdr) = STM_MAKE_VERSION(0, 4);
> +	*(u16 *)(trc_hdr + 2) = STM_HEADER_MAGIC;
> +	*(u32 *)(trc_hdr + 4) = raw_smp_processor_id();
> +	*(u64 *)(trc_hdr + 8) = task_tgid_nr(get_current());

What's the value in exporting PIDs when there are PID namespaces? How is
this useful? Also, neither console nor ftrace are required to come in a
task context.

I already asked in the previous version, why is trc_hdr not a struct?

There also used to be a timestamp field in trc_hdr, what happened to it?

Regards,
--
Alex
