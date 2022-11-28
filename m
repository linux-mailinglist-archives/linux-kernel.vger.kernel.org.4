Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4163AE99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiK1RLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiK1RLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:11:11 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B2C267E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:11:09 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z3so8073113iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWFgfn7sl4yRxD6csRHBAYHMq81sRHzc2nkScUHiHKo=;
        b=WTIMKifgTx7fIvYm6ryFKZeDz9eDqd4eUILvbSnXYv+qBvhCFbDN5WIzqgN1Ig0gGY
         FrFkCuK9k61a2Ut7hudNt5CNn1qoMrE66Ggs+sQKYD+Ma3hrUQ1txkEz412JaNxnHrrH
         wGZLhEyAK5D9hklt2yjpqybl2BxHqGdAqSVII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWFgfn7sl4yRxD6csRHBAYHMq81sRHzc2nkScUHiHKo=;
        b=feyRGqemSGeG9LtwyXVcDvGikBIotpU3u1/YTx5oWXcSwwNTKyryDtopOQoqywjtvT
         VfZFkvYnfQxPotSiORqwaUZ18SAELcxDrMAt7uuIJOb//f9hHPhzNc+8Y9UwkOLmwf9V
         pR3NdOtmw1sCkXy7T8NAIMfsm44lNBzxRNuC9ltwwBo9w+38CshnTMEKSKhPbo7CeE7W
         Rke4ysRqJdkYd5lrGXBc+o5T9cI2TobxG1GwA6x7h03iqjDpDzlYD8fUvv0Wajqs6mtN
         QKm2KfyWq3zKJKrLirbWTVmNzs0Ur9gW/fariDLoHg8PxUzpn6VtayMzhJHJ7TJ6LzU5
         jtMA==
X-Gm-Message-State: ANoB5pkf3QewulG0c9Ll36s44c+klG4YehLPrp+K17lfrYbHRJmNbEBa
        plBYAppOcdIzfxsD+z0AVzn0rdQ/ZLPjdNRW
X-Google-Smtp-Source: AA0mqf5m+pFeM//zi06j3rWRH6GhgtJoRzOfuNXwfb75EqUnYXShR7aFggMC1zgOU3RpRH9cRVIVYA==
X-Received: by 2002:a02:bb1a:0:b0:386:e9ed:202d with SMTP id y26-20020a02bb1a000000b00386e9ed202dmr13103848jan.269.1669655468638;
        Mon, 28 Nov 2022 09:11:08 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id q16-20020a02b050000000b00379cc6aba93sm2222118jah.34.2022.11.28.09.10.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:10:59 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id g7so5346691ile.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:10:53 -0800 (PST)
X-Received: by 2002:a05:6e02:66d:b0:303:1196:96c7 with SMTP id
 l13-20020a056e02066d00b00303119696c7mr2904256ilt.133.1669655452584; Mon, 28
 Nov 2022 09:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v5-0-4ededeb08ba0@chromium.org> <alpine.DEB.2.22.394.2211281629120.3532114@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2211281629120.3532114@eliteleevi.tm.intel.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 18:10:41 +0100
X-Gmail-Original-Message-ID: <CANiDSCtd52UX1WQDj4PLTuTogurr63ZdMXVWmYqJHCMo_kEoMQ@mail.gmail.com>
Message-ID: <CANiDSCtd52UX1WQDj4PLTuTogurr63ZdMXVWmYqJHCMo_kEoMQ@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kay

Thanks for your review

On Mon, 28 Nov 2022 at 15:41, Kai Vehmanen <kai.vehmanen@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, 28 Nov 2022, Ricardo Ribalda wrote:
>
> > During kexec(), the userspace is frozen. Therefore we cannot wait for it
> > to complete.
> >
> > Avoid running snd_sof_machine_unregister during shutdown.
> [...]
> >       /*
> > -      * make sure clients and machine driver(s) are unregistered to force
> > -      * all userspace devices to be closed prior to the DSP shutdown sequence
> > +      * make sure clients are unregistered prior to the DSP shutdown
> > +      * sequence.
> >        */
> >       sof_unregister_clients(sdev);
> >
> > -     snd_sof_machine_unregister(sdev, pdata);
> > -
> >       if (sdev->fw_state == SOF_FW_BOOT_COMPLETE)
>
> this is problematic as removing that machine_unregister() call will (at
> least) bring back an issue on Intel platforms (rare problem hitting S5 on
> Chromebooks).

Do you know which devices were affected or how to trigger the issue?

I have access to the ChromeOS lab, so I can test on a big variety of devices

Thanks!


>
> Not sure how to solve this, but if that call needs to be removed
> (unsafe to call at shutdown), then we need to rework how SOF
> does the cleanup.
>
> Br, Kai



-- 
Ricardo Ribalda
