Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFEA74D54A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGJMXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGJMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:23:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992BB1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:23:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c6833e6e326so5405645276.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688991812; x=1691583812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D5wpUGcoCMLJktVtdk3pDx8grpN6B5CCP4ofqZN22Ns=;
        b=ocuAjur8c/g9aUvJT2WR3TfZAzQu4EnTUMo6UB4meKF3y4D2+ka8nTVf/Vhb60o4hr
         WwXb78+52KfjNDzUyweIoufpkr/Er+ng7kY/r4h05JkVxgCsya6DQRp4eRW307L/4/rW
         wrJCv2Tdl3iVrIqR6SgqgOA5aW5UZI3hjCT516SMj4/PqL2st3hc7ZwZgW7gMGXrG/pv
         T1NkTZpXq6BkOa9Q4IjsY1ReLnGy0NsuZnH7N8nEBpbYH6i/fkNiSvkERtIQlrs7naTx
         TsTQNXBzKS5dfnmrXmhWgmfED08ndpUUawf7HCVOVAyqdWPrFw7Qi6QXsVYiNK8ulRJL
         Rv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991812; x=1691583812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5wpUGcoCMLJktVtdk3pDx8grpN6B5CCP4ofqZN22Ns=;
        b=baDP5RXhGckSYWM/Jem284szm6siDzu3s3TS844ujsWZNwSY8LxVeaF9lJfLSB4oIi
         bvHRRimCHQY6Dv3sgsT5yYh6yzCSYmKdbiTXFuzaYgYT68PAthcKaGACWuN6MfS8YcyY
         7mXFmJKICbsaRZZjcWddREv/Wu3IoSSBVy+pfs3kg+OqRS9s1DjKken5NpYrPmvt0GMK
         tzDDZKsNS1H/E2074GnRNDZZpGSr1LDpQnMSmbKF/ao+2QbLSsHkefiDRsKMBH/pN9oS
         B9L35iPZJCZA+5mi2l11AR+6FlCqyN3WYc8wz4wcpvHxQ6Rbr7JzvCPR5m/i0dOK/aYt
         EidA==
X-Gm-Message-State: ABy/qLYR+x9lRhMqJXXOiWpaGv2VKyIxFoph18BIBYAo5inr01dp+OL7
        05RptDkqcSIDiJOhMxsQW0Ue1GAwekARAOz1DAq1TQ==
X-Google-Smtp-Source: APBJJlHupZJB9Sam/r2Z4m1rFw/1XEugNXZQqU3G9JkRqCdzFkoSQ+aCNbEcwdZgIfayhMA1sxapEfL1iViYtUhPMwA=
X-Received: by 2002:a81:5354:0:b0:576:de5d:164e with SMTP id
 h81-20020a815354000000b00576de5d164emr13041207ywb.23.1688991811684; Mon, 10
 Jul 2023 05:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org> <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
 <ZKfyH4jRGlVlcLeY@hovoldconsulting.com> <CAMi1Hd2CGQKbMPm6GXfSHgrdHsyngBQ_DBseF08=oEvGdizVcw@mail.gmail.com>
 <ZKvvN53dM5vbAFGi@hovoldconsulting.com>
In-Reply-To: <ZKvvN53dM5vbAFGi@hovoldconsulting.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 10 Jul 2023 17:52:55 +0530
Message-ID: <CAMi1Hd3-iiNYfSyrvXpsjEFQ+_PzR_WJPoDEbcnAvH+Q1O_Pmw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 17:14, Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Jul 07, 2023 at 07:12:35PM +0530, Amit Pundir wrote:
> > On Fri, 7 Jul 2023 at 16:37, Johan Hovold <johan@kernel.org> wrote:
>
> > > That's odd. You should still see the above messages also with this patch
> > > applied, but you may now need to provide a valid device address before
> > > being able to use device in case the bootloader has not provided one
> > > (e.g. using btmgmt).
> >
> > Sorry for the confusion, I missed the part where I do see these
> > messages when the kernel module is loaded but the direct firmware
> > loading fails.
> >
> > Bluetooth: hci0: setting up wcn399x
> > Bluetooth: hci0: QCA Product ID   :0x0000000a
> > Bluetooth: hci0: QCA SOC Version  :0x40010214
> > Bluetooth: hci0: QCA ROM Version  :0x00000201
> > Bluetooth: hci0: QCA Patch Version:0x00000001
> > Bluetooth: hci0: QCA controller version 0x02140201
> > Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> > bluetooth hci0: Direct firmware load for qca/crbtfw21.tlv failed with error -2
> > Bluetooth: hci0: QCA Failed to request file: qca/crbtfw21.tlv (-2)
> > Bluetooth: hci0: QCA Failed to download patch (-2)
> > Bluetooth: hci0: QCA preshutdown_cmd failed (-56)
> >
> > This happens in all the cases (working and non-working BT) because
> > filesystem is not mounted by that time. I'm running AOSP and all the
> > kernel modules get loaded from a ramdisk. But in the working case, the
> > firmware loading kicks in again later in the boot process and BT gets
> > initiazed..
> >
> > With this patch, after the first attempt to load the firmware fails,
> > the firmware loading doesn't kick-in again. Also even if I keep the
> > firmware in ramdisk then the direct firmware loading from ramdisk
> > happens but BT still doesn't work
> > https://bugs.linaro.org/attachment.cgi?id=1148.
>
> So everything appears to work as intended. First, the firmware needs to
> be in your initramfs if you want to avoid that initial fw load failure.
>
> And after that you need to provide a valid device address as these
> devices ship without one.
>
> Once you set the address, the firmware should be loaded if it hasn't
> been already.

Thanks a lot for explanation Johan. I just booted up Debian on DB845c
and btmgmt works as you pointed out above.

root@linaro-gnome:~#
root@linaro-gnome:~# uname -a
Linux linaro-gnome 6.5.0-rc1 #1 SMP PREEMPT Mon Jul 10 15:42:50 IST
2023 aarch64 GNU/Linux
root@linaro-gnome:~#
root@linaro-gnome:~# btmgmt public-addr 01:02:03:04:05:06
[  165.708146] Bluetooth: MGMT ver 1.22
hci0 Set Public Address complete, options:
[  165.715275] Bluetooth: hci0: setting up wcn399x
root@linaro-gnome:~# [  165.868755] Bluetooth: hci0: QCA Product ID
:0x0000000a
[  165.874272] Bluetooth: hci0: QCA SOC Version  :0x40010214
[  165.879758] Bluetooth: hci0: QCA ROM Version  :0x00000201
[  165.885226] Bluetooth: hci0: QCA Patch Version:0x00000001
[  165.903506] Bluetooth: hci0: QCA controller version 0x02140201
[  165.909424] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[  166.794992] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[  166.870882] Bluetooth: hci0: QCA setup on UART is completed

>
> > > Are there any error messages in the log when running with this patch?
> >
> > I don't see any relevant error message in dmesg. I'll check if I can
> > find a command line BT debug tool which I can use on AOSP for
> > debugging. There used to be a few hci command line tools, when I
> > looked into it a few years ago. Not sure if they are still around and
> > useful.
>
> Yeah, I'm not sure how you set the device address with the Android
> stack, but there must be some way as there are other bluetooth
> controllers out there which similarly need a valid address before they
> can be used.
>

I'll look if I can reuse/simplify "btmgmt public-addr" command on
Android or find an equivalent tool to do that.

Regards,
Amit Pundir
