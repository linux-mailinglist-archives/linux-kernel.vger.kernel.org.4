Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88209658891
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiL2COG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiL2COD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:14:03 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760EB2E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 18:14:01 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BT2Ddcr771066
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 28 Dec 2022 18:13:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BT2Ddcr771066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672280020;
        bh=wDlVIMRzl48TIn6PdZnv8A8E3UHC34q713deYKTA5QA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=dEeZ8CBbOy98d3JIHEBFW0m4LEt3a+syD3kFsaOaRonOYJN3emSdaRBTyT2KkhFx3
         bsK1iEdGg9vJqFD7ZJVBjKO8B/hTq8JPveGkYpouKbHb8RTDuTJD54GLTxBv3iEhKZ
         eDxV3puw8rOpQIy1A5Pc6x7eVQfB3ruOg2oe6xFSyUhwAuQswhQY5BcmCxCC9hBlrF
         vut0sQX/QvOysHrNkeKVtgPZWJDVgzlRahiBDKm1mzokpk5CloO9cF3udiJ3KqIu2m
         EKEBgNpMYUWOWKaHmxrRarRdKKjKMMsYANmvoP/cuJHKik14vui8yt5aGGlYcQQy4+
         BhE1attzrlsOA==
Content-Type: multipart/mixed; boundary="------------zOvv02N0vbK1R1cRQLgodu5K"
Message-ID: <0baf674b-c7e7-a010-375d-ea1132495c44@zytor.com>
Date:   Wed, 28 Dec 2022 18:13:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, bp@alien8.de, philmd@linaro.org
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com> <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
In-Reply-To: <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------zOvv02N0vbK1R1cRQLgodu5K
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/28/22 15:58, H. Peter Anvin wrote:
> On December 28, 2022 8:57:54 AM PST, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
>> HELLO H. PETER ANVIN,
>> E
>> L
>> L
>> O
>>
>> On Wed, Dec 28, 2022 at 05:30:30PM +0100, Jason A. Donenfeld wrote:
>>>> Fix looks good, glad you figured out the problem.
>>>
>>> I mean, kind of. The solution here sucks, especially given that in the
>>> worst case, setup_data just gets dropped. I'm half inclined to consider
>>> this a kernel bug instead, and add some code to relocate setup_data
>>> prior to decompression, and then fix up all the links. It seems like
>>> this would be a lot more robust.
>>>
>>> I just wish the people who wrote this stuff would chime in. I've had
>>> x86@kernel.org CC'd but so far, no input from them.
>>
>> Apparently you are the x86 boot guru. What do you want to happen here?
>> Your input would be very instrumental.
>>
>> Jason
> 
> Hi!
> 
> Glad you asked.
> 
> So the kernel load addresses are parameterized in the kernel image
> setup header. One of the things that are so parameterized are the
> size and possible realignment of the kernel image in memory.
> 
> I'm very confused where you are getting the 64 MB number from. There
> should not be any such limitation.
> 
> In general, setup_data should be able to go anywhere the initrd can
> go, and so is subject to the same address cap (896 MB for old
> kernels, 4 GB on newer ones; this address too is enumerated in the
> header.)
> 
> If you want to put setup_data above 4 GB, it *should* be ok if and
> only if the kernel supports loading the initrd high, too (again,
> enumerated in the header.
> 
> TL;DR: put setup_data where you put the initrd (before or after
> doesn't matter.)
> 
> To be maximally conservative, link the setup_data list in order from
> lowest to highest address; currently there is no such item of
> relevance, but in the future there may be setup_data items needed by
> the BIOS part of the bootstrap in which case they would have to be <
> 1 MB and precede any items > 1 MB for obvious reasons. That being
> said, with BIOS dying it is not all that likely that such entries
> will ever be needed.
> 

So let me try for an algorithm. Attached as a text file to avoid line 
break damage.

	-hpa
--------------zOvv02N0vbK1R1cRQLgodu5K
Content-Type: text/plain; charset=UTF-8; name="kernel-data-addresses.txt"
Content-Disposition: attachment; filename="kernel-data-addresses.txt"
Content-Transfer-Encoding: base64

SGVyZSBpcyBhbiBhdHRlbXB0ZWQgZGVzY3JpcHRpb24gd2l0aCBwc2V1ZG8tQyBjb2RlOgoK
Rmlyc3Qgb2YgYWxsLCB0YWtlIGEgNEsgcGFnZSBvZiBtZW1vcnkgYW5kICppbml0aWFsaXpl
IGl0IHRvIHplcm8qLgp7CiAgICAjaW5jbHVkZSA8YXNtL2Jvb3RwYXJhbS5oPgkvKiBGcm9t
IHRoZSB1YXBpIGtlcm5lbCBzb3VyY2VzICovCgogICAgLyogQWxsb2NhdGVkIHNvbWV3aGVy
ZSBpbiB5b3VyIGNvZGUuLi4gKi8KICAgIGV4dGVybiB1bnNpZ25lZCBjaGFyICprZXJuZWxf
aW1hZ2U7CQkvKiBLZXJuZWwgZmlsZSAqLwogICAgZXh0ZXJuIHN0cnVjdCBib290X3BhcmFt
cyAqYm9vdF9wYXJhbXM7CS8qIDRLIGJ1ZmZlciAqLwogICAgZXh0ZXJuIHVpbnQzMl90IGtl
cm5lbF9pbWFnZV9zaXplOwkJLyogU2l6ZSBvZiBrZXJuZWwgZmlsZSAqLwoKICAgIC8qIENh
bGxiYWNrcyBpbnRvIHlvdXIgY29kZSAqLwogICAgZXh0ZXJuIGJvb2wgaXNfYmlvc19ib290
KHZvaWQpOwogICAgZXh0ZXJuIHVpbnQzMl90IGVuZF9vZl9sb3dfbWVtb3J5KHZvaWQpOyAv
KiBGb3IgQklPUyBib290ICovCiAgICAvKgogICAgICogVGhpcyBNVVNUIHJldHVybiBhbiBh
bGlnbm1lbnQgYWRkcmVzcyBiZXR3ZWVuIHN0YXJ0X2FkZHJlc3MKICAgICAqIGFuZCBtYXhf
YWRkcmVzcy4uLgogICAgICovCiAgICBleHRlcm4gdWludDY0X3QgbWF5YmVfcmVsb2NhdGVf
a2VybmVsKHVpbnQ2NF90IHN0YXJ0X2FkZHJlc3MsCgkgIHVpbnQ2NF90IG1heF9hZGRyZXNz
LCB1aW50MzJfdCBhbGlnbm1lbnQpOwoKICAgIC8qCiAgICAgKiBDb252ZW5pZW5jZSBwb2lu
dGVyIGludG8gdGhlIGtlcm5lbCBpbWFnZTsgbW9kaWZpY2F0aW9ucwogICAgICogZG9uZSBo
ZXJlIHNob3VsZCBiZSByZWZsZWN0ZWQgaW4gdGhlIGxvYWRlZCBrZXJuZWwgaW1hZ2UKICAg
ICAqLwogICAgc3RydWN0IHNldHVwX2hlYWRlciAqIGNvbnN0IGtlcm5lbF9zZXR1cF9oZWFk
ZXIgPQoJKHN0cnVjdCBzZXR1cF9oZWFkZXIgKikoa2VybmVsX2ltYWdlICsgMHgxZjEpOwoK
ICAgIC8qIEluaXRpYWxpemUgYm9vdF9wYXJhbXMgdG8gemVybyEhISAqLwogICAgbWVtc2V0
KGJvb3RfcGFyYW1zLCAwLCBzaXplb2YgKmJvb3RfcGFyYW1zKTsKfQoKQ29weSB0aGUgc2V0
dXAgaGVhZGVyIHN0YXJ0aW5nIGF0IGZpbGUgb2Zmc2V0IDB4MWYxIHRvIG9mZnNldCAweDFm
MQppbnRvIHRoYXQgcGFnZToKewogICAgaW50IHNldHVwX2xlbmd0aCA9CglrZXJuZWxfc2V0
dXBfaGVhZGVyLT5oZWFkZXIgPT0gMHg1MzcyNjQ0OAoJPyAoa2VybmVsX3NldHVwX2hlYWRl
ci0+anVtcCA+PiA4KSArIDE3IDogMTU7CgogICAgbWVtY3B5KCZib290X3BhcmFtcy0+aGRy
LCBrZXJuZWxfc2V0dXBfaGVhZGVyLCBzZXR1cF9sZW5ndGgpOwp9CgpOb3cgeW91IGNhbiBj
b21wdXRlIHZhbHVlcyBpbmNsdWRpbmcgb25lcyBhcmUgb21pdHRlZCBieSBvbGRlciBrZXJu
ZWxzOgp7CiAgICAvKgogICAgICogU3BsaXQgYmV0d2VlbiB0aGUgcGFydCBvZiB0aGUga2Vy
bmVsIHRvIGJlIGxvYWRlZCBpbnRvCiAgICAgKiBsb3cgbWVtb3J5IChmb3IgMTYtYml0IGJv
b3QsIG90aGVyd2lzZSBpdCBjYW4gYmUgc2FmZWx5CiAgICAgKiBvbWl0dGVkKSBhbmQgdGhl
IHBhcnQgdG8gYmUgbG9hZGVkIGludG8gaGlnaCBtZW1vcnkuCiAgICAgKi8KICAgIGlmICgh
Ym9vdF9wYXJhbXMtPmhkci5zZXR1cF9zZWN0cykKCWJvb3RfcGFyYW0tPmhkci5zZXR1cF9z
ZWN0cyA9IDQ7CgogICAgaW50IGhpZ2hfa2VybmVsX3N0YXJ0ID0gKGJvb3RfcGFyYW0tPmhk
ci5zZXR1cF9zZWN0cysxKSA8PCA5OwoKICAgIC8qCiAgICAgKiBIaWdoZXN0IHBlcm1pdHRl
ZCBhZGRyZXNzIGZvciB0aGUgaGlnaCBwYXJ0IG9mIHRoZSBrZXJuZWwgaW1hZ2UsCiAgICAg
KiBpbml0cmQsIGNvbW1hbmQgbGluZSAoKmV4Y2VwdCBmb3IgMTYtYml0IGJvb3QqKSwgYW5k
IHNldHVwX2RhdGEKICAgICAqCiAgICAgKiBtYXhfaW5pdHJkX2FkZHIgaGVyZSBpcyBleGNs
dXNpdmUKICAgICAqLwogICAgdWludDY0X3QgbWF4X2luaXRyZF9hZGRyID0gKHVpbnQ2NF90
KWJvb3RfcGFyYW1zLT5oZHIuaW5pdHJkX2FkZHJfbWF4ICsgMTsKICAgIGlmIChib290X3Bh
cmFtcy0+aGRyLnZlcnNpb24gPCAweDAyMDApCgltYXhfaW5pdHJkX2FkZHIgPSAwOwkvKiBO
byBpbml0cmQgc3VwcG9ydGVkICovCiAgICBlbHNlIGlmIChib290X3BhcmFtcy0+aGRyLnZl
cnNpb24gPCAweDAyMDMpCgltYXhfaW5pdHJkX2FkZHIgPSAweDM4MDAwMDAwOwogICAgZWxz
ZSBpZiAoYm9vdF9wYXJhbXMtPmhkci52ZXJzaW9uID49IDB4MDIwYyAmJgoJICAgICAgIChi
b290X3BhcmFtcy0+aGRyLnhsb2FkZmxhZ3MgJiBYTEZfQ0FOX0JFX0xPQURFRF9BQk9WRV80
RykpCgltYXhfaW5pdHJkX2FkZHIgPSAodWludDY0X3QpMSA8PCA1MjsgLyogQXJjaGl0ZWN0
dXJlLWltcG9zZWQgbGltaXQgKi8KCiAgICAvKgogICAgICogTWF4aW11bSBjb21tYW5kIGxp
bmUgc2l6ZSAqaW5jbHVkaW5nIHRlcm1pbmF0aW5nIG51bGwqCiAgICAgKi8KICAgIHVuc2ln
bmVkIGludCBjbWRsaW5lX3NpemU7CiAgICBpZiAoYm9vdF9wYXJhbXMtPmhkci52ZXJzaW9u
IDwgMHgwMjAwKQoJY21kbGluZV9zaXplID0gMDsJLyogTm8gY29tbWFuZCBsaW5lIHN1cHBv
cnRlZCAqLwogICAgZWxzZSBpZiAoYm9vdF9wYXJhbXMtPmhkci52ZXJzaW9uIDwgMHgwMjA2
KQoJYm9vdF9wYXJhbXMtPmhkci5jbWRsaW5lX3NpemUgPSAyNTY7CiAgICBlbHNlCglib290
X3BhcmFtcy0+aGRyLmNtZGxpbmVfc2l6ZSArIDE7CgogICAgLyogQ29tbWFuZCBsaW5lIHNp
emUgaW5jbHVkaW5nIHRlcm1pbmF0aW5nIG51bGwgKi8KCiAgICAvKgogICAgICogTG9hZCBh
ZGRyZXNzZXMgZm9yIHRoZSBsb3cgYW5kIGhpZ2gga2VybmVscywgcmVzcGVjdGl2ZWx5CiAg
ICAgKi8KICAgIHVpbnQzMl90IGxvd19rZXJuZWxfYWRkcmVzczsKICAgIHVpbnQ2NF90IGNt
ZGxpbmVfYWRkcjsJLyogQWRkcmVzcyB0byBsb2FkIHRoZSBjb21tYW5kIGxpbmUgKi8KCiAg
ICBpZiAoaXNfYmlvc19ib290KCkpIHsKCWlmICghKGJvb3RfcGFyYW1zLT5oZHIubG9hZGZs
YWdzICYgTE9BREVEX0hJR0gpKSB7CgkgICAgbG93X2tlcm5lbF9hZGRyZXNzID0gMHg5MDAw
MDsKCX0gZWxzZSB7CgkgICAgLyoKCSAgICAgKiBSZWNvbW1lbmRlZCB0byBiZSB0aGUgbG93
ZXN0IGF2YWlsYWJsZSBhZGRyZXNzIGJldHdlZW4KCSAgICAgKiAweDEwMDAwIGFuZCAweDkw
MDAwCgkgICAgICovCgkgICAgbG93X2tlcm5lbF9hZGRyZXNzID0gcHJlZmVycmVkX2xvd19r
ZXJuZWxfYWRkcmVzcygpOwoJfQoKCXVpbnQzMl90IGxvd2tlcm5lbF9tYXg7CgoJbG93a2Vy
bmVsX21heCA9IGxvd19rZXJuZWxfYWRkcmVzcyArIDB4MTAwMDA7CglpZiAoYm9vdF9wYXJh
bXMuaGRyLnZlcnNpb24gPj0gMHgwMjAyKQoJICAgIGxvd2tlcm5lbF9tYXggKz0gKGNtZGxp
bmVfc2l6ZSArIDE1KSAmIH4xNTsKCgkvKgoJICogZW5kX29mX2xvd19tZW1vcnkoKSBpcyB1
c3VhbGx5IGdpdmVuIGJ5ICoodWludDhfdCAqKTB4NDEzIDw8IDEwCgkgKi8KCWlmIChsb3dr
ZXJuZWxfbWF4ID4gZW5kX29mX2xvd19tZW1vcnkoKSkKCSAgICBsb3drZXJuZWxfbWF4ID0g
ZW5kX29mX2xvd19tZW1vcnkoKTsKCgljbWRsaW5lX2FkZHIgPSAobG93a2VybmVsX21heCAt
IGNtZGxpbmVfc2l6ZSkgJiB+MTU7CglpZiAoYm9vdF9wYXJhbXMtPmhkci52ZXJzaW9uID49
IDB4MDIwMikKCSAgICBrZXJuZWxfc2V0dXBfaGVhZGVyLT5jbWRfbGluZV9wdHIgPSBjbWRs
aW5lX2FkZHI7CgllbHNlIGlmIChib290X3BhcmFtcy0+aGRyLnZlcnNpb24gPj0gMHgwMjAw
KQoJICAgIGtlcm5lbF9zZXR1cF9oZWFkZXItPnNldHVwX21vdmVfc2l6ZSA9CgkJbG93a2Vy
bmVsX21heCAtIGxvd19rZXJuZWxfYWRkcmVzczsKCglpZiAoYm9vdF9wYXJhbXMuaGRyLnZl
cnNpb24gPj0gMHgwMjAxKSB7CgkgICAga2VybmVsX3NldHVwX2hlYWRlci0+aGVhcF9lbmRf
cHRyCgkJPSBjbWRsaW5lX2FkZHIgLSBsb3dfa2VybmVsX2FkZHJlc3MgLSAweDAyMDA7Cgkg
ICAga2VybmVsX3NldHVwX2hlYWRlci0+bG9hZGZsYWdzIHw9IENBTl9VU0VfSEVBUDsKCX0K
ICAgIH0gZWxzZSB7Cglsb3dfa2VybmVsX2FkZHJlc3MgPSAwOwkvKiBOb3QgdXNlZCBmb3Ig
bm9uLUJJT1MgYm9vdCAqLwoJY21kbGluZV9hZGRyID0gMDsJLyogTm90IGFzc2lnbmVkIHll
dCAqLwogICAgfQoKICAgIC8qCiAgICAgKiBEZWZhdWx0IGxvYWQgYWRkcmVzcyBmb3IgdGhl
IGhpZ2gga2VybmVsLCBhbmQgaWYgaXQgY2FuIGJlIHJlbG9jYXRlZAogICAgICovCiAgICB1
aW50NjRfdCBoaWdoX2tlcm5lbF9hZGRyZXNzOwogICAgdWludDMyX3QgaGlnaF9rZXJuZWxf
c2l6ZTsJLyogVGhlIGFtb3VudCBvZiBtZW1vcnkgdGhlIGhpZ2gga2VybmVsIG5lZWRzICov
CiAgICBib29sIHJlbG9jYXRhYmxlX2tlcm5lbCA9IGZhbHNlOwogICAgdWludDMyX3QgaGln
aF9rZXJuZWxfYWxpZ25tZW50ID0gMHg0MDAwMDA7IC8qIEtlcm5lbCBydW50aW1lIGFsaWdu
bWVudCAqLwoKICAgIGlmICghKGJvb3RfcGFyYW1zLT5oZHIubG9hZGZsYWdzICYgTE9BREVE
X0hJR0gpKSB7CgloaWdoX2tlcm5lbF9hZGRyZXNzID0gMHgxMDAwMDsKICAgIH0gZWxzZSB7
CglpZiAoYm9vdF9wYXJhbXMtPmhkci52ZXJzaW9uID49IDB4MDIwYSkKCSAgICBoaWdoX2tl
cm5lbF9hZGRyZXNzID0gYm9vdF9wYXJhbXMtPmhkci5wcmVmX2FkZHJlc3M7CgllbHNlCgkg
ICAgaGlnaF9rZXJuZWxfYWRkcmVzcyA9IDB4MTAwMDAwOwoKCWlmIChib290X3BhcmFtcy0+
aGRyLnZlcnNpb24gPj0gMHgwMjA1ICYmCgkgICAgYm9vdF9wYXJhbXMtPmhkci5yZWxvY2F0
YWJsZV9rZXJuZWwpIHsKCSAgICByZWxvY2F0YWJsZV9rZXJuZWwgPSB0cnVlOwoJICAgIGhp
Z2hfa2VybmVsX2FsaWdubWVudCA9IGJvb3RfcGFyYW1zLT5oZHIua2VybmVsX2FsaWdubWVu
dDsKCX0KICAgIH0KCiAgICAvKgogICAgICogTGluZWFyIG1lbW9yeSBhcmVhIG5lZWRlZCBi
eSB0aGUga2VybmVsCiAgICAgKi8KICAgIHVpbnQzMl90IGtlcm5lbF9tZW1fc2l6ZTsKICAg
IGlmIChib290X3BhcmFtcy0+aGRyLnZlcnNpb24gPj0gMHgwMjBhKQoJa2VybmVsX21lbV9z
aXplID0gYm9vdF9wYXJhbXMtPmhkci5pbml0X3NpemU7CiAgICBlbHNlCglrZXJuZWxfbWVt
X3NpemUgPSBrZXJuZWxfaW1hZ2Vfc2l6ZSA8PCAyOyAvKiBQdXJlIGd1ZXNzd29yay4uLiAq
LwoKICAgIC8qIFJlbG9jYXRlIHRoZSBrZXJuZWwgbG9hZCBhZGRyZXNzIGlmIGRlc2lyZWQg
Ki8KICAgIGlmIChyZWxvY2F0YWJsZV9rZXJuZWwpIHsKCWhpZ2hfa2VybmVsX2FkZHJlc3Mg
PQoJICAgIG1heWJlX3JlbG9jYXRlX2tlcm5lbChoaWdoX2tlcm5lbF9hZGRyZXNzLAoJCQkJ
ICBtYXhfaW5pdHJkX2FkZHIgLSBrZXJuZWxfbWVtX3NpemUsCgkJCQkgIGhpZ2hfa2VybmVs
X2FsaWdtZW50KTsKICAgIH0KCiAgICAvKiBBZGp1c3QgZm9yIHBvc3NpYmxlIGludGVybmFs
IGtlcm5lbCByZWFsaWdtZW50ICovCiAgICBrZXJuZWxfbWVtX3NpemUgKz0gKC1oaWdoX2tl
cm5lbF9hZGRyZXNzKSAmIChoaWdoX2tlcm5lbF9hbGlnbm1lbnQgLSAxKTsKCiAgICAvKgog
ICAgICogRGV0ZXJtaW5lIHRoZSBtaW5pbXVtIHNhZmUgYWRkcmVzcyBmb3IgbG9hZGluZyBp
bml0cmQsIHNldHVwX2RhdGEsCiAgICAgKiBhbmQsIGlmIGNtZGxpbmVfYWRkciA9PSAwIChp
LmUuICFpc19iaW9zX2Jvb3QoKSksIHRoZSBjb21tYW5kIGxpbmUuCiAgICAgKi8KICAgIHVp
bnQ2NF90IG1pbl9pbml0cmRfYWRkciA9IGhpZ2hfa2VybmVsX2FkZHJlc3MgKyBrZXJuZWxf
bWVtX3NpemU7Cn0K

--------------zOvv02N0vbK1R1cRQLgodu5K--
