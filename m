Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62657613CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJaR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:57:42 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68C63A8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:57:38 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id c65so7043787iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YPhKQoj326GDzQlpnATdi3QTN2ODDVoVrBVz75un/+Q=;
        b=sYhCXj1H3jsEvNOxWVGQJ+afX+j7LSp//QRFn83qUscI4Eep1oum3gEorgso/be61X
         ajUR+t2AHGLP7unbb9SEG4GCzpn7VMEt6fVz3yMCR+4ZJ2k3N8stJM6//h4FEAJbIubJ
         MOOT43YiJCNfV80lePj7IvdInQ56gfiODzSNIvTFqKsEvfjmwnVlO3+L5O5Y3nhWI6O9
         K0momkWkmHHQDU03ZdNfJPII5w9jSCVvXNB82RukQlzW01UlJ4B1/V2Qp7oeIwej2Rl7
         PL3/vaZkjrV+KbyrAUGu7zMuleUc1H3ioPDhznC7VYrfu9Cw6tC8fzAUPh9zYrRX+7ci
         ga9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPhKQoj326GDzQlpnATdi3QTN2ODDVoVrBVz75un/+Q=;
        b=klSlfD82tE7/77wsBaCrk2ZeF/8/xqyQs7+EIuLYr5OQI65sqI8WOnajXdqd0CahKn
         cK5eNPJ3vIkYrtYi2B6veSGUj/URdOKn4HuW0TCWi/soChgB1n8AYu36hsIVPMxJvzd5
         h2fsEecm8QRocHXXruNoNCesHLXMIMmNjgRi1uWuOdjfjmRLcGn1830Zv2BJGnl9KZOh
         cQlOg6nTsfyG537G1vepI5Fm0Sxr3n5CmtL8/l97aghaLiMrClf2v+XRjQuNQydpC6j+
         KZuap7kg7Q/MrII+Bi4+uYaZm/jIjIJamtxNUt0k/cbe/25fd+Grx0YlFLz/uhgtTEXQ
         /dTg==
X-Gm-Message-State: ACrzQf1IjEcYFNGtJ5JYgK+GLGGgA4X5ESxSatTsTUSUBUc78V5ky9YT
        N/7uQ7AbumKek8dnoAwJ8B2tmpyiDS/b3jwVtbXLkw==
X-Google-Smtp-Source: AMsMyM67XExll5UMwgggCXPKhjzVkZsaaGn9qC5GldyBHD5Q2MvvxO4lzgg49TL6tCvFB/QDf6Wp9kYI9i6MgOY9SQ8=
X-Received: by 2002:a02:a30c:0:b0:375:3a7a:de7e with SMTP id
 q12-20020a02a30c000000b003753a7ade7emr7890398jai.246.1667239057308; Mon, 31
 Oct 2022 10:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3a_35R48khgW8D1MxokEqmYP3mBsUwhMq5Vfi5BiyYCQ@mail.gmail.com>
 <425617d8-3d36-f50e-e582-826a4c6da32d@amd.com>
In-Reply-To: <425617d8-3d36-f50e-e582-826a4c6da32d@amd.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Oct 2022 18:57:01 +0100
Message-ID: <CAG48ez1Bkk0b6HtSnWcRPfYV0zxYJO_2kuC6s9jmRNwfYcXAiQ@mail.gmail.com>
Subject: Re: [BUG] AMDKFD: criu_checkpoint() error path treats userspace
 pointer as kernel pointer
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        David Yat Sin <david.yatsin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 6:54 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> Am 2022-10-31 um 10:20 schrieb Jann Horn:
> > be072b06c73970 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
> > added an error path in criu_checkpoint() that (unless I'm completely
> > misreading this) treats the userspace-supplied args->bos (which was
> > previously used as a userspace pointer when passed to
> > criu_checkpoint_bos()) as a kernel pointer:
> >
> >    ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
> >        (uint8_t __user *)args->priv_data, &priv_offset);
> >    if (ret)
> >      goto exit_unlock;
> >    [...]
> > close_bo_fds:
> >    if (ret) {
> >      /* If IOCTL returns err, user assumes all FDs opened in
> > criu_dump_bos are closed */
> >      uint32_t i;
> >      struct kfd_criu_bo_bucket *bo_buckets = (struct kfd_criu_bo_bucket
> > *) args->bos;
> >
> >      for (i = 0; i < num_bos; i++) {
> >        if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
> >          close_fd(bo_buckets[i].dmabuf_fd);
> >      }
> >    }
> >
> > This seems very wrong, and also like it's guaranteed to blow up as
> > soon as it runs on a machine with SMAP, which makes me think that this
> > codepath was probably never exercised?
> >
> > (Also note that just changing this to copy_from_user() instead would
> > still be wrong, because malicious/bogus userspace could change the FD
> > number to the KFD device's FD, and the VFS assumes that an FD can't be
> > closed while it's being accessed in a single-threaded process.)
>
> Thank you for catching this, and thank you for the advice. In other
> words, we need to store a copy of the FDs in a kernel mode buffer that
> is not accessibly by usermode, so we can reliably close the correct FDs
> in the error handling code path.

Sounds good to me.

> Rajneesh and I will fix this ASAP.
>
> Do you think we should also avoid copying the FDs to usermode before
> we're sure that we'll return success? I don't think it would make a big
> difference because user mode could try to guess the FDs and use them
> before we return from the ioctl either way.

Yeah, that shouldn't matter - as you said, userspace can guess the FDs.
