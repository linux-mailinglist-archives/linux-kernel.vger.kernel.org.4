Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4744604F07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiJSRko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJSRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:40:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B499D19045B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:40:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o12so20896260lfq.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Afowyyon5euI9PhaibGARBLnjdO0Eh8339cH1CRlAG4=;
        b=oN5WzzhF2z026vxDeU3ravyd7cp56GNv6K4OlSAMpfrlWRMw2m0fPV2wVMpeV5UKaV
         +0OvWqZcLSTARVGN7SEtsOnWNk54doU/b7NF/vnK47uMwOBpOUCvkx4gW66j05fldwch
         5Ht2SmtpsBrDZcX5oC6Qc+/vT5S52k9674loddh1y+h91B5X8Rj+EHmCBaU/ueH6GZeg
         n8u9n/sE6sxaaz5BCUDyjHtmrILpugKGn51vrV2/Y2onvHPAy7lDcFHpRfl4bg6Itsb5
         j/K/1/0XTpyyLrP04yPqP+UT5+/Zjo10XfMaA4n7ZgZKw0x8dVbXgulldmfgJFK5duDq
         6K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Afowyyon5euI9PhaibGARBLnjdO0Eh8339cH1CRlAG4=;
        b=4AuN1k7dTgDUZcdq3fV5KUig9eLzaLpmr6O3Hl5aca9SxKW5lFd/j46mFI3ihu8r3l
         N6Ydxi3Z9d+3cEK+3sNKez4gcBNgRAHBArfQd7a4WzOt0DCG0UcNdjDoVK3wwtpYYs9j
         gRh2/k56wRWgkuSGW4lzGKA7kihI91XymZiL+i+1DCvlPEg0bg7ClTd6AJqX7/t2P+qg
         lMRefNxW4VEQoTm+mPAK8jKPYjTYL4zX0hres+vgoHt9iqPW0S6cYiwVs1o4ywQkKFYe
         BjWlZFBmJK4H5KyNe3p7zrvRQ/f7eebdhFL94o0BbwVH16I/csOjUeWSFF5T1H+m4GhD
         zygQ==
X-Gm-Message-State: ACrzQf3Td0eSC3IRSQw6ZEODQjq3+0n1/D8fx5hv2TyD4uHMO88GOTxq
        IvSBQGQJLrl+FZJLDUT70knCwv3ov1FW3hwwnPcRbcu2FrWxZw==
X-Google-Smtp-Source: AMsMyM5OM0rkP4xd7qFD7X+W9BDiy0UNKNnDjY/WWqLGY78WJGku/tyVodwij2Sz0kBzFDfICmNvPAAhyWIOG7+B0NQ=
X-Received: by 2002:a19:5f52:0:b0:4a2:2429:c6d5 with SMTP id
 a18-20020a195f52000000b004a22429c6d5mr3690244lfj.291.1666201231457; Wed, 19
 Oct 2022 10:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221019150333.1047423-1-pgonda@google.com> <528937ab-8046-d5d1-26ff-50ef35f5635f@amd.com>
In-Reply-To: <528937ab-8046-d5d1-26ff-50ef35f5635f@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 19 Oct 2022 11:40:18 -0600
Message-ID: <CAMkAt6ritG1zmOreh9WYLYAGww0EJQy+m-Y0nfxD5+gpTkpJ1w@mail.gmail.com>
Subject: Re: [PATCH] virt: Prevent AES-GCM IV reuse in SNP guest driver
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@suse.de>, Michael Roth <michael.roth@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Dionna Glaze <dionnaglaze@google.com>
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

On Wed, Oct 19, 2022 at 11:03 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/19/22 10:03, Peter Gonda wrote:
> > The ASP and an SNP guest use a series of AES-GCM keys called VMPCKs to
> > communicate securely with each other. The IV to this scheme is a
> > sequence number that both the ASP and the guest track. Currently this
> > sequence number in a guest request must exactly match the sequence
> > number tracked by the ASP. This means that if the guest sees an error
> > from the host during a request it can only retry that exact request or
> > disable the VMPCK to prevent an IV reuse. AES-GCM cannot tolerate IV
> > reuse see:
> > https://csrc.nist.gov/csrc/media/projects/block-cipher-techniques/documents/bcm/comments/800-38-series-drafts/gcm/joux_comments.pdf
>
> I wonder if we can at least still support the extended report length query
> by having the kernel allocate the required pages when the error is
> SNP_GUEST_REQ_INVALID_LEN and retry the exact request again. If there are
> no errors on the second request, the sequence numbers can be safely
> updated, but the kernel returns the original error (which will provide the
> caller with the number of pages required).

I think we can but I thought fixing the security bug could come first,
then the usability fix after. Dionna was planning on working on that
fix.

In that flow how does userspace get the data? Its called the ioctl
with not enough output buffer space. What if the userspace calls the
ioctl with no buffers space allocated, so its trying to query the
length. We just send the host the request without any encrypted data.

>
> For the rate-limiting patch series [1], the rate-limiting will have to be
> performed within the kernel, while the mutex is held, and then retry the
> exact request again. Otherwise, that error will require disabling the
> VMPCK. Either that, or the hypervisor must provide the rate limiting.
>
> Thoughts?
>
> [1] https://lore.kernel.org/lkml/20221013160040.2858732-1-dionnaglaze@google.com/

Yes I think if the host rate limits the guest. The guest kernel should
retry the exact message. Which mutex are you referring too?
