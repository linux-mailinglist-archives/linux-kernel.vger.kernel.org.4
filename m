Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A196EDCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjDYHfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjDYHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:34:32 -0400
X-Greylist: delayed 1684 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 00:33:43 PDT
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C796C144;
        Tue, 25 Apr 2023 00:33:43 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id EF7EC1251;
        Tue, 25 Apr 2023 09:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1682408021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddDLRyBIIJJ/sPLSSjrl5uf8T1R/yy7tZgKr85AjjK0=;
        b=hjVbLJXBuXhpGpawTLxqydZsLxSWHiwy2j6hFZF3F/c3WCILQjyb4VnFKLZkjiYnQ8q6zi
        JeBMfScQL4poIQym/SVlcLckCVs9GTgw0j20Ffw/7825teShfcdp/2vcwN/z3Yf9hmpZRq
        HbDQq3NhN9NQjOJ3+PmWbAOJBwBxSzrJOoqEVb5vc0Vg7SIxf/+18PTs7TcC2LV96SRerz
        61ExytYFL2fOiKFy2LkYf/tab16LbHR1NvtY59Sakv9gYDrg0B7jNU/FetkKP0ToM9acbA
        /NeWERflRf4cZN32C53435auzmFaGBqowK1xtpgV3TdGETIGyq95kCBGMtlViQ==
MIME-Version: 1.0
Date:   Tue, 25 Apr 2023 09:33:40 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v10 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
In-Reply-To: <20230421142643.1784-2-vaibhaavram.tl@microchip.com>
References: <20230421142643.1784-1-vaibhaavram.tl@microchip.com>
 <20230421142643.1784-2-vaibhaavram.tl@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2265a7467850190ec99ac9ab0aaa7905@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +static int pci1xxxx_otp_read(void *priv_t, unsigned int off,
> +			     void *buf_t, size_t count)
> +{
> +	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
> +	void __iomem *rb = priv->reg_base;
> +	char *buf = buf_t;
> +	u32 regval;
> +	u32 byte;
> +	int ret;
> +	u8 data;
> +
> +	if (off >= priv->nvmem_config_otp.size)
> +		return -EFAULT;
> +
> +	if ((off + count) > priv->nvmem_config_otp.size)
> +		count = priv->nvmem_config_otp.size - off;
> +
> +	ret = set_sys_lock(priv);
> +	if (ret)
> +		return ret;
> +
> +	for (byte = 0; byte < count; byte++) {
> +		otp_device_set_address(priv, (u16)(off + byte));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		writel(data | OTP_FUNC_RD_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +		writel(data | OTP_CMD_GO_BIT,
> +		       rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
> +
> +		ret = read_poll_timeout(readl, regval,
> +					!(regval & OTP_STATUS_BUSY_BIT),
> +					STATUS_READ_DELAY_US,
> +					STATUS_READ_TIMEOUT_US, true,
> +					rb + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
> +
> +		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
> +		if (ret < 0 || data & OTP_FAIL_BIT)
> +			return -EIO;

Don't you need to release the lock?

> +
> +		buf[byte] = readl(rb + MMAP_OTP_OFFSET(OTP_RD_DATA_OFFSET));
> +	}
> +	release_sys_lock(priv);
> +
> +	return byte;
> +}

