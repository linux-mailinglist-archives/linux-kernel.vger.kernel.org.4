Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440226B3B65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCJJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCJJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:54:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801386189C;
        Fri, 10 Mar 2023 01:53:50 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E53EB660305B;
        Fri, 10 Mar 2023 09:53:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678442029;
        bh=sEvs8DHvWdeOFG6Ji40nINl66ef9BsHCMAHsxd8TCJc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VKOEk0Cet1hg7+M7LQBDg8sLYGizY+wmFxerYRttrOc6v9dsKcZ/N7kxwThaceOK4
         kJvt9k7e/nMxPpdYhuIZJDTr3m86WwnyqhFsY3jHjHc+6KpOCu+I4IvkA5lMtVPtqJ
         3aDjUJegoMtakVINANqM5g6lGkMiYfPZinMkAKPj4MoH31kXHTE4yMwbHjsX50r6uW
         w/kEOWjdGKPKXzOrlbZBOEQcKE0bV7bBdDN5u8kV/30NZVALq/xwfh1hmytB4SG/So
         O+Ge9vIZwKNsJ/VAMflwJtujF1hlBTpiGbAyXHJL9GEYMRTwiI8KB28mYHaCpMPM7K
         jBa9rxY/kMxpw==
Message-ID: <0d756429-13a5-f894-cf7d-b6f0f04da92c@collabora.com>
Date:   Fri, 10 Mar 2023 10:53:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/3] remoteproc: k4: Split out functions common with M4
 driver
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
 <20230302171450.1598576-3-martyn.welch@collabora.com>
 <400ab507-ff2f-cad8-19c6-66818407bf6d@ti.com>
 <a2a51a0a63b7856794ac8fd6889ebf9fcb23f84e.camel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a2a51a0a63b7856794ac8fd6889ebf9fcb23f84e.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/03/23 10:46, Martyn Welch ha scritto:
> On Thu, 2023-03-09 at 12:04 -0600, Hari Nagalla wrote:
>> On 3/2/23 11:14, Martyn Welch wrote:
>>> + * @ti_sci_id: TI-SCI device identifier
>>> + * @mbox: mailbox channel handle
>>> + * @client: mailbox client to request the mailbox channel
>>> + * @ipc_only: flag to indicate IPC-only mode
>>> + */
>>> +struct k3_rproc {
>>> +       struct device *dev;
>>> +       struct rproc *rproc;
>>> +       struct k3_rproc_mem *mem;
>>> +       int num_mems;
>>> +       struct k3_rproc_mem *rmem;
>>> +       int num_rmems;
>>> +       struct reset_control *reset;
>>> +       const struct k3_rproc_dev_data *data;
>>> +       struct ti_sci_proc *tsp;
>>> +       const struct ti_sci_handle *ti_sci;
>>> +       u32 ti_sci_id;
>>> +       struct mbox_chan *mbox;
>>> +       struct mbox_client client;
>>> +};
>>> +
>> "ipc_only" mode element is missing in the structure.
> 
> That's added with the M4F driver in the next patch - it's not part of
> the structure in the DSP driver.

Martyn, I get that it's added later, but the point here is that you are
documenting something that is missing! :-)

You should add the kerneldoc for @ipc_only: xxxx when you actually introduce
the new element... otherwise, this commit alone would trigger a kerneldoc warning.

Cheers,
Angelo
