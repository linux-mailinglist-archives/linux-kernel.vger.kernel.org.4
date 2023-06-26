Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6573EEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjFZWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:38:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9FE5A;
        Mon, 26 Jun 2023 15:38:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b698dd515dso33294421fa.3;
        Mon, 26 Jun 2023 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687819111; x=1690411111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/4BPPMHxIuX4VVUkfnAZKGZOTCGN6vqENFDffRdr5PA=;
        b=jQFjf4X3mG+0YOiNUYcjsja7cQ+ItKtzN8+vj6u4YVgsB4JaIqtuhMT5UCVUxUJz4i
         ZEDU69/ocAs3SvgoX+rDPvyDPOlHzbuQz/lyEAYF6L0LH+8LgctjGFNm4Vejo7MxVzDt
         qiJjofMJtWSRxEVa10tAOWjc+h7fi/7Hv05huAdjtBimk8g1S+ueVSLTo7op4BLp7ON5
         jvf5lj7DKxmOb5m6ju6QC6fnctbhz4mgT/io2QdujpKtpLMPYeNaco6tAscDk9Xkz5rQ
         pWWh3HUFbUIbbkW+Cf/iIIqufSPZY+ydtcQZIpa8QIJJJ0JPVMXz72S6TAns18MhtEP2
         apKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687819111; x=1690411111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4BPPMHxIuX4VVUkfnAZKGZOTCGN6vqENFDffRdr5PA=;
        b=KdG6a8oX4NOaAkuTiwR08HNMfZ7cGM56n/Zr0ucn90jsMLoOKSDHLOlpxKR04sEyK/
         rCQVRingfPSY1OW1ENCdL3xAnZpGyXaMTxuzVk3wf3ZS83CCswUW96ve1+3q+nn+Qx5k
         QTmwHYda4KBsslZWuTzn0hAYR7s0A3RWof8chgu2R2AzYuyyNSj7C1ZBV/s+YONkRKfm
         cAHhdQ89gRXviYF0vo3RJjKFLpdNpEh5/LQJdFvUfY8ApdVhaXWHDE9PDt7G3S0yUiRq
         +XHNcrQYR52gnKLZdW8HmIrOVM7pdpfm+9E+3cqQLtVCbCFoUQ0GnltjwPiMp8h9A2q2
         qNIw==
X-Gm-Message-State: AC+VfDxlglwQSVfY/8os9E5S2wjghPXGEY2qAj6ozImSOWEfKlD3HlQw
        vUlY9+iRIO70XU3tZkey+Di9o99AJqRraKN6h2A=
X-Google-Smtp-Source: ACHHUZ6lR+r47SwmWrLOLwTX0weKHcxS2NtYt9q6sHoMoPzLK4Ljmu+yCVm3VJkQRyQVU7ShZUnwFUHfeto+xg4lEu4=
X-Received: by 2002:a2e:2e10:0:b0:2b6:9b4a:2608 with SMTP id
 u16-20020a2e2e10000000b002b69b4a2608mr2962412lju.37.1687819111001; Mon, 26
 Jun 2023 15:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230620004217.4700-1-dakr@redhat.com> <20230620004217.4700-4-dakr@redhat.com>
 <cf6846ea-5bd0-0b41-b7e6-901c70701751@amd.com> <a8edf75b-e0f7-a6c7-7d29-f0d39923549b@redhat.com>
 <41aecd10-9956-0752-2838-34c97834f0c8@amd.com> <bcde7ea3-fbab-3a18-e810-64b6589ddb18@redhat.com>
 <86ef9898-c4b6-f4c0-7ad3-3ffe5358365a@amd.com> <c1f05169-dec0-22ee-52fa-c8070678394e@redhat.com>
 <2f502150-c1f8-615c-66d9-c3fb59b8c409@redhat.com> <4a52ac7c-19ba-8906-5902-fbf75673bf59@amd.com>
 <d18a4ea5-4e8e-be69-84c3-ca658f5cfd24@redhat.com> <923e914f-d367-2f74-9774-f0024d946bdd@amd.com>
In-Reply-To: <923e914f-d367-2f74-9774-f0024d946bdd@amd.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 27 Jun 2023 08:38:18 +1000
Message-ID: <CAPM=9tzQ51LEc9if5HBCgbn7-HUOPw+qEvx7jEE2hk6gYBKvOA@mail.gmail.com>
Subject: Re: [PATCH drm-next v5 03/14] drm: manager to keep track of GPUs VA mappings
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        tzimmermann@suse.de, mripard@kernel.org, corbet@lwn.net,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > As pointed out by Christian, this would optimize the "get all mappings
> > backed by a specific BO from a given VM" use case.
> >
> > The question for me is, do other drivers than amdgpu commonly need this?
>
> I have no idea.
>
> >
> > And what does amdgpu need this for? Maybe amdgpu does something we're
> > not doing (yet)?
>
> Basically when we do a CS we need to make sure that the VM used by this
> CS is up to date. For this we walk over the relocation list of BOs and
> check the status of each BO+VM structure.
>
> This is done because we don't want to update all VMs at the same time,
> but rather just those who needs the update.

This seems like a legacy from GL and possibly older vulkan, going
forward vulkan can't rely on passing lists of objects into the kernel
due to things like buffer_device_address, I'm not sure we should
optimise for this situation, and moving the tracking list into the
drivers is going to mean having a bunch of drivers all having the same
boilerplate, to do the same thing just so amdgpu can't avoid doing it.

Now there might be some benchmark somewhere we can produce a benefit
in this, and if there is then we should consider going this way for
all drivers and not just allowing drivers to choose their own path
here.

> >
> > Christian - I know you didn't ask for "do it the way amdgpu does",
> > instead you voted for keeping it entirely driver specific. But I think
> > everyone is pretty close and I'm still optimistic that we could just
> > generalize this.
>
> Well, you should *not* necessarily do it like amdgpu does! Basically the
> implementation in amdgpu was driven by requirements, e.g. we need that,
> let's do it like this.
>
> It's perfectly possible that other requirements (e.g. focus on Vulkan)
> lead to a completely different implementation.
>
> It's just that ideally I would like to have an implementation where I
> can apply at least the basics to amdgpu as well.
>

I think we can still do that just either have an option to disable
using the list internally in the gpuva or have the driver keep it's
own tracking alongside, there may still be use cases where it can use
the gpuva tracking instead of it's own.

I don't think we should forklift what is pretty likely to be common
code across every driver that uses this going forward just to benefit
an amdgpu design decision for older stacks.

Dave.
