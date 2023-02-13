Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770A694505
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBMMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBMMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:00:37 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F2B18B20;
        Mon, 13 Feb 2023 04:00:18 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C54F91646;
        Mon, 13 Feb 2023 13:00:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1676289616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voxYeZ7wh5c7OrjzskwQHyd3j/r/yCtZhLRFGBW9fEM=;
        b=n1yzElJg/OxL7J4kVsS0FOK/7wizoIWnPnrbMKATH3ilguTjMhUbnbBghkiYoZyAQGPeR3
        TL6HxNjofvC4k9qWG51WDpHb7nDgmXh9OAGTXUg8qw1F1oVEK//3mSck4XTHtss3Znl9+L
        gcVspdrCX1mQPS9ykjkvEtltO4l24tk9ayajznlrxIPfLGWwpJ0K1DjObJe9bRGdV21M47
        TtWyJAgc44FK7i2hgHsgEgqfHj8EDIt/2fmNE64bAAx5fs21xb6ON12kbEKnZf1YbqaX2C
        yGjWBMfaHc9csLKYKF1iTk1jXsmKKrK2CeqbImuPh0CXozyRpm/CKIFqWs+ZoA==
From:   Michael Walle <michael@walle.cc>
To:     tharunkumar.pasumarthi@microchip.com
Cc:     gregkh@linuxfoundation.org, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add OTP/EEPROM driver for the pci1xxxx switch
Date:   Mon, 13 Feb 2023 13:00:09 +0100
Message-Id: <20230213120009.2661528-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y+iQnfR65M0El34R@kroah.com>
References: <Y+iQnfR65M0El34R@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +	/* Wait for the EPC_BUSY bit to get cleared */
>>> +	do {
>>> +		data = readl(priv->reg_base + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
>>> +	} while (data & EEPROM_CMD_EPC_BUSY_BIT);
>>
>> Again, you can not sit and spin in a busy-wait like this with no chance
>> to recover if something goes wrong with the hardware (hint, what if it
>> got removed?)

Also, it is good practice to CC people who did comments on the
former versions.

-michael
