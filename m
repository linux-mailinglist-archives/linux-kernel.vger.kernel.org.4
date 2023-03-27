Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E156F6CB1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjC0Wln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjC0Wll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:41:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF11997;
        Mon, 27 Mar 2023 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=a+NNIptAWHtq0o22h3h8YYC7VcufgPSmYOfMKiLUR+I=; b=OqOtUMdy3UQOY9O+ksejOWJt7t
        Zi4oFgejgDUuQ8pErY4lxlS6Ug0uYmEP5RgzXWqcSHZkUFvCsuVEws1QH/BuPP4THh+vmlxMOXuiz
        tWVbGE9sT6G0B9HtZGzSPK/MyLqRQImn5iRp5nXlsGPtO/VtfShs4EoJtJHwQLN3lpY+KjTQ+3rpQ
        4fGp26V0dmZhTtcf39R6VZ0aUX68rD+EnZbEx7SmxM74n295n+ODQ2ja6CBj6PBvjw+WTqCDEMplT
        5xmuFErCUWNPrnwPTzyP0mk+ZqppkhYaDL6hXNleQBjMa8uQU06U/J1MrIcdelGKEXfIlEGLUx1B+
        7yzPYFkQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgvX1-00Cane-0u;
        Mon, 27 Mar 2023 22:41:39 +0000
Message-ID: <642d6944-4488-4dc6-99e9-209849b9771c@infradead.org>
Date:   Mon, 27 Mar 2023 15:41:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Bug in recent changes to builddeb
Content-Language: en-US
To:     Ron Economos <re@w6rz.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <54a519ec-bfe5-60f3-fc43-707a11d38d2a@w6rz.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <54a519ec-bfe5-60f3-fc43-707a11d38d2a@w6rz.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at least Cc linux-kbuild.

On 3/27/23 13:55, Ron Economos wrote:
> Looks like there's a bug in /scripts/package/builddeb. On lines 188, 197 and 198, the variable $version is used. However, it's not defined (removed with recent changes).
> 
> This causes the headers to be put into /usr/src/linux-headers-. When the next version is attempted to be installed, the following error occurs.
> 
> $ sudo dpkg -i linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb
> Selecting previously unselected package linux-headers-6.3.0-rc4.
> (Reading database ... 376925 files and directories currently installed.)
> Preparing to unpack linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb ...
> Unpacking linux-headers-6.3.0-rc4 (6.3.0-rc4-2) ...
> dpkg: error processing archive linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb (--install):
>  trying to overwrite '/usr/src/linux-headers-/.config', which is also in package linux-headers-6.3.0-rc3 6.3.0-rc3-4
> dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)
> Errors were encountered while processing:
>  linux-headers-6.3.0-rc4_6.3.0-rc4-2_riscv64.deb
> 

-- 
~Randy
