Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0D6589F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiL2Hbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiL2Hbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:31:53 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A7C9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:31:52 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BT7VXCx843333
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 28 Dec 2022 23:31:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BT7VXCx843333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672299094;
        bh=P9B3uTyi8J6q0aKf9lvY9XtgOYfhraMemSVXlke1pIA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=WfW98zlmWRjat8XXY4YvCjtF2d0PV7rT+SdB96ndtnnoBKwdX/tOa6eLa2EkWSCRK
         CCoyD+laiIIWUgeKHqKq0hci7eRSLMbWMIvFPu/ORqu2BN2rzjDC/UrC4Vl27UnFF2
         TfrHoxxZ9RlyCJj294k97ulX28VeCqKDS3ixu0/enFvWSugbhiLsn42XFGuruY/avT
         iZrDcFkjXqWp6YyulCn2HLcEHcM2yz588rfzBo1CcoqIcfs94nTckFPzMha5gzOAI5
         s1MlB6P/10I00c2tN1uf+XIpAGM7w8dJufC2sQUTKSqgV8MYvAaB44ddsY3vJm6qIa
         wJCmDBVAceroA==
Date:   Wed, 28 Dec 2022 23:31:34 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de, philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_qemu=5D_x86=3A_don=27t_let_decomp?= =?US-ASCII?Q?ressed_kernel_image_clobber_setup=5Fdata?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y6z765zHrQ6Rl/0o@zx2c4.com>
References: <20221228143831.396245-1-Jason@zx2c4.com> <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org> <Y6xvJheSYC83voCZ@zx2c4.com> <Y6x1knb8udpSyMSp@zx2c4.com> <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com> <Y6z765zHrQ6Rl/0o@zx2c4.com>
Message-ID: <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
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

On December 28, 2022 6:31:07 PM PST, "Jason A=2E Donenfeld" <Jason@zx2c4=2E=
com> wrote:
>Hi,
>
>Read this message in a fixed width text editor with a lot of columns=2E
>
>On Wed, Dec 28, 2022 at 03:58:12PM -0800, H=2E Peter Anvin wrote:
>> Glad you asked=2E
>>=20
>> So the kernel load addresses are parameterized in the kernel image
>> setup header=2E One of the things that are so parameterized are the siz=
e
>> and possible realignment of the kernel image in memory=2E
>>=20
>> I'm very confused where you are getting the 64 MB number from=2E There
>> should not be any such limitation=2E
>
>Currently, QEMU appends it to the kernel image, not to the initramfs as
>you suggest below=2E So, that winds up looking, currently, like:
>
>          kernel image            setup_data
>   |--------------------------||----------------|
>0x100000                  0x100000+l1     0x100000+l1+l2
>
>The problem is that this decompresses to 0x1000000 (one more zero)=2E So
>if l1 is > (0x1000000-0x100000), then this winds up looking like:
>
>          kernel image            setup_data
>   |--------------------------||----------------|
>0x100000                  0x100000+l1     0x100000+l1+l2
>
>                                 d e c o m p r e s s e d   k e r n e l
>		     |-------------------------------------------------------------|
>                0x1000000                                                =
     0x1000000+l3=20
>
>The decompressed kernel seemingly overwriting the compressed kernel
>image isn't a problem, because that gets relocated to a higher address
>early on in the boot process=2E setup_data, however, stays in the same
>place, since those links are self referential and nothing fixes them up=
=2E
>So the decompressed kernel clobbers it=2E
>
>The solution in this commit adds a bunch of padding between the kernel
>image and setup_data to avoid this=2E That looks like this:
>
>          kernel image                            padding                =
               setup_data
>   |--------------------------||-----------------------------------------=
----------||----------------|
>0x100000                  0x100000+l1                                    =
     0x1000000+l3      0x1000000+l3+l2
>
>                                 d e c o m p r e s s e d   k e r n e l
>		     |-------------------------------------------------------------|
>                0x1000000                                                =
     0x1000000+l3=20
>
>This way, the decompressed kernel doesn't clobber setup_data=2E
>
>The problem is that if 0x1000000+l3-0x100000 is around 62 megabytes,
>then the bootloader crashes when trying to dereference setup_data's
>->len param at the end of initialize_identity_maps() in ident_map_64=2Ec=
=2E
>I don't know why it does this=2E If I could remove the 62 megabyte
>restriction, then I could keep with this technique and all would be
>well=2E
>
>> In general, setup_data should be able to go anywhere the initrd can
>> go, and so is subject to the same address cap (896 MB for old kernels,
>> 4 GB on newer ones; this address too is enumerated in the header=2E)
>
>It would be theoretically possible to attach it to the initrd image
>instead of to the kernel image=2E As a last resort, I guess I can look
>into doing that=2E However, that's going to require some serious rework
>and plumbing of a lot of different components=2E So if I can make it work
>as is, that'd be ideal=2E However, I need to figure out this weird 62 meg
>limitation=2E
>
>Any ideas on that?
>
>Jason

As far as a crash=2E=2E=2E that sounds like a big and a pretty serious one=
 at that=2E

Could you let me know what kernel you are using and how *exactly* you are =
booting it?
