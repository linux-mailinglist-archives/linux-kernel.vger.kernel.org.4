Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5741A74D4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGJLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:44:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A48AC4;
        Mon, 10 Jul 2023 04:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA6BD60FBD;
        Mon, 10 Jul 2023 11:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256CBC433C8;
        Mon, 10 Jul 2023 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688989469;
        bh=o1LGyiMiSOQEwQarMwvLLj/BJ1xUtrDcPUNJciAkFqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8704k+zd3ZP775T2wQbMQQdBn48H0kbYUxSje47l21G2u4w7VXGnRvoG1N7fEMEV
         G5x740RU9jMYZukY1NEHbqOqVCZSbptouYvrOo0fmdFMbmkWY9tIij3278M2FCKzk6
         ZYDlJL/KW318e1m2ZMiKqMDbjw0P3vpJeKPcw6vLFZNU7+EcwE2zVyGxYF8FggONRk
         WxG65J1qCt61IQ9IDRe3JP7py1M060Fnh0BLbUkyiSCoi7ymvNFx2D6nRE0BwWq0s1
         czwZEYCrUx+TRZIl5ggzX7cxLDeZbDXC7V523BVCXgtFzAqVJlX2TP2muF2osI5p4m
         JB99siiRGkDLw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qIpK3-0002D4-1X;
        Mon, 10 Jul 2023 13:44:55 +0200
Date:   Mon, 10 Jul 2023 13:44:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
Message-ID: <ZKvvN53dM5vbAFGi@hovoldconsulting.com>
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org>
 <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
 <ZKfyH4jRGlVlcLeY@hovoldconsulting.com>
 <CAMi1Hd2CGQKbMPm6GXfSHgrdHsyngBQ_DBseF08=oEvGdizVcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd2CGQKbMPm6GXfSHgrdHsyngBQ_DBseF08=oEvGdizVcw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:12:35PM +0530, Amit Pundir wrote:
> On Fri, 7 Jul 2023 at 16:37, Johan Hovold <johan@kernel.org> wrote:

> > That's odd. You should still see the above messages also with this patch
> > applied, but you may now need to provide a valid device address before
> > being able to use device in case the bootloader has not provided one
> > (e.g. using btmgmt).
> 
> Sorry for the confusion, I missed the part where I do see these
> messages when the kernel module is loaded but the direct firmware
> loading fails.
> 
> Bluetooth: hci0: setting up wcn399x
> Bluetooth: hci0: QCA Product ID   :0x0000000a
> Bluetooth: hci0: QCA SOC Version  :0x40010214
> Bluetooth: hci0: QCA ROM Version  :0x00000201
> Bluetooth: hci0: QCA Patch Version:0x00000001
> Bluetooth: hci0: QCA controller version 0x02140201
> Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> bluetooth hci0: Direct firmware load for qca/crbtfw21.tlv failed with error -2
> Bluetooth: hci0: QCA Failed to request file: qca/crbtfw21.tlv (-2)
> Bluetooth: hci0: QCA Failed to download patch (-2)
> Bluetooth: hci0: QCA preshutdown_cmd failed (-56)
> 
> This happens in all the cases (working and non-working BT) because
> filesystem is not mounted by that time. I'm running AOSP and all the
> kernel modules get loaded from a ramdisk. But in the working case, the
> firmware loading kicks in again later in the boot process and BT gets
> initiazed..
> 
> With this patch, after the first attempt to load the firmware fails,
> the firmware loading doesn't kick-in again. Also even if I keep the
> firmware in ramdisk then the direct firmware loading from ramdisk
> happens but BT still doesn't work
> https://bugs.linaro.org/attachment.cgi?id=1148.

So everything appears to work as intended. First, the firmware needs to
be in your initramfs if you want to avoid that initial fw load failure.

And after that you need to provide a valid device address as these
devices ship without one.

Once you set the address, the firmware should be loaded if it hasn't
been already.

> > Are there any error messages in the log when running with this patch?
> 
> I don't see any relevant error message in dmesg. I'll check if I can
> find a command line BT debug tool which I can use on AOSP for
> debugging. There used to be a few hci command line tools, when I
> looked into it a few years ago. Not sure if they are still around and
> useful.

Yeah, I'm not sure how you set the device address with the Android
stack, but there must be some way as there are other bluetooth
controllers out there which similarly need a valid address before they
can be used.

Johan
