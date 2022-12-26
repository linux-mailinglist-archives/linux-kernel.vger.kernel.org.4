Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD9655F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 04:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLZDqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 22:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZDqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 22:46:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240F2F3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 19:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672026357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LPML0T2odU1efvKA6TB4e9nlnB9KljoL+oggFMgoV7U=;
        b=WXhnkygWPPM60oI96phUUIGCVhP35UX7c145IMZokDkpAdSoOF6u+o6GDEKf92Ws+DPKH4
        vBoOYH85PMlf7bmL3JdlwNdL3AxRkxFBeqHW0Q0GpCJEfvxEgm7dl9qOx00fchXwDxcIh+
        0K9RYeMAiO7K8LuJhDeOKwOH9rtHmRE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-bstLblnIPLa_CotG03swuA-1; Sun, 25 Dec 2022 22:45:55 -0500
X-MC-Unique: bstLblnIPLa_CotG03swuA-1
Received: by mail-ot1-f72.google.com with SMTP id cj4-20020a056830640400b0066dee63bd77so5776559otb.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 19:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPML0T2odU1efvKA6TB4e9nlnB9KljoL+oggFMgoV7U=;
        b=PcawFN+id6nclfCqYhaQ51jBHstgs2+3y664pALK+EP3iyZeAV9d+qUJNBL6GOBf36
         0vUerD16MR5cv+YeiCJl3SOrqkrGMLVEXId7cy5BFgNUKGCtcZ0Yq0f4yzVrakj/7MlT
         8bc6nBvOcLP9IwcCDDJkI30ztPMQuXlBbEtUc4IMG3V3GxwnszhRQX60SkoEk3GYoHeN
         2MAdRsfn90CyoN4vnXNuogalrTo5xEXSlCxbSo3JXrXOhEChtEkEwEAivB39GTk3stkf
         Cu8tCljKsIJaTMSsvM0kFdSHAl63AN01T50/I2xdhmPKZkCEo0/BX2vRo/37REfoW8dW
         kZZQ==
X-Gm-Message-State: AFqh2krJD5xhmUpnfbw0AjTPEXsxIRRP5raJrufBSYvj+qcAnRkhbdge
        +pvZXHNOMi4UPSqe9VWWs3vVpEE35urx9DbYjhKnJOdHCEK/J6PKr/mfpjMnKyt9Bd41b4zSYUd
        9WS3yOTQV7HIdwt4w+jcRU6wbpc8I53r6y7CmufoT
X-Received: by 2002:a05:6830:4a3:b0:670:8334:ccf2 with SMTP id l3-20020a05683004a300b006708334ccf2mr1092695otd.201.1672026354897;
        Sun, 25 Dec 2022 19:45:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv4l8sal78jwmSmfNpp5adoBH8DFpxNZ4rOpa5yo3+kGZLSJd99jDWK2hJIcSUrI33x/vEuSXvdG0zyZB3QQ+8=
X-Received: by 2002:a05:6830:4a3:b0:670:8334:ccf2 with SMTP id
 l3-20020a05683004a300b006708334ccf2mr1092684otd.201.1672026354707; Sun, 25
 Dec 2022 19:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com> <20221222060427.21626-5-jasowang@redhat.com>
 <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
 <CACGkMEv4YxuqrSx_HW2uWgXXSMOFCzTJCCD_EVhMwegsL8SoCg@mail.gmail.com>
 <CAJs=3_Akv1zoKy_HARjnqMdNsy_n34TzzGA6a25xrkF2rCnqwg@mail.gmail.com>
 <CACGkMEvtgr=pDpcZeE4+ssh+PiL0k2B2+3kzdDmEvxxe=2mtGA@mail.gmail.com> <CAJs=3_BqDqEoXGiU9zCNfGNqEjd1eijqkE_8_mb3nC=GwQoxHA@mail.gmail.com>
In-Reply-To: <CAJs=3_BqDqEoXGiU9zCNfGNqEjd1eijqkE_8_mb3nC=GwQoxHA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Dec 2022 11:45:43 +0800
Message-ID: <CACGkMEs=YrtP-GT_MKoZdORtYCD09QdmZGpgQUHMOMLG_eX-FA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq command
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 3:39 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> > This needs to be proposed to the virtio spec first. And actually we
> > need more than this:
> >
> > 1) we still need a way to deal with the device without this feature
> > 2) driver can't depend solely on what is advertised by the device (e.g
> > device can choose to advertise a very long timeout)
>
> I think that I wasn't clear, sorry.
> I'm not talking about a new virtio feature, I'm talking about a situation when:
> * virtio_net issues a control command.
> * the device gets the command, but somehow, completes the command
> after timeout.
> * virtio_net assumes that the command failed (timeout), and issues a
> different control command.
> * virtio_net will then call virtqueue_wait_for_used, and will
> immediately get the previous response (If I'm not wrong).
>
> So, this is not a new feature that I'm proposing, just a situation
> that may occur due to cvq timeouts.
>
> Anyhow, your solution calling BAD_RING if we reach a timeout should
> prevent this situation.

Right, that is the goal.

Thanks

>
> Thanks
>

