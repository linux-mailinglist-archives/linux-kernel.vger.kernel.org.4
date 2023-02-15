Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB669780A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjBOIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjBOIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:20:14 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103736442;
        Wed, 15 Feb 2023 00:20:12 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D8A9941;
        Wed, 15 Feb 2023 09:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1676449210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVb1fCpjLnpjYXpQ6VJ4SVLbqTDs0Hg9zsPio8OGrkc=;
        b=lvQkl0iD2g2hNBADa4/+lS1gXOd6VicvyAzHKclaG6CkJcOKo0WUUlOjkNZ38gIgdCAAYr
        Cm7bHgNtgm47iLogXLWfQxmqQkGzCYZBMrQ9ctcOGDtxE3j9XZP3GDe3jLDtBiANwSypHQ
        nio5uKRlCh+p+a/leByxo6cZy9WGCH4FD8KQQoAS+PzOpLiN/+O1kT/cRC49EEgwNaffXC
        3OMYk3aPWSPJrtxnmlXvFFxZiyMHkbJ9bfJLr7T65edAk3iBBHcXY8OZ+UvwY644gVqeb2
        Tt4CmmfhKhNkYpyRWGKfk/bfzKZEDG+h4S9Mf/gIFFi47hoGt+LOgm0piUVXMQ==
MIME-Version: 1.0
Date:   Wed, 15 Feb 2023 09:20:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     Tharunkumar.Pasumarthi@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
In-Reply-To: <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7276bef47792e489abd093e4bd0044de@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
>> > industrial, and automotive applications. This switch integrates OTP
>> > and EEPROM to enable customization of the part in the field. This
>> > patch provides the OTP/EEPROM driver to support the same.
>> 
>> Why isn't this driver using the nvmem subsystem which is usually used 
>> for
>> OTP and EEPROM?
> Michael, these OTP and EEPROM memories do not have any fixed location
> registers which
> store values (Eg. mac address, config parameters, etc) at fixed 
> offsets.
> It stores a bunch of records, each of which has some data to be
> written into the device's
> hardware registers at different locations. These records are directly
> consumed by the hardware
> and interpreted without the involvement of the software.
> Therefore, we don't require any OTP / EEPROM register map to be input
> to the OS / driver through
> device tree or board files.
> I only had to enumerate two separate block devices using the driver so
> that the config binary files can be
> overlayed using the dd command.
> Since this is not fitting like a conventional nvme device, I didn't
> choose the nvme subsystem.
> Please let me know your thoughts / comments if any.

So this is only for provisioning. i.e. during manufacturing a board
which uses this PCI bridge? There are no kernel users, nor is
there a common interface towards user-space. But just some block
device (why not a char device?) exposed to userspace. I presume
there is a companion userspace application for it? Why do you take
the extra step and have a (random) kernel interface, you could
also just access the PCI device directly from userspace within your
companion application, e.g. through libpci.

Just my two cents. I guess it's up to you and Greg who has to
maintain it.

-michael
