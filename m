Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0CC66B51C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjAPA4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAPA4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:56:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F4B75A;
        Sun, 15 Jan 2023 16:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=iggu42fpMPCC/JvbodIoxl6WKIv5OX3Xu3k05p/hDmk=; b=vvAIsznGgtklvdBSuFMOQnMfkt
        21OXgPGr/WMilHQWc5kZrtyk7iW5sQ+uLGOPhfv0Zuyj+dIEPmN12Atoov4nOr+iMdTiUrbjvM8Zw
        1Kt63fC/5CHrM5FwI+E/ZH5ZdzEWbBcy7vPp2XYr+4DDImMi+GTNmXn4oijtXCOOeIYGdsb+n2INT
        QaM9fnx0+/PXGgeeZEb/SAUVqhYPGyJxWIy7lP4N31TivTu2dapbHCTBkvUeUasVSmmdypoZfZTnK
        +KY1shhMDSIY4mWCt2hUkFEuaa2btC25SwOkFapdc+cf/ycboJKQhYAJNbD5u6Z3mPbRBw5rTYblE
        uj+xk7Vg==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHDn2-008G9G-0i; Mon, 16 Jan 2023 00:55:56 +0000
Message-ID: <cb1333e8-0e0b-2e3a-f5e1-553d2722be82@infradead.org>
Date:   Sun, 15 Jan 2023 16:55:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] Documentation: Avoid duplicate Kconfig inclusion
Content-Language: en-US
To:     Peter Foley <pefoley2@pefoley.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230114-doc-v1-1-efec2689e423@pefoley.com>
 <87edrxgk25.fsf@meer.lwn.net>
 <CAOFdcFNKJacBVtrV-hJyUu6hKBVFaKdpA84cZ6WGnZ=ZGnb4kQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOFdcFNKJacBVtrV-hJyUu6hKBVFaKdpA84cZ6WGnZ=ZGnb4kQ@mail.gmail.com>
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



On 1/15/23 16:42, Peter Foley wrote:
> On Sat, Jan 14, 2023 at 8:25 AM Jonathan Corbet <corbet@lwn.net> wrote:
>> The duplicate inclusion does seem worth fixing, but I wonder if you're
>> deleting the right one?  Having the documentation Kconfig under lib
>> seems a bit strange, somehow; Documentation/ is a top-level directory,
>> after all.
> 
> I thought about that.
> Looking at the history, the toplevel inclusion was added in
> b1663d7e3a7961 (2019-06-04), and the lib/Kconfig.debug inclusion was
> added in 75442fb0ccaacd (2020-10-30).
> Given the actual entries in Documentation/Kconfig
> (WARN_MISSING_DOCUMENTS and WARN_ABI_ERRORS), putting them under the
> "Kernel hacking" menu makes sense to me.
> We *could* add a new top-level menu to Documentation/Kconfig, but it
> doesn't really seem like an improvement over having them live in
> Kernel hacking.

Since b1663d7e3a7961 puts the Documentation/Kconfig just after
lib/Kconfig.debug, there's not much difference in its location in a
*config menu, but I would rather see it separated (independent) from
lib/Kconfig.debug because I think that it would make any future changes
easier.

Also, b1663d7e3a7961 came first. :)

-- 
~Randy
