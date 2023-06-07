Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4919725FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbjFGMmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbjFGMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C88F2122
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686141653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oT2y53ulYulPm7eYD4DjOZtoHv5XIt/WJdWLVzd0fzQ=;
        b=eGfw9V0ST/VfMxZ9bBxK0kxgOv+cm9aXC1iB9s3cjo+KkRYHExKFyMLuXBX2bwTChfseXe
        R4w5M7vD5TdB2gMV8IeI+COUoonsjPbTPuvLkTV/xhzIV9brckbhNqfCkd6zoJ9d19VObt
        JZuWJGVJKOEDdjrhEDm9GtHPaao0Jos=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-6lqIiZpMOsGDBsZjKdkHrQ-1; Wed, 07 Jun 2023 08:40:52 -0400
X-MC-Unique: 6lqIiZpMOsGDBsZjKdkHrQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b04600cac6so25970955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686141651; x=1688733651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT2y53ulYulPm7eYD4DjOZtoHv5XIt/WJdWLVzd0fzQ=;
        b=Ajgbr983lpsWIC/P3ixR1RW5Eito12WK+YBYuroRFFNO5vgH6fd/iyofeuG5O5jT7I
         g6TyEeyhyduJB10b4IqY2HZgll43gxxhANE8ZXFlbg+uR0uIuzl+ekz3vqDrU7YzhnRm
         8bJZA0I0NOu3zzs5SEisVwefVFaNs04lI+p7YWThtEc4/C3Rdv5FkazsP2y37JroTj1W
         MstMOFALq7qAhWmLbVSMEbYgPT2dp4+doOu3446C+vBwMf6Q4m+hxh+mmm8eu5MZi+Nt
         rc3Cm73QegDm5tGyF0h0ENcVMBti5TPVY6XI/5Z4uS4drIymhl0i60bX0ZNJfl4wFBLi
         ez+g==
X-Gm-Message-State: AC+VfDyNpUfGQJhk/xJsWmiyMkYKKv/CJn40aVYNNt54clPjEacWkZiE
        Z/+r/DbH06oQRu/KlLD5XRxLrfpZ1oGJF+QNwqwpFZiiWEydjBE3X2HLIbVmfF02Y5zhXPGigY0
        50lbyCTo6HjkMGgMulpQ9Ym+R
X-Received: by 2002:a17:902:db0c:b0:1b2:43a2:f2d with SMTP id m12-20020a170902db0c00b001b243a20f2dmr1491481plx.32.1686141651537;
        Wed, 07 Jun 2023 05:40:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WvWyXbPR8N3R/UFeTjYGCxTiv7+FaAuP9pTiCykGOIlpyziaDB0cvh9McEZlbMXXGNjIn1w==
X-Received: by 2002:a17:902:db0c:b0:1b2:43a2:f2d with SMTP id m12-20020a170902db0c00b001b243a20f2dmr1491467plx.32.1686141651162;
        Wed, 07 Jun 2023 05:40:51 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001b21bcea439sm5160378plh.170.2023.06.07.05.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:40:50 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:39:56 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, x86@kernel.org,
        dm-devel@redhat.com, Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kairui Song <ryncsn@gmail.com>,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <maamg4udo7visvgzp4m4qkfcds6djyiga236lb2mwtjasi6pvj@zmqzb2lijegj>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
 <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
 <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
 <88581a3c-8bd3-f7b2-064c-c809a2152ed3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <88581a3c-8bd3-f7b2-064c-c809a2152ed3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:14:44AM +0200, Milan Broz wrote:
>On 6/6/23 13:02, Coiby Xu wrote:
>>On Mon, Jun 05, 2023 at 09:09:49AM +0200, Milan Broz wrote:
>>>On 6/5/23 04:31, Coiby Xu wrote:
>>>>Hi Eric and Milan,
>>>>
>>>>On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>>>>>On 6/2/23 23:34, Eric Biggers wrote:
>>>>>>On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>>>>>[PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>>>>>
>>>>>>The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>>>>>happens to use.  But LUKS is a userspace concept.
>>>>>>
>>>>>>This is a kernel patchset, so why does it make sense for it to be talking about
>>>>>>LUKS at all?  Perhaps you mean dm-crypt?
>>>>>
>>>>>Exactly.
>>>>
>>>>Thanks for raising the above concern! The use cases like CoreOS and
>>>>Confidential VMs explicitly want kdump to work for LUKS. And correct me
>>>>if I'm wrong, I think the two problems addressed by this patch set only
>>>>apply to LUKS so the kdump part of the kernel only cares about the LUKS
>>>>case. If there are use cases where similar approach is needed, I'll be
>>>>happy to make the solution more generic.
>>>>
>>>>>
>>>>>I had the same comment almost a year ago... and it still applies:
>>>>>https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>>>>>
>>>>>Anyway, please fix the naming before this patchset can be read or reviewed!
>>>>>
>>>>>LUKS is user-space key management only (on-disk metadata); the kernel has
>>>>>no idea how the key is derived or what LUKS is - dm-crypt only knows the key
>>>>>(either through keyring or directly in the mapping table).
>>>>>
>>>>>Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
>>>>>is used in many other mappings (plain, bitlocker, veracrypt, ...)
>>>>>Just use the dm-crypt key, do not reference LUKS at all.
>>>>
>>>>Thanks for the reminding! That comment was on the first RFC version. But
>>>>starting with "RFC v2", there is no longer any interaction with dm-crypt
>>>>(to save a copy of the LUKS volume key for the kdump kernel) and now I
>>>>make cryptsetup talks to the kdump part of the kernel via the sysfs to
>>>>reuse the volume key. So only the kdump part of the kernel needs to know
>>>>LUKS which is what it cares. Thus I don't think there is any kernel
>>>>namespace pollution now.
>>>
>>>Hi,
>>>
>>>I am sorry if I did understand correctly, but I thought that kdump is part
>>>of the kernel.
>>
>>Yes, there is the kernel part of the kdump although there is also the
>>userspace part to make the feature complete:)
>>
>>>
>>>I am trying to say that kernel generally has no concept of LUKS;
>>>this is a userspace abstraction for key management.
>>>
>>>Even the cryptsetup dm-crypt configuration mapping table generated from LUKS
>>>has nothing LUKS special in it (only in DM-UUID as a name prefix).
>>>
>>>So I do not understand why you need to mention LUKS even in kdump part.
>>>Perhaps it is still only a naming problem, nothing more.
>>>
>>>All you need is to preserve key and configuration parameters (for dm-crypt).
>>>If it is set by cryptsetup, dmsetup, or any other way is not important - on this
>>>kernel layer, it has nothing to do with LUKS key management metadata.
>>>
>>>No problem if you support only LUKS in userspace, but really, all this machinery
>>>should work for any dm-crypt devices. Perhaps your patch even works for it already.
>>
>>Thanks for the explanation! After reflecting on your words for some
>>time, I realize I had an implicit assumption. I assumed is if I use a
>>name like dm_crypt_key instead of luks_volume_key, I need to support all
>>mappings like plain, bitlocker, veracrypt as mentioned by you and this
>>could mean much more efforts. So I'm not motivated to do that as
>>currently users only request kdump to work for LUKS.
>
>Thanks, I think it is perfectly fine to implement just subset here.
>
[...]
>
>My comment was just about proper naming in kernel, it is of course up to you
>what you want to support in userspace (and even in kernel, extensions can
>be added later).

Thanks for the confirmation!

>
>Only LUKS2 uses keyring for volume key in dm-crypt as default option anyway.

Thanks for the info!

>I do not think you need any cryptsetup patches, all you need is to write
>decrypted volume key from LUKS metadata with
>  cryptsetup luksDump ---dump-volume-key -volume-key-file <out> <device>
>(or any code equivalent with libcryptsetup), am I correct?

Correct me if I'm wrong, but I don't think there will be a safer way to
preserve key without patching cryptsetup. Actually the --dump-volume-key
approach has been proposed before and I agree with your conclusion [1]
on that approach i.e. "passing volume key this way is quite insecure".
Without patching cryptsetup, even if I save the volume key in the memory
reserved for the kdump kernel, I need to retrieve this key in the
userspace to unlock the LUKS device which may lead to quite a security
vulnerability.

I respect the efforts from you and the cryptsetup community to make LUKS
as secure as possible. And kdump is used in product environment. Kdump
is to a server as a black box is to an aircraft. So by no means I want
to reverse the used security measures and patching cryptsetup can allow
to keep the security measures. One concern raised by you against "FRC
v1" was a copy of the LUKS volume key for the kdump kernel creates an
attack vector. I took this feedback seriously and have sought advice
from my colleagues to implement the countermeasures ([PATCH 1/5] and
[Patch 4/5]).

[1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/


>
>Milan
>

-- 
Best regards,
Coiby

