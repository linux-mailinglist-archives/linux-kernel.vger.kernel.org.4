Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE9E6D968B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjDFL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbjDFL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CBCC01
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680781989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hYu6beRr7Ncw3h1cfQofNH9KOL1VzFTX2Sp4LLx77mM=;
        b=C0sI28Axi/fLT4B9E4iRQNGkCrVHRJZk/WVCG8Fb87t9aDUOrmByEB1CQ9l6ORudghy3Dz
        yfh79UWsdgeUEqgPW4kjd6iMhk9BNwXr+/XnNKP++HV0ZuDCItybtc/tkCJ+TkN9uS8m8h
        TEgE6u7WnQ9W1GOBP5tVGU4ymBrHOws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-WnaSA1slOL2hfGK6Oe5gpA-1; Thu, 06 Apr 2023 07:42:04 -0400
X-MC-Unique: WnaSA1slOL2hfGK6Oe5gpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30F033C0F37F;
        Thu,  6 Apr 2023 11:42:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 993E014171BC;
        Thu,  6 Apr 2023 11:42:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C77F61800081; Thu,  6 Apr 2023 13:42:00 +0200 (CEST)
Date:   Thu, 6 Apr 2023 13:42:00 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 02/27] x86/build: Remove RWX sections and align on 4KB
Message-ID: <x244aglrxdjgudpkp5uwnbsft5vorgvmztqlnrwdiiobyj5srx@3ewfdpiuatkq>
References: <cover.1678785672.git.baskov@ispras.ru>
 <edf3afbdcd87cb6c61815068084ac6de35be15a2.1678785672.git.baskov@ispras.ru>
 <20230405174059.GEZC2yq9WiXFsICyEy@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405174059.GEZC2yq9WiXFsICyEy@fat_crate.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> > Currently paging is disabled in x86_32 in compressed kernel, so
> > protection is not applied anyways, but .init code was incorrectly
> > placed in non-executable ".data" segment. This should not change
> > anything meaningful in memory layout now, but might be required in case
> > memory protection will also be implemented in compressed kernel for
> > x86_32.
> 
> I highly doubt that - no one cares about 32-bit x86 anymore.

Indeed.  ia32 edk2 runs without paging even in latest tianocore/edk2,
and I don't expect that to change until ia32 support gets removed.

take care,
  Gerd

