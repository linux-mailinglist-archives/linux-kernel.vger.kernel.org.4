Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD96D819C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbjDEPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjDEPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C41CA9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680707997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sP3ul0odyvb2mCxSTYifjSPJm8m8FyTTzYRYBcyYYsU=;
        b=byPnQY5NxjBxRQ4qWJDta9S4zdh6IjOwLEZvZOgk66ncieLHWRZ4fFmKOby2gJDCeHh2po
        1V8vBC+Sz7fmDndTiTxK5hjlQX26MZ/VUdIxrUiBQf571YdM6gaEjUfCLsMiQ9gV4X+rjl
        F+JUpYgUxsDpQBijNYjK1zJYg9toNQg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-XbUbz9JMP4iwdbqC1xi7Ng-1; Wed, 05 Apr 2023 11:19:56 -0400
X-MC-Unique: XbUbz9JMP4iwdbqC1xi7Ng-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b003ef79f2c207so11756641wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707995;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sP3ul0odyvb2mCxSTYifjSPJm8m8FyTTzYRYBcyYYsU=;
        b=c5IbBdSb9Or8MqSIL06xsyt6y4GbzAGxCG4YB0PaKhDallKxHIXn0z7MPpO1K+69JT
         RR+5QFOq+UDvmEhRY2ss9tUdB7udv64+b3YtzUrddEsCrlNfY1dsbUg0OPiptO0xo/hJ
         481iaArVf+aP251KVVkIeMNSRyiyIolRRSfup1ZjWuJRGOXPKkf+MsZQ6AZrwzvWiTOH
         jBl7FQhSczhVEs9QURwpa/KuhQsrcbQXuWk67wcCnl0s86Vt9ejKsLCvoPR7V3Cl3ufp
         mP5hp5YFw7d0JQpMJ6CcogolGfOkrXBwyhiTG7BRjDY9arWawZBsDeYk6YApNHOzJhBD
         KPjQ==
X-Gm-Message-State: AAQBX9fthOUzUkNK2Oqy6IpOIdiCUusvy3bf71atMfGke+ePX9CngfKJ
        jy6LlVItjAr5B9+VbvpGqbr8Dy1w1spV6o54/J+UyVo9xCb+9W3DIpoJcZGOuhvzF7aXgPhhNTz
        syzMiAV55zXdaeqBiIOuLQtCsvVhHu5Sa
X-Received: by 2002:a7b:ca55:0:b0:3ef:61f6:d7be with SMTP id m21-20020a7bca55000000b003ef61f6d7bemr4736290wml.35.1680707995686;
        Wed, 05 Apr 2023 08:19:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350a6WlwnNCK1QLahaR/cn/GyO30yMuujWhbya6puttlOjaiWGNXYX1j7RlGQxC+KYu05S5dlnw==
X-Received: by 2002:a7b:ca55:0:b0:3ef:61f6:d7be with SMTP id m21-20020a7bca55000000b003ef61f6d7bemr4736271wml.35.1680707995356;
        Wed, 05 Apr 2023 08:19:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003ee443bf0c7sm2533724wms.16.2023.04.05.08.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:19:54 -0700 (PDT)
Message-ID: <f7b33f02-9f2e-2f33-2656-0f02e39c844b@redhat.com>
Date:   Wed, 5 Apr 2023 17:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 0/2] mm/userfaultfd: fix and cleanup for migration
 entries with uffd-wp
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20230405142535.493854-1-david@redhat.com> <ZC2REi+NkyjZyyzq@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZC2REi+NkyjZyyzq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.23 17:17, Peter Xu wrote:
> On Wed, Apr 05, 2023 at 04:25:33PM +0200, David Hildenbrand wrote:
>> One fix (I have a simple reproducer but it's too long to paste it into
>> the commit)
> 
> I hope the recent rework of the unit test can help having more of these
> unit tests into the kselftests directly.
> 
> Currently it's still ugly even after the rework patchset - we'll need to
> reference e.g. area_dst in unit tests for the allocated memory region (with
> specified type of either MEM_ANON, MEM_SHMEM, ...), but there's plan to
> make it even better.

Yes, I refrained from messing with the selftest for now while you rework
Here is the hacky reproducer:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <stdint.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>
#include <linux/userfaultfd.h>
#include <linux/mempolicy.h>

static int uffd;
static int pagemap_fd;
static size_t pagesize;

static uint64_t pagemap_get_entry(int fd, char *start)
{
	const unsigned long pfn = (unsigned long)start / pagesize;
	uint64_t entry;
	int ret;

	ret = pread(fd, &entry, sizeof(entry), pfn * sizeof(entry));
	if (ret != sizeof(entry)) {
		fprintf(stderr, "pread() failed\n");
		exit(1);
	}

	return entry;
}

#define BIT_ULL(nr)                   (1ULL << (nr))
#define PM_UFFD_WP                    BIT_ULL(57)
#define PM_SWAP                       BIT_ULL(62)
#define PM_PRESENT                    BIT_ULL(63)

static bool pagemap_is_uffd_wp(int fd, char *start)
{
	uint64_t entry = pagemap_get_entry(fd, start);

	return entry & PM_UFFD_WP;
}

static bool pagemap_is_populated(int fd, char *start)
{
	uint64_t entry = pagemap_get_entry(fd, start);

	return entry & (PM_SWAP | PM_PRESENT);
}

static int setup_uffd(char *mem, size_t size)
{
	struct uffdio_api uffdio_api;
	struct uffdio_register uffdio_register;
	struct uffdio_range uffd_range;

	uffd = syscall(__NR_userfaultfd,
		       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
	if (uffd < 0) {
		fprintf(stderr, "syscall() failed: %d\n", errno);
		return -errno;
	}

	uffdio_api.api = UFFD_API;
	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
		fprintf(stderr, "UFFDIO_API failed: %d\n", errno);
		return -errno;
	}

	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
		fprintf(stderr, "UFFD_FEATURE_PAGEFAULT_FLAG_WP missing\n");
		return -ENOSYS;
	}

	/* Register UFFD-WP */
	uffdio_register.range.start = (unsigned long) mem;
	uffdio_register.range.len = size;
	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
		fprintf(stderr, "UFFDIO_REGISTER failed: %d\n", errno);
		return -errno;
	}

	return 0;
}

int main(int argc, char **argv)
{
	struct uffdio_writeprotect uffd_writeprotect;
	const size_t thpsize = 2 * 1024 * 1024;
	const size_t mmap_size = 2 * thpsize;
	char *mem;

	pagesize = getpagesize();
	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
	if (pagemap_fd < 0) {
		fprintf(stderr, "open() failed\n");
		exit(1);
	}

	mem = mmap(NULL, mmap_size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON,
		   -1, 0);
	if (mem == MAP_FAILED) {
		fprintf(stderr, "mmap() failed\n");
		return -errno;
	}
	mem = (char *)(((uintptr_t)mem + thpsize) & ~(thpsize - 1));

	if (madvise(mem, thpsize, MADV_HUGEPAGE)) {
		fprintf(stderr, "MADV_HUGEPAGE failed\n");
		return -errno;
	}

	/* Populate a THP. */
	memset(mem, 0, pagesize);

	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
		fprintf(stderr, "Did not get a THP populated\n");
		return -EBUSY;
	}

	/* Verify uffd-wp is not set. */
	if (pagemap_is_uffd_wp(pagemap_fd, mem)) {
		fprintf(stderr, "uffd-wp unexpectedly set\n");
		return -1;
	}

	/* Setup UFFD and protect the page. */
	if (setup_uffd(mem, thpsize))
		return 1;
	uffd_writeprotect.range.start = (unsigned long) mem;
	uffd_writeprotect.range.len = thpsize;
	uffd_writeprotect.mode = UFFDIO_WRITEPROTECT_MODE_WP;
	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &uffd_writeprotect)) {
		fprintf(stderr, "UFFDIO_WRITEPROTECT failed: %d\n", errno);
		return -errno;
	}

	/* Verify uffd-wp is set. */
	if (!pagemap_is_uffd_wp(pagemap_fd, mem)) {
		fprintf(stderr, "uffd-wp not set\n");
		return -1;
	}

	/* Migrate the THP. */
	if (syscall(__NR_mbind, mem, thpsize, MPOL_LOCAL, NULL, 0x7fful,
		    MPOL_MF_MOVE)) {
		fprintf(stderr, "mbind() failed\n");
		return -errno;
	}

	/* Verify uffd-wp is still set. */
	if (!pagemap_is_uffd_wp(pagemap_fd, mem)) {
		fprintf(stderr, "uffd-wp lost\n");
		return -1;
	}

	return 0;
}

-- 
Thanks,

David / dhildenb

