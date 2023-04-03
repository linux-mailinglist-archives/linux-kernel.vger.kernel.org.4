Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334566D42F6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDCLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjDCLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:07:46 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9730E4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:07:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VfHm6-7_1680520058;
Received: from 30.212.186.250(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VfHm6-7_1680520058)
          by smtp.aliyun-inc.com;
          Mon, 03 Apr 2023 19:07:40 +0800
Message-ID: <4154b815-3be4-53de-1bc0-ca87ecb925a4@linux.alibaba.com>
Date:   Mon, 3 Apr 2023 19:07:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error
 code 'status'
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        Heming Zhao via Ocfs2-devel <ocfs2-devel@oss.oracle.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <9e1d6835-34fc-49cd-869e-d99d9b546d17@kili.mountain>
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <9e1d6835-34fc-49cd-869e-d99d9b546d17@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
IIRC, we've discussed this before.
Success return is expected in case of 'hard readonly'.
So this a false positive report.

Thanks,
Joseph

On 4/3/23 2:14 PM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7b50567bdcad8925ca1e075feb7171c12015afd1
> commit: 0737e01de9c411e4db87dcedf4a9789d41b1c5c1 ocfs2: ocfs2_mount_volume does cleanup job before return error
> config: arm64-randconfig-m041-20230329 (https://download.01.org/0day-ci/archive/20230401/202304012244.gX4H4rBO-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202304012244.gX4H4rBO-lkp@intel.com/
> 
> smatch warnings:
> fs/ocfs2/super.c:1809 ocfs2_mount_volume() warn: missing error code 'status'
> 
> vim +/status +1809 fs/ocfs2/super.c
> 
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1803  static int ocfs2_mount_volume(struct super_block *sb)
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1804  {
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1805  	int status = 0;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1806  	struct ocfs2_super *osb = OCFS2_SB(sb);
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1807  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1808  	if (ocfs2_is_hard_readonly(osb))
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29 @1809  		goto out;
> 
> Hard to tell if this should be an error path or not...  Canonical
> problem with do nothing gotos.
> 
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1810  
> 5500ab4ed3b8f0 Gang He                     2019-03-05  1811  	mutex_init(&osb->obs_trim_fs_mutex);
> 5500ab4ed3b8f0 Gang He                     2019-03-05  1812  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1813  	status = ocfs2_dlm_init(osb);
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1814  	if (status < 0) {
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1815  		mlog_errno(status);
> a52370b3b182f7 Gang He                     2018-01-31  1816  		if (status == -EBADR && ocfs2_userspace_stack(osb))
> a52370b3b182f7 Gang He                     2018-01-31  1817  			mlog(ML_ERROR, "couldn't mount because cluster name on"
> a52370b3b182f7 Gang He                     2018-01-31  1818  			" disk does not match the running cluster name.\n");
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1819  		goto out;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1820  	}
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1821  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1822  	status = ocfs2_super_lock(osb, 1);
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1823  	if (status < 0) {
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1824  		mlog_errno(status);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1825  		goto out_dlm;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1826  	}
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1827  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1828  	/* This will load up the node map and add ourselves to it. */
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1829  	status = ocfs2_find_slot(osb);
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1830  	if (status < 0) {
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1831  		mlog_errno(status);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1832  		goto out_super_lock;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1833  	}
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1834  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1835  	/* load all node-local system inodes */
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1836  	status = ocfs2_init_local_system_inodes(osb);
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1837  	if (status < 0) {
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1838  		mlog_errno(status);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1839  		goto out_super_lock;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1840  	}
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1841  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1842  	status = ocfs2_check_volume(osb);
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1843  	if (status < 0) {
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1844  		mlog_errno(status);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1845  		goto out_system_inodes;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1846  	}
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1847  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1848  	status = ocfs2_truncate_log_init(osb);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1849  	if (status < 0) {
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1850  		mlog_errno(status);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1851  		goto out_system_inodes;
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1852  	}
> c271c5c22b0a7c Sunil Mushran               2006-12-05  1853  
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1854  	ocfs2_super_unlock(osb, 1);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1855  	return 0;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1856  
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1857  out_system_inodes:
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1858  	if (osb->local_alloc_state == OCFS2_LA_ENABLED)
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1859  		ocfs2_shutdown_local_alloc(osb);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1860  	ocfs2_release_system_inodes(osb);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1861  	/* before journal shutdown, we should release slot_info */
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1862  	ocfs2_free_slot_info(osb);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1863  	ocfs2_journal_shutdown(osb);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1864  out_super_lock:
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1865  	ocfs2_super_unlock(osb, 1);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1866  out_dlm:
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1867  	ocfs2_dlm_shutdown(osb, 0);
> 0737e01de9c411 Heming Zhao via Ocfs2-devel 2022-04-29  1868  out:
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1869  	return status;
> ccd979bdbce9fb Mark Fasheh                 2005-12-15  1870  }
> 
