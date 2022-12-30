Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA816597FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiL3MHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiL3MHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:07:16 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD70D2D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:07:15 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 863E92139;
        Fri, 30 Dec 2022 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672401821;
        bh=5FN+7mfpnB/2TIwOgNn2tZ0icLdMQdRE+Ak22nDc6To=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=q+HHtyGd6BVpAczELuQiXx4SyyWJ39HsOoNtr3NgVpldvAvnJrv7tVIelSicmuUtz
         YDZO69urit90BA4qA4nJ/yd4AUK2ch2a1jyp3S+GqTAT99ew/KFydo47iNFuf4ys1i
         rWo9PMiJXM0Ibcxlt2MC57PUmyStskMYPF1mF+xE=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1FE6D2137;
        Fri, 30 Dec 2022 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672402034;
        bh=5FN+7mfpnB/2TIwOgNn2tZ0icLdMQdRE+Ak22nDc6To=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eSL0d30fVdKbLDZJhssXtr51sw+REIR6hFDQ5t/BDwygEEhrPk78/a4iQAB5g2pIc
         qnxSsZ+jXSCkxcCMWogx7G3gHOW72sjnKfTkM3/oRPoS+5yjrJRAsK+e7Cxgbd19Pt
         zQW/HtMWBkweIP+XM7qgfW/5vRtwkSPtjaazV3G8=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 15:07:13 +0300
Message-ID: <1c45a3aa-275a-2815-79bf-ef72df30db97@paragon-software.com>
Date:   Fri, 30 Dec 2022 16:07:12 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] fs/ntfs3: Fixes for big endian systems
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_K=c3=bchnel?= <thomas.kuehnel@avm.de>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20211207102454.576906-1-thomas.kuehnel@avm.de>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20211207102454.576906-1-thomas.kuehnel@avm.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.2021 14:24, Thomas Kühnel wrote:
> I tried running the NTFS3 driver on a MIPS big endian system and
> noticed various errors when it tried to access bitmaps structures
> that are stored as little endian on disk.
>
> These patches were mainly tested in a qemu mips environment.
>
> I'm open for suggestions how to better implement the second patch
> "add functions to modify LE bitmaps". It adds copies of two functions
> from lib/bitmap.c but modified to work with little endian bitmaps.
> Other filesystems seem to have similar functions defined locally like
> le_bitmap_set in btrfs or ext4_set_bits in ext4 but no global
> implementation exists.
>
> Thomas Kühnel (3):
>    fs/ntfs3: fix endian conversion in ni_fname_name
>    fs/ntfs3: add functions to modify LE bitmaps
>    fs/ntfs3: use _le variants of bitops functions
>
>   fs/ntfs3/bitmap.c  | 56 +++++++++++++++++++++++++++++++++++++++-------
>   fs/ntfs3/frecord.c |  4 +++-
>   fs/ntfs3/fslog.c   |  4 ++--
>   fs/ntfs3/fsntfs.c  |  8 +++----
>   fs/ntfs3/index.c   | 14 ++++++------
>   fs/ntfs3/ntfs_fs.h |  3 +++
>   6 files changed, 67 insertions(+), 22 deletions(-)
>
>
> base-commit: 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1

Hello Thomas,

Thanks for patches, they have been applied long ago.

Sorry for not responding immediately.

