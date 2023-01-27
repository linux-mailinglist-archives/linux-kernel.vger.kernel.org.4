Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2476267EC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjA0RUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjA0RUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D737F0F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674839955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PmxGa44W6isfjTBSzVfP/UwTsDElhnXKEsXbjHCdyrI=;
        b=f1lM0cibFvxPY1WIaJ6Xu4Gwya7xRlem0Emj4MA9Y/f1GiswNa2kFuMGe5O6fffJy78lcf
        1lK2hZ0l3IjJwmLe2RN1eW8mb0VKsh6MNyvXtBSrPx4jyCpFk+mRLdUXIudMXwgIWeD3Td
        vDC/iYg7blNCSGdDqSBiaum7u29n0M4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-cKByCxfcM6qrhVEvjKlT6A-1; Fri, 27 Jan 2023 12:06:00 -0500
X-MC-Unique: cKByCxfcM6qrhVEvjKlT6A-1
Received: by mail-qk1-f200.google.com with SMTP id bp33-20020a05620a45a100b007090e2e1b0cso3344523qkb.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmxGa44W6isfjTBSzVfP/UwTsDElhnXKEsXbjHCdyrI=;
        b=2fC8Z1EjP9gTSZQtvD6uQ9a1iAKWfC/1jszHjJltN4pIdLITFtD8X4V+CaSEEwhnaw
         QmPrpyU1GB1D/RuhPnqeg9yUSDklubZUU8v0Io86b8AxkE1x2Q/65oje2lu0iOL9uLIz
         +F0o3TstIYnHHkXCj+SzjfyItxRW5VKhpoFzEI0Jp+oKP2FNJX9wDk4OLfHgAJmdy9LU
         wE/O1jTZadcYKSwShAxNhhGOoNR6v+o1SAS7iUMgObayhKsbOzsRA/OvFzchqTWMwXsf
         fJpjrIo2Bw0z8dA5w7en6HJiWEM1WD6zvogDJMZAAAnplhhWe0mKlrqXdW/sTG9qCgOv
         Xw9Q==
X-Gm-Message-State: AFqh2koj108XvchSIer8izFDwA44GRcNo7gGNGFIU+iFG7B2cBAh7WKK
        LB3c0zsTEWoS151xDEfO/q2dieFMRpPOf+5gGLBHigRXVPDYmLPqjed6ggB9URSUJ4CmhJQkxVA
        qZeAX2c7Y8TgD/Jlyg1ZurnqH
X-Received: by 2002:a05:622a:598b:b0:3a9:8f6c:2d7c with SMTP id gb11-20020a05622a598b00b003a98f6c2d7cmr63120112qtb.52.1674839160386;
        Fri, 27 Jan 2023 09:06:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsBuMR76qCD9iNhA3MG7zbleHxGuuO1yl2hlMrlf18HF044I6aiUQq824mIaMRnIi9g+mEKbA==
X-Received: by 2002:a05:622a:598b:b0:3a9:8f6c:2d7c with SMTP id gb11-20020a05622a598b00b003a98f6c2d7cmr63120073qtb.52.1674839160145;
        Fri, 27 Jan 2023 09:06:00 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x20-20020ac84a14000000b00399fe4aac3esm2949817qtq.50.2023.01.27.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:05:59 -0800 (PST)
Date:   Fri, 27 Jan 2023 12:05:57 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 2/4] userfaultfd: split mwriteprotect_range()
Message-ID: <Y9QEdbkZxOJ10oEJ@x1n>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124084323.1363825-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 01:43:21PM +0500, Muhammad Usama Anjum wrote:
> Split mwriteprotect_range() to create a unlocked version. This
> will be used in the next patch to write protect a memory area.
> Add a helper function, wp_range_async() as well.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

IIUC this patch is not needed.  You have a stable vma, so I think you can
directly use uffd_wp_range(), while most of the mwriteprotect_range() is
not needed.

There's one trivial detail of ignoring userfaultfd_ctx->mmap_changing when
it's set to true, but I don't think it applies here either because it was
used to resolve a problem in uffd non-cooperative mode on the predictable
behavior of events, here I don't think it matters a lot either.

-- 
Peter Xu

