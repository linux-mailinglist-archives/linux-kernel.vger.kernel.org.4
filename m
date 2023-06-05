Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917AE721C0E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjFECgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 22:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFECgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 22:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C3BC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685932549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbOf9YixGxYUT6+A1F/Xkspb+6fjMJ6LMndsBADdRu0=;
        b=X9fPnY6QuYlfnuwZVkm43WcOvojkXroneVn4RCcILdCT4Kb6P8hiaXcGnSV76njpiLStGM
        ioXahzelPmRo9F2de7c0fUVF0w9o4A18s4goG04Qh0q6hjGw7CIX0DyOFSh3RbdnSw8r4K
        jAecy2BJ5qz3NDZw+0PhfEXdvituecc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-3RDO53A0NCCJE1bqbY_Ywg-1; Sun, 04 Jun 2023 22:35:48 -0400
X-MC-Unique: 3RDO53A0NCCJE1bqbY_Ywg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b03ae23eacso39843025ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 19:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685932547; x=1688524547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbOf9YixGxYUT6+A1F/Xkspb+6fjMJ6LMndsBADdRu0=;
        b=fY5NzWihbxMWw/dQUj4iM5lkZMOR/OIRF5asSqsPmnCGpJyT5hXV44kKgPrAT36Xvb
         +Y6sjRU7ruyyucz0KZ+OrbIvruy0IDeCPA9TYtjx1+A/pQxTkozrUZZO9GgWjq9JAeEM
         nbftF5yruZWcKwSruRYqi7zGdfFxGiQCgwaUcTJhYp7teb0B/htbkVaZWPWR9JUjX0AE
         DQFcdTaTm19zde0oEt0ip+8AxCvOGbcSfw0f1bJOxJDMY8m3GlnMeblF0f3IfD5KqiE5
         nzYMDDpNwNU1z0aGmQVQLu/IY/AMk2pNkqB3H3Gxt7PSmt8KAm3K7vRw7VTqvo+cRrYh
         qjkw==
X-Gm-Message-State: AC+VfDwSVStmNPUNU7A+/kWCSUZLjzTvb9bIuITz5C+KAL+2eL2fkhZD
        MBVTxzPUb9vcYFqWMu+rL1ejRPokt9tpbS5omwixfNCfqKC/Nr2hMk5mIcOJ/lN6y0tAzaiP2JZ
        Ie8SR8CxVIzsnDDTgQ+9yPP/S
X-Received: by 2002:a17:902:c20d:b0:1a9:b0a3:f03a with SMTP id 13-20020a170902c20d00b001a9b0a3f03amr5828596pll.9.1685932546968;
        Sun, 04 Jun 2023 19:35:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RPcaCQNdS4CeYjKEEsiTHolnzKdcAYpiF586LtFjStL6H4T9gcjFxgb0r6IqczKNCCCAZmw==
X-Received: by 2002:a17:902:c20d:b0:1a9:b0a3:f03a with SMTP id 13-20020a170902c20d00b001a9b0a3f03amr5828575pll.9.1685932546645;
        Sun, 04 Jun 2023 19:35:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001b05e97ee09sm5218208pll.283.2023.06.04.19.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 19:35:46 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:31:49 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Milan Broz <gmazyland@gmail.com>
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, dm-devel@redhat.com,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kairui Song <ryncsn@gmail.com>,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <36mz3gn764ceadfbuhhmoo2zaiqmzplpkdcnszha2hzhmb3i62@sm6hilxryzk4>
References: <20230601072444.2033855-1-coxu@redhat.com>
 <20230602213452.GC628@quark.localdomain>
 <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f569a35a-bff9-9dbb-2ded-7e02ee060a9a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric and Milan,

On Sat, Jun 03, 2023 at 11:22:52AM +0200, Milan Broz wrote:
>On 6/2/23 23:34, Eric Biggers wrote:
>>On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
>>>[PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
>>
>>The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
>>happens to use.  But LUKS is a userspace concept.
>>
>>This is a kernel patchset, so why does it make sense for it to be talking about
>>LUKS at all?  Perhaps you mean dm-crypt?
>
>Exactly.

Thanks for raising the above concern! The use cases like CoreOS and
Confidential VMs explicitly want kdump to work for LUKS. And correct me
if I'm wrong, I think the two problems addressed by this patch set only
apply to LUKS so the kdump part of the kernel only cares about the LUKS
case. If there are use cases where similar approach is needed, I'll be
happy to make the solution more generic.

>
>I had the same comment almost a year ago... and it still applies:
>https://lore.kernel.org/all/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
>
> Anyway, please fix the naming before this patchset can be read or reviewed!
>
> LUKS is user-space key management only (on-disk metadata); the kernel has
> no idea how the key is derived or what LUKS is - dm-crypt only knows the key
> (either through keyring or directly in the mapping table).
>
> Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
> is used in many other mappings (plain, bitlocker, veracrypt, ...)
> Just use the dm-crypt key, do not reference LUKS at all.

Thanks for the reminding! That comment was on the first RFC version. But
starting with "RFC v2", there is no longer any interaction with dm-crypt
(to save a copy of the LUKS volume key for the kdump kernel) and now I
make cryptsetup talks to the kdump part of the kernel via the sysfs to
reuse the volume key. So only the kdump part of the kernel needs to know
LUKS which is what it cares. Thus I don't think there is any kernel
namespace pollution now.

>
>Milan
>

-- 
Best regards,
Coiby

