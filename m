Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B5564E1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLOTWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C222B25
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671132124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vp2bThwHIB6WQ0sb6fAkdMYsQig9ewPh2eMzT18STEE=;
        b=FCV/x8uAH9cmmPoWX+V4FfQS28WMr1GzE7GDWqSWmk9bOw9xLpmrXMoCho3fsNcR0k4+Og
        92R0UfrCRbnmIrpzLswtnppLsDzo1zDkRCL7dGU5fkYTZPL+EJkNuVsSi1Fq4uAHhuV46m
        RQxisuHbQe2R9aqA662L4rJvEoWhXMI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-Tis-Ll8mOVWIKyKvvNlgBQ-1; Thu, 15 Dec 2022 14:22:00 -0500
X-MC-Unique: Tis-Ll8mOVWIKyKvvNlgBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CF501C07828;
        Thu, 15 Dec 2022 19:21:59 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DB9C40C2064;
        Thu, 15 Dec 2022 19:21:58 +0000 (UTC)
Date:   Thu, 15 Dec 2022 14:21:55 -0500
From:   Peter Jones <pjones@redhat.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 00/26] x86_64: Improvements at compressed kernel stage
Message-ID: <20221215192154.fuu47gsultcqd3wh@redhat.com>
References: <cover.1671098103.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1671098103.git.baskov@ispras.ru>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 03:37:51PM +0300, Evgeniy Baskov wrote:
> This patchset is aimed
> * to improve UEFI compatibility of compressed kernel code for x86_64
> * to setup proper memory access attributes for code and rodata sections
> * to implement W^X protection policy throughout the whole execution 
>   of compressed kernel for EFISTUB code path. 

Hi Evgeniy,

Aside from some minor patch fuzz in patch 6 due to building this in
today's Fedora rawhide kernel rather than mainline, this patch set works
for me.

Thanks!

-- 
        Peter

