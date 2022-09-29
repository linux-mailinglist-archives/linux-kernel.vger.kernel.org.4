Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24BA5EEF91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiI2Hqi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Sep 2022 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiI2HqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:46:23 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 00:46:22 PDT
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C13EF090;
        Thu, 29 Sep 2022 00:46:21 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id E3A941C60E3;
        Thu, 29 Sep 2022 07:36:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id E57402002C;
        Thu, 29 Sep 2022 07:36:44 +0000 (UTC)
Message-ID: <3c02aad6d8bde70964b403a3cb8004de969becc6.camel@perches.com>
Subject: Re: [PATCH v4 10/14] gunyah: sysfs: Add node to describe supported
 features
From:   Joe Perches <joe@perches.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Sep 2022 00:36:50 -0700
In-Reply-To: <20220928195633.2348848-11-quic_eberman@quicinc.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
         <20220928195633.2348848-11-quic_eberman@quicinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: yfqwchey9yq5eu51co5zpzk7inon4u6t
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E57402002C
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/SbFmnkC0u2VswP4hwzbj5pLQd0DpRqLM=
X-HE-Tag: 1664437004-361455
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-28 at 12:56 -0700, Elliot Berman wrote:
> Add a sysfs node to list the features that the Gunyah hypervisor and
> Linux supports. For now, Linux support cspace (capability IDs) and
> message queues, so only report those..
[]
> diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
[]
> @@ -25,9 +25,24 @@ static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, c
>  }
>  static struct kobj_attribute variant_attr = __ATTR_RO(variant);
>  
> +static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
> +{
> +	int len = 0;
> +
> +	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
> +		len += sysfs_emit_at(buffer, len, "cspace ");
> +	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags))
> +		len += sysfs_emit_at(buffer, len, "message-queue ");
> +
> +	len += sysfs_emit_at(buffer, len, "\n");
> +	return len;
> +}

It's generally nicer to avoid unnecessary output spaces.

Perhaps:

{
	int len = 0;

	if (GH_IDENTIFY_PARTITION_CSPACE(gunyah_api.flags))
		len += sysfs_emit_at(buffer, len, "cspace");
	if (GH_IDENTIFY_MSGQUEUE(gunyah_api.flags)) {
		if (len)
			len += sysfs_emit_at(buffer, len, " ");
		len += sysfs_emit_at(buffer, len, "message-queue");
	}

	len += sysfs_emit_at(buffer, len, "\n");

	return len;
}

