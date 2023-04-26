Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8996EF3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbjDZMC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbjDZMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:02:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F359E8;
        Wed, 26 Apr 2023 05:02:15 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 717F81C0004;
        Wed, 26 Apr 2023 12:02:12 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenz Brun <lorenz@brun.one>
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix USB regulator on ROCK64
Date:   Wed, 26 Apr 2023 14:02:02 +0200
Message-ID: <6383328.LvFx2qVVIh@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20230421213841.3079632-1-lorenz@brun.one>
References: <20230421213841.3079632-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4185305.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4185305.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Wed, 26 Apr 2023 14:02:02 +0200
Message-ID: <6383328.LvFx2qVVIh@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20230421213841.3079632-1-lorenz@brun.one>
References: <20230421213841.3079632-1-lorenz@brun.one>
MIME-Version: 1.0

On Friday, 21 April 2023 23:38:41 CEST Lorenz Brun wrote:
> rockchip-pinctrl pinctrl: pin gpio0-2 already requested by vcc-host-5v-regulator; cannot claim for vcc-host1-5v-regulator
> rockchip-pinctrl pinctrl: pin-2 (vcc-host1-5v-regulator) status -22
> rockchip-pinctrl pinctrl: could not request pin 2 (gpio0-2) from group usb20-host-drv  on device rockchip-pinctrl 
> reg-fixed-voltage vcc-host1-5v-regulator: Error applying setting, reverse things back

I booted the Debian 6.1.0-8-arm64 kernel (6.1.25-1) on my Rock64 and then
booted that kernel with this patch applied (6.1.25-2) and this is the result:

diederik@rock64-dev:~$ uname -a
Linux rock64-dev 6.1.0-8-arm64 #1 SMP Debian 6.1.25-1 (2023-04-22) aarch64 GNU/Linux
diederik@rock64-dev:~$ su -l
Password: 
root@rock64-dev:~# dmesg --level emerg,alert,crit,err
[    7.296781] rockchip-pinctrl pinctrl: pin gpio0-2 already requested by vcc-host-5v-regulator; cannot claim for vcc-host1-5v-regulator
[    7.298007] rockchip-pinctrl pinctrl: pin-2 (vcc-host1-5v-regulator) status -22
[    7.298694] rockchip-pinctrl pinctrl: could not request pin 2 (gpio0-2) from group usb20-host-drv  on device rockchip-pinctrl
[    7.299736] reg-fixed-voltage vcc-host1-5v-regulator: Error applying setting, reverse things back
[    7.525107] rk_gmac-dwmac ff540000.ethernet: cannot get clock clk_mac_speed

root@rock64-dev:~# dmesg --level emerg,alert,crit,err,warn
[    5.295285] dw-apb-uart ff130000.serial: forbid DMA for kernel console
[    7.296781] rockchip-pinctrl pinctrl: pin gpio0-2 already requested by vcc-host-5v-regulator; cannot claim for vcc-host1-5v-regulator
[    7.298007] rockchip-pinctrl pinctrl: pin-2 (vcc-host1-5v-regulator) status -22
[    7.298694] rockchip-pinctrl pinctrl: could not request pin 2 (gpio0-2) from group usb20-host-drv  on device rockchip-pinctrl
[    7.299736] reg-fixed-voltage vcc-host1-5v-regulator: Error applying setting, reverse things back
[    7.312492] dwc2 ff580000.usb: supply vusb_d not found, using dummy regulator
[    7.313483] dwc2 ff580000.usb: supply vusb_a not found, using dummy regulator
[    7.525107] rk_gmac-dwmac ff540000.ethernet: cannot get clock clk_mac_speed
[   12.299438] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[   13.244268] systemd-journald[228]: File /var/log/journal/511b5fcdb7574d1f8604d582cf5c5b00/system.journal corrupted or uncleanly shut down, renaming and replacing.
[   16.537752] dw_wdt ff1a0000.watchdog: No valid TOPs array specified
[   16.615515] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
[   16.616532] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
[   17.177743] rockchip_vdec: module is from the staging directory, the quality is unknown, you have been warned.

root@rock64-dev:~# apt install /home/diederik/linux-image-6.1.0-8-rock64-regulator-arm64-unsigned_6.1.25-2_arm64.deb 
...
The following NEW packages will be installed:
  linux-image-6.1.0-8-rock64-regulator-arm64-unsigned
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 0 B/63.4 MB of archives.
After this operation, 455 MB of additional disk space will be used.
Get:1 /home/diederik/linux-image-6.1.0-8-rock64-regulator-arm64-unsigned_6.1.25-2_arm64.deb linux-image-6.1.0-8-rock64-regulator-arm64-unsigned arm64 6.1.25-2 [63.4 MB]
Selecting previously unselected package linux-image-6.1.0-8-rock64-regulator-arm64-unsigned.
...
/etc/kernel/postinst.d/zz-update-grub:
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-6.1.0-8-rock64-regulator-arm64
Found initrd image: /boot/initrd.img-6.1.0-8-rock64-regulator-arm64
Found linux image: /boot/vmlinuz-6.1.0-8-arm64
Found initrd image: /boot/initrd.img-6.1.0-8-arm64
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done
N: Download is performed unsandboxed as root as file '/home/diederik/linux-image-6.1.0-8-rock64-regulator-arm64-unsigned_6.1.25-2_arm64.deb' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)
root@rock64-dev:~# reboot
root@rock64-dev:~# Connection to rock64-dev closed by remote host.
Connection to rock64-dev closed.

diederik@bagend:~$ ssh rock64-dev
diederik@rock64-dev:~$ uname -a
Linux rock64-dev 6.1.0-8-rock64-regulator-arm64 #1 SMP Debian 6.1.25-2 (2023-04-25) aarch64 GNU/Linux
diederik@rock64-dev:~$ su -l
Password: 
root@rock64-dev:~# dmesg --level emerg,alert,crit,err
[    7.134332] rk_gmac-dwmac ff540000.ethernet: cannot get clock clk_mac_speed

root@rock64-dev:~# dmesg --level emerg,alert,crit,err,warn
[    5.128440] dw-apb-uart ff130000.serial: forbid DMA for kernel console
[    6.925949] dwc2 ff580000.usb: supply vusb_d not found, using dummy regulator
[    6.926983] dwc2 ff580000.usb: supply vusb_a not found, using dummy regulator
[    7.134332] rk_gmac-dwmac ff540000.ethernet: cannot get clock clk_mac_speed
[   11.465583] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[   12.358406] systemd-journald[231]: File /var/log/journal/511b5fcdb7574d1f8604d582cf5c5b00/system.journal corrupted or uncleanly shut down, renaming and replacing.
[   14.865704] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
[   14.866899] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
[   14.882228] dw_wdt ff1a0000.watchdog: No valid TOPs array specified
[   15.355843] rockchip_vdec: module is from the staging directory, the quality is unknown, you have been warned.

Everything seems to be working fine, but now with less errors in dmesg, so:

Tested-by: Diederik de Haas <didi.debian@cknow.org>
--nextPart4185305.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZEkSugAKCRDXblvOeH7b
bqIrAP4g0sF8YmpOc5gFU3UGtEN2TiUB1qPy2i9uOVU0tj5TqQEAv/Q1kbks7CFL
5CEN/daLxMPuPCOLTXxIweglZn9PzwA=
=HvZt
-----END PGP SIGNATURE-----

--nextPart4185305.ElGaqSPkdT--



