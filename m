Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14215FF4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJNU60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJNU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:58:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B8B44AC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:58:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z20so5802570plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huPp57ub9lRRha6PEidm00aaAsQprniPiZAF3tUi1Ug=;
        b=NJ4dkUgM0+QHetFSzyitOuTnmYkKVFwGLKGbOMCR2HPUhjWHUKbyVpmskF7fEGl0/u
         oBsGZDH4Sk5/XX+CRkq3IsN7cWzkr1gZD9ZPzIYXW8XnupXoicQAaq0323Rz633R57bR
         PZ5Co7E84ouPZWtTKqKPXfgkWYRoh0TDNoVz+VfP1HPr9HCeXN3vk58HWQduPqID4Q/2
         uaasNt0Om51jXvE5+QlYSU8xkDpzYLdTbuY9Yz78Tt496NrC+ZIG9Cb9Xum/183Xzvrg
         FuE0ITSv2c9BgQRl6bzTASyUBqEvycTvUPETDU/+Cr4mgy+N4phqjucd7KD5SVscTgsG
         cVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huPp57ub9lRRha6PEidm00aaAsQprniPiZAF3tUi1Ug=;
        b=2wSWyqrsJIPA/ZCwe/NFmeMDCKW2qJa/zI5bwX6IWVHjqczogZav/8d2xUJpDEMj0F
         tiXuBuTuG+xsDSQhA8R5V9VRJPjfi06QDZFhCYiX3Lx8Y9Kd3hnE5u7rlRXEZZ0iTf9R
         SZJ1+6+wWwv5U4D6TkEBvwHC6fP+Jc2qLpc1fSFWS8da34wmgPNCJkG0g34l33JGL42K
         NZunwfLsbfYTcKlURzZg4QvMp7OfQNdiUaXPL0EdxSDbyItD9p3bxBE+ySifCma82xCb
         deKdVS/1kMytRshc/L9D3+LiTmRv5Vuq7+oQihKlbVc0AYiQ+UxByzjAwwFz16zUU8By
         A2bQ==
X-Gm-Message-State: ACrzQf1LGSBaz0noomF3Mkoka/HqIBdgpt1VMwdGLtzCvXZg9rSiJY8/
        lVtnl6Z+QQDzDH/eVfpatEM=
X-Google-Smtp-Source: AMsMyM7EzaJLedNnQbiGc6n6Dyc4wWrCyXSHx0ym9WC6w4H2Lf6l352d9OjcakaXBrpfReUXh58+qA==
X-Received: by 2002:a17:903:2686:b0:17e:f177:3ec with SMTP id jf6-20020a170903268600b0017ef17703ecmr7269376plb.71.1665781100579;
        Fri, 14 Oct 2022 13:58:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79481000000b00560af825c13sm2234598pfk.91.2022.10.14.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:58:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Oct 2022 13:58:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/17] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
Message-ID: <20221014205818.GA1428667@roeck-us.net>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-11-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817101826.236819-11-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 17, 2022 at 07:18:19PM +0900, Hyeonggon Yoo wrote:
> There is not much benefit for serving large objects in kmalloc().
> Let's pass large requests to page allocator like SLUB for better
> maintenance of common code.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

This patch results in a WARNING backtrace in all mips and sparc64
emulations.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at mm/slab_common.c:729 kmalloc_slab+0xc0/0xdc
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-11990-g9c9155a3509a #1
Stack : ffffffff 801b2a18 80dd0000 00000004 00000000 00000000 81023cd4 00000000
        81040000 811a9930 81040000 8104a628 81101833 00000001 81023c78 00000000
        00000000 00000000 80f5d858 81023b98 00000001 00000023 00000000 ffffffff
        00000000 00000064 00000002 81040000 81040000 00000001 80f5d858 000002d9
        00000000 00000000 80000000 80002000 00000000 00000000 00000000 00000000
        ...
Call Trace:
[<8010a2bc>] show_stack+0x38/0x118
[<80cf5f7c>] dump_stack_lvl+0xac/0x104
[<80130d7c>] __warn+0xe0/0x224
[<80cdba5c>] warn_slowpath_fmt+0x64/0xb8
[<8028c058>] kmalloc_slab+0xc0/0xdc

irq event stamp: 0
hardirqs last  enabled at (0): [<00000000>] 0x0
hardirqs last disabled at (0): [<00000000>] 0x0
softirqs last  enabled at (0): [<00000000>] 0x0
softirqs last disabled at (0): [<00000000>] 0x0
---[ end trace 0000000000000000 ]---

Guenter
