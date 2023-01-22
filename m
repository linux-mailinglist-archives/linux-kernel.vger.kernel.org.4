Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598BB676B13
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 05:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjAVEpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 23:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVEo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 23:44:58 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBB223131
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 20:44:58 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30M4ifcP1810703
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 21 Jan 2023 20:44:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30M4ifcP1810703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674362682;
        bh=9Ab0ZijIloczLbeQG6t/QkuzyM4WvID+T58SXRdtSVc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=BPbLJU3DuoKO3bcAyH/dElIU0H9XvgdJDXsFkCekZKEZJdlGRmLjXGt6w4rlxNSOE
         ffFPJaFdEXDIxcx7cVcbLRQBgjn49E4Bz090L+Ry3o7QS73RV1NuTigRy0FL6a7UX8
         PmnAi2H4lX/zHkVVknR9gtP4sfA0D3Mpxw3NL5xZOMg5zh1lChMJxBHBALCiUzyCBq
         0vE5nv6jMuwPGHK9a+X/fiw6KBfrNGifgTSvBpjkysuFahq+BBRPxeBqj0KTq67m93
         eAwap1Thzj3F4zK+hK/OsV1FS8K09paElb30OSRuhG059d2cMDeRma85TpTbSYMssT
         cslfshLkx6/iw==
Date:   Sat, 21 Jan 2023 20:44:38 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
User-Agent: K-9 Mail for Android
In-Reply-To: <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com> <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com> <18B5DB6D-AEBD-4A67-A7B3-CE64940819B7@zytor.com> <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com> <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
Message-ID: <65D9F1DE-96D4-4CC7-A21C-A740B7DDE0C8@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2023 8:34:09 PM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 1/21/23 19:38, Li, Xin3 wrote:
>>> However, it doesn't seem to make sense to do so to me=2E The current b=
ehavior is
>>> much more of an artifact than desired behavior=2E
>> We kind of have an agreement that %r11 =3D %flags after returning from =
the kernel=2E
>>=20
>> And the question is, is it what we want?
>
>Can the selftest just set r11=3Drflags before the syscall?  The old
>syscall entry path will set r11=3Drflags=2E  The FRED path won't touch it=
=2E
>Either case will pass an r11=3D=3Drflags check=2E

That's a good idea=2E
