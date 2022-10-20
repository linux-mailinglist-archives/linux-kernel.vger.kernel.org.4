Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F113605958
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJTIKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJTIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C820985
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9422961A01
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458F4C433D7;
        Thu, 20 Oct 2022 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666253403;
        bh=TZH3HlrUcw85qXpZBg1C/yHHkc3IDLD5ROD1X0bKVM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RUrUJY+ZQID6beKKY8k/RIFOChFc6D1S84jdodkaPggjPAtO3AfUyUWiYQIuE3MEP
         zaL6Gtg63O0Fe0KWa/SsjRS3BcUlJ5ASCyxCaXQzK4SPlIkG7czgBPbpCJ6bRGDFbu
         jBQeGqIH5kTj8k8x8lZnbvBFdiCfrXzhkCM6xjdMbHWJ9OrrKuVD1sWKApkksSKoy1
         Ov0WKaEGoOssY3kM2nJdPhZ8S9frYiSwASv9nTPhshse4s2gITPwGhvf2yppCScqrM
         BAm2v3bjBh2Xb+pTHmKQKrFelaDDB8iJePbq3q37+KX2DngBF7IDCeqhV2KvfyBSOG
         fuT8Z8hw2l0Kg==
Message-ID: <0b2d44b0-7a72-2788-b8cc-b5c1ecfbcbae@kernel.org>
Date:   Thu, 20 Oct 2022 16:09:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] erofs: protect s_inodes with s_inode_list_lock
Content-Language: en-US
To:     Dawei Li <set_pte_at@outlook.com>, xiang@kernel.org
Cc:     zhujia.zj@bytedance.com, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <TYCP286MB23238380DE3B74874E8D78ABCA299@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 9:55, Dawei Li wrote:
> s_inodes is superblock-specific resource, which should be
> protected by sb's specific lock s_inode_list_lock.
> 
> v2: update the locking mechanisim to protect mutual-exclusive access
> both for s_inode_list_lock & erofs_fscache_domain_init_cookie(), as the
> reviewing comments from Jia Zhu.
> 
> v1: https://lore.kernel.org/all/TYCP286MB23237A9993E0FFCFE5C2BDBECA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> 
> base-commit: 8436c4a57bd147b0bd2943ab499bb8368981b9e1
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
