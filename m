Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882968B46D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBFDTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBFDTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4A12041
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675653513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HUnXR7sTsl7YLdib1oIsNCKOxnTEFsrq4tcNXVLT5m4=;
        b=KxfnIFax/ix7/eaFqrKY0vP/0ojgpbCYLEGoUAdkBP1d10M27S5kz8rrTnPeg1JUCMpYlE
        UToYvSIGStE60cDD3+/IW2wvXcGHsYhcDQa4oPnvW6gNjkBINAn0HrHH2d7eRMpUD1Cd8c
        kpGbOEYdqAosydDH0o7MJIi/vNsnees=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-ayUrbw4-Pbev7ewDVubn2Q-1; Sun, 05 Feb 2023 22:18:32 -0500
X-MC-Unique: ayUrbw4-Pbev7ewDVubn2Q-1
Received: by mail-qt1-f199.google.com with SMTP id hf20-20020a05622a609400b003abcad051d2so5718622qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 19:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUnXR7sTsl7YLdib1oIsNCKOxnTEFsrq4tcNXVLT5m4=;
        b=tWx40KIQUBywy5Qr8goXVYhjl5aOJQjws96WSg3HQS3sv15ZMJxLT+EeG95nsRJl9h
         6OeL4XASZ9kTklFo442u8fa8EX5w4mgWY24mXPS3hj7pKFCraFfYKnkbPwocMG8ZeDs6
         U3kYqYAUhzR0JTwt+hBAb7vuqsv9o0y/BT/NxT8js762iVf0IVh5x4AnC2D+ViT/8zKJ
         xhYJgxtcXI7AMZDhLncx9GCR8hXy9AcRwQP3pWDkkvTgdOOD0Yv/RNWuarp+Xu6jdckE
         DADuaw/Ugkx9yUvFRFLKFOuHuoesmqKZ/TMa8CbrRT3i0BHQNmYZ69OVcd7LidPxpCcD
         un/w==
X-Gm-Message-State: AO0yUKXRkBwuXZ7Np7oULX829joAA2fO4MQYuknXNRuI0X7Xjnf5VDgt
        OVx2zrpSjICTfonHJxXch16dl4oOJ0e38J9R85GCwtfzKWWdk2iGa4Atb1gTlmrl70qyAkjvf61
        pxYP2gU2qnjtnDjhqNeWhkutc
X-Received: by 2002:a05:622a:17c4:b0:3b8:5199:f841 with SMTP id u4-20020a05622a17c400b003b85199f841mr33929529qtk.0.1675653512189;
        Sun, 05 Feb 2023 19:18:32 -0800 (PST)
X-Google-Smtp-Source: AK7set/cpAGW2ESxNhYZ0jEVuvvuRs8ZuhdHof+3DnmWont85g1bLMGsUjVwGkO9KhDgbxDFzB1GTQ==
X-Received: by 2002:a05:622a:17c4:b0:3b8:5199:f841 with SMTP id u4-20020a05622a17c400b003b85199f841mr33929514qtk.0.1675653511960;
        Sun, 05 Feb 2023 19:18:31 -0800 (PST)
Received: from xz-m1.local (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b6-20020a379906000000b007186c9e167esm6574425qke.52.2023.02.05.19.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 19:18:31 -0800 (PST)
Date:   Sun, 5 Feb 2023 22:18:30 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/arch: Fix a few collide definition on private use
 of VM_FAULT_*
Message-ID: <Y+BxhuGUx1K+3XHb@xz-m1.local>
References: <20230205231704.909536-1-peterx@redhat.com>
 <Y+BFjQDBIFq5ih+t@casper.infradead.org>
 <Y+BPy3jFcHqOnWL0@x1n>
 <Y+BrJhxeJbAp49QE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+BrJhxeJbAp49QE@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:51:18AM +0000, Matthew Wilcox wrote:
> That wasn't what I meant.  I meant putting VM_FAULT_BADMAP and
> VM_FAULT_SIGSEGV in mm_types.h.  Not having "Here is a range of reserved
> arch private ones".

VM_FAULT_SIGSEGV is there already; I assume you meant adding them all
directly into vm_fault_reason.

Then I don't think it's a good idea..

Currently vm_fault_reason is a clear interface for handle_mm_fault() for
not only arch pffault handlers but also soft faults like GUP.

If handle_mm_fault() doesn't return VM_FAULT_BADMAP at all, I don't think
we should have it as public API at all.  When arch1 people reading the
VM_FAULT_ documents, it shouldn't care about some fault reason that only
happens with arch2.  Gup shouldn't care about it either.

Logically a new page fault handler should handle all the retval of
vm_fault_reason afaiu.  That shouldn't include e.g. VM_FAULT_BADMAP either.

Thanks,

-- 
Peter Xu

