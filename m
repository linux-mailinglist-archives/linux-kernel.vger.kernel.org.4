Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3751360817C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJUW2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJUW2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:28:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839AB219FE5;
        Fri, 21 Oct 2022 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gpujHzFrCcK1BjKxncwrcAxG2Cvj+tA9lKuzSVZczik=; b=g4ZqGu3jMqsiPiTJKMJjxGZCaG
        dWoV+m00IrNND0x8zJI03FuMca8pHRXUaxvH4py7U2D3l9c2LKNG7dQ91F/lsy6fC2uNaRZopuF6R
        O6dE7t0ygEUaF+1JOsgPdzZXkzGg9QH7cDyDEEU2tbnuvp+Y9ENa4vCPS+ff9HMBNx4Gt6Drhf6go
        OtvxAor0PSBATfnHk8/Y4dO+eBiRiPPcvSPzbsIRHurSUPKhKLr/A90YDBS94ecQK70Xlr+HIZbg4
        fp9U/6PBTYmHNCfHoUj5pCgXJlTfr386BshHH6PRW2lXhFqgeCE0D5TKcrGBL0fvMGEJl1ZroaV+d
        zf+AJiCg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1om0VP-00ACe7-1H; Fri, 21 Oct 2022 22:28:43 +0000
Message-ID: <a138e318-d075-63f9-4c41-f8edb45f63f4@infradead.org>
Date:   Fri, 21 Oct 2022 15:28:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] package: add tar development package for 3rd party
 modules
Content-Language: en-US
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021101452.1367745-1-federico.vaga@cern.ch>
 <20221021101452.1367745-2-federico.vaga@cern.ch>
 <55dd0e6d-3d52-fce9-015f-6ebb75cf826e@infradead.org>
 <20221021214857.saijsfcx5skdksp3@number5.vaga.pv.it>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221021214857.saijsfcx5skdksp3@number5.vaga.pv.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/22 14:48, Federico Vaga wrote:
> On Fri, Oct 21, 2022 at 01:11:18PM -0700, Randy Dunlap wrote:
>> Hi--
>>
>> On 10/21/22 03:14, Federico Vaga wrote:
>>> Most, if not all, Linux distributions provides a Linux development
>>> package which purpose is to support the building of out-of-tree modules
>>> without providing the entire source tree.
>>>
>>> What ends up in this development directory is a mixture of source
>>> files (mainly headers) and generated ones (headers, and tools produced
>>> by `make modules_prepare`).
>>>
>>> This patch is an attempt to generate a tarball archive containing all
>>> required files to build external modules. It could be than reused by
>>> packagers.
>>>
>>> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
>>> ---
>>>  Makefile                       |   2 +-
>>>  scripts/Makefile.package       |  13 +++
>>>  scripts/package/buildtar-devel | 207 +++++++++++++++++++++++++++++++++
>>>  3 files changed, 221 insertions(+), 1 deletion(-)
>>>  create mode 100644 scripts/package/buildtar-devel
>>
>> Is there a patch 2/2?  I don't see it anywhere.
> 
> My mistake.
> 
> Yes there is a second one but I did not want to send it becuase it is about
> generalizing buildtar to build 3 type of tarballs: the linux binaries to be
> placed in /boot, the header files for user-space, and the development headers
> and tools for out-of-tree modules (this patch).

Ah, I was wondering why this change was included:

diff --git a/Makefile b/Makefile
index cfbe6a7de640..36a58394ce16 100644
--- a/Makefile
+++ b/Makefile
@@ -1578,7 +1578,7 @@ CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
 		  arch/$(SRCARCH)/include/generated .objdiff \
-		  debian snap tar-install \
+		  debian snap tar-install* \
 		  .config .config.old .version \
 		  Module.symvers \
 		  certs/signing_key.pem \

so I think that you just explained it.

> The second one makes sense, only if this one makes sense. That's why I wrote few
> lines in the RFC cover letter. I should have used the format-patch option to not
> enumerate patches :)
> 
>> thanks.
>> -- 
>> ~Randy
> 

-- 
~Randy
