Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1E73F600
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjF0HsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjF0HsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A591BEF;
        Tue, 27 Jun 2023 00:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6D96104F;
        Tue, 27 Jun 2023 07:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35056C433C8;
        Tue, 27 Jun 2023 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687852085;
        bh=ZKJdk7+eb922UMMNDLeGRBSkHEMaZY+MyhMR+FRX4dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAYH7fThraQBh3W2I3HGXofUGkQ0inKnXYqn1U1rfQsXpW6+CXWbIfU5Nroq938fK
         3aPLQdNauvp8TGiLZiv0UTEfMLt2UBpyjAaiABRay7wOFCt9xVMKfcgmH0w5rcZKDp
         I+YWCqBz4mROI9QWEYTBmUjd6mT9fMoeq2tCL5GucVNa284duKUnf+B8tpy8MfpvTj
         NzEodcc6qtOXhI8GiQxCb82AB57j39DK76LxAzFOW6NpheDKaR39V1sPsxqg0AvEKy
         /uF93zqDB8pVIQwdaedVeMoZlmoNLDGiJ8SQjwmO+wXnNG6a/NpPvU0qpvvVCjZiX6
         AkuSmyMYdIn0g==
Date:   Tue, 27 Jun 2023 13:18:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anne Macedo <retpolanne@posteo.net>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Rene Treffer <treffer@measite.de>
Subject: Re: [PATCH] usb: host: xhci: remove renesas rom wiping
Message-ID: <ZJqUMWv1jM2KQsYu@matsya>
References: <20230626204910.728-3-retpolanne@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626204910.728-3-retpolanne@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-23, 20:49, Anne Macedo wrote:
> Cards based on Renesas uPD72020x currently have their ROM wiped on
> module start if they have an external ROM. This means that every time
> you start up the module, the ROM gets cleaned up and the firmware
> redownloaded.

Nak, that is not the correct understanding of the code!

In function renesas_xhci_check_request_fw(), we check ROM status first
and if it is already programmed, we skip.. Not sure why you are assuming
it is wiped every time!

        /* Check if device has ROM and loaded, if so skip everything */
        has_rom = renesas_check_rom(pdev);
        if (has_rom) {
                err = renesas_check_rom_state(pdev);
                if (!err)
                        return 0;
                else if (err != -ENOENT)
                        has_rom = false;
        }

Erasing ROM is part of ROM programming sequence and is also required to
if we ever have to recover, so this patch is NAKed by me

> Wiping the ROM all the time is not necessary and can lead to situations
> where, for example, people with stable firmwares might have their card fail
> due to incomplete flashes (due to timeouts, for example).
> 
> Another case is when PCI configs are set up after the ROM is flashed
> (e.g. disabling hotplugging). The ROM wipe and reflash process will
> overwrite these configs.

Why would ROM programming overwrite PCI config, does your device update
that. In case you are programming config space you should redo that
after ROM load (which should be done once)

> Also, the current ROM setup can't work: the flash layout contains more
> than the firmware – for uploading, it needs to be prefixed with ~40
> bytes that differ by card vendor. This config is documented on the
> "uPD720201/uPD720202 User's Manual", section 6.3 (Data Format).

I assure you it works for me on a publicly available Qualcomm Robotics
RB3 board  and many people who have tested. It may not work for you, but
you need to investigate better on what might be the cause. Btw what are
you testing this on..

> This patch, if applied, removes the cleanup and the setup of the Renesas
> ROM as to not make it wipe and reset the ROM.
> 
> It also reduces load time, especially during boot, as problems with the
> EEPROM chip or CRC checks might take some time during reflashing and
> possibly lead to timeouts. Since the ROM is already flashed (either
> manually by a tool such as uPD72020x-load or by the kernel module) it

where is this tool, I have not heard of it, is it publicly available,
where can I find the source of this tool?

> just needs to be loaded during module startup.
> 
> Suggested-by: Rene Treffer <treffer@measite.de>
> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
> ---
>  drivers/usb/host/xhci-pci-renesas.c | 188 ----------------------------
>  1 file changed, 188 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
> index 93f8b355bc70..28656beb808d 100644
> --- a/drivers/usb/host/xhci-pci-renesas.c
> +++ b/drivers/usb/host/xhci-pci-renesas.c
> @@ -375,199 +375,11 @@ static int renesas_fw_download(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> -static void renesas_rom_erase(struct pci_dev *pdev)
> -{
> -	int retval, i;
> -	u8 status;
> -
> -	dev_dbg(&pdev->dev, "Performing ROM Erase...\n");
> -	retval = pci_write_config_dword(pdev, RENESAS_DATA0,
> -					RENESAS_ROM_ERASE_MAGIC);
> -	if (retval) {
> -		dev_err(&pdev->dev, "ROM erase, magic word write failed: %d\n",
> -			pcibios_err_to_errno(retval));
> -		return;
> -	}
> -
> -	retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> -	if (retval) {
> -		dev_err(&pdev->dev, "ROM status read failed: %d\n",
> -			pcibios_err_to_errno(retval));
> -		return;
> -	}
> -	status |= RENESAS_ROM_STATUS_ERASE;
> -	retval = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, status);
> -	if (retval) {
> -		dev_err(&pdev->dev, "ROM erase set word write failed\n");
> -		return;
> -	}
> -
> -	/* sleep a bit while ROM is erased */
> -	msleep(20);
> -
> -	for (i = 0; i < RENESAS_RETRY; i++) {
> -		retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS,
> -					      &status);
> -		status &= RENESAS_ROM_STATUS_ERASE;
> -		if (!status)
> -			break;
> -
> -		mdelay(RENESAS_DELAY);
> -	}
> -
> -	if (i == RENESAS_RETRY)
> -		dev_dbg(&pdev->dev, "Chip erase timedout: %x\n", status);
> -
> -	dev_dbg(&pdev->dev, "ROM Erase... Done success\n");
> -}
> -
> -static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
> -{
> -	const u32 *fw_data = (const u32 *)fw->data;
> -	int err, i;
> -	u8 status;
> -
> -	/* 2. Write magic word to Data0 */
> -	err = pci_write_config_dword(pdev, RENESAS_DATA0,
> -				     RENESAS_ROM_WRITE_MAGIC);
> -	if (err)
> -		return false;
> -
> -	/* 3. Set External ROM access */
> -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
> -				    RENESAS_ROM_STATUS_ACCESS);
> -	if (err)
> -		goto remove_bypass;
> -
> -	/* 4. Check the result */
> -	err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> -	if (err)
> -		goto remove_bypass;
> -	status &= GENMASK(6, 4);
> -	if (status) {
> -		dev_err(&pdev->dev,
> -			"setting external rom failed: %x\n", status);
> -		goto remove_bypass;
> -	}
> -
> -	/* 5 to 16 Write FW to DATA0/1 while checking SetData0/1 */
> -	for (i = 0; i < fw->size / 4; i++) {
> -		err = renesas_fw_download_image(pdev, fw_data, i, true);
> -		if (err) {
> -			dev_err(&pdev->dev,
> -				"ROM Download Step %d failed at position %d bytes with (%d)\n",
> -				 i, i * 4, err);
> -			goto remove_bypass;
> -		}
> -	}
> -
> -	/*
> -	 * wait till DATA0/1 is cleared
> -	 */
> -	for (i = 0; i < RENESAS_RETRY; i++) {
> -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS_MSB,
> -					   &status);
> -		if (err)
> -			goto remove_bypass;
> -		if (!(status & (BIT(0) | BIT(1))))
> -			break;
> -
> -		udelay(RENESAS_DELAY);
> -	}
> -	if (i == RENESAS_RETRY) {
> -		dev_err(&pdev->dev, "Final Firmware ROM Download step timed out\n");
> -		goto remove_bypass;
> -	}
> -
> -	/* 17. Remove bypass */
> -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
> -	if (err)
> -		return false;
> -
> -	udelay(10);
> -
> -	/* 18. check result */
> -	for (i = 0; i < RENESAS_RETRY; i++) {
> -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> -		if (err) {
> -			dev_err(&pdev->dev, "Read ROM status failed:%d\n",
> -				pcibios_err_to_errno(err));
> -			return false;
> -		}
> -		status &= RENESAS_ROM_STATUS_RESULT;
> -		if (status ==  RENESAS_ROM_STATUS_SUCCESS) {
> -			dev_dbg(&pdev->dev, "Download ROM success\n");
> -			break;
> -		}
> -		udelay(RENESAS_DELAY);
> -	}
> -	if (i == RENESAS_RETRY) { /* Timed out */
> -		dev_err(&pdev->dev,
> -			"Download to external ROM TO: %x\n", status);
> -		return false;
> -	}
> -
> -	dev_dbg(&pdev->dev, "Download to external ROM succeeded\n");
> -
> -	/* Last step set Reload */
> -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
> -				    RENESAS_ROM_STATUS_RELOAD);
> -	if (err) {
> -		dev_err(&pdev->dev, "Set ROM execute failed: %d\n",
> -			pcibios_err_to_errno(err));
> -		return false;
> -	}
> -
> -	/*
> -	 * wait till Reload is cleared
> -	 */
> -	for (i = 0; i < RENESAS_RETRY; i++) {
> -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
> -		if (err)
> -			return false;
> -		if (!(status & RENESAS_ROM_STATUS_RELOAD))
> -			break;
> -
> -		udelay(RENESAS_DELAY);
> -	}
> -	if (i == RENESAS_RETRY) {
> -		dev_err(&pdev->dev, "ROM Exec timed out: %x\n", status);
> -		return false;
> -	}
> -
> -	return true;
> -
> -remove_bypass:
> -	pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
> -	return false;
> -}
> -
>  static int renesas_load_fw(struct pci_dev *pdev, const struct firmware *fw)
>  {
>  	int err = 0;
> -	bool rom;
> -
> -	/* Check if the device has external ROM */
> -	rom = renesas_check_rom(pdev);
> -	if (rom) {
> -		/* perform chip erase first */
> -		renesas_rom_erase(pdev);
> -
> -		/* lets try loading fw on ROM first */
> -		rom = renesas_setup_rom(pdev, fw);
> -		if (!rom) {
> -			dev_dbg(&pdev->dev,
> -				"ROM load failed, falling back on FW load\n");
> -		} else {
> -			dev_dbg(&pdev->dev,
> -				"ROM load success\n");
> -			goto exit;
> -		}
> -	}
>  
>  	err = renesas_fw_download(pdev, fw);
> -
> -exit:
>  	if (err)
>  		dev_err(&pdev->dev, "firmware failed to download (%d).", err);
>  	return err;
> -- 
> 2.41.0

-- 
~Vinod
