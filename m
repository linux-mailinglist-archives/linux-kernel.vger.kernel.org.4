Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8815B765D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiIMQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiIMQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:21:27 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917EA7224
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:16:29 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id s206so11627773pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=apQyGVVYmMnakIx4POqdO6HmfUSdw5uPwT9P4cF9O+I=;
        b=u302Hesvj18rnvKu7rDrjBIYxwHyWn3vb+sP1lkMij9Ch+P3F1PK3fv96t6cWArJXK
         MM7pojYDDFw0p11nQv5wlXKey+kNHl6LOWo4Bg/DMBP+UeDXnfSPpkWv6l7azHrsH2TA
         c+Dm/pn1nlx8gHJGHBQk9BbW0rrzbo/F4nZyETMuPE+3aJid0Rz1UW3pb/s/IAcPCaYl
         QQ5NiOY4Rr3I20WrarCTfqggUTVDNPY2qsg6kdJX26E3/3kDUvn9HhROyGIagFNm6xO7
         lTnDSBiDw3/PKgT35TzqcTxuafluqkZI8NcoLXHmTpqEfEqFfJ3q3tGWF9LKDBY9U/iL
         XPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=apQyGVVYmMnakIx4POqdO6HmfUSdw5uPwT9P4cF9O+I=;
        b=ZlRb6N4rd8r7rUJE/CN7PcYyvpV+MdQnEDvkh/8SSzXlS+LtF+bjn7ByM1E04ctWHK
         VattMsdef6UtcFL4NwFflafDBIlAl+HdTWLwft9E1VwLzJ3azxblvwua/ekVkJSFOTPG
         Ng3sJvnhZbvxzv8H+hdIHk2S8u+3BM0O0sR7L777Xjvv2rUjpqWRzGyBfGWNwKE6l4kf
         WJOh2VUSUuJtDVbEJmNNDkV+akSOm2RNrycOyr/n518IIKOwOtmj/9BIN5E8EFj/0Nmq
         c5bv4pJTUbLfb95hMGLVFiegPhRmSiEWeNpNZvN3ictO+a5gi28WK6mO1R7OL1kbToDq
         qZXA==
X-Gm-Message-State: ACgBeo18FZpXhZ9ZDmN5RX/mI4Ci0EW4f1HVCz9KrNfD7jXohjN4H4GT
        6qodyCF3TJOBHuvw35U8tQoyeg==
X-Google-Smtp-Source: AA6agR4bUOjLr+vCoro7msgXVsjpE1P4y3YArKRnoq5JYsDzYhL3DMaoigANpWy1LWPxHR1AHtxPjA==
X-Received: by 2002:a05:6a00:2485:b0:52e:ca57:5018 with SMTP id c5-20020a056a00248500b0052eca575018mr33080481pfv.43.1663082043320;
        Tue, 13 Sep 2022 08:14:03 -0700 (PDT)
Received: from smtpclient.apple (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id l24-20020a63ea58000000b0042ba0a822cbsm7953882pgk.8.2022.09.13.08.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 08:14:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] pcmcia: synclink_cs: Fix use-after-free in mgslpc_ioctl()
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
Date:   Tue, 13 Sep 2022 08:14:01 -0700
Cc:     Hyunwoo Kim <imv4bel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BBF8723-AF48-4380-B05B-CB3B552322BD@microgate.com>
References: <20220913052020.GA85241@ubuntu>
 <a8a9fd74-4ee5-4619-8492-be7139e6d48e@www.fastmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been out of production for almost 20 years. It was never a =
large seller. I do not have the hardware. The chance of one still being =
in operation someplace is close to zero.

The best solution is to remove this driver from the kernel. Two other =
obsolete SyncLink drivers were removed a year ago. This would be a good =
opportunity to remove synclink_cs.c (PCMCIA)

The current SyncLink driver is synclink_gt.c (PCI/PCIe hardware), which =
is still sold and supported.


> On Sep 13, 2022, at 7:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> On Tue, Sep 13, 2022, at 7:20 AM, Hyunwoo Kim wrote:
>> A race condition may occur if the user physically removes
>> the pcmcia device while calling ioctl() for this tty device node.
>>=20
>> This is a race condition between the mgslpc_ioctl() function and
>> the mgslpc_detach() function, which may eventually result in UAF.
>>=20
>> So, add a refcount check to mgslpc_detach() to free the structure
>> after the tty device node is close()d.
>>=20
>> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
>=20
> I think both your analysis and your patch are correct.
>=20
> You might want to spell out use-after-free in the changelog
> text, especially if you have a tool that finds more of these.
>=20
>> I think I've probably found a race-condition-to-UAF vulnerability in
>> drivers/char/pcmcia/synclink_cs.c.
>> However, this device driver is a pcmcia_driver based driver.
>> I haven't been able to get this old pcmcia adapter/device.
>>=20
>> If you don't mind, I'd like to ask the Linux kernel community to test =
if
>> this vulnerability actually triggers.
>=20
> Adding Paul Fulghum as the original driver author and Dominik
> Brodowski as the PCMCIA maintainer to Cc, if anyone still has
> the hardware, it would be one of them.
> https://lore.kernel.org/lkml/20220913052020.GA85241@ubuntu/
> has the full email for reference.
>=20
> Even if nobody has the hardware, we could just apply the patch
> anyway. Alternatively, we could take a pass at removing most
> of the pcmcia_driver instances from the kernel including this
> one. Dominik has previously brought up phasing out the
> 16-bit PCMCIA support altogether at some point, and we may
> as well start by removing the ones that have no apparent users
> any more, at least that might avoid spending much time on
> fixing bugs that nobody cares about.
>=20
> I'm fairly sure the embedded users mostly care about CF storage
> cards, which is the one driver that definitely has to stay.
> Most other pcmcia drivers predate the git history, though there
> are a few that were only added in the past decade, these would
> be the most likely to still be in use:
>=20
> v5.2-rc1-82-g8674a8aa2c39 scsi: fdomain: Add PCMCIA support
> v4.9-rc3-54-gf2ed287bcc90 char/pcmcia: add scr24x_cs chip card =
interface driver
> v3.3-rc5-882-g2b61972b7421 can: sja1000: add support for PEAK-System =
PCMCIA card
> v3.1-rc7-1048-gfd734c6f25ae can/sja1000: add driver for EMS PCMCIA =
card
> v2.6.37-3908-g0a0b7a5f7a04 can: add driver for Softing card
>=20
>   Arnd

