Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7D70D138
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjEWC2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEWC2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:28:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682BE9;
        Mon, 22 May 2023 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=S3haG+nzDseaoT60qOdpqQoWlYhd6ZwWcmpaVQIMgC8=; b=bMuDm7L5/DxR5q7Li34YZZ4fi/
        Bu2v3NVL2fEqKYUq0wqGlAs1n+zSf45nZDNme0d20/pNmWvqDSdSP/h/9VTcdIqjbtHV2sO8xGUW4
        y0B6EqvVKOcW+AgO8TtB3ISsi3J//pFiEIPe02Exrm4DwKV+/g28RIALL2Ku9cqvWWNWnNtEBf379
        DGMA7tnkcE4j5tv4qtJeH5CrYpgNHvGan1mFgpKj84QaVyf64mqe8DQHXnP+phaP8RzxS1SxeMEbt
        MXLrid9WQp0QZVo37I7Uow188Vj/q9AaHRFbu1Kthsb2l6ipLqdIKtDVD8zVH/NHRio95ZtJFAkHS
        fy2ncl7w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1HlW-008gdF-1O;
        Tue, 23 May 2023 02:28:46 +0000
Message-ID: <9f32e509-95b1-6a5a-aba2-664af4af37a8@infradead.org>
Date:   Mon, 22 May 2023 19:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Content-Language: en-US
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>
References: <20230515141235.0777c631@canb.auug.org.au>
 <54244db6-ff69-4cf8-894c-c3dd2f12df9c@infradead.org>
 <5d894e71-25ad-8ba0-f632-2eec6e017f46@ghiti.fr>
 <ee3bc2ce-5ebe-927e-5b6d-0b9490ef3875@ghiti.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ee3bc2ce-5ebe-927e-5b6d-0b9490ef3875@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/19/23 03:42, Alexandre Ghiti wrote:
>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section .text LMA [00000000000f09d4,00000000033562ab]
>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps section .data LMA [000000000041a000,00000000075bffd7]
>>
>>
>> I'll check this one too which seems to be related to kernel/pi introduction.
> 
> 
> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have limited size, hence the overlap, so no fix for this one. Is there a way to exclude this config from randconfig?

Does this mean exclude XIP_KERNEL or something else from randconfigs?

thanks.
-- 
~Randy
