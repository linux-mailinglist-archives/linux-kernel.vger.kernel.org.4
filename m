Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0465EA76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjAEMLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjAEMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:11:43 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB304260D;
        Thu,  5 Jan 2023 04:11:41 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CA8E061;
        Thu,  5 Jan 2023 13:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1672920697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=febkbDKBJ+jyyIrcrvvpxf5VuxTgBEoaFi7ap7kh3Wk=;
        b=WOWNXjRiQNwft/DVXDgwkJgpxzjqiAqG3oG61FMQX4cEi0lA1Gp0piIEuFTROobQ5gJ+dM
        B6UeyWD6DgrZRvpfuegq/NgS1wLq7mq6l+K3+7WNgmqjQ9Kqkt0ppIzvUX2fwwS7SqR0jz
        tT5U68PmX1Y10vmIUClJChxtynCbOymz6uixnFDt2/UyrDU39laet6KN95Dwvx+iswSjCn
        YWdPgTCHJf76BQzDBOR1aOrpF3wWtzei+OmQ/g2udPzTJRrSkgH5S+c0m3VyH9HBJApu6H
        5yOiOaZobzGfB5FQNeMZsLQ5tLmvw4ay5XkfvsPkPCGkLme9b6bzL+eWjgVg/g==
MIME-Version: 1.0
Date:   Thu, 05 Jan 2023 13:11:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
In-Reply-To: <20230105123534.38a70640@xps-13>
References: <20221206200740.3567551-1-michael@walle.cc>
 <20230103163902.218cb5c7@xps-13>
 <cf00e248-1f2c-d4ce-868d-9f77b2c9b76f@linaro.org>
 <2143916.GUh0CODmnK@steina-w> <20230105123534.38a70640@xps-13>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <34cddc1aa4f8a55c752a9565d1726127@walle.cc>
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

Hi Alexander,

thanks for debugging. I'm not yet sure what is going wrong, so
I have some more questions below.

>> This causes the following errors on existing boards (imx8mq-tqma8mq-
>> mba8mx.dtb):
>> root@tqma8-common:~# uname -r
>> 6.2.0-rc2-next-20230105
>> 
>> > OF: /soc@0: could not get #nvmem-cell-cells for /soc@0/bus@30000000/
>> efuse@30350000/soc-uid@4
>> > OF: /soc@0/bus@30800000/ethernet@30be0000: could not get #nvmem-cell-cells
>> for /soc@0/bus@30000000/efuse@30350000/mac-address@90
>> 
>> These are caused because '#nvmem-cell-cells = <0>;' is not explicitly 
>> set in
>> DT.
>> 
>> > TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: failed to get nvmem cell
>> io_impedance_ctrl
>> > TI DP83867: probe of 30be0000.ethernet-1:0e failed with error -22
>> 
>> These are caused because of_nvmem_cell_get() now returns -EINVAL 
>> instead of -
>> ENODEV if the requested nvmem cell is not available.

What do you mean with not available? Not yet available because of probe
order?

> Should we just assume #nvmem-cell-cells = <0> by default? I guess it's
> a safe assumption.

Actually, that's what patch 2/21 is for.

Alexander, did you verify that the EINVAL is returned by
of_parse_phandle_with_optional_args()?

-michael
