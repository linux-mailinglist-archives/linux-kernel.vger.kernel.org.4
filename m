Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAD72345B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjFFBLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFFBLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77DEA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3C062C15
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95B8C433EF;
        Tue,  6 Jun 2023 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686013859;
        bh=v+iFmUmGpocC9rT9XEBrvaU5BJbLM8ZNKrlK0Qm41SY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fviE26N9lT+7CePMHS+XZ3eO7M2dTx66yJ+KzpjzNOXBvIARIFtiVkL5eNyo9YzVh
         0DMjHOnjWTYGi/VxME9seD/JDuHyYMXUFUsmqoJztmO0G4DQ+8yCy1wo78fNhFjiHa
         xTLkOOSqseaYZRn5Bq9xtsazs3gsBHXvNqBkjsl+GDVQkc85fGiw9fAhH/098oHfJI
         905Bl8Fpa5Yom8riMXSpfqDaevbuwm1MyazVOHSQEdXJ2T/o0IaoSNSKNVtJj/1aoC
         UHOs4I1WdAFIK89pzM6t5K3Q8BEPESm9ymorxTmEFsV3mOqn1eVirW4Pc2TosZLAfv
         QH/1UwsTeCk9A==
Message-ID: <3c3782b0-fb1c-bcc9-a45c-d4691ab780e9@kernel.org>
Date:   Tue, 6 Jun 2023 09:10:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <20230601013759.75500-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230601013759.75500-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/1 9:37, Wu Bo wrote:
> The NULL return of 'd_splice_alias' dosen't mean error. Thus the
> successful case will also return NULL, which makes the tracepoint always
> print 'err=-ENOENT'.
> 
> And the different cases of 'new' & 'err' are list as following:
> 1) dentry exists: err(0) with new(NULL) --> dentry, err=0
> 2) dentry exists: err(0) with new(VALID) --> new, err=0
> 3) dentry exists: err(0) with new(ERR) --> dentry, err=ERR
> 4) no dentry exists: err(-ENOENT) with new(NULL) --> dentry, err=-ENOENT
> 5) no dentry exists: err(-ENOENT) with new(VALID) --> new, err=-ENOENT
> 6) no dentry exists: err(-ENOENT) with new(ERR) --> dentry, err=ERR
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
