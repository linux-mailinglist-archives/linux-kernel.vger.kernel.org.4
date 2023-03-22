Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A36C472C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCVKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCVKDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:03:15 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4429155;
        Wed, 22 Mar 2023 03:03:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7F9D5320024A;
        Wed, 22 Mar 2023 06:03:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 22 Mar 2023 06:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679479392; x=
        1679565792; bh=aD1YIpUAa25QM2vuMLDfbqJJy4ZVEI7gALNgRAtV62M=; b=m
        IWnEzzwVmjE0SLnbRans3uxqxIOl+LUGhThMm3aTg539LQNogEPmItSOoC9xAwDW
        wxCmDjwIqVVfTXBVGYd4jSf1dARwGgyFJkyZrUkv7GVo8NgoUzpOGLi4a819nRc7
        ljkUaxJUE56hUh5n7RKxSI+5ROs2xQDej5D3OgF+hxnpX8PDOGVZiokGiIVcRyWo
        chYLNaXQBYoTqXoGFNUrd9mhYEoqeAy4HEZ8OKwFMDJbETqir3FPFdl3ti2hExMR
        cWCdoWqC8YX3pdXqiW2PKAMY/wkk26WOOxwVxX2hL2zYwiEMmJcH6XvfsM9tvWwV
        fLLoqRT0N32s13ZZ5qUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679479392; x=1679565792; bh=aD1YIpUAa25QM
        2vuMLDfbqJJy4ZVEI7gALNgRAtV62M=; b=BJyLOtByEwChh7v1QLbjVOrX2wqmL
        Ien77v6Pg+m4cQkYOg4OHc297QYzeviQdqgNeRMPoyv2zDXUHW6gJx7MnO8xj3vk
        94/+e2UikiOB5prZHmjr1sTYNg9AqzDXjS5LSJXjd/cPPqDQ6xActnplgIthhXC6
        sQ64lOm42YyF6GwZcKNG80Y67iB0DS9hkUFkjYcdcXmMFfvm/z2pboWFgd/F4hFD
        yMl+avVtwWb+hLJilvhqg5RwJiMMET2CcM+pnPXUSOo5ihkWx5yn//5EMlZnViXh
        349c54nacGtuowuOUrxKtHCvM8s6aA7To1RHKArNGEGRiffF38p/LdnHQ==
X-ME-Sender: <xms:X9IaZDS3LWO01xs_x3cN1GTo99NifgNvRudh5MIJtE94eLBwE-fmQQ>
    <xme:X9IaZEzV9ZBHIScjZYoS0AOOQ2eLgnOwCjG2Y1JE17oD3wQzUqGjwNLJXNATsbwxv
    4K-ZGEXbM8sTjOXJEU>
X-ME-Received: <xmr:X9IaZI1xvhcNn1qUY1vllQRUJg-evj6lJZvOTrrz5yI3_E85IcKQM9q-2QbzbMFMpqKJaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:X9IaZDBz-m6wJSJkfOtwllYUqqQ6YjLHPPQB-urEQe-PhwhreFoXKg>
    <xmx:X9IaZMjvo1AHTrz-HzmxZGDnlYfvtAk8_05U7QsHzaxajyVvpQdWRA>
    <xmx:X9IaZHpkgZxmiYXfWk-7G5kBI1VzwwoJbkh685U8TDJDJbpPSzjBuQ>
    <xmx:YNIaZHVRB7n2YHQ3RNNtdz704m4SyOm9S7-TYF5X9E2LXJ6jJ9mW9w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 06:03:11 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id F3C1810A603; Wed, 22 Mar 2023 13:03:09 +0300 (+03)
Date:   Wed, 22 Mar 2023 13:03:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] loongarch: drop ranges for definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <20230322100309.lefchtsrvtsyboln@box>
References: <20230322081727.2516291-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322081727.2516291-1-rppt@kernel.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:17:27AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> LoongArch defines insane ranges for ARCH_FORCE_MAX_ORDER allowing
> MAX_ORDER up to 63, which implies maximal contiguous allocation size of
> 2^63 pages.
> 
> Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
> simple integer with sensible defaults.
> 
> Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
> will be able to do so but they won't be mislead by the bogus ranges.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
