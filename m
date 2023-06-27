Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A773FA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF0Kec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjF0Ke3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:34:29 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86EE183
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:34:23 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0DB48240101
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687862057; bh=wFrR56LpGnHjBBdhM5HE5PlJVK8qjPz+l6xZAIBnm8I=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Disposition:Content-Transfer-Encoding:From;
        b=aeVRi58RxvCoOWNOnoJlrWMeI4PM7fGEHfuDMI7xpu43loSl0xbMfHHVxLwxpWuEq
         oqOdbgdH4rOe9GRDmj4/WhPIZsbGxjy/cC9ge2VfNH/GbyfdBobZI2KBQd7P25rrj8
         ZsggqRuBTVQk/3X7p7b0ciqhgF89gpiR9waHRNWrAx31N0P/NYTR0ebq6MpSSg2Mk2
         Pa/Fcp14IGY6zRdcyczPJZLYfSfC15O1gxsNNvwAm2sor+rNdfoEBSkL/HFRbNqdZ2
         PQKLWrBTIqRFutudTKZiEicySPE0GhW/35oRwb5Eff/WsoSGydrBUy2n4LG9ozDFai
         cnY7OiVKIHlOA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qr1Kd2F6kz9rxK;
        Tue, 27 Jun 2023 12:34:12 +0200 (CEST)
Date:   Tue, 27 Jun 2023 10:34:06 +0000
From:   Anne Macedo <retpolanne@posteo.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Rene Treffer <treffer@measite.de>
Subject: Re: [PATCH] usb: host: xhci: remove renesas rom wiping
Message-ID: <eyy5flllixic3lmusslom7nt3cailisjndcn4bymkhekvdodnz@y2gylsbenekz>
References: <20230626204910.728-3-retpolanne@posteo.net>
 <ZJqUMWv1jM2KQsYu@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJqUMWv1jM2KQsYu@matsya>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:18:01PM +0530, Vinod Koul wrote:
> On 26-06-23, 20:49, Anne Macedo wrote:
> > Cards based on Renesas uPD72020x currently have their ROM wiped on
> > module start if they have an external ROM. This means that every time
> > you start up the module, the ROM gets cleaned up and the firmware
> > redownloaded.
> 
> Nak, that is not the correct understanding of the code!
> 
> In function renesas_xhci_check_request_fw(), we check ROM status first
> and if it is already programmed, we skip.. Not sure why you are assuming
> it is wiped every time!

So, these are the DMESG messages I get during this step - it's a freshly
booted machine and I kept the modules blocklisted until I was ready to
test it:

# renesas_xhci_check_request_fw -> renesas_check_rom
[  291.497544] xhci_hcd 0000:06:00.0: External ROM exists

# renesas_xhci_check_request_fw -> renesas_check_rom_state
[  291.497551] xhci_hcd 0000:06:00.0: Found ROM version: 2026
[  291.497558] xhci_hcd 0000:06:00.0: ROM exists
[  291.497560] xhci_hcd 0000:06:00.0: Unknown ROM status ...

# renesas_xhci_check_request_fw -> renesas_fw_check_running
[  291.497569] xhci_hcd 0000:06:00.0: FW is not ready/loaded yet.
# From this point, I believe that the module could not detect that
# there's a valid firmware running on the card

# renesas_xhci_check_request_fw -> renesas_load_fw -> renesas_check_rom
[  291.497985] xhci_hcd 0000:06:00.0: External ROM exists

# renesas_xhci_check_request_fw -> renesas_load_fw -> renesas_rom_erase
[  291.497996] xhci_hcd 0000:06:00.0: Performing ROM Erase...
[  291.523737] xhci_hcd 0000:06:00.0: ROM Erase... Done success

# renesas_xhci_check_request_fw -> renesas_load_fw -> renesas_setup_rom
[  319.410895] xhci_hcd 0000:06:00.0: Download to external ROM TO: 0
[  319.410904] xhci_hcd 0000:06:00.0: ROM load failed, falling back on FW load

# renesas_xhci_check_request_fw -> renesas_load_fw -> renesas_fw_download -> renesas_fw_download_image
[  319.552909] xhci_hcd 0000:06:00.0: Timeout for Set DATAX step: 2
[  319.552914] xhci_hcd 0000:06:00.0: Firmware Download Step 2 failed at position 8 bytes with (-110).
[  319.552918] xhci_hcd 0000:06:00.0: firmware failed to download (-110).
[  319.552927] xhci_hcd: probe of 0000:06:00.0 failed with error -110

These are failing due to the timeouts that I noticed on [1]. But the
timeouts aren't actually the problem – I added a bpftrace program to
trace all of the pci reads and functions from the module [2]. The output
is pretty interesting:

Renesas download image has been called with iterator i=33
Reading the config register f7 from PCI 1912:0014 - content 84f8b100
Writing the config register fc from PCI 1912:0014 - content e4251764
Writing the config register f7 from PCI 1912:0014 - content 0002
Renesas download image has been called with iterator i=34
Reading the config register f7 from PCI 1912:0014 - content 84f8b100
Reading the config register f7 from PCI 1912:0014 - content 84f8b300
# Thousands of logs later...
Reading the config register f7 from PCI 1912:0014 - content 84f8b300
Writing the config register f8 from PCI 1912:0014 - content 5c591724
Writing the config register f7 from PCI 1912:0014 - content 0001

If I understood correctly, every "step" is a DWORD, sent from
renesas_fw_download to renesas_fw_download_image, so for each DWORD a
block is sent to renesas_fw_download_image. After the 34th block, just
one byte from the F7 register changes and it locks for seconds until it
changes for the content of the firmware file (I checked with xxd and the
F8 register has exactly the same content as the 34th DWORD block). And
then F7 becomes 0000 or 0001 whether it is setting DATA0 or DATA1.

This was timing out on my machine, and I believe this was also timing
out in your environment, according to this message [3]. Some people on
the Lenovo forums also had the same problem on the step 34 [4].

Anyways, I manually increased the timeout to make the ROM programming
and FW download go through, so my card was stable, but whenever I would
boot onto another kernel build, it would get erased and overwritten. So
it is true that it gets erased *at least* during the first module
startup. 

Without the ROM erase, the module startup goes through blazingly fast on
this card. Card gets recognized, USB-C works, if I want to use USB-C on
boot (which is my plan) it will not impact boot times as well. 

I know removing completely this path may not be ideal, but erasing the
ROM on every boot, at least for this card (I'm buying other cards with
the same chipset to analyse the behaviour, but they are coming from
China to Brazil, so it's going to take a while), is not ideal as these
specific blocks that I mentioned take a long time to be overwritten. 

For *my* card it seems better not to erase the ROM, as it is stable from
other boots. To me, it seems like the module is touching the ROM
unnecessarily.

Do you have any suggestions for improving this module, taking into
consideration this context that I provided? 

[1] https://patchwork.kernel.org/project/linux-usb/patch/20230618224656.2476-2-retpolanne@posteo.net/
[2] https://github.com/retpolanne/kernel-workspace/blob/main/bpf/renesas-pci-trace.bt
[3] https://lore.kernel.org/lkml/20190626070658.GP2962@vkoul-mobl/
[4] https://forums.lenovo.com/t5/Other-Linux-Discussions/P14s-Gen-2-AMD-Linux-boot-errors/m-p/5206830

> 
>         /* Check if device has ROM and loaded, if so skip everything */
>         has_rom = renesas_check_rom(pdev);
>         if (has_rom) {
>                 err = renesas_check_rom_state(pdev);
>                 if (!err)
>                         return 0;
>                 else if (err != -ENOENT)
>                         has_rom = false;
>         }
> 
> Erasing ROM is part of ROM programming sequence and is also required to
> if we ever have to recover, so this patch is NAKed by me
> 
> > Wiping the ROM all the time is not necessary and can lead to situations
> > where, for example, people with stable firmwares might have their card fail
> > due to incomplete flashes (due to timeouts, for example).
> > 
> > Another case is when PCI configs are set up after the ROM is flashed
> > (e.g. disabling hotplugging). The ROM wipe and reflash process will
> > overwrite these configs.
> 
> Why would ROM programming overwrite PCI config, does your device update
> that. In case you are programming config space you should redo that
> after ROM load (which should be done once)
> 
> > Also, the current ROM setup can't work: the flash layout contains more
> > than the firmware – for uploading, it needs to be prefixed with ~40
> > bytes that differ by card vendor. This config is documented on the
> > "uPD720201/uPD720202 User's Manual", section 6.3 (Data Format).
> 
> I assure you it works for me on a publicly available Qualcomm Robotics
> RB3 board  and many people who have tested. It may not work for you, but
> you need to investigate better on what might be the cause. Btw what are
> you testing this on..

I'm testing on a Panhong PH61 Rev.1.3 21K30 PCI-E controller card. It
has a Puya P25Q40H ROM. I know it's a rather obscure card, but it was
the only one that was easily available on my local marketplace. 
> 
> > This patch, if applied, removes the cleanup and the setup of the Renesas
> > ROM as to not make it wipe and reset the ROM.
> > 
> > It also reduces load time, especially during boot, as problems with the
> > EEPROM chip or CRC checks might take some time during reflashing and
> > possibly lead to timeouts. Since the ROM is already flashed (either
> > manually by a tool such as uPD72020x-load or by the kernel module) it
> 
> where is this tool, I have not heard of it, is it publicly available,
> where can I find the source of this tool?

This is the repo: https://github.com/markusj/upd72020x-load

> 
> > just needs to be loaded during module startup.
> > 
> > Suggested-by: Rene Treffer <treffer@measite.de>
> > Signed-off-by: Anne Macedo <retpolanne@posteo.net>
> > ---
> >  drivers/usb/host/xhci-pci-renesas.c | 188 ----------------------------
> >  1 file changed, 188 deletions(-)
> > 
> > diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
> > index 93f8b355bc70..28656beb808d 100644
> > --- a/drivers/usb/host/xhci-pci-renesas.c
> > +++ b/drivers/usb/host/xhci-pci-renesas.c
> > @@ -375,199 +375,11 @@ static int renesas_fw_download(struct pci_dev *pdev,
> >  	return 0;
> >  }
> >  
> > -static void renesas_rom_erase(struct pci_dev *pdev)
> > -{
> > -	int retval, i;
> > -	u8 status;
> > -
> > -	dev_dbg(&pdev->dev, "Performing ROM Erase...\n");
> > -	retval = pci_write_config_dword(pdev, RENESAS_DATA0,
> > -					RENESAS_ROM_ERASE_MAGIC);
> > -	if (retval) {
> > -		dev_err(&pdev->dev, "ROM erase, magic word write failed: %d\n",
> > -			pcibios_err_to_errno(retval));
> > -		return;
> > -	}
> > -
> > -	retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> > -	if (retval) {
> > -		dev_err(&pdev->dev, "ROM status read failed: %d\n",
> > -			pcibios_err_to_errno(retval));
> > -		return;
> > -	}
> > -	status |= RENESAS_ROM_STATUS_ERASE;
> > -	retval = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, status);
> > -	if (retval) {
> > -		dev_err(&pdev->dev, "ROM erase set word write failed\n");
> > -		return;
> > -	}
> > -
> > -	/* sleep a bit while ROM is erased */
> > -	msleep(20);
> > -
> > -	for (i = 0; i < RENESAS_RETRY; i++) {
> > -		retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS,
> > -					      &status);
> > -		status &= RENESAS_ROM_STATUS_ERASE;
> > -		if (!status)
> > -			break;
> > -
> > -		mdelay(RENESAS_DELAY);
> > -	}
> > -
> > -	if (i == RENESAS_RETRY)
> > -		dev_dbg(&pdev->dev, "Chip erase timedout: %x\n", status);
> > -
> > -	dev_dbg(&pdev->dev, "ROM Erase... Done success\n");
> > -}
> > -
> > -static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
> > -{
> > -	const u32 *fw_data = (const u32 *)fw->data;
> > -	int err, i;
> > -	u8 status;
> > -
> > -	/* 2. Write magic word to Data0 */
> > -	err = pci_write_config_dword(pdev, RENESAS_DATA0,
> > -				     RENESAS_ROM_WRITE_MAGIC);
> > -	if (err)
> > -		return false;
> > -
> > -	/* 3. Set External ROM access */
> > -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
> > -				    RENESAS_ROM_STATUS_ACCESS);
> > -	if (err)
> > -		goto remove_bypass;
> > -
> > -	/* 4. Check the result */
> > -	err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> > -	if (err)
> > -		goto remove_bypass;
> > -	status &= GENMASK(6, 4);
> > -	if (status) {
> > -		dev_err(&pdev->dev,
> > -			"setting external rom failed: %x\n", status);
> > -		goto remove_bypass;
> > -	}
> > -
> > -	/* 5 to 16 Write FW to DATA0/1 while checking SetData0/1 */
> > -	for (i = 0; i < fw->size / 4; i++) {
> > -		err = renesas_fw_download_image(pdev, fw_data, i, true);
> > -		if (err) {
> > -			dev_err(&pdev->dev,
> > -				"ROM Download Step %d failed at position %d bytes with (%d)\n",
> > -				 i, i * 4, err);
> > -			goto remove_bypass;
> > -		}
> > -	}
> > -
> > -	/*
> > -	 * wait till DATA0/1 is cleared
> > -	 */
> > -	for (i = 0; i < RENESAS_RETRY; i++) {
> > -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS_MSB,
> > -					   &status);
> > -		if (err)
> > -			goto remove_bypass;
> > -		if (!(status & (BIT(0) | BIT(1))))
> > -			break;
> > -
> > -		udelay(RENESAS_DELAY);
> > -	}
> > -	if (i == RENESAS_RETRY) {
> > -		dev_err(&pdev->dev, "Final Firmware ROM Download step timed out\n");
> > -		goto remove_bypass;
> > -	}
> > -
> > -	/* 17. Remove bypass */
> > -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
> > -	if (err)
> > -		return false;
> > -
> > -	udelay(10);
> > -
> > -	/* 18. check result */
> > -	for (i = 0; i < RENESAS_RETRY; i++) {
> > -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> > -		if (err) {
> > -			dev_err(&pdev->dev, "Read ROM status failed:%d\n",
> > -				pcibios_err_to_errno(err));
> > -			return false;
> > -		}
> > -		status &= RENESAS_ROM_STATUS_RESULT;
> > -		if (status ==  RENESAS_ROM_STATUS_SUCCESS) {
> > -			dev_dbg(&pdev->dev, "Download ROM success\n");
> > -			break;
> > -		}
> > -		udelay(RENESAS_DELAY);
> > -	}
> > -	if (i == RENESAS_RETRY) { /* Timed out */
> > -		dev_err(&pdev->dev,
> > -			"Download to external ROM TO: %x\n", status);
> > -		return false;
> > -	}
> > -
> > -	dev_dbg(&pdev->dev, "Download to external ROM succeeded\n");
> > -
> > -	/* Last step set Reload */
> > -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
> > -				    RENESAS_ROM_STATUS_RELOAD);
> > -	if (err) {
> > -		dev_err(&pdev->dev, "Set ROM execute failed: %d\n",
> > -			pcibios_err_to_errno(err));
> > -		return false;
> > -	}
> > -
> > -	/*
> > -	 * wait till Reload is cleared
> > -	 */
> > -	for (i = 0; i < RENESAS_RETRY; i++) {
> > -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> > -		if (err)
> > -			return false;
> > -		if (!(status & RENESAS_ROM_STATUS_RELOAD))
> > -			break;
> > -
> > -		udelay(RENESAS_DELAY);
> > -	}
> > -	if (i == RENESAS_RETRY) {
> > -		dev_err(&pdev->dev, "ROM Exec timed out: %x\n", status);
> > -		return false;
> > -	}
> > -
> > -	return true;
> > -
> > -remove_bypass:
> > -	pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
> > -	return false;
> > -}
> > -
> >  static int renesas_load_fw(struct pci_dev *pdev, const struct firmware *fw)
> >  {
> >  	int err = 0;
> > -	bool rom;
> > -
> > -	/* Check if the device has external ROM */
> > -	rom = renesas_check_rom(pdev);
> > -	if (rom) {
> > -		/* perform chip erase first */
> > -		renesas_rom_erase(pdev);
> > -
> > -		/* lets try loading fw on ROM first */
> > -		rom = renesas_setup_rom(pdev, fw);
> > -		if (!rom) {
> > -			dev_dbg(&pdev->dev,
> > -				"ROM load failed, falling back on FW load\n");
> > -		} else {
> > -			dev_dbg(&pdev->dev,
> > -				"ROM load success\n");
> > -			goto exit;
> > -		}
> > -	}
> >  
> >  	err = renesas_fw_download(pdev, fw);
> > -
> > -exit:
> >  	if (err)
> >  		dev_err(&pdev->dev, "firmware failed to download (%d).", err);
> >  	return err;
> > -- 
> > 2.41.0
> 
> -- 
> ~Vinod
