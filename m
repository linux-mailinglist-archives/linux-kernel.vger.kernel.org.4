Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7983F73FB17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF0LYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjF0LYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:24:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297F2717
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:24:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e68e99c7so4051074f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=measite-de.20221208.gappssmtp.com; s=20221208; t=1687865061; x=1690457061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKnu6rMOOZjSXcGYNWdL6p9bBSOmCtnr/RsZ2K04ZeI=;
        b=IAW2WLILND+eApJhNLscbwAHZh9PViv6iqe23tABnyHHXe7HRPb1HdIQPnNoncPMCH
         atgW2JsO46lnrp+ga3iKeZeiP44olrm168l7sl3whN0IeFFaxVCyoN4mZvvGBxfG+H2H
         AIibJI90ToleQ6GHmsDuiKKNObbDlQ08vjVe4SAS1AAy/XpSnHLRyiW6esZrwG0Z/9N2
         TDHaZ+OgSAUhOhTetcW4ZjCJ73UFVpBZM6Sr4K/Eg/zV3EC6BeSW65B2syCEFL3mrcUs
         ag+DJGWkeI8+5/FAG4YueaV9shD44bf/f/coGlRVZnK1Z8Ccldnc01dMgrGV02QOuROk
         kJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687865061; x=1690457061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKnu6rMOOZjSXcGYNWdL6p9bBSOmCtnr/RsZ2K04ZeI=;
        b=kbrtfaSTkCQ3jMuP97Fx+dVUFGyeHTWWI0BazmSPYsgoOXr8YhpH3ceustEDYSPn5S
         v4HDvUVut74gL+eLtjwbBugTwWlCNPfQqY9elwEiEdmoBvcchidWRdZSNjj2YY9NiZMp
         JXz8hKajvS8faF+NSXprsb/Zjs6Qk1Mm2vFoJvLnqaw1i/CLMNpYZLsrV0sR1H5gpFCH
         fZGuQ2JIC3kOdMsJh4bqBD8qZUm9RNxODLmNHvWLqkcZZmCKK64BPYdIgLEaHPwj4y78
         RjDtrgfB6rQr3SWr4GQf0P5DHol8NDCiuAn0wjIeRuABa+dT1m4As+ATBlqehYVlqIoF
         o/3A==
X-Gm-Message-State: AC+VfDwPy8OVQRrd2od/OL6y0Zw8cG+MaIiweBiJx/WS7byiMfPXfULV
        OGr6a0FbmNlvJae9FZj8sV3ZpQ==
X-Google-Smtp-Source: ACHHUZ68o6ec/sBrxg3mhUL2zrbYllO2b2awBVHC0T/rJDDp+pLOGnnH6mueGW/gWfrp3Y4CGc4sTQ==
X-Received: by 2002:adf:e605:0:b0:314:1d4:b3a7 with SMTP id p5-20020adfe605000000b0031401d4b3a7mr924372wrm.33.1687865060595;
        Tue, 27 Jun 2023 04:24:20 -0700 (PDT)
Received: from ?IPV6:2a02:2454:3d7:b901:c5e4:944:e4d9:8d90? ([2a02:2454:3d7:b901:c5e4:944:e4d9:8d90])
        by smtp.gmail.com with ESMTPSA id i11-20020adfefcb000000b0030ae3a6be5bsm10140996wrp.78.2023.06.27.04.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 04:24:20 -0700 (PDT)
Message-ID: <0b553f38-2972-696d-866c-006f6aff48dc@measite.de>
Date:   Tue, 27 Jun 2023 13:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] usb: host: xhci: remove renesas rom wiping
To:     Vinod Koul <vkoul@kernel.org>, Anne Macedo <retpolanne@posteo.net>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>
References: <20230626204910.728-3-retpolanne@posteo.net>
 <ZJqUMWv1jM2KQsYu@matsya>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Treffer?= <treffer@measite.de>
In-Reply-To: <ZJqUMWv1jM2KQsYu@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.06.23 09:48, Vinod Koul wrote:
> On 26-06-23, 20:49, Anne Macedo wrote:
>> Cards based on Renesas uPD72020x currently have their ROM wiped on
>> module start if they have an external ROM. This means that every time
>> you start up the module, the ROM gets cleaned up and the firmware
>> redownloaded.
> Nak, that is not the correct understanding of the code!
>
> In function renesas_xhci_check_request_fw(), we check ROM status first
> and if it is already programmed, we skip.. Not sure why you are assuming
> it is wiped every time!
>
>          /* Check if device has ROM and loaded, if so skip everything */
>          has_rom = renesas_check_rom(pdev);
>          if (has_rom) {
>                  err = renesas_check_rom_state(pdev);
>                  if (!err)
>                          return 0;
>                  else if (err != -ENOENT)
>                          has_rom = false;
>          }
>
> Erasing ROM is part of ROM programming sequence and is also required to
> if we ever have to recover, so this patch is NAKed by me

As far as I know the upload to ROM needs to follow the ROM layout as 
noted in the "uPD720201/uPD720202 User's Manual: Hardware", and it 
differs from the FW by having a vendor specific configuration (page 
127). The vendor specific configuration is equivalent to configuring the 
PCI registers.

I have successfully uploaded firmware to the ROM of a card with the 
upd72020x-load tool and documented this in the github issue at [1]. It 
needed a vendor specific configuration and the firmware to work, even 
though the manual seems to indicate that the firmware is enough.

[1] https://github.com/markusj/upd72020x-load/issues/15 and 
https://github.com/geerlingguy/raspberry-pi-pcie-devices/issues/103 for 
out-of-band flashing.

>
>> Wiping the ROM all the time is not necessary and can lead to situations
>> where, for example, people with stable firmwares might have their card fail
>> due to incomplete flashes (due to timeouts, for example).
>>
>> Another case is when PCI configs are set up after the ROM is flashed
>> (e.g. disabling hotplugging). The ROM wipe and reflash process will
>> overwrite these configs.
> Why would ROM programming overwrite PCI config, does your device update
> that. In case you are programming config space you should redo that
> after ROM load (which should be done once)

The vendor specific configuration is responsible for describing the PCI 
setup, and wiping the ROM should wipe that.

>
>> Also, the current ROM setup can't work: the flash layout contains more
>> than the firmware – for uploading, it needs to be prefixed with ~40
>> bytes that differ by card vendor. This config is documented on the
>> "uPD720201/uPD720202 User's Manual", section 6.3 (Data Format).
> I assure you it works for me on a publicly available Qualcomm Robotics
> RB3 board  and many people who have tested. It may not work for you, but
> you need to investigate better on what might be the cause. Btw what are
> you testing this on..

I highly doubt that the ROM download works as intended. However the ROM 
has 2 areas (copies) as described in the manual on page 129 The flow 
chart on page 130 makes it clear that the first ROM section is used as a 
fallback.

But if the ROM is completely empty or the first section is corrupted and 
if the download to ROM fails then there is no firmware to load. Which is 
what I am assuming here. I want to test this at some point with the card 
I have lying around (use the external SOIC8 to wipe the whole flash). In 
all other cases the download should just fail and the card should come 
up normally.

According to the manual the regular fw download is always available, 
does not change the PCI configuration and should just work no matter the 
ROM setup.
That's why I suggested to remove the download to ROM and see if it helps.
And it made Anne's card work.

Regards,
   René

>> This patch, if applied, removes the cleanup and the setup of the Renesas
>> ROM as to not make it wipe and reset the ROM.
>>
>> It also reduces load time, especially during boot, as problems with the
>> EEPROM chip or CRC checks might take some time during reflashing and
>> possibly lead to timeouts. Since the ROM is already flashed (either
>> manually by a tool such as uPD72020x-load or by the kernel module) it
> where is this tool, I have not heard of it, is it publicly available,
> where can I find the source of this tool?
>
>> just needs to be loaded during module startup.
>>
>> Suggested-by: Rene Treffer <treffer@measite.de>
>> Signed-off-by: Anne Macedo <retpolanne@posteo.net>
>> ---
>>   drivers/usb/host/xhci-pci-renesas.c | 188 ----------------------------
>>   1 file changed, 188 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
>> index 93f8b355bc70..28656beb808d 100644
>> --- a/drivers/usb/host/xhci-pci-renesas.c
>> +++ b/drivers/usb/host/xhci-pci-renesas.c
>> @@ -375,199 +375,11 @@ static int renesas_fw_download(struct pci_dev *pdev,
>>   	return 0;
>>   }
>>   
>> -static void renesas_rom_erase(struct pci_dev *pdev)
>> -{
>> -	int retval, i;
>> -	u8 status;
>> -
>> -	dev_dbg(&pdev->dev, "Performing ROM Erase...\n");
>> -	retval = pci_write_config_dword(pdev, RENESAS_DATA0,
>> -					RENESAS_ROM_ERASE_MAGIC);
>> -	if (retval) {
>> -		dev_err(&pdev->dev, "ROM erase, magic word write failed: %d\n",
>> -			pcibios_err_to_errno(retval));
>> -		return;
>> -	}
>> -
>> -	retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
>> -	if (retval) {
>> -		dev_err(&pdev->dev, "ROM status read failed: %d\n",
>> -			pcibios_err_to_errno(retval));
>> -		return;
>> -	}
>> -	status |= RENESAS_ROM_STATUS_ERASE;
>> -	retval = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, status);
>> -	if (retval) {
>> -		dev_err(&pdev->dev, "ROM erase set word write failed\n");
>> -		return;
>> -	}
>> -
>> -	/* sleep a bit while ROM is erased */
>> -	msleep(20);
>> -
>> -	for (i = 0; i < RENESAS_RETRY; i++) {
>> -		retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS,
>> -					      &status);
>> -		status &= RENESAS_ROM_STATUS_ERASE;
>> -		if (!status)
>> -			break;
>> -
>> -		mdelay(RENESAS_DELAY);
>> -	}
>> -
>> -	if (i == RENESAS_RETRY)
>> -		dev_dbg(&pdev->dev, "Chip erase timedout: %x\n", status);
>> -
>> -	dev_dbg(&pdev->dev, "ROM Erase... Done success\n");
>> -}
>> -
>> -static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
>> -{
>> -	const u32 *fw_data = (const u32 *)fw->data;
>> -	int err, i;
>> -	u8 status;
>> -
>> -	/* 2. Write magic word to Data0 */
>> -	err = pci_write_config_dword(pdev, RENESAS_DATA0,
>> -				     RENESAS_ROM_WRITE_MAGIC);
>> -	if (err)
>> -		return false;
>> -
>> -	/* 3. Set External ROM access */
>> -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
>> -				    RENESAS_ROM_STATUS_ACCESS);
>> -	if (err)
>> -		goto remove_bypass;
>> -
>> -	/* 4. Check the result */
>> -	err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
>> -	if (err)
>> -		goto remove_bypass;
>> -	status &= GENMASK(6, 4);
>> -	if (status) {
>> -		dev_err(&pdev->dev,
>> -			"setting external rom failed: %x\n", status);
>> -		goto remove_bypass;
>> -	}
>> -
>> -	/* 5 to 16 Write FW to DATA0/1 while checking SetData0/1 */
>> -	for (i = 0; i < fw->size / 4; i++) {
>> -		err = renesas_fw_download_image(pdev, fw_data, i, true);
>> -		if (err) {
>> -			dev_err(&pdev->dev,
>> -				"ROM Download Step %d failed at position %d bytes with (%d)\n",
>> -				 i, i * 4, err);
>> -			goto remove_bypass;
>> -		}
>> -	}
>> -
>> -	/*
>> -	 * wait till DATA0/1 is cleared
>> -	 */
>> -	for (i = 0; i < RENESAS_RETRY; i++) {
>> -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS_MSB,
>> -					   &status);
>> -		if (err)
>> -			goto remove_bypass;
>> -		if (!(status & (BIT(0) | BIT(1))))
>> -			break;
>> -
>> -		udelay(RENESAS_DELAY);
>> -	}
>> -	if (i == RENESAS_RETRY) {
>> -		dev_err(&pdev->dev, "Final Firmware ROM Download step timed out\n");
>> -		goto remove_bypass;
>> -	}
>> -
>> -	/* 17. Remove bypass */
>> -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
>> -	if (err)
>> -		return false;
>> -
>> -	udelay(10);
>> -
>> -	/* 18. check result */
>> -	for (i = 0; i < RENESAS_RETRY; i++) {
>> -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
>> -		if (err) {
>> -			dev_err(&pdev->dev, "Read ROM status failed:%d\n",
>> -				pcibios_err_to_errno(err));
>> -			return false;
>> -		}
>> -		status &= RENESAS_ROM_STATUS_RESULT;
>> -		if (status ==  RENESAS_ROM_STATUS_SUCCESS) {
>> -			dev_dbg(&pdev->dev, "Download ROM success\n");
>> -			break;
>> -		}
>> -		udelay(RENESAS_DELAY);
>> -	}
>> -	if (i == RENESAS_RETRY) { /* Timed out */
>> -		dev_err(&pdev->dev,
>> -			"Download to external ROM TO: %x\n", status);
>> -		return false;
>> -	}
>> -
>> -	dev_dbg(&pdev->dev, "Download to external ROM succeeded\n");
>> -
>> -	/* Last step set Reload */
>> -	err = pci_write_config_byte(pdev, RENESAS_ROM_STATUS,
>> -				    RENESAS_ROM_STATUS_RELOAD);
>> -	if (err) {
>> -		dev_err(&pdev->dev, "Set ROM execute failed: %d\n",
>> -			pcibios_err_to_errno(err));
>> -		return false;
>> -	}
>> -
>> -	/*
>> -	 * wait till Reload is cleared
>> -	 */
>> -	for (i = 0; i < RENESAS_RETRY; i++) {
>> -		err = pci_read_config_byte(pdev, RENESAS_ROM_STATUS, &status);
>> -		if (err)
>> -			return false;
>> -		if (!(status & RENESAS_ROM_STATUS_RELOAD))
>> -			break;
>> -
>> -		udelay(RENESAS_DELAY);
>> -	}
>> -	if (i == RENESAS_RETRY) {
>> -		dev_err(&pdev->dev, "ROM Exec timed out: %x\n", status);
>> -		return false;
>> -	}
>> -
>> -	return true;
>> -
>> -remove_bypass:
>> -	pci_write_config_byte(pdev, RENESAS_ROM_STATUS, 0);
>> -	return false;
>> -}
>> -
>>   static int renesas_load_fw(struct pci_dev *pdev, const struct firmware *fw)
>>   {
>>   	int err = 0;
>> -	bool rom;
>> -
>> -	/* Check if the device has external ROM */
>> -	rom = renesas_check_rom(pdev);
>> -	if (rom) {
>> -		/* perform chip erase first */
>> -		renesas_rom_erase(pdev);
>> -
>> -		/* lets try loading fw on ROM first */
>> -		rom = renesas_setup_rom(pdev, fw);
>> -		if (!rom) {
>> -			dev_dbg(&pdev->dev,
>> -				"ROM load failed, falling back on FW load\n");
>> -		} else {
>> -			dev_dbg(&pdev->dev,
>> -				"ROM load success\n");
>> -			goto exit;
>> -		}
>> -	}
>>   
>>   	err = renesas_fw_download(pdev, fw);
>> -
>> -exit:
>>   	if (err)
>>   		dev_err(&pdev->dev, "firmware failed to download (%d).", err);
>>   	return err;
>> -- 
>> 2.41.0
