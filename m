Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229EE624BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiKJUUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiKJUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:20:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E89205;
        Thu, 10 Nov 2022 12:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=jjVnxFp7XvS9e2xuC99Hjr8fBnq91nKJs6OoJIcPSRM=; b=hqRmqsaDsb6nKNBke+e9cRPcvP
        BETdrRuIRI61quuLu6m+spXFURlUr4VGqgVbIn7NOcp6A2tfys/8LiJnBMHNC8l7+s/xSIUDfXL1m
        386ukd9wgkH/AW59Q51ZOJ2foHk+vqGkNsiZV3S2MJqB4qdfh5RwxQgBle3YObK2KtlKROLj2hvSg
        il7yUN1quzwkIRRzM9beakBkxSL7IXRTal1QL4smNGaF+fgnvhK5XcdooextLs3UY/5e4YzqNYQbj
        uE+BxEA1MluArpKzbO6qvommkXRhswIsiv5ExwB+osdtuc+JrRcuQOqnR6Zml4BfgpZICwVOJcl+8
        0qLeDO0Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otE2Z-009Jsg-Ea; Thu, 10 Nov 2022 20:20:47 +0000
Message-ID: <e523ce8c-9c60-13de-7e91-a553de985838@infradead.org>
Date:   Thu, 10 Nov 2022 12:20:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: linux-next: build warning after merge of the mm tree
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221110183352.08cc2303@canb.auug.org.au>
 <CAHk-=wiyYSrBiOKJEV3phOBDT7EMgdXCnDUrp57E8HGNT4SFdA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHk-=wiyYSrBiOKJEV3phOBDT7EMgdXCnDUrp57E8HGNT4SFdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-doc]

On 11/10/22 08:27, Linus Torvalds wrote:
> On Wed, Nov 9, 2022 at 11:33 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the mm tree, today's linux-next build (htmldocs) produced
>> this warning:
>>
>> include/linux/mm_types.h:268: error: Cannot parse struct or union!
> 
> Good on you. You check the docs warnings, I've given up on them
> because there's so many and it takes so long.
> 
> I tried to document the 'struct encoded_page' the same way 'struct
> folio' was documented, but clearly the docs parsing hates it. Let's
> remove the '/**' marker and just make it a regular comment.

Yep, that works. Or adding this works:
-struct encoded_page;
+struct encoded_page {
+};

although it shouldn't be needed.

> The same goes for the 'release_pages()' thing,

Looks like scripts/kernel-doc is deficient in parsing

struct encoded_page;

without having any { ... }

and it doesn't handle "typedef union" or "typedef struct". :(

-- 
~Randy
