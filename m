Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB4F6E9C93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjDTTlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTTlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:41:20 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F63C40CD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:41:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74de9ce136cso55101985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682019678; x=1684611678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hp2WoMYe8f0cA1azbQnh2XYZtbHDV4zsKL0sy4t3HRk=;
        b=cokRKqTe/KXOWR8TgrgKE35GN/QC9l9kuQHbG/6uekngK4te5Ju9kOuReHGCH2JCB7
         ctFyVY/HKqw53zXlDHfduMSnZZPS6ZVJ+FPUmcB/J9IOV83qIRPuCM4gYbngj1kdW5vK
         Runi1pNLAMlkYVXyEeG7lHjgtt7WRvWtTVT6ZBBo05cA+Gnu2hFswC1rfKfnIvLLK/c6
         HhkBTuMrKll6CjPW0vrjT4qOY/1xXEtAIMlLBeuZsJ/agTTbdx1B4sIy5PDCwMctLQS+
         M7WitvFtu6bdQl8U+8ucEGoUD4Js5gRj77jSi7N1+q3jIsg/GVycnTQIx6z8QI/eFmW0
         95nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019678; x=1684611678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp2WoMYe8f0cA1azbQnh2XYZtbHDV4zsKL0sy4t3HRk=;
        b=OjDiSC/fg5/H2GIErxKxt42SkS9Js2YRGbu3Hx7bANSRDYJgx0CiYhdkBfUzFYHPjX
         rFEVTi0aulyhFXLTXU8YHtD5GAFJeHQ9pIRuAEXgf26XxyC+o2ujr6UkpIEoiu++FEbz
         YbQHEpijMGqgobagjbFYG2AefxH2o6o1B5rMoSvRgLF4y+0A/Amh8xIjm4ACvVwGLiQt
         Z/whkYgTWTjY9Vg3cwBexikNl8CnOLHetNW9M7qYWLQrAMvWhqqWBSXc/f9HSDw3VKyg
         Fe9ImdQLQdS3PdLkKce3WTo2+SVynq9cjlWfFZn1+oDT5uczguaKnYGFVYPLcCBG7I/D
         1zpA==
X-Gm-Message-State: AAQBX9eqlABpfXb3FesFU1gIf0lxTnX5XvSURaqkhslNr+ehjlDox+Bf
        bfaMSjZJS+khDthoOx6GYHMiQw==
X-Google-Smtp-Source: AKy350YHZGfUCPsTXzxR0dSmjqT1qchvqDRAVjb1f3XBS1FGLghWbLDnz+KIU+WWC8QMjSXcknjIpQ==
X-Received: by 2002:a05:6214:e4e:b0:5ef:4ecb:cf9d with SMTP id o14-20020a0562140e4e00b005ef4ecbcf9dmr4390667qvc.6.1682019678370;
        Thu, 20 Apr 2023 12:41:18 -0700 (PDT)
Received: from localhost (hs-nc-a03feba254-450087-1.tingfiber.com. [64.98.124.17])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cedca000000b005dd8b9345b4sm597931qvr.76.2023.04.20.12.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:41:17 -0700 (PDT)
Date:   Thu, 20 Apr 2023 15:41:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH-next] nbd: fix incomplete validation of ioctl arg
Message-ID: <20230420194117.GA2179876@localhost.localdomain>
References: <20230206145805.2645671-1-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206145805.2645671-1-zhongjinghua@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:58:05PM +0800, Zhong Jinghua wrote:
> We tested and found an alarm caused by nbd_ioctl arg without verification.
> The UBSAN warning calltrace like below:
> 
> UBSAN: Undefined behaviour in fs/buffer.c:1709:35
> signed integer overflow:
> -9223372036854775808 - 1 cannot be represented in type 'long long int'
> CPU: 3 PID: 2523 Comm: syz-executor.0 Not tainted 4.19.90 #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x3f0 arch/arm64/kernel/time.c:78
>  show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x170/0x1dc lib/dump_stack.c:118
>  ubsan_epilogue+0x18/0xb4 lib/ubsan.c:161
>  handle_overflow+0x188/0x1dc lib/ubsan.c:192
>  __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:206
>  __block_write_full_page+0x94c/0xa20 fs/buffer.c:1709
>  block_write_full_page+0x1f0/0x280 fs/buffer.c:2934
>  blkdev_writepage+0x34/0x40 fs/block_dev.c:607
>  __writepage+0x68/0xe8 mm/page-writeback.c:2305
>  write_cache_pages+0x44c/0xc70 mm/page-writeback.c:2240
>  generic_writepages+0xdc/0x148 mm/page-writeback.c:2329
>  blkdev_writepages+0x2c/0x38 fs/block_dev.c:2114
>  do_writepages+0xd4/0x250 mm/page-writeback.c:2344
> 
> The reason for triggering this warning is __block_write_full_page()
> -> i_size_read(inode) - 1 overflow.
> inode->i_size is assigned in __nbd_ioctl() -> nbd_set_size() -> bytesize.
> We think it is necessary to limit the size of arg to prevent errors.
> 
> Moreover, __nbd_ioctl() -> nbd_add_socket(), arg will be cast to int.
> Assuming the value of arg is 0x80000000000000001) (on a 64-bit machine),
> it will become 1 after the coercion, which will return unexpected results.
> 
> Fix it by adding checks to prevent passing in too large numbers.
> 
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
