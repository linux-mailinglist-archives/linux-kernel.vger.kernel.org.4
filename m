Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7D68D99C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBGNpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBGNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:45:42 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BE81287D;
        Tue,  7 Feb 2023 05:45:37 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id ADC5D135F;
        Tue,  7 Feb 2023 14:45:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675777535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSReOe2y4UpDD6dHicviy+8pmrJGcGcu7s575dmJv+4=;
        b=VRserahtYkrAP8HdGnDz4ruA+y5spWEplilklku1XWRBVQQ51aqTaYA0+O/z8clRc4F4Zt
        PpHCExPCHv2hWp8pOThTFCRk3d3rl2uf7EOk5yQFKb+hlZCJM4HfulBPIg/NfDT/giALs8
        qdfCfzQwbqbPuHSo3pMzz4rj/06ofCHg2LY8Zwv8hwYWoDVsY6FLOTSIk0VPJs/BqT5aTe
        gSfCzZu9OrFi23nI038yIgmJ4lH19VOjFO/f3IUV7SfDhj+6miGAAkxGa3j9bdb+WUPigT
        LpAv1W1rl4sHFqrns2Q6S7hyaaIF2rUizOiAzXIr/RxKYDy5n3JUdF7x1hl/Iw==
From:   Michael Walle <michael@walle.cc>
To:     gregkh@linuxfoundation.org
Cc:     Kumaravel.Thiagarajan@microchip.com,
        Tharunkumar.Pasumarthi@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add OTP/EEPROM driver for the pci1xxxx switch
Date:   Tue,  7 Feb 2023 14:45:26 +0100
Message-Id: <20230207134526.2465045-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y+E9iRWyxqOjO4UX@kroah.com>
References: <Y+E9iRWyxqOjO4UX@kroah.com>
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

>> Our objective with that part of code is to wait for OTP_STATUS_BUSY_BIT 
>> to be cleared in the hardware, but make sure that we wait for a maximum 
>> of OTP_RW_TIMEOUT_MILLISECONDS ms in the driver and not beyond that. 
>
> How exact much do you mean by "not beyond that"?

Yeah that sounds strange. What is the reason to not wait "beyond that"?

Reading that paragraph above, it looks like you should have a look at
linux/iopoll.h.

-michael
