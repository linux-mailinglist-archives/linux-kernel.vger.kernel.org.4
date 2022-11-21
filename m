Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985576329B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKUQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiKUQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:36:35 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7FBC723C;
        Mon, 21 Nov 2022 08:36:18 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id j26so1229044qki.10;
        Mon, 21 Nov 2022 08:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipqo4h/cA5o5Pcu6O6H/mTx1mJVmCerOGJjrJckS4tE=;
        b=qNt+V5k0iCdLwb6ZUx633e1xf+T6VSyu+q0yakf7H1lMS2lNqc48F8xb+xGxheMuOE
         XjIGPQWQxHqUAzVSQhz+3ck8IZK+DsTz+OiWgZjYAmuXzJ46WLwlU3oECZfkaieIJkO1
         uIyvZ14LgkbF3z5elvTIf01L33Z4cTQaHM2NDvscpi1UfeIBV+Wh95E8LHBa2Qa9cJ6q
         /HoHQl6WFuQNC0OeGelTDzsXU7nW28xTuNGE5NOanygpsC4m5QyRnI38I56dhwvV0uKX
         HbqjWD5zpab+Qp1B8NGDR1RRs+Q0nYHGsp9c/otznwSJ8cT/yDN9p+g4YBsHxe34ppum
         YUZA==
X-Gm-Message-State: ANoB5pkOimqcU2Wcu+K9kiE/ytyqWJJ/d/HumdUHWyqTvLwjERaYdftc
        1cZDMQtabWklcnf7m+h0pQEbzN5y6faWBw==
X-Google-Smtp-Source: AA0mqf5RfNxRVXSKv9JpMmQgrf5F5oNBtnRkVJgswfohNNrH+tNwmhB6Qqt9TPuLCwHW20EmcOd+hg==
X-Received: by 2002:a05:620a:6017:b0:6fa:86cf:22a7 with SMTP id dw23-20020a05620a601700b006fa86cf22a7mr1946113qkb.525.1669048577102;
        Mon, 21 Nov 2022 08:36:17 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006eee3a09ff3sm8515474qkp.69.2022.11.21.08.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 08:36:16 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3691e040abaso118595127b3.9;
        Mon, 21 Nov 2022 08:36:16 -0800 (PST)
X-Received: by 2002:a0d:fec2:0:b0:36b:56d3:71b8 with SMTP id
 o185-20020a0dfec2000000b0036b56d371b8mr17585171ywf.384.1669048575865; Mon, 21
 Nov 2022 08:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com> <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org> <20221115150417.513955a7@bootlin.com>
 <20221118112349.7f09eefb@bootlin.com> <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com> <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
In-Reply-To: <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 17:36:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
Message-ID: <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Nov 21, 2022 at 5:33 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 21/11/2022 16:59, Herve Codina wrote:
> > On Mon, 21 Nov 2022 12:43:16 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >> On 18/11/2022 11:23, Herve Codina wrote:
> >>> On Tue, 15 Nov 2022 15:04:17 +0100
> >>> Herve Codina <herve.codina@bootlin.com> wrote:
> >>>> On Tue, 15 Nov 2022 14:07:52 +0100
> >>>>> On 15/11/2022 14:05, Krzysztof Kozlowski wrote:
> >>>>>> On 14/11/2022 12:15, Herve Codina wrote:
> >>>>>>> Add the h2mode property to force the USBs mode ie:
> >>>>>>>  - 2 hosts
> >>>>>>> or
> >>>>>>>  - 1 host and 1 device
> >>>>>>>
> >>>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>>>>>> ---
> >>>>>>>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++++++
> >>>>>>>  1 file changed, 10 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> >>>>>>> index 95bf485c6cec..f9e0a58aa4fb 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> >>>>>>> @@ -39,6 +39,16 @@ properties:
> >>>>>>>    '#power-domain-cells':
> >>>>>>>      const: 0
> >>>>>>>
> >>>>>>> +  renesas,h2mode:
> >>>>>>> +    description: |
> >>>>>>> +      Configure the USBs mode.
> >>>>>>> +        - <0> : the USBs are in 1 host and 1 device mode.
> >>>>>>> +        - <1> : the USBs are in 2 host mode.
> >>>>>>> +      If the property is not present, the value used is the one already present
> >>>>>>> +      in the CFG_USB register (from reset or set by the bootloader).
> >>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>>>> +    enum: [0, 1]
> >>>>>>
> >>>>>> 0/1 are quite cryptic. Why not making it a string which is easy to read
> >>>>>> and understand? Can be something like "two-hosts" and "one-host". Or
> >>>>>> anything you find more readable...
> >>>>>
> >>>>> ...but actually you should rather make it a property of your USB
> >>>>> controller, not clock controller. You have two controllers and we have a
> >>>>> generic property for them - dr_mode.
> >>>>>
> >>>>> Best regards,
> >>>>> Krzysztof
> >>>>>
> >>>>
> >>>> IMHO, this property in the USB controllers does not make sense.
> >>>> Indeed each controller cannot have a different 'mode'.
> >>>> Some controllers are USB host only (EHCI and OHCI) and the USBF
> >>>> controller I worked on is device only.
> >>>> 'h2mode' allows to choose between host or device on one of the USB
> >>>> but not at the USB controller level.
> >>>>
> >>>> This property should be handle outside the USB controller nodes.
> >>>>
> >>>> Currently, this node (declared as a clock node) is in fact a sysctrl
> >>>> node and can do some configuration not related to clocks.
> >>>>
> >>>> I agree with you something related to choosing USB Host/Device in
> >>>> a clock node seems strange.
> >>>>
> >>>> Some discussion were already opened related to this property and how
> >>>> to handle it:
> >>>>   https://lore.kernel.org/all/20221107182642.05a09f2f@bootlin.com/
> >>>>   https://lore.kernel.org/all/20221107173614.474707d7@bootlin.com/
> >>>>
> >>>
> >>> We advanced on this topic.
> >>>
> >>> First, even if 'renesas,r9a06g032-sysctrl.yaml' is present in
> >>> the devicetree/bindings/clock/ directory, this node is really
> >>> a 'system controller' node:
> >>> - title: Renesas RZ/N1D (R9A06G032) System Controller
> >>> - compatible: renesas,r9a06g032-sysctrl
> >>>
> >>> It handles clocks, power domains, some DMA routing, ...
> >>>
> >>> Now, the property 'h2mode' allows to choose between:
> >>>   - 2 USB hosts
> >>> or
> >>>   - 1 USB host and 1 USB device.
> >>>
> >>> This switching is system wide and has no reason to be done in
> >>> one specific USB controller. It can impact multiple devices and
> >>> PLL settings.
> >>>
> >>> The 'renesas,r9a06g032-sysctrl' node, as the system control
> >>> node of our system, is the best candidate to handle the property.
> >>
> >> Not necessarily. IIUC, you have:
> >>
> >> 1. sysctrl with some register(s) for choosing device mode
> >> 2. usb device or host at one address
> >> 3. usb host at separate address
> >>
> >
> > Just to clarify, usb device and host controller are not provided by
> > the same IP.
> > We have an USB host at some address range (PCI OHCI/EHCI USB host
> > below a PCI bridge) and the USB device at some other address range
> > (below a AHB to someting bridge).
> > And I am not sure that only USB host or devices are affected by this
> > property change.
> >
> >> If so then:
> >> A. Pretty often we have wrapper nodes for this purpose (USB, phy
> >> wrappers or glues) which are usually needed to configure something for a
> >> generic block (like Synopsys etc).
> >>
> >> B. Pretty often the device (so your USB host or device) needs to poke
> >> something in system controller registers, e.g. for power or some other
> >> setup.
> >
> > And we did it for some items (clocks and power).
> >
> >>
> >> Your case looks a lot like (B). We have many, many of such examples
> >> already. Actually it is exactly like that, except that it affects
> >> possibility of another device (e.g. choosing USB device blocks having
> >> host there).
> >>
> >> C. It looks a bit like a multi-serial-protocol interfaces (so
> >> UART+I2C+SPI). The difference is that such cases have all these nodes
> >> defined as a children of the protocol-wrapping device. Not here.
> >>
> >> I would propose to go with (B) unless of course it's causes some crazy
> >> architecture/code choices. Why? Because with exception of (C) we should
> >> not define properties which represent DT node choices. IOW, Choosing a
> >> node and compatible (e.g. usb controller as device) is enough to
> >> describe the hardware. No need for other properties to control some
> >> register in other block.
> >
> > The issue with h2mode is that it affects several devices and these
> > devices should not be in a "running" state when the h2mode is changed.
>
> Why the change should happen when device is running? And why this should
> be anyway different than your existing hsmode property - it also will
> happen when system and device are running.
>
>
> > PCI devices (host controllers) itself are not described in the DT. They
> > are automatically enumerated.
>
> Aren't we talking about USB controller in a MMIO-based SoC?
>
> > Changing the property in USB device controller can leads to hang on
> > other busses. Indeed, changing this property when a device affected
> > by the property is running can lead to a bus hang.>
> > In order to do that from the USB device controller I need to synchronize
> > the other devices to wait for this setting before running.
> > 1) probe sysctrl without setting h2mode
> > 2) probe some devices (USB host and probably others)
> >    Stop at some point and wait for the h2mode property setting.
>
> Why do you need to wait? Which device needs to wait? There are no such
> devices... if they are then please bring entire DTS, not some pieces in
> this patchset.
>
> > 3) probe usb device -> Set h2mode property
> > 4) allow devices waiting for the property setting to continue.
>
> I don't get why do you need such order. Your sysctrl also probes any
> time so old solution has exactly the same problem, doesn't it?
>
> > This synchronization seems pretty tricky and what to do if nobody
> > set the property (USB device controller not present or status="disabled"
> > for instance) ?
> >
> > Setting this property in sysctrl probe avoid the need for all of this
> > synchronization:
> > 1) probe sysctrl and set h2mode.
> > 2) probe other devices (no need to wait for the setting as it is already done)
>
> No, because other devices probe before sysctrl. If you bring here any
> manual ordering, you are doing it wrong.
>
> > The probing of the other devices (or the starting of they running state)
> > is guaranteed as they all need some clocks and so cannot start without
> > having the sysctrl node already probed.
> > This sysctrl node handles the clocks.
>
> Ah, so sysctrl is a clock controller for these?
>
> Then still there are no other devices depending on your USB. The USB is
> the owner of this property (specific bits in register), no one else.

1. There are two USB devices.
2. The USB drivers can be modular, the sysctrl driver cannot, as it is
   the main clock controller.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
