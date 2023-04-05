Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D536D7943
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjDEKHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbjDEKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6671BD0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680689169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QtxKCZQq9P6gn2grmwTtfOWjbfdkBo+gZpF7sZrBSXo=;
        b=b2W/2Dlwi1r5J9mP8B82GRV9KqfjJBuYdZSMtbTlJp6qq3VB6lTENlLJDeqQIe0mNw3kUf
        eMxDtDgIXJ51bW6nEPSV6GmJ47mL347YrL0543C9xm76IFiXoqfBWKvDroOn6cVrtZJFV1
        YFg95cqAMLDGB3nK0CBwZVng3ZpMo7M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-mMkzMFZ3NGWUO3hz9QkDEw-1; Wed, 05 Apr 2023 06:06:08 -0400
X-MC-Unique: mMkzMFZ3NGWUO3hz9QkDEw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 509DE280AA22;
        Wed,  5 Apr 2023 10:06:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF4CE400F4F;
        Wed,  5 Apr 2023 10:06:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 958C31800097; Wed,  5 Apr 2023 12:06:05 +0200 (CEST)
Date:   Wed, 5 Apr 2023 12:06:05 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <ts3dltyfxkchkop3y6uenz34bghyg2phwmlxxbigxi3b7nzy3d@b7a6a57ogpm2>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
 <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
 <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> User will specify if it wants unaccepted memory or not for the VM. And if
> it does it is his responsibility to have kernel that supports it.
> 
> And you have not addressed my question:
> 
> 	How is it different from any other feature the kernel is not [yet] aware
> 	of?

Come on.  Automatic feature negotiation is standard procedure in many
places.  It's not like we inventing something totally new here.

Just one example:  When a virtio device learns a new trick a feature flag
is added for it, and in case both guest and host support it it can be
enabled, otherwise not.  There is no need for the user to configure the
virtio device features manually according to the capabilities of the
kernel it is going to boot.

take care,
  Gerd

