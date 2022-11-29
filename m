Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04B063BE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiK2Kmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiK2Kmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:42:38 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9A101D5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:42:35 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3691e040abaso134246537b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiuHOBfLm8xDKPr5NpNi5uPMZ9QumzIsq4ugxTPstn0=;
        b=p050Ok3UGwXLXE9hFcZfGx5Mm2QsWRICxByxDR/1u4QZnbfvFG6psV+emVzskfbk5z
         89tYazSs4E6fwabgM0W6TmEDHClbFJtHSFhF17gcnpdPZS9JRhwCD4sfbWjdpBUVDvE/
         u2MBnXLQuSH1Q7YPq/ELFwZM+RC5st12uCHwg3aflM9OcA4A1oHN3SBT+SzUZYpH1fae
         5Pe4nEYvKmx5YNIpSXyJeyDZ7P7/SxdxnWcN/6yil7BGC9vs426mxusG24I9ipq3Qi5/
         T/j5+TNGI6ORutVEK309xwiJA4pakZDRpDdJpKhCwJt8i1VpsOg9UfGN8bOg2WVeTREb
         0L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiuHOBfLm8xDKPr5NpNi5uPMZ9QumzIsq4ugxTPstn0=;
        b=KBymNM2u6vBucTM8jz0qW0cPLFReXY7LfDy48VRBE/6/so6/qcCFc1MfFwZvb7BBTP
         0HcWL84s/VZzY9hZv61It+R9ooSKv/kpH5CEE8k5DPLLSlZOTdglsLsW3kKNpCOfA1eI
         Ki8q0ypaZtKX3R3UzjUQPiFOjjt3uBnkSIswGK/wLEBUPQSsXNgzk+hDDPKthGPiPOpg
         msXL0QP12Rxb1odyT4/5Jqn0BB8y1+oguRw6hZWalwNAlGwPgn3xV9w1yaGGX0XEcHgG
         T7cpq6GUN2FVIJd29cCyFK3Ai7bP5TTLfl2j+aZTaI1WkRBffjL63B0XvHycgmUDPyy0
         fNiQ==
X-Gm-Message-State: ANoB5pkJQ6mj+veqMCPmtYIGdDBEmBo67PETNPWtoM/rXw0xKXF0BvEB
        ZQ/WDAUuv6zfc4qSoJtNFpoWYxt1hLFNBMnXBqvbHg==
X-Google-Smtp-Source: AA0mqf6wCMf4LDoq0RWeKfC+T4s70dw2fPJdqZS8dpYQD0aDkLZtEaTaRNMR16bUd5fUPv1By3TVsd4xYQae6EVqobc=
X-Received: by 2002:a81:fc5:0:b0:3c3:5496:49f3 with SMTP id
 188-20020a810fc5000000b003c3549649f3mr11914670ywp.510.1669718554975; Tue, 29
 Nov 2022 02:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20221129101030.57499-1-randy.li@synaptics.com>
In-Reply-To: <20221129101030.57499-1-randy.li@synaptics.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Tue, 29 Nov 2022 10:42:24 +0000
Message-ID: <CAPj87rOiLoGCnOio7=g9wd4auMuwSQV8PesD3Svf=gOWJAzwOg@mail.gmail.com>
Subject: Re: [RFC] drm/fourcc: Add a modifier for contiguous memory
To:     Hsia-Jun Li <randy.li@synaptics.com>
Cc:     dri-devel@lists.freedesktop.org, ayaka@soulik.info,
        linux-kernel@vger.kernel.org, nicolas@ndufresne.ca,
        hverkuil@xs4all.nl, tzimmermann@suse.de, tfiga@chromium.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, 29 Nov 2022 at 10:11, Hsia-Jun Li <randy.li@synaptics.com> wrote:
> Currently, we assume all the pixel formats are multiple planes, devices
> could support each component has its own memory plane.
> But that may not apply for any device in the world. We could have a
> device without IOMMU then this is not impossible.
>
> Besides, when we export an handle through the PRIME, the upstream
> device(likes a capture card or camera) may not support non-contiguous
> memory. It would be better to allocate the handle in contiguous memory
> at the first time.
>
> We may think the memory allocation is done in user space, we could do
> the trick there. But the dumb_create() sometimes is not the right API
> for that.
>
> "Note that userspace is not allowed to use such objects for render
> acceleration - drivers must create their own private ioctls for such a
> use case."
> "Note that dumb objects may not be used for gpu acceleration, as has
> been attempted on some ARM embedded platforms. Such drivers really must
> have a hardware-specific ioctl to allocate suitable buffer objects."
>
> We need to relay on those device custom APIs then. It would be helpful
> for their library to calculate the right size for contiguous memory. It
> would be useful for the driver supports rendering dumb buffer as well.

As a buffer can only have a single modifier, this isn't practical.
Contiguous needs to be negotiated separately and out of band. See e.g.
dma-heaps for this.

Cheers,
Daniel
