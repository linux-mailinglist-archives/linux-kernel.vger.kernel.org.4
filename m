Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAF362D37F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiKQGbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiKQGbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10730F70
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668666641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77jIXkhrtwqKo94Wqd6nfY0jOcIj75IUYbToBjS3apo=;
        b=WWU1RpARVrD6uUtA+Z7kSccVQx+mBbhZPiTe5qWDWe8mjGwbNrsTqcwgpUNqjr5hzwqlQU
        3V9sqLmNvsKFINufAfjaWcNPv9kZFHEU7VSfBqcYZ6odBzG/37vHEZYsf9WaJgzl4UFSf9
        dhfqgqp7yn4fLyPQwjhZdzLUI0thphw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-CRrwlddmPzefAxow6mk3fw-1; Thu, 17 Nov 2022 01:30:39 -0500
X-MC-Unique: CRrwlddmPzefAxow6mk3fw-1
Received: by mail-qt1-f198.google.com with SMTP id b20-20020ac844d4000000b003a542f9de3dso893211qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77jIXkhrtwqKo94Wqd6nfY0jOcIj75IUYbToBjS3apo=;
        b=R+XxtqMe0dfSTuiuzkw2Da9rigvdZq16DefYqxGycaYUNu5OB69+fhul0M+K7a4rT7
         2BZm2skWiKsITWOM3uvEjBCnptAvdM7QAEFHU7bEGC0cbEeJEW/gH16f58R1DXEhNfmT
         UeNMrY5OpCmIotP0CGuRK7SWtazmMZw1WVeLHlj8cA0VWVmhmEZTPHqPBonPfmHHLfF6
         lE2JBio7Pgmbb1vUp4NBmlIXDB7u1xdIsDmKnfOF3etCX1hBDqhHYu7ZuXEaqbi2yZuE
         /RNdF409o7wsPNOH/yDF5ffEXvxN+/ETdeTvMxSx4PQ4Psaa2LDFF7DKbVx2z43OdxeV
         8Alg==
X-Gm-Message-State: ANoB5pkIEwGgLodwCELgk9lxHS219NzQ2qN5LHeM6N6dnaJTSyjnfl5d
        AyQXUQAShS4LX+jlq7ugsL8WCo9RXgqs9QnV+3U6kJOmvTjLYaqFZndM6pLTmW+o5j3e63z8Vzf
        CYfOO57hFHzBPGB0th5I4QvKdxdafxHse5Mq4XISu
X-Received: by 2002:a05:6214:5bc2:b0:4c6:5a5f:3068 with SMTP id lr2-20020a0562145bc200b004c65a5f3068mr1218584qvb.118.1668666639151;
        Wed, 16 Nov 2022 22:30:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6C0NFFwpUf6eJNDIZ7Qj/qK3H0M5BCwZM/qzII1WUKiMwE5KDMGj+97/7zqhN2WQwm0YJgcpGI4ay2jU99BPM=
X-Received: by 2002:a05:6214:5bc2:b0:4c6:5a5f:3068 with SMTP id
 lr2-20020a0562145bc200b004c65a5f3068mr1218566qvb.118.1668666638872; Wed, 16
 Nov 2022 22:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20221028132640.2791026-1-jsavitz@redhat.com> <20221108163124.a54f932f8f79f9c1d6e63903@linux-foundation.org>
 <CAL1p7m7Ar_DBbpLWuha8dPYKU3FjS6NyAROBa_PO6NKRgfuGxQ@mail.gmail.com>
In-Reply-To: <CAL1p7m7Ar_DBbpLWuha8dPYKU3FjS6NyAROBa_PO6NKRgfuGxQ@mail.gmail.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 17 Nov 2022 02:30:23 -0400
Message-ID: <CAL1p7m4BDXZug0cscQ2Oa3n-JNcDx60zE2NH9-_2GHNmE-=vwQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] selftests/vm: calculate variables in correct order
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 8:09 PM Joel Savitz <jsavitz@redhat.com> wrote:
>
> On Tue, Nov 8, 2022 at 8:31 PM Andrew Morton <akpm@linux-foundation.org> =
wrote:
>>
>> On Fri, 28 Oct 2022 09:26:40 -0400 Joel Savitz <jsavitz@redhat.com> wrot=
e:
>>
>> > commit b5ba705c2608 ("selftests/vm: enable running select groups of te=
sts")
>> > unintentionally reversed the ordering of some of the lines of
>> > run_vmtests.sh that calculate values based on system configuration.
>> > Importantly, $hpgsize_MB is determined from $hpgsize_KB, but this late=
r
>> > value is not read from /proc/meminfo until later, causing userfaultfd
>> > tests to incorrectly fail since $half_ufd_size_MB will always be 0.
>> >
>> > Switch these statements around into proper order to fix the invocation
>> > of the userfaultfd tests that use $half_ufd_size_MB.
>>
>> Does this fix address the failure in
>> https://lkml.kernel.org/r/202211021026.61b267d1-yujie.liu@intel.com?
>>
>> Thanks.
>>
>
> I have tried to reproduce this failure on a couple of different systems b=
efore and after the application of this commit but I haven't had any succes=
s in doing so. I suspect that there was some sort of hugepage configuration=
 issue on the test system but I'd have to look into it more to be sure.
>
> However, I noticed that on the mm-everything branch, the hugepage-mmap te=
st fails:
>
> # ./run_vmtests.sh -t "hugetlb"
> running: ./hugepage-mmap
> -----------------------
> running ./hugepage-mmap
> -----------------------
> Open failed: No such file or directory
> [FAIL]
> ...
>
> It appears this is due to commit 0796c7b8be84 ("selftests/vm: drop mnt po=
int for hugetlb in run_vmtests.sh")
> as the test still replies on the ./huge mountpoint removed in that commit=
. The test passes before that patchset is applied.
>
> Additionally, I just noticed an extraneous 'echo "running: $1"' line in r=
un_test(), the effects of which are seen above, and I have just sent a patc=
h to remove it.
>
> Joel

Resending this reply since it appears a bit of HTML slipped into the
last reply and it got rejected by the lists.

