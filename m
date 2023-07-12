Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69A174FF22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGLGU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGLGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650E010C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689142779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eP+PaMtiBoxy/ePKEN3Co0OlzL1iv3d3q85K2qe9AY=;
        b=KLbKfJnQWit3R1Tg5l1ZEj1glB1Vtc6xDgICAZNIxk2chzDhjhg65Utpm5g6uioTcduXkm
        QHd2hcqLKna5+Hw14swoWpASUmaDNirMuAtidBhKJtMl8d/R5pg6eIHWMMW82BRpoThJlg
        lrgd1U71C5LL3ECbBpk5aDLaICZBcIw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-kgb2c8F1MialrDyBAv45-A-1; Wed, 12 Jul 2023 02:19:38 -0400
X-MC-Unique: kgb2c8F1MialrDyBAv45-A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765986c0521so624636085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689142777; x=1691734777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eP+PaMtiBoxy/ePKEN3Co0OlzL1iv3d3q85K2qe9AY=;
        b=Q3+PjYgcHoschnNP97wieFggVNmvNgfIvzN3fBTr1J1TEGmHshO0xCts1KSGdPtBCD
         o3S2siGPTnEg695TbSP5Xd2qe6jOAhSfjczn+l9ILkLveI7AO+pz+n97jE3p2a/EERXC
         u+8ePn/v1DBcEv6S9WsUUzVXj3EqNh87y5i43vGPu1ntg552VPeyrHhTDWVfgv49G9pB
         gaGbWSQzslvGW8yqRNIHmn7b8CBAsw/RiOpCqViNRM4UFiIuUiKsU6FdhhyDJbRLhWUJ
         WOesGHLSHmMmFH9aNryu+XbEyafIXytYxfqP9WdjJHcEUelIVb+LO+YBBtwlRnestVXu
         8Y6Q==
X-Gm-Message-State: ABy/qLaGxjesWP81gqHnJmPS+BPCfbc57ygAr8oxct/ABeGs2aEgwuqq
        7Ajanyg0ChTZtUpYbS40XJxlVctCQtQhg45ERHTAX7GPFq+zLT5FLPQb9qA7RKaRxTgTAKgGUKv
        tdj4iq3PrmZnoujQj5xQDgWq4GFLRqPtC
X-Received: by 2002:a05:620a:2a57:b0:767:4d85:2668 with SMTP id q23-20020a05620a2a5700b007674d852668mr18381451qkp.63.1689142777007;
        Tue, 11 Jul 2023 23:19:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGYQQ3cK9xBP5MQM1dmtjYhHcgF+YEn6oWY7hcHkTeLsUjTMTQkA2o78eD8qYuOUSq8SOcMMw==
X-Received: by 2002:a05:620a:2a57:b0:767:4d85:2668 with SMTP id q23-20020a05620a2a5700b007674d852668mr18381442qkp.63.1689142776726;
        Tue, 11 Jul 2023 23:19:36 -0700 (PDT)
Received: from [192.168.149.40] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id i28-20020a05620a151c00b00767d5b81920sm1869406qkk.85.2023.07.11.23.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 23:19:36 -0700 (PDT)
Message-ID: <5e01b6a5-f993-f99d-41a0-ab671ec598f8@redhat.com>
Date:   Wed, 12 Jul 2023 08:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Content-Language: de-CH
To:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <7E9D397B-439F-484C-B950-9094605A7B4D@zytor.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <7E9D397B-439F-484C-B950-9094605A7B4D@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 12/07/2023 um 03:33 schrieb H. Peter Anvin:
> On July 11, 2023 8:44:49 AM PDT, Emanuele Giuseppe Esposito <eesposit@redhat.com> wrote:
>> *Important*: this is just an RFC, as I am not expert in this area and
>> I don't know what's the best way to achieve this.
>>
>> v2:
>> * add standard "sbat,1,SBAT Version,..." header string
>>
>> The aim of this patch is to add a .sbat section to the linux binary
>> (https://github.com/rhboot/shim/blob/main/SBAT.md).
>> We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
>> to revoke authorizations to specific signed PEs that were initially
>> considered as trusted. The reason might be for example a security issue
>> related to a specific linux release.
>>
>> A .sbat is simply a section containing a string with the component name
>> and a version number. This version number is compared with the value in
>> OVMF_VARS, and if it's less than the variable, the binary is not trusted,
>> even if it is correctly signed.
>>
>> Right now an UKI is built with a .sbat section containing the
>> systemd-stub sbat string (upstream + vendor), we would like to add
>> also a per-component specific string (ie vmlinux has its own sbat,
>> again upstream + vendor, each signed add-on its own and so on).
>> In this way, if a specific kernel version has an issue, we can revoke
>> it without compromising all other UKIs that are using a different
>> kernel with the same stub/initrd/something else.
>>
>> Issues with this patch:
>> * the string is added in a file but it is never deleted
>> * if the code is not modified but make is issued again, objcopy will
>>  be called again and will fail because .sbat exists already, making
>>  compilation fail
>> * minor display issue: objcopy command is printed in the make logs
>>
> Please ignore my previous message. It is a separate PECOFF section because it is consumed by UEFI rather than Linux.
> 
No worries :) thanks for responding!
Any hints on how to solve any of the issues I mention above?

And any comment on the SBAT string itself? I would like to get an
agreement on
"linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org"
before we use it as semplate also for downstream.

Thank you,
Emanuele

