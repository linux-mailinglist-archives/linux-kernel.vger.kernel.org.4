Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5E626AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiKLRVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:21:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144D10B77
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=w19pb6HJ2xuGUcdr6XnHaANHKpqgufdmt2JVPqsUfnY=; b=0zkUEhHonU3lvwQjMwFRxTpkft
        /MCGnRRSH20IqktHD6F9gHWW2wuF/46Tbs2ijXiA4j+fuw6krRlP11FG8eObUGyn2pmIoNr1k5waa
        EJWSOfoiWW7JzlMNGeUjMCJNHz91Vl8nDlxJ8yAZfpLY35Eh5XwVHOxXbmdCPacs6sAvLUPp6QtAr
        s5nUB36HHK3Kjce4ktu+LRpz6kyEpeWFezCBpeI2ZbYbczQAQyxYm69dJ8AdR8bLhck1ScHkNwU/N
        PnS4XSETze92bQy+pY5xf/WSh++tunmIMol1aUC0ML2aldg0DShZEF4SyYOPdAfNw5ZO2NWflzidd
        6T/TElJA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otuCH-0070Np-OU; Sat, 12 Nov 2022 17:21:37 +0000
Message-ID: <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org>
Date:   Sat, 12 Nov 2022 09:21:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
Content-Language: en-US
To:     Ian Cowan <ian@linux.cowan.aero>, cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <Y2/Luovqgz8O+Kqa@rhino>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y2/Luovqgz8O+Kqa@rhino>
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

Hi--

On 11/12/22 08:37, Ian Cowan wrote:
> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
> the following modpost error for both `kmalloc_trace` and
> `kmalloc_node_trace` on the staging/staging-next branch:
> 
> ERROR: modpost: "kmalloc_trace" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
> 
> This only occurs when I have 'CONFIG_TRACING=y' in my config, and I
> have traced it down to the slab header where the kmalloc_trace is
> defined. It appears that when CONFIG_TRACING is set, the kmalloc_trace
> and kmalloc_node_trace do not get defined by the compiler. I do not have
> enough context in this area of the code base to propose a fix or to even
> know if maybe it's a local compiling issue for myself. It looks like
> there are a few recent commits from August that did some refactoring in this header,
> and when compiling prior to that refactoring I am able to compile the
> specified drivers without error.
> 
> I will mention that I am using Red Hat gcc version 12.2.1 and make version
> 4.3 and am on Fedora.

Please post a full failing kernel .config file for this.
Thanks.

-- 
~Randy
