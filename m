Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10382744C2A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 06:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGBEHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 00:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGBEHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 00:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B82E68
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 21:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688270791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXJ7opQPuDL8XwIJEwpiNXqfyVRii49Tl3quJqNExu8=;
        b=QjOZbBHvBalf6KnEXaQt4csXVLU9GXwGyt+nAiVuL8if/fVu4hEiq8umcYOEjlG7AuHJky
        4dnPfJyXD9PhcRNRwbElrbh6qXAJEPV5ME6POvpd8q4EsIW26gxSa4AciaoarAZ9GYoD9h
        PCxM0tscq8VLHsNXyrQ4Swp6E7IcJgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-WOXosJquPkmtE2z8ZbgGZg-1; Sun, 02 Jul 2023 00:06:27 -0400
X-MC-Unique: WOXosJquPkmtE2z8ZbgGZg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C03CF810BB4;
        Sun,  2 Jul 2023 04:06:24 +0000 (UTC)
Received: from localhost (ovpn-12-126.pek2.redhat.com [10.72.12.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD03492B02;
        Sun,  2 Jul 2023 04:06:23 +0000 (UTC)
Date:   Sun, 2 Jul 2023 12:06:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org
Subject: Re: [PATCH -next v5 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Message-ID: <ZKD3tEBknEiF4PZK@MiWiFi-R3L-srv>
References: <20230511085139.1039088-1-chenjiahao16@huawei.com>
 <20230511085139.1039088-2-chenjiahao16@huawei.com>
 <ZHwKFADVXyNYJBCp@MiWiFi-R3L-srv>
 <852b8777-3c6e-f76b-0413-1c66629f33cd@huawei.com>
 <5c80666c-e6e2-8fa6-50b6-89536315925e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c80666c-e6e2-8fa6-50b6-89536315925e@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/23 at 05:51pm, chenjiahao (C) wrote:
...... 
> I have sent v6 patches, implementing the logic above. That fixes the
> retrying
> 
> logic and should be aligned with Arm64 code.

Hmm, it has improved much, while there's still issue which need be
fixed. You missed the case that crsahkernel low is specified as zero
explicitly. Obviously your v6 is not able to handle that well. Means
your v6 is not aligned with the current arm64 code completely.

crashkernel=xM,high crashkernel=0M,low

> 
> 
> Please let me know if there is any problem remains.

Earlier, I posted below RFC patchset to try to unify the
crashkernel=,high support on x86, arm64 and risc-v, the generic arch.
Wondering what you think about it. risc-v can be added in with very few
change to get the crahskernel=,high support.

[RFC PATCH 0/4] kdump: add generic functions to simplify crashkernel crashkernel in architecture

Surely, the crashkernel=,high support can be added independently in
advance. Later my patchset can unify them and remove the duplicated code
in risc-v. It's up to you and risc-v maintainers/reivewers to take one.
Anyway, I will add comment to your v6 to point out the issue.

Thanks
Baoquan

