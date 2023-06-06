Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552D5724076
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjFFLEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjFFLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0CF10E7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686049413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PECCGAhd7teBhoQVIkKkQ0gCChVRirWpXr8QC6vVa88=;
        b=b54OKLEvK+NAKPBFsc68Rt9vnMKHqjavlIlPotac5n4rfG3L44+lqKxG4+YdXL4PJ5MeWl
        zwr4jpXEti/IS3kJLg9BM2+3LAs7KL4fv2/sJdIXUxLNCUmBm1KlSeMgvwCBRvb6N7VONr
        JQ8cLo7mHtapx4quGhZ6yy/0kTpWLP8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-wqq9HCkiP4Ocnasu7kqNKg-1; Tue, 06 Jun 2023 07:03:32 -0400
X-MC-Unique: wqq9HCkiP4Ocnasu7kqNKg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5400b72fcb0so1704844a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049411; x=1688641411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PECCGAhd7teBhoQVIkKkQ0gCChVRirWpXr8QC6vVa88=;
        b=AaJdsfUHRfMU65y3BJLWNl7Lz+3nptzS9IeOLVEX8YiNcDEl3P5rYa+EGQvhu9bgsF
         Dpr1OFQ/HpTWxvyGq2xK/LwWSOolOAyHTyJoiIDT25NsKILwSwyYEjZ/HbAWCjxcSo0N
         zSJ4S/gkgAxpzaVURN6/smBwFEDiWrPgaB+o/25dHVmj+M9sOnGiM7TWt4Xj36w1/pQK
         s38TrkQ2Ee4lRULXbDrLX06GDy4c4+czOPsbKzf3bhGV1tRLKlN9I8v+a2OKsWjd0rsW
         EJ7IZkBELqUcuyoTgDsJdD7I8YZv0Uy+oQYzXRozs0l/gK7cDi2qFcwstvju98sd/VGh
         9mEQ==
X-Gm-Message-State: AC+VfDypsIBC1sOlr3+8UADN8E+lTRLcA79zEaDiZmdmTtTo159ELT5H
        UWd70icj648E8OEaRLtuRjoqiciTX1hMVj+X9kgKFC7kV8Fk9tlYJcPiiDcLk7L6BttJn4dcFrs
        JkSe5zoVWaduwf73dNEj7um7q
X-Received: by 2002:a17:90a:cb8f:b0:24e:2e86:5465 with SMTP id a15-20020a17090acb8f00b0024e2e865465mr244070pju.31.1686049411621;
        Tue, 06 Jun 2023 04:03:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Ut1fWyiC1Sxe/ag4hpzoFeyDmazttp0G3bC8zYvg1LgXcS3Mz6lzRVYGA5vny7y9WWqUGuQ==
X-Received: by 2002:a17:90a:cb8f:b0:24e:2e86:5465 with SMTP id a15-20020a17090acb8f00b0024e2e865465mr244050pju.31.1686049411302;
        Tue, 06 Jun 2023 04:03:31 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l3-20020a6542c3000000b005307501cfe4sm6611337pgp.44.2023.06.06.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:03:30 -0700 (PDT)
Date:   Tue, 6 Jun 2023 19:02:19 +0800
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
Message-ID: <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
 <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:09:49AM +0200, Milan Broz wrote:
>On 6/5/23 04:31, Coiby Xu wrote:
>>Hi Eric and Milan,
>>
>>On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>>>On 6/2/23 23:34, Eric Biggers wrote:
>>>>On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>>>[PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>>>
>>>>The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>>>happens to use.  But LUKS is a userspace concept.
>>>>
>>>>This is a kernel patchset, so why does it make sense for it to be talking about
>>>>LUKS at all?  Perhaps you mean dm-crypt?
>>>
>>>Exactly.
>>
>>Thanks for raising the above concern! The use cases like CoreOS and
>>Confidential VMs explicitly want kdump to work for LUKS. And correct me
>>if I'm wrong, I think the two problems addressed by this patch set only
>>apply to LUKS so the kdump part of the kernel only cares about the LUKS
>>case. If there are use cases where similar approach is needed, I'll be
>>happy to make the solution more generic.
>>
>>>
>>>I had the same comment almost a year ago... and it still applies:
>>>https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>>>
>>>Anyway, please fix the naming before this patchset can be read or reviewed!
>>>
>>>LUKS is user-space key management only (on-disk metadata); the kernel has
>>>no idea how the key is derived or what LUKS is - dm-crypt only knows the key
>>>(either through keyring or directly in the mapping table).
>>>
>>>Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
>>>is used in many other mappings (plain, bitlocker, veracrypt, ...)
>>>Just use the dm-crypt key, do not reference LUKS at all.
>>
>>Thanks for the reminding! That comment was on the first RFC version. But
>>starting with "RFC v2", there is no longer any interaction with dm-crypt
>>(to save a copy of the LUKS volume key for the kdump kernel) and now I
>>make cryptsetup talks to the kdump part of the kernel via the sysfs to
>>reuse the volume key. So only the kdump part of the kernel needs to know
>>LUKS which is what it cares. Thus I don't think there is any kernel
>>namespace pollution now.
>
>Hi,
>
>I am sorry if I did understand correctly, but I thought that kdump is part
>of the kernel.

Yes, there is the kernel part of the kdump although there is also the
userspace part to make the feature complete:)

>
>I am trying to say that kernel generally has no concept of LUKS;
>this is a userspace abstraction for key management.
>
>Even the cryptsetup dm-crypt configuration mapping table generated from LUKS
>has nothing LUKS special in it (only in DM-UUID as a name prefix).
>
>So I do not understand why you need to mention LUKS even in kdump part.
>Perhaps it is still only a naming problem, nothing more.
>
>All you need is to preserve key and configuration parameters (for dm-crypt).
>If it is set by cryptsetup, dmsetup, or any other way is not important - on this
>kernel layer, it has nothing to do with LUKS key management metadata.
>
>No problem if you support only LUKS in userspace, but really, all this machinery
>should work for any dm-crypt devices. Perhaps your patch even works for it already.

Thanks for the explanation! After reflecting on your words for some
time, I realize I had an implicit assumption. I assumed is if I use a
name like dm_crypt_key instead of luks_volume_key, I need to support all
mappings like plain, bitlocker, veracrypt as mentioned by you and this
could mean much more efforts. So I'm not motivated to do that as
currently users only request kdump to work for LUKS.  

But maybe I can divide the efforts into the kernel part and userspace
part. For the kernel part, almost no effort is needed since only
renaming is needed as pointed out by you. For the userpace part, maybe
it's OK to support preserving key only for LUKS2 in cryptsetup as hinted
by your last paragraph? Does it look good to you from the viewpoint of
the maintainer of cryptsetup?

>
>Milan
>

-- 
Best regards,
Coiby

