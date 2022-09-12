Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0465B5569
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiILHfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiILHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:35:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156D2A705
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:35:40 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D3F63F82D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662968138;
        bh=M8ZwI8G9EqvwVDaU3nJXSzOMPkM7yBsKLKTPp2g9WgM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=MEpd+GJiXMO7dCtMEbzT1SFE2LxA/skVIhg0QK6S1Y7v192wGvLff7lg5XYuzR/o+
         o6QdTkq5DQFc3CBZ56feluTXHgbgwfzfdR7xB/Tj6AK9oqmA9jIf1YhYg8wWI8A23M
         2krJnwc+0O5n/JfNERkJUG1iludHEn1+tDu/en5nIaZn2pYLYtD0/4JlfTuEsYpIFX
         V+NMnRDNXSQbpGFy1ZtDWr7n4suJSwR7n8ADbbIQGFwNENDQyPIfpzKk+IPZqNQ4hK
         SHOL9eoZcEq3yq+M+tFSAa61hY3rSXy++4ZxY7STWF75G6+7Mg1fbAsXeHxYDlSz1f
         SycaRQt8E/ViA==
Received: by mail-wm1-f69.google.com with SMTP id bg2-20020a05600c3c8200b003b33080cff8so1588873wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=M8ZwI8G9EqvwVDaU3nJXSzOMPkM7yBsKLKTPp2g9WgM=;
        b=KKLpD3ODemu8tsQx+355mMlT1uIR0DjTbP4Z3a0IeFk6DqwQDhAkpVhx3XQA5R5sgU
         +9d9rjGrkhL4wa6+y4yOS6qrRs4H9Uiclj1JuHVbOaEwv6R55YNF1SW9M1rodV0cal2d
         rBQwKkm909Y++OvMeNMKRot0E2sPmeqdC1akHsZxcKuMUfsNzsFTX9tK3LuALsHgjKnY
         ta4SpFBeOLGoVhOIwRk32rxPkEsoTXZypq/UW6UMvgOOKrDXjp1ULdd2Rv69bH6hzyrK
         gO5kkwIUR6rjo+WDAkyakrNW97aOxVO9z7+AUvQftvNPBqKbyGJnLknr9TllwTISkuOV
         kTrA==
X-Gm-Message-State: ACgBeo3byVwqk5hoDmfDPd5hInrLPyw4aQkfL8zMlaM8nbdO0i5NXUaJ
        95yCwJBodnsz2UGQLbNfftFU13o7dnHOuxz9sLOin4WX1nM61ZKFtXmga8qN8YfXs8gCCixKEAf
        783OxOTzMYrTMRtYUV8J2PXMp2kIGBxrnAKVTO1CaAuN/hd8odWmuHBDF7Q==
X-Received: by 2002:a05:600c:1992:b0:3a6:23f6:8417 with SMTP id t18-20020a05600c199200b003a623f68417mr12309802wmq.14.1662968138066;
        Mon, 12 Sep 2022 00:35:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7eP2hnaSKxFe6/FQgH2afyOttjwUxtLLbzmIm5J0Ggx2M2a0Gqg9+4V4VTmuOO2Xkvpii4N4LCgIy3ntprucM=
X-Received: by 2002:a05:600c:1992:b0:3a6:23f6:8417 with SMTP id
 t18-20020a05600c199200b003a623f68417mr12309784wmq.14.1662968137751; Mon, 12
 Sep 2022 00:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWlc1n4HRxawa/K@kroah.com> <DS7PR12MB60959AACEDB0AEFEE78A5B2EE2419@DS7PR12MB6095.namprd12.prod.outlook.com>
 <CAAd53p5cz0VWUH9Rdvk70pcpY-PLc9SV8UCvMEc0+TBGES5W5w@mail.gmail.com> <312d7781-671c-3765-a7d9-690d032650ec@amd.com>
In-Reply-To: <312d7781-671c-3765-a7d9-690d032650ec@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 12 Sep 2022 15:35:26 +0800
Message-ID: <CAAd53p5=SJ7gK7e1H4D09-1bXBVezMuzGsgA2ptXLKGtBESR9Q@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is found on
 AMD USB4 controller
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 8, 2022 at 11:22 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
[snipped]
> > Nice to hear. Hopefully this can be fixed at firmware/hardware side.
>
> I guess you and Anson might want to sync up offline and compare whether
> you have the same hardware stepping.

Sure.

[snipped]

> > We used UEFI capsule to update the firmware, via fwupd.
>
> So that's a difference from how Anson did it.  Could you perhaps dump
> the BIOS SPI image?  Anson can flash the exact same dump via dediprog
> and see if he can repro.
>
> It would let us confirm if it was caused by your upgrade path.

OK, will dissuss this with AMD/HP offline.

>
> >
> >>
> >> 2) Did you change any BIOS settings?  Particularly anything to do with Pre-OS CM?
> >
> > No, nothing in BIOS was changed. >
> >>
> >> 3) If you explicitly reset to HP's "default BIOS settings" does it resolve?
> >
> > Doesn't help. I put the device to ACPI G3 and it doesn't help, either.
>
> OK.
>
> >
> >>
> >> 4) Can you double check ADP_CS_5 bit 31?  I attached is a patch to kernel Bugzilla to
> >> add dyndbg output for it.  If it was for some reason set by Pre-OS CM in your BIOS/settings
> >> combination, we might need to undo it by the Linux CM.
> >
> > All ports say "Hotplug disabled: 0".
> >
> > dmesg attached to the bugzilla.
>
> OK, that at least rules out DHP from Pre-OS CM.
>
> >
> >>
> >> 5) Are you changing any of the default runtime PM policies for any of the USB4 routers or
> >> root ports used for tunneling using software like TLP?
> >
> > No. And they should be suspended by default.
> >
>
> Thinking about this being possibly a firmware upgrade path problem, can
> you please check:
>
> # grep SMC /sys/kernel/debug/dri/0/amdgpu_firmware_info
>
> Anson's system was 0x04453200 (program 4, version 69.50.0).

Exactly the same here.

Kai-Heng

>
> > Kai-Heng
> >
> >>
> >>>
> >>>>
> >>>> Bugzilla:
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> >>> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216448&amp;data=05%7C01%7Cm
> >>> ario.limonciello%40amd.com%7C1e27b1d6f69e42796c7b08da8f107121%7C3d
> >>> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637979598042186185%7CU
> >>> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> >>> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=0lhcaKfUyoK
> >>> 0FXT9uDZ8a%2Fpxs9tHd8aoQcyPFdB%2F0eY%3D&amp;reserved=0
> >>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>> ---
> >>>>   drivers/thunderbolt/nhi.c    | 29 +++++++++++++++++++++++++++++
> >>>>   drivers/thunderbolt/switch.c |  6 ++++++
> >>>>   drivers/thunderbolt/tb.c     |  1 +
> >>>>   drivers/thunderbolt/tb.h     |  5 +++++
> >>>>   include/linux/thunderbolt.h  |  1 +
> >>>>   5 files changed, 42 insertions(+)
> >>>>
> >>>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> >>>> index cb8c9c4ae93a2..75f5ce5e22978 100644
> >>>> --- a/drivers/thunderbolt/nhi.c
> >>>> +++ b/drivers/thunderbolt/nhi.c
> >>>> @@ -1225,6 +1225,8 @@ static int nhi_probe(struct pci_dev *pdev, const
> >>> struct pci_device_id *id)
> >>>>   {
> >>>>      struct tb_nhi *nhi;
> >>>>      struct tb *tb;
> >>>> +   struct pci_dev *p = NULL;
> >>>> +   struct tb_pci_bridge *pci_bridge, *n;
> >>>>      int res;
> >>>>
> >>>>      if (!nhi_imr_valid(pdev)) {
> >>>> @@ -1306,6 +1308,19 @@ static int nhi_probe(struct pci_dev *pdev, const
> >>> struct pci_device_id *id)
> >>>>              nhi_shutdown(nhi);
> >>>>              return res;
> >>>>      }
> >>>> +
> >>>> +   if (pdev->vendor == PCI_VENDOR_ID_AMD) {
> >>>> +           while ((p = pci_get_device(PCI_VENDOR_ID_AMD, 0x14cd,
> >>> p))) {
> >>>> +                   pci_bridge = kmalloc(sizeof(struct tb_pci_bridge),
> >>> GFP_KERNEL);
> >>>> +                   if (!pci_bridge)
> >>>> +                           goto cleanup;
> >>>> +
> >>>> +                   pci_bridge->bridge = p;
> >>>> +                   INIT_LIST_HEAD(&pci_bridge->list);
> >>>> +                   list_add(&pci_bridge->list, &tb->bridge_list);
> >>>> +           }
> >>>> +   }
> >>>
> >>> You can't walk the device tree and create a "shadow" list of devices
> >>> like this and expect any lifetime rules to work properly with them at
> >>> all.
> >>>
> >>> Please do not do this.
> >>>
> >>> greg k-h
>
