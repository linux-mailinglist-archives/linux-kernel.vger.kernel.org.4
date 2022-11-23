Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0312636794
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiKWRsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbiKWRsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:48:33 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7347F4508E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:48:30 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2ANHjdir771802
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 23 Nov 2022 09:45:40 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2ANHjdir771802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022110601; t=1669225541;
        bh=jtj6JpuZ522eL3b5dimnaNA+G3sxlclUD8CtOBUwzQs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=nei3CGr6hBezKQFAGiWug2HJc7SbBOIj+F3RCNaLx5OAk6C45ZZgwRQReoqJxEzcI
         S+EJGAD5IgjUKOpbq0y/lTusc+gCkjrolmE5Jj963qjQR0S9cLWUpiC/aQ9fsSGG5B
         ghPpzZNmknHHcWxSiXDp20yq0apw/ITdheyvUm+GExqDKhGoSMdFVZEq5CNVZeXEKb
         Y+tdWXKGLeCZzCMy4rIuNDBx9DKAzMkMYMfFy9blYDIaTcCRW6m47rJEopLyvPkuxR
         poNSRKXlKjg2mN2snaaHmBfEqwnJcowxORh8dM/MNDCj3I5pSoMdjA354DfRIR95ih
         x8okpSFVhM6xg==
Date:   Wed, 23 Nov 2022 09:45:37 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>, Petr Pavlu <petr.pavlu@suse.com>
CC:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, nicolas@fjasle.eu, masahiroy@kernel.org,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        michael.roth@amd.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
User-Agent: K-9 Mail for Android
In-Reply-To: <Y35CNdPVwq11NCYN@zn.tnic>
References: <20220927084632.14531-1-petr.pavlu@suse.com> <Y34SXeU6JEk+UGfV@zn.tnic> <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com> <Y35CNdPVwq11NCYN@zn.tnic>
Message-ID: <7DA74EEE-45F1-4F84-807A-3C04551DF6F4@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 23, 2022 7:54:29 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote=
:
>On Wed, Nov 23, 2022 at 04:43:20PM +0100, Petr Pavlu wrote:
>> The only post-link analysis tool in this case should be arch/x86/tools/=
relocs=2E
>> It produces a vmlinux=2Erelocs file which is appended to vmlinux=2Ebin=
=2E This is
>> all internal to the Linux build=2E I'm not aware of any external toolin=
g, such
>> as kernel debuggers, that would require this relocation information in
>> vmlinux=2E
>
>It would be good to know why --emit-relocs was added in the first place
>- that might give us a hint=2E Lemme talk to Micha=2E
>
>> The size command used in your example includes only allocatable code, d=
ata and
>> bss sections=2E It does not show size of any relocation sections=2E
>
>This:
>
>361M vmlinux=2Ebefore
>361M vmlinux=2Eafter
>
>is simple ls output=2E
>
>Maybe I need something else enabled in my =2Econfig which would show this
>significant difference *and* *explain* it=2E
>
>Thx=2E
>

The real question is: why does anyone care about the size of the vmlinux f=
ile specifically?
