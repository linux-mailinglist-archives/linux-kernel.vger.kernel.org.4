Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3E629E62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiKOQDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKOQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:03:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A762F7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:03:30 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id hh9so8961864qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bl7X7AtYz21yLn/dRe/iFEf1ZpAPljd60TEttSTNQec=;
        b=HJh/aWo1F07VJK6tyVYY1ZPO5frNwOHC6QU21Gl7eWt+zZcxZx32yuHkLlxSCbwidn
         yLIqZkZY1UWas70lpqWPx5snOpa+afrzsT5FuqB5LSiAlyATF1S37ds6bUFSWZ79RHMZ
         7WlpGrf4SfRxx5/LnvszocIqiaqV3wWKnF/ZqSOYnqLcEQUrRah/4G6sR/vj3p/is81z
         CnSSDyTtgiYSuHtHUCm17ZjXEHZvgVSNyZkaVc3iz60yI9YleeWz/7dlXv/BozvEcyrw
         bBgOqkKyMZ2JMc+zYz5RcTW5s0nWJycZrYGaNpSG0IsID+C07ZE/2VL3LC1P7XYOWq0w
         FxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bl7X7AtYz21yLn/dRe/iFEf1ZpAPljd60TEttSTNQec=;
        b=xb6n8lXRbT8UQqhm8w4eGuIbwDO/NHAPI7vmQ+uFGHn97qpSGkg9sSUncPAqfdpNP0
         GjPljMq9ZlkmH4Y6jgxR0yYK2xHZdRLfSwG4ZlKb3jsZkM0NY8OlZH5/4qe9yQ68COxa
         dpRTFFwerT3elgtTX4TXmFXLxRLApNDhXpVHmPOFDFjGeXTVhVaN5pmKUm7gjhihcpLz
         /nNhm4NNfkl/X+syi+mKvm2bKL7nH89RgnRxXVyTZdH+Ct0JTYVWPdtPxBodYPjqBP99
         PJCefjYTnGLAq7YrAbuCuucDNDyIBCDEKlfhuKYNP8YMhaMPhSCD7pztItkj1CNAQY1r
         8nPA==
X-Gm-Message-State: ANoB5pksumA6i7lbNidijdgIj4j4IW7SJbiC9V8w3ATikUmF28XNaIor
        zBX7ReYvjANdE7WQ3LGWLRXz+w==
X-Google-Smtp-Source: AA0mqf7+An+kjW586wfgvXyQ/KPEDy330b9Z4FeEVqedkZG1pEFpmATOd+Fmw0hz74emWtSTdRMmPg==
X-Received: by 2002:a05:622a:1e13:b0:39c:bd83:d75c with SMTP id br19-20020a05622a1e1300b0039cbd83d75cmr16926500qtb.38.1668528209865;
        Tue, 15 Nov 2022 08:03:29 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006fa617ac616sm8639722qkp.49.2022.11.15.08.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:03:29 -0800 (PST)
Message-ID: <df2a19b7fd0238808f00973b2cb5f4f478c38ef9.camel@ndufresne.ca>
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>,
        Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Date:   Tue, 15 Nov 2022 11:03:26 -0500
In-Reply-To: <CAAFQd5DD4QgDs-Dff_SB2tNT3d9Hs8HG0rkQFPV+6vgvKqg+qA@mail.gmail.com>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
         <20210114180738.1758707-3-helen.koike@collabora.com>
         <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
         <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
         <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
         <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
         <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com>
         <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
         <91a96b4a-a91e-aae6-733f-c307ca6840f0@synaptics.com>
         <CAAFQd5DD4QgDs-Dff_SB2tNT3d9Hs8HG0rkQFPV+6vgvKqg+qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 11 novembre 2022 =C3=A0 17:52 +0900, Tomasz Figa a =C3=A9crit=
=C2=A0:
> > > Memory allocation doesn't sound to me like it is related to formats o=
r
> > > modifiers in any way. I agree with Nicolas that if we want to allow
> > > the userspace to specify if the memory should be contiguous or not,
> > > that should be a separate flag and actually I'd probably see it in
> > > REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.
> > >=20
> > I agree with that. But here is a problem, if there was a display
> > device(DRM) that only supports contiguous planes in a frame buffer.
> > How do we be aware of that?
>=20
> That's why I think the MMAP mode is not scalable and shouldn't be
> expanded anymore. Both V4L2 and DRM devices should describe their
> constraints to the userspace and then the userspace should allocate
> accordingly from the right DMA-buf heap. (Or as Android and ChromeOS
> do, just have a central allocator library that understands the
> constraints, so there is no need to query the drivers.)

Just pointing out, they "hardcode" the constraints, they don't truly unders=
tand
them. Also, the Android/ChromeOS implementation is not a great playground, =
as it
completely ignores the constrait already exposed by V4L2 API (the sizeimage=
 and
bytesperline found in the FMT structure). You would not have to implement H=
antro
and Rockchip motion vector size calculation there if you'd simply use the
sizeimage.

Nicolas

