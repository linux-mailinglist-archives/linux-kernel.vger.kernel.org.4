Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19173618D17
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKDACE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiKDACB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C422290
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667520058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewaqDcbeUBXPxOKH8IZ4/ESLkH5oRwbGk48wj8JMb1g=;
        b=HW+35JB+C/H/5UAmtwCZGwQMfByS22RhnIh8Oyx1ZTTmgH+8cSMJlgJR7lHo6C13qhqMMa
        WfZlzlHCrGuYSYluVzRKxFgyQF8de3KXCYdParof/fjxiBY4eseT/NmTDaVQeJVaJ4Wqlg
        RRPsvsbB36KflWuIzaUv57UClHPlpKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-G2yohXCOPcKgJwrD5AYe1A-1; Thu, 03 Nov 2022 20:00:55 -0400
X-MC-Unique: G2yohXCOPcKgJwrD5AYe1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5417A811E67;
        Fri,  4 Nov 2022 00:00:54 +0000 (UTC)
Received: from [10.22.33.38] (unknown [10.22.33.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A230940C6EE9;
        Fri,  4 Nov 2022 00:00:53 +0000 (UTC)
Message-ID: <c1dce443-3f15-1677-a563-5e26469f93c0@redhat.com>
Date:   Thu, 3 Nov 2022 20:00:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 3/6] locking/rwsem: Disable preemption at all
 down_write*() and up_write() code paths
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        john.p.donnelly@oracle.com, Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221103182936.217120-4-longman@redhat.com>
 <202211040317.y9sxkmoi-lkp@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202211040317.y9sxkmoi-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/22 16:04, kernel test robot wrote:
> Hi Waiman,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on tip/locking/core]
> [also build test WARNING on tip/master linus/master v6.1-rc3 next-20221103]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/lockinig-rwsem-Fix-rwsem-bugs-enable-true-lock-handoff/20221104-023520
> patch link:    https://lore.kernel.org/r/20221103182936.217120-4-longman%40redhat.com
> patch subject: [PATCH v5 3/6] locking/rwsem: Disable preemption at all down_write*() and up_write() code paths
> config: m68k-allyesconfig
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/b83e7cdb918b02166fbe3954940a7bd6f04eef14
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Waiman-Long/lockinig-rwsem-Fix-rwsem-bugs-enable-true-lock-handoff/20221104-023520
>          git checkout b83e7cdb918b02166fbe3954940a7bd6f04eef14
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/locking/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     kernel/locking/rwsem.c: In function '__down_write_common':
>>> kernel/locking/rwsem.c:1302:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>      1302 |         int ret = 0;
>           |             ^~~

Oh well, I will fix that.

Cheers,
Longman

>
> vim +/ret +1302 kernel/locking/rwsem.c
>
>    1296	
>    1297	/*
>    1298	 * lock for writing
>    1299	 */
>    1300	static inline int __down_write_common(struct rw_semaphore *sem, int state)
>    1301	{
>> 1302		int ret = 0;
>    1303	
>    1304		preempt_disable();
>    1305		if (unlikely(!rwsem_write_trylock(sem))) {
>    1306			if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
>    1307				ret = -EINTR;
>    1308		}
>    1309		preempt_enable();
>    1310	
>    1311		return 0;
>    1312	}
>    1313	
>

