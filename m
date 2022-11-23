Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C3635886
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiKWJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiKWJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:58:16 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E2EC0B7;
        Wed, 23 Nov 2022 01:52:26 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7420F1D40;
        Wed, 23 Nov 2022 10:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669197144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQZCMeZbkCsZ9VF9ouX01MwdWli+CdAZ1Of8k/5J5XM=;
        b=hcBaH5TJzJwY+q9FCjgme0ERQPLxmXCoJkzjJ/cxpWaUwmckRi41AzIiYh0Mck12fKp3fM
        zP2qhvUn/QiW6OFlSaJEpXD9M/2ypF94M95QzKQ8vFeg31umjCR7JLDbk21FvOMyEHOWtD
        6qlVP3lPZPJ6qJKngqQqrZAEUUL1zLg9KB4v+Y/hoiLavO8gqw75X7KQpdHiLXahWjPNn9
        Hu0gLAUeww2eFY0dBrg00HzXfUnKTsfG757tuLzHiNLK85nITw3uzP9tRIkZmA1DUJGV65
        n6g+AqPsWAHQhtIY66PK/qP5HA2YqPcUjANVKZ/V5e2RcvlVCcfEy2TIii5VvA==
MIME-Version: 1.0
Date:   Wed, 23 Nov 2022 10:52:24 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 17/18] nvmem: layouts: Add ONIE tlv layout driver
In-Reply-To: <20221121075144.GL3143@pengutronix.de>
References: <20221118185118.1190044-1-michael@walle.cc>
 <20221118185118.1190044-18-michael@walle.cc>
 <20221121075144.GL3143@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <03a2791283d26c847d07852506e9d48f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-21 08:51, schrieb Sascha Hauer:
> On Fri, Nov 18, 2022 at 07:51:17PM +0100, Michael Walle wrote:
>> From: Miquel Raynal <miquel.raynal@bootlin.com>
>> 
>> This layout applies no top of any non volatile storage device 
>> containing
> 
> s/no/on/
> 
>> +	table_len = hdr_len + data_len;
>> +	if (table_len > ONIE_TLV_MAX_LEN) {
>> +		dev_err(dev, "Invalid ONIE TLV data length\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	table = devm_kmalloc(dev, table_len, GFP_KERNEL);
>> +	if (!table)
>> +		return -ENOMEM;
>> +
>> +	ret = nvmem_device_read(nvmem, 0, table_len, table);
>> +	if (ret != table_len)
>> +		goto free_data_buf;
>> +
>> +	if (!onie_tlv_crc_is_valid(dev, table_len, table)) {
>> +		ret = -EINVAL;
>> +		goto free_data_buf;
>> +	}
>> +
>> +	data = table + hdr_len;
>> +	ret = onie_tlv_add_cells(dev, nvmem, data_len, data);
>> +	if (ret)
>> +		goto free_data_buf;
>> +
>> +free_data_buf:
>> +	kfree(table);
> 
> This is allocated with devm_kmalloc(), you shouldn't free it here.

Miquel, should I drop your patches or should I fix this in place and
repost them?

Also, there is a mistake in nvmem_add_cells_from_layout() which doesn't
handle the return code. Probably a leftover from before when I had
.add_cells() return void.

-michael
