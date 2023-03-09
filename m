Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA0E6B2C96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjCISE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCISE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:04:57 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B979D61A9A;
        Thu,  9 Mar 2023 10:04:56 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 329I4ch6104016;
        Thu, 9 Mar 2023 12:04:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678385078;
        bh=UuxZhPTZ7rV2N4eAnH8eTAx6RVvc7KHaIl/3rBBiXCI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eC2SnnE1l9Wi3dobhabUmRpoZ2wCD0ly1F12FN6wRAPR/Ehjfc1iO9kHu1aLz2RE/
         av+QbcigSayX0FKvMl2A2RrbVF5js5QEDMpHsw+gIGwZj+1hygDLzAeC9gtFM9DE5k
         eClKGjdn2HFeN/i9Ylww4ubfzYRCO5/mUbZSWfFY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 329I4cGw022830
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 12:04:38 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 12:04:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 12:04:37 -0600
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 329I4bN3008107;
        Thu, 9 Mar 2023 12:04:37 -0600
Message-ID: <400ab507-ff2f-cad8-19c6-66818407bf6d@ti.com>
Date:   Thu, 9 Mar 2023 12:04:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/3] remoteproc: k4: Split out functions common with M4
 driver
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <kernel@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
 <20230302171450.1598576-3-martyn.welch@collabora.com>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20230302171450.1598576-3-martyn.welch@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 11:14, Martyn Welch wrote:
> + * @ti_sci_id: TI-SCI device identifier
> + * @mbox: mailbox channel handle
> + * @client: mailbox client to request the mailbox channel
> + * @ipc_only: flag to indicate IPC-only mode
> + */
> +struct k3_rproc {
> +	struct device *dev;
> +	struct rproc *rproc;
> +	struct k3_rproc_mem *mem;
> +	int num_mems;
> +	struct k3_rproc_mem *rmem;
> +	int num_rmems;
> +	struct reset_control *reset;
> +	const struct k3_rproc_dev_data *data;
> +	struct ti_sci_proc *tsp;
> +	const struct ti_sci_handle *ti_sci;
> +	u32 ti_sci_id;
> +	struct mbox_chan *mbox;
> +	struct mbox_client client;
> +};
> +
"ipc_only" mode element is missing in the structure.
