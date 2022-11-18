Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3262FEFA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKRUrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKRUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:47:01 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DBE63175
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:47:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f18so15891774ejz.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5mIJKaMx1pQwhku2nm6bI31JWHjArdgLDjzIVWQmzw=;
        b=p6G0G6EmyfrWheZD8YdSOgeWzjDKm8jq9RXjYThdcRilvkW/x7/9i5Iv+x+3+VNTtM
         aYFi5FUuKw4c4HpSqMOp4oyAn9yUVMVpOzIq3W3rN7ZFtwME6UWQP21JxkI4kO0e3V5l
         p/jMO/XmminachraU1I6jznhFkTMgGTCgUKqrSkIgF4zfLxaP1kXDlqfs26JXpqGAh16
         Q9HbkH3+JdCgcPV0kCanVuWpcrquQ61jFWku3miKhdg2Vuxgj1mopqUH9nvBT4F9rpwR
         2h7/eTXetDDT9Okvv92D8PlgXeo82Ni9s+lmuyvyk+btnRv0J5EQNtoGzSWPg493nvJL
         flhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5mIJKaMx1pQwhku2nm6bI31JWHjArdgLDjzIVWQmzw=;
        b=cb/3q2sLUjhVxTNVhXgj4wAh0n4ebK2AR0VyF49QmI9NYCsPL++SHZJj9jCk4f7z20
         2hampGeHg+66Bq1Ws2E/tGBMQzWCdggnlEpqGDVYHJebcGH2bIDVTJ/jL/1EwV5/5Tsk
         mHqEKG7oBoaDvaK5pChd3FPleJVeK7v0q18jSFEYjDIkxCyCJVqGxpcUWmV4H9zyXC3l
         hIK9PdnY4RXaxTFSj+9r/oZ0rGz+WMmCjyvHlQIR0gIDfKMn9AFc8kn8vK8bTNMAQAWm
         zqNrZGoDSn2jGHbzohKYYocMhnFAcMyQvgBztn5ikGEZfQ6CF4mXYYWn9kWiFs0Kv0EY
         WF4g==
X-Gm-Message-State: ANoB5plVxnyQWk49PU2e0WTE/rMk8Th3IqTYHxnbmn143Di+DdBwEHYp
        DrQGQgh+uq3cRR0mMhDsPa7JIYZoGW+lQj5sGpg=
X-Google-Smtp-Source: AA0mqf5WICxI6NK59qKF2yN268AeQmX+15/dr5sYNyDhDKSnHOrrc88T6Mmb4wPczvMKKxnxv6B9WAiLIRxQLi+WC3g=
X-Received: by 2002:a17:906:65c4:b0:7ad:d250:b907 with SMTP id
 z4-20020a17090665c400b007add250b907mr7182127ejn.737.1668804419101; Fri, 18
 Nov 2022 12:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
In-Reply-To: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Fri, 18 Nov 2022 15:46:47 -0500
Message-ID: <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled
To:     =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:50 AM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> the table is filled. Then it disables INTx just before clearing MASKALL
> bit. Currently this approach is rejected by xen-pciback.
> According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).
>
> Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
> applies to three places:
>  - checking currently enabled interrupts type,
>  - transition to MSI/MSI-X - where INTx would be implicitly disabled,
>  - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
>    enabled, as device should consider INTx disabled anyway in that case
>
> Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL t=
oo")
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> ---
> Changes in v3:
>  - allow clearing INTx regardless of MSI/MSI-X state, to be consistent
>    with enabling MSI/MSI-X
> Changes in v2:
>  - restructure the patch to consider not only MASKALL bit, but enabling
>    MSI/MSI-X generally, without explicitly disabling INTx first
> ---

I was trying to test your xen-pciback v3 patch, and I am having
assignment fail consistently now.  It is actually failing to
quarantine to domIO in the first place, which matches the failure from
the other day (when I more carefully read through the logs).  It now
consistently fails to quarantine on every boot unlike the other day
where it happened once.

I added some printks and it 's getting -EBUSY from pdev_msix_assign()
which means pci_reset_msix_state() is failing:
    if ( pci_conf_read16(pdev->sbdf, msix_control_reg(pos)) &
         PCI_MSIX_FLAGS_MASKALL )
        return -EBUSY;

# lspci -vv -s 14.3
...
    Capabilities: [80] MSI-X: Enable- Count=3D16 Masked+
        Vector table: BAR=3D0 offset=3D00002000
        PBA: BAR=3D0 offset=3D00003000

So it looks like MASKALL is set and prevents assignment.

setpci -s 00:14.3 82.W=3Df
cleared that out for me and I could assign the device.

My dom0 boots, it runs flask-label-pci for a set of PCI devices
(including iwlwifi), then xl pci-assignable-add for all PCI devices
which will be passed through, then a little later it boots the
associated domains.  Dom0 does not have a driver for iwlwifi.

I'll have to investigate more to see how MASKALL is getting set.  This
had not been an issue before your recent patches.

Regards,
Jason
