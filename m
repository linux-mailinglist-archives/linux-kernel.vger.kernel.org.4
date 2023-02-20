Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC94469C5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjBTH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjBTH1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:27:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AD4E3A2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:26:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f9-20020a17090a9b0900b00236679bc70cso1010865pjp.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8cjV9tBotVQoVLeoP2FgDZXVqOq0e7x0vn0sOuSOa0=;
        b=Xnb7NRKMt8MYXu9k7qM8ig0x/Cb/XyWlbHHJdwLidqfjzJHpaNGxrAr5wHoQF8a7fI
         E3EwTbgj0y+qLJ2Mf99kt9jEzE2BbRlFY9SPmsuldOUBKGwiLP6v1POabszUUKemEZ1E
         OCHCYD8QbDlkVHmApwfLHcY1uPngcktSUNuDbZ6k6RgKFEj2H7I+T/3ET+AZu5iVuIZg
         hxBwWbOc6j5bgH0Ec9CqCCr2bn1ljA1Z5dYqlf/z2O029yXh8mFMOiarwXoOnmrYXdDV
         j7UvrBhlhNwmOICmjwRIfQf5SHFRJvx4vCwUCrn54rS18noAo4iZYvk4neo3wG9DjTBQ
         sevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8cjV9tBotVQoVLeoP2FgDZXVqOq0e7x0vn0sOuSOa0=;
        b=R8agGYQ0BqdUHJNnImYfpS8hSD5zDSYalRUeglCAOKHguLfoezFzE36vJWDHcfEwPQ
         Z5QEK1hKRrlbBQaVmd4CWFnx/YdzH9BuDRiKwyiSIrG++3l9Fo5+j7+dN5+n0s7p+GQW
         2T/ZjoSQms/HFogzkk7NKZSYRXwrgwSFCgRgIeZLTidWId5E+UsyA7WthiZuvF2sbfl+
         jD3H0IBNxYOfd5ld7IvxV9z2x7KabJ0hwT/zO7oAESI6i1qv/0tHUZSfS2lEB4+BTblU
         Lw5YbhuuMtY6cgpSA8dlmKqAXkQyVbJm45dka2uAM27tWnjIxbjFvLSCqKNwCMROxvSF
         /JnQ==
X-Gm-Message-State: AO0yUKUuD/xVEFMQI4Gf2jnBESzsXEfeizTzigaD2HKuiOnoQL1wPO61
        q23ZBMluQrY52Oj9dVEUIfIIrlY59RFpqs6C
X-Google-Smtp-Source: AK7set/DeED0wXvq2tFZ0anEIxa+MnnkNcRSpD6q5g0JxwlcapDjJFYNK/TDmG4CNonjJ3ERU3VU5g==
X-Received: by 2002:a17:90a:20b:b0:22c:64c6:b7c4 with SMTP id c11-20020a17090a020b00b0022c64c6b7c4mr445184pjc.2.1676878006950;
        Sun, 19 Feb 2023 23:26:46 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a3b0e00b002369d3b282csm747286pjc.40.2023.02.19.23.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 23:26:46 -0800 (PST)
Message-ID: <896c1146-21bb-35bb-dc25-a12014eb5ccd@bytedance.com>
Date:   Mon, 20 Feb 2023 15:26:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: linux-next: build warning after merge of the driver-core tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230220163133.481e43d8@canb.auug.org.au>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230220163133.481e43d8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/20 13:31, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build
> (htmldocs) produced this warning:
> 
> Documentation/filesystems/api-summary:146: fs/debugfs/inode.c:804: WARNING: Inline literal start-string without end-string.
> 
> Introduced by commit
> 
>    d3002468cb5d ("debugfs: update comment of debugfs_rename()")

This is just a comment modification. Didn't see where my modification
caused this WARNING. :(

> 

-- 
Thanks,
Qi
