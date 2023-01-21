Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD3676764
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAUQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAUQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:37:45 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E85426847
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:37:43 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4NzhqM17DKz9ssb;
        Sat, 21 Jan 2023 17:37:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espindo.la; s=MBO0001;
        t=1674319055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Gua9qY8MWYbza4ODWsNxoeI2RrnpCInu/OZvKkC2+IU=;
        b=cQUehuXFkWj1WHhIjtkC4qbpjY4aqBBh0z9GS2tz37ClJezGaQ90pykuNHtcnzPNXCwTCX
        ESCAOiTLjRz4w2sXTzxeQ47NHos+aNU0G5dVSu7Tnww/V8Lmar0AucDUV6ZR8irssynX6Y
        BK7ow+9Y3D/kLL34Kq3pwE30xaCx/j2jYra5p9nwhw7TsRMfa61QgfyTcdn6rvh3hPHrS8
        ZzTQFYGniO5ubnFwDHSsLokBXlFAQFrfR/k14zKPru45MsNEioJiqtfhx0Bk7W5QsAa2ZM
        vVnRjNX32Apiug2yntEI+u2RFuHbtQmIFhSwSR994dtuKNVwJfAcZmHWaqiyxg==
From:   =?utf-8?Q?Rafael_=C3=81vila_de_Esp=C3=ADndola?= <rafael@espindo.la>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org
Subject: amdgpu: suspend-to-idle on a 4350G desktop
Date:   Sat, 21 Jan 2023 15:37:23 -0100
Message-ID: <87edrnu9mk.fsf@espindo.la>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4NzhqM17DKz9ssb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a desktop that doubles as a NAS, and would like to suspend it
when not in use. It works, but when it comes back it is using about 7W
more than before going to sleep.

It looks like a6ed2035878e5ad2e43ed175d8812ac9399d6c40 is the
culprit. The system doesn't even support S3:

% cat /sys/power/mem_sleep
[s2idle]

And looks like the vendor decided that they should not define
ACPI_FADT_LOW_POWER_S0. The MB is a Gigabyte B550I AORUS PRO AX with
bios version F16e.

Which systems had crashes when ACPI_FADT_LOW_POWER_S0 was not defined?
Would it be possible to limit the check only to those systems or at
least only to systems that have S3?

I can build the amdgpu module without that check and see if the problem
goes away if that would help.

Thanks,
Rafael
