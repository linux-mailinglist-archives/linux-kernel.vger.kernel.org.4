Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D37728CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbjFIBMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjFIBMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:12:52 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33054E47;
        Thu,  8 Jun 2023 18:12:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qcjk64lh4z4f3kpy;
        Fri,  9 Jun 2023 09:12:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77KJfIJkbOAQLQ--.60116S3;
        Fri, 09 Jun 2023 09:12:43 +0800 (CST)
Subject: Re: [PATCH v3 1/2] scsi: sg: fix blktrace debugfs entries leakage
To:     kernel test robot <lkp@intel.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230608024159.1282953-2-yukuai1@huaweicloud.com>
 <202306082353.o2lpbQcL-lkp@intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f952e9b0-7695-0366-a713-3d2444b74a90@huaweicloud.com>
Date:   Fri, 9 Jun 2023 09:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <202306082353.o2lpbQcL-lkp@intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77KJfIJkbOAQLQ--.60116S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW3trykWw48GFyrXr45trb_yoWrGF43pa
        1DXw4Ykr1UXr4I9a1I9r17u3Z8t398J345Xw1DKwn8uF9Fyasruwn29FZ8X3yqvw1vgasx
        tr93uFyq9w1DX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/06/09 0:02, kernel test robot Ð´µÀ:
> Hi Yu,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on axboe-block/for-next]
> [also build test WARNING on linus/master v6.4-rc5 next-20230608]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/scsi-sg-fix-blktrace-debugfs-entries-leakage/20230608-104735
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> patch link:    https://lore.kernel.org/r/20230608024159.1282953-2-yukuai1%40huaweicloud.com
> patch subject: [PATCH v3 1/2] scsi: sg: fix blktrace debugfs entries leakage
> config: i386-randconfig-r002-20230608 (https://download.01.org/0day-ci/archive/20230608/202306082353.o2lpbQcL-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build):
>          git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>          git fetch axboe-block for-next
>          git checkout axboe-block/for-next
>          b4 shazam https://lore.kernel.org/r/20230608024159.1282953-2-yukuai1@huaweicloud.com
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=i386 olddefconfig
>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306082353.o2lpbQcL-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from drivers/scsi/sg.c:45:
>     drivers/scsi/sg.c: In function 'sg_device_destroy':
>>> include/linux/blktrace_api.h:88:57: warning: statement with no effect [-Wunused-value]
>        88 | # define blk_trace_remove(q)                            (-ENOTTY)
>           |        

So, this warning happens in all the caller of blk_trace_remove() when
CONFIG_BLK_DEV_IO_TRACE is disabled that doesn't handle the return
value. I'll use blk_trace_shutdown() instead to avoid this warning.
                                                  ^
Thanks,
Kuai
>     drivers/scsi/sg.c:1575:9: note: in expansion of macro 'blk_trace_remove'
>      1575 |         blk_trace_remove(sdp->device->request_queue);
>           |         ^~~~~~~~~~~~~~~~
> 
> 
> vim +88 include/linux/blktrace_api.h
> 
> 157f9c00e88529 Arnaldo Carvalho de Melo 2009-01-26  81
> 2056a782f8e7e6 Jens Axboe               2006-03-23  82  #else /* !CONFIG_BLK_DEV_IO_TRACE */
> 2056a782f8e7e6 Jens Axboe               2006-03-23  83  # define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)
> 2056a782f8e7e6 Jens Axboe               2006-03-23  84  # define blk_trace_shutdown(q)				do { } while (0)
> a54895fa057c67 Christoph Hellwig        2020-12-03  85  # define blk_add_driver_data(rq, data, len)		do {} while (0)
> d0deef5b14af7d Shawn Du                 2009-04-14  86  # define blk_trace_setup(q, name, dev, bdev, arg)	(-ENOTTY)
> 6da127ad0918f9 Christof Schmitt         2008-01-11  87  # define blk_trace_startstop(q, start)			(-ENOTTY)
> 6da127ad0918f9 Christof Schmitt         2008-01-11 @88  # define blk_trace_remove(q)				(-ENOTTY)
> 9d5f09a424a67d Alan D. Brunelle         2008-05-27  89  # define blk_add_trace_msg(q, fmt, ...)			do { } while (0)
> 35fe6d763229e8 Shaohua Li               2017-07-12  90  # define blk_add_cgroup_trace_msg(q, cg, fmt, ...)	do { } while (0)
> 59fa0224cfea31 Shaohua Li               2016-05-09  91  # define blk_trace_note_message_enabled(q)		(false)
> 2056a782f8e7e6 Jens Axboe               2006-03-23  92  #endif /* CONFIG_BLK_DEV_IO_TRACE */
> d0deef5b14af7d Shawn Du                 2009-04-14  93
> 

