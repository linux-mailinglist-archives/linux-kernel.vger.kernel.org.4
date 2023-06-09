Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14C729685
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjFIKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjFIKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2859D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686304860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0n8/D5gSrVbcAskz0QgbStZ+qE9a1Ww6ORHIZhs/gc=;
        b=PgMiccRqL79Lb4ge9uoYcOxMYdeILtQXD7y0dU1A9F8vOTUID/8c3/RyxASiCIwqSuGZJB
        Y6k7fzXBNOhxVRWcvoguV67i8teGFXmL66pVvqqYy3Ga5inHbTgRPONSCS9v2FlqayOG+V
        rpncxhKsRySbF9Qlyg9sLgU4fqQ169A=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-op3wBjmnOOytQ9Il1aTeiQ-1; Fri, 09 Jun 2023 06:00:52 -0400
X-MC-Unique: op3wBjmnOOytQ9Il1aTeiQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b0116fef51so4084085ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304852; x=1688896852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0n8/D5gSrVbcAskz0QgbStZ+qE9a1Ww6ORHIZhs/gc=;
        b=JIlwKc/PxKG62UWWjYvbtjoWR7SVdxGajbiVbpwqBsUSIR+aDd94sqBG2u1wrI+yeW
         1YddAFe8wRljgcFsLopUZMnCAACxk0bYG77/UYNj+XuWu/tFTLdh6aEM+XbgBWdBM/nq
         KPEMI9bCDq8uIjRYPsuIdnDePC4HOYJQz59I7YZJ/z/wgst00NjEpBaPXIBKDYNG+dWn
         1oAKQC7lWKFIg4ndrLvjBy6NGP8mxlkBH3e5q5aHTZJVgQAleUU238s5tp2b7hKkVxz7
         nb7y9Ytc7BS8GB3aQ63yFH4ahp+YVTIabw1yGzPAji1j7CnmxEa/Ad+2tv8i+i+svjhX
         It5A==
X-Gm-Message-State: AC+VfDxluXRGvoPAzABxpyhVBO1JoKmAJtKTliZ4CHRtt7o8TG8W0eEs
        TK0s0INYZTlvHD1EgQFnNHC2mNXECtrmchBMZD8SvHkUislmAI/3zuJqj9qJw9ca0H/wAZ7hkNS
        b7D/KyKFttByCr6i3du23Gskq
X-Received: by 2002:a17:902:b194:b0:1b0:74f5:bf10 with SMTP id s20-20020a170902b19400b001b074f5bf10mr468749plr.65.1686304851826;
        Fri, 09 Jun 2023 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4D79t5gV/Mp/rSDmH1GlwdJpW+EfHN7X7D7bUurjaZ92cyqHMbXsDdD5+zEeKB48041JGjYg==
X-Received: by 2002:a17:902:b194:b0:1b0:74f5:bf10 with SMTP id s20-20020a170902b19400b001b074f5bf10mr468730plr.65.1686304851467;
        Fri, 09 Jun 2023 03:00:51 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b001b034faf49csm1437300plb.285.2023.06.09.03.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:00:50 -0700 (PDT)
Date:   Fri, 9 Jun 2023 17:58:11 +0800
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
        Dave Young <dyoung@redhat.com>,
        Ondrej Kozina <okozina@redhat.com>
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <mmvghlh7pdleopnkwu3mmqlc4etqjs3rmjwfgh2grbys5icehj@2ifbkc2a6ot5>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
 <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
 <a5eaa21d-6551-5857-98cd-50578fe59566@gmail.com>
 <oosx274kf6kzasncdfdg5a53ut6wey3nlnbho5x3rql2df3zep@c6r6m4whphvh>
 <88581a3c-8bd3-f7b2-064c-c809a2152ed3@gmail.com>
 <maamg4udo7visvgzp4m4qkfcds6djyiga236lb2mwtjasi6pvj@zmqzb2lijegj>
 <f7a1a20c-bee8-c7a4-4c49-b66415f556f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f7a1a20c-bee8-c7a4-4c49-b66415f556f9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:39:26PM +0200, Milan Broz wrote:
>On 6/7/23 14:39, Coiby Xu wrote:
>...
>>>I do not think you need any cryptsetup patches, all you need is to write
>>>decrypted volume key from LUKS metadata with
>>>  cryptsetup luksDump ---dump-volume-key -volume-key-file <out> <device>
>>>(or any code equivalent with libcryptsetup), am I correct?
>>
>>Correct me if I'm wrong, but I don't think there will be a safer way to
>>preserve key without patching cryptsetup. Actually the --dump-volume-key
>>approach has been proposed before and I agree with your conclusion [1]
>>on that approach i.e. "passing volume key this way is quite insecure".
>>Without patching cryptsetup, even if I save the volume key in the memory
>>reserved for the kdump kernel, I need to retrieve this key in the
>>userspace to unlock the LUKS device which may lead to quite a security
>>vulnerability.
>
>Hm, where are the patches for cryptsetup, then? I am afraid we do not want
>to add such specific things there.

Thanks for cleaning up the text to make the discussion easier! Sorry I
only mentioned it [3] in the cover letter and didn't provide one in
previous reply. [3] was done in a quick-and-dirty way (I plan to send a
formal merge request after finishing the kernel part) and there is no need
to read it. Let's me explain what [3] does here instead,
  1) After unlocking the LUKS-encrypted device, if cryptsetup finds
     /sys/kernel/crash_luks_volume_key exists, it will write the key
     description of the volume key to it to notify the kernel to save a copy
     of this logon key linked to its thread keyring for the kdump kernel
  2) After the 1st kernel crashes, if crytpsetup finds it's in the kdump
     kernel, instead of deriving the volume key from a passphrase, it
     will write the key description to /sys/kernel/crash_luks_volume_key
     to ask the kdump kernel to link the saved key to its thread keyring.

[3] https://gitlab.com/coxu/cryptsetup/-/commit/750a46d933fac82e0c994b5c41de40a0b8cac647

>
>But we are just going to merge a patchset that changes how we use keyring
>where you can tell cryptsetup to store/link key under some specific name
>and to specific keyring
>(see https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/492)
>(Please talk to Red Hat cryptsetup maintainers for more info,
>I just mentioned this mail to them today.)

Thanks for pointing me to the above MR which looks promising! Unlike
treating the kdump use case as a special case [3], it just provides a
generic way with the implemented options --link-vk-to-keyring and
--volume-key-keyring.

>
>>I respect the efforts from you and the cryptsetup community to make LUKS
>>as secure as possible. And kdump is used in product environment. Kdump
>>is to a server as a black box is to an aircraft. So by no means I want
>>to reverse the used security measures and patching cryptsetup can allow
>>to keep the security measures. One concern raised by you against "FRC
>>v1" was a copy of the LUKS volume key for the kdump kernel creates an
>>attack vector. I took this feedback seriously and have sought advice
>>from my colleagues to implement the countermeasures ([PATCH 1/5] and
>>[Patch 4/5]).
>>
>>[1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
>
>Yes, I appreciate that. And it is perfectly ok if your customers accept
>the trade-off and security risk of handling the key this way.
>
>Anyway, I feel we are going in circles here, and as it seems to be my fault,
>I do not want to sound grumpy as I am perhaps missing some context.

Actually I should thank you for your patience! You have been always
offering your feedback on this work kindly and promptly starting with
the first proposed solution [1].

>
>Could you please talk to internal RH cryptsetup maintainers first and discuss
>your solution? They know what we can do here can help to find an acceptable
>solution. (I added cc to Ondra.)

Sure, I'll talk to them first. Thanks for letting Ondra know!

>
>Thanks,
>Milan
>

-- 
Best regards,
Coiby

