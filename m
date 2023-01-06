Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0A6606CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjAFS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjAFS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:57:58 -0500
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7077D0B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 10:57:57 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id C20F116C0002;
        Fri,  6 Jan 2023 20:39:20 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XVre5n-Ey0QP; Fri,  6 Jan 2023 20:39:20 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1673030359; bh=fNmEoimusZ9c7AY5q2dIdtrOELvykZSuN250etZkQkg=;
        h=From:To:Cc:Subject:Date:From;
        b=KaFu8EOnvce2XH3yt5bmGi2blDxWmHjswwhiRHFMrpaHjkCtnYFx6q7tc41OZiZ2K
         18NDuqIFK7sHWEc/kbPohuETJxP0a/O+bnFQBsu6QFz6jRZPpeYVtmKGsgMNRuHR2Y
         4G0IDCZPSXeTAzAk8pWoNVeR1BDompfiajHf4nBE=
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [RFC] Sound support for Huawei line of AMD laptops using ACP and
 ES8336 codec
Date:   Fri, 06 Jan 2023 20:39:17 +0200
Message-ID: <874jt3fqy2.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Huawei Matebook 14 AMD 2021 laptop for which the sound isn't
supported on Linux. On further investigation in Windows and ACPI tables
I could determine that this particular SKU has an ES8336 codec connected
to the CPU ACP module.
The CPU of my laptop is an AMD Ryzen 5 5500U which seems to be codenamed
Lucienne and is a derivation of the Renoir family.
Acording to lspci the ACP is revision 1:

03:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] Raven/Raven2/FireFlight/Renoir Audio Processor [1022:15e2] (rev 01)
        Subsystem: Device [1e83:3e4d]
        Kernel driver in use: snd_rn_pci_acp3x
        Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x,
        snd_pci_acp6x, snd_acp_pci, snd_rpl_pci_acp6x,
        snd_sof_amd_renoir

I have written a machine driver for this platform and managed to make
the sound and internal microphone work. I am looking to integrate this
support but there are some issues with the current implementation of ACP
support.

As far as I can tell there are 4 directions I could take to add support:

1. A standalone machine driver in sound/soc/amd that uses the platform
  drivers from sound/soc/amd/raven/

2. An embedded driver in sound/soc/amd/acp/acp-legacy-mach.c

3. A standalone machine driver in sound/soc/amd that uses the platform
  drivers from sound/soc/amd/renoir

4. Use the SOF infrastructure

Now as far as I can tell, all of these directions have issues:

1. The pci driver from sound/soc/amd/raven/pci-acp3x.c doesn't support Lucienne
   since it blocks rev 1 devices in :

   /* Raven device detection */
   if (pci->revision != 0x00)
       return -ENODEV;

   This is the approach I took and just changed the check to add support
   for rev 1.
   The sound and internal microphone worked ok and I didn't encounter any
   issues with it. Of course I don't know the internals of ACP and
   don't know what are the differences between rev 0 and rev 1.

2. This approach could work but I would need to change the structure
   acp_card_drvdata and struct snd_soc_dapm_widget acp_widgets,
   to add proper support for jack handling (and maybe some other
   modifications).
   This driver seems to support rev 1 (in sound/soc/amd/acp/acp-pci.c):

   switch (pci->revision) {
    	case 0x01:
		chip->name = "acp_asoc_renoir";
		chip->acp_rev = ACP3X_DEV;
		break;

   Also from the module description it seems that these drivers are
   meant only for chromebook support.

3. This seems like it would the best approach in theory, but the problem
   is that the drivers inside only seem to add support for DMIC.

4. I tried to use SOF early when I started tinkering, but I always got a
   timeout during init phase when loading the renoir firmware.

So the reason for this email is to get some idea, on how to best add
support for these laptops.

