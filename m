Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23E367A018
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjAXRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjAXRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:24:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826904ABC4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:24:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w11so3775798edv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/+3NAYprDTW47i27HV9DulbYQse6ygZBWyRvZB/rMmI=;
        b=jEC6Nh/tqAlOs1YSTJNTXawYL4iplyAKQ1+Ox77YL1oC20Gva7XXE/Nbwtdz0oUPCr
         RBKgbklB98Enb4CV5xtJRIxa+qXd8APCNjwyxJNju5qeFnTu5WF7O3eTdBJY+hsGjJPt
         MfMym4mNOSSdUQfVGR05sXZklkKIoCKtRHJewTaZaR+U/J1xvWL6sAwds55BpqH7vUCy
         DiU9CBQaip5bMm6Ng1ZSBuDfbBXex87btI61gTquUR9Mb33rm3RAPz72pGYcAaO4nkaF
         hBOS/mf2O4EwwrrcEsV4ILl779me2oIKsBLWKz/c1oOsKu4D73+AkVSlsbfY+q7kFMlk
         014A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+3NAYprDTW47i27HV9DulbYQse6ygZBWyRvZB/rMmI=;
        b=PBKqON/39HGzkGqVvj9pJUCgEsXKsW+Nw0xb2dHadsw6o1P03sex/MdciXHn474Mo/
         l4sjECkDs3yGlCvhyjbqYqhVWMUEcdsi7cJ/xQ8+nFAy2rdtdw0kNZn78dflq2MNFUE6
         56QtaXIByn+uV0WH/cotcbP8JmKXHnd0PJwKBWW+oKD6T7kw5QKTsw5QfuewtIplSzRT
         wrrUfKo89mf+5FTpYEFrUmwq29RC521t/9Om/9sy6cAiHJW1wDtxeXJM5vEwQaTSlTf6
         V+4aZosJLfm0Z5Wyt8TSapOkMV2ddNMllvtrCUqqz8cudZXLiwu+RrByKaodUEHDW1/F
         afCw==
X-Gm-Message-State: AFqh2kqcCsmdczvceQ4Dr9Q1NdCD8R3wjToNBxuul1OgjpZol6MtQ0+O
        q7u54Lg6lmc2iKqmHZZrYtArbiFFns2Me7kkEy4hBQ==
X-Google-Smtp-Source: AMrXdXs0A3a5ilJtJ5xoFKD38+amPLcQxUPH0fh0heymyKAbeGes5xoRUhQlkI7DyCA8Tf0NryPdXu/+2kcDTPfP6e8=
X-Received: by 2002:aa7:c681:0:b0:461:e3f2:38bc with SMTP id
 n1-20020aa7c681000000b00461e3f238bcmr3847518edq.149.1674581061787; Tue, 24
 Jan 2023 09:24:21 -0800 (PST)
MIME-Version: 1.0
From:   Julien Bachmann <jbachmann@google.com>
Date:   Tue, 24 Jan 2023 18:24:10 +0100
Message-ID: <CAB_p7=joH8PxzkMfVxs2Gd_BefF1_H9Vd3rvP0iaEwGAM0DpeA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
To:     thomas.lendacky@amd.com
Cc:     David.Kaplan@amd.com, axboe@fb.com, hch@lst.de, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>, sagi@grimberg.me,
        Tom Roeder <tmroeder@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 12/02/20 07:31 PM, Tom Lendacky wrote:
> On 11/30/20 12:50 PM, Tom Roeder wrote:
>> On Fri, Nov 20, 2020 at 09:02:43AM +0100, Christoph Hellwig wrote:
>>> On Thu, Nov 19, 2020 at 05:27:37PM -0800, Tom Roeder wrote:
>>>> This patch changes the NVMe PCI implementation to cache host_mem_descs
>>>> in non-DMA memory instead of depending on descriptors stored in DMA
>>>> memory. This change is needed under the malicious-hypervisor threat
>>>> model assumed by the AMD SEV and Intel TDX architectures, which encryp=
t
>>>> guest memory to make it unreadable. Some versions of these architectur=
es
>>>> also make it cryptographically hard to modify guest memory without
>>>> detection.
>>>
>>> I don't think this is a useful threat model, and I've not seen a
>>> discussion on lkml where we had any discussion on this kind of threat
>>> model either.
>>
>> Thanks for the feedback and apologies for the lack of context.
>>
>> I was under the impression that support for AMD SEV SNP will start showi=
ng
>> up in KVM soon, and my understanding of SNP is that it implies this thre=
at
>> model for the guest. See the patchset for SEV-ES, which is the generatio=
n
>> before SNP:
>> https://lkml.org/lkml/2020/9/14/1168.> This doesn't get quite to the SNP=
 threat model, but it starts to assume
>> more maliciousness on the part of the hypervisor.
>>
>> You can also see the talk from David Kaplan of AMD from the 2019 Linux
>> Security Summit for info about SNP:
>> https://www.youtube.com/watch?v=3Dyr56SaJ_0QI.
>>
>>
>>>
>>> Before you start sending patches that regress optimizations in various
>>> drivers (and there will be lots with this model) we need to have a
>>> broader discussion first.
>>
>> I've added Tom Lendacky and David Kaplan from AMD on the thread now, sin=
ce
>> I don't think I have enough context to say where this discussion should
>> take place or the degree to which they think it has or hasn't.
>>
>> Tom, David: can you please comment on this?
>
> Any discussion should certainly take place in the open on the mailing
> lists.
>
> Further information on SEV-SNP can be found on the SEV developer web page
> at https://developer.amd.com/sev.
>
> There is a white paper specific to SNP:
>   https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isol=
ation-with-integrity-protection-and-more.pdf
>
> Also, volume 2 of the AMD APM provides further information on the various
> SEV features (sections 15.34 to 15.36):
>   https://www.amd.com/system/files/TechDocs/24593.pdf
>
> It is a good idea to go through the various drivers and promote changes
> to provide protection from a malicious hypervisor, but, as Christoph
> states, it needs to be discussed in order to determine the best approach.

Following up on this thread as Confidential Computing (CC) gained more
popularity over the last 2 years. The host-to-guest threat model for
CC is more researched and discussed (e.g. Hardening Linux guest kernel
for CC at the Linux Plumbers Conference 2022 [1]).

Has a more general discussion on this threat model happened on the
lkml since then? Cloud providers, chip makers and academic researchers
[2] patched multiple drivers for host-to-guest vulnerabilities
following research.

>>> And HMB support, which is for low-end consumer devices that are usually
>>> not directly assigned to VMs aren't a good starting point for this.
>>
>> I'm glad to hear that this case doesn't apply directly to cases we would
>> care about for assignment to guests. I'm not very familiar with this
>> codebase, unfortunately. Do the same kinds of issues apply for the kinds
>> of devices that would be assigned to guests?

I=E2=80=99m also not familiar with this codebase but would it be possible f=
or
a malicious hypervisor to send a crafted vendor_id or device_id to
reach this code upon kernel=E2=80=99s PCI probing?

Would the patch now be acceptable with the development of CC or do you
see updates that should be made?

Let me know what you think and what would be the preferred next steps.

Best regards

[1] https://lpc.events/event/16/contributions/1328/
[2] Examples of research and patches
- https://arxiv.org/pdf/2109.10660.pdf
- https://lore.kernel.org/linux-hyperv/20201117105437.xbyjrs4m7garb2lj@liuw=
e-devbox-debian-v2/T/#t
- https://github.com/torvalds/linux/commit/5218e919c8d06279884aa0baf76778a6=
817d5b93
