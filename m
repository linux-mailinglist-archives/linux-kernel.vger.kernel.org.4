Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53AF6E393F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjDPOau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDPOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBDC30F4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17E8F61374
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BAFC433EF;
        Sun, 16 Apr 2023 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655446;
        bh=HymfSVdUjO2cDi75EFsyrdzN33/1+ovPPz+N4tqm7n4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EgLgn8xv9+CkGPCavif6UpsE9EEgz+tDbvRXOQ41u2SSX7aLCvaDNWVmWvEugfR3x
         +4Grz6xqShSMyKFq4qId+KtQBI6OXWP869LicNIEadS/mEkAvF7uRYOWHHYHP4WCnw
         eS+ywvXr0TFRWbxE5ZGGxghDQKY9h4Hfi7P/HUsirYqMdHnozzfUOYa3POK06ov59m
         qlcl+jibjDdqRCHbd9Ax5uZYE3iAcLau6GFIkR98pW0bv69ZcKLfghvjNU72SsxSgx
         yhHP56Zi5gxX1JGGg3i9APYBoF2EVvUh99zqUmqS27/c/EW9lCqlU0+zH+MXl9fSHq
         fPlWTU0uqCHeg==
Message-ID: <78f01742-a672-7471-ccb3-e38d5047dab9@kernel.org>
Date:   Sun, 16 Apr 2023 22:30:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3] erofs: support flattened block device for multi-blob
 images
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, xiang@kernel.org,
        gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        jefflexu@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        Xin Yin <yinxin.x@bytedance.com>
References: <8be37b4c-5a87-1c10-b0e6-99284e6fd4ca@linux.alibaba.com>
 <20230302071751.48425-1-zhujia.zj@bytedance.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230302071751.48425-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/2 15:17, Jia Zhu wrote:
> In order to support mounting multi-blobs container image as a single
> block device, add flattened block device feature for EROFS.
> 
> In this mode, all meta/data contents will be mapped into one block
> address. User could compose a block device(by nbd/ublk/virtio-blk/
> vhost-user-blk) from multiple sources and mount the block device by
> EROFS directly. It can reduce the number of block devices used, and
> it's also benefits in both VM file passthrough and distributed storage
> scenarios.
> 
> You can test this using the method mentioned by:
> https://github.com/dragonflyoss/image-service/pull/1111
> 1. Compose a (nbd)block device from multi-blobs.
> 2. Mount EROFS on mntdir/.
> 3. Compare the md5sum between source dir and mntdir/.
> 
> Later, we could also use it to refer original tar blobs.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
