Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4992606E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJUCwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJUCwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:52:13 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7D1956CB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:52:11 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666320729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkKDMtOYkSz/YbDUgqjZfdVaaOBcZWET19nOKsAzQKA=;
        b=CVarCAOdvs4FsTVzMz+c11REvoVvfWQE84aIwvKDvJAd6ov0n3uP51VYbhztqKAX2UyZcJ
        DBiDZpSrbMU9Xi1SLupNdfa13Gutq3IQftJGmC+PPhXnoeT4uAmvLfQT8fQMalJztXVx+4
        QSkAkYP0CN1fZJJkqGaznXw56s4tlBs=
Date:   Fri, 21 Oct 2022 02:52:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <12e1236e3200c03b7fb2771cf7f8f72a@linux.dev>
Subject: Re: [PATCH] x86/e820: make e820 type string uniform
To:     "Dave Hansen" <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     noodles@fb.com, ross.philipson@oracle.com, daniel.kiper@oracle.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <8f84e984-c42b-b672-c9db-e7d4464b2a15@intel.com>
References: <8f84e984-c42b-b672-c9db-e7d4464b2a15@intel.com>
 <20221020115609.223940-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

October 20, 2022 11:44 PM, "Dave Hansen" <dave.hansen@intel.com> wrote:=
=0A=0A> On 10/20/22 04:56, Yajun Deng wrote:=0A> =0A>> /proc/iomem:=0A>> =
...=0A>> 00000000-00000fff : Reserved=0A>> 00001000-0005efff : System RAM=
=0A>> 0005f000-0005ffff : Reserved=0A>> 00060000-0009ffff : System RAM=0A=
>> 000a0000-000fffff : Reserved=0A>> 000a0000-000bffff : PCI Bus 0000:00=
=0A>> 000c0000-000cddff : Video ROM=0A>> 000f0000-000fffff : System ROM=
=0A>> 00100000-80ff3017 : System RAM=0A>> 80ff3018-81003e57 : System RAM =
(kernel)=0A>> 81003e58-81004017 : System RAM=0A>> 81004018-81023c57 : Sys=
tem RAM (kernel)=0A>> 81023c58-87672fff : System RAM=0A> =0A> I guess thi=
s is a pretty minimal change. It definitely makes=0A> /proc/iomem more hu=
man-readable.=0A> =0A> Did you consider if this change might break any us=
ers of this file?=0A=0AYes, it may be.=0AI don't know how many users use =
this file, but I think the impact of this change is limited.=0A=0A1st: Th=
is is not the first time this file has been changed. In commit =0A     ad=
5fb870c486("e820, efi: add ACPI 6.0 persistent memory types"), the E820_P=
RAM changed =0A     from "Persistent RAM" to "Persistent Memory (legacy)"=
.=0A=0A2nd: only super users can access the full information from /proc/i=
omem, which means the users=0A     of this file are limited.=0A     In co=
mmit 51d7b120418e("/proc/iomem: only expose physical resource addresses t=
o privileged users")=0A=0A3rd: The E820_TYPE_RESERVED_KERN changed from "=
System RAM" to "System RAM (kernel)" is a minimal change,=0A     and it a=
lso contains the "System RAM" string.
