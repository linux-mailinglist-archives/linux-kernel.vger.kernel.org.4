Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544646BE147
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCQGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQGcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:32:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2372CB7D8C;
        Thu, 16 Mar 2023 23:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90386621C1;
        Fri, 17 Mar 2023 06:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66077C433EF;
        Fri, 17 Mar 2023 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679034735;
        bh=YNPSDKsw9r0SYT8/ewQEeYA2cICUD/9xBMbfh07ni2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0qTkDQ3kAaNrFWblWU5jd+aEggNw/beWg3cGRDcIYBb9291XP5fnq5JjxbNVVvCZ
         fXOj1RDMmeC0ntpjAgsBZt4ihVj01JXhqw5fuv3J8qMZBWZhZUz3xcRVtlD1pWWYQu
         1/cprjIo7eGn+S51zhvOT01ULQSHd1bdkNXeei9sko1X8QWAiMiCQxPBenhUY68p3q
         aWRnWUf5ZjzRXDA7ICyKLv3qHM5kO/3NYVg7pnnxpq1mq9Oa/an2x4vQS3Iotsl8KV
         zC1n7/DxI55Ej0+bNpVL0c1WkVrhM0VlUUrhSGdiOyQfSjwMalGRT85Scz0vzDcCf4
         3QXwxLT2z0Cig==
Date:   Thu, 16 Mar 2023 23:32:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        aliyunlinux2-dev@linux.alibaba.com, jane.lv@intel.com
Subject: Re: [linux-stable-rc:linux-4.19.y] [panic] 4d00e68cfc:
 WARNING:at_fs/sysfs/file.c:#sysfs_emit_at
Message-ID: <20230317063213.GC882@sol.localdomain>
References: <202303141634.1e64fd76-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303141634.1e64fd76-yujie.liu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:34:22PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed WARNING:at_fs/sysfs/file.c:#sysfs_emit_at due to commit (built with gcc-11):
> 
> commit: 4d00e68cfcfd91d3a8c794d47617429a96d623ed ("panic: Expose "warn_count" to sysfs")
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y

It turns out this is a longstanding bug in 4.19.y and 4.14.y caused by a bad
backport, which is not actually related to the above commit (or the patch series
that contained it) at all.  I've sent out fixes:

4.19: https://lore.kernel.org/r/20230317062743.313169-1-ebiggers@kernel.org
4.14: https://lore.kernel.org/r/20230317062801.313217-1-ebiggers@kernel.org

- Eric
