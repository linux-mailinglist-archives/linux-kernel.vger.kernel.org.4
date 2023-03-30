Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018626D0038
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjC3JxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjC3Jwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:52:49 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6AE728A;
        Thu, 30 Mar 2023 02:51:52 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 463511272;
        Thu, 30 Mar 2023 11:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680169910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfCqrBgiqxweVNM1TXbSkTYgh4gxLV1zcEcv6yIVr5w=;
        b=qjhBh38Itt0cwBjWXOoTtH38EhHSnjiqyZVZb88hPF1f4H3D/+g1kTF8sb8o3Q24S2i9KH
        AtreYhCTsaHF2zyxZ/zxCWfNU2GTDslbu9K8BXOMf5bhFZeO3PbaW6SqKzB0Gcbay12L+L
        HsTNVh3Uzb36PQVd+wTRBqGe2GrTsek23VXOYEeuevUoY2TejtoKR1hNC0jIsh6phAbyd/
        OM8tpjoo7bR444kZEtvmh2U/2AVBfMXyJvYjdiHIz6OC0JB6T616kJwL/fI6023H8Ldv1f
        RamYA+lcWwVxeomFSfkyuqkFq5xOFSbxevpIGE5phaQwHLFfT6GjkQcr14mPTg==
From:   Michael Walle <michael@walle.cc>
To:     vaibhaavram.tl@microchip.com
Cc:     Tharunkumar.Pasumarthi@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v8 char-misc-next 3/5] misc: microchip: pci1xxxx: Add EEPROM Functionality to read and write into EEPROM bin sysfs
Date:   Thu, 30 Mar 2023 11:51:40 +0200
Message-Id: <20230330095140.3384441-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f999539280139b7085721803f12f836c201edf20.camel@microchip.com>
References: <f999539280139b7085721803f12f836c201edf20.camel@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[First, please CC people who did comments on previous versions.]

> > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> > > industrial, and automotive applications. This switch integrates OTP
> > > and EEPROM to enable customization of the part in the field.
> > > This patch adds EEPROM functionality to support the same.
> > 
> > Again, why not use the in-kernel eeprom api instead?
> Unlike other in-Kernel EEPROM APIs, this EEPROM is not accessible
> through any of the i2c/spi buses available to the kernel.

I fail to see how this matters. NVMEM has a generic read/write callback.
There is no dependency on I2C or SPI. Again, you should look into nvmem.
And it should be perfectly fine to use nvmem without nvmem cells at all.

With CONFIG_NVMEM_SYSFS you should get a "nvmem" binary file in sysfs.
Wit config->compat set (although I don't know if that is recommended) you
should get an "eeprom" binary file in sysfs.

> It is only accessible through the register interface available in the
> EEPROM controller of the PCI1XXXX device.

-michael
