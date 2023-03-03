Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11F36AA0F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCCVRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCCVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:17:17 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713F6150D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:17:07 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ky4so4134211plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 13:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677878227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhuLhnLZCviHLHyGIe9EHKicgCaiC5kWp2NCXRvwT4I=;
        b=nb/SD5Ls7IpbF/vQOkYudAu4gMlzu7iFxRTOsHX8uh5yXs77Dbfbd94UpWLyPcpKT5
         vmmOy5tH7iPwZuDw+v1Ae9TrWhs+zjtyHuC7kVSDl5maoaon2ZGg1hK0gIuh/XTwvK/0
         hYGn3id9j5kZFjEHqDII0oeLTTTmKfyCS+41r29/ApvkJc+nOSZxvoiikqd+6ia3LuRN
         otBAoDslznqT82OwXo9zIt6E7xoJsvV2QqJU930y5lOLYR1XvPX+kGLL/YprGF/coZPs
         weG5Y7kYSDvHG2VFRgh2FofaakQoo3tAhKsreGHDjv3UtQwsD3EP1OVhxk5SNUCaMIsi
         FP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677878227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhuLhnLZCviHLHyGIe9EHKicgCaiC5kWp2NCXRvwT4I=;
        b=siFz7DUffDg9DlYpbyv/WNxR2KkIFWpdSc6+U3QzG8fo71OPkQdUULBtXemOalhsln
         RyQ34RB5yQn/f0yKFMI/QBnhTVL3qOmIV6V1hNjKdnHN1G6KVL0d39qNPsrpMbdh6w0C
         /KHDzT5uqjOoMOgpmcz0l5e1dbjOc9HjrXyXoYih1bSRAvwEOqpDFsPACYWvxGm0kKqh
         YzLvO6Hh8uYFw+d5xVe172TZEjvvHP/qqWR6Ji54rsZrZwnWaF5NokB8h2+qkf2cpyPC
         9sRyzzSDQ2iPN44Kma6lGAt0xrIQhtnAOX28UBWpqLfJbSa0d9rJg7ZA8M3b7xLkZkrY
         LFMw==
X-Gm-Message-State: AO0yUKW4I/lES2h3DRtPPDXFSZGDkg2uA18UuTGLDHSptUaUclHPGda0
        laxfUHBYTFpwoFCctwh2Fb7155dnJ7Gf3j5UJGX+Sg==
X-Google-Smtp-Source: AK7set+32LcKQp112YY6MZ6fMJypwdkQArStXiZgdTOdsG7SWiCMXSTE0LjhEFcXm2TYDtRE+daKrHb6aq/srLIW1gI=
X-Received: by 2002:a17:903:41c9:b0:19e:2a1b:2797 with SMTP id
 u9-20020a17090341c900b0019e2a1b2797mr1324176ple.10.1677878226573; Fri, 03 Mar
 2023 13:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20230302023509.319903-1-saravanak@google.com> <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
 <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com> <98f5abe2-3d25-661a-a2b8-a50e2d27f085@i2se.com>
 <667f007f-1cb0-7e89-242a-c41823e82bee@gmail.com>
In-Reply-To: <667f007f-1cb0-7e89-242a-c41823e82bee@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 3 Mar 2023 13:16:30 -0800
Message-ID: <CAGETcx9UdOWT+ZnoydcXXqcS-sQ_i0FosWGr4ZTfRmRjA_FVcA@mail.gmail.com>
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 9:22=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.c=
om> wrote:
>
> On 3/3/23 03:57, Stefan Wahren wrote:
> > Hi,
> >
> > Am 02.03.23 um 18:51 schrieb Florian Fainelli:
> >>
> >>
> >> On 3/2/2023 9:20 AM, Saravana Kannan wrote:
> >>> On Thu, Mar 2, 2023 at 9:01=E2=80=AFAM Stefan Wahren <stefan.wahren@i=
2se.com>
> >>> wrote:
> >>>>
> >>>> Hi Saravana,
> >>>>
> >>>> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
> >>>>> This allow fw_devlink to do dependency tracking for serdev devices.
> >>>>>
> >>>>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>>> Link:
> >>>>> https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@g=
mail.com/
> >>>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> >>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>>>
> >>>> since this fixes an issue on Raspberry Pi 4, shouldn't this be
> >>>> mentioned
> >>>> in the commit message and providing a Fixes tag?
> >>>
> >>> So RPi 4 was never creating a device links between serdev devices and
> >>> their consumers. The error message was just a new one I added and we
> >>> are noticing and catching the fact that serdev wasn't setting fwnode
> >>> for a device.
> >>>
> >>> I'm also not sure if I can say this commit "Fixes" an issue in serdev
> >>> core because when serdev core was written, fw_devlink wasn't a thing.
> >>> Once I add Fixes, people will start pulling this into stable
> >>> branches/other trees where I don't think this should be pulled into
> >>> older stable branches.
> >>
> >> That is kind of the point of Fixes: tag, is not it? It is appropriate
> >> to list a commit that is not specific to serdev, but maybe a
> >> particular point into the fw_devlink history. Given this did not
> >> appear to have a functional impact, we could go without one.
> >
> > i was under the impression that this issue breaks at least Bluetooth on
> > Raspberry Pi 4 because the driver is never probed. I cannot see the
> > success output in Florian's trace. Something like this:
> >
> > [    7.124879] hci_uart_bcm serial0-0: supply vbat not found, using
> > dummy regulator
> > [    7.131743] hci_uart_bcm serial0-0: supply vddio not found, using
> > dummy regulator
> > ...
> > [    7.517249] Bluetooth: hci0: BCM: chip id 107
> > [    7.517499] Bluetooth: hci0: BCM: features 0x2f
> > [    7.519757] Bluetooth: hci0: BCM4345C0
> > [    7.519768] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
> > [    7.539495] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
> > ...
> > [    8.348831] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
> > [    8.348845] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
> >
> > I just want to make sure that 6.2 doesn't have a regression.
>
> My configuration uses hci_uart as a module, and it would always load
> fine, but I suppose I can make sure that even built-in this works
> properly. Give me a day or two to test that.

Thanks Stefan and Florian! I'll wait to see the results.

But based on my mental model of fw_devlink I don't expect BT to be
broken without this patch. If a device doesn't have fwnode set, it's
effectively invisible to fw_devlink. That could only affect consumers
of the device and not the device itself.

-Saravana
