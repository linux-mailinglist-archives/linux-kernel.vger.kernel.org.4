Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2227E5B917F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIOAGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIOAFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:05:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E532B86
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663200322; x=1694736322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U30LvbnHMWh3XBZ640uDpeAihP7sWwvMvwXRi4jrP/E=;
  b=ELB9fXD+GbhHW46THqMKU9XSuonerFpH+ucIEW4ltbvO7eGVm8Pxnwxc
   o/Y5vWHOmalelffc0Wos5WFRE+ugk4+LVei1Sccc9i6cc/WblPlJ5sAGu
   ug/2/tzAD6Nmw1mGsqfVj5JMCCGc3pPWtOekC9kkgsHwG/aUMEGt3/bDN
   Dm4mg0QED3/0GDuyQxVV3vTFKLWewRvxpNC91Ix58H63rhTZpwFMcXBto
   v/zqEBrWEgzt66GZHx7UNLXcApPwKJgUuA8T6IfbKH0kRICdsU3h9LM9y
   JQcKor5PqLS8GNeG2NwtP9GUv4JhDjMrFUXW3QPk3g1DsYkDZt2A0KLCH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="298568888"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="298568888"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 17:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="650268268"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2022 17:05:19 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYcNa-0000hf-1N;
        Thu, 15 Sep 2022 00:05:18 +0000
Date:   Thu, 15 Sep 2022 08:05:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 3/3] vmw_balloon: open-code vmballoon_compaction_init()
Message-ID: <202209150729.vb9gopf2-lkp@intel.com>
References: <20220913094306.317734-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913094306.317734-4-namit@vmware.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

I love your patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on linus/master v6.0-rc5 next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nadav-Amit/vmw_balloon-misc-fixes-and-enhancements/20220914-021333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git ceecbbddbf549fe0b7ffa3804a6e255b3360030f
config: i386-randconfig-a012-20220912 (https://download.01.org/0day-ci/archive/20220915/202209150729.vb9gopf2-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/aa1f38765dd703cbeb3450454d0b5b2c7f5a8f8d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nadav-Amit/vmw_balloon-misc-fixes-and-enhancements/20220914-021333
        git checkout aa1f38765dd703cbeb3450454d0b5b2c7f5a8f8d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/vmw_balloon.c:1732:2: error: unterminated conditional directive
   #ifdef CONFIG_BALLOON_COMPACTION
    ^
   1 error generated.


vim +1732 drivers/misc/vmw_balloon.c

453dc65931915ab drivers/misc/vmware_balloon.c Dmitry Torokhov 2010-04-23  1730  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1731  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25 @1732  #ifdef CONFIG_BALLOON_COMPACTION
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1733  /**
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1734   * vmballoon_migratepage() - migrates a balloon page.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1735   * @b_dev_info: balloon device information descriptor.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1736   * @newpage: the page to which @page should be migrated.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1737   * @page: a ballooned page that should be migrated.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1738   * @mode: migration mode, ignored.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1739   *
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1740   * This function is really open-coded, but that is according to the interface
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1741   * that balloon_compaction provides.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1742   *
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1743   * Return: zero on success, -EAGAIN when migration cannot be performed
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1744   *	   momentarily, and -EBUSY if migration failed and should be retried
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1745   *	   with that specific page.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1746   */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1747  static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1748  				 struct page *newpage, struct page *page,
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1749  				 enum migrate_mode mode)
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1750  {
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1751  	unsigned long status, flags;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1752  	struct vmballoon *b;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1753  	int ret;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1754  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1755  	b = container_of(b_dev_info, struct vmballoon, b_dev_info);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1756  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1757  	/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1758  	 * If the semaphore is taken, there is ongoing configuration change
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1759  	 * (i.e., balloon reset), so try again.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1760  	 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1761  	if (!down_read_trylock(&b->conf_sem))
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1762  		return -EAGAIN;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1763  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1764  	spin_lock(&b->comm_lock);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1765  	/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1766  	 * We must start by deflating and not inflating, as otherwise the
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1767  	 * hypervisor may tell us that it has enough memory and the new page is
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1768  	 * not needed. Since the old page is isolated, we cannot use the list
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1769  	 * interface to unlock it, as the LRU field is used for isolation.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1770  	 * Instead, we use the native interface directly.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1771  	 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1772  	vmballoon_add_page(b, 0, page);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1773  	status = vmballoon_lock_op(b, 1, VMW_BALLOON_4K_PAGE,
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1774  				   VMW_BALLOON_DEFLATE);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1775  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1776  	if (status == VMW_BALLOON_SUCCESS)
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1777  		status = vmballoon_status_page(b, 0, &page);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1778  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1779  	/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1780  	 * If a failure happened, let the migration mechanism know that it
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1781  	 * should not retry.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1782  	 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1783  	if (status != VMW_BALLOON_SUCCESS) {
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1784  		spin_unlock(&b->comm_lock);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1785  		ret = -EBUSY;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1786  		goto out_unlock;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1787  	}
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1788  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1789  	/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1790  	 * The page is isolated, so it is safe to delete it without holding
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1791  	 * @pages_lock . We keep holding @comm_lock since we will need it in a
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1792  	 * second.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1793  	 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1794  	balloon_page_delete(page);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1795  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1796  	put_page(page);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1797  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1798  	/* Inflate */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1799  	vmballoon_add_page(b, 0, newpage);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1800  	status = vmballoon_lock_op(b, 1, VMW_BALLOON_4K_PAGE,
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1801  				   VMW_BALLOON_INFLATE);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1802  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1803  	if (status == VMW_BALLOON_SUCCESS)
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1804  		status = vmballoon_status_page(b, 0, &newpage);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1805  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1806  	spin_unlock(&b->comm_lock);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1807  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1808  	if (status != VMW_BALLOON_SUCCESS) {
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1809  		/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1810  		 * A failure happened. While we can deflate the page we just
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1811  		 * inflated, this deflation can also encounter an error. Instead
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1812  		 * we will decrease the size of the balloon to reflect the
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1813  		 * change and report failure.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1814  		 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1815  		atomic64_dec(&b->size);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1816  		ret = -EBUSY;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1817  	} else {
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1818  		/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1819  		 * Success. Take a reference for the page, and we will add it to
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1820  		 * the list after acquiring the lock.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1821  		 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1822  		get_page(newpage);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1823  		ret = MIGRATEPAGE_SUCCESS;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1824  	}
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1825  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1826  	/* Update the balloon list under the @pages_lock */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1827  	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1828  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1829  	/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1830  	 * On inflation success, we already took a reference for the @newpage.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1831  	 * If we succeed just insert it to the list and update the statistics
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1832  	 * under the lock.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1833  	 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1834  	if (ret == MIGRATEPAGE_SUCCESS) {
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1835  		balloon_page_insert(&b->b_dev_info, newpage);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1836  		__count_vm_event(BALLOON_MIGRATE);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1837  	}
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1838  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1839  	/*
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1840  	 * We deflated successfully, so regardless to the inflation success, we
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1841  	 * need to reduce the number of isolated_pages.
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1842  	 */
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1843  	b->b_dev_info.isolated_pages--;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1844  	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1845  
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1846  out_unlock:
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1847  	up_read(&b->conf_sem);
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1848  	return ret;
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1849  }
83a8afa72e9c0a2 drivers/misc/vmw_balloon.c    Nadav Amit      2019-04-25  1850  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
